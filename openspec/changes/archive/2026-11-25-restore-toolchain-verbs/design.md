## Context

See [proposal.md](proposal.md). The refusal is in `build/evidence/release-0-2-7/proof/` (ticket of `29e15bc`).

## Goals / Non-Goals

**Goals:**

- The proof runs.

**Non-Goals:**

- Changing ETHOS's paradigm.

## Decisions

- The lane's light checks now include the full proof's plan without executing it (about seven seconds), which reports
  the paradigm's gaps; only `full_proof_requires_execute` may remain.

## Risks / Trade-offs

- None.
