## Why

The repository declares and runs ETHOS 0.2.0-beta.10. ETHOS 0.2.0-beta.11 was published on 21 November 2026,
upgrades directly from 0.2.0-beta.10 and publishes its own Mise declaration, whose platform checksums equal the
release's `SHA256SUMS` and the forge's asset digests. The workstation's version policy takes the latest release,
and the ETHOS sessions bind the other governed repositories to it the same day.

Of the release entry's changes (ETHOS `CHANGELOG.md`, section 0.2.0-beta.11), this repository meets these:

- Hosted CI artifacts expire after 14 days. The common CI model declares the retention once, so the generated
  pipelines change; only `ethos lane project --check` reports the old files, so the lane applies the previewed
  patch with `ethos lane project --apply`.
- No result continues with `export ETHOS_ACTOR=<holder>`; a result without an actor asks for `--actor`. The lane
  keeps `ETHOS_ACTOR` set for its commands.
- `ethos hook install` no longer deletes an installation whose consumer it cannot read.

The others do not apply: the repository declares no gate provider by name, no `timeout.admission_seconds`, no
`linguist-generated` or `linguist-vendored` mark, and the lane calls no `ethos adopt`.

## What Changes

- Replace the 0.2.0-beta.10 declaration in `.config/mise/config.toml` with the one published with
  0.2.0-beta.11, unchanged, keeping the `http:ethos` table form, and lock it again with native `mise lock`.
- Bind the repository family to the 0.2.0-beta.11 runtime through the locked console's `hook install`, keeping
  0.2.0-beta.10 as the rollback.
- Regenerate both pipelines with `ethos lane project --apply`.
- Record the move under Changed in the Changelog's Unreleased section.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

None. The book, its checks and its publication behave as before, so `.openspec.yaml` sets `skip_specs: true`.

## Impact

`.config/mise/config.toml`, `.config/mise/mise.lock`, both generated pipelines, `CHANGELOG.md` and the
repository-common runtime selection. The release age (`minimum_release_age = "24h"`, declared on 19 November 2026) stays as it is: an age filters only a version that Mise resolves, not an exact or locked one.
