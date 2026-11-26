# Tasks

## 1. Declare the layout's facts once

- [ ] 1.1 Declare the packages and their versions in `publication/layout/packages.typ`, import them from there, and
      print the colophon's versions from it and from the running compiler; done when no tracked file outside
      `packages.typ`, the supply manifest and the changelog names a package version, except where the retained
      publisher notice records the release it was copied from.
- [ ] 1.2 Name the type sizes by role, give the side margins from the paper and the text block, and declare the top
      and bottom margin and the language once; done when no `size:` in the layout, the figures or the front matter
      holds a number.
- [ ] 1.3 Set the cover and the contents in `publication/layout/front.typ` and declare the English title in
      `book/metadata.typ`; done when the front matter names no face, size or length.
- [ ] 1.4 Point the publication guide and the third-party notices to the files that pin packages and fonts; done when
      neither restates a version.

## 2. Let the checks read what the layout and the tasks declare

- [ ] 2.1 Declare the closing marks and the number pattern in the layout, and read them, the opening marks and the
      language in `tests/edition.py`; done when no test holds a copy of them.
- [ ] 2.2 Replace fixed lower counts with checks that something was found; done when no test compares a count of the
      book's content with a number.
- [ ] 2.3 Read the draft's commit from the archive task's inputs, the tools' time limit from `QUIET`, and declare the
      CI supply's fetch options once; done when the practice-pack test passes and the justfile repeats no option.

## 3. Accept

- [ ] 3.1 Build the PDF from the Change's head and from the head before it with the same inputs; done when the two
      files are identical and the compile has no warning.
- [ ] 3.2 State the requirement; done when `openspec validate declare-layout-once --strict` passes.
- [ ] 3.3 Answer each finding of the independent review in code or in this design; done when none is open.
