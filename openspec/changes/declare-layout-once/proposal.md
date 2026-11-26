## Why

The layout declares the body's size, measure, colours and faces once, but other presentation facts are written where
they are used. The Typst packages' versions stand in three imports, a test, the colophon and two documents, and the
colophon also prints Typst's version by hand. The cover and the contents set their own faces, sizes and geometry in
the manuscript's front matter, and the cover prints the English title there. A dozen type sizes in the layout and the
figures have no name, and the paper's width is written beside its name. The tests repeat layout rules (the closing and
opening marks, the pattern of a number cell, the language) and hold fixed counts; their one-minute time limit is
written twice more, and the practice-pack test cuts the draft's commit to seven characters as the archive task does.
The CI supply's two downloads repeat their options. The owner asked on 2026-11-26 that the hard-coded facts be
removed; this is the third of the three Changes that answer it.

## What Changes

- `publication/layout/packages.typ` declares the Typst packages the edition imports, each at one version; the
  entrypoint, the layout, the figures and the layout tests' specimen import them from there, and the colophon prints
  fletcher's version from it and Typst's from the compiler that runs. The supply manifest still pins each package's
  files. The publication guide and the third-party notices name the packages and fonts and point to the files that
  pin them instead of restating versions.
- The layout names its type sizes by role, gives the page's side margins as half the paper's width less half the text
  block's, declares the top and bottom margin once, and declares the language. The cover and the contents are set by
  `publication/layout/front.typ` from the declared faces and sizes; the front matter keeps their words, and
  `book/metadata.typ` declares the English title.
- The layout declares the marks that never open a line and the pattern of a number cell; the checks read them, the
  opening marks and the language from the layout instead of copying them. A check that guards against finding nothing
  asks for something found, not for a fixed count.
- The practice-pack test reads the draft's commit from the archive task's inputs; the CI supply declares its fetch
  options once. The tests' waits take their limit from the one minute that `tests/edition.py` declares; the reader's
  whole check of the pack has its longer limit named in its test, and the exercises' own test, which ships alone in
  the pack, keeps its own.

The PDF does not change: built from the same inputs, it is the same file.

Out of scope: the maintainer's local scripts outside the repository, consolidated on their own; the rules of prose;
any change of type size, face or spacing.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: "Layout rules declared once" covers the packages, type sizes, paper, language, the cover and
  contents, and the rules the checks read.

## Impact

`book/main.typ`, `book/front-matter.typ`, `book/back-matter.typ`, `book/metadata.typ`, `publication/layout/`,
`publication/justfile`, `publication/README.md`, `publication/rights/third-party-notices.md`, `tests/README.md`,
`tests/edition.py`, `tests/test_layout.py`, `tests/test_publication.py`, `tests/test_practice_pack.py`, the
specification.
