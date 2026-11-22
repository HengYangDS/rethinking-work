# Tasks

Scope: lone characters at the ends of wrapped lines in cells and boxes, tables and boxes split with too little on one
page, and a guard on the proof ticket. New scope enters as a task here before it is worked.

## 1. Contract

- [x] 1.1 "Typeset output keeps to its declared supply" covers wrapped lines in cells and boxes and split blocks; done
      when `openspec validate --strict` passes.

## 2. Checks

- [x] 2.1 The layout marks each table's and box's start and end and declares `split-least`; a test finds splits below
      it; done when it fails on the layout of `374655c`.
- [x] 2.2 The lone-character test covers every wrapped line; done when it fails on the layout of `374655c`.

## 3. Repair

- [x] 3.1 No wrapped line ends with one character alone; done when the test of 2.2 passes and the book holds its page
      ceiling.
- [x] 3.2 No split leaves less than `split-least` on a page; done when the test of 2.1 passes.

## 4. Guard

- [x] 4.1 The local proof ticket refuses a head whose book text has no reading record; done when it refuses a head
      without one and queues one with it.

## 5. Qualification

- [x] 5.1 The light gates pass, every reworded cell is read against its source, and the changed pages are looked at.
