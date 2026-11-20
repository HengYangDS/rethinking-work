# Design

See `proposal.md` for the reason.

## Context

Each fact about the proof's test run has one owner:

- `.ethos/profile.toml` declares the gate: its command, its verification provider and its dimensions.
- `publication/justfile` declares what `test` and `test-proof` run.
- `tests/README.md` describes the tests and the rules they hold, the section "Standard library only" included.
- `openspec/specs/publication-source/spec.md` states the requirements.
- The CHANGELOG records history.

The restatements this Change removes sit beside those owners and repeat them.

## Goals / Non-Goals

**Goals:** each of the facts above is stated in its owner; every other place that mentions it points there.

**Non-Goals:** any change in what the tests or the proof do; restatements this session did not write.

## Decisions

### D1. Pointers, not summaries

A pointer names where the fact lives and what a reader finds there. It does not repeat the fact. A one-line summary beside a pointer is still a copy that can drift, so none is kept.

### D2. The gate comment keeps only its pointer

The gate's dimensions already say which checks its reports serve. The comment points to `tests/README.md` for what the run holds the tests to. The timeout's reason stays beside the timeout: the accepted spec requires it there, so that comment is the owner of that reason, not a copy of it.

## Risks / Trade-offs

- A reader of `docs/contributing.md` follows one more link to learn the rule. Each place then has one answer.

## Migration Plan

Nothing to migrate. Rollback restores the removed sentences.
