package ci

import (
	"list"
	"strings"
)

// Shared commands have one owner; peers bind only their native job context.
shared: {
	tools: ["node", "python", "just", "npm:prettier", "duckdb", "ast-grep", "github:oasdiff/oasdiff", "cue"]
	publicationTools: list.Concat([tools, ["typst", "npm:@mermaid-js/mermaid-cli"]])
	miseVersion: "2026.11.7"
	// Only the hosted peer bootstraps Mise; the private peer's runners supply it.
	bootstrap: {
		platform: "macos-arm64"
		commands: [
			"mkdir -p build/runtime/ci/bootstrap",
			"curl --fail --silent --show-error --location --proto '=https' --proto-redir '=https' --connect-timeout 15 --max-time 180 --output build/runtime/ci/bootstrap/mise.tar.gz https://github.com/jdx/mise/releases/download/v\(miseVersion)/mise-v\(miseVersion)-\(platform).tar.gz",
			"shasum --algorithm 256 --check publication/supply/ci-mise-\(platform).sha256",
			"tar -xzf build/runtime/ci/bootstrap/mise.tar.gz -C build/runtime/ci/bootstrap --strip-components=2 mise/bin/mise",
			"build/runtime/ci/bootstrap/mise --version",
		]
	}
	verify: {
		platform: "macos:aarch64"
		commit:   string
		// The hosted peer runs its bootstrapped binary; the local runners have Mise on PATH.
		mise: *"build/runtime/ci/bootstrap/mise" | "mise"
		commands: [
			"\(mise) install \(strings.Join(tools, " "))",
			"\(mise) exec \(strings.Join(tools, " ")) -- just --justfile publication/justfile ci-identity \(platform) \"\(commit)\"",
			"\(mise) exec \(strings.Join(tools, " ")) -- just --justfile publication/justfile ci",
			"git diff --exit-code -- .config/mise",
		]
	}
	publication: {
		packages: ["algorithmic/1.0.7", "codly/2.0.0", "codly-languages/0.1.10", "elembic/1.1.1", "neat-book/0.1.0", "octique/0.1.1", "showybox/2.0.4", "theorion/0.6.0"]
		commands: [
			"build/runtime/ci/bootstrap/mise install \(strings.Join(publicationTools, " "))",
			"mkdir -p build/runtime/ci/downloads build/runtime/ci/typst/fonts \"$HOME/Library/Fonts\"",
			"curl --fail --silent --show-error --location --proto '=https' --proto-redir '=https' --connect-timeout 15 --max-time 180 --output build/runtime/ci/downloads/noto.zip https://github.com/notofonts/noto-cjk/releases/download/Sans2.004/08_NotoSansCJKsc.zip",
			"shasum --algorithm 256 --check publication/supply/ci-noto.sha256",
			"unzip -q build/runtime/ci/downloads/noto.zip -d build/runtime/ci/downloads/noto",
			for face in ["Regular", "Bold", "Black"]
			for command in [
				"cp build/runtime/ci/downloads/noto/NotoSansCJKsc-\(face).otf build/runtime/ci/typst/fonts/",
				"cp build/runtime/ci/typst/fonts/NotoSansCJKsc-\(face).otf \"$HOME/Library/Fonts/rethinking-NotoSansCJKsc-\(face).otf\"",
			] {command},
			for font in ["Supplemental/Songti.ttc", "Supplemental/Charter.ttc", "Apple Color Emoji.ttc"]
			for command in [
				"test -f \"/System/Library/Fonts/\(font)\"",
				"ln -s \"/System/Library/Fonts/\(font)\" \"build/runtime/ci/typst/fonts/\(strings.Split(font, "/")[len(strings.Split(font, "/"))-1])\"",
			] {command},
			for package in packages
			for command in [
				"mkdir -p build/runtime/ci/typst/packages/preview/\(package)",
				"curl --fail --silent --show-error --location --proto '=https' --proto-redir '=https' --connect-timeout 15 --max-time 90 --output build/runtime/ci/downloads/\(strings.Replace(package, "/", "-", -1)).tar.gz https://packages.typst.org/preview/\(strings.Replace(package, "/", "-", -1)).tar.gz",
				"tar -xzf build/runtime/ci/downloads/\(strings.Replace(package, "/", "-", -1)).tar.gz -C build/runtime/ci/typst/packages/preview/\(package)",
			] {command},
			"\"$PUPPETEER_EXECUTABLE_PATH\" --version",
			"shasum --algorithm 256 build/runtime/ci/typst/fonts/*",
			"build/runtime/ci/bootstrap/mise exec \(strings.Join(publicationTools, " ")) -- just --justfile publication/justfile ci-publication",
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
				CHECKOUT_URL:              "${{ github.server_url }}/${{ github.repository }}.git"
				CHECKOUT_SHA:              "${{ github.sha }}"
				PUPPETEER_EXECUTABLE_PATH: "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
				TYPST_IGNORE_SYSTEM_FONTS: "true"
				TYPST_FONT_PATHS:          "${{ github.workspace }}/build/runtime/ci/typst/fonts"
				TYPST_PACKAGE_PATH:        "${{ github.workspace }}/build/runtime/ci/typst/packages"
				TYPST_PACKAGE_CACHE_PATH:  "${{ github.workspace }}/build/runtime/ci/typst/packages"
			}
			defaults: run: shell: "bash"
			steps: [
				{name: "Initialize checkout", run: "git init ."},
				{name: "Select the public event repository", run: "git remote add origin \"$CHECKOUT_URL\""},
				{name: "Fetch the exact event commit", run: "git -c protocol.version=2 fetch --no-tags --depth=1 origin \"$CHECKOUT_SHA\""},
				{name: "Check out the fetched commit", run: "git -c core.hooksPath=/dev/null checkout --detach FETCH_HEAD"},
				for command in (shared.bootstrap & {platform: "macos-arm64"}).commands {run: command},
				for command in (shared.verify & {platform: "macos:aarch64", commit: "$CHECKOUT_SHA"}).commands {run: command},
				for command in shared.publication.commands {run: command},
				for artifact in [
					{label: "PDF", path: "build/artifacts/pdf/rethinking-work.pdf"},
					{label: "Practice package", path: "build/artifacts/practice/rethinking-work-practice.tgz"},
				] {
					name: "Upload \(artifact.label) without re-archiving"
					uses: "actions/upload-artifact@cf430e030ddbb5b0abf93d22962f4752f3646cd9"
					with: {
						path:                artifact.path
						archive:             false
						"if-no-files-found": "error"
						"retention-days":    14
					}
				},
			]
		}
	}
}

compiled: gitlab: {
	path: ".gitlab-ci.yml"
	// The owner's local macOS arm64 runners supply Mise; each runner account keeps its tools between jobs.
	_verify: {
		stage:         "verify"
		timeout:       "20m"
		interruptible: true
		script: [
			"mise --version",
			for command in (shared.verify & {mise: "mise", platform: "macos:aarch64", commit: "$CI_COMMIT_SHA"}).commands {command},
		]
	}
	document: {
		stages: ["verify"]
		workflow: rules: [
			{"if": "$CI_PIPELINE_SOURCE == \"merge_request_event\""},
			{"if": "$CI_COMMIT_BRANCH =~ /^proposal\\// && $CI_OPEN_MERGE_REQUESTS", when: "never"},
			{"if": "$CI_COMMIT_BRANCH == \"dev\" || $CI_COMMIT_BRANCH == \"main\" || $CI_COMMIT_BRANCH =~ /^proposal\\// || $CI_COMMIT_TAG =~ /^v[^\\/]*$/"},
		]
		variables: {
			GIT_DEPTH:              "1"
			GIT_STRATEGY:           "clone"
			GIT_SUBMODULE_STRATEGY: "none"
			// The lock settings are the shared ones; the hosted peer's job-local stores are not used here.
			for name in ["MISE_LOCKED", "MISE_EXEC_AUTO_INSTALL", "MISE_TRUSTED_CONFIG_PATHS"] {
				"\(name)": (shared.environment & {workspace: "$CI_PROJECT_DIR"}).variables[name]
			}

			// The runner account's own Mise settings and parent directories stay out of the job.
			MISE_CONFIG_DIR:    "$CI_PROJECT_DIR/build/runtime/ci/mise/config"
			MISE_CEILING_PATHS: "$CI_PROJECT_DIR/.."
			MISE_JOBS:          "1"
			MISE_YES:           "1"
		}
		"verify:macos:review": _verify & {
			tags: ["ci-macos-arm64-review"]
			rules: [{"if": "$CI_PIPELINE_SOURCE == \"merge_request_event\" || ($CI_COMMIT_BRANCH =~ /^proposal\\// && $CI_PIPELINE_SOURCE == \"push\")"}]
		}
		"verify:macos:protected": _verify & {
			tags: ["ci-macos-arm64-shell"]
			rules: [{"if": "$CI_COMMIT_REF_PROTECTED == \"true\" && ($CI_COMMIT_BRANCH == \"dev\" || $CI_COMMIT_BRANCH == \"main\" || $CI_COMMIT_TAG =~ /^v[^\\/]*$/)"}]
		}
	}
}
