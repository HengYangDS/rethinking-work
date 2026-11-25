package ci

// The installed common model (ETHOS `.config/ci/verification.cue`) generates the verification
// jobs of both Forges from `verification.toml`, and `ethos lane project` writes the native files.
// This file adds what the model leaves to the repository: on each Forge, a macOS job that builds
// the PDF and the practice archive and keeps them as artifacts for `artifactDays`.
artifactDays: 14

// The hosted job takes its supply as the verification jobs and the private peer's publication job do: the locked
// tools through Mise, then `ci-supply` for fonts, Typst packages, tests and PDF tools, checked against their manifests.
// A full checkout carries the tags, so a tag event builds that tag's edition (publication/justfile, `edition_inputs`).
publicationJob: {
	"runs-on":         _inputs.ci.github.runners[0]
	"timeout-minutes": 45
	steps: [{
		uses: "actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1"
		with: {"fetch-depth": 0, ref: "${{ github.event.pull_request.head.sha || github.sha }}"}
	}, {
		uses: "jdx/mise-action@b44d12e7d0d8ee7461bb893e1b1993500433185b"
		with: {version: _inputs.ci.supply.mise_version, install: false, cache: false}
	}, {
		name: "Acquire locked product supply"
		run:  "mise install --locked --jobs=1"
	}, {
		name: "Check locked supply"
		run:  "mise run ci-supply"
	}, {
		name: "Build the PDF and the edition archive"
		run:  "mise exec --locked -- just --justfile publication/justfile ci-artifacts"
	}, for artifact in [
		{label: "PDF", path: "build/artifacts/pdf/rethinking-work.pdf"},
		{label: "Edition archive", path: "build/artifacts/edition/rethinking-work-*.tgz"},
	] {
		name: "Upload \(artifact.label) without re-archiving"
		uses: "actions/upload-artifact@cf430e030ddbb5b0abf93d22962f4752f3646cd9"
		with: {
			path:                artifact.path
			archive:             false
			"if-no-files-found": "error"
			"retention-days":    artifactDays
		}
	}]
}

compiled: providers: github: jobs: publication: publicationJob

// The private peer builds the same two artifacts on the owner's local macOS runners, after the
// supply task has given the runner account its fonts and packages. Its rules
// follow the generated verification jobs of the same trust.
gitlabPublication: {
	stage:         "verify"
	timeout:       "30 minutes"
	interruptible: true
	variables: {
		MISE_CONFIG_DIR:           "$CI_PROJECT_DIR/build/runtime/work/mise-config"
		MISE_CEILING_PATHS:        "$CI_PROJECT_DIR/.."
		MISE_TRUSTED_CONFIG_PATHS: "$CI_PROJECT_DIR/.config/mise/config.toml"
		MISE_YES:                  "1"
	}
	before_script: ["mise install --locked --jobs=1", "mise run ci-supply"]
	script: ["mise exec --locked -- just --justfile publication/justfile ci-artifacts"]
	artifacts: {
		paths: ["build/artifacts/pdf/rethinking-work.pdf", "build/artifacts/edition/rethinking-work-*.tgz"]
		expire_in: "\(artifactDays) days"
	}
}

compiled: providers: gitlab: {
	"publication:macos:review": gitlabPublication & {
		tags: _inputs.ci.gitlab.runners.macos.review_tags
		rules: [{if: "$ETHOS_OFFLINE_CANDIDATE", when: "never"}, {if: "$CI_PIPELINE_SOURCE == \"merge_request_event\" || ($CI_COMMIT_BRANCH =~ /^proposal\\// && $CI_PIPELINE_SOURCE == \"push\")"}]
	}
	"publication:macos:protected": gitlabPublication & {
		tags: _inputs.ci.gitlab.runners.macos.protected_tags
		rules: [{if: "$ETHOS_OFFLINE_CANDIDATE", when: "never"}, {if: "$CI_COMMIT_REF_PROTECTED == \"true\" && ($CI_COMMIT_BRANCH == \"dev\" || $CI_COMMIT_BRANCH == \"main\" || $CI_COMMIT_TAG =~ /^v[^\\/]*$/)"}]
	}
}
