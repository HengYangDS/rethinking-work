## Why

The owner asked to release 0.2.7 (「发布 0.2.7」, 2026-11-26 03:42). `dev` at `500572a` holds the 0.2.7 work: the
figures drawn in Typst, the edition identity read from git, the calibrated readings, two content reviews, the reader
notes decided, the whole-book reading of `c3bce38` by both families and its corrections, and the error-rate sample of
`e650b93` (0.47 per 10,000 against a limit of 1) with its corrections, read again with no error.

## What Changes

- `VERSION` becomes 0.2.7, a patch release: the changes correct and tighten the text, redraw the figures and simplify
  the supply; they add no capability.
- The Changelog's Unreleased entries move under `[0.2.7]` dated 2026-11-26, the day the tag is made; the edition's date
  comes from the tag.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

None. `.openspec.yaml` sets `skip_specs: true`.

## Impact

`VERSION`, `CHANGELOG.md` and the release record in `publication/acceptance/reviews.toml`. The release itself (tag,
`main`, the releases on both forges with the edition archive, the delivered copy) follows the archived head and is
recorded by Git, the tag and the forges.
