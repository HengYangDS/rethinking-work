"""Build the edition archive from a minimal copy, read it back and run its extracted exercises."""

import hashlib
import os
import re
import shlex
import shutil
import subprocess
import sys
import tarfile
import tempfile
import unittest
from pathlib import Path

from edition import QUIET, ROOT

FOLDER = "重新理解工作"
EXERCISES = f"{FOLDER}/实战练习"
NOTES = ("publication/reader-start.zh.txt", "publication/archive-start.zh.txt")
# What the archive task reads besides the selected files: its tasks, the toolchain's Python line,
# the edition's identity and the reader notes.
INPUTS = ("publication/justfile", ".config/mise/config.toml", "book/metadata.typ", *NOTES)
JUSTFILE = ("--justfile", "publication/justfile")


def run(arguments, cwd, **options):
    return subprocess.run(arguments, cwd=cwd, **(QUIET | options))


def reader_environment():
    """Return this environment without the test environment's own programs.

    Under the proof the tests run inside the locked test environment, whose interpreter would
    otherwise answer the reader's command and could import the test packages. A reader has neither.
    """
    environment = dict(os.environ)
    if sys.prefix != sys.base_prefix:
        own = os.path.realpath(Path(sys.prefix, "bin"))
        environment["PATH"] = os.pathsep.join(
            entry
            for entry in environment["PATH"].split(os.pathsep)
            if os.path.realpath(entry) != own
        )
        environment.pop("VIRTUAL_ENV", None)
    return environment


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
            for relative in [*selected, *INPUTS]:
                target = root / relative
                target.parent.mkdir(parents=True, exist_ok=True)
                shutil.copy2(ROOT / relative, target)
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
                ["git", "add", "--", *selected, "publication", "book", ".config"],
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
            # The build's outputs, as the justfile names them.
            named = {
                name: root / run(["just", *JUSTFILE, "--evaluate", name], root, check=True).stdout
                for name in ("pdf", "archive")
            }
            pdf = named["pdf"]
            pdf.parent.mkdir(parents=True)
            pdf.write_bytes(b"%PDF-1.7 stand-in for the built edition\n")

            built = run(["just", *JUSTFILE, "edition-archive"], root)
            self.assertEqual(built.returncode, 0, built.stderr)
            version = (root / "VERSION").read_text().strip()
            archive = named["archive"]
            first = archive.read_bytes()
            rebuilt = run(["just", *JUSTFILE, "edition-archive"], root)
            self.assertEqual(rebuilt.returncode, 0, rebuilt.stderr)
            self.assertEqual(archive.read_bytes(), first, "the archive is not reproducible")

            extracted = root / "extracted"
            with tarfile.open(archive, "r:gz") as package:
                members = package.getmembers()
                self.assertEqual(
                    [item.name for item in members], sorted(item.name for item in members)
                )
                for item in members:
                    self.assertTrue(item.isfile() or item.isdir(), item.name)
                    self.assertTrue(
                        item.name == FOLDER or item.name.startswith(FOLDER + "/"), item.name
                    )
                    # A name beyond ASCII travels as UTF-8 in a pax header; no host user enters.
                    if not item.name.isascii():
                        self.assertEqual(item.pax_headers.get("path", "").rstrip("/"), item.name)
                    self.assertEqual((item.uid, item.gid, item.uname, item.gname), (0, 0, "", ""))
                    self.assertEqual(item.mode, 0o755 if item.isdir() else 0o644, item.name)
                package.extractall(extracted, filter="data")
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

            # The fixture's commit carries no tag v<VERSION>: both notes call the archive a draft
            # and name its commit.
            for note in (folder / "先读.txt", folder / "实战练习/先读.txt"):
                text = note.read_text(encoding="utf-8")
                self.assertIn(f"{version} 草稿 · 提交 {commit[:7]}", text, note.name)
                self.assertNotRegex(text, r"@[A-Z]+@")
            self.assertIn(commit, (folder / "先读.txt").read_text(encoding="utf-8"))
            self.assertIn(
                f"重新理解工作-{version}.pdf", (folder / "先读.txt").read_text(encoding="utf-8")
            )

            # The reader's command, exactly as the pack's note prints it.
            note = (folder / "实战练习/先读.txt").read_text(encoding="utf-8")
            printed = re.findall(r"^python\S* -B -m unittest .*$", note, re.MULTILINE)
            self.assertEqual(len(printed), 1, note)
            result = run(
                shlex.split(printed[0]),
                folder / "实战练习",
                timeout=120,
                env=reader_environment(),
            )
            self.assertEqual(result.returncode, 0, result.stderr)
            declared = (folder / "实战练习/tests/test_exercises.py").read_text(encoding="utf-8")
            count = len(re.findall(r"^    def test_", declared, re.MULTILINE))
            self.assertGreater(count, 0)
            self.assertIn(f"Ran {count} tests", result.stderr)
            self.assertIn("OK", result.stderr)
            self.assertIn(
                f"Ran {count} tests", (folder / "实战练习/先读.txt").read_text(encoding="utf-8")
            )
            self.assertFalse((root / "build/runtime/work/edition-archive").exists())

            # Tagged v<VERSION>, the same commit is that version's edition, dated by its tag.
            tagged = {**identity, "GIT_COMMITTER_DATE": "2026-01-02T08:00:00+08:00"}
            run(
                ["git", "tag", "--annotate", "--no-sign", "-m", "edition", f"v{version}"],
                root,
                check=True,
                env=tagged,
            )
            released = run(["just", *JUSTFILE, "edition-archive"], root)
            self.assertEqual(released.returncode, 0, released.stderr)
            with tarfile.open(archive, "r:gz") as package:
                notes = {
                    name: package.extractfile(f"{FOLDER}/{name}").read().decode("utf-8")
                    for name in ("先读.txt", "实战练习/先读.txt")
                }
            for name, text in notes.items():
                self.assertIn(f"{version} 版 · 2026 年 1 月 2 日", text, name)
                self.assertNotIn("草稿", text, name)


if __name__ == "__main__":
    unittest.main()
