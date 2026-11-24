## Why

The owner asked for 0.2.6 once the layout lane is landed (「落地后发 0.2.6」, 2026-11-24 09:13) and allowed a Codex
batch for its error-rate sample (「同意，但用 codex 花钱也可以，claude 本身也花钱」, 09:30). `dev` at `80710fe` holds the
layout repairs (Change `layout-faults`): lead-ins kept with their blocks and spaced as paragraphs, cards and code split
with the least part, floating figures, 198 pages with every chapter on 0.2.5's pages. The sample read pages 11–61 of
its PDF, apart from 0.2.5's sample, with the cover and contents, by two model families each judging the other blind:
105,823 characters, 0.02 errors per 10,000 against a limit of 1. Its errors are corrected here before the version is
set.

## What Changes

- The sample's two counted errors are corrected: the full stop of a quoted brief moves inside its closing quotation
  mark (chapter 9), and a computed percentage is written 「94%」 (chapter 11). A fresh reader's search of the book found
  the same kinds in practice 4 (「……催办。”」) and chapter 29 (「约 70%」「72%」), corrected with them, and chapter 10's
  brief now ends with a full stop like the book's other briefs.
- Alignment is declared in `publication/layout/style.typ`, one rule per kind of element, at the owner's word
  (「全篇中，左对齐、右对齐，居中，两端对齐等，需要明确的规范」, 2026-11-24 14:22; 「例子是个例，但道理是全局性的」,
  14:23): body justified, narrow text flush left, captions centred, and in tables a column of numbers flush right on
  its units digit (CY/T 170—2019 7.2.2.4) with every other column flush left. `tests/test_layout.py` reads each
  table's columns and holds the rule.
- `VERSION` becomes 0.2.6, a patch release: the changes correct the layout and some marks; they add no capability.
- The edition date in `book/metadata.typ` is already the release day (2026-11-24); the Changelog's Unreleased entries
  move under `[0.2.6]` with that date.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

None. `.openspec.yaml` sets `skip_specs: true`.

## Impact

Five book files, `publication/layout/style.typ`, `tests/test_layout.py`, `tests/edition.py`, `VERSION`, `CHANGELOG.md` and the review records. The release itself (tag, `main`, the releases on both
forges with the edition archive, the delivered copy) follows the archived head and is recorded by Git, the tag and the
forges.
