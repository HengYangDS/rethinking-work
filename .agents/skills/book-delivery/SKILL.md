---
name: book-delivery
description: Use when committing, reviewing, archiving, proving, landing, publishing or retiring a lane in this repository, so that its own preconditions hold before ETHOS's next step and the refusals already met here are avoided.
metadata:
  internal: "true"
---

# Delivering a change of the book

ETHOS owns the delivery journey: `ethos status --root <lane> --json` and each command's own result name the next step,
and ETHOS's guidance says to follow that result rather than a remembered sequence. [Contributing](../../../CONTRIBUTING.md)
owns the editing journey and [edition acceptance](../../../docs/publication-acceptance.md) the qualification and the
release of an edition. This Skill adds what they leave to practice here: the preconditions this repository sets before
a step, and the refusals met on the way, each with what prevents it.

## When to Use

- Before a commit, an independent review, `ethos lane archive-change`, a proof, landing, publication or a lane's
  retirement in this repository.
- Not for the book's Chinese (`book-chinese-prose`) or for judging an edition's pages (the acceptance guide).

## Workflow

1. Read `ethos status --root <lane> --json` and run only the step its `next` names; read the result again after each
   effect.
2. Set up the lane once. Set `ETHOS_ACTOR` to your own identity, or the commit hook refuses the commit
   (`invocation_actor_missing`); name the lane by its subject alone, since ETHOS adds the date and refuses a dated name
   (`work_lane_name_dated`); keep one active Change in it, since with two every commit is refused
   (`openspec_active_change_ambiguous`) even after `ethos lane prewrite` admitted its patch.
3. Commit on the checks' own verdicts: each gate's result and a `pass` from `ethos lane prewrite` for the exact index
   patch. A check piped into `tail` or `grep` reports the last command's status, not the check's. A change to a
   Skill's files records the package's new digest, or the skills gate fails.
4. Record what the proof will hold. A head that changes `book/` or `exercises/` needs its commands review and its
   reading in `publication/acceptance/reviews.toml` ("Reviewed text before landing" in
   `openspec/specs/editorial-acceptance/`); the acceptance guide gives the steps.
5. Review before the archive. A Change that changes code, tests or configuration gets one independent review of its
   whole diff, by a reviewer who has not seen it, and an answer to each finding in the code or in the Change. An
   archived Change cannot be reopened once a later commit sits on it (`openspec_archive_compensation_unavailable`), so
   a finding after the archive costs another Change.
6. Archive, then prove once. `ethos lane archive-change --apply` commits the archive, formats the archived
   specifications and then reports `proof_not_proven` with the proof of the archive head: that report is the request
   for the one proof landing needs, not a failure. Before the proof is queued, the readiness gates pass on that head
   (`ethos prove --readiness --execute`); the static-analysis gate, which holds comments to 100 characters where the
   formatter does not, is refused when run alone.
7. Generate the pipelines after editing `.config/ci/` with `ethos lane project` inside the active Change; outside one
   the apply is refused (`openspec_material_path_uncovered`).
8. Land, close out, publish and retire in the order the results give: `ethos land` from the lane,
   `ethos land --closeout` from the canonical checkout, `ethos publish --ref` per ref after its probe, and
   `ethos lane retire landed` once each peer's run of the landed head is read back. A peer may drop a connection
   opened seconds after another; the publication then ends `outcome_unknown` after its push. Wait for the pipeline
   that push started, then read the ref back before anything else.

## Evidence

- Each ETHOS result, preview and apply, kept with the lane's local evidence under `build/`, not in tracked source.
- The independent review in the reviewer's own words, and an answer to each finding.
- The proof's result for the exact head that lands, and each peer's run of that head.

## Trust Boundary

- ETHOS's current result and the repository's files are the source of truth: the result decides the next step, and a
  step it names is not proof that its preconditions hold. This Skill routes to them and overrides neither.
- Landing, publication and a release are separate effects, each with its own admission. A release, and anything
  outside this repository, is the owner's decision; the acceptance guide gives the release's steps and read-back.
- This Skill grants no authority and names no host, account, credential or path outside the repository.
