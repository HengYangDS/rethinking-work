package ci

import "list"

// The installed common model (ETHOS `.config/ci/verification.cue`) generates the verification
// jobs of both Forges from `verification.toml`, and `ethos lane project` writes the native files.
// This file adds what the model leaves to the repository: on each Forge, a macOS job that builds
// the PDF and the practice archive and keeps them as artifacts. Each takes its supply, rules, time
// limit and artifact lifetime from the verification job of the same Forge, runner and trust, so a
// change to the model or to `verification.toml` reaches it unchanged.

// The build's outputs lie alone in their folders (publication/justfile, `pdf` and `archive`); a
// tag event builds that tag's edition, since a full checkout carries the tags.
outputs: [
	{label: "PDF", path: "build/artifacts/pdf/*.pdf"},
	{label: "Edition archive", path: "build/artifacts/edition/*.tgz"},
]
build: "mise exec --locked -- just --justfile publication/justfile ci-artifacts"

let verify = compiled.providers.github.jobs.verify

// The verification job's supply is every step before the one that prepares its evidence directory.
let evidenceStep = [for i, step in verify.steps if step.name != _|_ if step.name == "Prepare owned evidence directory" {i}][0]

publicationJob: {
	"runs-on":         _inputs.ci.github.runners[0]
	"timeout-minutes": verify["timeout-minutes"]
	steps: list.Concat([list.Slice(verify.steps, 0, evidenceStep), [{
		name: "Build the PDF and the edition archive"
		run:  build
	}], [for artifact in outputs {
		name: "Upload \(artifact.label) without re-archiving"
		uses: [for step in verify.steps if step.uses != _|_ if step.uses =~ "^actions/upload-artifact@" {step.uses}][0]
		with: {
			path:                artifact.path
			archive:             false
			"if-no-files-found": "error"
			"retention-days": [for step in verify.steps if step.with != _|_ if step.with["retention-days"] != _|_ {step.with["retention-days"]}][0]
		}
	}]])
}

compiled: providers: github: jobs: publication: publicationJob

// The private peer builds the same two artifacts on the owner's local macOS runners, after the
// supply task has given the runner account its fonts and packages.
for name, runner in _inputs.ci.gitlab.runners if runner.system == "macos" {
	for trust in ["review", "protected"] {
		let verification = compiled.providers.gitlab["verify:\(name):\(trust)"]

		// Its supply is every command before the one that prepares the evidence directory.
		let evidenceCommand = [for i, command in verification.before_script if command =~ "build/evidence/ci$" {i}][0]
		compiled: providers: gitlab: "publication:\(name):\(trust)": {
			stage:         verification.stage
			tags:          verification.tags
			rules:         verification.rules
			timeout:       verification.timeout
			interruptible: verification.interruptible
			variables:     verification.variables
			before_script: list.Slice(verification.before_script, 0, evidenceCommand)
			script: [build]
			artifacts: {
				paths: [for artifact in outputs {artifact.path}]
				expire_in: verification.artifacts.expire_in
			}
		}
	}
}
