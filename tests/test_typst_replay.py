"""Exercise the bound-input task with synthetic files and the real compiler."""

import hashlib
import shutil
import subprocess
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


class BoundTypstReplay(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        workspace = ROOT / "build/runtime/work"
        workspace.mkdir(parents=True, exist_ok=True)
        cls.scratch = tempfile.TemporaryDirectory(prefix="replay-tests-", dir=workspace)
        cls.addClassCleanup(cls.scratch.cleanup)
        cls.root = Path(cls.scratch.name)
        cls.supply = cls.root / "supply"
        for directory in ("publication", "book", "supply/bin", "supply/fonts", "supply/packages"):
            (cls.root / directory).mkdir(parents=True)
        shutil.copy2(ROOT / "publication/justfile", cls.root / "publication/justfile")
        shutil.copy2(ROOT / "publication/brewfile", cls.root / "publication/brewfile")
        shutil.copy2(shutil.which("typst"), cls.supply / "bin/typst")
        (cls.root / "book/main.typ").write_text(
            '#set text(font: "DejaVu Sans Mono")\nBound input replay\n'
        )
        cls.required = cls.supply / "packages/fixture.txt"
        cls.required.write_bytes(b"Synthetic package input\n")
        (cls.supply / "fonts/fixture.txt").write_bytes(b"Synthetic font input\n")
        manifest = []
        for relative in ("bin/typst", "fonts/fixture.txt", "packages/fixture.txt"):
            digest = hashlib.sha256((cls.supply / relative).read_bytes()).hexdigest()
            manifest.append(f"{digest}  {relative}\n")
        (cls.root / "publication/typst-inputs.sha256").write_text("".join(manifest))
        cls.pdf = cls.root / "build/artifacts/pdf-isolated/rethinking-work.pdf"

    def replay(self):
        return subprocess.run(
            ["just", "--justfile", "publication/justfile", "pdf-isolated", str(self.supply)],
            cwd=self.root,
            stdin=subprocess.DEVNULL,
            capture_output=True,
            text=True,
            timeout=60,
            check=False,
        )

    def preserve_candidate(self):
        self.pdf.parent.mkdir(parents=True, exist_ok=True)
        self.pdf.write_bytes(b"Preserved candidate\n")
        original = self.required.read_bytes()
        self.addCleanup(self.required.write_bytes, original)

    def test_valid_bound_inputs_compile_readable_pdf(self):
        result = self.replay()
        self.assertEqual(result.returncode, 0, result.stderr)
        text = subprocess.run(
            [
                "just",
                "--justfile",
                "publication/justfile",
                "pdf-tool",
                "pdftotext",
                str(self.pdf),
                "-",
            ],
            cwd=self.root,
            stdin=subprocess.DEVNULL,
            capture_output=True,
            text=True,
            timeout=60,
            check=True,
        ).stdout
        self.assertEqual(text.strip(), "Bound input replay")

    def test_altered_required_input_refuses_before_replacing_candidate(self):
        self.preserve_candidate()
        self.required.write_bytes(b"Altered package input\n")
        result = self.replay()
        self.assertNotEqual(result.returncode, 0, result.stderr)
        self.assertIn("packages/fixture.txt: FAILED", result.stdout)
        self.assertEqual(self.pdf.read_bytes(), b"Preserved candidate\n")

    def test_missing_required_input_refuses_before_replacing_candidate(self):
        self.preserve_candidate()
        self.required.unlink()
        result = self.replay()
        self.assertNotEqual(result.returncode, 0, result.stderr)
        self.assertIn("packages/fixture.txt: FAILED", result.stdout)
        self.assertEqual(self.pdf.read_bytes(), b"Preserved candidate\n")


if __name__ == "__main__":
    unittest.main()
