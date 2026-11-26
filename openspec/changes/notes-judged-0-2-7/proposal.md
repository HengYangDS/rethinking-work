## Why

The owner chose 「判 1」 on 2026-11-26 11:34: the notes that no judge had seen in 0.2.7's sample and read-through were
judged blind by the other model family. The sample's 100 gave no error, so its 0.47 per 10,000 stands; the
read-through's 54 Claude notes gave four (`build/evidence/error-rate-sample/notes-judging/README.md`). They stand at
`v0.2.7`, and `docs/publication-acceptance.md` asks for every judged error to be corrected.

## What Changes

- `book/parts/boundaries.typ`: the outer circle's deletions, sending and credential reads are 「往往无法撤回」, since the
  next paragraph shows file edits that can be undone.
- `book/back-matter.typ`, appendix C, Hermes: only a script task's output is reported by its script.
- `book/parts/talent.typ`: the evidence list keeps delegation and acceptance records apart from acceptance
  conclusions, and the senior crossing's prediction, its proof and the direct use of the conclusion hold in one
  instance.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

None; wording only, so `.openspec.yaml` sets `skip_specs: true`.

## Impact

Three files under `book/`; 197 pages, every chapter on its pages.
