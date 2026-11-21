## Context

See [proposal.md](proposal.md). The sample's error list, with page, source line and proposed correction, is in the
local evidence `build/evidence/error-rate-sample/run-943c183/errors.tsv`.

## Goals / Non-Goals

**Goals:**

- Correct every error the sample found, and every other instance of the same kind.

**Non-Goals:**

- The loose lines next to long code, which the sample noted outside its count; they belong to the quality-gate work.

## Decisions

- Wording follows the reader-run session's proposed corrections, except where a clearer form names the same thing
  (`hindsight memory retain` instead of a count of commands).
- The card title stays bold and keeps the paragraph spacing; only its stickiness is new, declared once in the layout
  instead of in sixteen places.

## Risks / Trade-offs

- [A card that moves to the next page leaves its page shorter] → The page-foot checks and the page look cover it.
