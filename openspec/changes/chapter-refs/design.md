## Context

See [proposal.md](proposal.md). Each chapter opening, `chapter(part, n, title, lead)`, declares its number `n` and sets
a metadata element labelled `<chapter-navigation>` on the opening page; every chapter opens on a new page. A chapter
label (`<invariants>`) is attached to the opening.

## Goals / Non-Goals

**Goals:**

- One source for each chapter's number: the opening. Every reference by number reads it.
- The printed book does not change.

**Non-Goals:**

- Relative references (上一章, 下一章): they are written words, held by a test instead of derived.
- 本章, which needs no number.

## Decisions

- The number is found by page: the `<chapter-navigation>` metadata on the page where the target label stands. A chapter
  always opens on its own page, so the page holds exactly one.
- One function, `chapref`, chooses the form from the declared number: digits give 第X章 in Chinese numerals, 练X stays
  as declared, a letter gives 附录 X. The links keep the publisher's link style; a reference that was plain stays plain
  (`link: false`), so the colour of the text does not change.
- A written 「第X章」 is refused by the book's Vale style, the one place that already reads the book's wording; a string
  argument cannot hold `#chapref`, so the one lead that named a chapter became content.
- The replacement was mechanical (a script over `#link(<label>)[…]` and the plain 「第X章」), checked by comparing the
  built PDF before and after: the same text, the same 663 link annotations, and no word moved by more than 0.0001 pt.

## Risks / Trade-offs

- [A label that stands off its opening page] → `chapter-number` finds no metadata and the compile fails, naming it.
- [A compound reference with a different shape] → Only 第九、第十章 occurs; any other would be refused by the rule.
