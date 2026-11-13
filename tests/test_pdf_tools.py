"""Exercise the native PDF-tool prerequisite without changing installed supply."""

import os
import shutil
import subprocess
import tempfile
import unittest
import xml.etree.ElementTree as ET
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


class PdfToolPrerequisite(unittest.TestCase):
    def run_check(self, include_declaration, inspect_pdf=False):
        workspace = ROOT / "build/runtime/work"
        workspace.mkdir(parents=True, exist_ok=True)
        with tempfile.TemporaryDirectory(prefix="pdf tools tests ", dir=workspace) as directory:
            root = Path(directory)
            (root / "publication").mkdir()
            shutil.copy2(ROOT / "publication/justfile", root / "publication/justfile")
            if include_declaration:
                shutil.copy2(ROOT / "publication/brewfile", root / "publication/brewfile")
            shadow = root / "shadow"
            shadow.mkdir()
            for name in ("pdfinfo", "pdftotext"):
                executable = shadow / name
                executable.write_text("#!/bin/sh\nexit 47\n")
                executable.chmod(0o755)
            environment = os.environ.copy()
            environment["PATH"] = f"{shadow}{os.pathsep}{environment['PATH']}"
            command = ["just", "--justfile", "publication/justfile", "pdf-tools-check"]
            if inspect_pdf:
                source = root / "sample text.typ"
                pdf = root / "sample text.pdf"
                source.write_text("PDF inspection fixture\n")
                subprocess.run(
                    ["typst", "compile", str(source), str(pdf)],
                    cwd=root,
                    env=environment,
                    stdin=subprocess.DEVNULL,
                    capture_output=True,
                    text=True,
                    timeout=60,
                    check=True,
                )
                command = [
                    "just",
                    "--justfile",
                    "publication/justfile",
                    "pdf-tool",
                    "pdftotext",
                    "-bbox",
                    str(pdf),
                    "-",
                ]
            return subprocess.run(
                command,
                cwd=root,
                env=environment,
                stdin=subprocess.DEVNULL,
                capture_output=True,
                text=True,
                timeout=60,
                check=False,
            )

    def test_declared_installed_pdf_tools_run_despite_ambient_shadow(self):
        result = self.run_check(include_declaration=True)
        self.assertEqual(result.returncode, 0, result.stderr)
        output = result.stdout + result.stderr
        self.assertIn("pdfinfo version", output)
        self.assertIn("pdftotext version", output)

    def test_pdf_stdout_remains_parseable_with_spaces_in_paths(self):
        result = self.run_check(include_declaration=True, inspect_pdf=True)
        self.assertEqual(result.returncode, 0, result.stderr)
        document = ET.fromstring(result.stdout)
        words = document.findall(".//{http://www.w3.org/1999/xhtml}word")
        self.assertEqual(" ".join(word.text for word in words), "PDF inspection fixture")

    def test_missing_declaration_refuses_before_tool_checks(self):
        result = self.run_check(include_declaration=False)
        self.assertNotEqual(result.returncode, 0)
        output = result.stdout + result.stderr
        self.assertIn("brewfile", output)
        self.assertNotIn("pdfinfo version", output)
        self.assertNotIn("pdftotext version", output)


if __name__ == "__main__":
    unittest.main()
