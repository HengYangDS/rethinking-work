# Tasks

## 1. Hold the Skills in the proof

- [x] 1.1 Declare the skills gate in `.ethos/profile.toml` and list it among the gates a proof runs; done when the
      plan of a full proof lists `skills`.
- [x] 1.2 Record the current digest in the package of `book-chinese-prose`; done when the skills gate reports no gap
      for it.

## 2. Add the delivery Skill

- [x] 2.1 Write `.agents/skills/book-delivery/` with its package, register it in `activation.toml` and list it in the
      Skills index; done when the skills gate passes.
- [x] 2.2 State the owner's review rule and when the pipelines are written in `CONTRIBUTING.md`; done when the Skill
      points there instead of stating them.

## 3. Accept

- [x] 3.1 Validate the Change; done when `openspec validate add-book-delivery-skill --strict` passes.
- [x] 3.2 Answer each finding of the independent review in the Skill, the profile or this design; done when none is
      open.
