# Companion exercises

These are wholly synthetic worked examples and templates for the field guide's data, code, API and work-design sections. They contain no business data and require no credentials or model service.

## Check all runnable examples

From the repository root, run:

```sh
just --justfile publication/justfile exercises
```

This uses existing Python 3.12, DuckDB, ast-grep and oasdiff installations.
It checks the complete data outputs and coverage, the intentionally failing
export and its correction, structural search, and changed/unchanged API
controls. The overall suite passes only when each example has its stated
outcome, including the deliberate failures. It installs nothing and requires
no PDF, browser, account or model. Individual commands remain below for readers
to inspect and explain; a passing suite is not proof of transfer to real work.

## Historical research snapshot

Use an existing DuckDB installation; the recorded command uses DuckDB 2.0.0.
Run from this directory:

```sh
duckdb -no-agent -csv < reconcile.sql
duckdb -no-agent -csv < quality.sql
```

The event date is 2026-10-30 and the cutoff is 2026-11-02 09:00:00 UTC.
This fixture reconstructs what the system could use at the cutoff.
Both `published_at` and `ingested_at` must be at or before the cutoff.
Filter eligibility before selecting a revision, ordered by revision,
publication time, ingestion time and `row_no`, all descending. S03's duplicate
deliveries are equivalent; this tie-break does not resolve conflicting values.
The expected universe is S01–S06. Preserve zero and negative returns, in basis
points; exclude missing returns without changing the coverage denominator.

Accepted values are S01=0, S02=-100, S03=60 and S06=40: coverage 4/6.
`expected-differences.csv` contains S01 (-5), S02 (-20), S05 (not accepted at
cutoff) and S06 (missing in snapshot). Single-sided differences have NULL
deltas. `expected-quality.csv` contains S04 (missing return), S05 (not available
at cutoff) and S99 (outside universe). Do not sum individual security returns
into a portfolio return. These checks establish synthetic contract differences,
not the production cause of an incident or investment validity.

## Source selection

`source-candidates.csv` fixes one synthetic purpose: historical decisions for
the six-security universe U6 over calendar 2024. Use authorization, full
coverage, revision history and availability timestamps are hard requirements;
only eligible sources are compared by onboarding days. The days measure initial
effort, not procurement, maintenance or exit cost. Run in one DuckDB session:

```sql
.read source-selection.sql
SELECT source_id, onboarding_days FROM selected;
```

The result is `new_vendor,5`. The incumbent covers only five securities; the
public final-value source has no revision history or availability timestamps.
In an exercise copy, change incumbent coverage to six: the result becomes
`incumbent,1`. Alternatively, withdraw the new vendor's authorization under the
original coverage: no source is eligible. Do not fall back to a source that
cannot answer the declared question. These assumptions do not establish any
real vendor's authorization, data quality or procurement acceptance.

## Keyed reconciliation

```sh
duckdb -no-agent -csv < entity-reconciliation.sql
```

Expected E01=6000 and E02=4000 are swapped in the observed table. Counts and
totals agree, but the full keyed comparison reports E01=-2000 and E02=+2000
in `observed_minus_expected`. This direction differs from the snapshot's
expected-minus-observed delta. Values are synthetic counts, not returns or
exposures. Production inputs also need key-uniqueness checks before the join.

## Effective-date mapping

```sh
duckdb -no-agent -csv < entity-mapping.sql
```

PAT01 belongs to OWNER_A before 2024-07-01T00:00:00Z and OWNER_B from that
instant onward. Half-open intervals resolve EV01 to OWNER_A and EV02 exactly at
the boundary to OWNER_B. EV03 uses PAT99, so its owner is NULL and its status
is `unmapped`. Overlapping intervals yield NULL / `ambiguous`, not an arbitrary
owner. The suite checks this overlap in memory without changing the fixtures.
All timestamps are explicitly TIMESTAMPTZ. The mapping describes event-time
ownership; historical knowledge additionally needs publication or acquisition
times. Fixing a mapping does not authorize expanding the research universe.

## Export regression

Use an existing Python 3 installation. The module contract preserves zero, positive and negative returns and excludes only `None`.

```sh
EXPORT_MODULE=export_bug python3 -B -m unittest -v test_export.py
EXPORT_MODULE=export_fixed python3 -B -m unittest -v test_export.py
```

The old module is expected to fail one of two tests (exit 1). The fixed module passes both (exit 0). Empty input is the control test. These results do not establish deployment or coverage of other invalid inputs.

## Review and cleanup

Read the contracts first. Explain scope, assumptions and results to a peer. Do not change expected output merely to obtain a pass. Delete only copies you created; preserve your task's own results when needed. The full machine-specific acceptance receipt remains with the original evidence owner, not in this portable bundle.

## Working templates and transfer practice

`task-brief.md`, `source-table.csv`, `evaluation-card.md` and `team-asset-review.md` are editable templates, not host policy or model-call approval. `transfer-cases.json` holds author-prepared transfer cases and rubric. These are known synthetic practice cases, not an independently frozen blind benchmark. Use a new authorized real task to assess transfer; preserve the distinction between self-review and independent review.

For the data transfer case, state the reconstruction purpose before choosing
time filters. Public visibility requires `published_at` at or before the cutoff;
operational availability requires both `published_at` and `ingested_at` at or
before it. Apply the chosen filters before revision ranking. In the existing
fixture, S02 is -80 bps under public visibility and -100 bps under operational
availability: revision 2 was published before the cutoff but ingested after it.
The runnable `reconcile.sql` and `quality.sql` retain their operational contract.

## Structural code search and API contract

Use already-installed ast-grep and oasdiff. The first command matches one
selected expression without editing the file. A match is not a defect verdict:
the export contract and behavioral test determine the business meaning.

```sh
ast-grep run --lang python --pattern 'row["return_bps"]' \
  --json=compact export_bug.py
```

The synthetic API revision removes `GET /research-snapshot`. The breaking comparison is
expected to return `api-path-removed-without-deprecation` and exit 1. The
unchanged control returns `[]` and exit 0. External references are disabled;
neither command starts a service or uploads a specification.

```sh
oasdiff breaking openapi-before.yaml openapi-after.yaml \
  --format json --allow-external-refs=false --fail-on ERR
oasdiff breaking openapi-before.yaml openapi-before.yaml \
  --format json --allow-external-refs=false --fail-on ERR
```

These checks were executed on the stated synthetic inputs. They do not prove
implementation conformance, runtime compatibility or full API coverage.

## Work design and convergence

`work-chain-design.md` helps identify inputs, native capabilities, outputs,
decision owners and stop conditions. `long-task-checkpoint.md` separates changed
evidence, the next discriminating action, retained originals and exact cleanup.
Use the relevant fields inside the task's existing brief or progress owner;
neither template authorizes a new service, scheduler or duplicate task ledger.
