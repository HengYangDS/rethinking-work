# Tasks

Scope: the layout rules in `publication/layout/style.typ`, the call sites they change in `book/`, one check in `tests/test_publication.py`, and the CHANGELOG. The wording of the book is out of scope. New scope enters as a task here before it is worked. Measurements and the pages looked at are in the Change's local evidence, `build/evidence/page-foot-gaps/`.

## 1. Layout rules

- [x] 1.1 Reserve three body lines under a section heading instead of 96 pt. Done 2026-11-20 06:45.
- [x] 1.2 Give tables and sample boxes one rule: whole up to six body lines by measured height, continuing above that, with table rows whole. Remove the `breakable` argument of `matrix` and its five uses. Done 2026-11-20 06:57; on a test page every table, box, heading and paragraph sits where the 0.2.2 rules put it (`measure/scratch/spacing/`).
- [x] 1.3 Let a code block of more than six lines continue on the next page. Done 2026-11-20 06:45.
- [x] 1.4 Add `page-turn()` and use it at the three pages that an exercise ends on purpose. Done 2026-11-20 06:45; the marks are on pages 35, 129 and 131.

## 2. Check

- [x] 2.1 Add a check that fails when the page before a table or a sample box is short by more than 128 pt, leaving out chapter ends and declared page turns. It passes on the lane; on a copy in which tables and sample boxes are unbreakable again it fails and names twelve pages (shown, not kept). Done 2026-11-20 07:05 (`ticket-0652.log`).

## 3. Documentation

- [x] 3.1 Add a CHANGELOG entry under `[Unreleased]`, and name the check in the tests' notes.

## 4. Qualification

- [x] 4.1 Measure the lane's PDF as the base was measured: page count, and pages short by three, six and eight lines, by cause. Done 2026-11-20 06:57: 187 pages (190); 31, 6 and 2 pages (57, 29 and 16). Of the 31, a heading begins the next page after 12, a short code block after 11, a short table after 2, and a paragraph or a chapter's closing lines after 6 (`measure/scratch/lane2.json`).
- [x] 4.2 Look at every page on which a table, a sample box or a code block continues, and at every section heading in the last six lines of a page. Done 2026-11-20 07:10: ten body pages and the appendix pages 179 to 187 where a table or a box continues, pages 78 and 79 where a code block continues, and 22 pages with a heading near the foot; each continued table repeats its header, and each of those headings has text under it (`pages-looked-at/`).
- [x] 4.3 Compare the CPU time of one compile on the base and on the lane, three runs each on two threads. Done 2026-11-20 07:05: base 5.98, 5.82 and 6.05 s; lane 6.15, 6.20 and 5.82 s (`ticket-0652.log`).
- [x] 4.4 The light gates and the publication tests pass on the lane. Done 2026-11-20 07:05: nine light gates pass (`light-gates-3.json`); `just check` passes with 39 tests under a host ticket, since the publication tests measured 2.59 cores and are not light work.
- [x] 4.5 The full proof passes on the lane head. Done 2026-11-20 07:26: the proof of `17facba` passes all 11 gates, `source-behavior` with the new check in 27.1 s; the gates finished after 53.8 s (`proof/`).
