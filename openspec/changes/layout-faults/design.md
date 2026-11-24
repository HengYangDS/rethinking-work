## Context

See [proposal.md](proposal.md). The faults and their pages are in the 0.2.5 qualification's records
(`build/evidence/qualify-0.2.5/`).

## Goals / Non-Goals

**Goals:**

- Hold each fault by a layout rule and a test where a rule can hold it; repair the rest in the text.
- Keep the book at 198 pages with every chapter on its pages.

**Non-Goals:**

- Full-width quotation marks: Songti's quotation marks measure the same width in every tried setting, and GB/T
  15834—2011 5.1.11 allows compressing punctuation.
- Justification limits: limiting the opening between characters took the book to 208–209 pages.
- A release: tagging needs the owner's word.

## Decisions

- A lead-in is a paragraph that ends in a colon; it is made sticky to the next block. A long lead-in whose move left
  a page short past the bound is split so that only its last sentence sticks.
- A practice card holds its list and is a flow-block; its title's step is not counted as a line when deciding to set
  it whole.
- A code block's split is measured in printed lines from the PDF text, since an output line may wrap.

## Risks / Trade-offs

- [Rules move every page] → Every page is looked at again, and every changed sentence is read by a fresh reader.

## Migration Plan

Not applicable.
