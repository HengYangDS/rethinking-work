# Book

This directory owns what the reader learns, in the order the reader encounters
it. Presentation lives in [publication](../publication/README.md).

- [main.typ](main.typ) is the sole document entrypoint. It applies the publisher
  package and edition metadata before including the manuscript.
- [metadata.typ](metadata.typ) owns title, subtitle, author and keywords, and
  names the edition from the build's identity: the version's edition dated by
  its tag, or a draft named by its commit. Front matter and PDF metadata consume it.
- [manuscript.typ](manuscript.typ) owns reading order, not duplicate prose.
- [front-matter.typ](front-matter.typ) contains the cover, preface and contents.
- [parts](parts/README.md) contains one module per chapter.
- [back-matter.typ](back-matter.typ) holds the four appendices: the index of the
  companion exercises, a quick reference, the map of tools by layer, and the
  conditions of the runs the book cites with the basis of its conclusions.

Change a subject in its module. Change the ordering only when the argument
requires it. Preserve labels used by cross-references and check the complete
rendered navigation after moving a chapter.
