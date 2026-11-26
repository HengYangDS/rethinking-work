"""Hold a head that changes the book's text or exercises to its recorded reviews.

`publication/acceptance/reviews.toml` records each review of the printed commands and each
reading of changed passages. The lane's editor copies them from the reviewers' findings, which
stay in the reviewers' local evidence folders; the record is what the proof and the CIs read. A
head passes when its `book/` and `exercises/` trees are those of a commands review and its
`book/` tree is that of a reading, each with every point settled or declined, and when each
commands review that covers it compared the printed commands with the last release. See
docs/publication-acceptance.md.
"""

import subprocess
import tomllib
import unittest
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


def last_release(subject, read):
    """The release a review of `subject` read at `read` compares the printed commands with: the
    latest `v*` tag that names an ancestor of `subject` and was made no later than the reading."""
    commit = git("rev-parse", "--verify", f"{subject}^{{commit}}").stdout.strip()
    fields = "%(refname:short)%09%(objectname)%09%(*objectname)%09%(creatordate:unix)"
    made = []
    for line in git("for-each-ref", f"--format={fields}", "refs/tags/v*").stdout.splitlines():
        name, target, peeled, date = line.split("\t")
        ancestor = git("merge-base", "--is-ancestor", peeled or target, commit, check=False)
        if int(date) <= read.timestamp() and ancestor.returncode == 0:
            made.append((int(date), name))
    return max(made)[1] if made else None


class RecordedReviews(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.record = tomllib.loads(RECORD.read_text(encoding="utf-8"))
        cls.trees = {name: head_tree(name) for name in ("book", "exercises")}
        head = (cls.trees["book"], cls.trees["exercises"])
        cls.covering = [
            review
            for review in cls.record["commands"]
            if (review["book"], review["exercises"]) == head
        ]

    def test_a_recorded_review_has_no_open_point(self):
        # "no finding" carries no point; "settled" carries each point with how it was settled or why
        # it was declined. A review with an open point is not recorded at all.
        for kind, fields in FIELDS.items():
            for review in self.record[kind]:
                with self.subTest(kind=kind, subject=review.get("subject")):
                    self.assertLessEqual(fields | {"verdict"}, review.keys())
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

    def test_the_head_s_commands_review_compares_with_the_last_release(self):
        # "Run every changed command, old against new": the old commands are the last release's.
        # A baseline copied from an older record names an older tag and fails here.
        for review in self.covering:
            with self.subTest(subject=review["subject"]):
                expected = last_release(review["subject"], review["read"])
                self.assertIsNotNone(expected, "no release tag precedes the review; fetch tags")
                self.assertEqual(review["blocks_against"], expected)

    def test_the_head_has_a_reading_of_its_text(self):
        covered = [
            item["subject"] for item in self.record["reading"] if item["book"] == self.trees["book"]
        ]
        self.assertTrue(covered, f"no reading records book/ {self.trees['book']}")


if __name__ == "__main__":
    unittest.main()
