## Context

See [proposal.md](proposal.md). Measured on 2026-11-22 10:4x on the released head `d6b8e1e`: the compile prints no
warning; the PDF embeds Libertinus Serif, which the toolchain does not declare, for one glyph (ℹ, U+2139, in a printed
output of chapter 27); eight paragraphs end with a single character on their last line, and 26 lines in table cells and
sample boxes hold a single character alone.

## Goals / Non-Goals

**Goals:**

- The qualification of an edition is a declared item that a release recommendation checks, not a remembered rule.
- Each typeset fault of a decidable kind has a test that reads the built PDF and fails first.

**Non-Goals:**

- A prose gate for the Typst sources (Vale): it needs its supply on both CIs and is the next Change.
- Changing the book's sentences; loose lines beside long code; the figures' arrow placement.
- Rewriting the review briefs kept as evidence of earlier rounds; they stay as records of what was used then.

## Decisions

- The declared font set has one owner, `publication/supply/toolchain.json`; the test reads it and compares the PDF's
  embedded fonts by name, so adding a font is one edit there.
- The missing glyph keeps its face and the face is declared. Every text face that holds ℹ (Apple Symbols, STIX Two,
  Typst's Libertinus Serif) draws it as a bold serif i, so the earlier page look's "fallback font" was the symbol's own
  shape; the fault was an undeclared face. Libertinus Serif is bundled with the locked Typst like DejaVu Sans Mono, so
  declaring it changes no supply step on either CI and moves no page. A trial with Apple Color Emoji drew a coloured
  square beside a black ⚠ and was rejected.
- A lone character is a body line whose text is one Han character, with any closing punctuation, flush with the text
  block and set directly under a line that starts there too; the vertical bound is the layout's body line step and one
  unit of space, read from the layout file.
- Line breaking raises Typst's runt cost to 200%, which the line breaker of justified body text weighs against a short
  last line; 110% to 1000% gave the same layout, which ends no body paragraph with one character and changes nine
  pages. Its one cost is p.118: a paragraph whose last line was the single English word `automatically` now sets two
  lines of quoted output with wider spaces. A single English word on a last line is no fault in Chinese typesetting, but
  Typst counts it as a runt too; the trade is taken for the eight Chinese runts it removes and every later one.
- Table cells and sample boxes are not held to the rule. A trial of the optimized line breaker there removed their 26
  lone characters but balanced ragged lines, split words and once an option (`--` / `body`), and a wider column moved
  two lead-ins away from their blocks; narrow cells stay with the page review.
- The review criteria cite chapter 24, which states the owner's one definition of 信、达、雅 (shared rules of
  2026-11-21), rather than wording their own.

## Risks / Trade-offs

- [Runt costs move line breaks across the book] → The nine changed pages were looked at; the page-foot checks still
  hold.
- [A looser line on p.118] → Named here and in the Changelog; lowering the runt cost to the default restores it and
  brings back the eight runts.
