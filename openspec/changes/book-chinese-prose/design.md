## Context

The owner's words of 2026-11-26 (15:14 to 17:35) asked for idiomatic written Chinese across the book and for writing
about people from a human perspective. The repository had no carrier for its Chinese standard: the book's own
definition of 信、达、雅 sits in chapter 24, the decided wording in the `book-prose` gate, and the rest in one agent's
notes. Three read-only surveys of the same day (the ETHOS paradigm and sibling repositories, `build/` and the tracked
structure, forge practice) informed where a repository skill may live.

## Goals / Non-Goals

**Goals:** one carrier for how this book's Chinese is written, edited and read; every chapter revised to it; chapter 29
written for the colleague it assesses.

**Non-Goals:** splitting the specification into capabilities, community and forge files, and the `build/` clean-up;
they come back to the owner as proposals of their own. No release.

## Decisions

- **The skill lives at `.agents/skills/book-chinese-prose`.** The ETHOS paradigm admits repository skills only under
  `.agents/skills/` and routes each through `activation.toml`; `.claude/skills` or `.codex/skills` at the root are
  catalog gaps. The package passes ETHOS's skill portfolio check. The exercises' `agent/SKILL.md` is reader material
  and stays where it is.
- **Terms are fixed book-wide, not per chapter.** The five role names of chapter 23 replace every circumlocution
  (「有权决定的人」, 「有权验收的人」). Forms the book uses as its own vocabulary stay even where a reader found them
  unusual: 下一环 (chapter 1's five links), 最可能错在哪里 (the test of understanding), 带不带规则, 做成一道检查.
- **A chapter reference alone in parentheses takes no 见.** The book wrote it both ways (47 without, 18 with);
  parentheses that hold more than the reference keep 见.
- **Chapter 29.** Its rules state the department's guidelines (`data-department-work-guidelines`, `docs/grow.md`).
  - The member is told the result and agrees the next step: the guidelines already say a tier is used "to show each
    member where they stand at their grade and where to go next" (line 159), so this states the guideline, not a new
    rule.
  - The clauses that named years, seniority and calendar time only to exclude them are removed (owner, 16:51); the
    positive rules (requirements as the grade table lists them, promotion on the listed evidence) carry the same limit.
  - Six procedural details (a late result's period, S across periods, comparing three assessors, the B-and-S
    re-reading, a period without a tier, the chief's tiers) are left to the guidelines (owner, 17:35). The book keeps
    one source of each detail instead of a copy beside the guidelines.
- **Reading has its own lenses.** Translated or wrong Chinese, coldness toward people, behaviour unlike people, and
  unclear sentences; nine readers read the book in parts of about thirty pages after the last edit, and their findings
  were fixed.
- **Word choice and composition (owner, 17:45).** `references/composition.md` states the practice for 遣词造句 and
  谋篇布局 under the shared definition of 雅; the reading brief gains lens E. Within a chapter, paragraphs and sections
  may move; across chapters, the owner decides.
- **Moves across chapters (owner, 18:20).** Made: chapter 29 no longer cites chapter 31 ahead (chapter 31 refers back);
  the part introductions of chapters 4, 9, 15 and 22 follow the preface's wording. Deferred, not rejected: moving the
  external-skill section from chapter 12 to 13, renaming part four, parallel chapter titles, and a directory column in
  appendix A.
- **Fidelity before elegance.** When a structure or wording change and a fidelity reader disagreed, the shared rule
  decided: a dropped qualification, a moved clean-up step or a changed actor was restored. Where both concerns were of
  elegance (chapter 6's section order), the two reviewers agreed one arrangement.

## Risks / Trade-offs

- A reader of the book alone can no longer settle the six procedural details; the chapter says where they are.
- Splitting paragraphs costs lines: the polish first took the edition to 201 pages; four chapters were tightened
  back, and the edition stands at 198 with chapters 10 and 20 one page longer.
- Model safeguards stopped four of the twenty-seven sub-agents of this pass; their files were re-dispatched in smaller
  parts and completed. The stop names no passage, so its cause is not known.
