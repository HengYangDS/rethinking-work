## Context

See [proposal.md](proposal.md). The answers and their evidence are in
`build/evidence/error-rate-sample/next-0.2.7/calibration-answers.md`; the subsection's draft came from the commands
reviewer (`judging-rules-proposal.md` beside it), who tested its generator on f6a6110's document with and without the
subsection.

## Goals / Non-Goals

**Goals:**

- One written source in `docs/publication-acceptance.md` for how the sample counts and how a judge reads a row.

**Non-Goals:**

- Correcting the book's places the calibration named; that is separate work in this lane.
- A prose check for the question-mark reading; whether one is worth adding is decided after the four places are fixed.

## Decisions

- The draft is taken as written, with one sentence added from answer 6: where a quotation could be read both as words
  asked and as a name, the word that introduces it decides.
- "The stricter figure decides" becomes the stated rule: either judge finding an error counts it, at the higher figure.

## Risks / Trade-offs

- Readings settled without a clause in the standard are marked as the reviewer's own reading in the evidence; a later
  calibration may change them, and a sample is read against the document at its own commit.
