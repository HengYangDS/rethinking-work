## Why

The owner asked for quality to be held by the repository, systematically and from its root (「要制度性系统性地，上位本质地解决
问题」, 2026-11-21 17:05–17:08), and started this work on 2026-11-22 (「开始」, 10:31). The accepted requirement "Versioned
release" speaks of a qualified edition but declares no qualification, so before 0.2.4 a release recommendation rested on a
rule kept only in an agent's memory. The faults that 0.2.4's reviews found late were of kinds no check read: printed
commands that broke when copied from the PDF, a glyph set in a font outside the declared supply, single characters left
alone on a line. The repair of the copy fault is already a requirement; the others are not.

## What Changes

- A requirement declares what qualifies an edition before its release is approved: readers who did not edit a passage
  read it under 信、达、雅 as chapter 24 states them; a sentence-level cold read covers the whole book, and passages
  changed after it are read again; the prose beside each printed command is compared with the run records, and each
  command prints whole in the PDF; every page of the built PDF is looked at; and a sample of the final text meets the
  national error-rate bar.
- A requirement declares what the typeset output holds to: only the fonts the toolchain declares, a compile without
  warnings, and no body paragraph that ends with a single character alone on its last line.
- Tests check the second requirement against the built PDF; the font and paragraph checks fail on today's layout before
  it is repaired, and the warning check fails on a scratch copy given a warning.
- The layout is repaired: Typst's own Libertinus Serif, the one face that draws ℹ in a printed output, is declared as
  the code fallback in the toolchain, the publication README and the notices; line breaking weighs against a runt, so
  no body paragraph ends with one character alone.
- The acceptance guide states the 信、达、雅 definition every review cites, how printed commands and the prose beside
  them are checked, and the error-rate sample as it was run for 0.2.4.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: adds "Qualified edition" and "Typeset output keeps to its declared supply".

## Impact

`openspec/specs/publication-source/spec.md` (through this Change), `tests/test_publication.py`,
`publication/layout/style.typ`, `docs/publication-acceptance.md`, `publication/supply/toolchain.json`,
`publication/README.md` and `publication/rights/third-party-notices.md`. The book's sentences do not change.
