# Practice cases

Synthetic teaching data for 《重新理解工作》. Nothing here is business data.

## What is here

- `cases/<name>/`: one case per directory, with its inputs, queries or code,
  and the expected result.
- `templates/`: cards to copy into a real task.
- `assessment/transfer-cases.zh.md`: the same problems under changed conditions.

## Conventions an Agent cannot guess

- All timestamps are UTC. A cutoff written without a time zone is an error.
- Returns are in basis points. Zero is a value; an empty cell means unknown.
  Never fill an empty cell.
- "Available at a cutoff" means published and ingested no later than it.
- A security outside `universe.csv` is out of scope, not missing.

## How to check

In the directory above this one, run the command that its `先读.txt` gives; the
command names the Python line the checks run on. In the source repository, which
has no `先读.txt`, run `just --justfile publication/justfile exercises` there.

Expected: a line `Ran … tests` with the number of checks, then `OK`. Run DuckDB as
`duckdb -no-agent`.

## Do not

- Edit a file whose name starts with `expected-`, or any input CSV. To try a
  changed condition, copy the case directory and work in the copy.
- Report a check as passed without the command and its output.
