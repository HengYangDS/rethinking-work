## Context

The owner's decision of 2026-11-26 and the redesign he approved place every raw working record outside the tracked
tree: reviewer findings, briefs and run logs stay in local evidence and expire once their consumer releases them; the
lasting facts of a run go into a bounded Attestation. Such records exist across the repositories ETHOS governs, and
the family-wide rule and check belong to ETHOS. This Change brings this repository's tracked files outside its
archived Changes to that standard.

## Goals / Non-Goals

**Goals:** a review record whose fields cannot hold text; acceptance guidance, skill and profile without raw detail; a
changelog of product changes.

**Non-Goals:** rewriting archived Changes by hand (they are immutable records); building review Attestations or a
separate acceptance policy file before ETHOS provides the Attestation; any change to the book.

## Decisions

- **Fields, not prose.** The record holds only its declared kinds; each kind has a closed set of fields, and each value
  a declared shape (a tree, a commit, a tag, a digest, a time, a verdict, a count), so text has nowhere to go. Points
  are counted, not quoted; the wording of a point lives with the findings. The counts cannot show an open point: a
  review with one is not recorded, which the procedure holds, not the test.
- **The record covers the present.** It keeps the last release's reading, the reviews that cover that release's trees
  (a head whose trees equal the release's, such as a documentation-only lane after a release, needs them) and every
  review read after them, which form the chain from that release to the head. The release procedure removes the older
  entries when it records the next release's reading; Git keeps them.
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
  qualification statement once Attestations exist; until then the release notes on both forges state it, as the
  release procedure's fifth step now requires.
- A declined point's reason lives only in local findings, which expire. When the same point is raised again after they
  have gone, it is judged again; a reason that generalises is kept as a rule before then.
