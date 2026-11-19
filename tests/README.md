# Publication-input checks

[test_publication.py](test_publication.py) uses the installed Typst reader on the
actual document. Run it with `just --justfile publication/justfile test` from the
repository root. That task renders all declared figures before checking the
document, including in a checkout containing only source. It requires the
publication's headless browser; see [supply](../publication/README.md#supply-and-reproduction).

The checks read every document fact from one evaluation of the book, run beside
the one compile of the PDF, and each view of the PDF once. That evaluation is
one layout of the book, and each check must spend less than half of its CPU
time: a check that lays out the book again fails the run. A fact that fails to
evaluate fails every check, with Typst's message pointing at it.

The checks compare visible attribution, PDF Info and XMP to contextual edition
metadata, including title, subject, author, keywords, language and date.
They require native manuscript content,
resolve the complete declared diagram set with alternative descriptions, and
reject private host paths in portable inputs. Navigation checks require the
contents to list all thirty chapters and four practice modules, the epilogue, the afterword and four appendices in
reading order, each layer's opening chapter to carry its number, the practice
chapters to name exercise cases that exist, the hook settings and skill printed in the
tools chapter to equal the exercise files, the printed hook script to pass on
the fixed export and fail on the old one, and the back matter to state the
book's sources and limits. They use Python's standard library and require no
new test environment or model service.

This is not a full editorial or visual acceptance suite. Migration comparison,
PDF text and metadata checks, every-page inspection and reader review have
different scopes; follow [edition acceptance](../docs/publication-acceptance.md).
The [exercise regression](../exercises/README.md#export-regression) deliberately
includes a failing old-function control and is not silently changed to pass.

## Native raster replay

[test_diagram_replay.py](test_diagram_replay.py) runs the actual Just `diagram`
task in a temporary fixture using the real headless browser. Two renders must
equal a same-input software-rasterized reference produced through Mermaid's
supported launch configuration. The test checks PNG identity and dimensions,
not source strings or a fixed historical image digest. Each subprocess has a
60-second deadline; the fixture is removed even on assertion failure.

This guards the task's raster selection and observed repeated bytes on the
current host. It does not prove cross-machine rendering or replaces visual review of
a successor edition; no personal browser profile or reader PDF is changed.

## Companion contracts

[test_exercises.py](test_exercises.py) runs the documented synthetic exercises
through existing DuckDB, Python 3.12, ast-grep and oasdiff installations. Run
`just --justfile publication/justfile exercises` for this subset without a PDF
build or browser. The normal `test` and `check` tasks discover these checks too.
Missing executors fail the checks; the task does not install or skip them.

The checks compare complete CSV headers, rows, NULL fields and ordering; require
the accepted cutoff values and 4/6 coverage; retain the old export's specific
failure alongside the corrected and empty-input controls; and verify structural
search and both changed and unchanged API comparisons. An arbitrary nonzero
exit is not accepted as the intended failure. Commands use only synthetic local
inputs, disable OpenAPI external references, start no service and create no
database file. Each subprocess has a 60-second deadline.

Passing these known cases demonstrates repeatability of the teaching examples,
not independent reader learning, production root cause or investment validity.

## Bound-input task regression

[test_typst_replay.py](test_typst_replay.py) executes the actual Just task with
synthetic bound files and the installed Typst compiler. A valid fixture must
produce readable PDF text. Missing or altered required bytes must refuse before
replacing a preserved candidate. The temporary fixture is removed by unittest;
the publication's actual supply and reader PDF are not changed.

A hosted-environment regression reads the CUE-owned Typst setting and invokes
the native `pdf` task with synthetic inputs and the pinned compiler. Compilation
must produce a PDF; projection checks separately require the hosted YAML to
match that CUE owner. This guards the boolean environment value that previously
stopped the macOS job before compilation.

These checks protect the checksum prerequisite and its observable effects, not
the completeness, rights or security of the real input closure. The separate
same-host offline replay qualifies that specific closure; second-machine and
complete locked-supply acceptance remain distinct.
