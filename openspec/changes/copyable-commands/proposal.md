## Why

The book prints commands for the reader to copy from the PDF, and its layout keeps a short inline command whole for
that reason. The error-rate sample of the repaired edition (2026-11-21, the reader-run session) found that a longer
inline command breaks after `/tmp/`, so that a reader who copies the first line runs `rm -rf /tmp/`, and that a JSON
line inside a shell block wraps inside a string, so that a copied settings file is invalid. A page-by-page check of
the edition then found nine shell lines that wrap, eight inline commands split across lines, and a box limit counted
in bytes, which leaves short commands with Chinese words unprotected. The reader-run comparison had read the source,
not the copied text, so none of this was seen before.

## What Changes

- A requirement beside "Printed commands work as pasted" covers copying from the PDF: every line of a code block
  with a declared language prints whole on one line, and an inline command prints whole.
- Inline code is kept whole by its display width, not its byte length.
- The nine shell lines and eight inline commands are rewritten so that they print whole; what each command does,
  and the output printed after it, stay as they were.
- A test fails when a line of a code block with a declared language does not print whole, and names the page.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: adds "Printed commands survive copying" beside "Printed commands work as pasted".

## Impact

`book/main.typ`, six chapter files, `tests/test_publication.py`, `CHANGELOG.md` and the accepted spec. Pages after
the first changed page may move.
