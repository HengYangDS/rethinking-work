"""Check the publication's declared inputs and identity through the native Typst reader."""

import json
import os
import re
import subprocess
import tempfile
import unittest
import xml.etree.ElementTree as ET
from pathlib import Path

import edition
from edition import BACK_MATTER_SECTIONS, QUIET, ROOT


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


class PublicationInputs(edition.Edition):
    def test_identity_and_native_content(self):
        metadata = self.fact("identity")
        self.assertRegex(metadata["date"], r"^\d{4}-\d{2}-\d{2}$")
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
        self.assertEqual(language.text, edition.declared()["language"])
        self.assertEqual(description.text, identity["description"]["text"])
        self.assertEqual(keywords.text, ", ".join(identity["keywords"]))
        for value in (created, modified):
            self.assertEqual(value.text, identity["date"] + "T00:00:00Z")
        info = self.read("info")
        fields = dict(line.split(":", 1) for line in info.splitlines() if ":" in line)
        shown = {"Title": title, "Author": author, "Subject": description, "Keywords": keywords}
        for key, element in {**shown, "CreationDate": created, "ModDate": modified}.items():
            self.assertEqual(fields[key].strip(), element.text)
        pages, ceiling = int(fields["Pages"]), edition.declared()["page ceiling"]
        self.assertLessEqual(pages, ceiling, "pages over the ceiling the layout declares")
        cover = self.read("cover")
        self.assertIn(identity["title"]["text"], cover)
        self.assertIn(identity["author"][0], cover)
        version = (ROOT / "VERSION").read_text(encoding="utf-8").strip()
        self.assertEqual(identity["version"], version)
        self.assertIn(version, cover)
        # The cover names the edition the build is: a release shows its tag's date, a draft its
        # commit and no date.
        self.assertIn(identity["edition"], re.sub(r"\s+", " ", cover))
        date_parts = [
            str(int(part)) + unit
            for part, unit in zip(identity["date"].split("-"), "年月日", strict=True)
        ]
        shown = [part in re.sub(r"\s+", "", cover) for part in date_parts]
        self.assertEqual(shown, [identity["release"]] * 3)

    def test_the_edition_is_a_draft_unless_built_at_its_tag(self):
        # Only the release inputs name the version's edition and date; a draft names its commit.
        expression = (
            'import "/book/metadata.typ": book-edition, book-date; '
            "(book-edition, book-date != none)"
        )
        version = (ROOT / "VERSION").read_text(encoding="utf-8").strip()
        release = ("--input", "edition=release", "--input", "date=2026-01-02")
        draft = (
            "--input",
            "edition=draft",
            "--input",
            "released=true",
            "--input",
            "commit=abc1234",
            "--input",
            "changed=true",
            "--input",
            "date=2026-01-02",
        )
        self.assertEqual(
            edition.evaluate(expression, release, None), [f"{version} 版 · 2026 年 1 月 2 日", True]
        )
        self.assertEqual(
            edition.evaluate(expression, draft, None),
            [f"{version} 之后的草稿 · 提交 abc1234，另有未提交的改动", True],
        )
        self.assertEqual(edition.evaluate(expression, (), None)[0], f"{version} 草稿")

    def test_compile_has_no_warnings(self):
        # A warning names what the PDF hides: a missing glyph, an unknown font, a dropped reference.
        self.assertEqual(self.edition.warnings.strip(), "")

    def test_every_package_read_is_in_the_supply(self):
        # A package that a declared package imports is read too; a runner that holds only the
        # supply would fetch it during the compile.
        supply = (ROOT / "publication/supply/typst-packages.sha256").read_text(encoding="utf-8")
        listed = {line.split()[1] for line in supply.splitlines() if line.strip()}
        marker = "/packages/preview/"
        read = {
            "packages/preview/" + path.split(marker, 1)[1]
            for path in self.edition.inputs
            if marker in path
        }
        self.assertTrue(read, "the compile read no Typst package")
        self.assertEqual(sorted(read - listed), [])

    def test_embedded_fonts_are_the_declared_ones(self):
        # The layout declares the publication's faces once; the PDF embeds no other. A face's
        # PostScript name holds its family's name once case, spaces and punctuation are dropped.
        def letters(name):
            return re.sub(r"[^a-z]", "", name.lower())

        families = [letters(name) for name in edition.declared()["declared faces"]]
        embedded = {
            line.split()[0].split("+")[-1] for line in self.read("fonts").splitlines()[2:] if line
        }
        stray = sorted(name for name in embedded if not any(f in letters(name) for f in families))
        self.assertEqual(stray, [])

    def test_printed_code_carries_no_unfilled_token(self):
        # A printed block that names the pack's place writes `@PACK_PATH@` inside `pack-code`
        # (book/metadata.typ), which fills it; a block left outside would print the token itself.
        unfilled = [
            (item["page"], token)
            for item in self.fact("raws")
            for token in re.findall(r"@[A-Z_]+@", item["text"])
        ]
        self.assertEqual(unfilled, [])

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
        self.assertTrue(blocks)
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
        # Every diagram in `diagrams/` is drawn once, by a figure with an alternative text.
        sources = {path.stem for path in (ROOT / "diagrams").glob("*.typ")}
        figures = self.fact("figures")
        drawn = [item["source"] for item in figures]
        self.assertEqual(len(drawn), len(set(drawn)))
        self.assertEqual(set(drawn), sources)
        for item in figures:
            self.assertTrue(item["alt"], item["source"])

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

    def test_chapters_follow_the_declared_parts(self):
        # The parts in `book/manuscript.typ` give the reading order, and the order the numbers
        # (`chapter` in publication/layout/style.typ). Numbered chapters run from 01 without a gap;
        # each part keeps its chapters together; a practice closes its part, the practices numbered
        # in order; the appendices run from A.
        marks = self.fact("chapter marks")
        chapters = [mark["chapter"] for mark in marks]
        numbered = [chapter for chapter in chapters if chapter.isdigit()]
        self.assertEqual(numbered, [f"{n:02d}" for n in range(1, len(numbered) + 1)])
        parts = [mark["part"] for mark in marks]
        runs = [part for index, part in enumerate(parts) if index == 0 or parts[index - 1] != part]
        self.assertEqual(len(runs), len(set(runs)), "a part's chapters stand apart")
        practices = [chapter for chapter in chapters if chapter.startswith("练")]
        self.assertEqual(
            practices, ["练" + digit for digit in "一二三四五六七八九"[: len(practices)]]
        )
        for practice in practices:
            index = chapters.index(practice)
            self.assertTrue(
                index + 1 == len(chapters) or parts[index + 1] != parts[index], practice
            )
        appendices = [chapter for chapter in chapters if chapter.isascii() and chapter.isalpha()]
        self.assertEqual(appendices, [chr(ord("A") + n) for n in range(len(appendices))])

    def test_contents_lists_every_chapter_in_reading_order(self):
        # The contents may run over several pages; it ends where the first chapter opens.
        chapters = self.fact("chapters")
        contents_page = self.fact("contents page")
        first_chapter = next(m["page"] for m in self.fact("chapter marks") if m["chapter"] == "01")
        targets = [
            item["target"]
            for item in self.fact("internal links")
            if contents_page <= item["page"] < first_chapter
        ]
        self.assertEqual(len(targets), len(chapters) + 1)
        self.assertEqual(targets, sorted(targets))

    def test_practice_chapters_name_their_exercise_cases(self):
        start = self.fact("practice page")
        end = self.fact("closing page")
        named = " ".join(item["text"] for item in self.fact("raws") if start <= item["page"] < end)
        for case in sorted((ROOT / "exercises/cases").iterdir()):
            if case.is_dir():
                with self.subTest(case=case.name):
                    self.assertIn(f"cases/{case.name}/", named)

    def test_printed_hook_and_skill_match_the_pack_and_the_hook_script_runs(self):
        agent = ROOT / "exercises/cases/export-regression/agent"
        chapter = (ROOT / "book/parts/tools.typ").read_text(encoding="utf-8")
        printed = next(
            block.split("\n```")[0]
            for block in chapter.split("```json\n")[1:]
            if '"PostToolUse"' in block.split("\n```")[0]
        )
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
                env = {**os.environ, "CLAUDE_PROJECT_DIR": str(work)}
                result = subprocess.run(
                    ["sh", str(work / "check.sh")], cwd=work, env=env, **QUIET, check=False
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
