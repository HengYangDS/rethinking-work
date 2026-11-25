// The look of every figure, declared once: figures are drawn in Typst with fletcher, in the book's compile, in
// the book's sans face and the layout's colours. A figure's meaning (its nodes, labels and arrows) lives in
// `diagrams/`. Five rules keep them plain: the boxes of one figure share one width; a box names its step in bold
// and may add one muted line; arrows run straight or at right angles; a label sits beside its arrow on white;
// one box per figure may be emphasised, and a box off the main path is dashed.
#import "@preview/fletcher:0.6.0" as fletcher
#import "palette.typ": ink, tint, slate, muted
#let figure-node(pos, name, title, detail: none, width: 30mm, height: auto, emphasis: false, quiet: false) = fletcher.node(
  pos, name: name, width: width, height: height, inset: 5pt, corner-radius: 3pt,
  fill: if emphasis { ink } else if quiet { white } else { tint },
  stroke: if quiet { (paint: slate, thickness: .6pt, dash: (2pt, 1.5pt)) } else { .6pt + if emphasis { ink } else { slate } },
  align(center, {
    text(weight: "bold", fill: if emphasis { white } else { ink }, title)
    if detail != none {
      linebreak()
      text(size: 7.5pt, fill: if emphasis { tint } else { muted }, detail)
    }
  }),
)
// An arrow between boxes, one-headed unless a figure says otherwise; its label is small and muted, on white.
#let figure-edge(..args) = fletcher.edge(stroke: .7pt + slate, marks: "-|>", label-fill: white, label-sep: 3pt,
  ..args.pos(), ..args.named())
#let figure-label(body) = text(size: 7.5pt, fill: muted, body)
#let figure-diagram(..args) = {
  set text(font: "Noto Sans CJK SC", size: 9pt, fill: ink)
  fletcher.diagram(..args)
}
