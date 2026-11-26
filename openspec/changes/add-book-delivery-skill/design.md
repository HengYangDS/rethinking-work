## Context

See [proposal.md](proposal.md). ETHOS's own guidance for repository work asks an agent to follow the current result
of `ethos status` and each command, not a remembered command sequence, and not to copy a contract into another Skill.
The repository's guides own the editing journey and the qualification and release of an edition.

## Goals / Non-Goals

**Goals:**

- An agent new to this repository meets its preconditions before ETHOS's next step and does not repeat a refusal
  already met here.
- A Skill whose files change without its package fails the proof.

**Non-Goals:**

- Restating ETHOS's lane, proof, landing or publication commands as a sequence; the approved item asked for the steps,
  and ETHOS's guidance narrows that to what its result does not say.
- Host admission: the host's own rules own its queue, memory limits and tickets, and this public repository names no
  host.

## Decisions

- **What the Skill holds.** Each workflow item is a precondition this repository sets (one active Change, review
  records, review before the archive) or a refusal met here, named by ETHOS's own code with what prevents it. Every
  command it names is an ETHOS command; local scripts stay out.
- **One file.** The Skill is short enough to need no references; its package includes `SKILL.md` alone.
- **The gate.** The profile declares a gate `skills` with ETHOS's provider `provider.skill-portfolio`, the provider
  of ETHOS's packaged gate of the same name, and lists it among the gates a proof runs. A packaged gate cannot be
  listed there without a declaration (the profile is refused), and the packaged gate is not composed into a proof by
  itself, since it names no paths.
- **The stale digest.** The package of `book-chinese-prose` takes the digest ETHOS computes for its current files,
  which are the reviewed ones; the commit that changed them was proved and landed.

## Risks / Trade-offs

- [A Skill edit now needs its digest] → The skills gate names the Skill; the digest is ETHOS's own computation over
  the package's listed files.
- [The Skill and ETHOS drift apart] → A refusal named in the Skill is ETHOS's code for this version; when ETHOS
  changes, the Skill's list is checked against the new version's results in the Change that moves ETHOS.
