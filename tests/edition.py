"""The one build of the edition that the document checks read.

The PDF is compiled once and every document fact is read from one `typst eval`, beside it, per test
process; each view of the PDF is read once. Both test modules that read the document share it, so
the book is laid out once however the checks are grouped. See tests/README.md.
"""

import atexit
import functools
import json
import resource
import subprocess
import tempfile
import types
import unittest
import xml.etree.ElementTree as ET
from collections import Counter
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

PLACE = (
    "(page:it.location().page(), x:it.location().position().x.pt(),"
    " y:it.location().position().y.pt())"
)
BACK_MATTER_SECTIONS = ("run-conditions", "premises")

# Every document fact the checks read, by name. One `typst eval` reads them all from one layout
# of the book, beside the one compile of the PDF, instead of laying out the book once per fact.
FACTS = {
    "identity": "query(<edition-identity>).first().value",
    **{f"count {kind}": f"query({kind}).len()" for kind in ("heading", "raw", "table", "figure")},
    "paragraphs": f"query(par).map(it => {PLACE})",
    "breaks": "(query(heading) + query(figure) + query(raw.where(block: true))"
    f" + query(table) + query(<closing-block>) + query(<card-title>)).map(it => {PLACE})",
    "openings": f"query(heading.where(level: 1)).map(it => {PLACE})",
    "blocks": f"(query(table) + query(<sample-box>) + query(<card>) + query(<lead-in>))"
    f".map(it => {PLACE})",
    "page turns": "query(<page-turn>).map(it => it.location().page())",
    # Each table's columns, its cells as text, and the horizontal alignment given to each column.
    "tables": '{ import "/publication/layout/style.typ": plain-text;'
    " query(table).map(t => (columns: t.columns.len(),"
    " cells: t.children"
    ".map(c => if c.func() == table.header { c.children } else { (c,) }).flatten()"
    ".map(c => plain-text(c.body).trim()),"
    " align: range(t.columns.len()).map(x => repr((t.align)(x, 1).x)))) }",
    **{f"block {end}s": f"query(<block-{end}>).map(it => {PLACE})" for end in ("start", "end")},
    # Each figure drawn from `diagrams/`: the diagram it names and its alternative text.
    "figures": "query(figure.where(kind: image)).map(it => (source:"
    ' str(it.label).trim("diagram-", at: start), alt: it.alt))',
    # Each figure's caption, in order, and the places of the headings nearest before and after
    # it: the heading of the section that calls it and the next one.
    "figure sections": '{ import "/publication/layout/style.typ": plain-text;'
    " let place(h) = (page:h.location().page(), y:h.location().position().y.pt());"
    " query(figure.where(kind: image)).map(it => (caption: plain-text(it.caption.body),"
    " heading: place(query(selector(heading).before(it.location())).last()),"
    " next: place(query(selector(heading).after(it.location())).first()))) }",
    "case records page": "query(<case-records>).first().location().page()",
    **{
        f"section {label}": f"query(<{label}>).map(it => (level:it.level,"
        " page:it.location().page()))"
        for label in BACK_MATTER_SECTIONS
    },
    "link targets": "query(link).map(it => it.dest)",
    "chapters": '{ import "/publication/layout/style.typ": chapter-label;'
    " query(<chapter-navigation>).map(chapter-label) }",
    "contents page": "query(<contents>).first().location().page()",
    "internal links": "query(link).filter(it => type(it.dest) == location)"
    ".map(it => (page:it.location().page(), target:it.dest.page()))",
    # Each chapter in reading order, with its page and the name of the part it is in.
    "chapter marks": '{ import "/publication/layout/style.typ": book-part, chapter-label;'
    " query(<chapter-navigation>).map(it => (chapter:chapter-label(it),"
    " page:it.location().page(), part:book-part.at(it.location()).name)) }",
    "closing page": "query(<closing>).first().location().page()",
    "raws": "query(raw).map(it => (text:it.text, lang:it.lang, block:it.block,"
    " page:it.location().page()))",
    "practice page": "query(<practice-thinking>).first().location().page()",
    "openers": "query(heading.where(level: 1, outlined: true)).map(it => it.location().page())",
    "contents returns": "query(link).filter(it => it.dest == <contents>)"
    ".map(it => it.location().page())",
}


NS = {"pdf": "http://www.w3.org/1999/xhtml"}

# Every read of the built PDF the checks use, by name, with the PDF's place marked.
PDF_READS = {
    "metadata": ("pdfinfo", "-meta", "{pdf}"),
    "info": ("pdfinfo", "-isodates", "{pdf}"),
    "cover": ("pdftotext", "-f", "1", "-l", "1", "{pdf}", "-"),
    "layout": ("pdftotext", "-bbox-layout", "{pdf}", "-"),
    "text": ("pdftotext", "-layout", "{pdf}", "-"),
    "fonts": ("pdffonts", "{pdf}"),
}


# How every tool here runs: no input, its output kept as text, at most a minute.
QUIET = {"stdin": subprocess.DEVNULL, "capture_output": True, "text": True, "timeout": 60}

# What the layout (`publication/layout/style.typ`) declares for the checks, by name, lengths in
# pt. A check reads a rule or a bound here and holds no copy of it.
DECLARED = {
    "body size": "body-size.pt()",
    "body line": "body-line.pt()",
    # The farthest one line of a block is set below the one above it: a body line and one unit of
    # space, which a sample box's looser leading takes.
    "line bound": "(body-line + space).pt()",
    # The most a page is left short by a block that moved whole.
    "whole allowance": "whole-allowance.pt()",
    "split least": "split-least.pt()",
    "open most": "open-most.em",
    "page ceiling": "page-ceiling",
    "declared faces": "declared-faces",
    "opening marks": "opening-marks",
    "closing marks": "closing-marks",
    "number pattern": "number-pattern",
    "language": "language.lang",
}


@functools.cache
def pdf_tools():
    """The declared Poppler executables, resolved once in the bundle's environment (`pdf-tool`)."""
    names = ("pdfinfo", "pdftotext", "pdffonts")
    found = subprocess.run(
        [
            "just",
            "--justfile",
            "publication/justfile",
            "pdf-tool",
            "sh",
            "-c",
            "command -v " + " ".join(names),
        ],
        cwd=ROOT,
        **QUIET,
        check=True,
    ).stdout.split()
    return dict(zip(names, found, strict=True))


def read_pdf(tool, *arguments):
    return subprocess.run([pdf_tools()[tool], *arguments], cwd=ROOT, **QUIET, check=True)


@functools.cache
def edition_inputs():
    """The edition's identity as every build passes it to Typst, from the justfile's one source."""
    command = ["just", "--justfile", "publication/justfile", "--evaluate", "edition_inputs"]
    return tuple(subprocess.run(command, cwd=ROOT, **QUIET, check=True).stdout.split())


def evaluate(expression, inputs=None, within="book/main.typ"):
    """Evaluate within the laid-out book, or, with `within=None`, alone, without a layout."""
    given = edition_inputs() if inputs is None else inputs
    place = ["--in", within] if within else []
    command = ["typst", "eval", "--root", str(ROOT), *given, *place, expression]
    result = subprocess.run(command, cwd=ROOT, **QUIET, check=False)
    if result.returncode:
        raise AssertionError(f"typst eval failed:\n{result.stderr}")
    return json.loads(result.stdout)


@functools.cache
def declared():
    """Every declaration of DECLARED, read in one evaluation of the layout that lays nothing out."""
    entries = ", ".join(f"{json.dumps(name)}: {value}" for name, value in DECLARED.items())
    expression = '{ import "/publication/layout/style.typ": *; (' + entries + ") }"
    return evaluate(expression, inputs=(), within=None)


def cpu_seconds():
    """CPU time of this process and its finished children; it changes little with host load."""
    own = resource.getrusage(resource.RUSAGE_SELF)
    children = resource.getrusage(resource.RUSAGE_CHILDREN)
    return own.ru_utime + own.ru_stime + children.ru_utime + children.ru_stime


@functools.cache
def build():
    """Compile the PDF and evaluate every fact, once per process."""
    workspace = ROOT / "build/runtime/work"
    workspace.mkdir(parents=True, exist_ok=True)
    scratch = tempfile.TemporaryDirectory(prefix="publication-tests-", dir=workspace)
    atexit.register(scratch.cleanup)
    pdf = Path(scratch.name) / "edition.pdf"
    deps = Path(scratch.name) / "inputs.json"
    # The compile and the evaluation are independent; they run side by side. A fact that fails to
    # evaluate fails every check, with Typst's message, which points at that fact. The compile also
    # lists every file it read.
    with subprocess.Popen(
        [
            "typst",
            "compile",
            "--root",
            str(ROOT),
            *edition_inputs(),
            "--deps",
            str(deps),
            "book/main.typ",
            str(pdf),
        ],
        cwd=ROOT,
        stdin=subprocess.DEVNULL,
        stdout=subprocess.DEVNULL,
        stderr=subprocess.PIPE,
        text=True,
    ) as compiling:
        try:
            document = "(" + ", ".join(f"{json.dumps(n)}: {e}" for n, e in FACTS.items()) + ")"
            started = cpu_seconds()
            facts = evaluate(document)
            # The CPU time of one layout of the book, which the compile running beside it does not
            # enter: it is reaped only below.
            layout = cpu_seconds() - started
        finally:
            try:
                errors = compiling.communicate(timeout=QUIET["timeout"])[1]
            except subprocess.TimeoutExpired:
                compiling.kill()
                raise
    if compiling.returncode:
        raise AssertionError(f"typst compile failed:\n{errors}")
    # The PDF reads are independent of each other and run at once. A read that fails raises in the
    # checks that use it, not here.
    with ThreadPoolExecutor(max_workers=len(PDF_READS)) as reading:
        reads = {
            name: reading.submit(read_pdf, *(a.format(pdf=pdf) for a in arguments))
            for name, arguments in PDF_READS.items()
        }
    inputs = json.loads(deps.read_text())["inputs"]
    return types.SimpleNamespace(
        facts=facts, reads=reads, warnings=errors, layout=layout, inputs=inputs
    )


class Edition(unittest.TestCase):
    """A check of the built edition: it reads the one build and may not lay out the book again."""

    @classmethod
    def setUpClass(cls):
        cls.edition = build()
        declared()

    def setUp(self):
        self.started = cpu_seconds()

    def tearDown(self):
        # A check that laid out the book again would spend nearly one layout's CPU time; the checks
        # themselves spend a small fraction of it. Half a layout separates the two on any host.
        spent = cpu_seconds() - self.started
        self.assertLess(
            spent,
            self.edition.layout / 2,
            f"spent {spent:.1f} s of CPU; one layout of the book spent {self.edition.layout:.1f} s",
        )

    def fact(self, name):
        return self.edition.facts[name]

    def read(self, name):
        return self.edition.reads[name].result().stdout

    def pages(self):
        """Every page of the built PDF as read by `pdftotext -bbox-layout`."""
        return ET.fromstring(self.read("layout")).findall(".//pdf:page", NS)

    def layout_lines(self):
        """Every line of the built PDF as (page, text, left, top), and the left edge of the body."""
        pages = self.pages()
        lines = [
            (number, "".join(word.text or "" for word in line.findall("pdf:word", NS)))
            + (float(line.get("xMin")), float(line.get("yMin")))
            for number, page in enumerate(pages, 1)
            for line in page.findall(".//pdf:line", NS)
        ]
        paragraphs = self.fact("paragraphs")
        return lines, Counter(round(item["x"], 2) for item in paragraphs).most_common(1)[0][0]
