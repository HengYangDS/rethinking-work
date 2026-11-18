# Tasks

Scope: the manuscript, its companion pack, appendices, publication tests and tasks of this repository. New scope enters as a task here before it is worked.

## 1. Evidence

- [x] 1.1 Inventory every manuscript statement that depends on how a tool, host or Agent behaves, with its settling experiment and suspected errors; five part reports exist in the Change's local evidence `inventory/`.
- [x] 1.2 Inventory the workstation's Agent toolchain read-only (hosts, skills and their deployments, MCP servers per host, plugins, hooks, local models); `experiments/tool-state-20261118/inventory.txt` lists versions and counts.
- [x] 1.3 Run the shared-configuration and orchestration tools in isolated homes: TeamAI, Hermes kanban, Magpie, code-review-graph, RepoWise and skill-scanner each have a README and outputs under `experiments/`.
- [x] 1.4 Run the Agent-behaviour experiments under the 20 USD cap; `experiments/sessions/FINDINGS.md` states each claim, condition, count and verdict, and `ledger.tsv` the cost.
- [x] 1.5 Rerun every printed command and output of the manuscript on the installed versions in fresh scratch copies; each mismatch is listed with the corrected command or output. All 51 blocks replayed; six corrections (M1–M6) in `rerun/rerun-report.md`; model and Hindsight steps marked not run.
- [x] 1.6 Run the remaining experiments that the writing needs, each with its allow-list checked by one probe first: compaction kept three stated limits (E21), a project hook refused a write outside `work/` (E20), Hindsight retain, correction and recall in a scratch bank (`hindsight-20261118/`); TeamAI against a GitLab merge request was not run, because it needs a team repository and a token on GitLab, where `dig` is read-only except this project.
- [x] 1.7 Write the selection rule for named tools (one representative per role, chosen by what the team uses, with its layer and version) and the resulting tool list into `design.md`; the table names 24 roles with their evidence.
- [x] 1.8 Run one bounded task end to end through each local orchestration service with a scratch issue, and record status fields against the delivered result: Multica (answer delivered, issue stayed `todo`), Paperclip (answer delivered, issue went `blocked`), Hermes kanban (answer delivered, `done` in 27 s), Orca (worktree and terminal created, agent launch not shown because its terminal daemon was degraded); evidence in `experiments/{paperclip,hermes,orca,local-services}-20261118/`.

## 2. Design

- [x] 2.1 Re-derive the Agent and handing-over parts from the evidence: chapter list, what each chapter's hands-on section runs, and which statements change; the outline is in `design.md` and names no tool outside the selection.
- [x] 2.2 Design the shared-configuration chapter in the part on several people (chapter 27 「共用的环境」 after 26, TeamAI walk-through from the experiment, the single-authority question) and the renumbering it causes (27–29 become 28–30).

## 3. Manuscript

- [x] 3.1 Correct the statements that the experiments refuted or narrowed across all parts; each correction cites its finding in the Change's evidence. Done 2026-11-18: experiment findings applied across the manuscript; editors' records in `build/evidence/agent-practice/editors/`.
- [x] 3.2 Rewrite the Agent part chapter by chapter in disjoint files so that each layer ends with a hands-on use of the selected tool; every printed command matches a recorded run.
- [x] 3.3 Rewrite the handing-over part the same way, including the orchestration chapter's workspace, task-board and resident-agent tools and the evaluation chapter's tools.
- [x] 3.4 Add the shared-configuration chapter and update the contents, numbering and every cross-reference; the native build compiles.
- [x] 3.5 Revise the root, one-person and team parts where the inventory found an overstatement, and raise the argument where the rewrite touches it; no tendency is stated beyond its runs.
- [x] 3.6 Update appendices A to D: install list, command reference, tool map with versions from 1.2, and the conditions and counts of every session the book reports.
- [x] 3.7 Add the companion material the new sections use (the team-repository skeleton, session answers a reader can compare with); the pack's checks pass.
- [x] 3.8 Compress the hands-on material after the cold read, on the owner's go-ahead of 2026-11-18: outputs keep only the lines the prose interprets, setup and cleanup take one step, repetition goes; arguments, conclusions and every command a reader needs stay; the book returns from 208 to about 185 pages. Done 2026-11-18: 208 → 190 pages; compression reread and checked against the pre-compression copies (`cold-read/triage/fact-check-compress.md`).

## 4. Publication

- [x] 4.1 Take the diagram browser from one declared place and drop the stale change path from the supply manifest; the build and the CI projection check pass.
- [ ] 4.2 The supply moves relayed on 2026-11-18 (ast-grep 0.51.3, oasdiff 1.39.0, uv 0.13.9, hosted Mise 2026.11.9) are out of this Change: they go in their own small lane with its own proof, landed after the ETHOS copies run has read the tree on 2026-11-19; this Change rebases onto them before its own proof. Relayed on 2026-11-18 17:55 (peer fbee0c, owner's direction): the same lane sets the tracked Mise `minimum_release_age` from "0h" to "72h" as configuration, never a number held in a test or script, and takes only releases at least 72 hours old; uv's `exclude-newer = "72 hours"` goes in only with a same-commit relock once every locked artifact is 72 hours old. Appendix C's oasdiff version follows what that lane admits.
- [x] 4.3 Align the publication tests with the new structure by labels and positions, not prose; `just --justfile publication/justfile check` passes. Done 2026-11-18: the layout test also counts a chapter's closing block as a break (label `closing-block`); `check` passed at 23:43 (37 tests, `build/evidence/agent-practice/check/check-20261118-2307.log`).

## 5. Qualification

- [x] 5.1 Cold-read every changed chapter sentence by sentence with fresh readers of two model families within the owner's cap of 20 USD (2026-11-18); accepted findings are resolved and rejected ones kept with reasons. Done 2026-11-18: twelve cold readers and twelve rereaders of two families, then a reread after compression; five conflicts settled by two readers; 14.5 USD of the 20 USD cap; records in `build/evidence/agent-practice/cold-read/`.
- [x] 5.2 Qualify the candidate: complete text, navigation, metadata and every page reviewed; deliver to both PDF targets and read back. Done 2026-11-18: 190 pages reviewed in four parts (`build/evidence/agent-practice/page-review/`); code fonts, four stretched lines and one two-step command fixed; page-foot gaps from unbreakable blocks left for the next edition (same breaks in v0.1.0). Delivered as `~/Documents/重新理解工作-20261118.pdf` and beside the Codex copy (`2f90b24b`), pack `~/Documents/重新理解工作-实战练习-20261118.tgz` (`f72e0dbe`, 17 tests pass unpacked); v0.1.0 files preserved.
