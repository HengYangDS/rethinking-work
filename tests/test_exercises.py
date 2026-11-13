"""Exercise the synthetic teaching contracts through their installed native tools."""

import csv
import io
import json
import os
import subprocess
import sys
import unittest
from pathlib import Path

EXERCISES = Path(__file__).resolve().parents[1] / "exercises"


def run(*arguments, input=None, env=None):
    return subprocess.run(
        arguments,
        cwd=EXERCISES,
        input=input,
        stdin=subprocess.DEVNULL if input is None else None,
        capture_output=True,
        text=True,
        timeout=60,
        env=env,
        check=False,
    )


def csv_rows(text):
    return list(csv.reader(io.StringIO(text)))


class CompanionExercises(unittest.TestCase):
    def test_snapshot_differences_match_complete_expected_csv(self):
        result = run(
            "duckdb",
            "-no-agent",
            "-csv",
            input=(EXERCISES / "reconcile.sql").read_text(),
        )
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(
            csv_rows(result.stdout),
            csv_rows((EXERCISES / "expected-differences.csv").read_text()),
        )

    def test_quality_exceptions_match_complete_expected_csv(self):
        result = run("duckdb", "-no-agent", "-csv", input=(EXERCISES / "quality.sql").read_text())
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(
            csv_rows(result.stdout),
            csv_rows((EXERCISES / "expected-quality.csv").read_text()),
        )

    def test_cutoff_preserves_values_and_universe_coverage(self):
        sql = (EXERCISES / "reconcile.sql").read_text()
        result = run(
            "duckdb",
            "-no-agent",
            "-csv",
            input=sql + "\nSELECT security_id,return_bps FROM accepted ORDER BY security_id;\n",
        )
        self.assertEqual(result.returncode, 0, result.stderr)
        rows = csv_rows(result.stdout)
        header = rows.index(["security_id", "return_bps"])
        accepted = rows[header + 1 :]
        self.assertEqual(accepted, [["S01", "0"], ["S02", "-100"], ["S03", "60"], ["S06", "40"]])
        universe = csv_rows((EXERCISES / "universe.csv").read_text())[1:]
        self.assertEqual((len(accepted), len(universe)), (4, 6))

    def test_original_export_fails_only_the_nonmissing_return_contract(self):
        result = run(
            sys.executable,
            "-B",
            "-m",
            "unittest",
            "-v",
            "test_export.py",
            env=os.environ | {"EXPORT_MODULE": "export_bug"},
        )
        self.assertEqual(result.returncode, 1, result.stderr)
        self.assertIn(
            "test_empty_input (test_export.ExportContract.test_empty_input) ... ok",
            result.stderr,
        )
        self.assertIn("FAIL: test_keeps_zero_and_negative_return", result.stderr)
        self.assertIn("Ran 2 tests", result.stderr)
        self.assertIn("FAILED (failures=1)", result.stderr)

    def test_fixed_export_passes_both_contracts(self):
        result = run(
            sys.executable,
            "-B",
            "-m",
            "unittest",
            "-v",
            "test_export.py",
            env=os.environ | {"EXPORT_MODULE": "export_fixed"},
        )
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn("Ran 2 tests", result.stderr)
        self.assertTrue(result.stderr.rstrip().endswith("OK"), result.stderr)

    def test_structural_search_finds_the_selected_expression(self):
        result = run(
            "ast-grep",
            "run",
            "--lang",
            "python",
            "--pattern",
            'row["return_bps"]',
            "--json=compact",
            "export_bug.py",
        )
        self.assertEqual(result.returncode, 0, result.stderr)
        matches = json.loads(result.stdout)
        self.assertEqual(len(matches), 1)
        self.assertEqual(matches[0]["text"], 'row["return_bps"]')
        self.assertEqual(Path(matches[0]["file"]).name, "export_bug.py")

    def test_removed_api_path_is_a_breaking_change(self):
        result = run(
            "oasdiff",
            "breaking",
            "openapi-before.yaml",
            "openapi-after.yaml",
            "--format",
            "json",
            "--allow-external-refs=false",
            "--fail-on",
            "ERR",
        )
        self.assertEqual(result.returncode, 1, result.stderr)
        findings = json.loads(result.stdout)
        self.assertEqual(len(findings), 1)
        self.assertEqual(findings[0]["id"], "api-path-removed-without-deprecation")
        self.assertEqual(
            (findings[0]["operation"], findings[0]["path"]),
            ("GET", "/research-snapshot"),
        )

    def test_unchanged_api_is_the_control(self):
        result = run(
            "oasdiff",
            "breaking",
            "openapi-before.yaml",
            "openapi-before.yaml",
            "--format",
            "json",
            "--allow-external-refs=false",
            "--fail-on",
            "ERR",
        )
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(json.loads(result.stdout), [])

    def test_explicit_utc_cutoff_is_independent_of_session_timezone(self):
        for timezone in ("UTC", "Asia/Shanghai"):
            with self.subTest(timezone=timezone):
                result = run(
                    "duckdb",
                    "-no-agent",
                    "-csv",
                    input=f"SET TimeZone='{timezone}';\n"
                    "SELECT TIMESTAMPTZ '2026-11-02 05:00:00+00' "
                    "<= TIMESTAMPTZ '2026-11-02 09:00:00+00' AS eligible;\n",
                )
                self.assertEqual(result.returncode, 0, result.stderr)
                self.assertEqual(csv_rows(result.stdout), [["eligible"], ["true"]])

    def test_naive_cutoff_changes_the_teaching_answer(self):
        for timezone, expected in (("UTC", "true"), ("Asia/Shanghai", "false")):
            with self.subTest(timezone=timezone):
                result = run(
                    "duckdb",
                    "-no-agent",
                    "-csv",
                    input=f"SET TimeZone='{timezone}';\n"
                    "SELECT TIMESTAMPTZ '2026-11-02 05:00:00+00' "
                    "<= TIMESTAMP '2026-11-02 09:00:00' AS eligible;\n",
                )
                self.assertEqual(result.returncode, 0, result.stderr)
                self.assertEqual(csv_rows(result.stdout), [["eligible"], [expected]])

    def test_snapshot_values_agree_in_both_session_timezones(self):
        for timezone in ("UTC", "Asia/Shanghai"):
            with self.subTest(timezone=timezone):
                result = run(
                    "duckdb",
                    "-no-agent",
                    "-csv",
                    input=f"SET TimeZone='{timezone}';\n"
                    + (EXERCISES / "reconcile.sql").read_text(),
                )
                self.assertEqual(result.returncode, 0, result.stderr)
                self.assertEqual(
                    csv_rows(result.stdout),
                    csv_rows((EXERCISES / "expected-differences.csv").read_text()),
                )

    def test_source_selection_changes_only_when_decisive_evidence_changes(self):
        sql = (EXERCISES / "source-selection.sql").read_text()
        cases = (
            ("", [["new_vendor", "5"]]),
            (
                "UPDATE candidates SET covered_securities=6 WHERE source_id='incumbent';",
                [["incumbent", "1"]],
            ),
            (
                "UPDATE candidates SET use_allowed=false WHERE source_id='new_vendor';",
                [],
            ),
        )
        for evidence, expected in cases:
            with self.subTest(evidence=evidence):
                result = run(
                    "duckdb",
                    "-no-agent",
                    "-csv",
                    input=sql
                    + evidence
                    + "\nSELECT source_id, onboarding_days FROM selected ORDER BY source_id;\n",
                )
                self.assertEqual(result.returncode, 0, result.stderr)
                self.assertEqual(
                    csv_rows(result.stdout),
                    [["source_id", "onboarding_days"]] + expected,
                )

    def test_equal_totals_do_not_hide_swapped_entity_values(self):
        result = run(
            "duckdb",
            "-no-agent",
            "-csv",
            input=(EXERCISES / "entity-reconciliation.sql").read_text(),
        )
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(
            csv_rows(result.stdout),
            [
                [
                    "entity_id",
                    "expected_value",
                    "observed_value",
                    "observed_minus_expected",
                ],
                ["E01", "6000", "4000", "-2000"],
                ["E02", "4000", "6000", "2000"],
            ],
        )
        for filename in ("entity-expected.csv", "entity-observed.csv"):
            with (EXERCISES / filename).open() as source:
                values = list(csv.DictReader(source))
            self.assertEqual((len(values), sum(int(row["value"]) for row in values)), (2, 10000))

    def test_mapping_uses_event_time_and_excludes_the_old_boundary(self):
        sql = (EXERCISES / "entity-mapping.sql").read_text()
        result = run("duckdb", "-no-agent", "-csv", input=sql)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(
            csv_rows(result.stdout),
            [
                ["event_id", "owner_id", "mapping_status"],
                ["EV01", "OWNER_A", "resolved"],
                ["EV02", "OWNER_B", "resolved"],
                ["EV03", "NULL", "unmapped"],
            ],
        )

    def test_overlapping_mapping_is_reported_not_arbitrarily_selected(self):
        sql = (EXERCISES / "entity-mapping.sql").read_text()
        setup, query = sql.split("-- Resolve event ownership", 1)
        result = run(
            "duckdb",
            "-no-agent",
            "-csv",
            input=setup + "INSERT INTO mappings VALUES ('PAT01', 'OWNER_C', "
            "TIMESTAMPTZ '2024-01-01 00:00:00+00', TIMESTAMPTZ '2025-01-01 00:00:00+00');\n"
            + query,
        )
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(csv_rows(result.stdout)[1], ["EV01", "NULL", "ambiguous"])


if __name__ == "__main__":
    unittest.main()
