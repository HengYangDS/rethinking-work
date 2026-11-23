## Why

Every reference to a chapter, a practice or an appendix was written by hand: 441 of them as 「第X章」, 86 as a number in
a table, 63 as 「附录 X」, 「练X」 or a relative 上一章 and 下一章. When chapter 29 was inserted on 2026-11-22, two chapters
were renumbered and eight written references were changed by hand; a missed one would have pointed at the wrong
chapter, and no check would have seen it. The quality-system design of 2026-11-21 named this layer (L0, derive what is
declared once), and the owner's plan of 2026-11-23 14:1x (「按规划继续推进」) puts it next.

## What Changes

- A requirement declares that the manuscript derives every reference by number from the number the chapter's opening
  declares, and that a relative reference points at the adjacent chapter in the manuscript's order.
- The layout gains `chapref(<label>)`, which writes 第X章, 练X or 附录 X from the opening's declared number (linked, or
  plain with `link: false`; several targets give 第九、第十章); `chapnum(<label>)`, the number as the tables list it;
  `chapspan` and `chaprun` for a range or a list as the book writes them (第十八至二十一章, 第十、十一、十二章); and
  `relref(<label>)[上一章]`, which gives 上一章 and 下一章 their chapter while they print as before.
- Every written reference by number is replaced by them; the built PDF's text and every word's position are unchanged.
- Two rules of the book's Vale style refuse a written chapter, range, appendix or practice reference, and
  `tests/test_references.py` holds every 上一章 and 下一章 to the manuscript's order and refuses one that names no
  chapter. They fail on `d85751f` before the change, or when a reference is pointed wrongly. Markdown under
  `exercises/` names chapters by hand and stays outside this Change.
- The acceptance guide asks a reader of a shortened or reworded passage whether a replaced word is a term another
  chapter defines (the 「放行」 regression of 838730d).

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: adds "Chapter references are derived".

## Impact

`publication/layout/style.typ`, 37 files under `book/`, `.config/checks/vale/styles/book/`, `tests/test_references.py`,
`tests/README.md`, `docs/publication-acceptance.md`, `publication/acceptance/reviews.toml` and `CHANGELOG.md`. The
book's printed text does not change.
