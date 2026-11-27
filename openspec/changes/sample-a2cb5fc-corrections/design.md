## Context

See the [proposal](proposal.md). The sample's counted places, their judges and proposed fixes are in the sampler's
`run-a2cb5fc/errors.tsv` and `reread-errors.tsv`; the acceptance document's readings ("How a judgement reads the book")
settle the colon and quotation cases.

## Goals / Non-Goals

Goals: every counted place and the re-read's place corrected, with every place of the same kind in the book, in the
fewest words, with no requirement altered.

Non-Goals:

- Places that do not count but could be worded better.
- A further paid check of the corrected text; whether to run one is the owner's, put to him by the sampler.

## Decisions

1. A summary of a file says no more than the file: 截止时刻 for 时刻, the command that section 3 points to for one it
   writes out, 输入的 CSV 文件 for 输入数据 (`exercises/AGENTS.md`, lines 14, 22 to 24 and 31).
2. Where a fix to a colon would leave the sentence on one reading, the sentence is rebuilt so that it reads one way:
   比较一遍，看…，写下… (`practice-agent.typ`); 对照…，找出差别在哪里。 (`diagnose.typ:55`); the suspicion stated, not
   asked (`diagnose.typ:66`); the questions first and 请写下来 after them (`practice-doing.typ:104`).
3. Clauses with their own subjects take ， or a conjunction: 空库正常，旧库的副本失败; the conditions of the Hermes
   script with 或者 before the last. 旧的错了而新的改对了 in `verify.typ` is a wording change, not the kind: the pair
   fills one alternative of 是…，是…，还是…, as 一边有、一边没有 (`practice-doing.typ:116`) and 范围是…、…
   (`knowing.typ:30`), which keep their 、.
4. The same-kind search reads every 、 in the book's prose and table cells (1,096), in two passes: one for items that
   each carry a predicate word, one for items both six characters or longer; every hit is classed, and a series that
   fills one constituent (an object, an attributive, a list resumed by 这些) is not the kind.
5. A rule and its exception are reconciled at the rule's own terms, not by narrowing the rule: chapter 3 says an
   irreversible matter is decided by the responsible person before it is done (`invariants.typ:96`); spending in the
   middle circle is spending within a cap that person has set, so the cap is that decision, and the table and the
   sentence after it say so.
6. Coordinate items, one containing another: 把要求逐项想清楚，尤其是口径和边界; 交出去的要求，包括口径和边界.
   `roles.typ:47` keeps 要求、事实、检查、边界和状态, the five items `standing.typ:66` declares.

## Risks / Trade-offs

- The search decides by pattern and by hand; a clause pair with short items and no listed predicate could escape both
  passes. The classed lists are kept with the lane's evidence.
- `diagnose.typ:66` was not counted; it is rewritten because its colon introduces what is to be checked, the shape the
  sample counted on p. 91.
