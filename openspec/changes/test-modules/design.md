## Context

See [proposal.md](proposal.md). The checks share one expensive build (about one layout of the book); the class fixture
of a single module was what made it shared. Two modules need the build outside any one class.

## Goals / Non-Goals

**Goals:**

- Each module of document checks stays well under ETHOS's effective-line ceiling, with room for the next checks.
- The book is still laid out once per test run, and every check keeps its CPU guard.

**Non-Goals:**

- Changing what any check asserts.

## Decisions

- The build is a module-level function cached for the process (`functools.cache`), so unittest and pytest, which import
  each test module once, compile and evaluate once whatever the order or selection of checks.
- A base class `Edition` takes the build in `setUpClass` and keeps the CPU guard of each check, so a check that lays out
  the book again still fails.
- Checks are grouped by what they read the edition for, not by size: identity, inputs and commands in one module, the
  typeset layout in the other.

## Risks / Trade-offs

- [The scratch folder outlives the class] → It is removed at process exit (`atexit`).
- [A helper outside the test folder imports the old module] → Only local evidence drivers did; they follow the split.
