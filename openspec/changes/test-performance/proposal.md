# Proposal

## Why

The publication checks have grown slower than the book they check. At release 0.2.0 the `publication-inputs` gate took 147.7 s and the `source-behavior` gate 165.5 s in the local proof, against 85.8 s and 83.7 s at 0.1.0; on a hosted macOS runner the `publication-inputs` gate ran past its 300 s timeout at `4b76625` (the run's verification record), so that timeout was raised to 600 s as a hang guard. Most of the time goes to laying out the whole book again for each fact a check reads. The owner directed on 2026-11-18 that every ETHOS-governed repository be optimized for performance, this one in its own lane after the 0.2.0 delivery. On 2026-11-19, relayed by the session that released 0.2.1, the owner also directed that the edition archive use `.tgz`, the format of the other governed repositories (「让所有仓库统一」); this Change carries that in a commit of its own.

## What Changes

- Read every document fact the publication checks need from one evaluation of the book, run beside the one compile of the PDF, instead of one evaluation per fact.
- Remove the other measured costs that repeat per check or per run, one change at a time, each kept only when its measurement beats run-to-run noise.
- Keep every check and its acceptance: no test is dropped, no assertion is loosened, and checks keep testing rules and structure rather than literal manuscript sentences.
- Leave a time budget that the suite enforces, so that a check which repeats the expensive work fails the run.
- Deliver the edition archive as a gzipped tar, `rethinking-work-<version>.tgz`, instead of a zip, with the same layout, notes, checksums and reproducibility, and no host user name in it. **BREAKING** for anyone who fetches the release asset by its `.zip` name.
- Lower both test gates' timeouts (`publication-inputs` from 600 s, `source-behavior` from 300 s) to a bound derived from the new measurements, with its reason stated beside each.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: source verification SHALL complete within a declared time budget, and a check that repeats the book's layout beyond that budget SHALL fail.

## Impact

The publication tests under `tests/`, the publication task file, the ETHOS proof profile's two test-gate timeouts and the contributor notes on the tests are affected. The manuscript, its rendered PDF and the companion exercises do not change; the edition archive changes format, and the publication task file, both forges' CI files, the archive test and the publication notes follow. Supply stays as locked: no new tool, package or plugin. Out of scope: the supply moves left open by the previous Change, the hosted runners' own capacity, and the proof's gate composition.
