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

Prose is judged under 信、达、雅 as [chapter 24](../book/parts/writing.typ) states them, which is the owner's one
definition: fidelity is the root, clarity comes before elegance, and when they conflict fidelity prevails over clarity
and clarity over elegance. A review brief cites that definition instead of wording its own.

The book's decided wording and the decidable cases of Chinese punctuation are rules, not a reader's memory: the
`book-prose` gate runs them over the Typst sources (the `book` style in `.config/checks/vale/`; `just --justfile
publication/justfile prose-check`), each rule with its source, date and cases. A decision that depends on sense, such
as 可 as a conjunction or a term copied from the chapter that defines it, stays with the reader below.

A head that changes `book/` or `exercises/` is proved and landed only when
[`publication/acceptance/reviews.toml`](../publication/acceptance/reviews.toml) records, for its `book/` and
`exercises/` trees, a review of the printed commands and the prose beside them against the run records with no open
point, and, for its `book/` tree, a reading of every changed passage by a reader who did not write it. The reviewers
change nothing in the repository: the lane's editor copies each verdict, the trees it covered, its time and the path of
its findings, which stay in the reviewer's local evidence folder; the record itself is the evidence that the proof and
CI read. A point ends settled or declined with its reason; a review with an open point is not recorded.
[`tests/test_acceptance.py`](../tests/test_acceptance.py) fails a head without these records.

Read the complete changed prose and its qualifications. Verify that examples
teach the stated mechanism, sources support material claims, and conditions or
unknowns have not vanished during polishing. In a structural migration, compare
the complete native raw examples, table children and figure captions with the
preserved predecessor. Equal counts alone do not establish content preservation.

For a Chinese revision, review complete paragraphs rather than approve isolated
word substitutions. First identify the intended concept, object, actor and
relationship from the source. Then express that meaning in idiomatic Chinese,
without inheriting English sentence structure. Compare the revision with its
source for numbers, dates, negation, conditions, attribution and uncertainty.
Cold-read the paragraph for continuity, natural phrasing and a clear referent
for each compressed term. In an instruction, the reader must be able to identify
who acts, the prerequisites, the action and the observable result.

The credential examples illustrate this distinction: diagnostic values and
Gitleaks patterns concern passwords, tokens and keys; the Office case concerns
non-sensitive metadata; model adoption concerns sensitive information more
broadly. A single replacement for the English word "secret" would obscure these
different meanings. Review evidence must show the passage and the resolved
meaning, not merely a reviewer score, agreement or a list of banned words.

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
inspection, not source-order equality. Remove generated leader dots only on the
identified contents pages; do not strip punctuation from body text to force a
match. Case references must link to their dated qualification records, not to private raw receipts. Check every code example, table and figure; text extraction
alone cannot prove their visual fidelity or accessibility.

Render and inspect every final page. Look for heading collisions, missing glyphs,
awkward breaks, narrow columns, tiny diagram labels, misleading arrow directions,
poor spacing and weak navigation. Contact sheets help find rhythm and blank-page
issues; use readable-size inspection where density or a changed layout needs
closer judgment. Record that selection and the review scale. This is a page and
layout review, not a requirement to capture every changed paragraph separately.
Automated geometry checks complement this judgment rather than replacing it.

Extract each printed command and the prose beside it from the source at the commit being qualified, pair the commands
with the last run's by text, and compare the prose with the run records. Run every changed command, old against new,
without a model. On the built PDF, check that each command prints whole and that its first line is in the PDF's text:
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
by the classes of CY/T 266; the edition qualifies at no more than one error per 10,000 characters. A judgement that
counts two points goes to a second reader before it is counted. The second reader does not see the first reader's
reason, and the stricter figure decides. The sample's pages are drawn from the commit hash, and a later sample avoids
the pages already read; layout characters count the running head and page number as lines, and repeated errors are
capped, both by CY/T 266. The bar is that of Article 5 of 《图书质量管理规定》. The cover and the edition line are read on
the release commit's PDF before the tag. Correct every error found, and its kind across the book, before the release; a
model's sample is a self-test, not a publisher's check, and is reported as such.

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

## Accept and deliver within scope

State whether review was author self-review, independent review or actual
teaching feedback. Do not relabel one as another. Record the exact artifact and
source binding through the existing evidence owner. A measured improvement
requires a declared comparison, not an adjective.

Preserve the prior edition and required failed receipts before promotion. Verify
the declared reader target, file bytes and retained originals after the effect.
Retire only exact owned residue whose consumers have released it. No remote
push or public release follows automatically from a local PDF build.
