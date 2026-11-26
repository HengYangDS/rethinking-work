# Tasks

## 1. Hold the baseline as CI reads it

- [x] 1.1 The test reads the last release from the head's history by tagger date, requires an offset on `read`, and
      holds the latest covering review; done when it fails with `v0.2.6`, with `v0.2.3` and with a time without
      offset recorded for `f609d1c`, and passes in UTC, Asia/Shanghai and America/Los_Angeles.
- [x] 1.2 The acceptance document and the specification say what the test reads; done when `openspec validate --strict`
      passes.
