## Context

See [proposal.md](proposal.md). Measured on `6726521` (2026-11-23 10:3x, `pdftotext -bbox-layout` of a `--jobs 2`
build): Noto Serif CJK sets every ideograph one em wide, so in a justified line the width of a run of ideographs, or the
gap between two words that meet at ideographs, gives the space that justification added between characters. Pure
Chinese lines add at most a few hundredths of a point. Lines holding a Latin word or a command add more: 16 lines add
0.2 pt or more, 11 add more than 0.05 em (0.525 pt at the body size), and the widest adds 1.43 pt. Typst 0.15's
`par.justification-limits` bounds the stretch of word spaces and of tracking; it does not stop a line that has no other
room from opening its Chinese characters, and Typst's text costs weigh runts, widows and orphans, not stretch.

## Goals / Non-Goals

**Goals:**

- The opening of justified body lines is decidable from the built PDF, against a bound the layout declares, and a test
  holds it over the whole book.
- Each repair keeps its paragraph's meaning; a reader who did not write it reads every changed sentence.

**Non-Goals:**

- Word spaces around Latin text, which Typst stretches within its own declared limits.
- Text other than the body text: code keeps its spaces, and tables, sample boxes and short notes are set ragged.

## Decisions

- The bound is 0.05 em. Read at 150 dpi, lines opened by 0.06 em or more look spaced against their neighbours, and lines
  under 0.03 em do not; the bound sits between them, and it is a value the layout can change in one place.
- Body text is told by its size, the layout's `body-size`; a word of another size is not measured, and a pair is
  measured only when both words are body text, so a command between two Chinese words opens nothing.
- The repair is made in the wording, not by widening Typst's limits: wider word spaces would move the gaps beside the
  Latin words, and tracking would change the texture of every line.
- Each repair adds or removes one to four characters in the line before the Latin word or command, or in the line it
  leaves short, so that the break moves; one paragraph of chapter 17 took a removal in its first line and an addition
  in its third, so that the line holding the next command stays full. After the repair the widest opening in the body
  is 0.047 em (0.49 pt), and lines between 0.04 and 0.05 em remain on pages 44, 81, 91 and 102.

## Risks / Trade-offs

- [A rewording moves other lines] → The test runs over the whole book with the lone-character and split tests, and the
  changed pages are looked at.
- [The bound is a judgement] → It is declared once with its reason; the owner may move it, and the test follows.
