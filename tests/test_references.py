"""Hold the book's relative chapter references to the manuscript's order.

A reference by number is derived (`#chapref`, `#chapnum`); a relative one, 上一章 or 下一章, is
written, so it must point at the chapter just before or after the one it stands in, in the order
of book/manuscript.typ. Read from the sources; no build is needed.
"""

import re
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
OPENING = re.compile(r"#chapter\(.*?\)<([a-z-]+)>", re.S)
RELATIVE = re.compile(r"#link\(<([a-z-]+)>\)\[(上一章|下一章)\]")


class RelativeReferences(unittest.TestCase):
    def test_previous_and_next_chapter_point_at_their_neighbours(self):
        manuscript = (ROOT / "book/manuscript.typ").read_text(encoding="utf-8")
        files = [ROOT / "book" / name for name in re.findall(r'#include "([^"]+)"', manuscript)]
        sources = {path: path.read_text(encoding="utf-8") for path in files}
        order = [label for text in sources.values() for label in OPENING.findall(text)]
        wrong, seen = [], 0
        for path, text in sources.items():
            openings = [(match.start(), match.group(1)) for match in OPENING.finditer(text)]
            for match in RELATIVE.finditer(text):
                target, word = match.groups()
                own = [label for start, label in openings if start < match.start()][-1]
                index = order.index(own)
                expected = order[index - 1] if word == "上一章" else order[index + 1]
                seen += 1
                if target != expected:
                    wrong.append((path.name, word, target, expected))
        self.assertGreater(seen, 0)
        # Every 上一章 and 下一章 names its chapter, so none escapes the check above.
        plain = [
            (path.name, word)
            for path, text in sources.items()
            for word in re.findall("上一章|下一章", RELATIVE.sub("", text))
        ]
        self.assertEqual(plain, [])
        self.assertEqual(wrong, [])


if __name__ == "__main__":
    unittest.main()
