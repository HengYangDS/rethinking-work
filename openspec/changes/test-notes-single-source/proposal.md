# Proposal

## Why

The `single-test-run` Change wrote down the rule that the tests hold their imports to the standard library and run the reader's exercise command outside the locked environment, and its owner is the section "Standard library only" in `tests/README.md`. The Change also restated the rule beside that owner: in `docs/contributing.md` and in the comment on the `source-behavior` gate in `.ethos/profile.toml`. It restated the gate's own declaration in the opening of `tests/README.md` as well. On 2026-11-20 the owner made single source of truth a hard requirement for everything an agent writes (「SSOT,DRY,MECE,SOLID, 深模块，小表面积，充分解耦，声明式等最佳实践，是硬性要求」), and on the same day approved this correction (「开 lane 修正」).

## What Changes

- `docs/contributing.md` points to `tests/README.md` for how the proof and the local tasks run the tests and what they hold the tests to, instead of restating it.
- The comment on the `source-behavior` gate points to `tests/README.md` instead of restating what the gate's dimensions and the tests already declare.
- The opening of `tests/README.md` points to the proof profile for the gate instead of restating its command and runner. The description of the publication checks points to the section "Standard library only" instead of restating the rule, and the new test's docstring no longer restates how often the proof runs the tests.
- No test, assertion, gate, task or requirement changes.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

None. The requirements in `openspec/specs/publication-source/spec.md` stay as they are; only the contributor notes that restated them change.

## Impact

Affected: `docs/contributing.md`, `tests/README.md`, a comment in `.ethos/profile.toml`, and the CHANGELOG. Out of scope: restatements elsewhere in the repository that this session did not write; they belong to a repository-wide pass under the owner's new rule.
