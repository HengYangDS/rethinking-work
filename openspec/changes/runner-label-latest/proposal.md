## Why

The owner made one macOS runner label global for every repository (「全局统一，都是 macos-latest」, 2026-11-25 13:58),
after choosing `macos-latest` for GitHub and `macos-latest` with `review` or `protected` for GitLab (relayed from his
answer of 13:54). 0.2.6 declares `macos-26` for GitHub and the runner-specific `ci-macos-arm64-review` and
`ci-macos-arm64-shell` for GitLab, and the GitLab publication jobs repeat those tags instead of reading them.

## What Changes

- `.config/ci/verification.toml` declares `macos-latest` for GitHub and `macos-latest` with `review` or `protected`
  for GitLab, as the data-department guidelines repository does.
- `.config/ci/pipeline.cue` reads the GitLab tags from that declaration; the projections are regenerated.
- Both GitLab runners carry the new tags beside their old ones until `main` is published; removing the old tags then
  is a task of the lane that removes Windows after 0.2.6, since it needs the published `main`.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

None: the CI declaration is configuration that no specification requirement names.

## Impact

CI configuration only; the book, the exercises and the release archive are unchanged. GitHub's ruleset requires no
named check, so the check name `verify (macos-latest)` replacing `verify (macos-26)` blocks nothing.
