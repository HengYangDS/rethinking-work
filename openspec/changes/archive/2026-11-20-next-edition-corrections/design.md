# Design

## Context

0.2.3 states the interactive starting mode as observed under one sign-in, lists two statements as resting on the
vendor's documentation, and prints chapter 14's second recall as one outcome. Since then: the vendor's page on
permission modes was read in full (`build/evidence/reader-run-corrections/starting-mode-docs/`); 103 headless runs on
2.1.311 and 2.1.329 checked what `acceptEdits` lets through and which helpers read the instruction files
(`paid-checks-20261120/`); the reader-run session ran the final text (91 of 92 blocks match) and reran chapters 12
and 14 three times each (`build/evidence/reader-run-0.2.3/`).

## Goals / Non-Goals

Goals: each corrected statement rests on a named run or the vendor's page, with its version; the prompts and side
effects a reader meets are named where the reader meets them.

Non-Goals: the owner's own reading (it enters when it comes); a release (his word); new checks or exercises; the
subscription sign-in (he decided on 2026-11-21 not to test it). Two items of the 0.2.2 run's report are not taken
up: the background `codex app-server` after `/exit` (one observation, on Codex 0.170) and the 683 MB runtime of a
first `hermes` run (its raw record was in the scratch home, which is gone).

## Decisions

- Starting mode: from the vendor's page — from 2.1.283, with no mode in the settings files, an interactive
  terminal session starts in `auto`, and in Manual when `auto` is unavailable; from 2.1.302, `claude -p` starts in
  `default`. The
  observation under an API-key sign-in stays as the check that agrees with it.
- `acceptEdits`: the six listed commands pass; `sed` passes only when it does not edit in place on macOS; output
  redirection into the working directory passes; the rest asks (runs on 2.1.311 and 2.1.329, two rounds each, and a
  `default` control in which all but `ls` ask).
- Helpers: general-purpose reads the instruction files, Plan and Explore do not (four runs on the two versions, and
  the reader-run session's one).
- Chapter 14: over five runs the second recall returned only observations four times and, once, the stored
  correction whose consolidation had not yet run; of the four, one showed neither the earlier rule nor the commit. The
  text says what may come back and how to read the facts behind it.
- Side effects are named at the step where they occur, in one sentence each, from the run records.

## Risks / Trade-offs

- A vendor update can change a default; each statement names the version it rests on.
- More sentences about prompts lengthen the exercises slightly; each is kept to the step where it appears.
