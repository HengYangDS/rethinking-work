## Why

The owner asked for the book's quality to be held by the repository, systematically and from its root (「要制度性系统性地，
上位本质地解决问题」, 2026-11-21 17:05–17:08), and asked again to go on (「继续」, 2026-11-23 12:22). The whole-book review
of 2026-11-21 decided how the book words a set of terms and which spoken words it does not use; those decisions live in
an editing brief kept as evidence, and every later reader was asked to check them by hand. No check reads the book's
Typst sources for wording or punctuation: ETHOS's own `prose` gate runs Vale on Markdown only. Measured on `8af23aa`,
one replaced term has come back (chapter 29, 「有权的人」).

## What Changes

- A requirement declares that the book's sources keep its decided wording and set full-width punctuation against
  Chinese characters where GB/T 15834 decides it, through rules held in one declared Vale style.
- The style, `book` in the repository's Vale increment `.config/checks/vale/`, holds three rules: decided replacements, avoided words, and half-width
  punctuation against a Chinese character; each rule states its source and date and carries cases that `vale test`
  runs. A sample box titled 原话 keeps a speaker's own words as said; the configuration declares it and the rules
  skip it.
- A proof gate runs the rule cases and the rules over `book/`; Vale is added to the locked toolchain, so both CIs run
  it. The rules fail on `8af23aa` before the repair.
- The book is repaired where the rules fire.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: adds "Book prose keeps its decided wording".

## Impact

`.config/checks/vale/`, `.config/mise/config.toml` and `mise.lock`, `.ethos/profile.toml`,
`publication/justfile`, `docs/publication-acceptance.md`, `docs/contributing.md`, `book/parts/talent.typ`, `book/parts/practice-doing.typ` and
`CHANGELOG.md`. No printed command, output, case date or qualification changes.
