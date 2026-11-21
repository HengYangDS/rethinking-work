## Context

See [proposal.md](proposal.md). The static gate runs ruff isolated, with line length 100, target 3.12 and the rule
groups E, F, B, I and UP.

## Goals / Non-Goals

**Goals:**

- The static gate passes on the test file without changing what the test checks.

**Non-Goals:**

- Any other test or rule.

## Decisions

- Run ruff with the gate's own arguments before committing a Python change, through a saved command.

## Risks / Trade-offs

- [None beyond the edit itself] → The test runs in the proof.
