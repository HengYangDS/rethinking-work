## Why

A second independent review (2026-11-26 12:3x) of `review-baseline-hold` found that reading the last release from the
head's history rejects a correct record after a rebase that crosses a release: the trees stay, so the record still
covers the new head, but the head now holds a newer tag than the one the review compared with. It also found that
"signed" was claimed and not checked, that `v*` matches names that are not releases, and that the offset rule stood in
neither the specification nor the record's header.

## What Changes

- The last release depends on the review time alone: the latest signed release tag made no later than the review.
  Releases are tagged in turn on `main`, so the time names it, and no commit or head enters.
- Only tags named `v<major>.<minor>.<patch>` that carry a signature count; at equal times the higher version.
- The offset rule has its own test, a scenario in the specification and a line in the record's header.
- Commands reviews are recorded in the order they were read, so a record copied whole from an older one fails.
- GitLab's verification jobs fetch every tag (`GIT_FETCH_EXTRA_FLAGS`), and a recorded tag missing from the clone fails
  with "fetch the tags".
- The test's comment says when an older covering record is not held.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: "Reviewed text before landing" gains a scenario for a time without its offset, and the
  baseline scenario names the last release by time alone.

## Impact

`tests/test_acceptance.py`, `docs/publication-acceptance.md`, `publication/acceptance/reviews.toml` (header only),
`.config/ci/verification.toml` and the generated `.gitlab-ci.yml`, the specification.
