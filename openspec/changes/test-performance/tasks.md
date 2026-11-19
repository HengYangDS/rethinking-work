# Tasks

Scope: the publication tests, the publication task file, the proof profile's test-gate timeouts and their contributor notes. New scope enters as a task here before it is worked. Measurements run under host tickets through the gates' own commands; numbers and the ledger of every attempt are in the Change's local evidence `build/evidence/test-performance/`.

## 1. Baseline

- [x] 1.1 Measure both test gates on `52437dc` in one host ticket, per test and per phase (`baseline-2/`). Done 2026-11-19 14:09: `publication-inputs` 120.1 s, `source-behavior` 137.2 s, 37 tests pass; the document checks took 102.9 s and 119.0 s of them.

## 2. Document checks

- [x] 2.1 Read every document fact from one evaluation of the book, run beside the one compile of the PDF; every check passes and both gates are re-measured (`after-1/`). Done 2026-11-19 14:10, two runs: `publication-inputs` 23.9 and 18.6 s, `source-behavior` 23.1 and 20.6 s; the document checks 8.5 and 5.8 s, and 6.5 and 6.3 s.
- [x] 2.2 Read each view of the built PDF once, all at the same time in the setup, a failed read failing only the checks that use it; re-measured (`interleaved-1/`) and kept only if the gain exceeds run-to-run noise. Done 2026-11-19 15:45, three interleaved rounds of `publication-inputs`: 22.1 ± 2.4 → 20.0 ± 1.9 s, the document checks lower in every round (7.3, 7.5, 6.0 → 5.3, 4.6, 4.4 s); kept also because the budget in 4.1 needs the checks free of subprocess work.

## 3. Prerequisites

- [x] 3.1 Render the six diagrams concurrently through the task file; re-measured and kept only if the gain exceeds run-to-run noise and the rendered bytes are unchanged. Done 2026-11-19 15:45: `publication-inputs` 20.0 ± 1.9 → 15.3 ± 0.9 s, the time before the first test lower in every round (7.1, 8.0, 6.2 → 4.0, 2.6, 3.5 s); the six PNGs are byte-identical to the sequential renders.

## 4. Budget

- [x] 4.1 Make each document check fail when it spends half of one layout's CPU time measured in the same run; a check made to lay out the book once more fails in both test runners on this host (shown, not kept). Done 2026-11-19: the wall-time version at full width (`budget-1/`, 15:46) and, after review, the CPU-time version in light runs with one Typst worker (17:5x): the lane's checks pass under unittest and pytest with coverage, and the seeded extra layout fails both (5.0 s against a bound of 2.9 s; 5.8 s against 3.3 s).
- [x] 4.2 Lower the test gates' `timeout_seconds` to bounds taken from the new local and hosted measurements, each with its reason beside it. Done 2026-11-19: both 180 s, against 15–17 s locally on the 0.2.1 base; hosted proofs took up to twice the local time, and once more than twice for `publication-inputs` (over 300 s against 142 s at `4b76625`).
- [x] 4.3 Update the contributor notes on the tests and add a CHANGELOG entry under `[Unreleased]`.

## 5. Edition archive

- [ ] 5.1 Build the edition archive as a reproducible `rethinking-work-<version>.tgz` (sorted entries, no owner, no extended attributes, no gzip timestamp); the archive test reads it with `tarfile`, keeps every layout, checksum, note, reproducibility and exercise check, and checks UTF-8 pax names and the absence of a host user; both forges' CI files are regenerated from the CUE source; the publication notes and CHANGELOG follow.

## 6. Qualification

- [ ] 6.1 `just --justfile publication/justfile check` passes in the lane, and the full proof passes on the lane head; the ledger gives before and after per test for both gates (`per-test.md`: on the 0.2.1 base `publication-inputs` 117.2 → 17.0 and 15.4 s, `source-behavior` 134.9 → 16.4 and 16.8 s, 37 tests pass).
