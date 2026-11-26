# Tasks

## 1. Baseline by time

- [x] 1.1 The test names the last release by the review time and signed `v`-digit tags alone, and checks the offset in
      its own test; done when it fails with `v0.2.6`, with `v0.2.3` and with a time without offset recorded for
      `ef1b881`, and passes in UTC, Asia/Shanghai and America/Los_Angeles.
- [x] 1.2 The acceptance document, the specification and the record's header say what the test reads; done when
      `openspec validate --strict` passes.
- [x] 1.3 The third review's findings are answered: GitLab fetches every tag, a missing tag fails, releases are
      `vX.Y.Z` with a signature, records keep their reading order; done when the test fails on a recorded
      `v0.2.8-rc1` and on `ef1b881` copied with `6ef03de`'s time and baseline.
