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
  after the requirement of that name. `manuscript-structure` keeps the owner's name for its theme (书稿结构): the
  book's sources taken as one manuscript, of which the chapters are one kind; its Purpose names every publication
  input.
- **Spanning requirements.** Each goes whole to the theme of its SHALL sentence; the list is the starting point of the
  later Change that may split them.
  - "Cohesive publication inputs" to `manuscript-structure`: one editable owner per input.
  - "Portable and attributable edition" to `edition-identity`: what the edition says it is.
  - "Edition facts declared once" to `edition-delivery`: it names the archive's parts and the check its reader runs,
    beside "One versioned edition archive", which composes them.
  - "Independent publication build" to `edition-delivery`; its scenario on a package that imports another is about
    the supply that `source-verification` holds.
  - "Toolchain facts declared once" to `source-verification`; it also binds the reader notes, the printed commands and
    the build's output names.
  - "Tests and exercises need only the standard library" and "Printed commands work as pasted" to `reader-exercises`:
    what a reader runs.
  - "An account of work in the agentic era" and "Invariants before tools and current practice" to `book-argument`.
  - "Public source without internal disclosure" to `book-argument`: it binds every tracked source, which none of the
    nine capabilities covers whole, and the examples it governs are the argument's; the capability's Purpose states
    the whole scope.
  - Three scenarios sit under another theme's requirement: "A figure is set in the column" (a layout check, under
    "Cohesive publication inputs"), "Attractive output fails the intended purpose" and "Source meaning changes after a
    delivered edition" (editorial acceptance, under `book-argument`'s requirements).
- **The rename.** OpenSpec renames only within one capability, so the requirement leaves `publication-source` under its
  old title and enters `layout` under its new one. "Typeset output without typographic faults" names what its five
  obligations check across the whole text: its fonts, its compile and its lines. Its siblings in `layout` guard other
  typographic matters, each under a title that names its own rule, so a reader looking for page feet or the page
  ceiling finds them by title.
- **The check of the move.** Each added block, with the rename undone, is byte-identical to its block in
  `publication-source` at the Change's base, and each removed block names its new home; the base and the deltas alone
  are enough to check it.
- **Links.** The guides link to `openspec/specs/`, which exists before and after the archive, not to one capability's
  file.

## Risks / Trade-offs

- [Archive output that the formatter rewrites] → OpenSpec writes a new specification's Purpose heading without the
  blank line the repository's Markdown keeps. ETHOS's archive formats each changed specification with Prettier, under
  the same options as the repository's, before it commits, and the proof's formatting gate checks the archive head.
- [The old path goes away] → Links from outside the repository to `openspec/specs/publication-source/spec.md` break,
  and a Change written against `publication-source` can no longer be archived. No other branch carries such a Change;
  later Changes write their deltas against the nine capabilities.
- [A capability with one theme's few requirements] → `chinese-prose`, `edition-identity`, `manuscript-structure` and
  `reader-exercises` hold two each; they are themes of their own, and new requirements of those themes have a home.
