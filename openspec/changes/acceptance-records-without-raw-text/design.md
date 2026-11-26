## Context

The owner's decision of 2026-11-26 and the redesign he approved place every raw working record outside the tracked
tree: reviewer findings, briefs and run logs stay in local evidence and expire once their consumer releases them; the
lasting facts of a run go into a bounded Attestation. Five read-only surveys of the same day found such records in all
fifteen repositories that ETHOS governs; the family-wide rule and check are requested from ETHOS. This Change brings
this repository's tracked files outside its archived Changes to that standard.

## Goals / Non-Goals

**Goals:** a review record that cannot hold text; acceptance guidance, skill and profile without raw detail; a
changelog of product changes.

**Non-Goals:** rewriting archived Changes by hand (they are immutable records); building review Attestations or a
separate acceptance policy file before ETHOS provides the Attestation; any change to the book.

## Decisions

- **Fields, not prose.** Each kind of entry has a closed set of fields, and the test compares the set exactly, so text
  has nowhere to go. Points are counted, not quoted: the count is what the gate needs (an open point blocks), and the
  wording of a point lives with the findings.
- **The record covers the present.** It keeps the reviews read after the last release's reading, which form the chain
  from that release to the head, and that release's reading. Earlier entries leave the file; Git keeps them.
- **A reason that generalises becomes a rule.** Of the seventeen declined points, three carry reasons beyond their
  passage: a fraction in either numeral form (GB/T 15835—2011 4.3), quoted words keeping their form, and words used
  across chapters changing all at once. They go where rules live: the acceptance document's judgements and the skill's
  terms. The others stay with their findings.
- **Attribution in a decision record keeps date and role.** A comment that states a decision may say who decided and
  when (`style.typ`'s page ceiling); guidance that is not a decision record states the rule without attribution.
- **Extension point.** When ETHOS records reviews as semantic-assurance Attestations and its land gate checks them,
  `reviews.toml` and its test retire, and which reviews land and release need is declared once in the profile. The
  fields chosen here are the ones such an Attestation binds: subject, scope, baseline, time, verdict.

## Risks / Trade-offs

- Reviews before the last release leave the tracked file. Git history and the released editions keep them.
- The changelog no longer reports error-rate samples. How each edition was qualified will be stated in a per-edition
  qualification statement once Attestations exist; until then the release notes on both forges state it.
