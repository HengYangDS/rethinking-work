"""Check how the built edition is set: lines, paragraphs, tables, sample boxes and code."""

import re
import unittest
from collections import Counter, defaultdict

import edition
from edition import NS


def normalized(line):
    return re.sub(r"\s+", " ", line).strip()


def code_lines_not_whole(raws, text):
    """Lines of code blocks with a declared language that do not print whole on one line.

    A PDF viewer copies a visual line break as a newline, so such a line cannot be copied as
    printed. A line counts as whole when it appears on one line of its page, or of the next page,
    where a block may continue.
    """
    pages = [[normalized(line) for line in page.splitlines()] for page in text.split("\f")]
    found = []
    for raw in raws:
        if not raw["block"] or not raw["lang"]:
            continue
        for line in filter(str.strip, raw["text"].split("\n")):
            near = pages[raw["page"] - 1 : raw["page"] + 1]
            if not any(normalized(line) in printed for page in near for printed in page):
                found.append((raw["page"], line))
    return found


class EditionLayout(edition.Edition):
    def test_code_lines_print_whole(self):
        # Commands are copied from the PDF: every line of a code block with a declared language
        # prints whole on one line. Output blocks carry no language and are left to the page review.
        self.assertEqual(code_lines_not_whole(self.fact("raws"), self.read("text")), [])

    def test_no_wrapped_line_ends_with_a_single_character_alone(self):
        # No paragraph, table cell or sample box wraps with one character alone on its last line:
        # one Han character, with any closing marks, set directly under a line that starts at the
        # same left edge. A cell that holds one character has no such line above it.
        lines, _ = self.layout_lines()
        bound = self.fact("line bound")
        alone = re.compile("[\u4e00-\u9fff][，。、；：？！）」』”’》]*")
        found = [
            (page, text)
            for page, text, x0, top in lines
            if alone.fullmatch(text)
            and any(o == page and abs(x - x0) < 1 and 0 < top - y <= bound for o, _, x, y in lines)
        ]
        self.assertEqual(found, [])

    def test_justified_lines_keep_chinese_characters_close(self):
        # Justification opens the space between two Chinese characters of the body text by no more
        # than the layout declares: past it a line reads as letter-spaced. Each ideograph is one em
        # wide, so a run of them gives the opening by its width, and two words that meet at
        # ideographs give it by their gap. Body text is told by its size; code keeps its spaces.
        size, run = self.fact("body size"), re.compile("[\u4e00-\u9fff]+")
        pages = self.pages()
        found = []
        for number, page in enumerate(pages, 1):
            for line in page.findall(".//pdf:line", NS):
                words = [
                    (float(w.get("xMin")), float(w.get("xMax")), w.text or "")
                    if abs(float(w.get("yMax")) - float(w.get("yMin")) - size) < 0.1
                    else (0, 0, "")
                    for w in line.findall("pdf:word", NS)
                ]
                opened = [
                    (b - a - size) / (len(t) - 1) - size
                    for a, b, t in words
                    if len(t) > 1 and run.fullmatch(t)
                ]
                opened += [
                    c - b
                    for (_, b, t), (c, _, u) in zip(words, words[1:], strict=False)
                    if run.match(u) and run.match(t[-1:])
                ]
                if opened and max(opened) > self.fact("open most") * size:
                    found.append((number, "".join(w[-1] for w in words)[:24]))
        self.assertEqual(found, [], "lines opened past the declared bound")

    def test_no_body_line_opens_with_a_closing_mark(self):
        # Chinese typesetting never opens a line with a closing mark. A short inline command is set
        # whole in a box, and a box may break on either side, so the layout must keep the mark that
        # follows it on the same line. Lines flush with the text block are body lines.
        lines, margin = self.layout_lines()
        opened = [
            (page, text[:20])
            for page, text, left, _ in lines
            if abs(left - margin) < 0.6 and text and text[0] in "，。、；：？！）」』”’》"
        ]
        self.assertEqual(opened, [])

    def test_body_paragraphs_use_aligned_starts_and_visible_spacing(self):
        # Every body paragraph, located natively, starts flush with the text block; lines within a
        # paragraph step 16 pt and adjacent paragraphs 32 pt. Chapter openings and the cover carry
        # their own apparatus and are left to the page review.
        paragraphs = self.fact("paragraphs")
        breaks = self.fact("breaks")
        openings = {item["page"] for item in self.fact("openings")}
        front = min(openings)
        margin = Counter(round(item["x"], 2) for item in paragraphs).most_common(1)[0][0]
        pages = self.pages()

        def ideograph(text):
            return bool(text) and "\u4e00" <= text[0] <= "\u9fff"

        def top(line):
            words = line.findall("pdf:word", NS)
            return next((float(w.get("yMin")) for w in words if ideograph(w.text or "")), None)

        def flush(line):
            return abs(float(line.get("xMin")) - margin) < 0.6

        starts = defaultdict(list)
        for item in paragraphs + breaks:
            starts[item["page"]].append(item["y"])
        indented, line_steps, paragraph_steps = [], [], []
        for index, paragraph in enumerate(paragraphs):
            page = paragraph["page"]
            if page in openings or page < front or abs(paragraph["x"] - margin) > 0.01:
                continue
            lines = pages[page - 1].findall(".//pdf:line", NS)
            candidates = [
                (abs(top(line) - paragraph["y"]), position)
                for position, line in enumerate(lines)
                if top(line) is not None
            ]
            if not candidates or min(candidates)[0] > 8:
                continue
            position = min(candidates)[1]
            first = lines[position]
            if not flush(first):
                indented.append(page)
            bound = min((y for y in starts[page] if y > paragraph["y"] + 1), default=float("inf"))
            if position + 1 < len(lines):
                following = lines[position + 1]
                words = following.findall("pdf:word", NS)
                if (
                    words
                    and ideograph(words[0].text or "")
                    and flush(following)
                    and top(following) < bound - 4
                ):
                    line_steps.append(top(following) - top(first))
            previous = paragraphs[index - 1] if index else None
            if (
                previous
                and previous["page"] == page
                and abs(previous["x"] - margin) < 0.01
                and not any(
                    item["page"] == page and previous["y"] < item["y"] < paragraph["y"]
                    for item in breaks
                )
                and position
                and top(lines[position - 1]) is not None
            ):
                paragraph_steps.append(top(first) - top(lines[position - 1]))
        self.assertEqual(indented, [])
        self.assertGreater(len(line_steps), 100)
        self.assertGreater(len(paragraph_steps), 100)
        self.assertEqual([step for step in line_steps if abs(step - 16) > 0.5], [])
        self.assertEqual([step for step in paragraph_steps if abs(step - 32) > 0.5], [])

    def test_tables_and_sample_boxes_meet_page_ends_cleanly(self):
        # A short table or sample box moves to the next page whole, and a tall one continues
        # there. So the page before one that opens a page is short by no more than the bound the
        # layout declares for a whole block; the check holds no number of its own. A page the
        # manuscript ends on purpose is left out, and a chapter never opens with such a block.
        # A block that continues keeps at least the declared least part on each page: from its
        # start mark to the lowest line of that page, and from the top of the next to its end mark.
        allowed = self.fact("whole allowance")
        turns = set(self.fact("page turns"))
        top = min(item["y"] for item in self.fact("breaks"))
        opened = {item["page"] for item in self.fact("blocks") if item["y"] - top < 1}
        pages = self.pages()
        ends = {
            number: sorted(float(line.get("yMax")) for line in page.findall(".//pdf:line", NS))
            for number, page in enumerate(pages, 1)
        }
        # The page number is the lowest line of nearly every page, at one height; the body of a
        # page ends with its lowest line above that.
        footer = Counter(round(ys[-1]) for ys in ends.values() if ys).most_common(1)[0][0] - 4
        feet = {
            number: max(end for end in lines if end < footer)
            for number, lines in ends.items()
            if any(end < footer for end in lines)
        }
        bottom = max(feet.values())
        short = {
            page - 1: round(bottom - feet[page - 1])
            for page in opened
            if page - 1 in feet and page - 1 not in turns and bottom - feet[page - 1] > allowed
        }
        thin = [
            (start["page"], round(part))
            for start, end in zip(self.fact("block starts"), self.fact("block ends"), strict=True)
            if start["page"] != end["page"]
            for part in (feet[start["page"]] - start["y"], end["y"] - top)
            if part < self.fact("split least")
        ]
        self.assertTrue(opened and turns)
        self.assertEqual(short, {}, "pages left short before a table or a sample box, in pt")
        self.assertEqual(thin, [], "split blocks with a part below the declared least, in pt")


if __name__ == "__main__":
    unittest.main()
