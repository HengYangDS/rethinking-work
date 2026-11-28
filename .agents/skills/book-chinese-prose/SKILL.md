---
name: book-chinese-prose
description: Use when writing, editing or reviewing the Chinese of the book (book/, the Chinese reader notes, exercises/**/*.zh.md, Chinese release notes), so that it reads as idiomatic written Chinese with one name per concept and the person, not the procedure, at the centre.
metadata:
  internal: "true"
---

# Chinese prose of the book

The book's own chapter on writing (`book/parts/writing.typ`, 「信、达、雅」) defines the standard; this Skill does not
restate or reword it. It carries what that chapter leaves to practice: the names the book has fixed, the
translated forms that keep coming back, and a human perspective on the people the book writes about.

## When to Use

- Before writing or editing any sentence in the prose listed in the description.
- Before briefing an editor or a reader of the book's Chinese; give them this Skill's path, not a summary of it.
- Not for code, commands, file names, labels or the English contributor documents.

## Workflow

1. Read `references/terms.md`, `references/translated-forms.md`, `references/human-voice.md` and
   `references/composition.md` completely.
2. Fix the meaning before the words: the facts, numbers, conditions, negations, who acts and who answers for it
   stay exactly as they are. Add no fact, example or number.
3. Write each sentence as a Chinese author would: subject and verb first, verbs rather than nouns made from verbs,
   no English participle used as a modifier, no passive where Chinese is active, one name per concept from
   `references/terms.md`, the book's written register (not speech, not officialese).
4. Read each passage as its reader would: a member of a quantitative data department, a person. Where it speaks of
   people, apply `references/human-voice.md` first; where a rule is stated, say why before how.
5. Shape the passage after `references/composition.md`: the exact word, rhythm, one point per paragraph, the order
   a reader needs, proportion and an ending on the point.
6. Keep the department's guidelines as the one definition of grades and tiers (`book/parts/talent.typ` follows
   them); change how they are said, never what they say.
7. Build with `typst compile --root . --jobs 2 book/main.typ <out>` at nice 10, and keep the page ceiling and every
   chapter's opening page in view.
8. Hand every changed passage to a reader who did not write it, with `references/reading-brief.md`, and settle each
   point before recording the reading in `publication/acceptance/reviews.toml`.

## Evidence

- Per file: the paragraphs changed, and the before and after of the ten most important.
- Each point a reader raised, settled (where and how) or declined (why).
- The Vale gate `book-prose` passes; the decidable forms in `references/translated-forms.md` that recur belong in
  `.config/checks/vale/styles/book/`, not only here.

## Trust Boundary

- The repository files are the source of truth: `book/parts/writing.typ` for the standard, the department guidelines for grades and
  tiers, the Vale style for decided words. This Skill routes to them and adds the practice they leave open.
- An edit never adds a fact, softens a limit or changes who is responsible.
- Writing about people follows `references/human-voice.md`, whose §7 holds the boundaries that stay.
- Quoted words of a speaker, commands and recorded output keep their form.
- A reader's yes is not acceptance: the owner reads the result.
