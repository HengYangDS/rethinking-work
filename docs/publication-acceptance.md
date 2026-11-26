---
subject: rethinking-work:edition-acceptance
role: how-to
state: active
relations:
  canonical_for: publication qualification procedure
---

# Edition acceptance

A candidate becomes a delivered edition only after its meaning, rendered pages
and target bytes have been checked. The observable requirements belong to the
[official publication-source specification](../openspec/specs/publication-source/spec.md).
This guide explains their execution; it is not another acceptance or progress
register.

## Check complete meaning

Prose is judged under 信、达、雅 as [chapter 24](../book/parts/writing.typ) states them, which is the shared
definition: fidelity is the root, clarity comes before elegance, and when they conflict fidelity prevails over clarity
and clarity over elegance. A review brief cites that definition instead of wording its own.

The book's decided wording and the decidable cases of Chinese punctuation are rules, not a reader's memory: the
`book-prose` gate runs them over the Typst sources (the `book` style in `.config/checks/vale/`; `just --justfile
publication/justfile prose-check`), each rule with its source, date and cases. A decision that depends on sense, such
as 可 as a conjunction or a term copied from the chapter that defines it, stays with the reader below.

A head that changes `book/` or `exercises/` is proved and landed only when
[`publication/acceptance/reviews.toml`](../publication/acceptance/reviews.toml) records, for its `book/` and
`exercises/` trees and the Python line its commands name, a review of the printed commands and the prose beside them
against the run records with no open point, and, for its `book/` tree, a reading of every changed passage by a reader
who did not write it. The reviewers change nothing in the repository. The lane's editor records each review with its declared fields only: what was read,
against what, when, the verdict, and how many points were settled and how many declined. The findings stay in the
reviewer's local evidence folder and are neither named nor copied; the record itself is the evidence that the proof and
CI read. A point ends settled or declined with its reason; a review with an open point is not recorded. The record
keeps the last release's reading, the reviews that cover that release's trees and every review read after them; Git
keeps the rest. A declined point whose reason holds beyond its passage becomes a rule: a judgement below, a term in the
skill, or a Vale rule.
[`tests/test_acceptance.py`](../tests/test_acceptance.py) fails a head without these records.

Read the complete changed prose and its qualifications. Where a passage was shortened or reworded,
ask of every replaced word whether another chapter defines it as a term. Verify that examples
teach the stated mechanism, sources support material claims, and conditions or
unknowns have not vanished during polishing.

For a Chinese revision, review complete paragraphs rather than approve isolated
word substitutions. First identify the intended concept, object, actor and
relationship from the source. Then express that meaning in idiomatic Chinese,
without inheriting English sentence structure. Compare the revision with its
source for numbers, dates, negation, conditions, attribution and uncertainty.
Cold-read the paragraph for continuity, natural phrasing and a clear referent
for each compressed term. In an instruction, the reader must be able to identify
who acts, the prerequisites, the action and the observable result.

Review evidence must show the passage and the resolved meaning, not merely a reviewer score, agreement or a list of
banned words.

Readability is checked on its own, after the last content or fact edit, because
fact corrections and compression change sentences that no fact check reads for
sense. Split the manuscript into parts of about thirty pages and give each part
to a reader who did not write it, reading every sentence as a member of the
department: mark where a sentence cannot be understood on first reading, has to
be reread, or leaves its actor, referent, term or next step unclear. Check
separately that each term is explained where it first appears and keeps one
meaning. Fix those findings, then have a different reader read the changed
passages and verify them against the records. A whole-book impression or a
fact check does not stand in for this reading.

The readers work from the repository skill `book-chinese-prose` (`.agents/skills/`), whose reading brief names five lenses: translated or wrong Chinese, coldness toward people, behaviour unlike people, unclear sentences, and word choice and composition. A passage
about colleagues is read for whether the person is its subject, its purpose comes before its mechanism, and its support
before its requirement.

Follow the argument as a new reader, not as the person who remembers its sources.
For each consequential scenario, identify the work question it poses, uncertainty,
alternatives, distinguishing observation, changed judgment and practical result.
Check that its transfer problem changes a meaningful condition and that the
answer explains the effect. Read reconstructed teaching dialogue as instruction,
not as a verbatim transcript. Normative department guidance does not prove actual
adoption; a historical receipt does not prove current runtime state.

If reader feedback rejects the substance, reopen the existing editorial task.
Source preservation, compilation and visual self-review retain their limited
evidential roles; none can overrule that rejection. After substantive revision,
qualify the new complete edition again before replacing any reader copy.

`just --justfile publication/justfile test` checks declared native inputs,
edition identity, figure source closure, alternative descriptions and portable
paths. It does not establish full argument fidelity, model effectiveness or
teaching transfer. The synthetic exercises have their own contracts and expected
failures; an expected failing control must not be weakened to make every command
green.

## Check the actual PDF

Build with the complete declared inputs. Verify title, subject, author, keywords,
editorial date, language, bookmarks, links, PDF Info and XMP in the produced
file. Visible author and date must consume the same identity. Textual attribution
does not imply a cryptographic signature, ISBN or publisher endorsement.

Compare complete native page-bound text against `pdftotext -raw` output,
retaining
meaningful punctuation while accounting for renderer control characters and
outline leaders. `-layout` reorders columns by geometry and is useful for
inspection, not source-order equality. Do not strip punctuation from body text to force a match. Case references must link to their dated qualification records, not to private raw receipts. Check every code example, table and figure; text extraction
alone cannot prove their visual fidelity or accessibility.

Render and inspect every final page. Look for heading collisions, missing glyphs,
awkward breaks, narrow columns, tiny diagram labels, misleading arrow directions,
poor spacing and weak navigation. Contact sheets help find rhythm and blank-page
issues; use readable-size inspection where density or a changed layout needs
closer judgment. Record that selection and the review scale. This is a page and
layout review, not a requirement to capture every changed paragraph separately.
Automated geometry checks complement this judgment rather than replacing it.

Extract each printed command and the prose beside it from the source at the commit being qualified, evaluating the
parts the source derives, such as the Python line from the toolchain declaration; pair the commands with the last
release's by text, and compare the prose with the run records. The last release is the latest release
tag, `v<major>.<minor>.<patch>` with a signature, made no later than the review's findings were written; the record
names it as `blocks_against`. Run every changed command, old against new, without a model. On the built PDF, check
that each command prints whole and that its first line is in the PDF's text:
a viewer copies a visual line break as a newline, so a command that wraps cannot be copied as printed.

Check all logical links, destinations and clickable text coverage in the PDF.
For an affected reader application, use a bounded journey covering the reported
defect and distinct link behaviors: for example, a contents jump near each end
of the book, a cross-reference and an external link. Record the actual destination
and return behavior. Structural validation is not a click journey; clicking
every structurally equivalent link is not a separate requirement.

## Sample the error rate

Before an edition is released, sample its final text for errors. Read at least 100,000 consecutive layout characters,
with the cover, title page, copyright page and contents, from a PDF whose body text equals the release's; count errors
by the classes of CY/T 266; the edition qualifies at no more than one error per 10,000 characters. A note that a reader
lists and a judge finds to be an error counts as a listed error does. Every error or note a reader raises in a class
that counts two points goes to a second judge, whatever the first judge found; the second judge does not see the first
one's reason, and neither judge comes from the family of the model that raised it. It counts when either judge finds an
error, at the higher of their two figures. The sample's pages are drawn from the commit hash, and a later sample avoids
the pages already read; layout characters count the running head and page number as lines, and repeated errors are
capped, both by CY/T 266. The bar is that of Article 5 of 《图书质量管理规定》. The cover and the edition line are read on the
release commit's PDF before the tag. Correct every error found, and its kind across the book, before the release; a
model's sample is a self-test, not a publisher's check, and is reported as such.

### How a judgement reads the book

The rows are CY/T 266's own (Tables 1 to 3); these readings settle what the rows leave open, as decided on
2026-11-25. Whether a place counts and whether it is corrected are separate: a place that does not count may still be
worded better, and the editors correct what is inappropriate.

- A sentence that is correct and clear but could be more precise, more complete or better worded is not an error;
  the reader lists it as a note. Neither is a reading that needs the reader to ignore the sentence's own context.
- 1-20 is judged for the book's stated reader, a quantitative data department (UTC, SQL, CSV and JSON are common
  there). A figure or table is its own context for 1-18.
- A contradiction between two passages of the text is 1-11, 2 points; 1-8 covers only contents, an index, a figure's or
  table's words and a running head that do not agree with the text.
- A collocation that does not hold (「合乎读者」; a reason compared with a value) is 1-11's 语句不通. Two coordinate items
  one of which contains the other (「奖励」 beside 「奖惩」) are 1-11. A repeated phrase whose sense holds is wording, not
  1-2.
- A topic and comment whose relation reads clearly is not 句式杂糅. A sentence that could be more precise, whose
  readings all say the same, is not 歧义 or 表意不明. A thesis the book argues in later chapters is not a conclusion
  that fails to follow where it is stated. A loose position word that does not send the reader to the wrong place is
  not an error. A sentence that itself states the condition a reader might think it lacks is not a wrong fact.
- A category reassigned under a new standard is 重新归类, not 换算 (1-5).
- Several questions after a colon may share one final ？ or take one each; neither is an error (GB/T 15834—2011 4.2.3.1;
  no clause decides it). The book's own form, where the lead-in names the questions, is a ？ after each.
- A colon that introduces what a verb (查、看、核对) is to find ends with 。; one whose lead-in names a question, or asks
  the reader to ask (「可以这样自查：」), ends with ？.
- A quotation that gives the words asked after 问、追问、反问 keeps its ？ inside the quotation marks, with no mark
  outside (GB/T 15834—2011 B.2.1); a question used as a name (after a measure word or 所……的, as a heading, after
  回答 or 配一句) takes none. Where both could apply, the word that introduces the quotation decides: words asked keep
  their ？.
- A measured value with three or more significant digits is in Arabic numerals (GB/T 15835—2011 4.1.1); a round
  count of one or two digits (十八万、五千、约三百) may be in either, the same within one place (4.3). So may a
  fraction (七分之一), the same within one place (4.3).
- Words quoted from a file or a brief in their own form, case and spelling included, are not an error.
- A figure stands after the text that introduces it and inside its section (3-5, item 5, 1 point).
- A protocol named in the text is in capitals (HTTP, HTTPS); an address keeps its own spelling (`https://`), in code
  type.
- A closing quotation mark set in half a cell beside another mark is the compression GB/T 15834—2011 5.1.11 allows,
  not an error.

## Reuse evidence and stop completed checks

Bind each result to its source inputs, artifact hash, tool/configuration identity
and demonstrated scope. If those relevant bindings are unchanged, reuse the
result. Reopening a task or resuming a conversation does not invalidate it.
Reader feedback reopens the rejected dimension; it does not make unrelated
file, metadata or exercise checks fail retroactively.

Choose rechecks from the effect of a change. Prose needs meaning review; a new
rendered edition needs complete-content, navigation and every-page qualification.
A layout change needs the affected layout reviewed at the appropriate scale.
Delivery to a different target needs target readback. Contributor-guide or task
edits need native formatting and specification/task validation, not a manuscript
rebuild. An unchanged final PDF needs no new render or image-reading cycle unless
a specific unresolved visual defect requires it.

Before a repeat check, identify the changed input, the unresolved requirement
and the observation that could change the decision. Without one of these
reasons, stop that check. Preserve its evidence and proceed to the next real
gap. Editorial judgment, author visual self-review, structural correctness,
reader-application behavior, file delivery and source integration remain
distinct results; none silently stands in for another.

## Release

A release is made in a lane and ends with its edition published on both peers. Publishing `main`, the tag and the
releases need the owner's word each time; landing a proved lane on `dev` does not.

1. In the lane, set `VERSION`, give the version a dated section in `CHANGELOG.md`, record the reviews of the final
   `book/` and `exercises/` trees in `publication/acceptance/reviews.toml`, complete the release Change's tasks and
   archive it.
2. Read the release PDF built at that head: the cover and its edition line, the colophon and the printed blocks; record
   the reading as the `[[release]]` entry in place of the previous release's, and remove the reviews read before the
   reviews of this release's trees.
3. Prove the head with the full proof, land it on `dev`, and publish `dev` and then `main` to both peers, one receipt
   each.
4. Tag it with `ethos land --release`, a signed `v<VERSION>` on that head. A clean checkout of the tag builds the
   release edition (`edition_inputs`); the tag event's publication jobs build it on both peers.
5. Build the edition archive from the tagged head, create the release on both forges with the PDF and the archive, and
   read both back by SHA-256. The release notes state how the edition was qualified: which reviews it passed and that
   they are self-tests, not a publisher's check.
6. Note on the previous release's pages that this edition supersedes it, deliver the archive beside the earlier
   editions, and retire the lane once both peers' jobs are green.

## Accept and deliver within scope

State whether review was author self-review, independent review or actual
teaching feedback. Do not relabel one as another. Record the exact artifact and
source binding through the existing evidence owner. A measured improvement
requires a declared comparison, not an adjective.

Preserve the prior edition and required failed receipts before promotion. Verify
the declared reader target, file bytes and retained originals after the effect.
Retire only exact owned residue whose consumers have released it. No remote
push or public release follows automatically from a local PDF build.
