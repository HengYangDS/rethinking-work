#import "/publication/layout/style.typ": *
#import "/book/metadata.typ": *
#chapter("三 / 智能体", "12", "工具：它够得着什么", "接上工具，它才能动手。怎样让它具备一种能力，又怎样确认这种能力已可正常使用？")<tools>
刚开始使用大模型时，常见的情形是：人打开网页，把公告复制下来贴给它，它作答，人再把回答贴进表格，然后去复制下一条。它每一条都答得很快，人却比原来更忙了。

这时用的只是一个会回答问题的模型。它接触不到网页，也接触不到表格，搬运只能由人来做。

真正接触现实的是工具这一层。模型给出的是说得通的话，工具带回的是实际操作的结果，所以凡是算得出、查得到的，都应交给工具。

== 四种接法
为智能体提供一种能力，目前常见的有四种办法。名称是当下的叫法，一两年后也许会变，但各自负责的事不大会变。

#matrix(columns: (0.8fr, 1.5fr, 1.3fr, 1.4fr), [*接法*], [*是什么*], [*适合*], [*怎样算接好*], [命令行], [它直接运行已有的命令], [查询、测试、构建、版本管理], [从输入到输出完整运行一遍], [结构化工具], [按通行的协议（MCP）接入，带有名称、说明、参数和返回的格式], [要求参数严格、结果规整的查找和操作], [在实际使用的宿主中，能够找到工具、完成调用并读取返回结果], [技能（Skill）], [一份写好的做法，连同脚本和参考材料，遇到对口的任务才读入], [反复进行、步骤稳定的事], [在一项日常任务中，智能体确实选中了这份技能，完整读过，并按其中的做法执行], [钩子（Hook）], [某件事发生时，由宿主固定执行的动作，不经过模型判断], [每一次都必须发生的事], [触发、失败、停用都已试过])

这四种之外还有一种：让它像人一样看屏幕、点鼠标、敲键盘，去操作没有接口的界面。这种接法最通用，但也最慢、最容易出错，只用于确实没有其他入口的场合。

多数时候，一条现成的命令加一份技能就够了。需要参数严格、结果规整时，再接入结构化工具。每次都必须发生的事，比如改完文件运行一遍格式检查，交给钩子，不指望模型每次都能想起。

== 一个工具由什么构成
对模型来说，一个工具就是几行说明。

#matrix(columns: (0.6fr, 2.4fr), [*项目*], [*内容*], [名字], [查询快照], [说明], [按冻结时刻，返回研究范围内每只证券当时可用的值。只读。], [参数], [冻结时刻，要带时区；范围的名字], [返回], [每只证券一行：值，版本，没有值的原因], [出错时], [时刻未带时区：拒绝执行，并说明缺少什么])

模型依据“说明”那一栏决定是否使用、如何使用。说明写得含糊，它就只能去猜。写工具说明与#link(<delegate>)[第十五章]讲的写委托是同一种功夫：把对方猜不到的写出来。

一个 MCP 服务可以提供多个工具，每个工具在模型眼中是什么样子，可以直接打印出来。mcporter 是查看和调试这类服务的工具，`mcporter list <服务名> --schema` 会按模型看到的样子列出一个服务的工具。下面看 semble 提供的一个工具。semble 是一个代码搜索服务，#link(<context>)[第十一章]用过它的命令行：

```sh
mcporter list semble --schema --all-parameters
```

输出很长，下面只摘录 `search` 这个工具的签名和其中三项，即两个参数的说明和必填清单。每项压缩为一行，略去了 `title` 和 `minimum` 两个字段：

```
function search(query: string, repo: unknown, top_k?: number,
                max_snippet_lines?: unknown, content?: unknown): searchOutput;
  "query": { "description": "Natural language or code query.", "type": "string" },
  "top_k": { "default": 5, "description": "Number of results to return.", "type": "integer" },
  "required": [ "query", "repo" ]
```

这个工具自己的说明里写着：“搜一次，查询写函数名、类名或行为，不写报错信息；返回文件和行号，直接去那里，不要重复搜。”查看一个服务时要带上它的名称。不带服务名的 `mcporter list` 会实际连接配置中的每一个服务，而不只是读取配置。

两个宿主也能各自列出自己接入的服务：

```sh
claude mcp list
codex mcp list --json
```

同一台机器上，两个宿主接入的服务未必相同。接入是按宿主分别进行的；服务装好了，宿主未必看得见。

== 格式对了，不等于结果对了
参数的格式保证的是“调得动”：证券代码是字符串，时间带有时区，收益是整数。

结果是否正确则是另一回事。零收益的行是否保留，同一条记录取哪个版本，按公布时间算还是按入库时间算，这些是业务规定，格式检查发现不了，要靠#link(<verify>)[第十六章]讲的办法去核验。

工具返回什么也有讲究。只回复一句“成功”的工具，让人无从判断下一步。设想一次调用没有指明目标库，工具在默认位置建了一个空库并报告成功，而真正要用的那个库里什么也没有。好的返回会附上结果本身：写到了哪里，写了多少，哪些没有处理。

== 让它按格式交付
结果要交给下一个程序时，请它按写明的格式交付：包含哪几个字段，各是什么类型，哪些必填。宿主可以用这个格式校验它的输出，不合格就退回重写。不过，这样约束的仍然只是格式。

== 算得出来的，交给工具算
统计行数、求和、按主键比对、筛出符合条件的记录，这些都有确定的答案，应交给查询和程序去做。模型做它擅长的事：选择哪些字段，怎样解释一处异常，提出几种可能的原因。

让它“看一眼，估个数”，是最常见的浪费，也是最常见的错误。它只读了前几十行，就报出一个覆盖率，而且说得煞有介事。

常用的几种工具如下，每种只负责一类事：

#matrix(columns: (1fr, 1fr, 1.8fr), [*要做的事*], [*工具*], [*命令示例*], [查找确切的文字], [ripgrep], [`rg -n 'return_bps' exercises/cases`], [按语法结构查找代码], [ast-grep], [`ast-grep run --lang python --pattern 'row["return_bps"]' .`], [按语义查找代码], [semble], [`semble search "…" <仓库> --top-k 3`], [比较两个文件的结构], [difftastic], [`difft --display inline a.py b.py`], [计算和比对数据], [DuckDB], [`duckdb -no-agent -markdown -f query.sql`], [比较两版接口说明], [oasdiff], [`oasdiff breaking before.yaml after.yaml --format json --fail-on ERR`], [从 JSON 中选取字段], [jq], [`jq '.[0] | {id, operation, path}'`], [验证行为], [unittest], [`EXPORT_MODULE=export_bug python3 -B -m unittest -v test_export.py`])

按符号（函数名、类名这类名称）查找定义和引用，依靠的是语言服务器。Serena 通过结构化工具提供这项能力，智能体可以直接查询“这个函数在哪里被调用”。

书中的 `duckdb` 命令一律带 `-no-agent`。DuckDB 检测到自己被智能体调用时，会改用一种专为智能体设计的输出格式；加上这个开关，人和智能体看到的就是同一份输出。

有一处需要留意。把带 `--fail-on ERR` 的 `oasdiff` 接到 `jq` 上，接口不兼容时，`oasdiff` 的退出码是 1，`jq` 是 0，整条管道返回 0，看上去成功了。`$?` 只反映最后一条命令的退出码，前面哪一条失败，它不会显示。可以查看每一段的退出码（zsh 中是 `$pipestatus`，bash 中是 `${PIPESTATUS[@]}`），也可以先设置 `set -o pipefail`，使管道中任何一段失败，整条都算失败。在这一点上，智能体和人一样容易被误导。

== 技能
技能是一个目录，其中有一份 `SKILL.md`，必要时再附 `references/` 和 `scripts/`。文件头只有两项：

```
---
name: evidence-auditor
description: Use when checking whether claims, closeout, tests, sources, or handoffs are backed by current evidence.
---
```

模型平时只看到名称和这一行描述，遇到对口的任务才读入正文，`references/` 里的材料用到时才读，因此不相关的做法不占用上下文。描述那一行决定它会不会被选中，正文决定选中之后是否有用。

技能多了，需要一处统一管理。skills-manager 维护一个技能库，再按需部署给各个宿主。部署的是一个符号链接，而不是副本：

```sh
skills-manager-cli skills list
/bin/ls -la ~/.claude/skills/decision-log
```

第一条列出每个技能部署给了哪些宿主，第二条查看其中一个。在部署过这个技能的机器上，第二条的结果如下：

```
lrwxr-xr-x  decision-log -> ~/.skills-manager/external/library-…/skills/decision-log
```

链接存在，只说明已经部署。它在一项日常任务中是否被选中、完整读过、按其中的做法执行，要用一项实际任务来检验。

== 钩子
钩子写在宿主的设置文件中。一条钩子说明三件事：什么事件，匹配哪个工具，运行什么命令；此外还可以设定一个超时。

```json
"hooks": { "PreToolUse": [ { "matcher": "Bash",
    "hooks": [ { "type": "command", "command": "rtk hook claude" } ] } ] }
```

这一条的意思是：智能体每次运行一条 shell 命令之前，先把命令交给 `rtk` 改写（rtk 是什么，下一节讲）。Codex 使用同一种格式，文件位于 `~/.codex/hooks.json`。常用的事件有会话开始、用户发言、工具调用前后、会话停止和压缩之后。

钩子可以通过退出码决定把什么交给模型。一条命令输出文字有两个出口：标准输出和标准错误。在 Claude Code 中，工具调用之后的钩子若以 0 退出，它打印到标准输出的文字不交给模型；若以 2 退出，它写到标准错误的文字会交给模型。章末的“上手”会实际配置一条。

== 两种管理上下文的工具
大量输出不应整个进入对话。有两种工具专门处理这件事，一种借助钩子，一种借助 MCP。

上面那条钩子调用的就是 RTK：智能体每次要运行一条命令，钩子先把命令改写成 `rtk` 版本，输出经它压缩后再进入对话。

```sh
rtk init --show
rtk rewrite "git log --oneline -20"
```

```
[ok] Hook: rtk hook claude (native binary command)
[ok] settings.json: RTK hooks configured (PreToolUse)
rtk git log --oneline -20
```

前两行是 `init --show` 报告钩子已经装好，最后一行是 `rewrite` 给出的改写结果。它压缩掉的是冗余：`git log -20` 的输出从 4652 字节减到 2340，`ls -la` 从 1730 减到 510，本已十分紧凑的 `git log --oneline` 则一个字节也没有减少。`rtk gain` 给出累计的统计。它减少了送入的字节，却不能防止错误；被压缩掉的若恰好是决定行动的那一行，还须回去读原件。

context-mode 采用另一种思路。它是一个 MCP 服务，为智能体提供几个 `ctx_*` 工具，让它在大文件、大输出上先筛选、计数、求和，只把答案放进对话。它的说明中有一句话值得照做：超过约二十行的数据，凡是需要计数、求和、筛选、查找的，都用 `ctx_execute`，只打印答案。

没有安装这两种工具，也同样可以做到：对大量输出先筛选、先计数，只把答案带进对话。

== 装好了，它未必看得见
从工具装在机器上，到智能体能够使用它，中间还隔着一层接入。

常见的问题有两种。一种是在命令行中能查到结果，智能体那边却说没有这个工具；另一种是工具已经更新，智能体那边持有的仍是旧的参数格式，调用一再失败。两种问题都不在工具本身，而在宿主与工具之间的那条连接上。

所以检验是否接好，要在实际使用的那个宿主里进行。在别处试通了，不能说明这里也通。排查时也要对症下药，只处理出问题的那一条连接，不必把整套系统重装一遍。

== 何时该增加一个工具
看人在哪里充当了接口：反复复制网页，反复查找同一个文件，反复向它解释当前的环境，反复核对同一种输出。这些地方就应接入一个工具。

接入的工具也有代价：需要维护，上游改版时要随之修改，失败时要有人处理。每周都做的事，值得接入；偶尔做一次的，手工处理更划算。

#note("一份接入说明写什么", [写以下几项：什么时候用它，什么时候不用；输入是什么，输出是什么；出错时返回什么，代表什么意思；它的职责范围到哪里，哪些情况它不处理。人读了能够判断，智能体才有条件选对。])

== 上手
在#link(<first>)[第十章]建立的 `first-session` 目录里，完成以下几件事。

先列出你的宿主接入了哪些服务：`claude mcp list` 或 `codex mcp list`。新安装的宿主往往一个服务也没有，这一项就到此为止。如果有，选一个，在会话中问它“这个服务有哪些工具，各自的说明是怎么写的”；安装了 mcporter 的，用 `mcporter list <服务名> --schema` 直接打印。读每个工具的说明，想一想如果由你来写，会补充哪一句。

用两条命令查找同一处代码，一条按文字查找，一条按结构查找（所需的命令列在#link(<companion>)[附录 A]）：

```sh
rg -n 'return_bps' .
ast-grep run --lang python --pattern 'row["return_bps"]' .
```

在 `export.py` 中加一行注释，注释里写上 `row["return_bps"]`，两条命令各重新运行一遍，看哪一条多出一处：`rg` 多出一处，`ast-grep` 不变。看完后删掉这一行。

再看一次管道怎样掩盖失败。`false` 是一条什么也不做、只以 1 退出的命令。运行 `false | cat; echo $?`，再运行 `set -o pipefail; false | cat; echo $?`：前一次输出 0，后一次输出 1。试完后运行 `set +o pipefail` 将其关闭。

安装一条钩子，再安装一份技能。这两项在 `first-session` 的一份副本里进行，因为后面几章还要使用原来的目录，那里不应有钩子和技能。钩子的设置和技能都在练习包中，复制到副本里：

```sh
PACK=~/Downloads/重新理解工作-实战练习
A="$PACK/exercises/cases/export-regression/agent"
mkdir ~/tools-practice && cp -R ~/first-session/. ~/tools-practice/ &&
  cd ~/tools-practice &&
  mkdir -p .claude/hooks .claude/skills/check-export &&
  cp "$A/settings.json" .claude/settings.json &&
  cp "$A/SKILL.md" .claude/skills/check-export/SKILL.md
```

钩子是下面这一条：它每次用 `Edit` 或 `Write` 改完文件，运行一遍 `check.sh`。

```json
{ "hooks": { "PostToolUse": [ { "matcher": "Edit|Write",
    "hooks": [ { "type": "command",
      "command": "sh \"$CLAUDE_PROJECT_DIR\"/.claude/hooks/check.sh" } ] } ] } }
```

`check.sh` 需要自己创建：把下面整段粘贴进终端，就会保存为这个文件。它运行那两项测试，在 `.claude/hook.log` 中记一行；测试不通过时，把输出的末尾几行写到标准错误，并以 2 退出：

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

在副本里启动一个会话，命令同#link(<first>)[第十章]：`claude --permission-mode manual`。它每次要修改文件，都会先停下来询问；看清改的是 `export.py` 的哪一行，再选择“只这一次”。交给它下面这份委托：

#note("委托", [分两步做，都只用编辑文件的工具，不要自己去跑测试。第一步：给 export.py 里的 export_rows 加一行文档字符串，写明空值会被排除。第二步：把筛选条件临时改成 `if row["return_bps"]`，我要看一看改坏了会发生什么；看到之后把它改回去。最后告诉我：每一步改完之后，你各收到了什么反馈，这些反馈是从哪里来的。])

完成后退出，打开 `.claude/hook.log` 查看：钩子每运行一次记一行，`exit=` 后面是测试的退出码。按#link(<case-records>)[附录 D]所列的条件运行一次，智能体修改了三次文件，留下三行：

```
06:59:14 exit=0
06:59:19 exit=1
06:59:25 exit=0
```

第一次和第三次，它只收到一句普通的确认：文件已更新。第二次，它另外收到一条钩子的报错，其中包含 `Ran 2 tests` 和 `FAILED (failures=1)`。它在报告中写明，这条反馈不是它自己运行测试得到的，也写明它不知道第一次和第三次钩子究竟是否运行过，因为通过的那两次，钩子什么也没有交给它。再用 `git diff` 查看，应当只多出那一行文档字符串；不想保留，就运行 `git checkout export.py`。

技能是下面这一份，写下了“检查一处改动”的做法：

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

在 `~/tools-practice` 里再启动一个会话（命令同上），只说一句：“检查一下 fix 这次提交对 export.py 的改动。”fix 是#link(<first>)[第十章]给修复的那次提交起的名字。完成后退出，先取得这一次会话的文件，再用第十章列出工具调用的那条 `jq` 查看第一行：

```sh
f=$(/bin/ls -t ~/.claude/projects/*tools-practice*/*.jsonl | head -1)
```

按同样的条件运行一次，结果如下：那句话里没有提到这份技能，智能体第一步调用的却正是它，列表的第一行是 `Skill`；接着它用一条命令查看了那次提交，并运行了测试。交回的报告正是技能要求的三段，测试那一段写的是运行 2 项，通过 2 项，失败 0 项，跳过 0 项。

如果智能体没有调用这份技能，先检查描述那一行：是否选中它，依据的正是这一行。
