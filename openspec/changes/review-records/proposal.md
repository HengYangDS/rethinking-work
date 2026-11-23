## Why

Three book commits (838730d, ad8affd, 1f712ad) landed on 2026-11-22 and 23 without the review of the printed commands
that the edition's acceptance names: the stage existed only in a driver under the ignored `build/`, which a newer
driver dropped. It is the third recurrence (RA-V on 11-21, RW-C on 11-22, RS-A traced by the commands reviewer on 11-23);
the reading of changed passages by a fresh reader had the same weakness. The owner asked for quality held by the
repository (「要制度性系统性地，上位本质地解决问题」, 2026-11-21) and to speed up (「加速推进」, 2026-11-23 13:37); a stage
that no proof or CI reads can be skipped by any new script.

## What Changes

- A requirement declares that a head whose `book/` or `exercises/` tree changes is proved only with a recorded review of
  its printed commands and a recorded reading of its changed passages, each with every point settled or declined.
- `publication/acceptance/reviews.toml`, tracked, holds the records: commands reviews keyed by the trees of `book/` and
  `exercises/`, readings keyed by the tree of `book/`, and release PDF checks keyed by the PDF's SHA-256. The reviewers
  change nothing in the repository; the lane's editor copies their verdicts, and their findings stay in their local
  evidence folders, named by path.
- `tests/test_acceptance.py` fails a head without these records, so the proof and both CIs read them. The format was
  agreed with the commands reviewer (2026-11-23 13:0x).
- The acceptance guide states the stage.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: adds "Reviewed text before landing".

## Impact

`publication/acceptance/reviews.toml`, `tests/test_acceptance.py`, `tests/README.md`, `docs/publication-acceptance.md`
and `CHANGELOG.md`. The book does not change.
