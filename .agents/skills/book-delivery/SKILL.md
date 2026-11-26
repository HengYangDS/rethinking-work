---
name: book-delivery
description: Use when committing, reviewing, archiving, proving, landing, publishing or retiring a lane in this repository, so that its own preconditions hold before ETHOS's next step and the refusals already met here are avoided.
metadata:
  internal: "true"
---

# Delivering a change of the book

ETHOS's current result names the next step, and its guidance says how to act on it. [Contributing](../../../CONTRIBUTING.md)
owns the editing journey, [edition acceptance](../../../docs/publication-acceptance.md) the qualification and release
of an edition, and the specifications what a head must hold. This Skill adds what none of them says: facts about this
repository and about ETHOS 0.2.0-beta.11 that an agent needs before a step, and the refusals met here, each with what
prevents it. The refusal codes are that version's.

## When to Use

- Before a commit, an independent review, `ethos lane archive-change`, a proof, landing, publication or a lane's
  retirement in this repository.
- Not for the book's Chinese (`book-chinese-prose`) or for judging an edition's pages (the acceptance guide).

## Workflow

1. Act on each result as ETHOS's guidance says (its path is `governance_context.agent_guidance` in
   `ethos status --root <lane> --json`); nothing below replaces a step the result names.
2. Give ETHOS your identity in every shell that commits or runs an ETHOS effect, through `ETHOS_ACTOR` or the
   command's `--actor`; without it the commit hook refuses the commit (`invocation_actor_missing`). Name a lane by its
   subject alone: ETHOS adds the date and refuses a dated name (`work_lane_name_dated`).
3. Keep one active Change in a lane. With two, the commit hook refuses every commit
   (`openspec_active_change_ambiguous`), even after `ethos lane prewrite` admitted the patch; archive the finished
   Change before writing the next.
4. Commit on the checks' own verdicts: each gate's result and a `pass` from `ethos lane prewrite`. A check piped into
   `tail` or `grep` reports the last command's status, not the check's. When a file that a Skill's package lists
   changes, copy the `digest` the skills gate reports into the package's `expected_digest`.
5. Before the archive, record the reviews that "Reviewed text before landing" in
   `openspec/specs/editorial-acceptance/` requires of the head, and have a change of code reviewed as Contributing
   says. An archived Change cannot be reopened once a later commit sits on it
   (`openspec_archive_compensation_unavailable`), so a finding after the archive costs another Change.
6. `ethos lane archive-change --apply` commits the archive, formats the specifications it updates, and then reports
   `proof_not_proven` with the proof of the archive head: that report asks for the one proof landing needs. A full
   proof runs its readiness gates first; where it waits in a host's queue before starting, run them on the head
   beforehand (`ethos prove --readiness --execute`). The static-analysis gate among them holds comments to 100
   characters, which the formatter does not, and ETHOS refuses it when run alone.
7. Closeout runs in the checkout of the accepted branch, here the canonical checkout on `dev`. Landing a proved lane
   on `dev` and publishing `dev` need no further word; publishing `main`, a tag or a release needs the owner's word
   each time, as the acceptance guide's Release section says.
8. A peer may drop a connection opened seconds after another, and the publication then ends `outcome_unknown` after
   its push, which may already have started a pipeline. Wait for that pipeline, then read the ref back before
   repeating anything.

## Evidence

- Each ETHOS result, preview and apply, kept with the lane's local evidence under `build/`, not in tracked source.
- The independent review in the reviewer's own words, and an answer to each finding.
- The proof's result for the exact head that lands, and each peer's run of that head.

## Trust Boundary

- ETHOS's current result and the repository's files are the source of truth: the result decides the next step, and a
  step it names is not proof that its preconditions hold. This Skill routes to them and overrides neither.
- Landing, publication and a release are separate effects, each with its own admission.
- This Skill grants no authority and names no host, account, credential or path outside the repository.
