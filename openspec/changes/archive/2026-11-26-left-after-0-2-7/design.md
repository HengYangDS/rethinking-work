## Context

See [proposal.md](proposal.md). The decision to keep the transfer cases is in
`build/evidence/repo-review-20261125/PLAN.md` (delegated decisions): the book has cited them since 0.2.6, and the root
`AGENTS.md` declares `exercises/assessment/` for them.

## Goals / Non-Goals

**Goals:**

- Each transfer question changes a condition the book's own variants do not, and its points explain the effect, as
  `docs/publication-acceptance.md` asks of a transfer problem.

**Non-Goals:**

- A scoring rubric; appendix A says the questions are for self-checking, not assessment.

## Decisions

- Markdown in Chinese, as the templates the book cites are `*.zh.md`; questions first, points after all three, so that
  a reader answers before reading them.
- The questions name the exercises and the section by title, not by chapter number, so that a renumbering cannot leave
  them wrong.
- The first two questions were run before they were written: S03's two rows of one revision set to 60 and 65 make
  `reconcile.sql` take the later row and report the snapshot as wrong, and swapping them hides the difference; read
  from a CSV file, the pre-change export keeps `'0'` and drops `''`, the post-change one keeps both, and
  `test_export.py` still passes.
- The merges keep every rule and scenario: "Host behaviour states its basis" joins "Behaviour claims grounded in runs";
  "Printed commands survive copying" joins "Printed commands work as pasted", copying being the first half of pasting;
  "Truthful publication acceptance" joins "Qualified edition", its proof scenario being "Reviewed text before
  landing"'s; the four Chinese prose requirements become "Chinese prose", their particulars moved into scenarios to keep
  the rule short. The misnamed "Typeset output keeps to its declared supply" is left for a later Change.

## Risks / Trade-offs

- The third question rests on chapter 12's account of how a host takes its tool list; it is not a recorded run.
