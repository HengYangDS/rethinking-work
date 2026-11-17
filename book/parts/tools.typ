#import "/publication/layout/style.typ": *
#import "/book/metadata.typ": *
#chapter("三 / 智能体", "12", "工具：它够得着什么", "给它接上工具，它才动得了手。一样能力怎样接给它，接上以后怎样算接好了？")<tools>
刚开始用大模型时，常见的情形是：人打开网页，把公告复制下来贴给它，它作答，人再把回答贴进表格，然后去复制下一条。它每一条都答得很快，人却比原来更忙了。

这时用的只是一个会回答的模型。它够不着网页，也够不着表格，搬运只能由人来做。

真正碰到现实的是工具这一层。模型说的是说得通的话，工具带回的是实际碰到的结果，所以凡是算得出、查得到的，都交给工具。

== 四种接法
把一样能力接给智能体，今天常见的有四种办法。名字是眼下的叫法，过一两年也许会换，但各自管的事不大会变。

#matrix(columns: (0.8fr, 1.5fr, 1.3fr, 1.4fr), [*接法*], [*是什么*], [*适合*], [*怎样算接好了*], [命令行], [它直接运行已有的命令], [查询、测试、构建、版本管理], [从输入到输出完整走通一遍], [结构化工具], [按通行的协议（MCP）接进来，有名字、说明、参数和返回的格式], [要求参数严格、结果规整的查找和操作], [在实际用的那个宿主里看得到、调得动、读得回], [技能（Skill）], [一份写好的做法，连同脚本和参考材料，对口的任务来了才读进来], [反复做、步骤稳定的事], [一件平常的任务里，它确实被选中、读全、照着做了], [钩子（Hook）], [某件事发生时，由宿主固定执行的动作，不经过模型判断], [每一次都必须发生的事], [触发、失败、停用都试过])

这四种之外还有一种，让它像人一样看屏幕、点鼠标、敲键盘，去操作没有接口的界面。这种接法最通用，也最慢、最容易出错，只留给确实没有别的入口的地方。

多数时候，一条现成的命令加一份技能就够了。需要参数严格、结果规整时，再接结构化工具。每次都必须发生的事，比如改完文件跑一遍格式检查，交给钩子，不指望模型每次都想得起来。

== 一个工具长什么样
对模型来说，一个工具就是几行说明。

#matrix(columns: (0.6fr, 2.4fr), [*项目*], [*内容*], [名字], [查询快照], [说明], [按冻结时刻，返回研究范围内每只证券当时可用的值。只读。], [参数], [冻结时刻，要带时区；范围的名字], [返回], [每只证券一行：值，版本，没有值的原因], [出错时], [时刻没带时区：拒绝执行，并说明缺什么])

模型照着“说明”那一栏决定用不用、怎么用。说明写得含糊，它就去猜。写工具说明和#link(<delegate>)[第十五章]讲的写委托是同一种功夫：把对方猜不到的写出来。

一个 MCP 服务可以带几个工具，每个工具在模型眼里是什么样子，可以直接打印出来。mcporter 是查看和调试这类服务的工具，`mcporter list <服务名> --schema` 会把一个服务的工具按模型看到的样子列出来。下面看 semble 带的一个工具。semble 是一个代码搜索服务，#link(<context>)[第十一章]用过它的命令行：

```sh
mcporter list semble --schema --all-parameters
```

输出很长，下面只摘 `search` 这个工具的签名和其中三项，即两个参数的说明和必填清单。每项压成了一行，`title` 和 `minimum` 两个字段略去：

```
function search(query: string, repo: unknown, top_k?: number,
                max_snippet_lines?: unknown, content?: unknown): searchOutput;
  "query": { "description": "Natural language or code query.", "type": "string" },
  "top_k": { "default": 5, "description": "Number of results to return.", "type": "integer" },
  "required": [ "query", "repo" ]
```

这个工具自己的说明里写着：“搜一次，查询写函数名、类名或行为，不写报错信息；返回文件和行号，直接去那里，不要重复搜。”查一个服务时要带上它的名字。不带服务名的 `mcporter list` 会实际去连接配置里的每一个服务，而不只是读一下配置。

两个宿主也能各自列出自己接入的服务：

```sh
claude mcp list
codex mcp list --json
```

同一台机器上，两个宿主接入的服务未必相同。接入是按宿主做的，装好了，它未必看得见。

== 格式对了，不等于结果对了
参数的格式管的是“调得动”：证券代码是字符串，时间带着时区，收益是整数。

结果对不对是另一回事。零收益的行留不留，同一条记录取哪个版本，按公布算还是按入库算，这些是业务上的规定，格式检查看不出来，要靠#link(<verify>)[第十六章]讲的办法去核。

工具返回什么也有讲究。只回一句“成功”的工具，让人无从判断下一步。设想一次调用没有指明目标库，工具在默认位置建了一个空库，报告成功，而真正要用的那个库里什么也没有。好的返回会带上结果本身：写到了哪里，写了多少，哪些没有处理。

== 让它按格式交
结果要交给下一个程序时，请它按写明的格式交：哪几个字段，各是什么类型，哪些必填。宿主可以拿这个格式校验它的输出，不合格就退回重写。不过管住的仍然只是格式。

== 算得出来的，交给工具算
数行数、求和、按主键比对、筛出符合条件的记录，这些都有确定的答案，交给查询和程序去做。模型做它拿手的事：选哪些字段，怎样解释一处异常，提出几个可能的原因。

让它“看一眼，估个数”，是最常见的浪费，也是最常见的错。它只读了前几十行，就报出一个覆盖率，说得煞有介事。

常用的几样，各管一件事：

#matrix(columns: (1fr, 1fr, 1.8fr), [*要做的事*], [*工具*], [*命令的样子*], [找确切的文字], [ripgrep], [`rg -n 'return_bps' exercises/cases`], [按语法结构找代码], [ast-grep], [`ast-grep run --lang python --pattern 'row["return_bps"]' .`], [按意思找代码], [semble], [`semble search "…" <仓库> --top-k 3`], [比两个文件的结构], [difftastic], [`difft --display inline a.py b.py`], [算数、比数据], [DuckDB], [`duckdb -no-agent -markdown -f query.sql`], [比两版接口说明], [oasdiff], [`oasdiff breaking before.yaml after.yaml --format json --fail-on ERR`], [从 JSON 里选字段], [jq], [`jq '.[0] | {id, operation, path}'`], [验行为], [unittest], [`EXPORT_MODULE=export_bug python3 -B -m unittest -v test_export.py`])

按符号（函数名、类名这类名字）找定义和引用，靠的是语言服务器。Serena 把这项能力接成了结构化工具，智能体可以直接问“这个函数在哪里被调用”。

书里的 `duckdb` 一律带 `-no-agent`。DuckDB 发现自己被智能体调用时，会换一种专给智能体看的输出格式，带上这个开关，人和智能体看到的就是同一份输出。

有一处要留神。把带 `--fail-on ERR` 的 `oasdiff` 接到 `jq` 上，接口不兼容时，`oasdiff` 的退出码是 1，`jq` 是 0，整条管道报 0，看上去成功了。`$?` 只反映最后一条命令的退出码，前面哪一条失败，它不会说。要么查看每一段的退出码（zsh 里是 `$pipestatus`，bash 里是 `${PIPESTATUS[@]}`），要么先设 `set -o pipefail`，让管道中任何一段失败，整条都算失败。在这里，智能体和人一样会上当。

== 技能
技能是一个目录，里面有一份 `SKILL.md`，必要时再带 `references/` 和 `scripts/`。文件头只有两项：

```
---
name: evidence-auditor
description: Use when checking whether claims, closeout, tests, sources, or handoffs are backed by current evidence.
---
```

模型平时只看到名字和这一行描述，对口的任务来了才把正文读进来，`references/` 里的材料用到了才读，因此不相干的做法不占上下文。描述那一行决定它会不会被选中，正文决定选中之后管不管用。

技能多了，要有一处统一管。skills-manager 维护一个技能库，再按需部署给各个宿主。部署的是一个符号链接，不是拷贝：

```sh
skills-manager-cli skills list
/bin/ls -la ~/.claude/skills/decision-log
```

第一条列出每个技能部署给了哪些宿主，第二条查看其中一个。部署过这个技能的机器上，第二条的结果是这样：

```
lrwxr-xr-x  decision-log -> ~/.skills-manager/external/library-…/skills/decision-log
```

链接存在，只说明部署了。它在一件平常的任务里有没有被选中、读全、照着做，要拿一件任务来看。

== 钩子
钩子写在宿主的设置文件里。一条钩子交代三件事：什么事件，匹配哪个工具，跑什么命令，此外还可以加一个超时。

```json
"hooks": { "PreToolUse": [ { "matcher": "Bash",
    "hooks": [ { "type": "command", "command": "rtk hook claude" } ] } ] }
```

这一条的意思是，智能体每次要运行一条 shell 命令之前，先把命令交给 `rtk` 改写（rtk 是什么，下一节讲）。Codex 用的是同一种格式，文件在 `~/.codex/hooks.json`。常用的事件有会话开始、用户发话、工具调用前后、会话停止和压缩之后。

钩子可以靠退出码决定把什么交给模型。一条命令往外写文字有两个出口，标准输出和标准错误。在 Claude Code 里，工具调用之后的钩子若以 0 退出，它打印到标准输出的文字不交给模型；若以 2 退出，它写到标准错误的文字会交给模型。章末的上手会做一条。

== 两样管上下文的工具
大输出不该整个进对话。有两样工具专管这件事，一样靠钩子，一样靠 MCP。

上面那条钩子调用的就是 RTK：智能体每次要运行一条命令，钩子先把命令改写成 `rtk` 版本，输出经它压缩后再进对话。

```sh
rtk init --show
rtk rewrite "git log --oneline -20"
```

```
[ok] Hook: rtk hook claude (native binary command)
[ok] settings.json: RTK hooks configured (PreToolUse)
rtk git log --oneline -20
```

前两行是 `init --show` 报告钩子已经装好，最后一行是 `rewrite` 给出的改写结果。它压掉的是冗余：`git log -20` 的输出从 4652 字节压到 2340，`ls -la` 从 1730 压到 510，本已很紧凑的 `git log --oneline` 则一个字节也没少。`rtk gain` 给出累计的账。它少送了字节，却不防错，被压掉的若恰是决定行动的那一行，还得回去读原件。

context-mode 走的是另一条路。它是一个 MCP 服务，给智能体几个 `ctx_*` 工具，让它在大文件、大输出上先筛选、计数、求和，只把答案放进对话。它的说明里有一句话值得照做：超过二十来行的数据，凡是要数、要加、要筛、要找的，都用 `ctx_execute`，只打印答案。

没装这两样，也照样做得到：大输出先筛、先数，只把答案带进对话。

== 装好了，它未必看得见
工具装在机器上，和智能体用得上，中间还隔着一层接入。

常见的毛病有两种。一种是命令行里查得到结果，智能体那边却说没有这个工具；另一种是工具更新了，智能体那边拿着的还是旧的参数格式，调用一再失败。两种毛病都不出在工具本身，而出在宿主和工具之间的那条连接上。

所以检验接没接好，要在实际用的那个宿主里做。在别处试通了，说明不了这里通。排查时也要对症下药，只动出问题的那一条连接，不必把整套东西重装一遍。

== 什么时候该添一个工具
看人在哪里充当了接口：反复复制网页，反复找同一个文件，反复向它解释当前的环境，反复核对同一种输出。这些地方就该接一个工具。

接上的工具也有代价：要维护，上游改版了要跟着改，失败了要有人处理。每周都做的事，值得接；偶尔做一次的，手工更划算。

#note("一份接入说明写什么", [写这几样：什么时候用它，什么时候不用；输入是什么，输出是什么；出错的时候返回什么，是什么意思；它管到哪里，哪些情况它不处理。人读了能判断，智能体才有条件选对。])

== 上手
在#link(<first>)[第十章]建的那个 `first-session` 目录里，做几件事。

先列出你的宿主接入了哪些服务：`claude mcp list` 或 `codex mcp list`。新装的宿主多半一个也没有，这一件就到此为止。如果有，挑一个，在会话里问它“这个服务有哪些工具，各自的说明是怎么写的”；装了 mcporter 的，用 `mcporter list <服务名> --schema` 直接打印。读每个工具的说明，想一想如果换你来写，会补上哪一句。

用两条命令找同一样东西，一条按文字找，一条按结构找（所需的命令列在#link(<companion>)[附录 A]）：

```sh
rg -n 'return_bps' .
ast-grep run --lang python --pattern 'row["return_bps"]' .
```

在 `export.py` 里加一行注释，注释里写上 `row["return_bps"]`，两条命令各重跑一遍，看哪一条多出一处：`rg` 多出一处，`ast-grep` 不变。看完把这一行删掉。

再让一条管道骗你一次。`false` 是一条什么也不做、只以 1 退出的命令。运行 `false | cat; echo $?`，再运行 `set -o pipefail; false | cat; echo $?`，前一次是 0，后一次是 1。试完运行 `set +o pipefail` 关掉。

装一条钩子，再装一份技能。这两样在 `first-session` 的一份副本里做，因为后面几章还要用原来那个目录，那里不该有钩子和技能。钩子的设置和技能都在练习包里，拷进副本：

```sh
PACK=~/Downloads/重新理解工作-实战练习
A="$PACK/exercises/cases/export-regression/agent"
mkdir ~/tools-practice && cp -R ~/first-session/. ~/tools-practice/ &&
  cd ~/tools-practice &&
  mkdir -p .claude/hooks .claude/skills/check-export &&
  cp "$A/settings.json" .claude/settings.json &&
  cp "$A/SKILL.md" .claude/skills/check-export/SKILL.md
```

钩子是这一条：每次它用 `Edit` 或 `Write` 改完文件，跑一遍 `check.sh`。

```json
{ "hooks": { "PostToolUse": [ { "matcher": "Edit|Write",
    "hooks": [ { "type": "command",
      "command": "sh \"$CLAUDE_PROJECT_DIR\"/.claude/hooks/check.sh" } ] } ] } }
```

`check.sh` 要自己建，把下面整段贴进终端，就存成了这个文件。它跑那两项测试，往 `.claude/hook.log` 记一行；测试不通过时，把输出的末尾几行写到标准错误，并以 2 退出：

```sh
cat > .claude/hooks/check.sh <<'EOF'
#!/bin/sh
cd "$CLAUDE_PROJECT_DIR" || exit 0
out=$(EXPORT_MODULE=export python3 -B -m unittest test_export.py 2>&1)
code=$?
echo "$(date +%T) exit=$code" >>.claude/hook.log
[ "$code" -eq 0 ] && exit 0
echo "$out" | tail -5 >&2
exit 2
EOF
```

在副本里启动一个会话，命令同#link(<first>)[第十章]：`claude --permission-mode manual`。它每次要改文件，都会先停下来问；看清改的是 `export.py` 的哪一行，再答应只这一次。交给它：

#note("委托", [分两步做，都只用编辑文件的工具，不要自己去跑测试。第一步：给 export.py 里的 export_rows 加一行文档字符串，写明空值会被排除。第二步：把筛选条件临时改成 `if row["return_bps"]`，我要看一看改坏了会发生什么；看到之后把它改回去。最后告诉我：每一步改完之后，你各收到了什么反馈，这些反馈是从哪里来的。])

做完退出，打开 `.claude/hook.log` 看一眼：钩子每跑一次记一行，`exit=` 后面是测试的退出码。按#link(<case-records>)[附录 D]所列的条件运行一次，智能体改了三次文件，留下三行：

```
06:59:14 exit=0
06:59:19 exit=1
06:59:25 exit=0
```

第一次和第三次，它只收到一句平常的确认：文件已更新。第二次，它另外收到一条钩子的报错，里面是 `Ran 2 tests` 和 `FAILED (failures=1)`。它在报告里写明，这条反馈不是它自己跑出来的，也写明它不知道第一次和第三次钩子究竟跑没跑，因为通过的那两次，钩子什么也没有交给它。再用 `git diff` 看一眼，应当只多出那一行文档字符串；不想保留，就运行 `git checkout export.py`。

技能是下面这一份，把“检查一处改动”的做法写了下来：

```
---
name: check-export
description: Use when asked to check, verify or review a change to export.py in this directory.
---

# Check a change to the export function

1. Show the change: `git diff` for uncommitted work, `git show <commit> -- export.py` for a commit.
2. Run the contract test: `EXPORT_MODULE=export python3 -B -m unittest -v test_export.py`.
3. Read the changed lines against the conventions in `AGENTS.md`.
4. Report three parts, in this order:
   - Changed: file and line, old and new.
   - Test: the command, then how many tests ran, passed, failed and were skipped.
   - Not checked: what this check does not cover, such as other callers of `export_rows` and inputs the test has no case for.
```

在 `~/tools-practice` 里再启动一个会话（同上），只说一句：“检查一下 fix 这次提交对 export.py 的改动。”fix 是#link(<first>)[第十章]给修复的那次提交起的名字。做完退出，先取这一次会话的文件，再用第十章列工具调用的那条 `jq` 看第一行：

```sh
f=$(/bin/ls -t ~/.claude/projects/*tools-practice*/*.jsonl | head -1)
```

按同样的条件运行一次：那句话里没有提这份技能，智能体第一步调用的就是它，单子的第一行是 `Skill`；接着用一条命令看了那次提交，并跑了测试。交回的报告正是技能要的三段，测试那一段写的是跑了 2 个，通过 2 个，失败 0 个，跳过 0 个。

如果智能体没有调用这份技能，先看描述那一行，选不选中它，凭的就是这一行。
