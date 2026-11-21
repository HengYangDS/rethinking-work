## Why

The owner asked for a second error-rate sample after the first one's corrections (「另抽一段测」, 2026-11-21 22:32). Read by
OpenAI's model through Codex from pages 15–65 of `e618e05`'s PDF, with every candidate judged by a Claude model blind to
the first model's reasons, it passed: 4.5 points over 105,823 characters, 0.43 per 10,000 against a limit of 1. Its seven
agreed errors are corrected before the release, with their kind looked for across the book.

## What Changes

- Chapter 4 names the first of its two deviations as a behaviour, as it does the second.
- Chapter 5 states the limit of ingest time as the example after it shows: what was in the system is not what could be
  obtained at the time.
- Direct questions after a colon end with 「？」, percentage points beside percentages are in Arabic numerals, and a
  semicolon no longer carries a colon's scope past what it introduces.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

None. `.openspec.yaml` sets `skip_specs: true`.

## Impact

Five chapter files. Two borderline items of the sample are kept as written, with their reasons in the local evidence.
