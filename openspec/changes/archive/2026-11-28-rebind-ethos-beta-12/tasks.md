# Tasks

Scope: ETHOS 0.2.0-beta.12 in this repository, from its own published declaration. New scope enters as a task here
before it is worked. Evidence paths are under the local `build/evidence/rebind-ethos-beta-12/`.

## 1. Runtime

- [x] 1.1 Set the ETHOS version in `.config/mise/config.toml` to 0.2.0-beta.12 and lock it again with native
      `mise lock`; done when the lock holds 0.2.0-beta.12 for each platform it locked before, each checksum equals the
      release's `SHA256SUMS`, no 0.2.0-beta.11 entry remains, and the other tools' entries are unchanged. Done
      2026-11-28 13:5x (`release-beta.12/`, `mise-lock.txt`).
- [x] 1.2 Bind the repository family to the 0.2.0-beta.12 runtime with the locked console's `hook install`,
      keeping 0.2.0-beta.11 as the rollback; done when `ethos status` reports the runtime 0.2.0-beta.12 and the
      `ROLLBACK` selection names 0.2.0-beta.11. Done 2026-11-28 13:58 (`admission/hook-install.json`,
      `admission/status-after-bind.json`).
- [x] 1.3 Check both pipelines with `ethos lane project --check` after the bind; done when it reports them
      conforming. Done 2026-11-28 13:59: conforming, no regeneration.
- [x] 1.4 Record the move under Changed in the Changelog's Unreleased section; done when the format check passes.

## 2. Qualification

- [x] 2.1 The light gates pass under 0.2.0-beta.12. Done 2026-11-28 14:12 (`light-gates/light-gates-4.txt`).
