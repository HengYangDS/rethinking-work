# Design

## Context

See `proposal.md`. Edition v0.1.0 (`0c7c9a5`) is the baseline. An inventory of the whole manuscript, kept with the Change's local evidence, lists each statement that depends on how a real tool or Agent behaves, with the experiment that would settle it and the statements the inventory suspects are wrong. The tools are those installed on the author's workstation on 2026-11-18.

## Goals / Non-Goals

The reader should be able to operate each layer of an agentic system with the tool the team uses for it, and to tell when it worked. Every printed command and output is one the author ran; every claim about an Agent's tendency names its runs.

This Change does not turn the book into a tool catalogue or a workstation manual: tools appear in the layer they serve, after the principle they illustrate. It does not configure the reader's machine, install tools, or operate the department's systems.

## Decisions

### Teach each layer through its tool

Each Agent-layer chapter keeps its order (principle, scenario, then the team's practice) and ends with a hands-on section that uses the team's tool for that layer. A product taught only by role gains a first use, its output and its failure mode, or leaves the chapter. Versions and dates are stated once, in the tool map.

### Experiments settle claims; conditions are stated once

A claim is settled by the cheapest sufficient observation: `--help` or the installed source for a flag, a run in a scratch directory or an isolated home for a command, and a recorded model session only for an Agent's behaviour. Model sessions run headless with the conditions of the 2026-11-16 control group (no global rules, hooks, plugins or MCP servers; an allow-list; a cost cap) unless the claim is about the full workstation. Their answers that a reader might reproduce go into the companion pack; their conditions and counts go into appendix D.

### Shared configuration as its own chapter

The team's shared skills, rules and instruction files are a team practice, not an Agent layer, so they belong in the part on several people, after the chapter on what a team keeps. The chapter teaches the mechanism through TeamAI (one team repository, review by merge request, delivery into each host at session start, drift check) and weighs it against the book's rule that a content has one authority and its copies are derived.

### Select one tool per role

The workstation holds far more than the book can teach: about sixty Agent tools, 270 skills deployed to fifteen hosts, thirty-odd MCP servers across four hosts. The book names a tool when it is the team's choice for a role in a layer, and teaches that one; others of the same role appear, if at all, in the tool map. The selection and its reasons are recorded here before writing (task 1.7), so that a comprehensive inventory does not turn into a catalogue.

#### Selection rule and selected tools (task 1.7)

A tool is taught in the book when all of these hold: it fills one role in one layer of the system the book describes; the team uses it for that role on the author's workstation (inventory of 2026-11-18); its first use, output and failure mode were run and recorded in the Change's evidence; and it is a public product, so the repository discloses nothing internal. When two installed tools fill one role, the book teaches the one the team relies on and names the other at most in the tool map. A tool whose first use writes into the reader's repository or global configuration is taught with that effect and its opt-out stated.

| Layer (chapter)    | Role                                             | Taught                                                                              | Named in the map only                                                       | Evidence                                                          |
| ------------------ | ------------------------------------------------ | ----------------------------------------------------------------------------------- | --------------------------------------------------------------------------- | ----------------------------------------------------------------- |
| Model (9)          | Point a host at a provider and model; check it   | AIGW 0.8 (`aigw use`, `aigw check --depth client`)                                  | Magpie (same role plus a local gateway and shared library)                  | `local-services/aigw-check-client-depth.json`, `magpie-20261118/` |
| Model (9)          | Local model                                      | Ollama 0.40                                                                         |                                                                             | inventory                                                         |
| Host (9, 10)       | Main hosts                                       | Claude Code 2.1, Codex 0.170                                                        | Hermes, OpenCode, Qwen Code, Cursor CLI                                     | sessions E1–E21                                                   |
| Context (11)       | Instruction files                                | `AGENTS.md` / `CLAUDE.md` (Claude reads every parent; Codex from the Git root down) |                                                                             | E4                                                                |
| Context (11)       | Semantic code search                             | semble 0.7                                                                          |                                                                             | rerun M5, E14                                                     |
| Context (11)       | Structure graph: callers and impact              | code-review-graph 2.4                                                               | RepoWise (writes editor files into the repository on init), codebase-memory | `code-review-graph-20261118/`, `repowise-20261118/`               |
| Tools (12)         | Structured tools                                 | MCP, mcporter 0.17                                                                  |                                                                             | rerun                                                             |
| Tools (12)         | Skills and their deployment                      | Skills, skills-manager 1.44                                                         | Magpie library                                                              | E6, inventory                                                     |
| Tools (12)         | Supply-chain check of a skill                    | skill-scanner 2.3 (static analyzers pass prose instructions)                        |                                                                             | `skill-scanner-20261118/`                                         |
| Tools (12)         | Context compression                              | RTK 1.2 (hook), context-mode 2.2 (MCP)                                              |                                                                             | rerun M3                                                          |
| Boundaries (13)    | Permission modes and allow-lists                 | Claude Code modes, `Edit(path)` rules; Codex sandbox                                |                                                                             | E10w, E15, E16, Codex sandbox test                                |
| Boundaries (13)    | A boundary the host enforces                     | `PreToolUse` hook                                                                   |                                                                             | E20                                                               |
| Boundaries (13)    | Secrets without typing                           | Bitwarden with `bw`                                                                 |                                                                             | `local-services/frontends.md`                                     |
| Memory (14)        | Memory across sessions                           | Hindsight 1.2 (retain, recall, correction, `--prefer-observations=false`)           | episodic-memory                                                             | `hindsight-20261118/`                                             |
| Run (18)           | Intent and progress                              | OpenSpec 2.0                                                                        |                                                                             | rerun M1                                                          |
| Run (18)           | Scheduled runs                                   | Hermes cron                                                                         | launchd                                                                     | `hermes-20261118/`                                                |
| Orchestration (20) | Helpers                                          | Host sub-agents (they load instruction files)                                       |                                                                             | E17                                                               |
| Orchestration (20) | Workspaces                                       | git worktree, Orca 1.4                                                              |                                                                             | `orca-20261118/`                                                  |
| Orchestration (20) | Task board for agents                            | Multica 0.10 (self-hosted), Hermes kanban                                           |                                                                             | `local-services/`, `hermes-20261118/`                             |
| Orchestration (20) | Resident agent                                   | Hermes 0.23                                                                         |                                                                             | `hermes-20261118/`                                                |
| Orchestration (20) | Agent organization with budgets and approvals    | Paperclip 2026.11                                                                   |                                                                             | `paperclip-20261118/`                                             |
| Evaluation (21)    | Prompt comparison; whole-task evaluation; traces | promptfoo 0.125, Inspect 0.3, Phoenix                                               |                                                                             | rerun                                                             |
| Team (new chapter) | Shared configuration                             | TeamAI 0.30                                                                         | Magpie library, skills-manager presets                                      | `teamai-20261118/`                                                |
| Review (25)        | Review package and model review                  | Open Code Review 1.13                                                               |                                                                             | rerun                                                             |

#### Statements the evidence changes

From `experiments/sessions/FINDINGS.md` and `rerun/rerun-report.md`, at least: "空值补成零吧" is refused when a contract test is in reach (E2) and followed when nothing contradicts it (E2b); a sub-agent loads the instruction files (E17); `dontAsk` runs read-only commands that are not on the list (E15); path-scoped write permission is `Edit(path)` (E10w); Codex reads instruction files only from the Git root down (E4); a host without user settings starts in `default` (pm); `-no-agent` matters only without an output mode; one common Chinese character is about one token here (tok); an empty brief, an expected count or a sample that cannot be completed did not produce invented content in these runs (E7, E13, E19), so those passages describe a risk to check rather than a regular behaviour; asked for a count with no tools at all, two of three runs wrote a command and a made-up output for it and stated a number (E11); status fields of task boards diverged from delivery in two of three services (`paperclip`, `local-services`, `hermes`).

#### Outline of the rewrite (tasks 2.1 and 2.2)

The book's argument stays: producing has become cheap, understanding has not. What rises in this edition is the second half of that sentence's consequence for practice: the person's main work moves from doing a task to building the environment in which agents do it, and the team's environment becomes the team's capability. Parts three and four teach how to build and operate that environment layer by layer; part five adds the team's shared environment; part six stays with the person.

Part three, the Agent (chapters 9 to 14). Each chapter keeps principle → scenario → practice and ends with 「上手」, using the tools selected above.

- 9 智能体是什么. Six properties restated against the runs: "顺着你写" holds when nothing in reach contradicts the user and yields to a contract test in reach (E2, E2b); with no tools at all, two of three runs stated a count backed by a command output they wrote themselves, while runs whose counting commands were refused declined to give a figure, so the property is that a number counts only when the record shows the query behind it (E1, E11, E19); "你确定吗" yields 确定 and no new evidence (E12). Model choice taught through AIGW: `aigw status`, `aigw use`, `aigw check <host> --depth client`, with the observed output; Ollama for data that may not leave.
- 10 第一次会话. Permission mode named `default` (`manual` is its alias), the first-run trust prompt, Codex as the second host; record reading unchanged.
- 11 上下文. Instruction-file discovery as measured (Claude Code reads every parent; Codex from the Git root down); token arithmetic corrected (about one token per common character on the measured tokenizer); retrieval with semble; structure with code-review-graph (`build`, `query callers_of` and its ambiguity refusal); compaction kept stated limits in a short session (E21) and the advice to keep limits in the instruction file stays as practice.
- 12 工具. MCP given to one session with `--mcp-config` (E14) and inspected with `mcporter list --stdio`; skills, their deployment and their supply-chain check with skill-scanner (a script is caught, prose is not); hooks (E5) and RTK's rewrite exit codes; DuckDB agent mode explained by output mode.
- 13 边界. Modes and allow-lists as measured: `dontAsk` runs read-only commands not on the list (E15), path rules are `Edit(path)` (E10w), plan mode writes only its plan file (E16); a `PreToolUse` hook as a boundary the host enforces (E20); the Codex sandbox's real reach (workspace and `/tmp` writable, home and network closed); secrets read by `bw` instead of typed; prompt injection narrowed (E10: recognised and refused here; the boundary, not the model's judgement, is the defence). A scenario of a live application damaged by automation it did not offer an interface for teaches "收不回的事" and the order interface → CLI → screen.
- 14 记忆. Hindsight through a scratch bank: `bank create`, `memory retain` with a time, `memory recall --prefer-observations=false`, a correction and what observations do to it; the key read from its store, never typed.

Part four, after handing over (chapters 15 to 21).

- 15, 16: anchoring and empty-brief passages become risks to check, with the runs that did not reproduce them stated once in appendix D.
- 17 从头到尾做一遍: the rule experiment at 6 + 6 runs; the strong and light model rerun without the denied-loop confound (E18).
- 18 走到头: scheduled runs taught with Hermes cron instead of crontab; OpenSpec output corrected (M1).
- 19 出了错: a diagnosis scenario built on a desktop client that waits on a backend whose port another process holds (layer by layer: client log, backend status, port owner, one change).
- 20 多个智能体: the five object types each taught with one tool and one run: helpers (sub-agents load instruction files, E17), workspaces (git worktree, Orca), task boards (Hermes kanban end to end; Multica), resident agents (Hermes), organizations with budgets and approvals (Paperclip). The section 「状态字段不等于交付」 uses the three boards' measured divergence.
- 21 评测: unchanged except versions.

Part five gains chapter 27 「共用的环境」 after 26 沉淀, so that 27–29 become 28–30. It argues that a team's skills, rules, instruction files and MCP servers are the team's environment and need one authority, review and delivery to every host, and teaches TeamAI from the experiment: `init`, the team repository's layout, `push` to a review branch, merge, `pull` into each host (Claude reads `.claude/rules/`; Codex receives the rules at session start), `status` for drift, and the reports branch. It weighs copies-on-each-host against the book's rule that a content has one authority: the copies are derived and checked, the repository is the authority.

The contents test's chapter list, the layer-label test and the cross-references follow the renumbering; appendix C gains the tools selected above with versions as of 2026-11-18; appendix D states every session's conditions and counts once.

### Isolation for experiments

Tools that write configuration run with an isolated `HOME` and a local bare repository standing in for the team repository, so the owner's hosts, accounts and the department's systems are untouched. Model sessions that do not need the owner's sign-in also get an isolated host configuration directory, because a session writes its record and plans into the host's home even when its environment is reduced. Each new allow-list is tried by one cheap session before a group runs. Experiments that need the owner's sign-in are recorded as not run.

### Publication tasks find the browser instead of naming its path

The diagram task currently names one browser build's path in three places. It should take the browser from the declared supply in one place and refuse clearly when it is missing.

## Risks / Trade-offs

- Tool versions move within weeks; the tool map's versions bound every printed output, and a reprint reruns the experiment.
- Model behaviour varies between runs; small samples are stated as such, and no tendency is stated beyond what its runs show.
- More hands-on material lengthens the book; material that does not teach practice is cut in the same pass.
