# Publication-input checks

[test_publication.py](test_publication.py) checks the edition's identity, inputs,
navigation and printed commands, and [test_layout.py](test_layout.py) how it is
set: lines, paragraphs, tables, sample boxes and code. Both use the installed
Typst reader on the actual document through [edition.py](edition.py), which
builds it once per test process. Run them with `just --justfile publication/justfile test` from the
repository root. The figures are drawn in that same build, so a checkout
containing only source needs no earlier build.
The proof runs them through the gate that
[the proof profile](../.ethos/profile.toml) declares; see also
[standard library only](#standard-library-only).

The checks read every document fact from one evaluation of the book, run beside
the one compile of the PDF, and each view of the PDF once. That evaluation is
one layout of the book, and each check must spend less than half of its CPU
time: a check that lays out the book again fails the run. Every tool they run
has the deadline that `QUIET` in `edition.py` declares. A fact that fails to
evaluate fails every check, with Typst's message pointing at it.

The checks compare visible attribution, PDF Info and XMP to contextual edition
metadata, including title, subject, author, keywords, language and date.
They require native manuscript content
and every diagram in `diagrams/` drawn once, by a figure with an alternative
text, and reject private host paths in portable inputs. Navigation checks require the
contents to list every chapter in reading order, the chapters to follow the parts that `book/manuscript.typ` declares
(numbered chapters without a gap, each part's chapters together, a practice closing its part, appendices from A), the
practice chapters to name exercise cases that exist, the hook settings and skill printed in the
tools chapter to equal the exercise files, the printed hook script to pass on
the fixed export and fail on the old one, and the back matter to state the
book's sources and limits. A layout check requires that the page before a table
or a sample box is short by no more than a whole block allows, leaving out the
pages that the manuscript ends on purpose. A check of the printed shell blocks
requires what a reader's pasting needs: no word beginning with `#` outside
quotes and here-documents, a wait after a line that starts a background
process, and a removal command after each registered scheduled job. They
require no new test environment or model service, and import only what
[standard library only](#standard-library-only) allows.

[test_references.py](test_references.py) holds the relative chapter references,
上一章 and 下一章, to the manuscript's order; references by number are derived in
the layout and need no check.
[test_acceptance.py](test_acceptance.py) fails a head whose book text,
exercises or reader notes no recorded review covers; the records and their format are in
[reviews.toml](../publication/acceptance/reviews.toml).

This is not a full editorial or visual acceptance suite. Migration comparison,
PDF text and metadata checks, every-page inspection and reader review have
different scopes; follow [edition acceptance](../docs/publication-acceptance.md).
The [exercise regression](../exercises/cases/export-regression/) deliberately
includes a failing old-function control and is not silently changed to pass.

## Companion contracts

[test_exercises.py](test_exercises.py) runs the documented synthetic exercises
through existing DuckDB, Python, ast-grep and oasdiff installations. Run
`just --justfile publication/justfile exercises` for this subset without a PDF
build. The normal `test` and `check` tasks discover these checks too.
Missing executors fail the checks; the task does not install or skip them.

The checks compare complete CSV headers, rows, NULL fields and ordering; require
the accepted cutoff values and 4/6 coverage; retain the old export's specific
failure alongside the corrected and empty-input controls; and verify structural
search and both changed and unchanged API comparisons. An arbitrary nonzero
exit is not accepted as the intended failure. Commands use only synthetic local
inputs, disable OpenAPI external references, start no service and create no
database file. Each subprocess has a one-minute deadline, which the file names
itself because it ships alone in the practice pack.

Passing these known cases demonstrates repeatability of the teaching examples,
not independent reader learning, production root cause or investment validity.

## Standard library only

[test_standard_library.py](test_standard_library.py) reads the imports of every
Python file under `tests/` and `exercises/cases/`. Each must name a module of
Python's standard library or a module in the importing file's own directory.
The proof runs the tests in the locked test environment, where pytest and its
plugins can be imported, while readers run the exercise contracts with a plain
Python. A module named at run time is not read here. The archive test covers
that case: it runs the reader's exercise command in the extracted edition with
the locked environment removed from `PATH`, so the contracts run under the
host's Python as they do for a reader. `exercises/templates/` is outside both
checks: readers run those files with tools they install for the purpose, and no
test runs them.
