// Task, action, tool result, correction and stopping: the loop runs down the middle, its exits to the left.
#import "/publication/layout/figures.typ": figure-diagram, figure-node as n, figure-edge as e, figure-label as l
#let w = 26mm
#let body = figure-diagram(spacing: (22mm, 6mm),
  n((1, 0), <h>, [人定目标], width: w),
  n((0, 1), <end>, [运行结束], width: w, quiet: true),
  n((1, 1), <a>, [智能体选行动], width: w, emphasis: true),
  n((2, 1), <t>, [工具执行], width: w),
  n((0, 2), <s>, [停下询问或说明], width: w, quiet: true),
  n((1, 2), <r>, [检查结果], width: w),
  n((1, 3), <d>, [交付], width: w),
  e(<h>, <a>), e(<a>, <t>), e(<t>, (2, 2), <r>),
  e(<r>, <a>, l[纠偏], label-side: right),
  e(<a>, <end>, l[到上限], label-side: right),
  e(<a>, <s>, l[越界或缺条件], label-side: left),
  e(<r>, <d>, l[完成], label-side: left),
)
