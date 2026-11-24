package ci

import (
	"list"
	"strings"
)

// The installed common model (ETHOS `.config/ci/verification.cue`) generates the verification
// jobs of both Forges from `verification.toml`, and `ethos lane project` writes the native files.
// This file adds what the model leaves to the repository: on each Forge, a macOS job that builds
// the PDF and the practice archive and keeps them as artifacts for `artifactDays`.
artifactDays: 14

supply: {
	tools: ["node", "python", "just", "npm:prettier", "duckdb", "ast-grep", "github:oasdiff/oasdiff", "cue", "typst", "npm:@mermaid-js/mermaid-cli"]
	miseVersion: _inputs.ci.supply.mise_version
	packages: ["algorithmic/1.0.7", "codly/2.0.0", "codly-languages/0.1.10", "elembic/1.1.1", "neat-book/0.1.0", "octique/0.1.1", "showybox/2.0.4", "theorion/0.6.0"]
	bootstrap: [
		"mkdir -p build/runtime/ci/bootstrap",
		"curl --fail --silent --show-error --location --proto '=https' --proto-redir '=https' --connect-timeout 15 --max-time 180 --output build/runtime/ci/bootstrap/mise.tar.gz https://github.com/jdx/mise/releases/download/v\(miseVersion)/mise-v\(miseVersion)-macos-arm64.tar.gz",
		"shasum --algorithm 256 --check publication/supply/ci-mise-macos-arm64.sha256",
		"tar -xzf build/runtime/ci/bootstrap/mise.tar.gz -C build/runtime/ci/bootstrap --strip-components=2 mise/bin/mise",
		"build/runtime/ci/bootstrap/mise --version",
	]
	build: list.Concat([[
		"build/runtime/ci/bootstrap/mise install \(strings.Join(tools, " "))",
		"mkdir -p build/runtime/ci/downloads build/runtime/ci/typst/fonts \"$HOME/Library/Fonts\"",
		"curl --fail --silent --show-error --location --proto '=https' --proto-redir '=https' --connect-timeout 15 --max-time 180 --output build/runtime/ci/downloads/noto.zip https://github.com/notofonts/noto-cjk/releases/download/Sans2.004/08_NotoSansCJKsc.zip",
		"shasum --algorithm 256 --check publication/supply/ci-noto.sha256",
		"unzip -q build/runtime/ci/downloads/noto.zip -d build/runtime/ci/downloads/noto",
	], [
		for face in ["Regular", "Bold", "Black"]
		for command in [
			"cp build/runtime/ci/downloads/noto/NotoSansCJKsc-\(face).otf build/runtime/ci/typst/fonts/",
			"cp build/runtime/ci/typst/fonts/NotoSansCJKsc-\(face).otf \"$HOME/Library/Fonts/rethinking-NotoSansCJKsc-\(face).otf\"",
		] {command},
	], [
		for font in ["Supplemental/Songti.ttc", "Supplemental/Charter.ttc", "Apple Color Emoji.ttc"]
		for command in [
			"test -f \"/System/Library/Fonts/\(font)\"",
			"ln -s \"/System/Library/Fonts/\(font)\" \"build/runtime/ci/typst/fonts/\(strings.Split(font, "/")[len(strings.Split(font, "/"))-1])\"",
		] {command},
	], [
		for package in packages
		for command in [
			"mkdir -p build/runtime/ci/typst/packages/preview/\(package)",
			"curl --fail --silent --show-error --location --proto '=https' --proto-redir '=https' --connect-timeout 15 --max-time 90 --output build/runtime/ci/downloads/\(strings.Replace(package, "/", "-", -1)).tar.gz https://packages.typst.org/preview/\(strings.Replace(package, "/", "-", -1)).tar.gz",
			"tar -xzf build/runtime/ci/downloads/\(strings.Replace(package, "/", "-", -1)).tar.gz -C build/runtime/ci/typst/packages/preview/\(package)",
		] {command},
	], [
		"\"$PUPPETEER_EXECUTABLE_PATH\" --version",
		"shasum --algorithm 256 build/runtime/ci/typst/fonts/*",
		"build/runtime/ci/bootstrap/mise exec \(strings.Join(tools, " ")) -- just --justfile publication/justfile ci-publication",
	]])
}

// The job keeps every tool, font and package inside its own workspace, on the fixed macOS label the verification
// jobs declare in `verification.toml`.
publicationJob: {
	"runs-on":         _inputs.ci.github.runners[0]
	"timeout-minutes": 20
	env: {
		MISE_LOCKED:               "1"
		MISE_EXEC_AUTO_INSTALL:    "0"
		MISE_TRUSTED_CONFIG_PATHS: "${{ github.workspace }}"
		MISE_DATA_DIR:             "${{ github.workspace }}/build/runtime/ci/mise/data"
		MISE_CACHE_DIR:            "${{ github.workspace }}/build/runtime/ci/mise/cache"
		MISE_STATE_DIR:            "${{ github.workspace }}/build/runtime/ci/mise/state"
		CHECKOUT_URL:              "${{ github.server_url }}/${{ github.repository }}.git"
		CHECKOUT_SHA:              "${{ github.sha }}"
		PUPPETEER_EXECUTABLE_PATH: "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
		TYPST_IGNORE_SYSTEM_FONTS: "true"
		TYPST_FONT_PATHS:          "${{ github.workspace }}/build/runtime/ci/typst/fonts"
		TYPST_PACKAGE_PATH:        "${{ github.workspace }}/build/runtime/ci/typst/packages"
		TYPST_PACKAGE_CACHE_PATH:  "${{ github.workspace }}/build/runtime/ci/typst/packages"
	}
	defaults: run: shell: "bash"
	steps: list.Concat([[
		{name: "Initialize checkout", run: "git init ."},
		{name: "Select the public event repository", run: "git remote add origin \"$CHECKOUT_URL\""},
		{name: "Fetch the exact event commit", run: "git -c protocol.version=2 fetch --no-tags --depth=1 origin \"$CHECKOUT_SHA\""},
		{name: "Check out the fetched commit", run: "git -c core.hooksPath=/dev/null checkout --detach FETCH_HEAD"},
	], [for command in supply.bootstrap {run: command}], [for command in supply.build {run: command}], [
		for artifact in [
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
		},
	]])
}

compiled: providers: github: jobs: publication: publicationJob

// The private peer builds the same two artifacts on the owner's local macOS runners, after the
// supply task has given the runner account its fonts, packages and headless shell. Its rules
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
		tags: ["ci-macos-arm64-review"]
		rules: [{if: "$ETHOS_OFFLINE_CANDIDATE", when: "never"}, {if: "$CI_PIPELINE_SOURCE == \"merge_request_event\" || ($CI_COMMIT_BRANCH =~ /^proposal\\// && $CI_PIPELINE_SOURCE == \"push\")"}]
	}
	"publication:macos:protected": gitlabPublication & {
		tags: ["ci-macos-arm64-shell"]
		rules: [{if: "$ETHOS_OFFLINE_CANDIDATE", when: "never"}, {if: "$CI_COMMIT_REF_PROTECTED == \"true\" && ($CI_COMMIT_BRANCH == \"dev\" || $CI_COMMIT_BRANCH == \"main\" || $CI_COMMIT_TAG =~ /^v[^\\/]*$/)"}]
	}
}
