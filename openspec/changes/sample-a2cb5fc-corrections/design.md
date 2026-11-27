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
   writes out, 输入的 CSV 文件 for 输入数据, the case directory copied and the copy edited for a file copied
   (`exercises/AGENTS.md`, lines 14, 22 to 24 and 31 to 32).
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
5. A rule and its exception are stated together where the rule is. Chapter 3 says that what cannot be undone takes the
   heaviest procedure (`invariants.typ:107`) and, earlier, that an irreversible matter is decided by the responsible
   person before it is done (`invariants.typ:96`). It now names spending as the exception on the second sentence's
   terms: the cap is that decision, given once, and each payment within it falls under it. The middle circle's 「说明要
   做什么，等人确认」 is that one agreement, not a confirmation of each payment, which would contradict the permission
   to spend in `invariants.typ:66` and the unattended run of the `run` chapter; spending with no cap waits for one, so
   no spending falls outside the circles. The table cell keeps 产生费用 and the sentence after it says this. The other
   statements of the rule refer to the outer circle's procedure and read with the exception; they are classed in the
   lane's evidence.
6. Coordinate items, one containing another. 要求 means two things in the book: in `delegate.typ` what can be said of
   the work, the delegation's five items (`:17`, `:51`), which include 口径 and 边界; in `standing.typ:68` and
   `roles.typ:47` what the work is to become, beside 边界. Each corrected place names what it means instead of
   claiming that 要求 contains 边界: 把委托的五项逐项想清楚，尤其是口径和边界 (`delegate.typ:67`);
   交出去的事要做成什么样，连同它的口径和边界 (`writing.typ:10`). `roles.typ:47` keeps its five items.
7. The sampling rule keeps one draw for each sample, by the commit hash: before the whole body is read, from the pages
   no earlier sample of the edition read; after it, from the whole body. The owner's words allow (可) the whole body; the
   rule makes it the draw, so that the sampler has no choice of region. This is the editor's reading, taken under
   delegation and agreed with the sampler; it goes to the owner at closeout as a decision taken, not as his words. A
   page counts as read when a sample read it, or a reading whose every item went to judges as a sample's items do
   (blind, outside the raising family, a second judge for a two-point class); the readers may be of one family, as the
   option the owner chose described its read-through (Claude readers, Codex judges).

## Risks / Trade-offs

- The search decides by pattern and by hand; a clause pair with short items and no listed predicate could escape both
  passes. The classed lists are kept with the lane's evidence.
- `diagnose.typ:66` was not counted; it is rewritten because its colon introduces what is to be checked, the shape the
  sample counted on p. 91.
