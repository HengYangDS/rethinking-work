## Context

See [proposal.md](proposal.md). OpenSpec owns the specifications; each capability is one folder under
`openspec/specs/`. A requirement moves between capabilities as a REMOVED block in its old capability and an ADDED
block in its new one; a capability whose last requirement is removed is deleted on archive when the Change declares
`retire_capabilities`.

## Goals / Non-Goals

**Goals:**

- Each requirement has one home whose name says what it governs.
- The moved text is the same text: a reader of the new specifications reads the same obligations and scenarios.

**Non-Goals:**

- Rewording, merging or splitting requirements, or moving a scenario to another requirement. Where a requirement
  spans two themes, it goes whole to the theme its SHALL sentence states; a later Change may split it.
- Renaming the two weaker candidates the mapping found ("Behaviour claims grounded in runs", "Chapter references are
  derived"): their titles still describe their requirements.

## Decisions

- **The nine homes.** The themes the owner approved, named as the repository already speaks: `edition-identity` and
  `editorial-acceptance` as in `AGENTS.md` and `README.md`, `layout` as `publication/layout/`, `source-verification`
  after the requirement of that name.
- **Spanning requirements.** "Cohesive publication inputs" goes to `manuscript-structure` (one editable owner per
  input); "Portable and attributable edition" and "Edition facts declared once" to `edition-identity`; "Tests and
  exercises need only the standard library" and "Printed commands work as pasted" to `reader-exercises` (what a reader
  runs); "An account of work in the agentic era" and "Invariants before tools and current practice" to
  `book-argument`.
- **The rename.** OpenSpec renames only within one capability, so the requirement leaves `publication-source` under its
  old title and enters `layout` under its new one.
- **How the deltas are made.** One script reads the mapping from title to capability and writes every delta from the
  source specification, then checks that each moved block, with the rename undone, appears in the source verbatim.
  The script and the mapping stay with the lane's local evidence; the Change holds their output.
- **Links.** The guides link to `openspec/specs/`, which exists before and after the archive, not to one capability's
  file.

## Risks / Trade-offs

- [Archive output that the formatter rewrites] → OpenSpec writes a new specification's Purpose heading without the
  blank line the repository's Markdown keeps. ETHOS's archive renders each changed specification through the
  repository's Markdown formatter before it commits, and the proof's formatting gate checks the archive head.
- [A capability with one theme's few requirements] → `chinese-prose`, `manuscript-structure` and `reader-exercises`
  hold two each; they are themes of their own, and new requirements of those themes have a home.
