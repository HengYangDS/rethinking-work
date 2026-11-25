## Why

The code review of 2026-11-25 (`build/evidence/repo-review-20261125/report-code.md`, items 6, 8 and 9) found tests that
pin numbers and text instead of reading the declarations: the line and paragraph steps (16 pt, 32 pt) and the type size
(10.5 pt) in the layout tests, the author, title and keyword count in the identity test (the next test already compares
the PDF with the declared identity), a link check inside the portability test, a fixed list of six exercise cases, and
a JSON block taken by its position. Two PDF-tool cases tested Homebrew's own behaviour. Each PDF read started Homebrew
again, about a second each.

## What Changes

- The layout tests read the body's size and baseline from `style.typ`.
- The identity test keeps the date's form; the portability test keeps portability; the practice test walks
  `exercises/cases/`; the hook test finds its JSON block by content.
- The PDF-tool test keeps the case of paths with spaces; the shadowed-tool and missing-declaration cases go.
- The declared Poppler executables are resolved once through `pdf-tool` and then run directly.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: checks read the layout's declared measure rather than their own copies of it.

## Impact

`tests/edition.py`, `tests/test_layout.py`, `tests/test_publication.py`, `tests/test_pdf_tools.py`.
