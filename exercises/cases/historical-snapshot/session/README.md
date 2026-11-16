# Two sessions on the same snapshot

Both briefs were given to a sub-agent dispatched from a Claude Code session on
2026-11-14 (the sub-agent transcripts record Claude Code 2.1.325). Each
sub-agent worked in a directory holding the three CSV files of this case. The
files here are the briefs and the query the second session returned.

Conditions that shaped the result, stated so that the comparison is not
over-read:

- Each prompt began with one added paragraph naming the working directory.
  The first continued: work only in this directory, do not modify the three
  CSV files already here, do not access the network. The second continued:
  work only in this directory, do not access the network, run DuckDB as
  `duckdb -no-agent`.
- The sub-agents inherited the author's standing instruction files, about
  28,000 characters. Two of those rules matter here: ask first when the object,
  path or intent is ambiguous; hand off as facts, evidence, unproved items and
  next step. No tool allow-list and no cost cap were set.
- The first directory also held three leftover files from an earlier headless
  attempt that had failed to start. The session noticed them and reported that
  it did not use them as evidence.
- On 2026-11-15 each brief was given twice more, each time in a new directory
  holding only the three CSV files, under the same standing instructions. The
  outcomes matched: the one-sentence brief was not answered with a guessed
  rule in any of the three runs; the five-item brief returned the same three
  values and stopped after the batch in all three. The files here are from the
  first run of each.

What each file is:

- `brief-vague.txt`: one sentence. The session found that no cutoff instant
  reproduces the snapshot, reported that the cutoff, the clock and the null
  policy were undecided, and did not guess a rule. That matches the standing
  rules. These runs all carried the rules, so they do not show the cause; the
  control group below was run without them.
- `brief-precise.txt`: purpose, objects, rule, boundary, deliverable, and a
  first batch of three securities. The session returned S01 = 0, S02 = -100,
  S03 = 60 with each excluded version and its reason, and stopped after the
  batch as asked.
- `query.sql`: the second session's query, unchanged. Run it in the parent
  directory, where the CSV files are, with
  `duckdb -no-agent -csv < session/query.sql`.

To cover the whole universe, copy the case directory and remove the batch
filter in the copy:

```sh
grep -v "security_id IN ('S01'" session/query.sql > full.sql
duckdb -no-agent -csv < full.sql
```

The pack's own check reads `query.sql` unchanged, so do not edit it in place.
No file in the case directory was modified by either session.

## Control group without the standing rules

On 2026-11-16 the one-sentence brief was run six more times as one group, to
see what the "ask first" rule changes. `control/` holds the six final answers,
unchanged.

Conditions:

- Claude Code 2.1.311, started headless with `claude -p` from a directory
  holding only the three CSV files; one model throughout (Claude Opus 5.5).
- None of the author's instruction files, user settings, hooks, plugins or MCP
  servers were loaded (`--setting-sources project --strict-mcp-config`); the
  environment was reduced to a few variables such as `HOME` and `PATH`, with a
  shell that has no aliases. One settings file was passed with `--settings`;
  it carried only what is needed to reach the model.
- `--permission-mode dontAsk` with an allow-list without `Edit` or `Write`
  (`Read`, `Glob`, `Grep` and shell prefixes such as `Bash(cat *)` and
  `Bash(duckdb *)`), and `--max-budget-usd 1`.
- The one difference: three directories also held an `AGENTS.md` with one line:
  `对象、口径有歧义，先列出来问，不要自己定。` The other three held no
  instruction file.

What the answers show:

| | `no-rule-1..3.txt` | `rule-1..3.txt` |
| --- | --- | --- |
| Verdict | Given at the opening in all three | Given in none |
| Conventions | Partly chosen by the session: two state the basis they checked against, one states which clock must be used; two recommend keeping the empty row, one says keep it or attach a list of exclusions | Cutoff, clock and null handling listed as questions in all three |
| Question to the user | At the end: the cutoff in all three, the clock in two | Before any verdict: at the opening in one, after a data summary in one, after a list of confirmed facts in one |
| Missing S06 | Reported in all three | Reported in all three |

Limits: three runs each, one model, one task. This group is not comparable
with the sessions above, which ran as sub-agents on another model under the
author's full instruction files.

A first round of six runs is not included. In it the shell's `ls` was an alias
that printed nothing and returned success, so every session saw only the
snapshot file it had been told about and reported that the directory held no
data to compare against. The CSV files were there. Check that the first
listing shows three files before reading any answer.

## The five-item brief on two models

`brief-precise.txt` was also run once on a stronger and once on a lighter
model of the same family (Claude Opus 5.5 and Claude Haiku 5.5), under the
conditions above with its own allow-list, which adds `Write`, and no
instruction file. `control/model-strong.txt` and `control/model-light.txt` are
the final answers; in the second, the absolute path of the scratch directory
is shortened to the file name, and nothing else is changed.
`control/model-light-query.sql` is the lighter model's saved query.

| | Strong | Light |
| --- | --- | --- |
| S01, S02, S03 | 0, -100, 60 | 0, -100, 60 |
| Query | Saved and run by the session | Saved, never run; as saved it fails because it reads the three CSV files as existing tables; it also compares the times as text |
| Report | Says the query was run and that one edit was denied | Says nothing was executed and the values were worked out by reading; adds that no SQL engine was available, which no step had checked |
| Turns, wall time | 8, 66 s | 6, 137 s |
| Cost reported by the host | 0.31 USD | under 0.01 USD |

The lighter session's first shell command contained a loop and was denied;
it did not try another command. Every shell command of the stronger
session was allowed, so part of the difference is that denial, not the model.
One run each. The cost is the host's estimate at list prices, not a bill.

To run the lighter model's query, load the files under the names it assumed:

```sh
duckdb -no-agent -csv \
  -c "CREATE TABLE universe AS SELECT * FROM read_csv('universe.csv');" \
  -c "CREATE TABLE source_observations AS SELECT * FROM read_csv('source-observations.csv', all_varchar=true);" \
  -c "CREATE TABLE research_snapshot AS SELECT * FROM read_csv('research-snapshot.csv');" \
  -c ".read session/control/model-light-query.sql"
```
