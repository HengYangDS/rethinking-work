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
  appendix, practice, range and list forms that a fresh reader found the script had missed; a reference that was plain
  at `d85751f` stays plain (`link: false` on `chapref`, `chapspan` and `chaprun` alike). Checked by comparing the built
  PDF before and after: the same `pdftotext -layout` text, 14,640 words within 0.0001 pt of their places, every page
  within 4 of 255 per colour channel at glyph edges; the 663 link annotations are kept, and 11 are added for the ten
  `relref` words (one wraps a line).

## Risks / Trade-offs

- [A label that stands off its opening page] → `chapter-number` stops the compile with "chapref: <label> is not on a
  chapter's opening page".
- [Two chapters on one page] → `chapter-number` reads the first marker on the page; every chapter opens a new page
  today, and a merge of two openings would need it to read the nearest marker before the label instead.
- [终 or 记 referenced by number] → `chapref` would write 附录 终; nothing references them, and a reference would need
  a branch that writes 结语 or 后记.
- [A number outside 0–99, or a span or run over a practice or appendix] → `zh-number` handles 0–99, and `chapspan` and
  `chaprun` take numbered chapters only; either stops the compile (an index or digit error), never prints a wrong word.
- [Counts of chapters written in words] → 「后面八章」 (team), 「第一部共三章」 (front matter), 「共五章」 (question),
  「第二部的五章」 (growth), 「前三章」 (memory) and 上一部, 下一部 are written by hand; a change of a part's chapters must
  update them, and no check reads them.
