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
	bootstrap: {
		platform: "macos-arm64" | "linux-x64"
		checkCommand: {"macos-arm64": "shasum --algorithm 256 --check", "linux-x64": "sha256sum --check"}[platform]
		// The official installer uses this Linux mirror; checksums stay GitHub-bound.
		downloadBase: {"macos-arm64": "https://github.com/jdx/mise/releases/download", "linux-x64": "https://mise.jdx.dev"}[platform]
		commands: [
			"mkdir -p build/runtime/ci/bootstrap",
			"curl --fail --silent --show-error --location --proto '=https' --proto-redir '=https' --connect-timeout 15 --max-time 180 --output build/runtime/ci/bootstrap/mise.tar.gz \(downloadBase)/v\(miseVersion)/mise-v\(miseVersion)-\(platform).tar.gz",
			"\(checkCommand) publication/supply/ci-mise-\(platform).sha256",
			"tar -xzf build/runtime/ci/bootstrap/mise.tar.gz -C build/runtime/ci/bootstrap --strip-components=2 mise/bin/mise",
			"build/runtime/ci/bootstrap/mise --version",
		]
	}
	verify: {
		platform: "macos:aarch64" | "linux:x86_64"
		commit:   string
		commands: [
			"build/runtime/ci/bootstrap/mise install \(strings.Join(tools, " "))",
			"build/runtime/ci/bootstrap/mise exec \(strings.Join(tools, " ")) -- just --justfile publication/justfile ci-identity \(platform) \"\(commit)\"",
			"build/runtime/ci/bootstrap/mise exec \(strings.Join(tools, " ")) -- just --justfile publication/justfile ci",
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
				TYPST_IGNORE_SYSTEM_FONTS: "1"
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
