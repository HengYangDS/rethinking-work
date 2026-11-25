## Why

The full proof of `7d7073d`, the release head of 0.2.6, failed its static-analysis gate on one line: a comment added to
`tests/edition.py` for the figure test runs to 102 characters, over the gate's limit of 100.

## What Changes

- The comment is rewrapped within 100 characters; nothing else changes.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

None. `.openspec.yaml` sets `skip_specs: true`.

## Impact

One comment in `tests/edition.py`.
