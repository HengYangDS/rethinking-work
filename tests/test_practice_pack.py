"""Build the edition archive from a minimal copy, read it back and run its extracted exercises."""

import functools
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

from edition import QUIET, ROOT, evaluate

NOTES = ("publication/notes/reader-start.zh.txt", "publication/notes/archive-start.zh.txt")
# What the archive task reads besides the selected files: its tasks, the toolchain's Python line,
# the edition's identity and the reader notes.
INPUTS = ("publication/justfile", ".config/mise/config.toml", "book/metadata.typ", *NOTES)
JUSTFILE = ("--justfile", "publication/justfile")
# The reader's whole check runs every exercise's tools in turn, each within the exercises' limit.
READER_CHECK_LIMIT = 120


@functools.cache
def archive_names():
    """The archive's names and the reader's command, as book/metadata.typ declares them."""
    return evaluate(
        '{ import "/book/metadata.typ": *; (folder: book-title, pdf: book-pdf, pack: book-pack,'
        " note: book-note, sums: book-sums, checks: book-checks, check: book-check) }",
        inputs=(),
        within=None,
    )


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
        names = archive_names()
        folder_name, pack, note_name = names["folder"], names["pack"], names["note"]
        with tempfile.TemporaryDirectory(prefix="edition-tests-", dir=workspace) as tmp:
            root = Path(tmp)
            selected = run(
                ["git", "ls-files", "VERSION", "LICENSE", "exercises", names["checks"]],
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
            # The commit as the archive task names a draft by it.
            inputs = run(["just", *JUSTFILE, "--evaluate", "edition_inputs"], root, check=True)
            named_commit = dict(
                item.split("=", 1) for item in inputs.stdout.split() if "=" in item
            )["commit"]
            self.assertTrue(named_commit)
            self.assertTrue(commit.startswith(named_commit), named_commit)
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
                        item.name == folder_name or item.name.startswith(folder_name + "/"),
                        item.name,
                    )
                    # A name beyond ASCII travels as UTF-8 in a pax header; no host user enters.
                    if not item.name.isascii():
                        self.assertEqual(item.pax_headers.get("path", "").rstrip("/"), item.name)
                    self.assertEqual((item.uid, item.gid, item.uname, item.gname), (0, 0, "", ""))
                    self.assertEqual(item.mode, 0o755 if item.isdir() else 0o644, item.name)
                package.extractall(extracted, filter="data")
            folder = extracted / folder_name
            files = {p.relative_to(folder).as_posix() for p in folder.rglob("*") if p.is_file()}
            expected = {f"{pack}/{name}" for name in selected}
            expected |= {f"{pack}/{note_name}", note_name, names["pdf"], names["sums"]}
            self.assertEqual(files, expected)
            self.assertIn(version, names["pdf"])
            for name in selected:
                self.assertEqual(
                    (folder / pack / name).read_bytes(), (root / name).read_bytes(), name
                )
            self.assertEqual((folder / names["pdf"]).read_bytes(), pdf.read_bytes())

            listed = {}
            for line in (folder / names["sums"]).read_text(encoding="utf-8").splitlines():
                digest, name = line.split("  ", 1)
                listed[name] = digest
            self.assertEqual(set(listed), expected - {names["sums"]})
            for name, digest in listed.items():
                self.assertEqual(
                    hashlib.sha256((folder / name).read_bytes()).hexdigest(), digest, name
                )

            # The fixture's commit carries no tag v<VERSION>: both notes call the archive a draft
            # and name its commit.
            for note in (folder / note_name, folder / pack / note_name):
                text = note.read_text(encoding="utf-8")
                self.assertIn(f"{version} 草稿 · 提交 {named_commit}", text, note.name)
                self.assertNotRegex(text, r"@[A-Z_]+@")
            self.assertIn(commit, (folder / note_name).read_text(encoding="utf-8"))
            self.assertIn(names["pdf"], (folder / note_name).read_text(encoding="utf-8"))

            # The reader's command, as the pack's note prints it on a line of its own.
            note = (folder / pack / note_name).read_text(encoding="utf-8")
            self.assertEqual(note.splitlines().count(names["check"]), 1, note)
            result = run(
                shlex.split(names["check"]),
                folder / pack,
                timeout=READER_CHECK_LIMIT,
                env=reader_environment(),
            )
            self.assertEqual(result.returncode, 0, result.stderr)
            checks = (folder / pack / names["checks"]).read_text(encoding="utf-8")
            count = len(re.findall(r"^    def test_", checks, re.MULTILINE))
            self.assertGreater(count, 0)
            self.assertIn(f"Ran {count} tests", result.stderr)
            self.assertIn("OK", result.stderr)
            self.assertIn(f"Ran {count} tests", note)
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
                    name: package.extractfile(f"{folder_name}/{name}").read().decode("utf-8")
                    for name in (note_name, f"{pack}/{note_name}")
                }
            for name, text in notes.items():
                self.assertIn(f"{version} 版 · 2026 年 1 月 2 日", text, name)
                self.assertNotIn("草稿", text, name)


if __name__ == "__main__":
    unittest.main()
