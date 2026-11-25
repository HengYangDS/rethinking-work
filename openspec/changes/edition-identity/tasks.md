# Tasks

## 1. Edition identity

- [x] 1.1 The justfile derives `edition_inputs` from git and passes them to the PDF compile and the archive; done when a
      build of an untagged commit prints 「草稿」 and its commit, and a build at a tag prints the edition and the tag's date.
- [x] 1.2 `book/metadata.typ` reads the identity from the build's inputs and writes no date by hand; done when no date
      literal is left in `book/`.
- [x] 1.3 The tests take the same inputs from the justfile and hold both states; done when the suite passes and a test
      evaluates the identity as draft and as release.
- [x] 1.4 The hosted publication job fetches a tag event's tag; done when `ethos lane project --check` reads the
      projections conforming.
