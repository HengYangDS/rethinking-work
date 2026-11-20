# Design

## Context

The reader run of 0.2.2 (2026-11-20, `build/evidence/reader-run-0.2.2/`) ran the 90 printed shell blocks in a scratch account: Claude Code 2.1.311 and Codex 0.170 in interactive sessions typed into a terminal, Hermes 0.23.2 in a fresh data directory, `zsh -f` for model-free blocks. Its table names each differing block with the source line and the effect on a reader. The experiments the book rested on until then (appendix D, second kind) were headless `claude -p` runs in the `dontAsk` mode. Three of the book's statements were true of those runs and wrong as generalised to an interactive session: the starting mode, the hook exercise's mode, and what a helper reads.

## Goals / Non-Goals

**Goals:**

- A reader who follows the book is not charged for a run he did not ask for, sees the boundary exercise hold, and is not stopped by a printed command.
- Each corrected statement rests on a recorded run, on the vendor's documentation or the program's source, and appendix D says which.
- The three defects that are properties of printed commands cannot return unnoticed.

**Non-Goals:**

- New material, or a rewrite of the chapters around the corrected lines.
- The items the run found unmentioned rather than wrong.
- The owner's reading notes.

## Decisions

### Chapter 13 starts in `default`; the hook is not widened

Two remedies were open: widen the hook to shell commands, or start the session in a mode that asks before a shell command. Widening would have the hook parse a command line to find the files it writes, which a short script cannot do reliably, and the chapter's point is the opposite: a boundary covers the paths it was put on, and the others need their own guard. In `default` the reader is that guard. The vendor's documentation states the order (a `PreToolUse` hook runs before the permission prompt; exit 2 stops the call before any rule or prompt) and that `acceptEdits` approves file edits and common filesystem commands in the working directory without a prompt. The two `acceptEdits` runs stay in the text as the worked instance of the chapter's closing sentence. The documentation's list of commands that mode approves does not contain the `echo` redirection the runs used, so the text gives the observation and the list side by side and explains neither by the other.

### The scheduled job: the warning stands beside the command

The removal is printed directly after the registration, with the cost of a run, because a reader who stops after the block must already know. Chapter 20 names the trigger where it happens: dispatching starts the account's gateway. That a gateway started this way ends itself once idle is stated in Hermes's source and was not observed, so the book does not say it.

### Helpers by type

The book's experiment used a general-purpose helper, which read `AGENTS.md`. The reader run's two helpers were of the built-in Explore type and received no project instructions. The vendor's documentation settles the difference without another paid run: Explore and Plan start without the instruction files, other built-in and custom helpers load them. The chapter states both, the exercise reads the helper's type from its `.meta.json` before judging its last sentence, and the advice follows the documentation: a rule a helper must keep is restated in the brief.

### The starting mode and the commands that continue a session

An interactive session without `--permission-mode` and without a setting starts in `auto` on the book's version (three reads in the clean account; the vendor's documentation says the same for 2.1.283 and later); `claude -p` starts in `default`. The chapter says so, and the printed `--continue` and `--resume` commands carry the option, as the first start already does. Chapter 13 held the old statement in a second place and is corrected with it, and the three later exercises that start a session without printing the command now print it.

### The check reads the printed blocks from the laid-out document

Three rules, each a property of commands, none a sentence: a shell block holds no word beginning with `#` outside quotes and here-document bodies (a block that is a script, beginning with `#!`, is left out); a line that starts a background process is followed by a `sleep`; a block that registers a scheduled job is followed, before the next such block, by a removal command anywhere in the text. The check uses the list of code spans the suite already evaluates, extended by each span's language and whether it is a block. On the text of 0.2.2 it fails on all three.

### What rests on what

| Correction                                   | Basis                                                                      |
| -------------------------------------------- | -------------------------------------------------------------------------- |
| Job is live; dispatch starts the gateway     | reader run, once; the gateway's start log, three seconds after dispatch    |
| `acceptEdits` writes through the shell       | reader run, two of two; vendor documentation                               |
| The exercise in `default`                    | vendor documentation; not yet run as printed                               |
| Trailing comments                            | reader run; repeated here in `zsh -f -i`                                   |
| Wait before the request                      | reader run, 0 of 5 without it; run here with it                            |
| Starting mode                                | reader run, three reads; vendor documentation                              |
| Helpers by type                              | the book's run (general), reader run (Explore, once); vendor documentation |
| AIGW items, graph numbers, observation delay | reader run, once each                                                      |

## Risks / Trade-offs

- The chapter 13 exercise in `default`, the helper exercise and the continued session's mode are corrected from documentation and are run as printed only in the re-check that follows this Change's commit. The paid part of that re-check needs the owner's cap. If it does not happen before the release, appendix D says that these three rest on documentation.
- The edition carries the layout rules landed since 0.2.2, so its page numbers differ from 0.2.2 by up to four pages; the heading-by-heading map is in `build/evidence/page-foot-gaps/`.
- A vendor may change a mode's behaviour again. The back matter names the versions the statements belong to.
