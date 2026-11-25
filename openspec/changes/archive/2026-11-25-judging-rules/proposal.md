## Why

The calibration of 2026-11-25 settled how the error-rate sample counts and reads (the owner's delegation at 17:53; the
commands reviewer's answers of 18:17). The acceptance document still says only that a two-point judgement goes to a
second reader and "the stricter figure decides"; it does not say whether a reader's note counts, who the second judge
may be, or how the rows of CY/T 266 are read where they leave a case open. Those readings lived in hand-written briefs,
and one such brief filed a contradiction under the wrong row. The commands reviewer now generates the readers' and
judges' briefs from this document at the commit being read, so the readings need one home here.

## What Changes

- The error-rate section states the two counting rules: a note a judge finds to be an error counts as a listed error;
  every two-point error or note goes to a second, blind judge whatever the first found, neither judge from the
  raising family, and it counts when either finds an error, at the higher figure.
- A subsection, "How a judgement reads the book", states the calibrated readings, each with the clause it rests on, and
  that whether a place counts is separate from whether it is corrected (owner, 18:30). Its title is fixed: the brief
  generator selects it by title and refuses to run without it.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: the error-rate scenario names the counting rules and the declared readings.

## Impact

`docs/publication-acceptance.md` only. The book's text and the build are unchanged.
