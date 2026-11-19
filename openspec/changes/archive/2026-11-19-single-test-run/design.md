# Design

See `proposal.md` for the reason and `specs/publication-source/spec.md` for the requirement.

## Context

The proof profile declares two test gates over one test suite:

- `publication-inputs` runs the task file's `test` recipe: it renders the diagrams, checks the PDF tools, then runs `unittest discover` under the host's `python3.12`.
- `source-behavior` runs `test-proof`, with the same prerequisites. It runs pytest in the locked uv environment and writes JUnit, a pytest event log and Cobertura coverage. ETHOS's `python_quality:behavior_report` then judges those reports.

Both gates run every test file in `tests/`. Coverage measures `tests/` and `exercises/`. ETHOS maps the `behavior` axis to `source-behavior` alone. `publication-inputs` adds no axis that ETHOS judges, only a second execution and its own dimension label.

The two runs differ in three ways:

- The interpreter. `sys.executable` is the locked environment's Python under `test-proof` and the host's Python 3.12 under `test`. The locked environment can import the eight test packages (`pytest`, `coverage`, `pygments` and others).
- The PATH that the tests' subprocesses see. `uv run` puts the locked environment's `bin/` first, so a child that asks for `python3.12` or `python3` gets the locked interpreter, and coverage follows it into the child.
- The runner's file pattern. unittest discovery takes `test*.py`; pytest by default takes `test_*.py` and `*_test.py`.

So the second run guarded one property: what the tests run with Python, including the reader's own exercise command that the archive test runs, needs nothing beyond the standard library. The reader runs the exercise contracts with a plain `python3.12` (`publication/reader-start.zh.txt`).

## Goals / Non-Goals

**Goals:** one execution of the suite per proof; the same evidence for every dimension the two gates declared; the standard-library property still enforced in the proof.

**Non-Goals:** changing any assertion or the document checks' CPU-time budget; changing ETHOS's readiness gates or admission; changing the local `test` and `check` recipes.

## Decisions

### D1. One test gate, carrying both dimensions

Remove the `publication-inputs` gate and add `publication-inputs` to the dimensions of `source-behavior`. Its command, native outputs, verification provider and timeout stay as they are.

The owner's `openai-responses-proxy` follows the same pattern: one command gate whose native reports a verification provider judges. ETHOS 0.2.0-beta.10 resolves the changed profile with no gap. It records `publication-inputs` as the only changed obligation, and the repository declares no independent verification for control replacement.

Alternatives considered:

- Keep both gates and split the test files between them. Coverage would then measure only half the suite. The diagrams would also render twice, unless one gate read the other's output, which would couple the gates.
- Keep both gates as they are. This is the cost the owner chose to remove.

### D2. The standard-library property, kept in two places

Two checks take over from the plain-interpreter run.

**Imports, read statically.** A test parses every Python file under `tests/` and `exercises/cases/` and collects the top-level module of each absolute import. The test fails if any of these modules is neither in `sys.stdlib_module_names` nor a module beside the importing file, meaning a `.py` file or package in the same directory, which is the script's import root. The failure message lists every file and module. It costs a few milliseconds and covers the tests themselves, which the second check does not run.

**The reader's command, run outside the test environment.** The archive test already runs the reader's command (`python3.12 -B -m unittest discover -s tests -p test_exercises.py`) in the extracted edition. It now starts that command with the locked environment's `bin/` removed from PATH and without `VIRTUAL_ENV`. The 17 exercise contracts, and the export contracts they run through `sys.executable`, therefore run under the host's Python 3.12, as a reader runs them. This also covers what the static check cannot see, such as a module named at run time. Under `just test` the environment is unchanged. The check costs nothing extra, because the subprocess already existed.

Alternatives considered:

- Run the whole suite again under the base interpreter. This brings back the second run.
- Rely on the static check alone. A review found that it misses `-m` and `-c` arguments, dynamic imports, and every child the tests start through PATH.

`exercises/templates/` is outside both checks. It holds files that readers run with tools they install for that purpose: `templates/eval/zero_task.py` imports `inspect_ai`, as the evaluation chapter and appendix A describe, and no test runs them.

### D3. One file pattern for both runners

`.config/checks/pytest/pytest.toml` declares `python_files = ["test*.py"]`, unittest discovery's pattern. A test file that `just test` finds is then also in the proof.

### D4. The timeout stays at 180 s

`source-behavior` keeps its 180 s hang guard, and its stated reason is rewritten for a single test gate. Two figures support 180 s:

- Hosted runners: they have taken up to twice the local time for the whole proof, and once more than twice for the former `publication-inputs` gate.
- The local run: it does what `source-behavior` did before, plus the static check.

## Risks / Trade-offs

- Children other than the reader's command still see the locked environment in the proof. Two examples: the book's hook script, which calls `python3`, and the archive recipe's inline `python3.12 -c`. The hook script runs the same export contract files that the reader's command runs outside the environment. The archive recipe imports only `json` and `sys`, and the publication job runs it outside uv. A dependency added there would show in that job, not in the proof.
- The local `check` recipe still runs everything under the plain interpreter. It is now the only full run there.
- Hosted savings are not yet measured. Neither forge's verification record keeps per-gate durations, so the saving shows only in the whole proof's time on each forge after the change reaches `dev`.

## Migration Plan

Nothing to migrate: both forges' CI jobs run the profile's proof.

Rollback restores the removed gate block, its entry in `code_correctness_gates` and the dimension list. The new test, the reader environment and the file pattern can stay.
