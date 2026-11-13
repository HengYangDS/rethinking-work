"""Check native diagram raster selection and repeated output bytes."""

import shutil
import struct
import subprocess
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


class DiagramReplay(unittest.TestCase):
    def test_native_task_matches_software_raster_and_replays_exactly(self):
        workspace = ROOT / "build/runtime/work"
        workspace.mkdir(parents=True, exist_ok=True)
        with tempfile.TemporaryDirectory(
            prefix="diagram-replay-tests-", dir=workspace
        ) as directory:
            root = Path(directory)
            (root / "publication").mkdir()
            (root / "diagrams").mkdir()
            for name in ("justfile", "mermaid.json", "puppeteer.json"):
                source = ROOT / "publication" / name
                if source.exists():
                    shutil.copy2(source, root / "publication" / name)
            shutil.copy2(ROOT / "diagrams/reconcile.mmd", root / "diagrams/reconcile.mmd")
            (root / "software.json").write_text('{"args":["--disable-gpu"]}\n')
            reference = root / "reference.png"
            result = subprocess.run(
                [
                    "mmdc",
                    "--input",
                    "diagrams/reconcile.mmd",
                    "--output",
                    str(reference),
                    "--configFile",
                    "publication/mermaid.json",
                    "--scale",
                    "2",
                    "--backgroundColor",
                    "white",
                    "--puppeteerConfigFile",
                    "software.json",
                ],
                cwd=root,
                stdin=subprocess.DEVNULL,
                capture_output=True,
                text=True,
                timeout=60,
                check=False,
            )
            self.assertEqual(result.returncode, 0, result.stderr)
            expected = reference.read_bytes()
            self.assertEqual(expected[:8], b"\x89PNG\r\n\x1a\n")
            self.assertTrue(all(struct.unpack(">II", expected[16:24])))
            task = ["just", "--justfile", "publication/justfile", "diagram", "reconcile"]
            image = root / "build/artifacts/diagrams/reconcile.png"
            for attempt in range(2):
                with self.subTest(replay=attempt + 1):
                    result = subprocess.run(
                        task,
                        cwd=root,
                        stdin=subprocess.DEVNULL,
                        capture_output=True,
                        text=True,
                        timeout=60,
                        check=False,
                    )
                    self.assertEqual(result.returncode, 0, result.stderr)
                    self.assertTrue(
                        image.read_bytes() == expected,
                        "Native diagram output differs from the same-input software raster",
                    )


if __name__ == "__main__":
    unittest.main()
