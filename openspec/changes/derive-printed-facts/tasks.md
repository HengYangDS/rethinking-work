# Tasks

## 1. Derive the printed structure

- [x] 1.1 Number chapters, practices and appendices by kind from the reading order and parts by their place; done when
      the evaluated chapter marks and the PDF's text equal those of the head before the Change and the layout converges
      without warnings.
- [x] 1.2 Derive references to parts and the first part's chapter count, and add a prose rule for a part written by
      hand; done when the rule's cases pass and the book has no finding.

## 2. Declare the edition's facts once

- [x] 2.1 Declare the archive's names, the pack's place, the companion appendix's title and the check command in
      `book/metadata.typ`, and print the pack's place through `pack-code`; done when the PDF's text is unchanged.
- [x] 2.2 Fill the archive, both reader notes and the exercises task from the declaration, and make the practice-pack
      test read it; done when the test passes and the built notes name every declared value.
- [x] 2.3 Move the reader notes to `publication/notes/` and record that tree in commands reviews; done when the
      acceptance test refuses a head whose notes no review covers.
- [x] 2.4 Name chapters outside the book by file or title; done when no tracked file outside `book/`, the changelog and
      the archive names a chapter, part or appendix by number.
- [x] 2.5 State the requirements; done when `openspec validate derive-printed-facts --strict` passes.

## 3. Review

- [ ] 3.1 Answer each finding of the independent review in code or in this design; done when none is open.
- [ ] 3.2 Record the commands review and the reading of the changed `book/`, `exercises/` and note passages; done when
      the acceptance test passes on the head.
