## Why

The full proof of `5d3f16f` failed its static analysis: the copy-safety test added in `copyable-commands` has three
lines over the fleet's 100-character limit and assigns a lambda to a name (ruff E501, E731). The base passed the same
check; the test was checked before commit with the checker's defaults, not the gate's own arguments.

## What Changes

- The test's docstring and comment wrap within 100 characters, and its normalising function becomes a `def`.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

None. `.openspec.yaml` sets `skip_specs: true`.

## Impact

`tests/test_publication.py` only; no behaviour changes.
