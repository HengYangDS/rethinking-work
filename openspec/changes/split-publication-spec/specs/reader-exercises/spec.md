## Purpose

Make each command a reader pastes from the book and each companion exercise a reader runs give the result the text states, on the reader's own machine and Python, outside the repository's locked environment.

## ADDED Requirements

### Requirement: Tests and exercises need only the standard library

Every Python file under `tests/` and `exercises/cases/` SHALL import only Python's standard library and modules in its own directory. The proof SHALL run the reader's exercise command from the edition archive under the host's Python, outside the locked test environment. Either check SHALL fail the run when its condition does not hold, even where the locked test environment provides the package.

#### Scenario: A test file imports a package outside the standard library

- **WHEN** a Python file under `tests/` or `exercises/cases/` imports a package that is neither part of Python's standard library nor a module in the file's own directory
- **THEN** a test fails and lists the file and the package, although the locked test environment can import that package.

#### Scenario: An exercise needs a package only at run time

- **WHEN** an exercise contract loads a package outside the standard library by a name computed at run time
- **THEN** the reader's exercise command fails in the archive test, as it would for a reader, and the proof fails.

### Requirement: Printed commands work as pasted

A printed command SHALL give the stated result when a reader copies it from the PDF and pastes it whole into an interactive shell with default options. A printed command that registers a job which later runs by itself SHALL be followed, before the next such registration, by the command that removes it.

#### Scenario: A reader pastes a block into the default macOS terminal

- **WHEN** a printed shell block is pasted whole into an interactive zsh without `interactivecomments`
- **THEN** no word beginning with `#` reaches a command, and the block gives the result the text states.

#### Scenario: A block starts a listener and requests it

- **WHEN** a printed block starts a process in the background and then sends it a request
- **THEN** a wait stands between the two lines, so that the request does not arrive before the process listens.

#### Scenario: A chapter registers a scheduled job

- **WHEN** a printed command registers a job that a scheduler will run by itself
- **THEN** the text says that the job is live and what a run costs, and the command that removes it follows before the next registration.

#### Scenario: A printed block gains a trailing comment

- **WHEN** a change adds a `#` comment to a printed command, removes the wait after a background start, or removes a job's removal command
- **THEN** a check fails and names the page.

#### Scenario: A reader copies a command from the PDF

- **WHEN** a reader copies a line of a code block with a declared language, or an inline command, from the PDF
- **THEN** the copy holds the line as printed, with no line break inside it.

#### Scenario: A printed line grows wider than its block

- **WHEN** a change makes a line of a code block with a declared language too wide to print on one line
- **THEN** a check fails and names the page.
