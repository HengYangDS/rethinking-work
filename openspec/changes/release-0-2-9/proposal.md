## Why

The owner agreed to release 0.2.9 (「同意发布 0.2.9」, 2026-11-27) and chose how it qualifies after its second sample failed:
read every body page no sample of 0.2.9 had read, correct what that reading counts, then sample again from the whole
body (「1 先通读再抽样」, 2026-11-27). The read-through's corrections, the changed sampling rule and the third sample are in
`sample-a2cb5fc-corrections`, archived before this Change. The third sample, drawn from pp. 115–165 of `cb1b09c`, found
0.31 errors per 10,000 characters as its judges decided, under the bar of 1; every passage changed after it was re-read
by two families, and the last re-read counted none. `dev` holds, besides, the work since 0.2.8: the book's standard of
Chinese prose as a repository skill and every chapter revised to it; the errors the first sample of `b59ab28` and a
third judge family counted there, corrected with their kinds; chapter and part numbers derived from the reading order;
the toolchain, layout and supply each declared once; the review record held to its fields; and the specification in nine
capabilities.

## What Changes

- `VERSION` becomes 0.2.9, a patch release: the changes revise and correct the text and declare its facts once; the
  two skills are guidance for the agents that edit the book, not a capability of the edition.
- The Changelog's Unreleased entries move under `[0.2.9]` dated 2026-11-28, the day the tag is made; the edition's date
  comes from the tag.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

None. `.openspec.yaml` sets `skip_specs: true`.

## Impact

`VERSION`, `CHANGELOG.md`, the release record in `publication/acceptance/reviews.toml`, and three wordings in
`book/parts/` (`knowing.typ`, `agent.typ`, `talent.typ`) that the layout checks need. The release itself follows
the archived head as `docs/publication-acceptance.md` ("Release") describes, and is recorded by Git, the tag and the
forges.
