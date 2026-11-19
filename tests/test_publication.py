"""Check the publication's declared inputs through the native Typst reader."""

import json
import os
import subprocess
import tempfile
import unittest
import xml.etree.ElementTree as ET
from collections import Counter, defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


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
        check=True,
    )
    return json.loads(result.stdout)


class PublicationInputs(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        workspace = ROOT / "build/runtime/work"
        workspace.mkdir(parents=True, exist_ok=True)
        cls.scratch = tempfile.TemporaryDirectory(prefix="publication-tests-", dir=workspace)
        cls.addClassCleanup(cls.scratch.cleanup)
        cls.pdf = Path(cls.scratch.name) / "edition.pdf"
        subprocess.run(
            [
                "typst",
                "compile",
                "--root",
                str(ROOT),
                "book/main.typ",
                str(cls.pdf),
            ],
            cwd=ROOT,
            stdin=subprocess.DEVNULL,
            capture_output=True,
            text=True,
            timeout=60,
            check=True,
        )

    def test_identity_and_native_content(self):
        metadata = evaluate("query(<edition-identity>).first().value")
        self.assertEqual(metadata["author"], ["衡阳"])
        self.assertEqual(metadata["title"]["text"], "重新理解工作")
        self.assertRegex(metadata["date"], r"^\d{4}-\d{2}-\d{2}$")
        self.assertTrue(metadata["description"])
        self.assertGreaterEqual(len(metadata["keywords"]), 4)
        for selector in ("heading", "raw", "table", "figure"):
            self.assertGreater(evaluate(f"query({selector}).len()"), 0)

    def test_built_pdf_identity_matches_visible_attribution(self):
        identity = evaluate("query(<edition-identity>).first().value")
        result = read_pdf("pdfinfo", "-meta", str(self.pdf))
        xmp = ET.fromstring(result.stdout)
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
        info = read_pdf("pdfinfo", "-isodates", str(self.pdf)).stdout
        fields = dict(line.split(":", 1) for line in info.splitlines() if ":" in line)
        self.assertEqual(fields["Title"].strip(), title.text)
        self.assertEqual(fields["Author"].strip(), author.text)
        self.assertEqual(fields["Subject"].strip(), description.text)
        self.assertEqual(fields["Keywords"].strip(), keywords.text)
        self.assertEqual(fields["CreationDate"].strip(), created.text)
        self.assertEqual(fields["ModDate"].strip(), modified.text)
        cover = read_pdf("pdftotext", "-f", "1", "-l", "1", str(self.pdf), "-").stdout
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
        place = (
            "(page:it.location().page(), x:it.location().position().x.pt(),"
            " y:it.location().position().y.pt())"
        )
        paragraphs = evaluate(f"query(par).map(it => {place})")
        breaks = evaluate(
            "(query(heading) + query(figure) + query(raw.where(block: true))"
            f" + query(table) + query(<closing-block>)).map(it => {place})"
        )
        openings = {
            item["page"] for item in evaluate(f"query(heading.where(level: 1)).map(it => {place})")
        }
        front = min(openings)
        margin = Counter(round(item["x"], 2) for item in paragraphs).most_common(1)[0][0]
        document = ET.fromstring(read_pdf("pdftotext", "-bbox-layout", str(self.pdf), "-").stdout)
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

    def test_declared_diagrams_resolve(self):
        sources = {path.stem for path in (ROOT / "diagrams").glob("*.mmd")}
        figures = evaluate("query(figure).map(it => it.body)")
        rendered = [Path(item["source"]).stem for item in figures]
        self.assertEqual(len(rendered), len(set(rendered)))
        self.assertEqual(set(rendered), sources)
        for item in figures:
            self.assertTrue(item["alt"], item["source"])
            self.assertTrue((ROOT / item["source"].lstrip("/")).is_file())

    def test_sources_and_limits_are_stated_once_in_the_back_matter(self):
        back = evaluate("query(<case-records>).first().location().page()")
        for label in ("run-conditions", "premises"):
            with self.subTest(label=label):
                found = evaluate(
                    f"query(<{label}>).map(it => (level:it.level, page:it.location().page()))"
                )
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
        links = evaluate("query(link).map(it => it.dest)")
        self.assertIn("https://typst.app/docs/", links)

    def test_contents_lists_every_chapter_in_reading_order(self):
        chapters = evaluate("query(<chapter-navigation>).map(it => it.value.chapter)")
        expected = [f"{n:02d}" for n in range(1, 31)]
        for after, mark in (("08", "练一"), ("14", "练二"), ("21", "练三"), ("29", "练四")):
            expected.insert(expected.index(after) + 1, mark)
        self.assertEqual(chapters, expected + ["终", "记", "A", "B", "C", "D"])
        # The contents may run over several pages; it ends where chapter 01 opens.
        contents_page = evaluate("query(<contents>).first().location().page()")
        first_chapter = evaluate("query(<work>).first().location().page()")
        entries = evaluate(
            "query(link).filter(it => type(it.dest) == location)"
            ".map(it => (page:it.location().page(), target:it.dest.page()))"
        )
        targets = [
            item["target"] for item in entries if contents_page <= item["page"] < first_chapter
        ]
        self.assertEqual(len(targets), len(chapters) + 1)
        self.assertEqual(targets, sorted(targets))

    def test_each_layer_has_its_chapters(self):
        marks = evaluate(
            "query(<chapter-navigation>).map(it => (chapter:it.value.chapter,"
            " page:it.location().page()))"
        )
        labels = {
            "work": "01",
            "question": "04",
            "agent": "09",
            "delegate": "15",
            "team": "22",
            "shared": "27",
            "growth": "30",
            "closing": "终",
        }
        pages = {item["chapter"]: item["page"] for item in marks}
        for label, chapter in labels.items():
            with self.subTest(label=label):
                page = evaluate(f"query(<{label}>).first().location().page()")
                self.assertEqual(page, pages[chapter])

    def test_practice_chapters_name_their_exercise_cases(self):
        raws = evaluate("query(raw).map(it => (text:it.text, page:it.location().page()))")
        start = evaluate("query(<practice-thinking>).first().location().page()")
        end = evaluate("query(<closing>).first().location().page()")
        named = " ".join(item["text"] for item in raws if start <= item["page"] < end)
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
        openers = evaluate(
            "query(heading.where(level: 1, outlined: true)).map(it => it.location().page())"
        )
        self.assertTrue(openers)
        returns = evaluate(
            "query(link).filter(it => it.dest == <contents>).map(it => it.location().page())"
        )
        for page in openers:
            with self.subTest(page=page):
                self.assertIn(page, returns)


if __name__ == "__main__":
    unittest.main()
