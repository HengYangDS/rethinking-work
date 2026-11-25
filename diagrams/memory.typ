// Historical recall, current verification, action and correction; the next task starts from the record.
#import "/publication/layout/figures.typ": figure-diagram, figure-node as n, figure-edge as e, figure-label as l
#let w = 24mm
#let body = figure-diagram(spacing: (9mm, 7mm),
  n((0, 0), <a>, [查历史], width: w), n((1, 0), <b>, [核当前], width: w, emphasis: true),
  n((2, 0), <c>, [行动], width: w), n((3, 0), <d>, [保留与纠正], width: w),
  e(<a>, <b>), e(<b>, <c>), e(<c>, <d>),
  e(<d>, (3, 1), (0, 1), <a>, l[下一次任务], label-side: right),
)
