"""Read back the native practice archive and run its extracted exercises."""

import shutil
import subprocess
import tarfile
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
PACK_ROOT = "重新理解工作-实战练习"


class PracticePack(unittest.TestCase):
    def test_archive_preserves_selected_source_and_runs_extracted_exercises(self):
        workspace = ROOT / "build/runtime/work"
        workspace.mkdir(parents=True, exist_ok=True)
        with tempfile.TemporaryDirectory(prefix="practice-tests-", dir=workspace) as tmp:
            root = Path(tmp)
            selected = subprocess.run(
                ["git", "ls-files", "VERSION", "LICENSE", "exercises", "tests/test_exercises.py"],
                cwd=ROOT,
                capture_output=True,
                text=True,
                check=True,
                timeout=30,
            ).stdout.splitlines()
            for relative in selected + ["publication/justfile", "publication/reader-start.zh.txt"]:
                target = root / relative
                target.parent.mkdir(parents=True, exist_ok=True)
                shutil.copy2(ROOT / relative, target)
            subprocess.run(["git", "init", "--quiet"], cwd=root, check=True, timeout=30)
            subprocess.run(["git", "add", "--", *selected], cwd=root, check=True, timeout=30)
            (root / "exercises/untracked.txt").write_text("Not a publication input\n")
            result = subprocess.run(
                ["just", "--justfile", "publication/justfile", "practice-pack"],
                cwd=root,
                stdin=subprocess.DEVNULL,
                capture_output=True,
                text=True,
                timeout=60,
            )
            self.assertEqual(result.returncode, 0, result.stderr)
            expected = {f"{PACK_ROOT}/{name}": (root / name).read_bytes() for name in selected}
            expected[f"{PACK_ROOT}/先读.txt"] = (
                root / "publication/reader-start.zh.txt"
            ).read_bytes()
            archive = root / "build/artifacts/practice/rethinking-work-practice.tgz"
            extracted = root / "extracted"
            extracted.mkdir()
            with tarfile.open(archive, "r:gz") as package:
                files = {item.name: item for item in package.getmembers() if item.isfile()}
                self.assertEqual(set(files), set(expected))
                for item in package.getmembers():
                    self.assertTrue(item.isfile() or item.isdir(), item.name)
                    self.assertTrue(item.name == PACK_ROOT or item.name.startswith(PACK_ROOT + "/"))
                for name, item in files.items():
                    self.assertEqual(item.mode, 0o644, name)
                    self.assertEqual(package.extractfile(item).read(), expected[name], name)
                package.extractall(extracted, filter="data")
            result = subprocess.run(
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
                cwd=extracted / PACK_ROOT,
                stdin=subprocess.DEVNULL,
                capture_output=True,
                text=True,
                timeout=120,
            )
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertIn("Ran 15 tests", result.stderr)
            self.assertIn("OK", result.stderr)
            self.assertFalse((root / "build/runtime/work/practice-pack").exists())


if __name__ == "__main__":
    unittest.main()
