## Why

The full proof of `29e15bc` refused before running (2026-11-26 00:26): ETHOS's repository paradigm asks every repository
for the Mise toolchain verbs `bootstrap`, `check` and `fix`, which `one-task-interface` had removed on the code review's
advice. The light checks did not catch it, because no single gate reads the paradigm.

## What Changes

- `.config/mise/config.toml` has `bootstrap`, `check` and `fix` again, each calling its Just recipe; `build` and `render`
  stay removed.
- The changelog says which Mise tasks remain.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: the repository keeps the toolchain verbs its governance asks for.

## Impact

`.config/mise/config.toml`, `CHANGELOG.md`.
