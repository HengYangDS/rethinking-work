"""Hold the book's relative chapter and part references to the manuscript's order.

A reference by number is derived (`#chapref`, `#chapnum`, `#partref`); a relative one, 上一章 or
下一章, is written, so it must point at the chapter just before or after the one it stands in, in
the order of book/manuscript.typ. A relative part reference, 上一部 or 下一部, names its part in
`#partrel`, which the layout checks. Read from the sources; no build is needed.
"""

import re
import unittest

from edition import ROOT

OPENING = re.compile(r"#chapter\(.*?\)<([a-z-]+)>", re.S)
RELATIVE = re.compile(r"#link\(<([a-z-]+)>\)\[(上一章|下一章)\]")
# A relative part reference names its part, and the layout checks it (`partrel`).
RELATIVE_PART = re.compile(r'#partrel\("(?:上一部|下一部)", "[^"]+"\)')


class RelativeReferences(unittest.TestCase):
    def test_previous_and_next_chapter_point_at_their_neighbours(self):
        manuscript = (ROOT / "book/manuscript.typ").read_text(encoding="utf-8")
        # The front matter's include, then each part's declared files, in reading order.
        names = re.findall(r'#include "([^"]+)"', manuscript) + [
            name + ".typ"
            for files in re.findall(r"files: \(([^)]*)\)", manuscript)
            for name in re.findall(r'"([^"]+)"', files)
        ]
        files = [ROOT / "book" / name for name in names]
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

    def test_previous_and_next_part_name_their_part(self):
        sources = {
            path: path.read_text(encoding="utf-8") for path in (ROOT / "book").rglob("*.typ")
        }
        plain = [
            (path.name, word)
            for path, text in sorted(sources.items())
            for word in re.findall("(?:上一部|下一部)(?!分)", RELATIVE_PART.sub("", text))
        ]
        self.assertEqual(plain, [])


if __name__ == "__main__":
    unittest.main()
