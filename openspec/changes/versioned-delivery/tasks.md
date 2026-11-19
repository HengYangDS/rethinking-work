# Tasks

## 1. Version on the edition

- [x] 1.1 `book/metadata.typ` reads the version from `VERSION` and the `<edition-identity>` metadata carries it; done when `typst query` returns it.
- [x] 1.2 The cover prints the version beside the date; done when the PDF identity test checks the cover against `VERSION` and passes.

## 2. One edition archive

- [x] 2.1 The packaging recipe builds `rethinking-work-<version>.zip` with the reader note, versioned PDF, `实战练习/` and `SHA256SUMS`, writing names with the UTF-8 flag; done when the archive test extracts it, checks every checksum, finds both notes stating `VERSION`, and runs the exercises.
- [x] 2.2 Both reader notes are templates filled from `VERSION`; done when no hand-written date or version remains in them and the recipe refuses a leftover token.
- [x] 2.3 Both forges' CI keep the archive as the job artifact; done when the GitHub and GitLab definitions name it and `ci-artifacts` prints its SHA-256.

## 3. Reader text and records

- [x] 3.1 Appendix A and the eight example `PACK=` lines follow the archive layout; done when no manuscript line names the old folder.
- [x] 3.2 README states how the version reaches the edition; `VERSION` is 0.2.1 and `CHANGELOG.md` has its section; done when the format check passes.

## 4. Qualification

- [x] 4.1 The full check passes and the rebuilt PDF differs from 0.2.0 only by the cover line and appendix A's changed passages; done when the text comparison shows no other difference.
