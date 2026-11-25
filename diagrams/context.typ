// What one request to the model contains: five sources gathered into the context, which the model reads.
#import "/publication/layout/figures.typ": figure-diagram, figure-node as n, figure-edge as e, figure-label as l
#let w = 24mm
#let body = figure-diagram(spacing: (8mm, 3mm),
  n((0, 0), <s>, [宿主的说明], width: w), n((0, 1), <p>, [说明文件], width: w),
  n((0, 2), <t>, [工具清单], width: w), n((0, 3), <h>, [对话], width: w),
  n((0, 4), <r>, [工具结果], width: w),
  n((2, 2), <c>, [上下文], width: w, emphasis: true), n((3, 2), <m>, [模型], width: 18mm),
  n((4, 2), <o>, [回答或工具调用], width: 32mm),
  ..(<s>, <p>, <t>, <h>, <r>).enumerate().map(((i, k)) => e(k, (1, i), (1, 2), <c>, marks: if i == 2 { "-|>" } else { "-" })),
  e(<c>, <m>), e(<m>, <o>),
)
