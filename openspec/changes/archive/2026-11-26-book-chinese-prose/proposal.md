## Why

The owner read chapter 29 on 2026-11-26 and found its Chinese stiff and unidiomatic, a fault he called systematic
across the book (「有权决定的人，在中文里，真的这样表述么？」). He also found passages that treat people as items
processed, most of all in the assessment of colleagues, and asked for the book to be polished from a human perspective,
with care for people and encouragement in front.

The cause lies upstream of any one sentence. The book was drafted from English guidelines with English briefs; its
checks judged errors by CY/T 266 and GB/T and had no reading for idiom or for how people are written about; and the
book's Chinese standard lived in one agent's private notes, so no other agent loaded it.

## What Changes

- A repository skill, `.agents/skills/book-chinese-prose`, carries the standard: decided terms (the role names of
  chapter 23 among them), translated forms and their replacements, how to write about people, and a reading brief with
  its lenses. `activation.toml` routes it for `book/**`.
- Every chapter is revised to that standard and read sentence by sentence by readers who did not edit it; their
  findings are fixed. 「有权决定的人」 becomes 「决策负责人」 throughout.
- Chapter 29 opens with what assessment is for, tells the member the result and agrees the next step with them, drops
  the clauses that named seniority only to exclude it, and leaves six procedural details to the department's
  guidelines (owner, 17:35: 「按照你建议的方式」).
- A further pass polishes word choice and composition (owner, 17:45: 「其他遣词造句，谋篇布局等方面的问题，也再打磨优化下吧」):
  the skill gains `references/composition.md`; every chapter is polished; sections and paragraphs move within chapters
  after a whole-book structure review; two moves across chapters are made (owner, 18:20: 「同意建议」) and three are
  deferred.
- Readers who did not edit check every changed passage against the base for meaning, facts and conditions; their
  findings are fixed.
- The acceptance document's readability reading uses the skill's lenses.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: "Chinese prose" gains a scenario for passages about people and one for the skill as the
  standard; "Talent judged by a stated standard" states the essentials, leaves procedural details to the guidelines,
  and tells the member the result.

## Impact

`book/` (every chapter, the front and back matter), `.agents/skills/` (new), `docs/publication-acceptance.md`, the
specification. No command, code block, recorded output, fact or number changes; the edition grows from 197 to 198
pages, within its ceiling of 200.
