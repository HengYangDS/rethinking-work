package ci

import "strings"

// Shared commands have one owner; peers bind only their native job context.
shared: {
	tools: ["node", "python", "just", "npm:prettier", "duckdb", "ast-grep", "github:oasdiff/oasdiff", "cue"]
	miseVersion: "2026.11.7"
	bootstrap: {
		platform: "macos-arm64" | "linux-x64"
		checkCommand: {"macos-arm64": "shasum --algorithm 256 --check", "linux-x64": "sha256sum --check"}[platform]
		commands: [
			"mkdir -p build/runtime/ci/bootstrap",
			"curl --fail --silent --show-error --location --proto '=https' --proto-redir '=https' --connect-timeout 15 --max-time 180 --output build/runtime/ci/bootstrap/mise.tar.gz https://github.com/jdx/mise/releases/download/v\(miseVersion)/mise-v\(miseVersion)-\(platform).tar.gz",
			"\(checkCommand) publication/supply/ci-mise-\(platform).sha256",
			"tar -xzf build/runtime/ci/bootstrap/mise.tar.gz -C build/runtime/ci/bootstrap --strip-components=2 mise/bin/mise",
			"build/runtime/ci/bootstrap/mise --version",
		]
	}
	verify: {
		platform: "macos:aarch64" | "linux:x86_64"
		commit: string
		commands: [
			"build/runtime/ci/bootstrap/mise install \(strings.Join(tools, " "))",
			"build/runtime/ci/bootstrap/mise exec \(strings.Join(tools, " ")) -- just --justfile publication/justfile ci-identity \(platform) \"\(commit)\"",
			"build/runtime/ci/bootstrap/mise exec \(strings.Join(tools, " ")) -- just --justfile publication/justfile ci",
			"git diff --exit-code -- .config/mise",
		]
	}
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
			env: (shared.environment & {workspace: "${{ github.workspace }}"}).variables & {
				CHECKOUT_URL: "${{ github.server_url }}/${{ github.repository }}.git"
				CHECKOUT_SHA: "${{ github.sha }}"
			}
			defaults: run: shell: "bash"
			steps: [
				{name: "Initialize checkout", run: "git init ."},
				{name: "Select the public event repository", run: "git remote add origin \"$CHECKOUT_URL\""},
				{name: "Fetch the exact event commit", run: "git -c protocol.version=2 fetch --no-tags --depth=1 origin \"$CHECKOUT_SHA\""},
				{name: "Check out the fetched commit", run: "git -c core.hooksPath=/dev/null checkout --detach FETCH_HEAD"},
				for command in (shared.bootstrap & {platform: "macos-arm64"}).commands {run: command},
				for command in (shared.verify & {platform: "macos:aarch64", commit: "$CHECKOUT_SHA"}).commands {run: command},
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
			image:         "public.ecr.aws/docker/library/node@sha256:6eca1d4ba35cef57a8a41008310420541a2a9ffdcd4883841463ccb39a588bd8"
			timeout:       "20m"
			interruptible: true
			script: [
				for command in (shared.bootstrap & {platform: "linux-x64"}).commands {command},
				for command in (shared.verify & {platform: "linux:x86_64", commit: "$CI_COMMIT_SHA"}).commands {command},
			]
		}
	}
}
