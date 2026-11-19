# Tasks

Scope: the proof profile's test gates, one new test, the archive test's environment for the reader's command, pytest's file pattern, and the contributor notes on the tests. New scope enters as a task here before it is worked. Measurements run under host tickets through the gates' own commands. Numbers and the ledger are in the Change's local evidence, `build/evidence/single-test-run/`.

## 1. Gate composition

- [x] 1.1 Remove the `publication-inputs` gate from the proof profile and add its dimension to `source-behavior`. ETHOS resolves the profile to 11 gates with no gap and names only `publication-inputs` as a changed obligation. Done 2026-11-19 22:3x (`policy-resolution.log`).
- [x] 1.2 Restate the reason for the `source-behavior` timeout for a single test gate, keeping 180 s.

## 2. Standard-library rule

- [x] 2.1 Add a test that fails when a file under `tests/` or `exercises/cases/` imports a module that is neither in the standard library nor beside it. It passes on the lane. On a copy seeded with `import pytest` in a test and `import pygments` in an exercise case, it fails and names both (shown, not kept). Done 2026-11-19 22:3x under unittest and under locked pytest (`standard-library-*.log`).
- [x] 2.2 Run the reader's exercise command in the archive test outside the locked environment. On a copy seeded with a run-time import of `pygments` in an exercise case, the archive test fails under locked pytest, and the same test at `254958f` passes (shown, not kept). Done 2026-11-19 23:05 (`reader-environment-seeded.log`).
- [x] 2.3 Give pytest unittest discovery's file pattern, `test*.py`, so that the proof takes every file that `just test` takes.

## 3. Documentation

- [x] 3.1 Update the contributor notes on the tests and the proof, and add a CHANGELOG entry under `[Unreleased]`.

## 4. Qualification

- [x] 4.1 In one host ticket, measure the two test-gate commands of `254958f` and the lane's `test-proof`, two interleaved runs each. All tests pass in every run, and the lane's run takes no longer than the base's `test-proof`, beyond run-to-run noise. Done 2026-11-19 23:58 (`measure-1/`): base `test` 21.8 and 17.9 s, base `test-proof` 18.4 and 22.1 s, lane `test-proof` 19.0 and 18.9 s; every run passes.
- [ ] 4.2 The full proof passes on the lane head with one test gate. Its gate timeline is compared with the proof of `254958f`, whose gates finished after 71.1 s.
