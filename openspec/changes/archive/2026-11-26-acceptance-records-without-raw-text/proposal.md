## Why

On 2026-11-26 the owner decided that the tracked repository holds designed artefacts, not raw working records, and
approved a redesign of acceptance. A review is a statement about content: who read which tree, against what standard,
with what verdict. Such a statement belongs beside the content, bound to its digest, not inside the tree it describes.
Its intended form is an ETHOS semantic-assurance Attestation, which the ETHOS kernel specifies but does not yet
implement. Until it does, the review record stays the land gate, and it must hold no raw text.

Today `publication/acceptance/reviews.toml` holds 84 reviewer points in prose and 32 paths into ignored local evidence.
The acceptance document, the prose skill and the proof profile carry clock times, a local path, dated personal
attributions and measurement history. CHANGELOG narrates how editions were qualified and who chose what.

## What Changes

- The review record holds exactly its declared fields: what was read, against what, when, the verdict, and how many
  points were settled and how many declined, each value in a declared shape. It keeps the last release's reading, the
  reviews that cover that release's trees and every review read after them; Git keeps the rest.
- `tests/test_acceptance.py` holds the record to its kinds, every entry to exactly its fields and their shapes, and
  every verdict to its counts.
- Declined points whose reasons hold beyond their passage become rules: two judgements in the acceptance document and a
  rule for words used across chapters in the prose skill.
- `docs/publication-acceptance.md` records reviews by their declared fields; its calibration paragraph loses its times
  and path, and an anecdote gives way to the rule it illustrated.
- The prose skill and `.ethos/profile.toml` lose dated personal attributions and measurement history; the skill's
  digest is recomputed.
- CHANGELOG states product changes only: the qualification narrative and personal attributions leave every section.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: "Reviewed text before landing" records counts of settled and declined points instead of where
  the findings are and how each point was settled, and a record that holds more than its fields fails.

## Impact

`publication/acceptance/reviews.toml`, `tests/test_acceptance.py`, `docs/publication-acceptance.md`,
`.agents/skills/book-chinese-prose/`, `.ethos/profile.toml`, `CHANGELOG.md` and the specification. The book's text,
the exercises and the edition do not change. Out of scope: the archived Changes, which are immutable records and wait
for an ETHOS command that rewrites them with a record of the rewrite; the move of reviews to Attestations, which is
ETHOS's work; the removal of hard-coded values, which is the next Change.
