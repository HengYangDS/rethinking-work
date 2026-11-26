# Tasks

## 1. Keep the runner supply in the account's caches

- [x] 1.1 Declare the faces' folder in the account's cache and name it to Typst in every task; done when `ci-supply`
      writes nothing into the account's font folder and `just --command env` shows `TYPST_FONT_PATHS` at that folder.
- [x] 1.2 Take Typst's package cache from the compiler and list the manifest's files relative to it; done when the
      manifest checks against the cache that `typst info` reports and the package-supply check passes.
- [x] 1.3 Describe the supply's place in the publication guide; done when no document names the account's font folder
      as the place of the faces.

## 2. Accept

- [x] 2.1 Build the PDF from the Change's head and from the head before it with the same inputs; done when the two
      files are identical and the compile has no warning.
- [x] 2.2 Remove the faces the old task installed in the font folders of the two GitLab runner accounts; done when
      neither folder holds a `rethinking-` face.
- [x] 2.3 State the requirement; done when `openspec validate runner-supply-cache --strict` passes.
- [x] 2.4 Answer each finding of the independent review in code or in this design; done when none is open.
