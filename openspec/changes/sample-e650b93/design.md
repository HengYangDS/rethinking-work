## Context

See [proposal.md](proposal.md). The sample's counted errors are in `run-e650b93/errors.tsv`; the standards excerpts the
judges read are in `error-rate-sample/tools/standards-excerpts.md`.

## Goals / Non-Goals

**Goals:**

- Each counted place and each place of its kind is corrected with the least wording that fixes it.
- A clean runner compiles the book from the declared supply alone.

**Non-Goals:**

- The 100 notes that were not sent to a judge; they stay with the editors' decisions.

## Decisions

- The figure box reads 「4 只有值」, as the text beside the figure does (「四只有值」); 「只」 then counts securities.
- 「token」 takes the gloss chapter 11 gives it, at its first use in chapter 10; chapter 11 keeps its own sentence.
- The sweep for the comma kind takes a series as items when each is a nominal phrase in an order (GB/T 15834—2011
  A.4.1); clauses with their own predicates keep their commas (4.4.3.1), such as the state list in chapter 7 and the
  run list in chapter 18.
- Letter words: every first use in the prose was listed in reading order; the others are glossed, tool names, or common
  for the stated reader (`docs/publication-acceptance.md`).
- Code type: every file name, path and label in body prose was listed; outside quoted words a reader types or a brief's
  text, only the chapter 12 label was in body type.

## Risks / Trade-offs

- The changed passages are read again before the release.
