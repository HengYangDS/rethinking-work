## Context

See [proposal.md](proposal.md). Two reviewers work outside the repository: the session that compares the printed commands
and the prose beside them with the run records (its findings under `build/evidence/reader-run-next-edition/`), and a
fresh reader of each changed passage. Their verdicts gated proofs only through my local proof ticket, which read files
under the ignored `build/`; CI never saw them.

## Goals / Non-Goals

**Goals:**

- A head that changes the book's text or exercises cannot pass the proof or either CI without both records.
- The record says what was read, against what, when, and how each point ended, so a later reader can follow it.

**Non-Goals:**

- Copying the findings into the repository: they stay where the reviewer wrote them.
- Gating the release PDF check by a test: the release procedure reads its record.

## Decisions

- The key is the git tree of `book/` and `exercises/` (the commands reviewer's request: both are what the runs read),
  not a commit: a commit that changes neither, such as the record's own commit or an OpenSpec archive, keeps its
  review. Printing whole is not in the key; the copy test holds it in CI.
- A commands review names two baselines: the run records' blocks (`blocks_against`, v0.2.3 today) and the reviewed
  commit the prose was compared with (`prose_against`), and the PDF it read by SHA-256 or "none", so a text-only review
  is told from one that read printing.
- A point ends settled (the commit and wording) or declined (the reason, and the review that accepted it); a review with
  an open point is not recorded, so it never passes.
- The check is a test module of its own, reading the tracked file and `git rev-parse HEAD:<dir>`; it needs no PDF and
  runs in a fraction of a second.

## Risks / Trade-offs

- [A record copied wrongly] → Each entry names the findings path; the reviewer reads the record in its next review.
- [Every book change now waits for the commands reviewer] → Its reviews took minutes today; the wait is the price of a
  stage the acceptance already required.
