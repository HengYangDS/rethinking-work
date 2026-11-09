# Publication-input checks

[test_publication.py](test_publication.py) uses the installed Typst reader on the
actual document. Run it with `just --justfile publication/justfile test` from the
repository root. That task renders all declared figures before checking the
document, including in a checkout containing only source. It requires the
publication's headless browser; see [supply](../publication/README.md#supply-and-reproduction).

The checks compare visible attribution, PDF Info and XMP to contextual edition
metadata, including title, subject, author, keywords, language and date.
They require native manuscript content,
resolve the complete declared diagram set with alternative descriptions, and
reject private host paths in portable inputs. A focused case-reference check requires clickable destinations to the original dated qualification records. They use Python's standard library
and require no new test environment or model service.

This is not a full editorial or visual acceptance suite. Migration comparison,
PDF text and metadata checks, every-page inspection and reader review have
different scopes; follow [edition acceptance](../docs/publication-acceptance.md).
The [exercise regression](../exercises/README.md#export-regression) deliberately
includes a failing old-function control and is not silently changed to pass.

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

These checks protect the checksum prerequisite and its observable effects, not
the completeness, rights or security of the real input closure. The separate
same-host offline replay qualifies that specific closure; second-machine and
complete locked-supply acceptance remain distinct.
