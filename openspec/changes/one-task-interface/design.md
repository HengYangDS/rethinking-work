## Context

See [proposal.md](proposal.md).

## Goals / Non-Goals

**Goals:**

- One way to run each task and the tests.

**Non-Goals:**

- Moving the justfile to the repository root; the owner's other repositories' convention is not yet read.

## Decisions

- `uv lock --check --offline` resolves the same ten packages without the build tables.

## Risks / Trade-offs

- None found.
