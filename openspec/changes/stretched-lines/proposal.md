## Why

After the page-fault lane landed, three justified lines of the edition were seen set letter-spaced (pages 44, 49 and 102
of `6726521`), and the owner chose to repair them in the same session (「在这里修」, 2026-11-23 10:27). Measured on
`6726521`, the class is eleven body lines whose characters are opened by more than 0.05 em: each is followed by a Latin
word, a time or a command too long for the rest of the line, so the line breaks early and justification spreads the
room between its Chinese characters. The layout's line-breaking costs do not cause it: with the runt cost at Typst's
default the same eleven lines open. No check reads character spacing, so the page review was the only guard.

## What Changes

- The typeset requirement adds that justification opens the space between two Chinese characters of the body text by
  no more than the bound the layout declares.
- The layout declares the bound, `open-most`, at 0.05 em; a test measures each body line from the PDF and fails on
  `6726521` before the repair.
- The eleven lines are repaired where they are set, by the shortest change of wording that moves the line's break and
  keeps the paragraph's meaning.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: "Typeset output keeps to its declared supply" covers the opening of justified body lines.

## Impact

`publication/layout/style.typ`, `tests/test_publication.py`, the paragraphs that hold the eleven lines in `book/parts/`,
and `CHANGELOG.md`. No printed command, output, case date or qualification changes.
