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
[official publication-source specification](../openspec/changes/publication-foundation/specs/publication-source/spec.md).
This guide explains their execution; it is not another acceptance or progress
register.

## Check complete meaning

Read the complete changed prose and its qualifications. Verify that examples
teach the stated mechanism, sources support material claims, and conditions or
unknowns have not vanished during polishing. In a structural migration, compare
the complete native raw examples, table children and figure captions with the
preserved predecessor. Equal counts alone do not establish content preservation.

Follow the argument as a new reader, not as the person who remembers its sources.
For each consequential case, identify the real work question, uncertainty,
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
issues; inspect dense and changed pages at readable size. Automated geometry
checks complement this judgment rather than replacing it.

## Accept and deliver within scope

State whether review was author self-review, independent review or actual
teaching feedback. Do not relabel one as another. Record the exact artifact and
source binding through the existing evidence owner. A measured improvement
requires a declared comparison, not an adjective.

Preserve the prior edition and required failed receipts before promotion. Verify
the declared reader target, file bytes and retained originals after the effect.
Retire only exact owned residue whose consumers have released it. No remote
push or public release follows automatically from a local PDF build.
