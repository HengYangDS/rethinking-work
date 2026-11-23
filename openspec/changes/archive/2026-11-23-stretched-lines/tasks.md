# Tasks

Scope: Chinese characters opened by justification in the body text. New scope enters as a task here before it is worked.

## 1. Contract

- [x] 1.1 "Typeset output keeps to its declared supply" covers the opening of justified body lines; done when
      `openspec validate --strict` passes.

## 2. Check

- [x] 2.1 The layout declares `open-most` and a test measures every body line against it; done when the test fails on
      the book of `6726521`.

## 3. Repair

- [x] 3.1 No body line opens past `open-most`; done when the test of 2.1 passes with the lone-character, split and
      page-ceiling tests.
- [x] 3.2 A hook that exits 0 is no longer said to 放行 a call, which in chapter 13 means a call that runs without
      asking: chapter 13 says again that the host still asks about a call the hook did not refuse (「它没有拒绝的」,
      as before 838730d), its script 「不加阻拦」 or 「以 0 退出」, appendix D's hook 「拒绝 `work/` 以外的修改」, and
      chapter 12's RTK hook leaves a command 「保持原样」. Reported by the reader of the printed commands and the cold
      reader at 10:5x–11:0x; done when the five places read so and the layout tests pass.

## 4. Qualification

- [x] 4.1 The light gates pass, every changed sentence is read by a reader who did not write it, and the changed pages
      are looked at.
