## Why

The error-rate sample of the repaired edition (2026-11-21, read by the reader-run session from the PDF of `943c183`)
passed the bar the owner set for 0.2.4 (「先抽测」): 8.5 points over 105,823 characters, 0.80 per 10,000 against a limit
of 1. A sample stands for the whole book, so every error it found is corrected, and each one's kind is looked for in
the rest of the book. The copy-safety findings of the same sample are in the Change `copyable-commands`.

## What Changes

- Figure 6 and its description say 「问题尚未成形」 and 「先看难的样品」, as chapter 15 does.
- Chapter 18 says that `--no-agent` stops Hermes from calling its own agent, not that the task calls no model.
- Chapter 14 names `hindsight memory retain` as the command whose response carries `is_async`.
- A practice card's title is set by one layout function that keeps it with the items under it.
- An ordinal takes 「、」, a direct question after 「问一句：」 ends with 「？」, and the status value `missed` is in code type.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

None. `.openspec.yaml` sets `skip_specs: true`.

## Impact

`diagrams/collaboration.mmd`, `publication/layout/style.typ` and seven chapter files. Pages after the first changed page
may move.
