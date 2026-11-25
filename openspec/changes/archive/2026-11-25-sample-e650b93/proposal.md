## Why

The error-rate sample of `e650b93` (pages 24–74, 100,878 layout characters, run by the commands reviewer under the owner's
250 USD cap) passed at 0.47 per 10,000 and counted five errors
(`build/evidence/error-rate-sample/run-e650b93/RESULT.md`). The acceptance document asks for every error found, and its
kind across the book, to be corrected before the release. The hosted verification of `f31c0a3` also failed: the
compile fetched `@preview/oxifmt:1.0.0`, which CeTZ imports and the package supply did not list, and the fetch message
broke the no-warnings check.

## What Changes

- The five counted places are corrected: a measure word on a figure box, a 「减轻」 whose object could not be lessened, an
  ordered series set with commas, the first use of 「token」 without a gloss, and a git label in body type.
- Two more ordered series of nominal items are set with 顿号, the same kind as the third place. No other place of the
  five kinds was found.
- oxifmt 1.0.0 is added to the locked Typst package supply and to the third-party notices.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: the build's package supply covers every package the compile reads.

## Impact

`diagrams/reconcile.typ`; `book/parts/agent.typ`, `first.typ`, `tools.typ`, `talent.typ`, `walkthrough.typ`;
`publication/supply/typst-packages.sha256`; `publication/rights/third-party-notices.md`; `CHANGELOG.md`. Out of scope:
the readers' notes that were not judged errors.
