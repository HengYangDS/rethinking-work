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
- The lead-in is wrapped in a block to make it sticky, and Typst spaces a block after a paragraph by the block's own
  space above, and two blocks by the larger of their spaces. So a state records what was set last (a paragraph, a
  lead-in, or another block, recorded at a block's start and end): a lead-in takes the paragraph step above it only
  after a paragraph or a lead-in, and nothing below it; a paragraph after a lead-in takes the paragraph step. Each
  transition then keeps the step it has without the rule.
- Lists, code blocks and tables have no space of their own, as a paragraph has none: after a lead-in they take the
  paragraph step, and what follows them is spaced as after a paragraph. Codly sets each line of code as a paragraph,
  so a paragraph set in the code face is left to codly. Giving a table the paragraph step on both sides instead also
  spaced it further from a following sample box and from a chapter's opening line than 0.2.5 does, so it was not
  kept.
- The test of these rules compiles a specimen twice, once with its paragraphs ending in a colon and once in a full
  stop, and requires the same steps between all lines. The first page looks found the spacing faults that the
  whole-book checks had passed: a check of steps between flush body lines does not see a code box or a table.

## Risks / Trade-offs

- [Rules move every page] → Every page is looked at again, and every changed sentence is read by a fresh reader.

## Migration Plan

Not applicable.
