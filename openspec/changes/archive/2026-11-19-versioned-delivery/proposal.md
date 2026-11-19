# Proposal

## Why

Release 0.2.0 shipped a PDF that shows only its date and no version, and a practice archive whose reader note still said it pairs with the 2026-11-15 manuscript. The two were separate release assets, so once a reader had downloaded them nothing showed that they belong together. The owner asked on 2026-11-19 that the PDF carry its version, that the exercises carry it too, and that both be delivered complete in one archive.

## What Changes

- The PDF cover prints the version read from `VERSION`, beside the edition date.
- The release is one zip archive. It holds a top-level reader note, the PDF named with its version, the exercises folder and a SHA-256 list of every file in the archive. It replaces the separate PDF and practice archive as release assets.
- The reader notes of the archive and of the exercises are generated from `VERSION` at packaging time; no date or version is written into them by hand.
- The manuscript's example path to the exercises and appendix A follow the new layout.
- **BREAKING** for anyone who downloads release assets by name: the assets become the archive and its SHA-256 list.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: an edition SHALL show its version on the PDF and in every reader note, and SHALL be released and built as one archive that holds the PDF and the exercises with their checksums.

## Impact

`book/metadata.typ`, the cover, appendix A and the eight example `PACK=` lines; the packaging recipe and two reader-note templates in `publication/`; the practice-archive test and one PDF identity assertion; both forges' CI artifact paths; README, VERSION and CHANGELOG. Out of scope: the content of the book and the exercises, the test-performance work in its own lane, and ETHOS changes that would make the same guarantee for every governed repository.
