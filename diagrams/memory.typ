// Recall gives a lead, checked against the present before acting; a wrong record gets a correction.
#import "/publication/layout/figures.typ": figure-diagram, figure-node as n, figure-edge as e, figure-label as l
#let w = 26mm
#let body = figure-diagram(spacing: (9mm, 7mm),
  n((0, 0), <a>, [查记忆], width: w), n((1, 0), <b>, [对照眼前核实], width: w, emphasis: true),
  n((2, 0), <c>, [行动], width: w), n((3, 0), <d>, [写入纠正], width: w),
  e(<a>, <b>), e(<b>, <c>), e(<c>, <d>),
  e(<d>, (3, 1), (0, 1), <a>, l[下一次任务], label-side: right),
)
