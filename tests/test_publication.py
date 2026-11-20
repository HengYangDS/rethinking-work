"""Check the publication's declared inputs through the native Typst reader."""

import json
import os
import re
import resource
import subprocess
import tempfile
import unittest
import xml.etree.ElementTree as ET
from collections import Counter, defaultdict
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

PLACE = (
    "(page:it.location().page(), x:it.location().position().x.pt(),"
    " y:it.location().position().y.pt())"
)
# Each layer's label and the chapter that opens it.
LAYERS = {
    "work": "01",
    "question": "04",
    "agent": "09",
    "delegate": "15",
    "team": "22",
    "shared": "27",
    "growth": "30",
    "closing": "终",
}
BACK_MATTER_SECTIONS = ("run-conditions", "premises")

# Every document fact the checks read, by name. One `typst eval` reads them all from one layout
# of the book, beside the one compile of the PDF, instead of laying out the book once per fact.
FACTS = {
    "identity": "query(<edition-identity>).first().value",
    **{f"count {kind}": f"query({kind}).len()" for kind in ("heading", "raw", "table", "figure")},
    "paragraphs": f"query(par).map(it => {PLACE})",
    "breaks": "(query(heading) + query(figure) + query(raw.where(block: true))"
    f" + query(table) + query(<closing-block>)).map(it => {PLACE})",
    "openings": f"query(heading.where(level: 1)).map(it => {PLACE})",
    "blocks": f"(query(table) + query(<sample-box>)).map(it => {PLACE})",
    "page turns": "query(<page-turn>).map(it => it.location().page())",
    # The layout's own bound for a page left short by a block that moved whole, in pt.
    "whole allowance": '{ import "/publication/layout/style.typ": whole-allowance;'
    " whole-allowance.pt() }",
    "figures": "query(figure).map(it => it.body)",
    "case records page": "query(<case-records>).first().location().page()",
    **{
        f"section {label}": f"query(<{label}>).map(it => (level:it.level,"
        " page:it.location().page()))"
        for label in BACK_MATTER_SECTIONS
    },
    "link targets": "query(link).map(it => it.dest)",
    "chapters": "query(<chapter-navigation>).map(it => it.value.chapter)",
    "contents page": "query(<contents>).first().location().page()",
    "internal links": "query(link).filter(it => type(it.dest) == location)"
    ".map(it => (page:it.location().page(), target:it.dest.page()))",
    "chapter marks": "query(<chapter-navigation>).map(it => (chapter:it.value.chapter,"
    " page:it.location().page()))",
    **{f"layer {label}": f"query(<{label}>).first().location().page()" for label in LAYERS},
    "raws": "query(raw).map(it => (text:it.text, lang:it.lang, block:it.block,"
    " page:it.location().page()))",
    "practice page": "query(<practice-thinking>).first().location().page()",
    "openers": "query(heading.where(level: 1, outlined: true)).map(it => it.location().page())",
    "contents returns": "query(link).filter(it => it.dest == <contents>)"
    ".map(it => it.location().page())",
}


# Every read of the built PDF the checks use, by name, with the PDF's place marked.
PDF_READS = {
    "metadata": ("pdfinfo", "-meta", "{pdf}"),
    "info": ("pdfinfo", "-isodates", "{pdf}"),
    "cover": ("pdftotext", "-f", "1", "-l", "1", "{pdf}", "-"),
    "layout": ("pdftotext", "-bbox-layout", "{pdf}", "-"),
}


def read_pdf(*arguments):
    return subprocess.run(
        ["just", "--justfile", "publication/justfile", "pdf-tool", *arguments],
        cwd=ROOT,
        stdin=subprocess.DEVNULL,
        capture_output=True,
        text=True,
        timeout=60,
        check=True,
    )


def evaluate(expression):
    result = subprocess.run(
        ["typst", "eval", "--root", str(ROOT), "--in", "book/main.typ", expression],
        cwd=ROOT,
        stdin=subprocess.DEVNULL,
        capture_output=True,
        text=True,
        timeout=60,
        check=False,
    )
    if result.returncode:
        raise AssertionError(f"typst eval failed:\n{result.stderr}")
    return json.loads(result.stdout)


def bare_comment_lines(script):
    """Lines of a shell text with a word beginning with `#` outside quotes and here-documents."""
    found, quote, until = [], None, None
    for number, line in enumerate(script.split("\n"), 1):
        if until is not None:
            until = None if line.strip() == until else until
            continue
        index, previous = 0, " "
        while index < len(line):
            char = line[index]
            if char == "\\" and quote != "'":
                index += 1
            elif quote:
                quote = None if char == quote else quote
            elif char in "'\"":
                quote = char
            elif char == "#" and previous.isspace():
                found.append(number)
                break
            previous = char
            index += 1
        document = None if quote else re.search(r"<<-?\s*['\"]?(\w+)", line)
        until = document.group(1) if document else None
    return found


def cpu_seconds():
    """CPU time of this process and its finished children; it changes little with host load."""
    own, children = (
        resource.getrusage(resource.RUSAGE_SELF),
        resource.getrusage(resource.RUSAGE_CHILDREN),
    )
    return own.ru_utime + own.ru_stime + children.ru_utime + children.ru_stime


class PublicationInputs(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        workspace = ROOT / "build/runtime/work"
        workspace.mkdir(parents=True, exist_ok=True)
        cls.scratch = tempfile.TemporaryDirectory(prefix="publication-tests-", dir=workspace)
        cls.addClassCleanup(cls.scratch.cleanup)
        cls.pdf = Path(cls.scratch.name) / "edition.pdf"
        # The compile and the evaluation are independent; they run side by side. A fact that fails
        # to evaluate fails every check here, with Typst's message, which points at that fact.
        with subprocess.Popen(
            ["typst", "compile", "--root", str(ROOT), "book/main.typ", str(cls.pdf)],
            cwd=ROOT,
            stdin=subprocess.DEVNULL,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.PIPE,
            text=True,
        ) as compiling:
            try:
                document = "(" + ", ".join(f"{json.dumps(n)}: {e}" for n, e in FACTS.items()) + ")"
                started = cpu_seconds()
                cls.facts = evaluate(document)
                # The CPU time of one layout of the book, which the compile running beside it
                # does not enter: it is reaped only below.
                cls.layout = cpu_seconds() - started
            finally:
                try:
                    errors = compiling.communicate(timeout=60)[1]
                except subprocess.TimeoutExpired:
                    compiling.kill()
                    raise
        if compiling.returncode:
            raise AssertionError(f"typst compile failed:\n{errors}")
        # The PDF reads are independent of each other and run at once. A read that fails raises in
        # the checks that use it, not here.
        with ThreadPoolExecutor(max_workers=len(PDF_READS)) as reading:
            cls.reads = {
                name: reading.submit(read_pdf, *(a.format(pdf=cls.pdf) for a in arguments))
                for name, arguments in PDF_READS.items()
            }

    def setUp(self):
        self.started = cpu_seconds()

    def tearDown(self):
        # A check that laid out the book again would spend nearly one layout's CPU time; the checks
        # themselves spend a small fraction of it. Half a layout separates the two on any host.
        spent = cpu_seconds() - self.started
        self.assertLess(
            spent,
            self.layout / 2,
            f"spent {spent:.1f} s of CPU; one layout of the book spent {self.layout:.1f} s",
        )

    def fact(self, name):
        return self.facts[name]

    def read(self, name):
        return self.reads[name].result().stdout

    def test_identity_and_native_content(self):
        metadata = self.fact("identity")
        self.assertEqual(metadata["author"], ["衡阳"])
        self.assertEqual(metadata["title"]["text"], "重新理解工作")
        self.assertRegex(metadata["date"], r"^\d{4}-\d{2}-\d{2}$")
        self.assertTrue(metadata["description"])
        self.assertGreaterEqual(len(metadata["keywords"]), 4)
        for selector in ("heading", "raw", "table", "figure"):
            self.assertGreater(self.fact(f"count {selector}"), 0)

    def test_built_pdf_identity_matches_visible_attribution(self):
        identity = self.fact("identity")
        xmp = ET.fromstring(self.read("metadata"))
        namespaces = {
            "dc": "http://purl.org/dc/elements/1.1/",
            "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
        }
        title = xmp.find(".//dc:title/rdf:Alt/rdf:li", namespaces)
        author = xmp.find(".//dc:creator/rdf:Seq/rdf:li", namespaces)
        language = xmp.find(".//dc:language/rdf:Bag/rdf:li", namespaces)
        description = xmp.find(".//dc:description/rdf:Alt/rdf:li", namespaces)
        created = xmp.find(".//{http://ns.adobe.com/xap/1.0/}CreateDate")
        modified = xmp.find(".//{http://ns.adobe.com/xap/1.0/}ModifyDate")
        keywords = xmp.find(".//{http://ns.adobe.com/pdf/1.3/}Keywords")
        self.assertEqual(title.text, identity["title"]["text"])
        self.assertEqual(author.text, identity["author"][0])
        self.assertEqual(language.text, "zh")
        self.assertEqual(description.text, identity["description"]["text"])
        self.assertEqual(keywords.text, ", ".join(identity["keywords"]))
        for value in (created, modified):
            self.assertEqual(value.text, identity["date"] + "T00:00:00Z")
        info = self.read("info")
        fields = dict(line.split(":", 1) for line in info.splitlines() if ":" in line)
        self.assertEqual(fields["Title"].strip(), title.text)
        self.assertEqual(fields["Author"].strip(), author.text)
        self.assertEqual(fields["Subject"].strip(), description.text)
        self.assertEqual(fields["Keywords"].strip(), keywords.text)
        self.assertEqual(fields["CreationDate"].strip(), created.text)
        self.assertEqual(fields["ModDate"].strip(), modified.text)
        cover = self.read("cover")
        self.assertIn(identity["title"]["text"], cover)
        self.assertIn(identity["author"][0], cover)
        for part in identity["date"].split("-"):
            self.assertIn(str(int(part)), cover)
        version = (ROOT / "VERSION").read_text(encoding="utf-8").strip()
        self.assertEqual(identity["version"], version)
        self.assertIn(version, cover)

    def test_body_paragraphs_use_aligned_starts_and_visible_spacing(self):
        # Every body paragraph, located natively, starts flush with the text block; lines within a
        # paragraph step 16 pt and adjacent paragraphs 32 pt. Chapter openings and the cover carry
        # their own apparatus and are left to the page review.
        paragraphs = self.fact("paragraphs")
        breaks = self.fact("breaks")
        openings = {item["page"] for item in self.fact("openings")}
        front = min(openings)
        margin = Counter(round(item["x"], 2) for item in paragraphs).most_common(1)[0][0]
        document = ET.fromstring(self.read("layout"))
        ns = {"pdf": "http://www.w3.org/1999/xhtml"}
        pages = document.findall(".//pdf:page", ns)

        def ideograph(text):
            return bool(text) and "\u4e00" <= text[0] <= "\u9fff"

        def top(line):
            for word in line.findall("pdf:word", ns):
                if ideograph(word.text or ""):
                    return float(word.get("yMin"))
            return None

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
            lines = pages[page - 1].findall(".//pdf:line", ns)
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
                words = following.findall("pdf:word", ns)
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
        for step in line_steps:
            self.assertAlmostEqual(step, 16, delta=0.5)
        for step in paragraph_steps:
            self.assertAlmostEqual(step, 32, delta=0.5)

    def test_no_page_is_left_short_before_a_table_or_a_sample_box(self):
        # A short table or sample box moves to the next page whole, and a tall one continues
        # there. So the page before one that opens a page is short by no more than the bound the
        # layout declares for a whole block; the check holds no number of its own. A page the
        # manuscript ends on purpose is left out, and a chapter never opens with such a block.
        allowed = self.fact("whole allowance")
        turns = set(self.fact("page turns"))
        top = min(item["y"] for item in self.fact("breaks"))
        opened = {item["page"] for item in self.fact("blocks") if item["y"] - top < 1}
        document = ET.fromstring(self.read("layout"))
        ns = {"pdf": "http://www.w3.org/1999/xhtml"}
        ends = {
            number: sorted(float(line.get("yMax")) for line in page.findall(".//pdf:line", ns))
            for number, page in enumerate(document.findall(".//pdf:page", ns), 1)
        }
        # The page number is the lowest line of nearly every page, at one height; the body of a
        # page ends with its lowest line above that.
        number_line = Counter(round(lines[-1]) for lines in ends.values() if lines).most_common(1)
        footer = number_line[0][0] - 4
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
        self.assertTrue(opened)
        self.assertTrue(turns)
        self.assertEqual(short, {}, "pages left short before a table or a sample box, in pt")

    def test_printed_commands_work_when_pasted_whole(self):
        # A reader pastes a printed block into an interactive shell with default options. There a
        # trailing `#` is no comment (zsh hands it to the command), a request sent right after a
        # background start arrives before the process listens, and a registered scheduled job
        # runs by itself until it is removed. A block that is a script's text begins with `#!`.
        raws = self.fact("raws")
        blocks = [
            (index, item)
            for index, item in enumerate(raws)
            if item["block"] and item["lang"] == "sh" and not item["text"].startswith("#!")
        ]
        self.assertGreater(len(blocks), 50)
        commented, unwaited = {}, []
        for _, item in blocks:
            marks = bare_comment_lines(item["text"])
            if marks:
                commented[item["page"]] = marks
            lines = item["text"].split("\n")
            for line, following in zip(lines, lines[1:], strict=False):
                if line.rstrip().endswith(" &") and not following.startswith("sleep "):
                    unwaited.append(item["page"])
        self.assertEqual(commented, {}, "pages with a `#` word in a command, by line of the block")
        self.assertEqual(unwaited, [], "pages where a background start is not followed by a wait")
        registered = [index for index, item in blocks if "hermes cron create" in item["text"]]
        self.assertTrue(registered)
        kept = [
            raws[start]["page"]
            for start, end in zip(registered, registered[1:] + [len(raws)], strict=True)
            if not any("hermes cron remove" in item["text"] for item in raws[start:end])
        ]
        self.assertEqual(kept, [], "pages that register a scheduled job which nothing removes")

    def test_declared_diagrams_resolve(self):
        sources = {path.stem for path in (ROOT / "diagrams").glob("*.mmd")}
        figures = self.fact("figures")
        rendered = [Path(item["source"]).stem for item in figures]
        self.assertEqual(len(rendered), len(set(rendered)))
        self.assertEqual(set(rendered), sources)
        for item in figures:
            self.assertTrue(item["alt"], item["source"])
            self.assertTrue((ROOT / item["source"].lstrip("/")).is_file())

    def test_sources_and_limits_are_stated_once_in_the_back_matter(self):
        back = self.fact("case records page")
        for label in BACK_MATTER_SECTIONS:
            with self.subTest(label=label):
                found = self.fact(f"section {label}")
                self.assertEqual(len(found), 1)
                self.assertEqual(found[0]["level"], 2)
                self.assertGreaterEqual(found[0]["page"], back)

    def test_portable_publication_inputs(self):
        roots = [ROOT / n for n in ("book", "publication", "diagrams", "exercises")]
        for root in roots:
            for path in root.rglob("*"):
                if path.is_file():
                    text = path.read_text()
                    self.assertNotRegex(text, r"/Users/[^/]+/|/private/tmp/", str(path))
        self.assertIn("https://typst.app/docs/", self.fact("link targets"))

    def test_contents_lists_every_chapter_in_reading_order(self):
        chapters = self.fact("chapters")
        expected = [f"{n:02d}" for n in range(1, 31)]
        for after, mark in (("08", "练一"), ("14", "练二"), ("21", "练三"), ("29", "练四")):
            expected.insert(expected.index(after) + 1, mark)
        self.assertEqual(chapters, expected + ["终", "记", "A", "B", "C", "D"])
        # The contents may run over several pages; it ends where chapter 01 opens.
        contents_page = self.fact("contents page")
        first_chapter = self.fact("layer work")
        targets = [
            item["target"]
            for item in self.fact("internal links")
            if contents_page <= item["page"] < first_chapter
        ]
        self.assertEqual(len(targets), len(chapters) + 1)
        self.assertEqual(targets, sorted(targets))

    def test_each_layer_has_its_chapters(self):
        pages = {item["chapter"]: item["page"] for item in self.fact("chapter marks")}
        for label, chapter in LAYERS.items():
            with self.subTest(label=label):
                self.assertEqual(self.fact(f"layer {label}"), pages[chapter])

    def test_practice_chapters_name_their_exercise_cases(self):
        start = self.fact("practice page")
        end = self.fact("layer closing")
        named = " ".join(item["text"] for item in self.fact("raws") if start <= item["page"] < end)
        for case in (
            "cases/historical-snapshot/",
            "cases/keyed-reconciliation/",
            "cases/effective-date-mapping/",
            "cases/export-regression/",
            "cases/api-evolution/",
            "cases/source-selection/",
        ):
            with self.subTest(case=case):
                self.assertIn(case, named)
                self.assertTrue((ROOT / "exercises" / case).is_dir())

    def test_printed_hook_and_skill_match_the_pack_and_the_hook_script_runs(self):
        agent = ROOT / "exercises/cases/export-regression/agent"
        chapter = (ROOT / "book/parts/tools.typ").read_text(encoding="utf-8")
        printed = chapter.split("```json\n")[2].split("\n```")[0]
        self.assertEqual(json.loads(printed), json.loads((agent / "settings.json").read_text()))
        self.assertIn((agent / "SKILL.md").read_text(encoding="utf-8").strip(), chapter)
        script = chapter.split("<<'EOF'\n")[1].split("\nEOF\n")[0] + "\n"
        case = agent.parent
        for module, expected in (("export_fixed.py", 0), ("export_bug.py", 2)):
            with self.subTest(module=module), tempfile.TemporaryDirectory() as project:
                work = Path(project)
                (work / ".claude").mkdir()
                (work / "check.sh").write_text(script, encoding="utf-8")
                (work / "export.py").write_bytes((case / module).read_bytes())
                (work / "test_export.py").write_bytes((case / "test_export.py").read_bytes())
                result = subprocess.run(
                    ["sh", str(work / "check.sh")],
                    cwd=work,
                    env={**os.environ, "CLAUDE_PROJECT_DIR": str(work)},
                    stdin=subprocess.DEVNULL,
                    capture_output=True,
                    text=True,
                    timeout=60,
                    check=False,
                )
                self.assertEqual(result.returncode, expected, result.stderr)
                self.assertEqual(bool(result.stderr), bool(expected))

    def test_each_chapter_opener_can_return_to_contents(self):
        openers = self.fact("openers")
        self.assertTrue(openers)
        returns = self.fact("contents returns")
        for page in openers:
            with self.subTest(page=page):
                self.assertIn(page, returns)


if __name__ == "__main__":
    unittest.main()
