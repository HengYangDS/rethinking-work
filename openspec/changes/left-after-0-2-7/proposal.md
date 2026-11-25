## Why

Three items were left out of 0.2.7 because the book's text was bound to the whole-book reading: the transfer cases
were English points without questions, `book/README.md` and `book/parts/README.md` described appendices and parts the
book no longer has, and the changelog's count of the third sample's 92 reader notes left out three of them. The owner
said 「开始做」 on 2026-11-26 05:34.

## What Changes

- `exercises/assessment/transfer-cases.zh.md` replaces `transfer-cases.json`: three Chinese questions, each changing one
  condition of an exercise or section, with their points after all three. Appendix A, chapter 11's table, the pack's
  `AGENTS.md` and `README.md`, and the pack test name the new file.
- `book/README.md` names the four appendices; `book/parts/README.md` puts orchestration and evaluation in the fourth
  part and names the chapters that end with a hands-on section.
- 0.2.7's changelog entry counts the 3 notes left after the editor's check.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

None; no behavior a test holds is added.

## Impact

`book/back-matter.typ`, `book/parts/context.typ`, the two book READMEs, `exercises/`, `tests/test_exercises.py`,
`CHANGELOG.md`.
