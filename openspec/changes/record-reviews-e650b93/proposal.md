## Why

A head that changes the book's text or exercises needs a commands review and a reading of its exact trees before it is
proved and landed (`docs/publication-acceptance.md`, held by `tests/test_acceptance.py`). The commands reviewer read
`c3bce38` and `e650b93`, and both families read the whole book at `c3bce38`; the lane's corrections are in `e40b3ce` and
`e650b93`.

## What Changes

- `publication/acceptance/reviews.toml` records the commands review and the reading of the `book/` and `exercises/`
  trees at `e650b93`, each point with how it was settled or why it was declined.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: the head's reviews are recorded before it is proved.

## Impact

`publication/acceptance/reviews.toml` only.
