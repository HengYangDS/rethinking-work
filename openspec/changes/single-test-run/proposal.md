# Proposal

## Why

Each full proof runs the publication tests twice. The `publication-inputs` gate runs `just test`, which is unittest under the host's Python 3.12. The `source-behavior` gate runs `just test-proof`, which is pytest with coverage in the locked test environment. Both first render the six diagrams and then run the same 37 tests, one of which compiles the whole book. In the proof of `254958f` the two gates ran one after the other, 19.6 s and 19.4 s, and the gates finished after 71.1 s. The owner directed on 2026-11-18 that every ETHOS-governed repository be optimized for performance. On 2026-11-19 he chose to have one run serve both gates (「按方案一改」).

## What Changes

- The proof runs the publication tests once, as the `source-behavior` gate. Its native test and coverage reports also stand for the publication-input checks. The `publication-inputs` gate is removed, and its dimension moves to `source-behavior`.
- The proof no longer runs the tests under the host's plain Python. There, a missing package would have shown, even though the locked environment provides it. Two checks take that place:
  - A test reads the imports of every Python file under `tests/` and `exercises/cases/`. Each import must name the standard library or a module in the file's own directory.
  - The archive test runs the reader's exercise command outside the locked environment, under the host's Python, as a reader runs it.
- pytest takes the same test files as unittest discovery (`test*.py`), so the proof runs every file that `just test` runs.
- `just test` and `just check` remain the local way to run the same tests without the locked environment.
- Every test and assertion stays. So do the document checks' CPU-time budget and the test gate's timeout.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: the proof SHALL run the publication tests once. The tests and exercise cases SHALL import only the standard library and their own modules, and the reader's exercise command SHALL pass under the host's Python.

## Impact

Affected:

- `.ethos/profile.toml`: the gate list, plus the dimensions and timeout reason of `source-behavior`.
- `tests/`: one new test, and the archive test's environment for the reader's command.
- `.config/checks/pytest/pytest.toml`: the test file pattern.
- The contributor notes on the tests.
- The CHANGELOG.

The manuscript, PDF, edition archive, exercises, task file and CI files do not change. Both forges' CI jobs run the proof that the profile declares, so they drop the same gate.

Out of scope:

- The other repositories' test gates, which a separate session handles.
- ETHOS's readiness gates and its load-admission sample.
