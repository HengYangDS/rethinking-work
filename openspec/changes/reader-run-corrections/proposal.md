# Proposal

## Why

On 2026-11-20 every command block printed in edition 0.2.2 was run as a reader runs it: with a new empty home directory under the same system user, pasted or typed into an interactive shell, with the hosts started by the printed commands. Of 90 blocks, 80 gave what the book says, 9 differed and 1 (four install commands) was only dry-run. Three differences harm a reader:

- Chapter 18 registers a scheduled job that calls a model every weekday at 7:30 and never has the reader remove it. A later command of chapter 20 starts the scheduler, and the job then runs by itself; in the run it did, once.
- The boundary exercise of chapter 13 fails as printed. In the `acceptEdits` mode the host wrote the protected file through a shell command without asking, the hook never fired, and the instruction to refuse the request could not be followed. Two runs of two.
- Two printed commands of chapter 10 carry trailing `#` comments. The default interactive zsh of macOS passes them to the command, which fails.

Six more blocks differ without stopping the reader, and four statements in the prose are contradicted. The run's report is the Change's local evidence source, `build/evidence/reader-run-0.2.2/REPORT.md`. The owner decided on 2026-11-20 to issue a corrected edition (「出更正版」).

## What Changes

- Chapter 18: the registered job is declared live, with its cost, and removed by a printed command; chapter 20 says that dispatching starts the scheduler.
- Chapter 13: the exercise starts in the `default` mode, where the hook runs before the host's prompt; the text says why `acceptEdits` is not used and what happened in it. The mode table states what `acceptEdits` lets through.
- Chapter 10: the two commands lose their comments and stand in two blocks. The starting mode is stated as it was seen: an interactive session without the option started in `auto`, under the one sign-in tried. The commands that continue a session name the mode. The choices of a permission prompt are named as the host shows them.
- Chapter 19: both blocks wait a second between starting a background process and requesting it.
- Chapters 9, 11 and 14: the prerequisite of a configured AIGW, the two items a configured machine does not show, the two graph numbers, the composition of the default search result, and the delay before an observation appears.
- Chapter 20 and the appendices: a helper reads the project's instruction files only when it is of the general type; the built-in Explore and Plan types do not. The exercise checks the helper's type first.
- Appendix D records the conditions of the reader run and the runs these corrections rest on.
- A check fails when a printed shell block carries a `#` word outside quotes, requests a background process without a wait, or registers a scheduled job that nothing removes.
- Release 0.2.3 with these corrections and the changes already on `dev` since 0.2.2.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: a printed shell block SHALL give the stated result when pasted whole into an interactive shell with default options, and a printed registration of a job that later runs by itself SHALL be followed by its removal.

## Impact

Affected:

- `book/parts/`: `agent.typ`, `first.typ`, `context.typ`, `boundaries.typ`, `memory.typ`, `run.typ`, `diagnose.typ`, `orchestrate.typ`.
- `book/back-matter.typ`: appendix B's commands, appendix C's line on helpers, appendix D's conditions and table.
- `tests/test_publication.py` and `tests/README.md`: one check and the facts it reads.
- `VERSION`, `CHANGELOG.md`, the edition's date.

Out of scope:

- Statements the run found unmentioned rather than wrong: the first launch's theme picker and notices, the daemon Codex leaves, the 683 MB runtime a first Hermes run prepares, a file an exercise leaves in the current directory.
- The sample of chapter 20 that prints nine events where the run had eight; the book already says the sample is another run.
- The owner's reading notes, which make the edition after this one.
- Any change to the exercises' files.
