# Tasks

## 1. The standard in the repository

- [x] 1.1 The skill `book-chinese-prose` holds the terms, translated forms, human voice and reading brief, routed for
      `book/**`; done when ETHOS's skill portfolio check reports no gap.
- [x] 1.2 The acceptance document's readability reading names the skill's four lenses; done when
      `openspec validate --all --strict` and the light checks pass.

## 2. The book

- [x] 2.1 Every chapter is revised to the skill; done when each file's Typst markup counts and code blocks equal the
      base, no file grows, and 「有权决定的人」 no longer occurs.
- [x] 2.2 Readers who did not edit read the book in parts of about thirty pages; done when every finding is fixed or
      declined with its reason.
- [x] 2.3 Chapter 29 states what assessment is for, tells the member the result, and leaves six procedural details to
      the department's guidelines; done when the chapter holds no rule the guidelines do not.
- [x] 2.4 The edition stays within its ceiling; done when the build has at most 200 pages and every chapter start equals
      the base.
- [x] 2.5 A reader who did not edit checks the changed passages against the base for meaning, facts and conditions;
      done when every point is settled.
- [x] 2.6 Word choice and composition are polished to `references/composition.md` and a whole-book structure review;
      done when every finding is applied, declined with its reason, or settled by the reviewers, and the build stays
      within 200 pages.

## 3. Acceptance and landing

- [ ] 3.1 The commands review and the reading are recorded in `publication/acceptance/reviews.toml`; done when
      `tests/test_acceptance.py` passes.
- [ ] 3.2 The full proof passes on the archived head; done when the lane lands on `dev` and both forges' CI is green.
