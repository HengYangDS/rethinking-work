## Context

See the [proposal](proposal.md). The third judge's reasons for each of the thirteen places are in the sampler's
evidence for `run-b59ab28-gemini`; the acceptance document's rule is "Correct every error found, and its kind across
the book, before the release"; its reading list settles that an unfit collocation counts at 1-11 and a 、 between
clauses at 2-1.

## Goals / Non-Goals

Goals: every counted place corrected, and every place of the same kind in the book with it, with the fewest words
changed and no requirement altered.

Non-Goals:

- A prose-style check for these kinds; whether the decidable ones become rules held by a test is a separate Change.
- Places that do not count but could be worded better.
- A fresh paid sample of the corrected text.

## Decisions

1. Each rewrite keeps the clause that carried the meaning and replaces only the part that did not fit: 写入转为通过 →
   写入成功 (the write succeeds; the check passes); 执行这个看法 → 把这个看法当作规则…执行; 动手的工夫多由智能体承担 →
   动手做的工作多由智能体承担. A doubled preposition is undone without changing what the second phrase means: in the
   book 对外 names where a conclusion or message goes (对外发送, 不对外作出承诺), so 不对生产、治理或对外下结论 becomes
   不就生产、治理下结论，不对外下结论, not a phrase about external matters.
2. Where the fault is in the syntax rather than a word, the sentence is rebuilt around the actor it already had:
   the chosen party in `orchestrate.typ`, the reader in `writing.typ` (写给 people, then 写进 a newly opened session),
   the observer in `team.typ` (接手 the work, know why). Where the fault is in an example that names an act rather
   than what the sentence is about, the example keeps the sentence's own term: the B sentence in `talent.typ` is about
   judgements left to others, so each of its examples is a judgement (给学徒什么指导、专员的成果能否通过验收、
   初级的成果是否通过专人评审), and the third names the work the junior row sends to review, not the person.
3. A comparison of unlike magnitudes becomes a contrast of two stated facts, not a larger figure: 「省下的字有限，补错了，
   代价要大得多」.
4. The same-kind search reads the book's prose and table cells, outside code blocks, for two decidable shapes: a 、
   that joins free-standing clauses (each with its own subject and predicate, none governed by a verb or ending in 的),
   and a comparison whose two sides are different kinds. Every hit is classed by hand with its reason; a clausal
   series governed by 看、说清、写明 or nominalised by a trailing 的 is not the kind.

## Risks / Trade-offs

- Several sentences and one table cell grow by a few characters; the page count and the chapter openings are checked
  against `b59ab28`'s.
- The search decides the 、 kind by a pattern; a clause series that carries no adverb and no pronoun could escape
  both passes, so a third pass reads every 、 that precedes 或者、都、就、才、便.
- The judge's own reading is one family's; where it called a place a note rather than an error the place is still
  corrected, because the acceptance document counts a place once either judge finds an error, with no step that
  weighs one judge against another.
- Two readings of GB/T 15834—2011 are in play for a 、: the strict one (clauses of a compound sentence take ，) and
  the permissive one (subject-predicate items filling one constituent take 、). A comma satisfies both, a 、 only
  the permissive one, so every corrected place takes the comma and no place rests on which reading is right.
