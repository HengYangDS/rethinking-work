## Why

An independent review of the baseline check that `review-baseline` added (2026-11-26 11:5x, a reviewer that had not
seen the change) found that it could fail in CI on a correct record. It resolved the reviewed commit, which a lane
rewritten after its review leaves on no ref that a CI clone fetches; the first record in `reviews.toml`, `601fbca`, is
such a commit. It also found that a review time without its offset is read in the runner's time zone, and that a
lightweight tag's date is its commit's.

## What Changes

- The last release is read from the head's history, not the reviewed commit's, in one `git for-each-ref --merged=HEAD`
  sorted by the tag's own date; a tag without a tagger date takes no part.
- A record's `read` must be a date and time with its offset.
- Only the latest commands review that covers the head is held to the rule; an older record that the head's trees
  match again stays as it was written.
- The acceptance document and the specification say "no later than the review" and "the head's history", as the test
  reads them.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: the baseline scenario of "Reviewed text before landing" names the latest covering review and
  the head's history.

## Impact

`tests/test_acceptance.py`, `docs/publication-acceptance.md`, the specification.
