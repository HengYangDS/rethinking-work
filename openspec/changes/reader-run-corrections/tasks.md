# Tasks

Scope: the printed commands and the statements beside them that the reader run of 0.2.2 found wrong, appendix D's record of that run, one check, and the release of 0.2.3. New scope enters as a task here before it is worked. Evidence is in `build/evidence/reader-run-0.2.2/` (the run) and `build/evidence/reader-run-corrections/` (this Change).

## 1. Corrections

- [x] 1.1 Chapter 18 and chapter 20: declare the registered job live with its cost, print its removal, and say that dispatching starts the gateway. Done 2026-11-20 12:00.
- [x] 1.2 Chapter 13: start the exercise in `default`, state the order of hook and prompt, report the two `acceptEdits` runs, and correct the mode table's row. Done 2026-11-20 12:00; the chapter's second statement of the starting mode (the paragraph under the mode table) is corrected with it.
- [x] 1.3 Chapter 10: split the two `git checkout` commands into two blocks without comments; state the starting mode; name the mode in the commands that continue a session, here and in appendix B; name the prompt's choices as shown. Done 2026-11-20 12:00; three later exercises that start a session now print the command.
- [x] 1.4 Chapter 19: wait a second before each request to a process the block starts. Done 2026-11-20 11:10.
- [x] 1.5 Chapters 9, 11 and 14: the configured AIGW, the two items a configured machine does not show, the graph's numbers, the default search result, the delay before an observation. Done 2026-11-20 12:00.
- [x] 1.6 Chapter 20 and appendix C: helpers read the instruction files by type; the exercise reads the type first. Done 2026-11-20 12:00; the two printed lines of the helper block give `Explore` twice on the reader run's stored session (`ch20-helper-type-lines.txt`).
- [x] 1.7 Appendix D: the conditions of the reader run, and the rows these corrections rest on. Done 2026-11-20 12:00: a fourth kind of session, four rows marked 照书, and the list of corrections that rest on documentation alone.

## 2. Check

- [x] 2.1 Add a check of the printed shell blocks: no `#` word outside quotes and here-document bodies, a `sleep` after a background start, a removal after each registered job. On the text of 0.2.2 it fails on all three (shown, not kept); on the corrected text it passes. Done 2026-11-20 11:06 and 12:03 (`check-red-on-0.2.2-text.txt`, `check-green-on-corrected-text.txt`): one page with comment words, two background starts without a wait, one registration never removed; none on the corrected text.

## 3. Documentation

- [x] 3.1 Add the CHANGELOG entries and name the check in the tests' notes. Done 2026-11-20 12:25, after the lane was refreshed onto `5800328`, which had changed both files.

## 4. Qualification

- [x] 4.1 Run the two chapter 19 blocks as printed, pasted whole, five times each. Done 2026-11-20 11:32: the second block gave 200 in 5 of 5 rounds; the first gave the printed five-second timeout in 5 of 5 rounds when run alone. Run seconds after the second block it cannot bind the port, which a reader's single pass does not do (`ch19-blocks-pasted-5x.txt`, `ch19-block-a-alone-5x.txt`).
- [x] 4.2 A reader who has not seen the edits reads every changed Chinese passage; what is found is corrected. Done 2026-11-20 12:15: one reader, four rounds over the changed passages against the evidence list; 17 findings, then 13, then 3, then 4 on three sentences shortened for the page; each taken or settled against the record (`changed-passages*.md`, `facts-for-the-reader.md`).
- [ ] 4.3 The reader-run session runs the changed blocks from the committed text in its scratch account: the model-free ones at once, the paid ones under the owner's cap.
- [x] 4.4 The light gates pass (done 2026-11-20 12:27, nine gates, `light-gates-3.json`). The publication tests run in the proof of task 4.5, not in a ticket of their own: the proof's test gate runs every test, and each ticket waited up to half an hour on 2026-11-20. Before the proof, the new check ran on the corrected text through its driver (`check-driver.py`).
- [ ] 4.5 The full proof passes on the lane head.

## 5. Release 0.2.3

- [ ] 5.1 Set `VERSION`, the CHANGELOG section and the edition's date.
- [ ] 5.2 Archive the Change; the proof of the archive head passes; land and close out.
- [ ] 5.3 Publish `dev`, then `main`, then the tag, each after the previous pipeline has ended with every job successful.
- [ ] 5.4 Build the edition archive from the release head, create the release on both forges, and read both back by hash.
- [ ] 5.5 Deliver the archive beside 0.2.2 without replacing it, and retire the lane.
