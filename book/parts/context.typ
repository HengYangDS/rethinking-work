#import "/publication/layout/style.typ": *
#import "/book/metadata.typ": *
#chapter("上下文：它眼前有什么", "对话进行到第三个小时，智能体把空值补成了零，而开头已经商定“空值不补”。那句话此刻还在它眼前吗？")<context>
设想与智能体一起把一件事从上午做到下午。开头商定了“空值不补”，中间一切顺利。到了第三个小时，智能体交回的表里，空值被补成了零。问它原因，它道歉并改了回来；过了一会儿，又补上了。这时要问的不是它是否敷衍，而是那句话此刻是否还在它眼前。

#chapref(<agent>)的第一条性质，说的正是这种情形。

== 一次请求里有什么
模型每走一步，都要把送给它的全部文字从头读一遍。这一长段文字就是上下文。

#reader-figure("context", [一次请求送给模型的全部内容，即上下文（见#chapref(<agent>, link: false)第一条性质）。], [宿主的说明、说明文件（项目的和用户级的）、工具清单、到目前为止的对话、工具带回的内容，五项拼成上下文送给模型；模型读完，写出一段回答或者一个工具调用。])

其中大致有五项内容：宿主的说明，即模型的角色和须遵守的规则；说明文件，有项目的和用户级的两种，前者写明这个仓库做什么、怎样检查、哪些内容不能改动，后者写明对所有项目都适用的约定；工具清单，列出有哪些工具、各自如何使用；到目前为止的对话，即你的要求和它的回答；工具带回的内容，比如读过的文件、查询的结果、报错信息。

== 长度上限与压缩
上下文有长度上限，以 token 计。token 是模型处理文字时切分出的小片段，与字数并不等同。在#chapref(<case-records>)所记试验使用的 Claude 轻量模型上，一个常用汉字大约占一个 token；换一个模型，分词方式可能不同，这个比例要重新测量。

接近装满时，宿主会压缩上下文：把前面的对话替换为一份摘要，腾出空间继续工作。摘要是一次转述。转述可能漏掉一句否定、一个条件、一个截止时间，而这类话往往只说过一遍。#chapref(<case-records>)记的一次运行中，压缩之后三条限制都还在；但那次的要求只有这三条，限制只是长篇对话中的一句时会不会丢，还没有检验。开头那句“空值不补”是否在压缩时丢失，要查过才知道。

写进说明文件的约定另有一层保障：在所查的几份 Claude Code 会话记录中，每次压缩之后，宿主都随即重新附上了说明文件。所以，对每件事都成立的限制，要写进说明文件。只属于这一件事的，比如这一次要把数据复原到哪一时刻，写在委托里（#chapref(<delegate>)）；委托也是对话的一部分，没有这层保障，压缩之后要对照委托再查一遍。怎样从记录中看到这一点，见本章“上手”。

#note("压缩之后，查三项", [要求中的“不要”和“只”是否还在。口径和截止时间是否还在。它现在报告“已经完成”，依据的是压缩之后重新查看的结果，还是只有摘要。前两项让它复述，再与原来的要求核对；第三项要在记录中找到它压缩之后重新查看的那一步。前两项复述得不对，或者第三项在记录中找不到那一步，就让它重读原件。])

宿主会自动压缩，你也可以手动压缩，两者在会话记录里分别记作 `auto` 和 `manual`。在 Claude Code 会话中，下面两条斜杠命令一条查看上下文的占用，一条执行压缩；与上下文有关的其余几条，以及 Codex 中的对应命令，列在#chapref(<quickref>)。

#matrix(columns: (0.8fr, 2.4fr), [*命令*], [*做什么*], [`/context`], [把当前上下文的占用绘成一张方格图：宿主的说明、工具清单、对话、文件各占多少], [`/compact`], [把此前的对话压缩成一份摘要，腾出空间])

== 何时另起一个会话
压缩之后，旧对话仍以摘要的形式留在上下文里。遇到以下几种情况，最好另起一个会话：转向一件不相干的事；这次对话中走了许多弯路；它开始重复，或者前后说法不一。另起会话用 `/clear`，旧会话仍保留在磁盘上，见#chapref(<quickref>)。后两种情况，另起之前先写一份交接说明，带到新会话中，写法见#chapref(<run>)。新会话从这份说明和眼前的文件开始，不再受旧对话中那些弯路的干扰。

== 一次请求的花费
每一步都要把到目前为止的全部内容重新发送一遍，所以一件事送进的 token 数，大致是步数乘以上下文的平均长度。事情做得越久，上下文越长，每一步就越贵。

请求开头没有变化的部分可以缓存，重新发送时便宜得多。下面是一次会话开头三次请求的用量，单位为 token：

#matrix(columns: (0.6fr, 1fr, 1fr, 1fr, 0.8fr), [*请求*], [*送进，不经缓存*], [*送进，写入缓存*], [*送进，从缓存读取*], [*它写出的*], [1], [19,113], [48,431], [0], [778], [2], [816], [27,768], [48,431], [547], [3], [46], [4,558], [76,199], [495])

看第三次请求。三栏“送进”合计八万多个 token，其中 94% 从缓存读取，它写出的只有几百个。前两次送进的也都在六万个以上，写出的都不到八百个。所以一件事用掉的 token，绝大部分是送进去读的，而不是它写出的。

即使上下文没有装满，多放也有代价：放进去的内容，此后每一步都要重新发送。与其把三万行日志全部贴进去再问它错在哪里，不如先由程序筛出报错前后的五十行再交给它。

从缓存读取便宜，写入缓存比读取贵得多，所以开头的说明要保持稳定；中途改动开头，改动处之后的缓存就会作废，需要重新写入。

还有两个因素会改变总的花费。派出去的帮手（宿主中的子智能体，见#chapref(<orchestrate>)）各有自己的上下文，也各自按请求计费，总用量要把它们加上。压缩把长对话换成短摘要，节省了费用，代价是细节只剩下转述。

== 该给它什么
只给决定这件事如何做的材料：当前的目标、所指的对象、所用的口径、已经完成的部分、尚未验证的部分、下一步要做的事。

给原件，少给转述。能指明路径的，就指明路径，请它自己去读。你用自己的话把一份文档复述一遍，它得到的只是你的理解，原文中你没有留意的内容，已经不在其中了。

大文件和长日志留在原处，让它带着问题去读。但有几类必须完整读过：要遵守的规则、要修改的正文、要核对的成品。文件的摘要能指明原件在哪里，读过摘要却不等于读过原件。

== 说明文件：每次都读的那一页
一次请求的五项内容中，项目的说明文件最值得下功夫。每次会话，宿主都会把它放进上下文，它是你与智能体之间最稳定的一份约定；写得不当，影响的也是每一次。

Codex 读取 `AGENTS.md`；Claude Code 读取 `CLAUDE.md`，目录里没有 `CLAUDE.md` 时读取 `AGENTS.md`。仓库里只放一份 `AGENTS.md`，两个宿主读到的就是同一份。除了仓库里的，两个宿主还各读一份用户级的说明文件，即 `~/.claude/CLAUDE.md` 和 `~/.codex/AGENTS.md`；你在任何目录中启动会话，相应的宿主都会读入自己的那一份。

各级目录中的说明文件读入哪几份，取决于在哪里启动，两个宿主的规则不同。Claude Code 从启动目录逐层向上读入，Git 仓库以外的上层目录也在内；Codex 从 Git 仓库的根目录读起，一直读到启动目录，仓库以外的上层目录不读（依据的试验见#chapref(<case-records>)，本章“上手”可以亲手重做）。所以，放在仓库以外上层目录中的约定，Codex 读不到：对所有仓库都成立的约定，应写进两个宿主各自的用户级说明文件；只属于一个仓库的，写进这个仓库根目录下的那一份，在仓库里任何一层启动，两个宿主都读得到。

练习包里就有一份，位于 `exercises/AGENTS.md`，约三十行。下面按它的四节，说明应当写些什么。

#matrix(columns: (0.9fr, 2.2fr), [*节*], [*写了什么*], [这里有什么], [`cases/` 每个案例一个目录，含输入、查询或代码，以及预期结果；`templates/` 是可以复制到实际任务中的卡片；`assessment/transfer-cases.zh.md` 是换了条件的同类问题], [智能体猜不到的约定], [时间一律用 UTC，未带时区的截止时刻视为错误；收益的单位是基点，零是一个值，空表示不知道，空值不补；“某一刻可用”指公布和入库都不晚于这一刻；范围外的证券归入“不在范围”，不算作缺失], [怎样检查], [用哪条命令检查，以及它应当打印的结果], [不要做什么], [不修改以 `expected-` 开头的文件和输入的 CSV 文件，要试其他条件，就把案例目录复制一份，在副本中修改；没有命令和输出，不报告“通过”])

第二节最为重要。这四条约定，从代码里看不出来：代码只显示它做了什么，显示不出应当怎样做。代码弄错其中一条，程序未必报错。#chapref(<agent>)那个导出函数漏掉了零收益的行，程序照常运行完毕，不报任何错误，要靠测试或核对导出的结果才能发现。这几条只能明确地写给它；写进说明文件，每次会话都会读到，就不必每次委托时重复一遍。

第三节指明检查用哪条命令，并写明它应当打印的结果：一行 `Ran … tests`，然后是 `OK`。测试的项数没有写进去：项数由测试文件决定，在说明文件里再写一遍，就多了一处可能过时的数字。第一节列出的三个路径，练习包自带的检查会逐一核对：它们写在说明文件里，也确实存在。写在说明文件里的事实，和别处的事实一样会过时；能交给程序核对的，就交给程序核对。

有三类内容不写。智能体读代码就能知道的，写进来只是重复，代码一改，说明就过时了。团队自己都不遵守的规矩，写进来，它可能照着做，反而与团队实际的做法相悖。从别处照搬的大段规定，每次会话都要读入，白白占用上下文，增加花费。写给智能体的操作规则放在说明文件里，不混进给人看的文档，两类读者要读的内容不同。

== 检索：先找到，再读
资料多到放不进上下文时，常用的办法是检索增强生成（RAG）：事先把材料切成小段、建立索引，再根据问题检索出最相关的几段，放进上下文，让模型据此作答。它增加的是材料，而不是模型的能力。

按关键词查找，适合确切的名称和代码；按意思查找，适合措辞与问题不同的内容，两种方式常常配合使用。按意思查找时，返回的每一段都带有一个相似度。相似度只用于排序，并不表示这段话有多大可能是正确的。

检索返回的也只是片段。如果只找到一行筛选条件，还须去读完整的函数和调用它的地方。资料不多时，直接读整个文件更简便，不必为了检索先搭建一套系统。

按意思查找代码，书中使用的是 semble。它是可选的（#chapref(<companion>)）：已安装的读者可以照着运行，未安装的读下面的输出即可。第一次运行时，它从网上下载一个把文字转换为向量的小型模型，再为给定的目录单独建立一个索引；模型和索引都存放在用户的缓存目录中，不写入仓库。

semble 还可以作为 MCP 服务运行（MCP 是接入工具的一种通行协议，#chapref(<tools>)用这种方式把它接入一个会话）。这样运行时，按它自己的说明，建过的索引在整个会话期间都由这个服务保留着。目录越大，索引越大，所以交给它检索的应当是一个仓库的根目录，而不是主目录或放着许多仓库的上层目录。

下一节的工具要在目录里写入文件，所以这一节和下一节都在练习包的一份副本里进行。复制之后，用一句英文按“删去收益为空的行”的意思搜索：

#pack-code(```sh
PACK=@PACK_PATH@
cp -R "$PACK/exercises" ~/search-practice && cd ~/search-practice
semble search "drop rows whose return is missing" cases \
  --top-k 3 --max-snippet-lines 6 --format text
```)

下面的输出有删节，第一条的正文已略去，后两条各只保留需要看的那一行：

```
historical-snapshot/session/query.sql:100-119
...
export-regression/export_fixed.py:1-2
    return [row for row in rows if row["return_bps"] is not None]
export-regression/export_bug.py:1-2
    return [row for row in rows if row["return_bps"]]
```

排在第一的是一份时点查询，其中有“no version available”这样的字眼，与所问的事只是略有关联。修复后的那份排第二，有错的那份排第三。检索把你引到相关内容附近，哪一份才是要找的，仍须自己阅读判断。

没有找到，也不等于不存在：索引可能没有收录要找的文件。semble 默认只检索代码。问“空值能不能补成零？”答案写在 `AGENTS.md` 里，默认检索却找不到它。下面这条命令检索整个副本（`.`），末尾的 `--content docs` 让它检索文档。去掉这一项，就是默认检索，排在前三的是两个 Python 文件和一份 SQL 查询，没有 `AGENTS.md`。输出有删节，只保留第一行：

```sh
semble search "may an empty return be filled with zero" . \
  --top-k 3 --max-snippet-lines 0 --format text --content docs
```

```
AGENTS.md:1-19
```

这一次，`AGENTS.md` 的前 19 行排在第一，“Never fill an empty cell”就在其中。检索的范围是查询的一部分：没有找到时，先查明检索覆盖了哪些文件。

== 结构：谁调用了它
按意思检索，找的是相似的片段，回答的是“哪里有相关的内容”。修改一个函数之前，要问的是另一类问题：谁调用了它？改了会波及哪里？回答这类问题要靠代码的结构：工具逐个解析文件，记下每个函数定义在哪里、调用了谁，连成一张图。书中使用的是 code-review-graph，它同样是可选的。在上一节的副本里建图：

```sh
code-review-graph build --repo .
```

它向标准错误输出若干行日志，向标准输出则只打印一行 `Full build: 16 files, 111 nodes, 165 edges (postprocess=full)`：解析了 16 个文件，图中有 111 个节点、165 条边。图存放在当前目录里新建的 `.code-review-graph/` 中。

问 `export_rows` 被谁调用。它输出的是 JSON，下面用 `jq` 取出其中几项，结果有删节，只保留第一行和末两行：

```sh
code-review-graph query callers_of export_rows --repo . |
  jq -r '.status, .summary, (.disambiguation[].qualified_name | split("/")[-1])'
```

```
ambiguous
export_bug.py::export_rows
export_fixed.py::export_rows
```

练习包里有两个同名的函数，有错的一份和修复后的一份。code-review-graph 不替你挑选其中一个，也不给出调用者，而是列出两个带文件名的限定名，请你指明是哪一个。换成限定名再问：

```sh
code-review-graph query callers_of export_bug.py::export_rows --repo . |
  jq -r '.status, (.results[] | [.name, .call_site.line, .target_resolution] | @tsv)'
```

```
ok
test_keeps_zero_and_negative_return	11	unresolved
test_empty_input	14	unresolved
```

图列出的两个调用者都是测试，调用发生在 `test_export.py` 的第 11 行和第 14 行。第三列的 `unresolved` 值得留意：测试文件第 5 行按环境变量 `EXPORT_MODULE` 决定导入哪个模块，这要到运行时才能确定，所以这两处调用的是哪一个 `export_rows`，图无从判断。结构图回答的是代码字面上写明的关系；凡是标为 `unresolved` 的地方，都要回到源代码读那一行。

== 上手
回到 `~/first-session`，写一份说明文件，四节各写一两行即可。下面这份可以照原样使用，用文本编辑器保存为这个目录中的 `AGENTS.md`；其中第一节“这里有什么”没有单独的小标题，就是总标题下的那一句：

```md
# Export function

One function, `export_rows`, and its contract test.

## Conventions you cannot guess
- `return_bps` is in basis points. Zero is a value; `None` means unknown.
- Keep zero, positive and negative returns. Drop only `None`. Never fill `None`.

## How to check
Run `EXPORT_MODULE=export python3 -B -m unittest -v test_export.py`.
Expected: a line `Ran … tests`, then `OK`.

## Do not
- Change `test_export.py` to make a test pass.
```

保存后提交（`git add AGENTS.md && git commit -q -m "docs: agent instructions"`），然后在这个目录里启动一个新会话（`claude --permission-mode default`），只问：“这个目录里，收益是空的行怎么处理？检查用哪条命令？”

它若答出你写的那两条，这些信息可能来自启动时读入的说明文件，也可能来自它这一次临时读过的文件，比如说明文件本身，或者修复后的代码和测试。要分清是哪一种，就输入 `/exit` 退出，重新运行#chapref(<first>)中取 `f` 的那一行，再用列出工具调用的那条 `jq` 查看。如果列表中没有任何一次读文件的调用，答案就来自启动时读入的说明文件。

再看说明文件按什么规则读入。建三层目录，各放一份写着标记词的 `AGENTS.md`，只把中间一层做成 Git 仓库，最后进入最里层：

```sh
mkdir -p ~/discover/repo/sub && cd ~/discover &&
  echo 'Code word for the outer directory: HERON.' > AGENTS.md &&
  echo 'Code word for this repository: OTTER.' > repo/AGENTS.md &&
  echo 'Code word for the sub directory: LYNX.' > repo/sub/AGENTS.md &&
  git -C repo init -q && cd repo/sub
```

在这里启动会话（`claude --permission-mode default`），只问：“Without reading any file or running any command, list every code word that appears in the instructions you were given at startup. If none, say NONE.”安装了 Codex 的，先用 `/exit` 退出 Claude Code，再在同一个目录里运行 `codex`，问同样的话。按上文“说明文件：每次都读的那一页”一节所说的读入规则，Claude Code 应答出三个标记词，Codex 应答出 `OTTER` 和 `LYNX` 两个。

最后看压缩。回到 `~/first-session`，再启动一次 Claude Code 会话（`claude --permission-mode default`）。先说一句说明文件里没有的话，比如“这次会话里，报告都用英文写”。运行 `/context`，看上下文由哪几部分占用；运行 `/compact` 之后，再运行一次 `/context`，看留下了什么。然后问它是否还记得两件事：说明文件中关于空值处理的那一条，以及你只说过一遍的那句话。退出之后，按#chapref(<first>, link: false)的办法重新取得 `f`，看压缩时记下了什么：

```sh
jq -r 'if .subtype == "compact_boundary"
  then .compactMetadata | "compact \(.trigger) \(.preTokens) -> \(.postTokens)"
  elif .attachment.type? == "instructions"
  then "instructions: " + (.attachment.files | map(.path | split("/")[-1]) | join(" "))
  else empty end' "$f"
```

下面是一次较长会话的记录中，手动压缩时记下的两行：

```
compact manual 829509 -> 42628
instructions: CLAUDE.md RTK.md AGENTS.md AGENTS.md MEMORY.md
```

其中 `compact` 那一行记的是压缩的方式和压缩前后的 token 数。紧随其后的 `instructions` 那一行，记下宿主重新附上了这次会话读入的说明文件。这一行列出哪些文件，取决于那台机器上有哪些说明文件；其中的 `RTK.md` 由#chapref(<tools>)介绍的 RTK 写入。

你的列表开头可能还有一行 `instructions`，那是会话开始时读入的。看 `compact` 之后的那一行里有没有 `AGENTS.md`：如果有，就表明这份说明文件已经重新附上，其中关于空值的那一条，压缩之后仍在它眼前。只说过一遍的那句话是否还在，要看摘要是否保留了它，像刚才那样问过才知道。
