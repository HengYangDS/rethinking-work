# Design

## Context

`VERSION` is the repository's version authority (README); `book/metadata.typ` owns the edition identity shown on the cover and in PDF metadata. Release 0.2.0 kept the two apart on purpose, to say that a version is not editorial acceptance. The result was a PDF without a version and a practice note with a stale date, written by hand.

## Goals / Non-Goals

Goals: every delivered file shows the version it belongs to; the reader receives one archive that holds the book and its exercises; every identity statement is derived from one source at build time.

Non-goals: editorial acceptance (a version still does not establish it); changing manuscript or exercise content; a cross-repository mechanism (that belongs to ETHOS).

## Decisions

### One source

`book/metadata.typ` reads `VERSION` (`read("/VERSION")`), so the cover and the `<edition-identity>` metadata carry the same string the tag carries. The packaging recipe reads the same file.

### Cover line

The cover prints `<version> 版 · <date>` under the author. PDF metadata has no version field in Typst's `document`; the cover is the reader-visible carrier and the test checks it against `VERSION`.

### Archive layout

`rethinking-work-<version>.zip` contains one folder `重新理解工作/` with `先读.txt`, `重新理解工作-<version>.pdf`, `实战练习/` and `SHA256SUMS`. The top folder carries no version, so the manuscript's example path `~/Downloads/重新理解工作/实战练习` stays valid across releases; the version is on the archive name, the PDF name, the cover and both reader notes.

### Zip writer

The standard library's `python3.12 -m zipfile -c` sets the UTF-8 name flag, so Chinese names extract correctly on Windows as well as macOS; Info-ZIP and `ditto` on this host do not set it (checked 2026-11-19). Python 3.12 is already a declared tool.

### Generated notes

`publication/reader-start.zh.txt` (exercises) and `publication/archive-start.zh.txt` (archive) are templates with an `@VERSION@` token; the recipe substitutes it and refuses if a token remains. The archive note also names the source commit.

### Checksums inside and outside

`SHA256SUMS` inside the archive lists every other file in it, so the pairing survives after unpacking; the release also carries the archive's own SHA-256 so a download can be checked before unpacking.

### Alternatives considered

- Keep two assets and add a manifest: rejected; the pairing would still depend on the release page.
- Version in the top folder name: rejected; every release would change the eight example paths in the manuscript.
- tgz: rejected; it does not open by double-click on Windows.

## Risks / Trade-offs

- A reader with an older unpacked `重新理解工作/` folder gets a second folder from the unpacker; the version on the PDF name and both notes tells them apart.
- The test-performance lane edits `tests/test_publication.py` in parallel; whichever lands second rebases.
