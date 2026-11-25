## Why

The owner removed Windows from every repository ETHOS manages (2026-11-25 13:45, 「ethos 所有纳管仓库，全面去除对 windows 的
支持，从 CI 以及各个方面」) and required each to work local-only, with one remote and with two, the remotes independent and
mirrored where they overlap (13:47); he confirmed both for every repository at 15:02. This repository's CI already runs
only on ARM macOS; its Mise supply still pins two Windows packages of ETHOS, and its specification promises that a
reader can unpack the archive on Windows.

## What Changes

- The Mise platform table for ETHOS keeps macOS and Linux only (the two `windows-*` rows go), as the data-department
  guidelines repository did in its 10.1.1.
- The archive scenario of `publication-source` names macOS and Linux.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: the requirement "One versioned edition archive" names the systems a reader unpacks it on.

## Impact

`.config/mise/config.toml` and the specification. Out of scope: Linux supply, which is kept.
