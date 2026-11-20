# Proposal

## Why

After 0.2.3 was released on 2026-11-20, the book's statements about how the hosts behave were checked further: the vendor's documentation was read in full, the two statements that rested on documentation alone were run on Claude Code 2.1.311 (the book's version) and 2.1.329, the final text was run again as a reader runs it, and the two observations that rested on one run each were run three more times. Several statements are narrower or wider than these runs show, and a reader meets a few prompts and side effects the book does not mention. The owner asked on 2026-11-21 for the next edition to go ahead without waiting for his reading (「我先不通读给意见，你自行往下推进新版」).

Evidence: `build/evidence/reader-run-corrections/starting-mode-docs/`, `paid-checks-20261120/`, `windows-unpack/`; `build/evidence/reader-run-0.2.3/` (its `REPORT.md` and `rerun-20261121/`); `build/evidence/reader-run-0.2.2/REPORT.md` (the items it did not take up).

## What Changes

- The starting permission mode is stated as the vendor documents it, with its conditions, in chapter 10, chapter 13 and appendix D.
- Chapter 13 states what `acceptEdits` lets through as the runs show it: output redirection into the working directory passes without a prompt, and `sed` asks when it edits a file in place on macOS.
- Appendix D records the runs behind the two statements that rested on documentation, and drops "documentation only" for them.
- Chapter 14 describes what the second recall may return instead of one outcome.
- Chapter 12 and appendix D describe the hook's report as the runs show it: most reports attribute the test failure to the hook, one said the hook did not seem to fire.
- The reader is told of the prompts and side effects the reader runs met: the LSP plugin offer when a session is continued, the first-launch screens on a new home, a second Ollama install, `none.duckdb` in the working directory.
- The two pages left short before a chapter's closing lines are looked at again after these changes; letting the closing block break was tried and left two stranded lines, so the pages stay as they are (`build/evidence/next-edition-corrections/pages-looked-at/`).

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: a statement about how a host or tool behaves SHALL name what it rests on: the version and the runs, or the vendor's documentation.

## Impact

Affected: `book/parts/first.typ`, `book/parts/boundaries.typ`, `book/parts/memory.typ`, `book/back-matter.typ`, and other chapters where a side effect is mentioned; `CHANGELOG.md`. No code, no check and no exercise changes are expected.
