// The Typst packages the edition imports, each at one version; the entrypoint, the layout, the figures and the
// colophon read them here. publication/supply/typst-packages.sha256 pins every file of these packages and of the
// packages they import, and a check fails when the compile reads a file it does not pin.
#let package-versions = (neat-book: "0.1.0", fletcher: "0.6.0")
#import "@preview/neat-book:" + package-versions.neat-book: neat-book, codly
#import "@preview/fletcher:" + package-versions.fletcher as fletcher
// A version as the colophon names a tool: its major and minor parts, 0.6 for 0.6.0.
#let version-line(version) = str(version).split(".").slice(0, 2).join(".")
