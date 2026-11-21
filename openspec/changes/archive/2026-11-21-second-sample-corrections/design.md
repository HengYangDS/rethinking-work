## Context

See [proposal.md](proposal.md). The error list and the borderline items are in the local evidence
`build/evidence/error-rate-sample/run-codex/`.

## Goals / Non-Goals

**Goals:**

- Correct the seven agreed errors and every other instance of their kinds.

**Non-Goals:**

- The two borderline items: 「大部分源于精度」 rests on two steps of chapter 6's test together (rounding to 0.1 removes
  the tail differences that precision causes, and 32-bit floats reproduce nine tenths of the rest), and 「共十一行」 is
  defined by the next sentence as eleven observations.

## Decisions

- Wording follows the sample's proposed corrections, adjusted so that each sentence reads on with its neighbours.

## Risks / Trade-offs

- [Pages after the first change may move] → The changed pages are looked at before the release commit.
