# Book

This directory owns what the reader learns, in the order the reader encounters
it. Presentation lives in [publication](../publication/README.md); facts and
qualifications stay here with the argument they support.

- [main.typ](main.typ) is the sole document entrypoint. It applies the publisher
  package and edition metadata before including the manuscript.
- [metadata.typ](metadata.typ) owns title, subtitle, author, editorial date and
  keywords. Front matter and PDF metadata consume it.
- [manuscript.typ](manuscript.typ) owns reading order, not duplicate prose.
- [front-matter.typ](front-matter.typ) contains the cover, opening argument,
  reading routes and contents.
- [parts](parts/README.md) contains the coherent subject modules.
- [back-matter.typ](back-matter.typ) owns reader references, dated case
  qualifications, official entrypoints and the companion-exercise route.

Change a subject in its module. Change the ordering only when the argument or
reader task requires it, not to balance source-file lengths. Preserve labels
used by page references and check the complete rendered navigation after moving
a section. A source split is not an editorial improvement by itself.
