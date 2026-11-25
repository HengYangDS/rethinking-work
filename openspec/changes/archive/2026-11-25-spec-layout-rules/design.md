## Context

See [proposal.md](proposal.md). The tests are `tests/test_layout.py` (`test_table_columns_align_as_their_contents_read`,
`test_quotation_marks_take_full_cells`, `test_no_page_ends_with_a_lead_in`, `test_lead_ins_are_spaced_as_paragraphs`,
`test_justified_lines_keep_chinese_characters_close`); the declarations are in `publication/layout/style.typ`.

## Goals / Non-Goals

**Goals:**

- The specification states every behavior a test holds.

**Non-Goals:**

- Merging the overlapping requirements the review named (two on runs, two on printed commands, two on acceptance, four
  on Chinese prose), or splitting the capability; each merge needs its own reading of what the pair holds.

## Decisions

- One requirement for the four layout behaviors, since one module declares them and one test file holds them.

## Risks / Trade-offs

- None.
