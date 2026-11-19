# Proposal

## Why

The repository's Mise configuration sets `minimum_release_age = "0h"`, which overrides the host and admits a tool release the minute it is published; its Python test environment has no age at all. The owner decided on 2026-11-19 that every governed repository waits 24 hours before it takes a supply update, and that each repository writes this age itself. Three locked tools and the hosted Mise have newer releases that are older than that age.

## What Changes

- The repository declares a 24-hour release age for its Mise tools and for the Python packages uv resolves.
- ast-grep, oasdiff and uv move to their newest releases that are at least 24 hours old; the hosted Mise that the forge jobs bootstrap moves likewise.
- The lock, the pipeline declarations with their generated files, and the contributor documents state the new versions in the same commit.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: the repository SHALL declare the minimum age of a supply release in its own native configuration and admit a newer version only when it is that old.

## Impact

`.config/mise/config.toml` and its lock, `pyproject.toml` and `uv.lock`, the pipeline declaration and verification parameters under `.config/ci/` with both forges' generated files, the hosted Mise checksum under `publication/supply/`, `publication/README.md` and `CHANGELOG.md`. The manuscript does not change: appendix C already names oasdiff 1.39 and ast-grep 0.51. Out of scope: Python stays on the 3.12 line, ETHOS stays at the bound release, and no tool without an admissible newer release moves.
