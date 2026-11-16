#import "/publication/layout/style.typ": *
#import "/book/metadata.typ": *
#chapter("三 / 智能体", "12", "工具：它够得着什么", "给它接上工具，它才动得了手。一样能力怎样接给它，接上以后怎样算接好了？")<tools>
刚开始用智能体，常见的样子是这样的：人打开网页，把公告复制下来贴给它；它回答；人把回答贴进表格，再去复制下一条。它每一条都答得很快，人却比原来更忙了。

这时候智能体只有一张嘴，没有手。它够不着网页，够不着表格，于是由人来当它的手。

真正碰到现实的是工具这一层。模型说的是说得通的话，工具带回的是它实际碰到的结果；所以凡是算得出来、查得到的，交给工具。

== 四种接法
把一样能力接给智能体，今天常见的有四种办法。名字是眼下的叫法，过一两年可能换，各自管的事不大会变。

#matrix(columns: (0.8fr, 1.5fr, 1.3fr, 1.4fr), [*接法*], [*是什么*], [*适合*], [*怎样算接好了*], [命令行], [它直接运行已有的命令], [查询、测试、构建、版本管理], [从输入到输出完整走通一遍], [结构化工具], [按通行的协议（MCP）接进来，有名字、说明、参数和返回的格式], [要求参数严格、结果规整的查找和操作], [在实际用的那个宿主里看得到、调得动、读得回], [技能（Skill）], [一份写好的做法，连同脚本和参考材料，对口的任务来了才读进来], [反复做、步骤稳定的事], [一件平常的任务里，它确实被选中、读全、照着做了], [钩子（Hook）], [某件事发生时，由宿主固定执行的动作，不经过模型判断], [每一次都必须发生的事], [触发、失败、停用都试过])

这四种之外，还有一种：让它像人一样看屏幕、点鼠标、敲键盘，去操作一个没有接口的界面。开头那种替它复制网页的活，本来可以由它自己来。这种接法最通用，也最慢、最容易出错，留给确实没有别的入口的地方。

多数时候，一条现成的命令加一份做法说明就够了。要参数严格、结果规整，再接结构化的工具。每次都必须发生的事，比如改完文件跑一遍格式检查，交给钩子，不指望模型每次都想得起来。

== 一个工具长什么样
对模型来说，一个工具就是几行说明。

#matrix(columns: (0.6fr, 2.4fr), [*项目*], [*内容*], [名字], [查询快照], [说明], [按冻结时刻，返回研究范围内每只证券当时可用的值。只读。], [参数], [冻结时刻，要带时区；范围的名字], [返回], [每只证券一行：值，版本，没有值的原因], [出错时], [时刻没带时区：拒绝执行，并说明缺什么])

模型是照着“说明”那一栏来决定用不用、怎么用的。说明写得含糊，它就猜。写工具的说明，和#link(<delegate>)[第十五章]讲的写委托，是同一种功夫：把对方猜不到的写出来。

一个 MCP 服务在模型眼里是什么样，可以直接打印出来。我用 mcporter 查看和调试这类服务：`mcporter list <服务名> --schema` 把一个服务的工具按模型看到的样子列出来。下面是代码搜索服务 semble 的一个工具：

```sh
mcporter list semble --schema --all-parameters
```

输出很长。下面只摘 `search` 这个工具的签名和其中三项：两个参数的说明，和必填的清单。每项压成了一行，`title` 和 `minimum` 两个字段略去了：

```
function search(query: string, repo: unknown, top_k?: number,
                max_snippet_lines?: unknown, content?: unknown): searchOutput;
  "query": { "description": "Natural language or code query.", "type": "string" },
  "top_k": { "default": 5, "description": "Number of results to return.", "type": "integer" },
  "required": [ "query", "repo" ]
```

这个工具自己的说明里写着：“搜一次，查询写函数名、类名或行为，不写报错信息；返回文件和行号，直接去那里，不要重复搜。”模型决定用不用这个工具、怎么用，看的就是这几行。查一个服务，带上它的名字：不带服务名的 `mcporter list` 会把配置里的每一个服务都连一遍，不只是看一眼。

两个宿主各自也能列出自己接着的服务：

```sh
claude mcp list
codex mcp list --json
```

同一台机器，两个宿主接的服务不一样：接入是按宿主做的，装好了，它未必看得见。

== 格式对了，不等于结果对了
参数的格式管的是“调得动”：证券代码是字符串，时间带着时区，收益是整数。

结果对不对是另一回事。零收益的行留不留，同一条记录取哪个版本，按公布算还是按入库算，这些是业务上的规定，格式检查看不出来，得靠#link(<verify>)[第十六章]讲的办法去核。

工具返回什么也有讲究。只回一句“成功”的工具，让人没法判断下一步。设想一次调用没有指明目标库：工具在默认的位置建了一个空库，报告成功，而要用的那个库里什么也没有。好的返回会带上结果本身：写到了哪里，写了多少，哪些没处理。

== 让它按格式交
结果要交给下一个程序的时候，请它按一个写明的格式交：哪几个字段，各是什么类型，哪些必填。宿主可以拿这个格式去校验它的输出，不合就退回去重写。这样管住的仍然只是格式：字段齐了，值对不对，是另一回事。

== 算得出来的，交给工具算
数一数有多少行，求和，按键比对，筛出符合条件的记录，这些都有确定的答案，让查询和程序去做。模型做它拿手的：选哪些字段，怎样解释一处异常，提出几个可能的原因。

让它“看一眼，估个数”，是最常见的浪费，也是最常见的错。它只读了前几十行，就报出一个覆盖率，听着很像回事。

常用的几样，各管一件事：

#matrix(columns: (1fr, 1fr, 1.8fr), [*要做的事*], [*工具*], [*命令的样子*], [找确切的文字], [ripgrep], [`rg -n 'return_bps' exercises/cases`], [按语法结构找代码], [ast-grep], [`ast-grep run --lang python --pattern 'row["return_bps"]' .`], [按意思找代码], [semble], [`semble search "…" <仓库> --top-k 3`], [比两个文件的结构], [difftastic], [`difft --display inline a.py b.py`], [算数、比数据], [DuckDB], [`duckdb -no-agent -markdown -f query.sql`], [比两版接口说明], [oasdiff], [`oasdiff breaking before.yaml after.yaml --format json --fail-on ERR`], [从 JSON 里选字段], [jq], [`jq '.[0] | {id, operation, path}'`], [验行为], [unittest], [`EXPORT_MODULE=export_bug python3 -B -m unittest -v test_export.py`])

按符号找定义和引用，靠的是语言服务器；Serena 把这一样能力接成了结构化工具，智能体可以直接问“这个函数在哪里被调用”。书里的 `duckdb` 一律带 `-no-agent`：DuckDB 发现自己是被智能体调用的时候，会换一种专给智能体看的输出格式；带上这个开关，人和智能体看到的是同一份输出。

有一处要留神。把带着 `--fail-on ERR` 的 `oasdiff` 接到 `jq` 上：接口不兼容的时候，`oasdiff` 的退出码是 1，`jq` 是 0，整条管道报 0。`$?` 看到的只是最后一条命令的退出码，前面哪一条失败了，它不说。要看每一段的退出码（zsh 里是 `$pipestatus`，bash 里是 `${PIPESTATUS[@]}`），或者先设 `set -o pipefail`。智能体在这里和人一样会被骗。

== 技能
技能是一个目录，里面一份 `SKILL.md`，必要时带 `references/` 和 `scripts/`。文件头只有两项：

```
---
name: evidence-auditor
description: Use when checking whether claims, closeout, tests, sources, or handoffs are backed by current evidence.
---
```

模型平时只看到名字和这一行描述；对口的任务来了，才把正文读进来；`references/` 里的材料，用到了才读。Codex 自带的技能写作指南里就是这样分的：名字和描述“在挑技能的时候可见，要简洁、有区分度”，正文“适用时才加载”，附带材料“当前任务确实需要时才读或执行”。所以不相干的做法不占上下文；描述那一行决定它会不会被选中，正文决定它选中后管不管用。

我用 skills-manager 维护一个技能库，再按需要部署给各个宿主。部署是一个符号链接，不是拷贝：

```sh
skills-manager-cli skills list
/bin/ls -la ~/.claude/skills/decision-log
```

第一条列出每个技能部署给了哪些宿主。第二条看其中一个：

```
lrwxr-xr-x  decision-log -> ~/.skills-manager/external/library-…/skills/decision-log
```

链接存在，只说明部署了。它有没有在一件平常的任务里被选中、读全、照着做，要用一件任务去看。

== 钩子
钩子写在宿主的设置文件里。一条钩子说三件事：什么事件，匹配哪个工具，跑什么命令；还可以加一个超时。

```json
"hooks": { "PreToolUse": [ { "matcher": "Bash",
    "hooks": [ { "type": "command", "command": "rtk hook claude" } ] } ] }
```

这一条的意思是：每次智能体要运行一条 shell 命令之前，先把命令交给 `rtk` 改写。Codex 用的是同一个格式，文件在 `~/.codex/hooks.json`。常用的事件：会话开始、用户发话、工具调用前后、会话停止、压缩之后。

钩子可以靠退出码回话。在 Claude Code 里，工具调用之后的钩子以 0 退出，它打印的普通文字不交给模型；以 2 退出，它写到标准错误的内容会交给模型。章末的上手做一条。

== 两样管上下文的工具
大输出不该整个进对话。有两样工具专门管这件事，一样靠钩子，一样靠 MCP。

RTK 就装在上面那条钩子里：智能体每要运行一条命令，钩子先把命令改写成 `rtk` 版本，输出经它压缩后再进对话。

```sh
rtk init --show
rtk rewrite "git log --oneline -20"
```

```
[ok] Hook: rtk hook claude (native binary command)
[ok] settings.json: RTK hooks configured (PreToolUse)
rtk git log --oneline -20
```

前两行是 `init --show` 报告钩子已经装好，最后一行是 `rewrite` 给出的改写结果。它压的是冗余：`git log -20` 的输出从 4652 字节压到 2340，`ls -la` 从 1730 压到 510，已经很紧的 `git log --oneline` 一个字节也不少。`rtk gain` 给出累计的账。它减少的是搬运，不减少错误：被压掉的如果正是决定行动的那一行，还得回去读原件。

context-mode 走另一条路：它是一个 MCP 服务，给智能体几个 `ctx_*` 工具，让智能体在大文件、大输出上先做筛选、计数、求和，只把答案放进对话。我把它接在 Codex 上，开放四个工具：`ctx_execute`、`ctx_batch`、`ctx_index`、`ctx_search`。它的说明里写着一句话，值得照做：超过二十来行的数据，凡是要数、要加、要筛、要找的，用 `ctx_execute`，只打印答案。

没装这两样，这句话照样做得了：大输出先筛、先数，只把答案带进对话。

== 装好了，它未必看得见
工具装在机器上，和智能体用得上，中间还隔着一层接入。

常见的有两种：命令行里查得到结果，智能体那边却说没有这个工具；工具更新了，智能体那边拿着的还是旧的参数格式，调用一直失败。两种的问题都不在工具本身，在宿主和工具之间那条连接。

所以验收要在实际用的那个宿主里做。在别处试通了，说明不了这里通。排查的时候，也只动出问题的那一条连接，不必把整套东西重装一遍。

== 什么时候该添一个工具
看人在哪里当接口：反复复制网页，反复找同一个文件，反复向它解释当前的环境，反复核对同一种输出。这些地方，就是该接一个工具的地方。

接口也有代价：要维护，上游改版了要跟着改，失败了要有人处理。每周都做的事，值得接；偶尔做一次的，手工更划算。

#note("一份接入说明写什么", [写这几样：什么时候用它，什么时候不用；输入是什么，输出是什么；出错的时候返回什么，是什么意思；它管到哪里，哪些情况它不处理。人读了能判断，智能体才有条件选对。])

== 上手
在#link(<first>)[第十章]建的那个 `first-session` 目录里，做几件事。

列出你的宿主接着哪些服务：`claude mcp list` 或 `codex mcp list`。新装的宿主多半一个也没有，这一件就做到这里。有的话，挑一个，在会话里问它“这个服务有哪些工具，各自的说明是怎么写的”；装了 mcporter 的，用 `mcporter list <服务名> --schema` 直接打印。读说明那一栏，想一想换成你来写，会补上哪一句。

用两种办法找同一样东西，一条按文字找，一条按结构找：

```sh
rg -n 'return_bps' .
ast-grep run --lang python --pattern 'row["return_bps"]' .
```

在 `export.py` 里加一行注释，注释里写上 `row["return_bps"]`，两条命令各重跑一遍，看哪一条多出一处。看完把这一行删掉。

让一条管道骗你一次：运行 `false | cat; echo $?`，再运行 `set -o pipefail; false | cat; echo $?`。前一次是 0，后一次是 1。试完运行 `set +o pipefail` 关掉。

装一条钩子，再装一份技能。这两样在 `first-session` 的一份副本里做：后面几章还要用原来那个目录，不带它们。钩子的设置和技能在练习包里，拷进副本：

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

`check.sh` 自己建，下面整段贴进终端，就存成了这个文件。它跑那两项测试，往 `.claude/hook.log` 记一行；测试不过，把输出的末尾几行写到标准错误，以 2 退出：

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

在副本里另起一个会话，交给它：

#note("交给它的话", [分两步做，都只用编辑文件的工具，不要自己去跑测试。第一步：给 export.py 里的 export_rows 加一行文档字符串，写明空值会被排除。第二步：把筛选条件临时改成 `if row["return_bps"]`，我要看一看改坏了会发生什么；看到之后把它改回去。最后告诉我：每一步改完之后，你各收到了什么反馈，这些反馈是从哪里来的。])

我这样跑过一次。它改了三次文件，`.claude/hook.log` 里是三行，`exit=` 后面是测试的退出码：

```
06:59:14 exit=0
06:59:19 exit=1
06:59:25 exit=0
```

头一次和第三次，它只收到平常的一句文件已更新的确认。第二次，它另收到一条钩子的报错，里面是 `Ran 2 tests` 和 `FAILED (failures=1)`。它在报告里写明这条反馈不是它跑出来的，也写明它不知道头一次和第三次钩子到底跑没跑：通过的那两次，什么也没有交给它。做完用 `git diff` 看一眼，只该多出那一行文档字符串；不想留，`git checkout export.py`。

技能是这一份，把“检查一处改动”的做法写下来：

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

另起一个会话，只说一句：“检查一下 fix 这次提交对 export.py 的改动。”我这样跑过一次：没有人提这份技能，智能体头一步调的就是它；接着一条命令里看了那次提交，跑了测试；交回的报告是技能要的三段，测试那一段写的是跑了 2 个，通过 2 个，失败 0 个，跳过 0 个。先取这一次会话的文件，再用#link(<first>)[第十章]列工具调用的那条 `jq` 看，我那一次头一行是 `Skill`：

```sh
f=$(/bin/ls -t ~/.claude/projects/*tools-practice*/*.jsonl | head -1)
```

它要是没有调，先看描述那一行：它决定这份技能会不会被选中。
