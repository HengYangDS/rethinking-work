package ci

import "strings"

// Shared commands have one owner; peers bind only their native job context.
shared: {
	tools: ["node", "python", "just", "npm:prettier", "duckdb", "ast-grep", "github:oasdiff/oasdiff", "cue"]
	miseVersion: "2026.11.7"
	bootstrap: {
		platform: "macos-arm64" | "linux-x64"
		identity: {"macos-arm64": "Darwin:arm64", "linux-x64": "Linux:x86_64"}[platform]
		checkCommand: {"macos-arm64": "shasum --algorithm 256 --check", "linux-x64": "sha256sum --check"}[platform]
		checksum: {"macos-arm64": "92f1b9f68b6031a9f77938a0ff8dfd7a77fe9cd918c5b09d0ed434f06ebbd3f2", "linux-x64": "3198a5ed5716ca8c17ecfc54521e2769d6cacbf2d13f24f0c2f9706620ec0024"}[platform]
		script: strings.Join([
			"test \"$(uname -s):$(uname -m)\" = \"\(identity)\"",
			"mkdir -p build/runtime/ci/bootstrap",
			"curl --fail --silent --show-error --location --proto '=https' --proto-redir '=https' --connect-timeout 15 --max-time 180 --output build/runtime/ci/bootstrap/mise.tar.gz https://github.com/jdx/mise/releases/download/v\(miseVersion)/mise-v\(miseVersion)-\(platform).tar.gz",
			"printf '%s  %s\\n' '\(checksum)' build/runtime/ci/bootstrap/mise.tar.gz | \(checkCommand)",
			"tar -xzf build/runtime/ci/bootstrap/mise.tar.gz -C build/runtime/ci/bootstrap --strip-components=2 mise/bin/mise",
			"build/runtime/ci/bootstrap/mise --version",
		], "\n")
	}
	verify: strings.Join([
		"build/runtime/ci/bootstrap/mise install \(strings.Join(tools, " "))",
		"build/runtime/ci/bootstrap/mise exec \(strings.Join(tools, " ")) -- just --justfile publication/justfile ci",
		"git diff --exit-code -- .config/mise",
	], "\n")
	environment: {
		workspace: string
		variables: {
			MISE_LOCKED:               "1"
			MISE_EXEC_AUTO_INSTALL:    "0"
			MISE_TRUSTED_CONFIG_PATHS: workspace
			MISE_DATA_DIR:             "\(workspace)/build/runtime/ci/mise/data"
			MISE_CACHE_DIR:            "\(workspace)/build/runtime/ci/mise/cache"
			MISE_STATE_DIR:            "\(workspace)/build/runtime/ci/mise/state"
		}
	}
}

compiled: github: {
	path: ".github/workflows/verify.yml"
	document: {
		name: "Source verification"
		on: {push: null, pull_request: null, workflow_dispatch: null}
		permissions: contents: "read"
		concurrency: {
			group:                "source-verification-${{ github.workflow }}-${{ github.ref }}"
			"cancel-in-progress": true
		}
		jobs: verify: {
			"runs-on":         "macos-15"
			"timeout-minutes": 20
			env: (shared.environment & {workspace: "${{ github.workspace }}"}).variables
			defaults: run: shell: "bash"
			steps: [
				{
					name: "Check out the exact event commit"
					env: {
						CHECKOUT_URL: "${{ github.server_url }}/${{ github.repository }}.git"
						CHECKOUT_SHA: "${{ github.sha }}"
					}
					run: strings.Join([
						"git init .",
						"git remote add origin \"$CHECKOUT_URL\"",
						"git -c protocol.version=2 fetch --no-tags --depth=1 origin \"$CHECKOUT_SHA\"",
						"git -c core.hooksPath=/dev/null checkout --detach FETCH_HEAD",
						"test \"$(git rev-parse HEAD)\" = \"$CHECKOUT_SHA\"",
					], "\n")
				},
				{name: "Prepare checksum-bound Mise", run: (shared.bootstrap & {platform: "macos-arm64"}).script},
				{name: "Check projections, formatting and all companion contracts", run: shared.verify},
			]
		}
	}
}

compiled: gitlab: {
	path: ".gitlab-ci.yml"
	document: {
		stages: ["verify"]
		workflow: rules: [
			{"if": "$CI_PIPELINE_SOURCE == \"merge_request_event\""},
			{"if": "$CI_PIPELINE_SOURCE == \"push\" && $CI_COMMIT_BRANCH && $CI_OPEN_MERGE_REQUESTS", when: "never"},
			{"if": "$CI_COMMIT_BRANCH || $CI_COMMIT_TAG"},
		]
		variables: (shared.environment & {workspace: "$CI_PROJECT_DIR"}).variables & {
			GIT_DEPTH:              "1"
			GIT_STRATEGY:           "clone"
			GIT_SUBMODULE_STRATEGY: "none"
		}
		"verify:source": {
			stage: "verify"
			// The owner-associated general Linux Runner supplies an isolated Kubernetes job.
			tags: ["platform-general"]
			image:         "node@sha256:6eca1d4ba35cef57a8a41008310420541a2a9ffdcd4883841463ccb39a588bd8"
			timeout:       "20m"
			interruptible: true
			script: [
				"test \"$(git rev-parse HEAD)\" = \"$CI_COMMIT_SHA\"",
				(shared.bootstrap & {platform: "linux-x64"}).script,
				shared.verify,
			]
		}
	}
}
