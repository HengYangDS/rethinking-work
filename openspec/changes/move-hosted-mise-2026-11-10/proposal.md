## Why

The hosted jobs install Mise 2026.11.9. Mise 2026.11.10, published on 18 November 2026 and past the repository's
24-hour release age, fixes `mise exec` running Node's bundled npm instead of the pinned npm when the inherited
`PATH` already holds the tool (jdx/mise#15771, fixed by jdx/mise#15838), a defect that ETHOS 0.2.0-beta.11's entry
names as known and open.

The repository states the hosted Mise release twice: `[supply] mise_version` in `.config/ci/verification.toml`,
which the common model reads for the verification jobs, and `supply.miseVersion` in `.config/ci/pipeline.cue`,
which the publication job's bootstrap reads. Moving it means changing both by hand today.

## What Changes

- `.config/ci/pipeline.cue` reads the Mise release from the declared input, `_inputs.ci.supply.mise_version`, so
  `verification.toml` is its only source.
- Move `[supply] mise_version` to 2026.11.10 and the bootstrap checksum in
  `publication/supply/ci-mise-macos-arm64.sha256` to that release's macOS archive.
- Generate the pipelines again from the common model.
- Record the move under Changed in the Changelog's Unreleased section.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

None. The repository's checks and its publication behave as before, so `.openspec.yaml` sets `skip_specs: true`.

## Impact

`.config/ci/verification.toml`, `.config/ci/pipeline.cue`, `publication/supply/ci-mise-macos-arm64.sha256`, the
generated pipelines and `CHANGELOG.md`. The lockfile and the Mise floor stay as they are.
