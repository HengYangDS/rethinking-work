# Tasks

Scope: the book's decided wording and decidable Chinese punctuation, as rules over `book/`. New scope enters as a task
here before it is worked.

## 1. Contract

- [x] 1.1 "Book prose keeps its decided wording" is stated; done when `openspec validate --strict` passes.

## 2. Rules

- [x] 2.1 The `book` style holds the three rules with their sources and dates and cases; done when `vale test --coverage`
      passes and the rules fail on the book of `8af23aa`.

## 3. Repair

- [x] 3.1 The book keeps its decided wording; done when Vale reports nothing over `book/` and the layout tests pass.

## 4. Gate

- [x] 4.1 Vale is in the locked toolchain and a proof gate runs the cases and the rules; done when `prose-check` passes
      with the locked Vale and ETHOS's profile reader lists the `book-prose` gate. The full proof of the archive head
      runs it.

## 5. Qualification

- [x] 5.1 The light gates pass, every changed sentence is read by a reader who did not write it, and the changed pages
      are looked at.
