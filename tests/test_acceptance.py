"""Hold a head that changes the book's text or exercises to its recorded reviews.

`publication/acceptance/reviews.toml` records each review of the printed commands, each
reading of changed passages and each release reading, every entry with exactly its declared
fields: what was read, against what, when, the verdict and how many points were settled and
declined. The reviewers' findings stay in their local evidence folders and are neither named
nor copied; the record is what the proof and the CIs read. A head passes when its `book/` and
`exercises/` trees are those of a commands review and its `book/` tree is that of a reading,
and when the latest commands review that covers it names the last release as its baseline.
See docs/publication-acceptance.md.
"""

import re
import subprocess
import tomllib
import unittest
from datetime import datetime
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
RECORD = ROOT / "publication/acceptance/reviews.toml"
# The fields of each kind of entry, and no others: a record holds no reviewer's words and no path.
REVIEW = {"read", "verdict", "settled", "declined"}
FIELDS = {
    "commands": {"book", "exercises", "subject", "blocks_against", "prose_against", "pdf"} | REVIEW,
    "reading": {"book", "subject", "against"} | REVIEW,
    "release": {"version", "pdf", "read", "verdict"},
}
VERDICTS = ("no finding", "settled")


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


def releases():
    """The release tags, newest first: names `v<major>.<minor>.<patch>` that carry a signature, with
    the time each was made. The CIs fetch every tag (`GIT_FETCH_EXTRA_FLAGS` on GitLab)."""
    signed = "%(if)%(contents:signature)%(then)signed%(else)unsigned%(end)"
    tags = git(
        "for-each-ref",
        "--sort=-version:refname",
        "--sort=-taggerdate",
        f"--format=%(taggerdate:unix) %(refname:lstrip=2) {signed}",
        "refs/tags/v[0-9]*",
    ).stdout.split("\n")
    found = []
    for line in filter(None, tags):
        made, name, state = line.rsplit(" ", 2)
        if made and state == "signed" and re.fullmatch(r"v\d+\.\d+\.\d+", name):
            found.append((int(made), name))
    return found


def last_release(read, tags):
    """The release whose printed commands a review read at `read` compares with: the latest
    release made no later than the reading. Releases are tagged in turn on `main`, so the time
    alone names it; neither the reviewed commit, which a rewritten lane leaves on no fetched
    ref, nor the head, which a rebase can move past a later release, enters."""
    return next((name for made, name in tags if made <= read.timestamp()), None)


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

    def test_an_entry_holds_exactly_its_fields(self):
        for kind, fields in FIELDS.items():
            for entry in self.record.get(kind, []):
                with self.subTest(kind=kind, entry=entry.get("subject", entry.get("version"))):
                    self.assertEqual(set(entry), fields)
                    self.assertIn(entry["verdict"], VERDICTS)

    def test_a_verdict_agrees_with_its_points(self):
        # "no finding" counts no point; "settled" counts each point settled, or declined with its
        # reason. A review with an open point is not recorded at all.
        for kind in ("commands", "reading"):
            for review in self.record[kind]:
                with self.subTest(kind=kind, subject=review["subject"]):
                    counts = (review["settled"], review["declined"])
                    self.assertTrue(all(isinstance(n, int) and n >= 0 for n in counts), counts)
                    self.assertEqual(review["verdict"] == "settled", sum(counts) > 0)

    def test_the_head_has_a_commands_review_of_its_text_and_exercises(self):
        self.assertTrue(
            self.covering, f"no commands review records book/ and exercises/ {self.trees}"
        )

    def test_a_review_time_carries_its_offset(self):
        # A time without its offset would be read in the runner's own time zone.
        for kind in FIELDS:
            for review in self.record.get(kind, []):
                with self.subTest(kind=kind, entry=review.get("subject", review.get("version"))):
                    self.assertIsInstance(review["read"], datetime)
                    self.assertIsNotNone(review["read"].utcoffset(), "read carries no offset")

    def test_commands_reviews_are_recorded_in_the_order_they_were_read(self):
        # A record copied whole from an older one carries the older time and its baseline; the
        # order of reading shows it.
        times = [review["read"] for review in self.record["commands"]]
        self.assertEqual(times, sorted(times))

    def test_the_latest_commands_review_of_the_head_names_the_last_release(self):
        # "Run every changed command, old against new": the old commands are the last release's.
        # A baseline copied from an older record names an older tag and fails here. When later
        # reviews cover the same trees, only the one read last is held.
        if not self.covering:
            self.skipTest("no commands review covers the head; the test above fails")
        review = max(self.covering, key=lambda item: item["read"])
        tags = releases()
        names = [name for _, name in tags]
        self.assertIn(
            review["blocks_against"], names, "not a release in this clone; fetch the tags"
        )
        self.assertEqual(review["blocks_against"], last_release(review["read"], tags))

    def test_the_head_has_a_reading_of_its_text(self):
        covered = [
            item["subject"] for item in self.record["reading"] if item["book"] == self.trees["book"]
        ]
        self.assertTrue(covered, f"no reading records book/ {self.trees['book']}")


if __name__ == "__main__":
    unittest.main()
