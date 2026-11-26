## Context

See [proposal.md](proposal.md). ETHOS's own guidance for repository work asks an agent to follow the current result
of `ethos status` and each command, not a remembered command sequence, and not to copy a contract into another Skill.
The repository's guides own the editing journey and the qualification and release of an edition; the specifications
own what a head must hold.

## Goals / Non-Goals

**Goals:**

- An agent new to this repository knows, before ETHOS's next step, what the result does not say, and does not repeat
  a refusal already met here.
- A Skill whose listed files change without its package fails the proof.

**Non-Goals:**

- Restating ETHOS's lane, proof, landing or publication commands as a sequence, or a requirement's conditions. The
  owner asked for the steps; ETHOS's guidance narrows that to what its result does not say.
- Host admission: the host's own rules own its queue, memory limits and tickets, and this public repository names no
  host.

## Decisions

- **What the Skill holds.** Each workflow item is a fact the result does not give (where closeout runs, which
  publications need the owner's word, what `outcome_unknown` leaves behind) or a refusal met here, named by ETHOS's
  code with what prevents it. It cites requirements and guides by name instead of restating their conditions.
- **The review rule.** The owner's rule that a change of code has one independent review before its archive, sent
  only to a model service the owner agreed to, is stated in the contributing guide, where an agent reads the editing
  journey; the Skill points there.
- **One version.** The Skill names the ETHOS version its refusal codes come from, so a reader on another version sees
  that they may differ.
- **One file.** The Skill is short enough to need no references; its package includes `SKILL.md` alone.
- **The gate.** The profile declares a gate `skills` with ETHOS's provider `provider.skill-portfolio`, the provider
  of ETHOS's packaged gate of the same name, and lists it among the gates a repository proof runs. A packaged gate
  cannot be listed there without a declaration (the profile is refused), and the packaged gate is not composed into
  a proof by itself, since it names no paths.
- **The stale digest.** The package of `book-chinese-prose` takes the digest ETHOS computes for its current files,
  which are the reviewed ones; the commit that changed them was proved and landed.

## Risks / Trade-offs

- [A Skill edit now needs its digest] → The skills gate names the Skill and reports the digest of its listed files.
- [ETHOS moves on] → The refusal codes are tied to the version the Skill names; the Change that moves ETHOS reads the
  Skill against the new version.
