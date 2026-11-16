---
name: check-export
description: Use when asked to check, verify or review a change to export.py in this directory.
---

# Check a change to the export function

1. Show the change: `git diff` for uncommitted work, `git show <commit> -- export.py` for a commit.
2. Run the contract test: `EXPORT_MODULE=export python3 -B -m unittest -v test_export.py`.
3. Read the changed lines against the conventions in `AGENTS.md`.
4. Report three parts, in this order:
   - Changed: file and line, old and new.
   - Test: the command, then how many tests ran, passed, failed and were skipped.
   - Not checked: what this check does not cover, such as other callers of `export_rows` and inputs the test has no case for.
