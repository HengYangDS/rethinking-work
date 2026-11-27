## Context

See the [proposal](proposal.md). The sample's result, its counted places and its own search of their kinds are in the
sampler's evidence for `b59ab28`; the acceptance document's rule is "Correct every error found, and its kind across the
book, before the release".

## Goals / Non-Goals

Goals: each counted place and each place of the same kind in the book is corrected, with the fewest words changed.

Non-Goals:

- A new check for these kinds; whether the decidable ones become rules of the book's prose style is a separate Change.
- Places that do not count but could be worded better.

## Decisions

1. The contradiction in `roles.typ` is resolved at the exception, not at the rule: the five functions stay required,
   and a small matter keeps a light review.
2. A table cell that lists names joins them with 、; a cell that lists clauses or itemised entries keeps ；
   (GB/T 15834—2011 4.6.3.1 and 4.6.3.3). The tools column of the back matter's table is names; its other columns, the
   exercise contents and the checklist entries are not.
3. A colon inside a sentence that already has one becomes ， or 。, whichever keeps the label that opens the sentence.
4. The kind search is the sampler's own script, run over every chapter and the front and back matter; each hit is
   classed in the lane's evidence as corrected or not the kind, with its reason.

## Risks / Trade-offs

- The meaning of `roles.typ`'s sentence changes; the meaning review checks it against the chapter's rule.
- The search finds the punctuation kinds by pattern and the contradiction kind only through a list of absolute rules;
  the meaning review reads the changed passages, not the whole book.
