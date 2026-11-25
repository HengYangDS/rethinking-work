# Companion exercises

Synthetic worked examples and working materials for the book 《重新理解工作》. They hold no business data and need no
credentials or model service. Readers start from the book's appendix A (随书练习), which lists each exercise with the
chapter that uses it; this file is the maintainer's reference.

## Layout

- `cases/<name>/`: one runnable example each, with its inputs, its queries or code, and its `expected-*` results.
- `cases/historical-snapshot/session/`: the agent sessions that chapter 17 reports; `control/` keeps their answers as
  returned and is never edited.
- `templates/`: the brief and checkpoint templates the book cites (`*.zh.md`) and `eval/`, a runnable evaluation
  example.
- `assessment/transfer-cases.zh.md`: transfer cases.

## Check every example

From the repository root:

```sh
just --justfile publication/justfile exercises
```

From the root of an unpacked practice pack, which has no `publication/` directory:

```sh
python3.12 -B -m unittest discover -s tests -p test_exercises.py -v
```

The check uses the installed Python 3.12, DuckDB, ast-grep and oasdiff and installs nothing. It passes only when each
example shows its stated outcome, the deliberate failures included.

## Add or change an example

Commit an example's inputs, its query or code and its `expected-*` files together. The tests read `expected-*`; no
prose, here or in the book, copies a result.
