## Why

What an agent needs to deliver a change of this repository, beyond what ETHOS's own result tells it, lives only in
one agent's private notes: the preconditions the repository sets before a step, and the refusals met here with their
causes. The owner approved on 2026-11-26 putting it in the repository as a second Skill beside `book-chinese-prose`.

Writing it showed that no proof checks the repository's Skills. ETHOS offers a skills check that compares each Skill
with its activation record and package manifest, but the profile does not run it, and the package of
`book-chinese-prose` has not matched its files since a commit of 2026-11-27 changed three of them.

## What Changes

- A Skill `book-delivery` routes an agent to ETHOS's current result, the contributing guide and the acceptance guide,
  and carries the facts none of them gives and the refusals met here, each with what prevents it. It restates no
  ETHOS command sequence and no requirement.
- The contributing guide states the owner's rule for reviewing a change of code, and that the pipelines are written
  while the Change is active.
- The activation record and the Skills index list it.
- The profile declares the skills gate with ETHOS's skill portfolio provider, and every proof runs it.
- The package of `book-chinese-prose` records the digest of its current files; the files do not change.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `source-verification`: a requirement that every proof holds the repository's Skills to their activation record and
  packages.

## Impact

`.agents/skills/`, `.ethos/profile.toml`, `CONTRIBUTING.md`, `openspec/specs/source-verification/`. A later edit of a Skill's files
fails the proof until its package records the new digest. Out of scope: a Skill for releases beyond what the
acceptance guide says, and host-specific admission rules, which the host's own rules own.
