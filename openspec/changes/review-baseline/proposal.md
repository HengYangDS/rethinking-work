## Why

"Run every changed command, old against new" (`docs/publication-acceptance.md`) needs the old commands to be the last
release's. Each commands review records that baseline as `blocks_against` in `publication/acceptance/reviews.toml`, and
the test checks only that the field is there. The record of `e650b93` copied `v0.2.3` from an older entry, against
which ten changed blocks would have counted as unrun; the commands reviewer found it, and it now reads `v0.2.6`. The
reviewer proposed a test on 2026-11-26 06:15, and the owner said to do it here at 11:32.

## What Changes

- `tests/test_acceptance.py` fails a head when a commands review that covers it names a baseline other than the last
  release: the latest `v*` tag that the review's subject descends from and that was made no later than the review.
- The acceptance document states which release the old commands come from.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: "Reviewed text before landing" names the baseline of the commands review in a scenario.

## Impact

`tests/test_acceptance.py`, `docs/publication-acceptance.md`, `CHANGELOG.md`, the specification.
