## Context

See [proposal.md](proposal.md). The justfile owns the tasks and the supply manifests in `publication/supply/` own
what is fetched; Typst owns where it looks for fonts and packages and says so through its own settings and
`typst info`. Every CI job runs `mise run ci-supply` before it builds; the GitLab jobs run on two accounts of the macOS
guest that keep files between jobs, the GitHub job on a fresh hosted machine.

## Goals / Non-Goals

**Goals:**

- No task writes into an account's font folder, and no file names a platform's folder or restates Typst's defaults.
- A runner that keeps its account between jobs fetches the supply once, and fetches it again only when it is missing
  or changed.
- The check that every package read is supplied reads the cache that the compile read.

**Non-Goals:**

- Builds that ignore the system's fonts. The body's faces, Songti SC and Charter, are macOS system faces that no
  supply can carry, so Typst keeps reading the system's fonts beside the supplied folder.
- What is fetched: the manifests' digests and the archive's address do not change; only the package manifest's paths
  lose their `packages/` prefix.

## Decisions

- **The faces' folder.** `cache_directory() / project / "fonts"`, declared once in the justfile: the platform's cache
  folder as `just` derives it, under the repository's name, which the justfile declares once as `project` and also
  uses for the PDF's and the archive's names. Not the account's font folder, which
  every application of the account reads; not `build/`, which the GitLab runner removes when each job starts; not
  Typst's own cache, whose layout Typst owns.
- **How Typst finds the faces.** The justfile exports `TYPST_FONT_PATHS` with that folder, after the font paths the
  caller set (joined by the platform's separator), so every task, the tests the test task runs and ETHOS's gates,
  which call the tasks, read the same faces, and a host that names its own font paths keeps them. Typst 0.15.1
  ignores a font path that does not exist (checked on 2026-11-27), so a host without the supply reads its own font
  paths and the system's fonts as before.
- **The package folders.** The supply task reads `packages.package-cache-path` from `typst info --format json`, and
  stops when Typst reports none; the manifest lists each file relative to that folder, so a
  `TYPST_PACKAGE_CACHE_PATH` moves the supply and the check together. The check reads the same report through
  `tests/edition.py`, with the standard library only, and counts the files under Typst's own package folder too,
  which Typst reads before the cache. Typst writes a file under the root into the compile's input list relative to
  the root and any other in full, and `typst info` repeats a configured folder as it was given, so the check resolves
  both from the root before comparing them (a cache inside the checkout: 272 package reads, all relative, all found;
  checked on 2026-11-27).
- **The old faces.** The two GitLab runner accounts each hold the three faces the old task installed
  (`rethinking-NotoSansCJKsc-*.otf`, read 2026-11-27). They are removed before landing, so that the first job of the
  new task fills the cache folder and the build reads the faces from there.

## Risks / Trade-offs

- [A face of the same name in a system folder] → Typst may read either copy. The maintainer's host holds the same
  three files in its font folder (digests equal to the manifest's, read 2026-11-27); on the runners the old copies are
  removed.
- [A cleanup of the account's cache] → The next job fetches the Noto archive and the packages again; nothing fails.
- [A later Typst renames or empties the field that `typst info` reports] → The supply task and the check stop with an
  error that names the field or says that no cache is reported; the upgrade that changes it changes both lines.
- [A supply folder left behind after the faces' manifest changed] → On a runner the supply task replaces a face whose
  digest differs before every build. On a maintainer's host the folder exists only if the task was run there, and
  running it again replaces the faces.
