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
   script with 或者 before the last. A pair of clauses that fills one alternative or one item is the kind as well: the
   read-through's judge counted 范围是三千多条逐条比对过、2023 年及更早的没有查 (`knowing.typ:30`), which the first
   search had kept, so it takes a comma inside and semicolons between the three items (GB/T 15834—2011 4.6.3.3);
   一边有、一边没有 (`practice-doing.typ:116`) becomes 一边有而另一边没有, and 旧的错了而新的改对了 (`verify.typ`)
   already takes 而.
4. The same-kind search reads every 、 in the book's prose and table cells (1,096), in two passes: one for items that
   each carry a predicate word, one for items both six characters or longer; every hit is classed, and a series that
   fills one constituent (an object, an attributive, a list resumed by 这些) is not the kind.
5. A rule and its exception are stated together where the rule is. Chapter 3 says that what cannot be undone takes the
   heaviest procedure (`invariants.typ:107`) and, earlier, that an irreversible matter is decided by the responsible
   person before it is done (`invariants.typ:96`). It now names spending as the exception on the second sentence's
   terms: the cap is that decision, given once, and each payment within it is not decided again. The middle circle's
   「说明要做什么，等人确认」 is that one agreement, not a confirmation of each payment, which would contradict the
   permission to spend in `invariants.typ:66` and the unattended run of the `run` chapter; spending with no cap waits
   for one, so no spending falls outside the circles. The table cell goes back to 产生费用 and the sentence after it
   says this. The section on irreversible matters, where `verify.typ:87` and `practice-collaborating.typ:25` send the
   reader, ends with 产生费用例外，见上文“三个圈”, so that chapter 3's 「完整的规定」 holds there too; the note is short
   enough to fill its paragraph's last line and move no page. The other statements of the rule are classed in the
   lane's evidence.
6. Coordinate items, one containing another. 要求 means two things in the book: in `delegate.typ` what can be said of
   the work, the delegation's five items (`:17`, `:51`), which include 口径 and 边界; in `standing.typ:68` and
   `roles.typ:47` what the work is to become, beside 边界, with 口径 inside it (`diagnose.typ:46`). Each corrected
   place names the delegation instead, which holds both: 把委托的五项逐一想清楚，尤其是口径和边界 (`delegate.typ:67`);
   交出去的委托，口径和边界都写在其中 (`writing.typ:10`). `roles.typ:47` keeps its five items.
7. The sampling rule keeps one draw for each sample, by the commit hash: before the whole body is read, from the pages
   no earlier sample of the edition read; after it, from the whole body. The owner's words allow (可) the whole body; the
   rule makes it the draw, so that the sampler has no choice of region. This is the editor's reading, taken under
   delegation and agreed with the sampler; it goes to the owner at closeout as a decision taken, not as his words. A
   page counts as read when a sample read it, or a reading whose every item went to judges as a sample's items do
   (blind, outside the raising family, a second judge for a two-point class); the readers may be of one family, as the
   option the owner chose described its read-through (Claude readers, Codex judges).
8. The read-through's places are corrected in the fewest words that remove the counted reading, most as the reader
   proposed: 比如 before the four judgments (`change.typ:55`); 对事实如何的断言 (`invariants.typ:33`), which keeps the
   heading's 事实如何 and chapter 4's 判断 apart from 事实; from the vendor's ingest day the usable moment is
   estimated from that time plus the local collection, as `knowing.typ:37`'s chain has it (`:52`); 服务商收入数据库的
   日期 and 逐日收入 where 入库 meant the vendor's database (`:52`, `:54`, `:67`); 要另行报告的情况 for what `quality.sql` lists (`practice-thinking.typ:51`, and the query's own first comment);
   放入三个 CSV 文件 (`walkthrough.typ:97`), and 只放数据，即三个 CSV 文件 at `:111` as a wording change, not the kind
   (目录中 means the two directories of the opening runs); 0、−100、60 as appendix D writes
   numbers; 把…原样送达 without 只 (`run.typ:95`); 同时写明 and one subject for 经…认定 and 写明 (`talent.typ`);
   参考答案或对照要点, with 其余各题无法靠运行来核对 earlier in the sentence so that the chapter keeps five pages
   (`practice-collaborating.typ:3`); 追问“为什么？” with no mark after it, by the acceptance reading on 问 and 追问;
   交代得更清楚 (`growth.typ:54`). The searches for each kind are in the lane's classed lists.
9. Two places no judge counted are corrected as wording, so that a term keeps one meaning and a name says what its
   gloss shows; the sample stage's re-read of `cb1b09c` judged both no (two Codex judges), and the sampler and the
   internal reader agreed to correct them all the same: `leading.typ:15` sums up `knowing.typ:52` with
   服务商的数据库里……逐日收入, since `knowing.typ:37` keeps 入库 for the local write; `growth.typ:54` 是否交代清楚, since
   its gloss shows presence and the third point is not comparative either. `invariants.typ:107` 无须逐笔另议 avoids
   决定 twice. The comment at the head of `quality.sql` says what the query lists, as `practice-thinking.typ:51` now
   does; the book does not print it.
10. The read-through's notes that no judge counted, and the reviewers' optional points, are corrected where a reader
    would otherwise have to work out what is meant, under the owner's 「尽量修复优化」 (O170), outside pp. 115–165 while
    the third sample reads them. A pointer names its section (`invariants.typ:57`, `growth.typ:12`); a count, a term
    or a list says what the file and the chapter say: 研究范围内的六只证券 and 十一行数据 for a file with S99 and a
    header, 两种定义 as `model.typ:10` names them, 有合格数据 as the table heads, 期间 among what
    `source-selection.sql` filters, S99 among what `quality.sql` still lists at the later time (run on a copy at
    23:4x), 补录 for the vendor's backfill throughout; a qualifier states its comparison (`bounds.typ:68`, against the
    share of the files due) or its case (`invariants.typ:91`, 无法撤回的 before acting; `practice-collaborating.typ:94`,
    the convention 系统当时有什么 by which the missing ingest condition is an omission); the sandbox's limits are on
    writing, not on running commands (`first.typ:149`); the pack's template is copied before it is edited, as appendix A
    says (`run.typ:46`); a timed job runs now rather than 次日早上, since its schedule skips weekends (`run.typ:158`);
    `project` is named as the action AIGW takes on the file (`aigw-cli`, `internal/adapter/claude/settings.go`);
    `talent.typ` lists the uses its opening lists. The work-loop figure takes the exit for a step out of bounds from the
    choice of action, as the chapter's text does. Left with a reason: the line breaks at S04–S06 and the compressed
    marks of one line (typesetting, no clause read against them), 6 步，45 秒 and 09:00 UTC (the reader proposed no
    change), and `invariants.typ:107`, which keeps the reason for its exception because chapter 3 states the rule.
    The two notes on pp. 115–165 wait for the third sample's result (task 5.3).
11. The third sample (`cb1b09c`, pp. 115–165, 0.31 per 10,000) counts three places, rewritten as its sampler
    proposed: the reported counts are what the reports recorded (依次记为, `evaluate.typ:4`), so the narration keeps
    its order, appearance first; 这一方 for a party that may be a person (`orchestrate.typ:113`); 。 before 其次, which
    stands outside the colon's list (`talent.typ:8`). Their kinds were searched across the book: every 它 after an
    antecedent that may be a person (one more, `delegate.typ:43`, 对方); every count stated before its passage
    corrects the unit (none more); every colon whose reach crosses a semicolon into a parallel item, and every colon
    inside a first item followed by a semicolon (one more, `practice-agent.typ:82`, where the exit code is not part
    of the report). Its uncounted notes are corrected where both families named the same place or a command or a
    fact was inexact, as decision 10 does elsewhere; the step-two command of `diagnose.typ` now unsets the key as
    step one unsets the address, and its output is what hindsight 1.2.1 prints without a key (run 2026-11-28 00:0x,
    against the local service). The rest are other wordings of sentences that read as they are, and stay.

## Risks / Trade-offs

- The search decides by pattern and by hand; a clause pair with short items and no listed predicate could escape both
  passes. The classed lists are kept with the lane's evidence.
- `diagnose.typ:66` was not counted; it is rewritten because its colon introduces what is to be checked, the shape the
  sample counted on p. 91.
