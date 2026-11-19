# Design

## Context

`.config/mise/config.toml` owns the tool versions and `uv.lock` the Python test environment. The owner's direction of 2026-11-19: supply updates wait 24 hours instead of 72, each governed repository writes its own age, and ETHOS's common base supplies 24 hours where a repository writes none. On that day this repository still said "0h", and `mise outdated` under a 24-hour age named ast-grep, oasdiff and uv.

## Goals / Non-Goals

Goals: one declared age per resolver, in that resolver's own configuration; the tools that have an admissible newer release move in one commit with every statement of their version.

Non-Goals: a test or script that holds the number; moving Python off 3.12, ETHOS off its bound release, or any tool that has no admissible newer release.

## Decisions

### The age lives in each resolver's native setting

Mise reads `minimum_release_age = "24h"` from the repository's `[settings]`; uv reads `exclude-newer = "24 hours"` from `[tool.uv]` and records the span, not a date, in `uv.lock`, so `uv run --locked` stays valid as time passes. Both follow the owner's filmkit repository. No test restates the number: the resolvers refuse a younger release themselves.

### Versions are the newest admissible on the day of the commit

Read on 2026-11-19 from each project's release list: ast-grep 0.51.3 (published 11-16), oasdiff 1.39.0 (11-17), uv 0.13.9 (11-17) and hosted Mise 2026.11.9 (11-16). Mise 2026.11.10 was published on 11-18 and was not yet 24 hours old. `mise lock` writes the lock for the platforms the lock already carries; the hosted Mise's version sits once in the pipeline declaration and the verification parameters, and its archive checksum in `publication/supply/`.

### Alternatives considered

- Remove the Mise line and inherit the base's default: rejected; the owner asked each repository to write its age.
- Wait for Mise 2026.11.10: rejected for this commit; it follows in the next supply move.

## Risks / Trade-offs

- oasdiff moves two minor versions; its output feeds one exercise contract. The exercises run under the new lock before the commit.
- A relative age means a later relock can admit versions this commit did not see; the lock, not the age, fixes what a proof runs.
