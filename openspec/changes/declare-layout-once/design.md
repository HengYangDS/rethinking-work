## Context

See [proposal.md](proposal.md). The layout (`publication/layout/`) owns presentation, `book/metadata.typ` the edition's
identity, the justfile the tasks and `tests/edition.py` what every check shares. Each fact below gets one carrier in
that owner; every other mention reads it.

## Goals / Non-Goals

**Goals:**

- Upgrading a Typst package changes one line of `packages.typ` and the supply manifest that pins its files; for Neat
  Book, whose notice is retained verbatim from one release, it also means checking that notice again.
- Changing a type size, a face or the paper changes the layout only; the cover, the contents and the figures follow.
- No check holds a copy of a layout rule, a count of the book's content or a length the archive task chose.

**Non-Goals:**

- Spacing, leading and stroke values that one element's function sets once, where its parameter names them. They are
  not read anywhere else; naming them would add a second place to look without removing a repetition.
- The values themselves: no size, face, spacing or margin changes, so the PDF built from the same inputs is the same
  file.

## Decisions

- **What gets a name.** A value read in more than one place, or by a check, is declared once by name in its owner. A
  value set once, beside the parameter that says what it is (`--ppi 144`, `leading: 5.5pt`), is already declared
  there. Type sizes are named although most are set once: together they are the type hierarchy, and they are set in
  three files.
- **Package versions as data.** `packages.typ` holds `package-versions` and imports each package from a specifier built
  from it, with an explicit name (Typst needs `as` for an import it cannot read before evaluation). The colophon prints
  fletcher's major and minor version from the same entry, and Typst's from `sys.version`, which is the compiler that
  set the book. The manifest `publication/supply/typst-packages.sha256` stays the lock of the files, transitive
  packages included; it is generated from a fetch and checked by `ci-supply`.
- **Sizes by role.** `type-size` maps each role a reader sees to its size: the three heading levels, the chapter's lead,
  a sample box's title, a table's body and header, a caption, small print, the chapter's navigation line, a figure's
  text and its detail, the contents, and the cover's lines. Roles that stand together as one kind share an entry (the
  navigation line and the link back to the contents; a figure's detail and an arrow's label). Roles that only happen
  to share a size keep their own, so that changing one does not move another.
- **The paper.** The side margins are `50% - text-width / 2`: Typst resolves a relative side margin against the page's
  width, so the text block stays centred on any paper without the width being written. `y` sets the top and bottom
  margin once. A specimen on A4 confirmed the text block's width.
- **Cover and contents.** `front.typ` sets them from the layout's faces and sizes; the front matter passes the words
  (the titles, the author, the tagline, the edition line) and keeps the headings and labels the book links to. The
  cover prints the English title in capitals from `book-title-en`, so the declared title reads as a title. The row
  under the preface's heading, which carries the link back to the contents, moves with them.
- **The checks read the layout.** `tests/edition.py` reads, in one evaluation that lays out nothing, what the layout
  declares for the checks: the body's size and line, the opening and closing marks, the number pattern and the
  language. The number pattern is a regular expression that Typst and Python read alike. The table check now reads
  the pattern the layout applies, so it holds how the rule is applied (the first column, a heading over its column),
  not what counts as a number; that is the layout's to say.
- **Coverage from other facts, not counts.** A fixed lower count (`> 100` steps, `> 40` tables, `> 50` blocks, `> 30`
  specimen lines) guarded against a reader that finds nothing or too little. Each guard now derives what must be found
  from another fact: the body's line and paragraph steps are measured in every part of the book; every block with a
  language is either a printed command, which the command check reads, or one of the declared languages of a file's
  content; every page of the specimen, one per kind of block, is measured. The tables come from one query, which
  cannot find part of them, so finding some suffices there.
- **The draft's commit.** The practice-pack test reads `commit=` from the archive task's `edition_inputs` in its fixture
  and requires the full commit to begin with it, instead of cutting the commit to seven characters itself.
- **Time limits.** `QUIET` carries the one-minute limit; the compile's wait reads it, and the tests' guide points to it.
  The reader's whole check of the pack runs every exercise's tools in turn; its limit of two minutes is named at the
  top of its test, its only reader.
- **Repeated invocations.** The justfile declares once what it ran in several places: the tests' command, which
  `test` and `test-proof` share, the locked test environment, which `test-env` syncs, the Brewfile, whose check
  `ci-supply` now runs through `_pdf-tools-installed`, and the options both of the supply's downloads share; each
  download keeps its own `--max-time`, set once beside the flag.

## Risks / Trade-offs

- A dynamic import hides the version from an editor's static analysis → the specifier is built from a literal in the
  same file, and a check already fails when the compile reads a package file the manifest does not pin.
- A role shared by two texts couples them → only texts that stand together as one kind share a role; the rest keep
  their own.
- A part with no measurable step, or a new language for a file's content, fails a guard that is right to stop → the
  failure names the part or the language, and the fix is one entry, not a number.
- Relative side margins assume a paper wider than the text block → the measure and the paper are both declared in the
  layout, where a change of either is reviewed on every page.
