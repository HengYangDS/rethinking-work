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

### Changed

- The repository runs ETHOS 0.2.0-beta.12, from the release's own declaration.

## [0.2.9] - 2026-11-28

### Added

- A repository skill, `.agents/skills/book-chinese-prose`, carries the book's
  standard of Chinese prose: decided terms, translated forms and their
  replacements, how to write about people, how to compose a chapter, and the
  lenses of a reading. A second skill, `book-delivery`, carries what an agent
  needs to deliver a change here beyond ETHOS's own results. Every proof checks
  both against their activation record and packages.

### Changed

- Every chapter is revised to that standard and read sentence by sentence by
  readers who did not edit it: idiomatic Chinese, people first, and composition
  within and across chapters. 「有权决定的人」 becomes 「决策负责人」
  throughout, and chapter 29 opens with what assessment is for and agrees the
  next step with the member. No command, recorded output, fact or number
  changes.
- Errors found by the error-rate sample of the revised text, and the same kinds
  across the book, are corrected: small matters keep a light review instead of
  none, so that chapters 23 and 25 agree with the five functions every matter
  needs; a measure word; coordinate items joined by 、; two clauses separated
  by ，; names in table cells joined by 、; and no second colon inside a
  sentence.
- A third judge family read the same sample and counted thirteen more places:
  eleven where a word does not fit what it names, two where a 、 joins two
  clauses. All thirteen are corrected, and both kinds are searched across the
  book; one further place of the same kind is corrected. With them the sample
  stands at 2.65 points per 10,000 characters, above the bar of 1.
- A second sample, of pages not read before, stands at 1.22 per 10,000, above
  the bar of 1. Its nine places and one more found by re-reading the changed
  passages are corrected, with their kinds across the book: two summaries of
  the practice pack's instructions that said more than the file, a severity
  level spoken of as a finding, 访问 with a matter as its object, the mark
  after a colon that introduces a question or what a check is to find, a mark
  after a quotation that ends in ？, clauses joined by 、, 要求 listed beside
  口径 and 边界 where it includes them, and spending, which cannot be undone,
  placed in the middle circle. Chapter 3 now names spending as the exception
  to its rule that what cannot be undone takes the heaviest procedure: the cap
  set beforehand is the one agreement, and each payment within it is not
  decided again. A summary of the practice pack's rule on copying now says
  what the file says: copy the case directory and work in the copy.
- A read-through of the 77 body pages that neither sample of 0.2.9 read counts
  fifteen more places; they are corrected with their kinds: a list of judgments
  that left one out, a judgment called a statement of fact, the vendor's ingest
  time taken as the moment of use without the local collection, the vendor's
  database called by the local one's name 入库, a query's report called the
  source's problems, 只 where more follows, numbers listed with ，, 连同 without a
  verb, a subject that shifts within a clause, an answer promised where a
  checklist stands, a quoted question without its ？, a gloss that did not show
  what it named, and clauses joined by 、.
- A third sample, drawn from the whole body once every page had been read and
  corrected, stands at 0.31 per 10,000, below the bar of 1. Its three places
  are corrected with their kinds: a count stated as fact before the passage
  corrects its unit, 它 for a party that may be a person, and a colon whose
  reach crossed a semicolon into a parallel item.
- Wording that readers noted but no judge counted is made plain: pointers name
  their section, counts and terms match the files and chapters they describe,
  补录 names the vendor's backfill throughout, and the work-loop figure takes
  the exit for a step out of bounds from the choice of action, as the text does.
- Three printed blocks are corrected: the second step of the memory-library
  diagnosis unsets the key as the first unsets the address, a command printed
  over three lines carries its line continuations, and a comment in an
  evaluation configuration gives the gist of the prompt instead of quoting it.
- A later sample of an edition avoids the pages its earlier samples read only
  until every body page has been read, with every item judged as a sample's
  are, and the errors found are corrected; it is then drawn from the whole
  body.
- Chapter, practice, appendix and part numbers, and the counts of a part's
  chapters, are derived from the reading order; a reference written by hand
  fails the check. The archive's names, the pack's place, the tools its checks
  need and the command that runs them are declared once in
  `book/metadata.typ`, and the reader notes, now in `publication/notes/`, read
  them. The companion appendix says that the PDF and the pack share a version.
- The toolchain, the layout and the supply each declare their facts once: the
  Python line, the Typst packages, type sizes, margins, closing marks and the
  CI supply's sources. The publication jobs of both peers take their steps from
  the generated verification job, and the runners keep the fonts and packages
  in the account's cache.
- The review record holds exactly its declared fields; a commands review also
  records the reader notes and the Python line that the printed commands name.
- The specification is split into nine capabilities; no obligation changes.

## [0.2.8] - 2026-11-26

### Changed

- The transfer cases are three Chinese questions with their points
  (`exercises/assessment/transfer-cases.zh.md`, in place of the English points
  of `transfer-cases.json`), each changing one condition of an exercise or
  section: two rows of one revision that disagree, returns read from a CSV file
  as strings, and three entry points to one tool on different versions.
- `book/README.md` names the four appendices, and `book/parts/README.md` puts
  orchestration and evaluation in the fourth part.
- The acceptance test fails a head whose latest commands review names any
  release but the last one, the latest signed `vX.Y.Z` tag made no later than
  the review, so that a baseline copied from an older record cannot pass; a
  review time must carry its offset, and reviews are recorded in the order they
  were read. GitLab's verification jobs fetch every tag.
- Four places are corrected: what the outer circle of chapter 13 cannot undo,
  what appendix C says Hermes reports, and two sentences of chapter 29 brought
  to DDWG's wording.
- The hosted jobs install Mise 2026.11.14, the latest stable release.

## [0.2.7] - 2026-11-26

### Changed

- The six figures are drawn in Typst with fletcher, in the book's own compile:
  vector, in the book's sans face and the layout's colours, their text
  selectable, each with its alternative text. Mermaid CLI, Puppeteer and the
  Chrome headless shell are gone from the supply, the tasks, CI and the tests;
  fletcher and CeTZ join the locked Typst packages. The colophon names the new
  tool.
- Windows is no longer supported: the Mise supply pins ETHOS for macOS and Linux
  only, and the archive promises its reader macOS or Linux.
- The edition's identity comes from git, not from a written date: only a clean
  build of the commit that the signed tag `v<VERSION>` names is that version's
  edition, dated by its tag; every other build is a draft that names its commit
  (「0.2.6 之后的草稿 · 提交 …」 once that version is tagged), on the cover, in
  the PDF metadata and in both reader notes. The justfile reads it once for
  every compile, test and archive; the hosted publication job fetches a tag
  event's tag. Tests hold the draft and the release forms.
- Page 148's 「都合乎题材和读者」 is corrected to 「都切合题材、适合读者」, as the
  shared rules now define 雅. Further places are corrected: four quoted
  questions keep their question mark, 「换算」 becomes 「重新归类」 for
  re-classified industries, and three sentences in chapters 2, 27 and 29 are
  reworded.
- `docs/publication-acceptance.md` states how the error-rate sample counts and
  reads its notes.
- Each figure and its caption stand centred in the text column, held by a
  layout test.
- The text says each fact once, where it belongs: a run's conditions and
  versions stay in appendices C and D, results are no longer told before the
  上手 section that produces them, part introductions and repeated examples go,
  chapters 14 and 30 open on a scene, chapter 18 describes its paid scheduled
  task instead of registering and deleting it, chapter 28's four marks of 突出
  move to chapter 29, and the ending is one paragraph.
- The practice pack has one reader index, appendix A: the Chinese reader guide,
  which repeated the exercises with their answers, and six English templates the
  book never cited are removed. The snapshot difference is named
  `snapshot_minus_expected_bps`, the direction the keyed reconciliation uses.
- Figures 1, 2, 5 and 6 use their chapter's words and steps, without an
  unexplained dark box.
- One task interface: Mise keeps `ci-supply` and the toolchain verbs ETHOS asks
  for (`bootstrap`, `check`, `fix`), and the local `test` task runs the tests as
  the proof does. Unused build tables, a leftover `.zip` cleanup
  and a second copy of the Prettier arguments are gone.
- One contributor guide, `CONTRIBUTING.md`, replaces the guide and index under
  `docs/`; the acceptance document states the release steps and drops
  migration-era passages; the OpenSpec configuration no longer says that no
  public licence is implied.
- The tests read the measure, the exercise cases and the printed hook from their
  owners instead of pinned numbers and positions, and resolve the declared
  Poppler once instead of starting Homebrew for every PDF read; two cases that
  tested Homebrew's own behaviour are gone.
- GitHub's publication job takes its supply as every other job does, through
  `mise install --locked` and `mise run ci-supply`, instead of 48 shell steps of
  its own; `ci-supply` reads the Typst packages from their manifest. The offline
  replay of 2026-11-10 (`typst-inputs.sha256`, `pdf-isolated` and its tests),
  `toolchain.json` and the unused diagnostic entrypoint are retired; the layout
  declares its faces once and the font test reads them there. The publication
  README states the current contract only.
- The book's parts are declared once in `book/manuscript.typ`; the chapter heads
  and the contents follow them, and the tests check rules (numbered chapters
  without a gap, each part's chapters together) instead of pinned lists. Layout
  functions nobody called and the second way of writing a relative reference
  are gone, and the entry file's layout rules live in the layout module. The
  PDF's text is unchanged.
- Errors found across the whole book before the release are corrected, except
  a quoted brief kept as it was written.
- Further errors and two more places of the same kind are corrected: a figure
  box's measure word, what host rules lessen, ordered series set with 顿号, a
  gloss at the first use of 「token」, and a git label in code type.
- oxifmt, which CeTZ imports, joins the locked Typst packages and the notices; a
  test holds every package the compile reads to the supply.
- Chapter 17 says five of six runs named their basis; appendix D gives the first
  kind of run its host, model and dates; chapters 11 and 15 again say what their
  runs did not test; figure 2 sends the set-aside securities from the step where
  each leaves. The book is 197 pages.
- Twenty-six places are reworded. Clock times take two-digit hours throughout,
  and chapter 24's lead ends on its question.
- Chapters 28 and 29 say that judging rests on work performance and name
  nothing it does not rest on, as DDWG 10.1.2 does; 37 sentences across the
  book that denied a meaning nobody gave, repeated the point just made or
  explained the obvious are cut.

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
- Chapter 3's passage on responsibility is revised.
- Every CI job runs on the macOS label `macos-latest`: GitHub's two jobs, and
  GitLab's jobs with `review` or `protected`; each forge's label is declared
  once in `.config/ci/verification.toml` and read by `.config/ci/pipeline.cue`.
- Text is tightened where the new measure left a loose or short line, a lone
  character or a chapter's last page nearly empty, each edit keeping its facts;
  other passages are revised as well.

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
- A quoted brief's full stop now sits inside its closing quotation mark
  (chapter 9), and a computed percentage is written in Arabic numerals
  (chapter 11), as the book writes others. The same kinds are corrected in
  practice 4 and chapter 29, and the brief of chapter 10 ends with a full stop
  like the book's other briefs.
- Further errors found before the release and their kinds are corrected, except
  page 148's 「都合乎题材和读者」, which restates the shared rules'
  definition of 雅 and is left until that definition is settled.
- More errors and their kinds across the book are corrected: figures are set
  where they are called, inside their own section and after the text that
  introduces them, where three had floated above its heading; a code block that
  continues on the next page parts between two commands, never inside a command
  continued with `\`; a measured size of five digits is in Arabic numerals;
  quotations match the words they quote; a colon's scope no longer runs past a
  semicolon or holds a second colon (eighteen places); the hook sentence of
  chapter 12 no longer says that every hook matches a tool; practice 4's card
  takes chapter 26's second question. Tests hold the figure and code-block
  rules.
- Errors in the appendices and the preface are corrected: the preface no longer
  says that every example is from data work, every exercise file is in the pack,
  or every tool sits in a layer; appendix C's first column reads 「层或类别」
  and its `AGENTS.md` row says when Claude Code reads it; appendix D's run
  descriptions match their counts and conditions, and its punctuation follows
  the book's rules. A quoted question keeps its question mark where the words
  are quoted as asked, here and in chapter 9 and practice 2.

## [0.2.5] - 2026-11-24

### Added

- A head that changes the book's text or exercises is proved only with its
  reviews on record: `publication/acceptance/reviews.toml` records each review
  of the printed commands (keyed by the trees of `book/` and `exercises/`) and
  each reading of changed passages (keyed by `book/`), with how every point was
  settled or declined, and `tests/test_acceptance.py` fails a head that no
  record covers.
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

- Across the book, 195 repairs restore missing premises and referents, narrow
  overstatements to what the book and its records support, explain terms where
  they first appear and keep each in one sense, and split crowded sentences.
  Chapter 19 keeps its six pages.
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
  or exercise changed.
- The accepted specification declares what qualifies an edition for release
  (fresh readers under chapter 24's 信、达、雅, a whole-book cold read with
  later changes read again, the prose beside printed commands against the run
  records and every command whole in the PDF, every page looked at, and an
  error-rate sample of the final text), and the acceptance guide describes each
  stage.
- Tests check that the PDF embeds only the declared fonts, compiles without
  warnings, and ends no body paragraph with a single character alone.

### Fixed

- Errors found before the release are corrected with the same kinds elsewhere
  in the book: a word, punctuation between clauses joined by 却 or 但, a colon
  after 如下, list items separated by 顿号, corner brackets in a comment, and
  one table's durations, now all in Arabic numerals.
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

- The whole book is reviewed and repaired.
- Book-wide terms are fixed once and used alike in every chapter; names that one
  chapter defines (the record's five fields, the conditions for handing work
  over, the role names, the stop conditions) are copied verbatim elsewhere.
- Chapter 3 states the responsibility convention: responsibility follows the
  decision that let an error through, not rank.
- Chapter 24 states 信、达、雅 as the shared definition does: 信 is
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
- Errors found before the release are corrected, each with its kind across the
  book: figure 6 matches chapter 15, the Hermes `--no-agent` sentence and the
  `is_async` reference say what the text around them says, practice-card titles
  keep to their items, and an ordinal, a direct question and a status value
  follow the book's punctuation and type.
- Further errors are corrected: chapter 4 names both of its deviations as
  behaviours, chapter 5 states the limit of ingest time as its example shows,
  and three questions, two percentage-point figures and one colon follow the
  book's convention.

## [0.2.3] - 2026-11-20

### Fixed

- Chapter 18 now says that the registered `reconcile` job is live and prints
  its removal; chapter 20 says that dispatching a card starts the gateway. The
  boundary exercise of chapter 13 starts in the `default` mode:
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
  run of 0.2.2's printed commands.

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
  `rethinking-work-<version>.tgz`, the format of the other repositories ETHOS
  manages, instead of a zip. Its folder, reader notes, PDF, exercises and
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
- The hands-on material was compressed from 208 to 190 pages without dropping
  an argument, a run's conclusion or a command a reader needs.
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
- Details that could identify a vendor, a colleague, an internal system or a
  schedule were rewritten or dropped, and the practice figures of the second
  part's fourth exercise were replaced by an invented set; the book was revised
  for argument and teaching, for Chinese prose and for disclosure. Terms are
  explained at first use and keep one meaning, and hands-on steps say where to
  run, what to do and what to expect. The edition acceptance guide now requires
  a cold read of every sentence after the last content edit. The whole book was
  then rewritten for standard written Chinese in the author's register:
  non-standard words and calques replaced, oral fillers and colon-and-semicolon
  chains reduced, and fitting idioms used where they say a thing more exactly.
  The whole book was then rewritten in an objective third-person register: the
  business context is stated once, examples are scenarios that do not claim to
  have happened, nothing stresses who did or wrote what, and details weakly
  related to a point were cut. The preface opens on one scenario whose stake is
  a decision; appendix D keeps the run conditions of the demonstrated sessions
  and the table of premises. A section heading now starts the next page unless
  about six body lines fit under it.
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
- Run private-peer source verification on local macOS arm64 runners, as other
  repositories do, with one runner for protected refs and one for review. The
  runner supplies Mise and its account keeps the
  locked tools between jobs. The earlier Linux job on a department runner, its
  job cache and its 15-minute script deadline are withdrawn; the lock keeps its
  Linux x64 records without a consumer.
- Adopt the verification model of the other repositories ETHOS manages: the
  installed ETHOS release generates both pipelines from
  `.config/ci/verification.toml`, and each job runs the full proof with ETHOS
  0.2.0-beta.10 and uv 0.13.8 locked as tools. A supply task provides the Noto
  faces, Typst packages, test environment and PDF tools against the
  repository's manifests. The hosted publication build remains as the
  repository's own job. The publication-inputs gate's time limit is 300 seconds;
  120 seconds was exceeded under host load. On CI runners Mermaid uses Chrome
  for Testing's headless shell, which the supply task installs checksum-checked;
  Google Chrome did not start under the local runner's launch context.
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
