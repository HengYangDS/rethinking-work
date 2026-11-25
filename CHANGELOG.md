# Changelog

All notable repository changes are recorded here. The format follows
[Keep a Changelog 1.1.0](https://keepachangelog.com/en/1.1.0/), and repository
versions follow [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
[VERSION](VERSION) is the sole source of the repository version. PDF editorial
identity remains in [book/metadata.typ](book/metadata.typ).

Entries under Unreleased describe work awaiting a source release; they do not
claim editorial acceptance or public publication. From 0.2.1, a released
version's edition archive (the PDF and the exercises in one folder, with their
checksums) is attached to its release on both peers; a release does not by
itself claim editorial acceptance.

## [Unreleased]

## [0.2.6] - 2026-11-25

### Changed

- Alignment is declared once in the layout, one rule per kind of element
  (W3C clreq; CY/T 170—2019 for tables): body text is justified, narrow text
  (boxes, cards, cells) flush left, headings and code flush left, captions
  centred. In tables the first column and text columns are flush left and a
  column of numbers is set flush right on its units digit, its heading over
  it; nothing in a table is centred. A test reads each table's columns and
  holds the rule. Five tables change: the two coverage tables, the source
  comparison, the token table and the snapshot table.
- The text block holds exactly 43 characters a line, and a curly quotation mark
  takes a full character cell, as the other Chinese marks do; two marks side by
  side take one and a half. An opening mark at the start of a line or paragraph,
  and a closing mark at the end of a line, drop the blank half of their cell
  (W3C clreq 6.3.2.3). List text starts two cells in, on the same grid, and a
  number keeps the date or time unit after it on its line. Specimen tests hold
  the cells and the spacing.
- Chapter 29 states the tiers as DDWG v10.0.3 does: five tiers named 评定等级 (S 远超预期, A 超出预期, B 符合预期,
  C 及格 as the passing line, D 不及格), D read first and one yes-or-no question
  for each tier above it, the evidence each rests on, the assessment's steps,
  promotion, the evidence for entering senior and expert as v10.0.3 reads it
  (in each of two pieces of work a method another adopted, the methods free to
  differ; a borne-out prediction in a sentence of its own), and a worked example
  read tier by tier.
- Chapter 3's passage on responsibility takes the readers' four points, as the
  owner chose.
- Both GitHub jobs run on one fixed macOS label, `macos-26`, declared once in
  `.config/ci/verification.toml` and read by `.config/ci/pipeline.cue`; the
  publication job ran on `macos-15` and verification on `macos-latest`.
- Text is tightened where the new measure left a loose or short line, a lone
  character or a chapter's last page nearly empty, each edit keeping its facts;
  49 of the first sample's reader notes are applied.

### Fixed

- A paragraph that ends in a colon stays with the command, box, table or list
  it introduces, so no page ends with a lead-in; practice cards are set whole
  or, when tall, split with at least three lines on each page, like sample
  boxes; figures float. A lead-in is spaced as any paragraph is, before and
  after a command, table, list, card or box, which a test of a compiled
  specimen holds. Tests hold these rules over the whole book, a split
  code block keeps at least three printed lines on each page, and the
  loose-line check also measures words with Chinese punctuation. Where the
  rules moved pages, text was tightened or split, each change keeping its
  facts; four tables have column widths that keep their cells whole; the
  preface's return link is set right. The book is 200 pages, its ceiling.
- A first error-rate sample (pages 11–61 of `80710fe`'s PDF and
  the cover and contents, two model families judging each other blind,
  105,823 characters) found 0.02 errors per 10,000 against a limit of 1,
  counted by the readers' brief. Its
  two errors are corrected: a quoted brief's full stop now sits inside its
  closing quotation mark (chapter 9), and a computed percentage is written
  in Arabic numerals (chapter 11), as the book writes others. A search of
  the book corrected the same kinds in practice 4 and chapter 29, and the
  brief of chapter 10 ends with a full stop like the book's other briefs.
- A second sample (pages 70–120 of `67399ac`'s PDF, 105,823 characters) found
  0.43 errors per 10,000 by the classes of CY/T 266 Table 1 (0.33 by the
  readers' brief, which put a contradiction between passages under 1-8). Its
  errors and their kinds are corrected, and the editors' decisions on its 77
  reader notes are applied, as the owner chose.
- A third sample (pages 128–178 of `6dc17d4`'s PDF) was over the limit by
  `docs/publication-acceptance.md`: 0.89 errors per 10,000 for the places both
  families judged errors, 1.08 with a note one judge found an error and the
  other did not (the stricter figure decides), 1.17 with one more note; the
  readers' brief gave 0.60. Its errors and their kinds are corrected, and both
  families read the changed passages again and found no error. The corrected
  text is not sampled again.
- Both families read the pages no sample had read, 5–9, 62–69, 121–127 and
  179–186 of `aaf100a`'s PDF, as the owner chose; this reading replaces a
  fourth sample and gives no rate. Its twelve errors and their kinds across the
  book are corrected: figures are set where they are called, inside their own
  section and after the text that introduces them, where three had floated above
  its heading; a code block that continues on the next page parts between two
  commands, never inside a command continued with `\`; a measured size of five
  digits is in Arabic numerals; quotations match the words they quote; a
  colon's scope no longer runs past a semicolon or holds a second colon (eighteen
  places); the hook sentence of chapter 12 no longer says that every hook
  matches a tool; practice 4's card takes chapter 26's second question. Tests
  hold the figure and code-block rules.

## [0.2.5] - 2026-11-24

### Added

- A head that changes the book's text or exercises is proved only with its
  reviews on record: `publication/acceptance/reviews.toml` records each review
  of the printed commands (keyed by the trees of `book/` and `exercises/`) and
  each reading of changed passages (keyed by `book/`), with how every point was
  settled or declined, and `tests/test_acceptance.py` fails a head that no
  record covers. The stage had lived in a local script, and three book commits
  landed without it.
- The book's decided wording and the decidable cases of Chinese punctuation are
  checked on every change: a Vale style in `.config/checks/vale/` holds
  the replacements and avoided words decided in the whole-book review of
  2026-11-21 and half-width punctuation against a Chinese character, each rule
  with its source, date and cases, and the `book-prose` proof gate runs the
  cases and the rules over `book/` in the proof and both CIs. Vale 3.28.1
  joins the locked toolchain. Chapter 29 now says 「有权决定的人」, the decided
  form, and practice 3 answers its requester's 「靠不靠谱」 in written words;
  the requester's own words, in a box titled 原话, are not read.
- Chapter 29, 「怎样评一个人的表现」, states how the department judges work and
  a member's performance: a work score for one piece, a tier S to E for one
  period at the member's own grade, and a professional sequence of eight grades
  in four bands (器、术、法、道), joined by one chain of evidence; where the
  evidence comes from, five steps of assessment, a worked judgement, promotion
  with its two crossings, and hiring. It is derived from the department's
  guidelines and written so that a reader without them can apply it. Former
  chapters 29 and 30 are now 30 and 31.
- The layout declares a page ceiling of 200 pages, and a test fails when the PDF
  exceeds it.

### Changed

- A sentence-level cold read of the whole book, by seven readers who had not
  written it, found 188 places where a reader would stop, reread or be misled;
  195 repairs restore missing premises and referents, narrow overstatements to
  what the book and its records support, explain terms where they first appear
  and keep each in one sense, and split crowded sentences. Chapter 19 keeps its
  six pages through cuts reviewed for it earlier.
- The definition of 信 quoted in the chapter on writing names who does the work
  beside who is responsible, following the shared definition of 2026-11-23.
- Chapter 29 lists the four hard lines of the department's standard (truth,
  bounds, an accountable person, no claim of completion without evidence) as
  the standard does; it had merged two of them, so one fabrication and one
  unsupported completion claim counted as the same line crossed twice.
  Attainment is measured against the goals agreed for the period.
- Every reference to a chapter, a practice or an appendix by its number is
  derived from the number the chapter's opening declares (`chapref`,
  `chapnum`), so a renumbering changes them with it; the printed book is
  unchanged. Rules of the book's Vale style refuse a written chapter, range,
  appendix or practice reference, and a test holds every 上一章 and 下一章
  to the reading order.
- The checks of the built edition are split by what they read it for:
  `tests/test_publication.py` keeps identity, inputs, navigation and printed
  commands, `tests/test_layout.py` takes how the edition is set, and
  `tests/edition.py` builds the edition once per test process for both. No
  check changed.
- To hold the book at 200 pages with the new chapter, chapters 1, 3, 7, 13, 17,
  21, 25, 26 and 28 were rewritten more concisely and chapter 11 lost one
  repeated clause: second statements of what a chapter or a table already says
  were cut or merged, the closing blocks of chapters 3, 25 and 28 lost their
  headings as the other chapters' do, and chapter 26's section 「苗头」 joined
  the section before it. No printed command, output, case date, qualification
  or exercise changed; readers who had not edited the passages read every
  change, and their findings were repaired.
- The accepted specification declares what qualifies an edition for release
  (fresh readers under chapter 24's 信、达、雅, a whole-book cold read with
  later changes read again, the prose beside printed commands against the run
  records and every command whole in the PDF, every page looked at, and an
  error-rate sample of the final text), and the acceptance guide describes each
  stage as it was run for 0.2.4.
- Tests check that the PDF embeds only the declared fonts, compiles without
  warnings, and ends no body paragraph with a single character alone.

### Fixed

- An error-rate sample of the final text, read by two model families on pages no
  earlier sample read (105,823 characters), found 0.15 errors per 10,000 against a
  limit of 1. Its errors are corrected with the same kinds elsewhere in the book:
  a word, punctuation between clauses joined by 却 or 但, a colon after 如下,
  list items separated by 顿号, corner brackets in a comment, and one table's
  durations, now all in Arabic numerals.
- Typst's own Libertinus Serif, which draws the ℹ of one printed output, is
  declared in the toolchain and the notices instead of being reached unnamed.
- No body paragraph ends with one character alone on its last line: eight are
  gone, by a runt cost in line breaking. One paragraph on page 118 sets two
  lines of quoted output with wider spaces as a result.
- No line of a table cell or a sample box ends with one character alone either,
  and no table or sample box that continues on the next page leaves less than
  three body lines on a page. Twenty-seven such lines and three such splits
  are gone: fourteen tables have new column widths, one time keeps its time
  zone on its line, and one paragraph of chapter 17, three of chapter 25, a
  field and a card item of practice 2 and three cells of appendix D's
  「结论的依据」 say the same in fewer words. Tests hold both rules over the
  whole book.
- No justified body line opens the space between its Chinese characters by
  more than 0.05 em, the bound the layout now declares. Eleven lines were set
  letter-spaced because a Latin word, a time or a command too long for the
  rest of the line made it break early; in chapters 9, 10, 12, 17, 19, 21 and
  27 and practices 1 and 2, a few characters were added or removed so that
  each break moves. A test measures every body line.
- A hook that exits 0 is no longer said to 放行 a call, which chapter 13 uses
  for a call that runs without asking: chapter 13 again says that the host
  still asks about a call the hook did not refuse (a shortening for the page
  ceiling had written 「它放行的」), and two sentences of chapter 13, one of
  chapter 12 and one row of appendix D say what the hook does instead.

## [0.2.4] - 2026-11-22

### Changed

- The whole book was reviewed and repaired. Each part was read by two readers
  under one written standard (logic and reliability; wording and flow) and the
  whole book by a structure reader; twelve editors repaired every finding, and
  readers who had not seen the edits read every changed passage. A reviewer of
  another model family then read every file; the findings the editors did not
  adopt in full were settled with it to one wording each. The prose beside each
  printed command was read against the reader-run records.
- Book-wide terms are fixed once and used alike in every chapter; names that one
  chapter defines (the record's five fields, the conditions for handing work
  over, the role names, the stop conditions) are copied verbatim elsewhere.
- Chapter 3 states the responsibility convention as the owner approved it:
  responsibility follows the decision that let an error through, not rank.
- Chapter 24 states 信、达、雅 as the owner's one definition does: 信 is
  fidelity, 达 is clarity on which the reader can act, and 雅 is grace on top
  of both, with restraint and concision as means to it, not its definition; the
  order is a precedence when they conflict. Exercise four measures 雅 the same way.
- Counts and values written beside their owners now name the owner instead:
  the number of exercise checks, diagrams, chapters, Typst packages, font files
  and locked tools, and each locked tool's version, in the contributor notes and
  the accepted spec. Three of them had gone stale (the diagram count twice, the
  tool count once). The pipeline declaration states the artifact retention once.
- The book's appendix and the exercise notes state the expected result of the
  exercise checks without their number; the reader note in the edition archive
  is filled with it at build time from the test file.
- The repository runs ETHOS 0.2.0-beta.11, from the release's own declaration;
  the generated pipelines keep hosted artifacts for 14 days.
- The hosted jobs bootstrap Mise 2026.11.10, which runs the pinned npm under
  `mise exec`; the pipeline declaration states the Mise release once.

### Fixed

- Statements about how the hosts behave now say what they rest on. The starting
  permission mode is stated as the vendor documents it (from Claude Code 2.1.283,
  `auto` for an interactive session with no mode in the settings, Manual when
  `auto` is unavailable; `default` for `claude -p` from 2.1.302). Chapter 13 states what
  `acceptEdits` lets through as run on 2.1.311 and 2.1.329: output redirection
  into the working directory passes, and `sed` asks when it edits a file in place
  on macOS. Appendix D records these runs and the helper types, which rested on
  documentation alone in 0.2.3, and the reader run of 0.2.3's final text.
  Chapter 14 describes what the second recall may return, and chapter 12 how the
  hook's report varied. The reader is told of the first-launch screens, the LSP
  plugin offer when a session is continued, where `none.duckdb` is left, and a
  second Ollama install.
- No body line opens with a closing punctuation mark. A short inline command is
  set whole in a box, and a box may break on either side; a word joiner after
  the box now keeps the mark that follows it on its line (two lines of the
  reviewed text had opened with a semicolon). A test checks every body line.
- Figure 2 no longer breaks words inside its boxes, and figure 1's return arrow
  points to the judgement it changes, as its caption says.
- Printed commands survive copying from the PDF, which turns a visual line break
  into a newline. The clean-up after the sandbox trial and the two identity
  commands of chapter 10 are blocks of their own, so no copied line reads
  `rm -rf /tmp/`. Nine shell lines that wrapped (among them the hook setting's
  JSON, an appended rule and a jq filter) are rewritten to print on one line and
  do exactly what they did; the tools table gives each command a line of its
  own; inline code is kept whole by its display width, so short commands with
  Chinese words no longer break. A test checks every line of a code block with a
  declared language.
- The errors that the error-rate sample found are corrected, each with its kind
  across the book: figure 6 matches chapter 15, the Hermes `--no-agent` sentence
  and the `is_async` reference say what the text around them says, practice-card
  titles keep to their items, and an ordinal, a direct question and a status
  value follow the book's punctuation and type.
- The errors that a second sample by another model family found are corrected:
  chapter 4 names both of its deviations as behaviours, chapter 5 states the
  limit of ingest time as its example shows, and three questions, two
  percentage-point figures and one colon follow the book's convention.

## [0.2.3] - 2026-11-20

### Fixed

- Corrections from running every printed command of 0.2.2 as a reader, with a
  new empty home directory on the same machine (2026-11-20: 80 of 90 blocks matched, 9 differed, 1 was only
  dry-run). Chapter 18 now says that the registered `reconcile` job is live
  and prints its removal; chapter 20 says that dispatching a card starts the
  gateway. The boundary exercise of chapter 13 starts in the `default` mode:
  in `acceptEdits` the host wrote the protected file through a shell command
  without asking and the hook never fired. Chapter 10 drops two trailing `#`
  comments that an interactive zsh passes to the command, states that an
  interactive session without `--permission-mode` started in `auto` under the
  one sign-in tried, and names
  the mode in the commands that continue a session; chapter 13, which held
  the old statement too, is corrected with it, and three later exercises now
  print the command that starts their session. Both blocks of chapter 19
  wait a second before requesting a process they start. Chapters 9, 11 and 14
  correct a prerequisite, two items a configured machine does not show, two
  numbers and the delay before an observation appears. Chapter 20 and the
  appendices state that only a helper of the general type reads the project's
  instruction files; Explore and Plan helpers do not. Appendix D records the
  run.

### Added

- A check of the printed shell blocks fails on a `#` word outside quotes and
  here-documents, on a background start without a wait, and on a registered
  scheduled job that nothing removes.

### Changed

- The contributor notes and the proof profile's gate comment point to the test
  notes for how the tests run and what they hold themselves to, instead of
  restating it beside them.
- The proof runs the publication tests once instead of twice. The
  `publication-inputs` gate, which ran them under the host's plain Python, is
  removed; `source-behavior` runs them with coverage, and its reports serve the
  publication-input checks as well. Two checks replace the plain-Python run. A
  test fails when a file under `tests/` or `exercises/cases/` imports anything
  beyond Python's standard library and its own directory. The archive test now
  runs the reader's exercise command outside the locked environment, as a reader
  runs it. pytest takes the same test files as `just test`, which still runs the
  tests locally without the locked environment.
- The layout leaves fewer page feet empty. A section heading needs room for
  three body lines under it instead of six. A table or a sample box taller
  than six body lines continues on the next page instead of moving there whole,
  a table under a repeated header with each row whole; a code block of more than
  six lines may continue as well. The same text takes 187 pages instead of 190,
  and the pages short by six or more lines fall from 29 to 6. The wording does
  not change; page numbers do. The three pages that an exercise ends on purpose
  say so through `page-turn()`, and a check fails when the page before a table
  or a sample box is left emptier than a whole block allows.

## [0.2.2] - 2026-11-19

### Changed

- **Breaking:** the edition archive is now a gzipped tar,
  `rethinking-work-<version>.tgz`, the format of the owner's other
  repositories, instead of a zip. Its folder, reader notes, PDF, exercises and
  `SHA256SUMS` are unchanged; a rebuild of the same commit still gives the same
  bytes, names beyond ASCII travel as UTF-8, and no host user name enters the
  archive.
- The publication checks read every document fact from one layout of the book
  instead of one layout per fact, and each view of the PDF once; the six
  figures render at the same time. On the author's workstation the
  `publication-inputs` gate went from 117 s to about 16 s and `source-behavior`
  from 135 s to about 17 s. Each document check now fails when it spends half of
  that layout's CPU time, and both test gates' timeouts come down to 180 s.
- The repository declares a 24-hour release age for its supply: Mise's
  `minimum_release_age` (it was "0h") and uv's `exclude-newer`, whose span the
  lock records. ast-grep moves to 0.51.3, oasdiff to 1.39.0, uv to 0.13.9 and
  the hosted Mise that the GitHub jobs bootstrap to 2026.11.9, each the newest
  release at least 24 hours old on 2026-11-19.

### Fixed

- `exercises/reader-guide.zh.md` names the exercises folder as the edition
  archive lays it out (`重新理解工作/实战练习`); the 0.2.1 archive still carried
  the earlier folder name in that line.
- `publication/README.md` no longer says the private peer has no publication
  job; its `publication:macos` jobs have built the artifacts since 2026-11-17.

## [0.2.1] - 2026-11-19

### Changed

- **Breaking:** a release now carries one edition archive,
  `rethinking-work-<version>.zip`, and its SHA-256, instead of a separate PDF
  and practice archive. The archive holds one folder `重新理解工作/` with a
  reader note, `重新理解工作-<version>.pdf`, the exercises under `实战练习/` and
  a `SHA256SUMS` of every file, so the book and its exercises stay paired after
  download. Names are stored as UTF-8 for Windows and macOS unpackers, and a
  rebuild of the same commit gives the same bytes.
- The cover prints the version from `VERSION` beside the edition date, and the
  edition identity carries it; the publication test checks both against
  `VERSION`.
- Both reader notes are generated from `VERSION` and the edition date; the
  exercises' note no longer claims to pair with the 2026-11-15 manuscript.
- Appendix A and the hands-on example path `PACK=` follow the archive layout.
- The `practice-pack` task is replaced by `edition-archive`; both forges keep
  the edition archive as the publication job's artifact.

## [0.2.0] - 2026-11-19

### Changed

- **Breaking:** part five gains chapter 27 「共用的环境」, on a team's shared
  skills, rules and instruction files: one team repository is the authority,
  copies on each host are derived and checked, taught through TeamAI. Chapters
  27 to 29 become 28 to 30.
- Each Agent layer is now taught through the tool the team uses for it, with a
  hands-on section whose commands and outputs come from recorded runs: model
  and host (AIGW, Ollama, Claude Code, Codex), context (instruction-file
  discovery, semble, code-review-graph), tools (MCP with mcporter, skills with
  skills-manager and skill-scanner, hooks, RTK), boundaries (permission modes,
  path-scoped allow rules, the Codex sandbox, a `PreToolUse` hook, the
  Bitwarden CLI), memory (Hindsight), unattended runs and diagnosis (Hermes
  scheduled jobs, a port conflict), and several Agents (sub-agents, Git
  worktrees and Orca, Hermes kanban, Multica, Paperclip).
- Statements about how an Agent behaves rest on headless runs of 2026-11-16
  and 2026-11-18. Where a run did not reproduce a statement, the passage now
  describes a risk to check rather than a regular behaviour; where a run
  contradicted it, the statement was corrected. Appendix D states every run's
  conditions and counts once.
- Chapter 17's rule experiment rests on two rounds of six runs each, and the
  strong and light models were rerun under the same refusals.
- Appendix A lists install lines and the commands each chapter needs, appendix
  B the commands the chapters teach, appendix C every tool with its version.
- Readers of two model families read the changed chapters sentence by
  sentence, then the revised passages again; disagreements between readers
  were settled by the readers. The hands-on material was then compressed from
  208 to 190 pages without dropping an argument, a run's conclusion or a
  command a reader needs, and every compressed file was checked against its
  previous version and the run records.
- The diagram browser build is declared once, and the diagram task refuses
  clearly when no browser is available. Chinese inside commands and outputs
  uses the sans face. The layout test counts a chapter's closing block as a
  break between paragraphs.
- The publication-inputs gate's time limit is 600 s, a guard against a hung
  run; the suite exceeded 300 s once on a hosted macOS runner.

### Added

- The companion pack holds the second round of control answers and the strong
  and light models' answers of the rerun, with the light model's saved query.

## [0.1.0] - 2026-11-17

### Changed

- **Breaking:** rebuilt the manuscript as an account of work and team
  collaboration in the agentic era, set in a quantitative data team's business
  context, in twenty-nine chapters with four
  practice modules, an epilogue and an afterword. The definition of work yields
  four unavoidable conditions and three working criteria; responsibility stays
  with people, so understanding stays with people. The same question, how
  understanding is reached, is then asked for one person, after work is handed
  to an Agent, and for several people, before the book returns to the person.
  The Agent has a part of its own that explains one Agent layer by layer
  (model, harness, context, tools, boundaries, memory); several Agents and
  evaluation close the handing-over part, after delegation has been taught.
  Chapters on the Agent end with a hands-on section, most run in a
  scratch repository the reader builds in the first-session chapter. Examples are
  scenarios in that context. The figure set is
  six diagrams; the book gains a one-page quick reference; the companion pack
  carries two session briefs with the returned query and the conditions those
  sessions ran under, the unchanged answers of a control group and of one run
  each on a stronger and a lighter model, the hook and skill files of the tools
  chapter, two model-free evaluation files and two Chinese templates in the
  book's own terms, and its self-check has seventeen tests.
- Qualified the rebuilt edition of 2026-11-17 for delivery. Details that could
  identify a vendor, a colleague, an internal system or a schedule were
  rewritten or dropped, and the practice figures of the second part's fourth
  exercise were replaced by an invented set; an independent panel read the whole book for argument and teaching, for Chinese
  prose and for disclosure, and its accepted findings were applied and checked
  against the records. A readability round then read every sentence in parts of
  about thirty pages; terms are explained at first use and keep one meaning, and
  hands-on steps say where to run, what to do and what to expect. The edition
  acceptance guide now requires this cold read after the last content edit.
  The whole book was then rewritten for standard written Chinese in the
  author's register: non-standard words and calques replaced, oral fillers and
  colon-and-semicolon chains reduced, and fitting idioms used where they say a
  thing more exactly; verifiers checked every change for meaning, usage and
  idiom fit, and disagreements between checkers were settled by the checkers
  themselves. The whole book was then rewritten in an objective third-person
  register: the business context is stated once, examples are scenarios that do
  not claim to have happened, nothing stresses who did or wrote what, and
  details weakly related to a point were cut. The preface opens on one scenario
  whose stake is a decision; appendix D keeps the run conditions of the
  demonstrated sessions and the table of premises. Fresh readers read every
  sentence again in parts, and readers of a different model family read the
  first three parts, the fifth and sixth, and the whole book once for
  continuity. A section heading now starts the next page unless about
  six body lines fit under it. The edition's complete text, code, tables,
  figures, outline, links and metadata were checked against the native
  document, every page was reviewed, and the PDF and practice archive were
  delivered to the reader targets and read back.
- Check the edition's layout over every body paragraph: the publication test now
  joins Typst's own paragraph positions with the PDF's lines and requires flush
  starts, 16 pt line steps and 32 pt paragraph steps, instead of locating two
  manuscript sentences. Appendix D's sections are found by label, and the
  practice-pack test counts the pack's own tests.
- Build the PDF and the practice archive on both peers. The private peer's
  local macOS runners now run the same `ci-artifacts` recipe as the hosted job
  and keep both files as job artifacts for 14 days. The private peer had lacked
  this job only because its earlier Linux runner could not use the licensed
  Apple fonts. Each released version carries both files on both peers.
- Configure the third-party release age as `0h` in the repository Mise settings,
  keeping the value explicit and adjustable without changing global policy.
- Run private-peer source verification on the owner's local macOS arm64
  runners, as the owner's other repositories do, with one runner for protected
  refs and one for review. The runner supplies Mise and its account keeps the
  locked tools between jobs. The earlier Linux job on a department runner, its
  job cache and its 15-minute script deadline are withdrawn; the lock keeps its
  Linux x64 records without a consumer.
- Adopt the verification model of the owner's other repositories: the installed
  ETHOS release generates both pipelines from `.config/ci/verification.toml`,
  and each job runs the full proof with ETHOS 0.2.0-beta.10 and uv 0.13.8 locked
  as tools. A supply task provides the Noto faces, Typst packages, test
  environment and PDF tools against the repository's manifests. The hosted
  publication build remains as the repository's own job. The publication-inputs
  gate's time limit is 300 seconds; 120 seconds was exceeded under host load.
  On CI runners Mermaid uses Chrome for Testing's headless shell, which the
  supply task installs checksum-checked; Google Chrome did not start under the
  local runner's launch context.
- Organized synthetic exercises by teaching case, separating reusable templates
  and transfer assessment while preserving fixture bytes and behavior.
- Separated publication layout, diagnostics, supply manifests and third-party
  notices, updating their native task and manuscript consumers.
- Moved the publication Node lock to the 26.13.1 security release, preserving
  the other five tool versions and npm sidecars.
- Bound the native Mermaid task to software rasterization through supported
  Puppeteer configuration, with a real-browser replay regression. Same-host
  stability is qualified; changed raster pixels still require successor review.
- Reworked the opening around a quantitative data department's complete work
  chain, from the research question and source evaluation to modeling,
  production, quality, delivery and feedback.
- Connected tool choices to consequential uncertainties and inspectable outputs,
  and expanded the teaching path from repeated answers to transferable judgment.
- Dated the substantive PDF successor 2026-11-11; reader qualification and source
  integration retain their independent acceptance boundaries.

### Added

- Shared-source native GitHub and GitLab CI for pipeline consistency, formatting
  and all 15 synthetic exercise contracts, with exact-commit checkout and a
  checksum-bound, job-local toolchain. Private-peer execution needs a suitable
  Runner; source CI does not replace full PDF qualification or editorial review.
- Exact macOS arm64 locks for the four CI tools and Linux x64 records for the
  seven native source-CI tools, preserving existing records and npm sidecars.
- A modular Chinese handbook for quantitative data teams, with worked data,
  research, engineering, delivery and team-learning cases, explicit source
  qualifications and decision-led tool guidance.
- A single edition metadata owner and native Typst, Mermaid, formatting and
  verification tasks, with navigable figures and reader references.
- A synthetic practice companion with 15 executable checks covering source
  selection, entity-level reconciliation, effective-date mapping, explicit UTC
  cutoffs, exports, structural search and API contracts.
- A checksum-bound compiler, font and complete Typst package input manifest,
  with native replay and three missing/altered-input regression tests. The
  same-host network-disabled replay matches the delivered PDF. Approved native
  Mise locks now bind six publication tools on macOS arm64; independent-machine
  bootstrap and cross-machine reproduction remain unqualified.
- A repository version source and contributor links distinguishing source
  releases from PDF editorial editions.
- Repository-specific GitLab collaboration and GitHub public-distribution peer
  declarations, with exact signed-source publication and separate remote checks.
- An MIT license for the authored source, copyright 2026 衡阳.
- A locked Python 3.12 verification environment and native JUnit/Cobertura
  reports from the existing test cases, including subprocess exercise coverage.
