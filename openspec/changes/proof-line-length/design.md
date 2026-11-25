## Context

See [proposal.md](proposal.md). The gate runs ruff with `--line-length 100` over the tests.

## Goals / Non-Goals

**Goals:**

- The proof's static-analysis gate passes on the release head.

**Non-Goals:**

- Any other change.

## Decisions

- Rewrap the comment; the gate's own ruff command was run on the change before the proof.

## Risks / Trade-offs

- None.
