"""Exercise the native PDF-tool prerequisite without changing installed supply."""

import os
import shutil
import subprocess
import tempfile
import unittest
import xml.etree.ElementTree as ET
from pathlib import Path

from edition import QUIET, ROOT


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
                    check=True,
                    **QUIET,
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
                check=False,
                **QUIET,
            )

    def test_pdf_stdout_remains_parseable_with_spaces_in_paths(self):
        result = self.run_check(include_declaration=True, inspect_pdf=True)
        self.assertEqual(result.returncode, 0, result.stderr)
        document = ET.fromstring(result.stdout)
        words = document.findall(".//{http://www.w3.org/1999/xhtml}word")
        self.assertEqual(" ".join(word.text for word in words), "PDF inspection fixture")


if __name__ == "__main__":
    unittest.main()
