"""Hold a head that changes the book's text or exercises to its recorded reviews.

`publication/acceptance/reviews.toml` records each review of the printed commands and each reading of
changed passages. The lane's editor copies them from the reviewers' findings, which stay in the
reviewers' local evidence folders; the record is what the proof and the CIs read. A head passes when its
`book/` and `exercises/` trees are those of a commands review and its `book/` tree is that of a reading,
each with every point settled or declined. See docs/publication-acceptance.md.
"""

import subprocess
import tomllib
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
RECORD = ROOT / "publication/acceptance/reviews.toml"
COMMANDS = {
    "book",
    "exercises",
    "subject",
    "blocks_against",
    "prose_against",
    "pdf",
    "read",
    "findings",
}


def head_tree(directory):
    """The git tree of a directory at the checked-out head."""
    command = ["git", "rev-parse", f"HEAD:{directory}"]
    run = subprocess.run(
        command,
        cwd=ROOT,
        stdin=subprocess.DEVNULL,
        capture_output=True,
        text=True,
        timeout=60,
        check=True,
    )
    return run.stdout.strip()


class RecordedReviews(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.record = tomllib.loads(RECORD.read_text(encoding="utf-8"))
        cls.trees = {name: head_tree(name) for name in ("book", "exercises")}

    def test_a_recorded_review_has_no_open_point(self):
        # "no finding" carries no point; "settled" carries each point with how it was settled or why
        # it was declined. A review with an open point is not recorded at all.
        for kind in ("commands", "reading"):
            for review in self.record[kind]:
                with self.subTest(kind=kind, subject=review["subject"]):
                    points = review.get("point", [])
                    self.assertIn(review["verdict"], ("no finding", "settled"))
                    self.assertEqual(review["verdict"] == "settled", bool(points))
                    for point in points:
                        self.assertEqual(
                            len({"settled", "declined"} & point.keys()), 1, point["point"]
                        )
        for review in self.record["commands"]:
            self.assertLessEqual(COMMANDS, review.keys(), review["subject"])

    def test_the_head_has_a_commands_review_of_its_text_and_exercises(self):
        covered = [
            review["subject"]
            for review in self.record["commands"]
            if (review["book"], review["exercises"])
            == (self.trees["book"], self.trees["exercises"])
        ]
        self.assertTrue(covered, f"no commands review records book/ and exercises/ {self.trees}")

    def test_the_head_has_a_reading_of_its_text(self):
        covered = [
            item["subject"] for item in self.record["reading"] if item["book"] == self.trees["book"]
        ]
        self.assertTrue(covered, f"no reading records book/ {self.trees['book']}")


if __name__ == "__main__":
    unittest.main()
