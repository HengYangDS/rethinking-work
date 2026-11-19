"""Build the edition archive from a minimal copy, read it back and run its extracted exercises."""

import hashlib
import os
import re
import shutil
import subprocess
import tempfile
import unittest
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
FOLDER = "重新理解工作"
EXERCISES = f"{FOLDER}/实战练习"
NOTES = ("publication/reader-start.zh.txt", "publication/archive-start.zh.txt")


def run(arguments, cwd, **options):
    return subprocess.run(
        arguments,
        cwd=cwd,
        stdin=subprocess.DEVNULL,
        capture_output=True,
        text=True,
        timeout=options.pop("timeout", 60),
        **options,
    )


class EditionArchive(unittest.TestCase):
    def test_archive_pairs_the_pdf_and_exercises_under_one_version(self):
        workspace = ROOT / "build/runtime/work"
        workspace.mkdir(parents=True, exist_ok=True)
        with tempfile.TemporaryDirectory(prefix="edition-tests-", dir=workspace) as tmp:
            root = Path(tmp)
            selected = run(
                ["git", "ls-files", "VERSION", "LICENSE", "exercises", "tests/test_exercises.py"],
                ROOT,
                check=True,
            ).stdout.splitlines()
            for relative in selected + ["publication/justfile", "book/metadata.typ", *NOTES]:
                target = root / relative
                target.parent.mkdir(parents=True, exist_ok=True)
                shutil.copy2(ROOT / relative, target)
            pdf = root / "build/artifacts/pdf/rethinking-work.pdf"
            pdf.parent.mkdir(parents=True)
            pdf.write_bytes(b"%PDF-1.7 stand-in for the built edition\n")
            identity = {
                "GIT_AUTHOR_NAME": "Test",
                "GIT_AUTHOR_EMAIL": "test@example.invalid",
                "GIT_COMMITTER_NAME": "Test",
                "GIT_COMMITTER_EMAIL": "test@example.invalid",
                "GIT_CONFIG_GLOBAL": "/dev/null",
                "GIT_CONFIG_NOSYSTEM": "1",
                "PATH": os.environ["PATH"],
            }
            run(["git", "init", "--quiet"], root, check=True, env=identity)
            run(
                ["git", "add", "--", *selected, "publication", "book"],
                root,
                check=True,
                env=identity,
            )
            run(
                ["git", "commit", "--quiet", "--no-gpg-sign", "-m", "fixture"],
                root,
                check=True,
                env=identity,
            )
            commit = run(["git", "rev-parse", "HEAD"], root, check=True).stdout.strip()
            (root / "exercises/untracked.txt").write_text("Not a publication input\n")

            built = run(["just", "--justfile", "publication/justfile", "edition-archive"], root)
            self.assertEqual(built.returncode, 0, built.stderr)
            version = (root / "VERSION").read_text().strip()
            archive = root / f"build/artifacts/edition/rethinking-work-{version}.zip"
            first = archive.read_bytes()
            rebuilt = run(["just", "--justfile", "publication/justfile", "edition-archive"], root)
            self.assertEqual(rebuilt.returncode, 0, rebuilt.stderr)
            self.assertEqual(archive.read_bytes(), first, "the archive is not reproducible")

            extracted = root / "extracted"
            with zipfile.ZipFile(archive) as package:
                for item in package.infolist():
                    self.assertTrue(item.filename.startswith(FOLDER + "/"), item.filename)
                    self.assertTrue(
                        item.flag_bits & 0x800, f"name not marked UTF-8: {item.filename}"
                    )
                package.extractall(extracted)
            folder = extracted / FOLDER
            files = {p.relative_to(folder).as_posix() for p in folder.rglob("*") if p.is_file()}
            expected = {f"实战练习/{name}" for name in selected}
            expected |= {
                "实战练习/先读.txt",
                "先读.txt",
                f"重新理解工作-{version}.pdf",
                "SHA256SUMS",
            }
            self.assertEqual(files, expected)
            for name in selected:
                self.assertEqual(
                    (folder / "实战练习" / name).read_bytes(), (root / name).read_bytes(), name
                )
            self.assertEqual(
                (folder / f"重新理解工作-{version}.pdf").read_bytes(), pdf.read_bytes()
            )

            listed = {}
            for line in (folder / "SHA256SUMS").read_text(encoding="utf-8").splitlines():
                digest, name = line.split("  ", 1)
                listed[name] = digest
            self.assertEqual(set(listed), expected - {"SHA256SUMS"})
            for name, digest in listed.items():
                self.assertEqual(
                    hashlib.sha256((folder / name).read_bytes()).hexdigest(), digest, name
                )

            for note in (folder / "先读.txt", folder / "实战练习/先读.txt"):
                text = note.read_text(encoding="utf-8")
                self.assertIn(f"{version} 版", text, note.name)
                self.assertNotRegex(text, r"@[A-Z]+@")
            self.assertIn(commit, (folder / "先读.txt").read_text(encoding="utf-8"))
            self.assertIn(
                f"重新理解工作-{version}.pdf", (folder / "先读.txt").read_text(encoding="utf-8")
            )

            result = run(
                [
                    "python3.12",
                    "-B",
                    "-m",
                    "unittest",
                    "discover",
                    "-s",
                    "tests",
                    "-p",
                    "test_exercises.py",
                    "-v",
                ],
                folder / "实战练习",
                timeout=120,
            )
            self.assertEqual(result.returncode, 0, result.stderr)
            declared = (folder / "实战练习/tests/test_exercises.py").read_text(encoding="utf-8")
            count = len(re.findall(r"^    def test_", declared, re.MULTILINE))
            self.assertGreater(count, 0)
            self.assertIn(f"Ran {count} tests", result.stderr)
            self.assertIn("OK", result.stderr)
            self.assertFalse((root / "build/runtime/work/edition-archive").exists())


if __name__ == "__main__":
    unittest.main()
