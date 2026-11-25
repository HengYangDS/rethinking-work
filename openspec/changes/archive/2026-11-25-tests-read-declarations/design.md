## Context

See [proposal.md](proposal.md).

## Goals / Non-Goals

**Goals:**

- Each number a check uses comes from the declaration it checks.

**Non-Goals:**

- Changing what any check holds.

## Decisions

- A paragraph step is two body lines, the layout's own definition of a paragraph transition (one empty body line).
- Poppler stays bound by the Brewfile: the paths come from one `pdf-tool` call, so the declared bundle still wins over
  any other copy on the path.

## Risks / Trade-offs

- None found.
