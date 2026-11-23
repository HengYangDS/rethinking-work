## Context

See [proposal.md](proposal.md). Each chapter opening, `chapter(part, n, title, lead)`, declares its number `n` and sets
a metadata element labelled `<chapter-navigation>` on the opening page; every chapter opens on a new page. A chapter
label (`<invariants>`) is attached to the opening.

## Goals / Non-Goals

**Goals:**

- One source for each chapter's number: the opening. Every reference by number reads it.
- The printed book does not change.

**Non-Goals:**

- 本章, which needs no number.
- References in the exercise pack's Markdown (`exercises/reader-guide.zh.md`, `exercises/templates/`): Markdown cannot
  call the layout; a renumbering must update them by hand until the pack is generated from the book.

## Decisions

- The number is found by page: the `<chapter-navigation>` metadata on the page where the target label stands. A chapter
  always opens on its own page, so the page holds exactly one.
- Relative references keep their words and gain their chapter (`relref`), with the body text's colour, so that a test
  can hold them to the reading order; a 上一章 that names no chapter is refused by the same test.
- One function, `chapref`, chooses the form from the declared number: digits give 第X章 in Chinese numerals, 练X stays
  as declared, a letter gives 附录 X. The links keep the publisher's link style; a reference that was plain stays plain
  (`link: false`), so the colour of the text does not change.
- A written 「第X章」 is refused by the book's Vale style, the one place that already reads the book's wording; a string
  argument cannot hold `#chapref`, so the one lead that named a chapter became content.
- The replacement was mechanical (a script over `#link(<label>)[…]` and the plain 「第X章」), then completed by hand for
  appendix, practice, range and list forms that a fresh reader found the script had missed. Checked by comparing the
  built PDF before and after: the same `pdftotext -layout` text, 14,640 words within 0.0001 pt of their places, every
  page within 4 of 255 per colour channel at glyph edges; the link annotations grow from 663 to 692, one for each
  reference that gained its chapter.

## Risks / Trade-offs

- [A label that stands off its opening page] → `chapter-number` finds no metadata and the compile fails, naming it.
- [Two chapters on one page] → `chapter-number` reads the first marker on the page; every chapter opens a new page
  today, and a merge of two openings would need it to read the nearest marker before the label instead.
- [终 or 记 referenced by number] → `chapref` would write 附录 终; nothing references them, and a reference would need
  a branch that writes 结语 or 后记.
