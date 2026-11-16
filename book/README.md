# Book

This directory owns what the reader learns, in the order the reader encounters
it. Presentation lives in [publication](../publication/README.md).

- [main.typ](main.typ) is the sole document entrypoint. It applies the publisher
  package and edition metadata before including the manuscript.
- [metadata.typ](metadata.typ) owns title, subtitle, author, editorial date and
  keywords. Front matter and PDF metadata consume it.
- [manuscript.typ](manuscript.typ) owns reading order, not duplicate prose.
- [front-matter.typ](front-matter.typ) contains the cover, preface and contents.
- [parts](parts/README.md) contains one module per chapter.
- [back-matter.typ](back-matter.typ) owns the companion-exercise index and the
  statement of sources, rewritten cases and the author's open positions.

Change a subject in its module. Change the ordering only when the argument
requires it. Preserve labels used by cross-references and check the complete
rendered navigation after moving a chapter.
