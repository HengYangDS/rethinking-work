## Why

The repository declares and runs ETHOS 0.2.0-beta.11. ETHOS 0.2.0-beta.12 was published on 28 November 2026 (01:19
CST), upgrades directly from 0.2.0-beta.11, and publishes its own Mise declaration, whose platform checksums equal
the release's `SHA256SUMS` and the forge's asset digests. The workstation's version policy takes the latest release,
and the other governed repositories bind it the same day.

Of the release entry's changes (ETHOS `CHANGELOG.md`, section 0.2.0-beta.12), this repository meets these:

- The `source-format`, `markdown-lint` and `config-quality` gates start each tool a fixed number of times.
- A ticket keeps its place in the host queue after its holder is killed, and a full proof on a quiet host no longer
  waits one sampling interval before its first test gate.
- An executed proof reports its inherited environment, its footprint in the lane and its gate inputs; none of these
  changes a verdict.

The others do not apply: the repository declares no `subject_pattern`, no `{scratch}` argument, no sqlfluff policy
and no Windows platform or job. The Docs Registry's new section on decision records asks each repository to migrate
its records through a lane of its own; that is not part of this move.

## What Changes

- Set `version` in the `[tools."http:ethos"]` table of `.config/mise/config.toml` to 0.2.0-beta.12, and lock it
  again with native `mise lock`; the table keeps its form, and the lock holds each platform's checksum.
- Bind the repository family to the 0.2.0-beta.12 runtime through the locked console's `hook install`, keeping
  0.2.0-beta.11 as the rollback.
- Record the move under Changed in the Changelog's Unreleased section.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

None. The book, its checks and its publication behave as before, so `.openspec.yaml` sets `skip_specs: true`.

## Impact

`.config/mise/config.toml`, `.config/mise/mise.lock`, `CHANGELOG.md` and the repository-common runtime selection.
Both generated pipelines conform under 0.2.0-beta.12 as they stand. The release age (`minimum_release_age = "24h"`)
stays as it is: it filters a version that Mise resolves, not an exact one, as the 0.2.0-beta.11 move recorded.
