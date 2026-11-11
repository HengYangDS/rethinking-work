"""Check the publication's declared inputs through the native Typst reader."""

import json
from pathlib import Path
import subprocess
import tempfile
import unittest
import xml.etree.ElementTree as ET


ROOT = Path(__file__).resolve().parents[1]


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
        result = subprocess.run(
            ["pdfinfo", "-meta", str(self.pdf)],
            stdin=subprocess.DEVNULL,
            capture_output=True,
            text=True,
            timeout=15,
            check=True,
        )
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
        info = subprocess.run(
            ["pdfinfo", "-isodates", str(self.pdf)],
            stdin=subprocess.DEVNULL,
            capture_output=True,
            text=True,
            timeout=15,
            check=True,
        ).stdout
        fields = dict(line.split(":", 1) for line in info.splitlines() if ":" in line)
        self.assertEqual(fields["Title"].strip(), title.text)
        self.assertEqual(fields["Author"].strip(), author.text)
        self.assertEqual(fields["Subject"].strip(), description.text)
        self.assertEqual(fields["Keywords"].strip(), keywords.text)
        self.assertEqual(fields["CreationDate"].strip(), created.text)
        self.assertEqual(fields["ModDate"].strip(), modified.text)
        cover = subprocess.run(
            ["pdftotext", "-f", "1", "-l", "1", str(self.pdf), "-"],
            stdin=subprocess.DEVNULL,
            capture_output=True,
            text=True,
            timeout=15,
            check=True,
        ).stdout
        self.assertIn(identity["title"]["text"], cover)
        self.assertIn(identity["author"][0], cover)
        for part in identity["date"].split("-"):
            self.assertIn(str(int(part)), cover)

    def test_body_paragraphs_use_aligned_starts_and_visible_spacing(self):
        result = subprocess.run(
            ["pdftotext", "-bbox-layout", str(self.pdf), "-"],
            stdin=subprocess.DEVNULL,
            capture_output=True,
            text=True,
            timeout=20,
            check=True,
        )
        document = ET.fromstring(result.stdout)
        ns = {"pdf": "http://www.w3.org/1999/xhtml"}
        pages = document.findall(".//pdf:page", ns)
        pairs = (
            ("前六项实战已经显出一个区别", "本册把Agenticnative"),
            ("从十二个来源中选一项", "工具可以分担检索与表达"),
        )
        for first, second in pairs:
            with self.subTest(paragraph=second):
                positions = {}
                for page_number, page in enumerate(pages):
                    lines = page.findall(".//pdf:line", ns)
                    for index, line in enumerate(lines):
                        text = "".join(word.text or "" for word in line.findall("pdf:word", ns))
                        for prefix in (first, second):
                            if text.startswith(prefix):
                                positions[prefix] = (page_number, index, lines)
                self.assertEqual(set(positions), {first, second})
                first_page, first_index, first_lines = positions[first]
                page, index, lines = positions[second]
                self.assertAlmostEqual(
                    float(first_lines[first_index].get("xMin")),
                    float(lines[index].get("xMin")),
                    delta=0.5,
                )
                if page == first_page:

                    def cjk_top(line):
                        word = next(
                            word
                            for word in line.findall("pdf:word", ns)
                            if any("\u4e00" <= char <= "\u9fff" for char in word.text or "")
                        )
                        return float(word.get("yMin"))

                    paragraph_step = cjk_top(lines[index]) - cjk_top(lines[index - 1])
                    line_step = cjk_top(lines[index + 1]) - cjk_top(lines[index])
                    self.assertAlmostEqual(line_step, 16, delta=0.5)
                    self.assertAlmostEqual(paragraph_step, 32, delta=0.5)

    def test_declared_diagrams_resolve(self):
        sources = {path.stem for path in (ROOT / "diagrams").glob("*.mmd")}
        figures = evaluate("query(figure).map(it => it.body)")
        rendered = [Path(item["source"]).stem for item in figures]
        self.assertEqual(len(rendered), len(set(rendered)))
        self.assertEqual(set(rendered), sources)
        for item in figures:
            self.assertTrue(item["alt"], item["source"])
            self.assertTrue((ROOT / item["source"].lstrip("/")).is_file())

    def test_case_references_reach_qualification_records(self):
        links = evaluate("query(link).map(it => (dest:it.dest, page:it.location().page()))")
        records = evaluate(
            'query(metadata).filter(it => type(it.value) == dictionary and "case" in it.value)'
            ".map(it => (identifier:it.value.case, page:it.location().page()))"
        )
        for identifier in (
            "S1",
            "S7",
            "H1",
            "H2",
            "L3",
            "L7",
            "M1",
            "X2",
            "N4",
            "T2",
            "I2",
            "R1",
        ):
            with self.subTest(identifier=identifier):
                references = [item for item in links if item["dest"] == f"<case-{identifier}>"]
                self.assertTrue(references, f"Case {identifier} is not clickable")
                targets = [item for item in records if item["identifier"] == identifier]
                self.assertEqual(len(targets), 1)
                self.assertGreater(targets[0]["page"], min(item["page"] for item in references))

    def test_portable_publication_inputs(self):
        roots = [ROOT / n for n in ("book", "publication", "diagrams", "exercises")]
        for root in roots:
            for path in root.rglob("*"):
                if path.is_file():
                    text = path.read_text()
                    self.assertNotRegex(text, r"/Users/[^/]+/|/private/tmp/", str(path))
        links = evaluate("query(link).map(it => it.dest)")
        self.assertIn("https://typst.app/docs/", links)

    def test_route_tools_reach_their_explanations(self):
        route_page = evaluate("query(<route>).first().location().page()")
        links = evaluate("query(link).map(it => (dest:it.dest, page:it.location().page()))")
        for destination in (
            "<research-tools>",
            "<code-search>",
            "<quality>",
            "<data-work>",
            "<pipeline>",
            "<hindsight-use>",
            "<readable-knowledge>",
            "<reusable-methods>",
            "<publish>",
            "<workspace>",
            "<asset>",
            "<interface-work>",
        ):
            with self.subTest(destination=destination):
                self.assertTrue(
                    any(
                        item["dest"] == destination and item["page"] == route_page for item in links
                    ),
                    f"Route tool has no explanation link: {destination}",
                )

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
