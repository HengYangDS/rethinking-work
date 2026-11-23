## Context

See [proposal.md](proposal.md). The research of 2026-11-21 (`build/evidence/quality-system-research/`) compared
Chinese-capable prose linters and chose Vale, installed through Homebrew at 3.28.1 and in Mise's registry as
`aqua:vale-cli/vale`: declarative YAML rules, Go regular expressions with `\p{Han}`, and `.typ` read as Markdown so that
code spans and code blocks are skipped. Vale 3.28 also runs test cases kept beside a configuration's rules
(`vale test`, with `--coverage` failing a rule that alerts in no case). AutoCorrect, textlint, zhlint and LanguageTool
were not adopted (runtimes, stale Chinese rules, Markdown only, or models that do not reproduce).

## Goals / Non-Goals

**Goals:**

- Every decision of the whole-book review that a pattern can decide is a rule with its source and date, run on every
  change in the proof and both CIs.
- Each rule shows by its own cases that it alerts on the replaced form and passes the decided one.

**Non-Goals:**

- Decisions that depend on sense: 可 as a conjunction, 默认 for a document's order, 带宽 as a loose word, 轮 for a host's
  turn, 弄明白 and 做出来 outside the chapters that argue with them, the five-field and role names copied from one
  chapter. They stay with the fresh reader and the cold read.
- ETHOS's own `prose` gate, which reads Markdown; reading a repository's non-Markdown sources there is a product change
  for ETHOS's owner.

## Decisions

- One style, `book`, in the repository's Vale increment, `.config/checks/vale/vale.ini`: ETHOS's paradigm makes that
  file Vale's one carrier in a repository and refuses a `.vale.ini` elsewhere; its prose gate runs the increment on
  Markdown, where the style, bound to `*.typ`, adds nothing. The file opens with `[DEFAULT]`, as ETHOS's own and
  DDWG's increments do, so that the configuration check reads it.
- Three rules by kind: `decided-terms` (substitution, one replacement each), `avoided-words` (existence, where more than
  one replacement fits), `half-width-punctuation` (existence). A pattern that would also catch a sound use is narrowed in
  the pattern (更强的模型 and 大半年 stay; 比上 is left out because 比上一次 is sound; `name::key` is not punctuation).
- A speaker's own words are declared where they stand, not switched off in place: a sample box titled 原话 is skipped
  by `TokenIgnores` in the configuration, and a project case shows that the prose after it is still read. ETHOS refuses
  Vale's in-file switches as weakening a shared floor; the book follows the same stance. Where the book only repeated a
  speaker's word in its own voice (practice 3's 「靠不靠谱」), the sentence says it in written words instead.
- One gate, `book-prose`, listed in `code_correctness_gates`, the profile's proof sets (a declared gate that is not
  listed never runs; the first proof of this Change found that), runs `vale test` and then Vale over `book/` through one `publication/justfile` task, so the
  proof and the CIs run the same command; `--no-global` keeps a host's own Vale configuration out.

## Risks / Trade-offs

- [A sound use matches a rule] → The rule is narrowed and a case added; an exemption is used only for quoted words.
- [Vale's Markdown reading of Typst] → Typst markup between Chinese characters (`#link(<x>)[第三章]`) reads as text
  without punctuation; the rules read only Chinese characters and the punctuation against them.
