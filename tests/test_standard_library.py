"""Hold what the tests run with Python to the standard library.

The proof runs the tests once, in the locked test environment, where the test packages can be
imported. Readers run the exercise contracts with a plain Python. A module that only the locked
environment provides would pass the proof and fail for the reader, so the imports are read here.
"""

import ast
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
# The tests, and the exercise cases they run in subprocesses. Templates are run by readers with
# tools installed for that purpose, and by no test.
TREES = (ROOT / "tests", ROOT / "exercises/cases")


def imported_modules(path):
    """Return the top-level module of each absolute import in one source file."""
    tree = ast.parse(path.read_text(encoding="utf-8"), filename=str(path))
    for node in ast.walk(tree):
        if isinstance(node, ast.Import):
            for alias in node.names:
                yield alias.name.partition(".")[0]
        elif isinstance(node, ast.ImportFrom) and node.level == 0 and node.module:
            yield node.module.partition(".")[0]


def modules_beside(path):
    """Return the modules importable from the file's own directory, its import root."""
    return {
        entry.stem if entry.suffix == ".py" else entry.name
        for entry in path.parent.iterdir()
        if entry.suffix == ".py" or entry.is_dir()
    }


class StandardLibraryOnly(unittest.TestCase):
    def test_tests_and_exercise_cases_import_only_the_standard_library(self):
        outside = []
        for tree in TREES:
            sources = sorted(tree.rglob("*.py"))
            self.assertTrue(sources, tree)
            for path in sources:
                beside = modules_beside(path)
                for module in imported_modules(path):
                    if module not in sys.stdlib_module_names and module not in beside:
                        outside.append(f"{path.relative_to(ROOT)}: {module}")
        self.assertFalse(outside, "imports outside the standard library:\n" + "\n".join(outside))


if __name__ == "__main__":
    unittest.main()
