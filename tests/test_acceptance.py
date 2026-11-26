"""Hold a head that changes the book's text or exercises to its recorded reviews.

`publication/acceptance/reviews.toml` records each review of the printed commands and each
reading of changed passages. The lane's editor copies them from the reviewers' findings, which
stay in the reviewers' local evidence folders; the record is what the proof and the CIs read. A
head passes when its `book/` and `exercises/` trees are those of a commands review and its
`book/` tree is that of a reading, each with every point settled or declined, and when the
latest commands review that covers it names the last release as its baseline. See
docs/publication-acceptance.md.
"""

import subprocess
import tomllib
import unittest
from datetime import datetime
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
RECORD = ROOT / "publication/acceptance/reviews.toml"
# The fields every record of a kind carries, besides its verdict and points.
FIELDS = {
    "commands": {"book", "exercises", "subject", "blocks_against", "prose_against", "pdf", "read"}
    | {"findings"},
    "reading": {"book", "subject", "against", "read", "report"},
}


def git(*args, check=True):
    """A git command run at the repository root."""
    return subprocess.run(
        ["git", *args],
        cwd=ROOT,
        stdin=subprocess.DEVNULL,
        capture_output=True,
        text=True,
        timeout=60,
        check=check,
    )


def head_tree(directory):
    """The git tree of a directory at the checked-out head."""
    return git("rev-parse", f"HEAD:{directory}").stdout.strip()


def last_release(read):
    """The release whose printed commands a review read at `read` compares with: the latest
    signed `v*` tag in the head's history that was made no later than the reading. The head's
    history is used, not the reviewed commit's: a lane rewritten after its review keeps the
    trees the review covers, but the reviewed commit is then on no ref that a CI clone fetches."""
    tags = git(
        "for-each-ref",
        "--merged=HEAD",
        "--sort=-taggerdate",
        "--format=%(taggerdate:unix) %(refname:lstrip=2)",
        "refs/tags/v*",
    ).stdout.split("\n")
    for line in filter(None, tags):
        made, name = line.split(" ", 1)
        if made and int(made) <= read.timestamp():
            return name
    return None


class RecordedReviews(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.record = tomllib.loads(RECORD.read_text(encoding="utf-8"))
        cls.trees = {name: head_tree(name) for name in ("book", "exercises")}
        head = (cls.trees["book"], cls.trees["exercises"])
        cls.covering = [
            review
            for review in cls.record["commands"]
            if (review.get("book"), review.get("exercises")) == head
        ]

    def test_a_recorded_review_has_no_open_point(self):
        # "no finding" carries no point; "settled" carries each point with how it was settled or why
        # it was declined. A review with an open point is not recorded at all.
        for kind, fields in FIELDS.items():
            for review in self.record[kind]:
                with self.subTest(kind=kind, subject=review.get("subject")):
                    self.assertLessEqual(fields | {"verdict"}, review.keys())
                    # A time without its offset would be read in the runner's own time zone.
                    self.assertIsInstance(review["read"], datetime)
                    self.assertIsNotNone(review["read"].utcoffset(), "read carries no offset")
                    points = review.get("point", [])
                    self.assertIn(review["verdict"], ("no finding", "settled"))
                    self.assertEqual(review["verdict"] == "settled", bool(points))
                    for point in points:
                        self.assertEqual(
                            len({"settled", "declined"} & point.keys()), 1, point["point"]
                        )

    def test_the_head_has_a_commands_review_of_its_text_and_exercises(self):
        self.assertTrue(
            self.covering, f"no commands review records book/ and exercises/ {self.trees}"
        )

    def test_the_latest_commands_review_of_the_head_names_the_last_release(self):
        # "Run every changed command, old against new": the old commands are the last release's.
        # A baseline copied from an older record names an older tag and fails here. Only the
        # review read last is held: an older record that the head's trees match again stays as
        # it was written.
        if not self.covering:
            self.skipTest("no commands review covers the head; the test above fails")
        review = max(self.covering, key=lambda item: item["read"])
        expected = last_release(review["read"])
        self.assertIsNotNone(expected, "no signed v* tag in the head's history; fetch the tags")
        self.assertEqual(review["blocks_against"], expected, review["subject"])

    def test_the_head_has_a_reading_of_its_text(self):
        covered = [
            item["subject"] for item in self.record["reading"] if item["book"] == self.trees["book"]
        ]
        self.assertTrue(covered, f"no reading records book/ {self.trees['book']}")


if __name__ == "__main__":
    unittest.main()
