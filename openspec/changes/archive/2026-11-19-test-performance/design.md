# Design

## Context

See proposal.md for why. The `publication-inputs` gate runs `just --justfile publication/justfile test`: the task renders the six diagrams, checks the PDF tools, then runs every test module with unittest. The `source-behavior` gate runs the same modules under pytest with coverage. In `tests/test_publication.py` the document checks compile the book once in `setUpClass` and then run `typst eval` 32 times, on 29 distinct expressions from 22 call sites; each run lays out the whole book again.

On `52437dc`, under a host ticket, one run of the `publication-inputs` gate took 120 s: 8 s before the first test, 103 s in the document checks and 9 s in the other modules. One layout of the book took about 4 s, so the document checks spent nearly all their time repeating it. The ledger in the Change's local evidence records each measurement and each attempt, kept or reverted.

## Goals / Non-Goals

**Goals:**

- The cost of the document checks no longer grows with the number of checks.
- Each remaining cost is measured before and after its change, under a host ticket and through the gates' own commands.
- A regression of the measured kind fails the run on any host, without a number tuned to one machine.

**Non-Goals:**

- Changing what any check asserts, or which checks exist.
- Adding a dependency, plugin or test runner.
- Changing which gates the proof runs.

## Decisions

### One evaluation for every document fact

A table in the test module names each document fact a check reads and gives its Typst expression; the checks read facts by name. `setUpClass` evaluates one dictionary built from the whole table, so all facts come from a single layout of the book. The compile of the PDF does not depend on it and runs at the same time as a second process, so the setup costs about one layout of wall time.

Alternatives: caching `evaluate` by expression would still lay out the book once per distinct expression, 29 times. Reading the facts back from the PDF would replace native introspection with text scraping. A long-running `typst watch` would add a service to the suite.

If the combined evaluation fails, the class setup fails with Typst's message, which points at the failing fact inside the combined expression, and every document check fails with it. A first version fell back to evaluating each fact per check; review found that the fallback hid the failure behind a slow run of 33 layouts, which on a hosted runner would reach the gate timeout before naming the fact, and turned the budget off. A failure in the compile also reports Typst's message.

### Each view of the PDF read once, concurrently

The checks read four views of the built PDF through the task file's `pdf-tool`, which enters Brew's environment for each call. A second table names these reads. Once the PDF exists, `setUpClass` runs all of them at once and keeps each result; a failed read raises only in the checks that use it. The checks then do no subprocess work on the book or the PDF, which the budget below relies on.

Alternative: resolving the tools' paths once and calling them directly would bypass the task file's declared supply, which `tests/test_pdf_tools.py` exists to protect.

### Diagrams rendered concurrently

The six figure renders are independent Mermaid runs. Marking the task file's `diagrams` recipe `[parallel]` lets Just run them at once. The change is kept only if the gain exceeds run-to-run noise and the rendered bytes match those of sequential runs. Each render starts its own headless browser, so six run at once for a few seconds. Just supports the attribute from 1.42.0; the runners use the locked 1.59.0. Because the six outputs now interleave, a failed render prints its own name. The `build` task depends on `diagrams` too, so the delivered PDF's figures are rendered the same way; their bytes matched the sequential renders on this host, and the PDF built by each forge after landing is compared with the one built at the base.

### A budget measured in layouts of the book

The document checks take the CPU time of their one evaluation, a full layout of the book, as their unit, and each check must spend less than half of it, counting the test process and the children it waited for. A check that laid out the book again would spend nearly a whole unit: evaluating one fact alone took 0.93 of the combined evaluation in the first trial, so a bound of one whole unit let such a check pass. The checks themselves, reading shared facts and reads, spend a small fraction of a unit. CPU time rather than wall time, because the unit is measured while the compile runs beside it and the checks run after it: a first version measured wall time, and review showed that a loaded host during the evaluation could stretch the unit enough to let a second layout pass. The compile is reaped only after the measurement, so its CPU time does not enter the unit. The rule needs no number tuned to a host.

Alternatives: an absolute per-test or suite limit has to allow for the slowest hosted runner, and is then too loose to catch one extra layout on the workstation. A plugin such as pytest-timeout would bound only the pytest gate, and it adds supply.

### Edition archive as `.tgz`

The owner chose `.tgz` so that every governed repository delivers the same format; ETHOS manages release and checksums and leaves the format to each repository's build. The archive keeps its folder, notes, checksum list and its test. The system `tar` (bsdtar) writes it from a sorted file list, with the edition date already set on every file, no owner or group, no extended attributes, ACLs or flags, and no timestamp in the gzip header, so two builds of one commit give the same bytes and no host user name enters a release asset. Names beyond ASCII travel as UTF-8 in pax headers, which the archive test checks in place of the zip's UTF-8 flag. The archived `versioned-delivery` Change keeps its zip rationale as history.

Alternatives: Python's `tarfile` would give the same bytes, but the other repositories pack with `tar`. GNU tar is not part of the declared supply.

### Gate timeouts as the outer bound

Each test gate keeps an absolute `timeout_seconds` as the hang guard over its whole run, including diagrams and companion contracts. After this Change each test gate takes 15 to 17 s locally. Before it, hosted macOS runners took up to about twice the local time for the whole proof, and one hosted `publication-inputs` run passed 300 s against 142 s locally, more than twice. Both gates get 180 s: several times the expected hosted time, so a slow runner does not fail the proof, and short enough that a hang fails within three minutes. The reason is stated beside each in the profile.

## Risks / Trade-offs

- [A check needs more than one layout's worth of work] → it is restructured to read shared facts and reads, or this design's rule is changed with its measured reason; the budget is never raised as a number.
- [The compile and the evaluation running side by side double the peak CPU for a few seconds] → both run inside the gate's host ticket; on a host with few cores they still finish in about two layouts.
- [A time rule can flake under contention] → the rule compares CPU time, which host load changes little, and the observed margin is wide (a check at most a tenth of the unit, a second layout above nine tenths).
- [The `.tgz` is not unpacked on Windows here] → pax headers carry UTF-8 names by the POSIX standard, and Windows' bundled `tar` is libarchive; a Windows unpack is not run in this Change.
- [The budget is shown on this host only] → a hosted run after landing exercises the passing side; the failing side was shown here in both test gates.

## Migration Plan

Only test code and the task file change; rolling back means reverting the commit. No reader-facing output changes: the figures are byte-identical on this host, and the first forge build after landing is compared with the base build.
