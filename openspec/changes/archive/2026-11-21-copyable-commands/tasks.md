# Tasks

Scope: printed commands survive copying from the PDF. New scope enters as a task here before it is worked.

## 1. Contract

- [x] 1.1 The requirement "Printed commands survive copying" is stated beside "Printed commands work as pasted";
      done when `openspec validate --strict` passes.

## 2. Repair

- [x] 2.1 Inline code is kept whole by display width, and the long inline commands are rewritten; done when the
      page-by-page copy check finds no inline command split across lines.
- [x] 2.2 The wrapped shell lines are rewritten with unchanged behaviour; done when each rewrite gives the same
      argument, file or output as the printed original in a scratch run.
- [x] 2.3 A test fails when a line of a code block with a declared language does not print whole; done when it fails
      on the unrepaired layout and passes on the repaired one.

## 3. Qualification

- [x] 3.1 The light gates pass, the pages are rebuilt and the changed pages looked at, and the reader-run session
      confirms that the rewritten commands match the run records.
