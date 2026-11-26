// One edition identity for the cover, colophon and native PDF metadata.
#let book-title = "重新理解工作"
#let book-subtitle = "智能体时代的工作与团队"
#let book-author = "衡阳"
// The repository version is the one in VERSION. Whether this build is that version's edition, and its date, come
// from the build (`edition_inputs` in publication/justfile, read from git); a compile given no inputs is a draft.
#let book-version = read("/VERSION").trim()
#let book-release = sys.inputs.at("edition", default: "draft") == "release"
#let book-commit = sys.inputs.at("commit", default: none)
#let book-changed = sys.inputs.at("changed", default: "false") == "true"
#let book-released = sys.inputs.at("released", default: "false") == "true"
#let book-date = sys.inputs.at("date", default: none)
#let book-date = if book-date != none {
  let (year, month, day) = book-date.split("-").map(int)
  datetime(year: year, month: month, day: day)
}
#let book-date-text = if book-date != none {
  str(book-date.year()) + " 年 " + str(book-date.month()) + " 月 " + str(book-date.day()) + " 日"
}
// The edition as the cover and the reader notes name it: the version and the tag's date for a release; for a
// draft, the version it leads to or, once that version is tagged on another commit, the version it follows, then
// the commit, and that tracked files differ from it when they do.
#let book-edition = if book-release { book-version + " 版 · " + book-date-text } else {
  book-version + if book-released { " 之后的草稿" } else { " 草稿" }
  if book-commit != none { " · 提交 " + book-commit }
  if book-changed { "，另有未提交的改动" }
}
#let book-keywords = ("智能体", "工作设计", "团队协作", "判断与责任", "证据与信任", "组织与领导", "数据工作")

// The edition archive, as the book, its reader notes and the archive task (`publication/justfile`) name its parts:
// one folder named for the book holds the PDF, the practice pack's folder, a note to read first and a SHA-256 list;
// the pack holds a note of the same name. The book tells the reader where the pack lies once the archive is unpacked
// in Downloads, which appendix the pack's note points to, what the pack's checks need and the command that runs them
// on the toolchain's Python line (`.config/mise/config.toml`).
#let book-pdf = book-title + "-" + book-version + ".pdf"
#let book-pack = "实战练习"
#let book-note = "先读.txt"
#let book-sums = "SHA256SUMS"
#let book-pack-path = "~/Downloads/" + book-title + "/" + book-pack
#let book-companion = "随书练习"
#let book-python-line = toml("/.config/mise/config.toml").tools.python
#let book-checks = "tests/test_exercises.py"
#let book-check = {
  let segments = book-checks.split("/")
  let folder = segments.slice(0, -1).join("/")
  "python" + book-python-line + " -B -m unittest discover -s " + folder + " -p " + segments.last() + " -v"
}
// What a machine needs before the pack's checks run; the pack installs none of it.
#let book-pack-tools = ("Python " + book-python-line, "DuckDB", "ast-grep", "oasdiff").join("、", last: " 和 ")
// An authored code block in which `@PACK_PATH@` stands for the place of the pack: the block as the reader sees it,
// with the declared path.
#let pack-code(it) = raw(it.text.replace("@PACK_PATH@", book-pack-path), lang: it.lang, block: it.block)
