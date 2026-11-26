## Why

The plan for removing hard-coded facts, approved by the owner on 2026-11-26, asked that the CI supply stop writing
fonts into the runner account's font folder; none of the three Changes that answered it took that item. The supply
task still copies the three Noto faces into `home_directory()/Library/Fonts`, under a `rethinking-` prefix: a
platform path written in the justfile, and a write into a folder that every application of the account reads. It also
writes Typst's default package cache, `cache_directory()/typst`, which restates where Typst keeps its packages.

## What Changes

- The supply task keeps the faces in a folder of the account's cache, declared once in the justfile under the
  repository's name, which the justfile now declares once for its outputs too. Every task names that folder to Typst
  through Typst's own setting, `TYPST_FONT_PATHS`, after any font paths the caller set. On a host without the folder,
  Typst reads the caller's font paths and the system's fonts as before. The faces keep their own file names.
- The supply task and the check that every package read is supplied take Typst's package folders from the compiler
  (`typst info --format json`); the package manifest lists each file relative to the package cache.
- The faces the old task installed in the font folders of the two GitLab runner accounts are removed.

The supply stays outside the checkout, not under `build/runtime/tool-cache/` as the plan named: the GitLab runner
removes the checkout's ignored files, `build/` included, when each job starts (jobs 80432 and 80433 of pipeline 18506,
2026-11-27), so a supply kept there would be fetched again by every job. The account's cache outlives the job; a
cleanup of it only means that the next job fetches the supply again.

The PDF does not change: the faces are the same files, found in another folder.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: a new requirement, "Runner supply in the account's caches", covers where a runner keeps the
  fonts and packages it fetched and how Typst reaches them.

## Impact

`publication/justfile`, `publication/supply/typst-packages.sha256`, `publication/README.md`, `tests/edition.py`,
`tests/test_publication.py`, the specification; outside the repository, the font folders of the GitLab runner accounts
`ci-rethinking-work-protected` and `ci-rethinking-work-review` in the macOS guest.
