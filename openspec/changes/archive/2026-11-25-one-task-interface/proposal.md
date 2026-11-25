## Why

The code review of 2026-11-25 (`build/evidence/repo-review-20261125/report-code.md`, item 10, 11 and small items) found
two task entries and two test runners: five Mise tasks only called Just recipes, and `test` ran the tests with unittest
while the proof's `test-proof` ran them with pytest. `pyproject.toml` kept build tables that nothing built, the
justfile still removed a `.zip` archive that was retired, the Prettier arguments were written twice, and coverage
counted an evaluation example that no test runs.

## What Changes

- Mise keeps only `ci-supply`, the task the CI model calls; the Just recipes are the one task interface.
- `test` runs the tests as the proof does, without its reports; `exercises` keeps unittest, as readers run it.
- `pyproject.toml` loses `[build-system]` and the setuptools tables; the lock is unchanged.
- The justfile names the Prettier command once and no longer removes `.zip` archives; coverage omits
  `exercises/templates/`.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: the local test task and the proof run the tests with the same runner.

## Impact

`.config/mise/config.toml`, `pyproject.toml`, `publication/justfile`, `.config/checks/coverage/coverage.toml`.
