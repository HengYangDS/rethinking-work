# Tasks

Scope: ETHOS 0.2.0-beta.11 in this repository, from its own published declaration. New scope enters as a task here
before it is worked. Evidence paths are under the local `build/evidence/rebind-ethos-beta-11/`.

## 1. Runtime

- [x] 1.1 Replace the 0.2.0-beta.10 declaration in `.config/mise/config.toml` with the one published with
      0.2.0-beta.11, checked against the release's `SHA256SUMS` and asset digests, and lock it again with native
      `mise lock`; done when the lock holds 0.2.0-beta.11 for each platform it locked before, no 0.2.0-beta.10
      entry remains, and the other tools' entries are unchanged. Done 2026-11-21 14:10 (`release-beta.11/`, `mise-lock.txt`; ETHOS now also locked for linux-x64).
- [x] 1.2 Bind the repository family to the 0.2.0-beta.11 runtime with the locked console's `hook install`,
      keeping 0.2.0-beta.10 as the rollback; done when `ethos status` reports the lane ready under 0.2.0-beta.11. Done 2026-11-21 14:12 (`admission/hook-install.json`, `admission/status-after-bind.json`; rollback 0.2.0-beta.10).
- [x] 1.3 Regenerate both pipelines with `ethos lane project --apply` after the bind; done when
      `ethos lane project --check --json` reports them conforming and the change adds only the retention lines. Done 2026-11-21 14:15 (`admission/project-apply.json`; three retention lines added).
- [x] 1.4 Record the move under Changed in the Changelog's Unreleased section; done when the format check passes. Done 2026-11-21 14:15.

## 2. Qualification

- [x] 2.1 The light gates pass under 0.2.0-beta.11. Done 2026-11-21 14:16 (`light-gates/light-gates-1.json`).
