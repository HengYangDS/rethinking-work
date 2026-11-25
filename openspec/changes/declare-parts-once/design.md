## Context

See [proposal.md](proposal.md).

## Goals / Non-Goals

**Goals:**

- One place for the parts; layout rules in the layout module; no dead layout code.

**Non-Goals:**

- Deriving chapter numbers from a counter: chapter references read the declared numbers ("09", "练二", "A").

## Decisions

- The part is a state that the manuscript sets before each part's files; a chapter's head reads it in context, and the
  contents read it at each chapter mark's location. Chapter metadata stays outside `context`: inside it, Typst did not
  converge in five attempts.
- Acceptance: the PDF's text, laid out, is the same before and after, except the draft's commit on the cover.

## Risks / Trade-offs

- None found; the tests read the same marks as before.
