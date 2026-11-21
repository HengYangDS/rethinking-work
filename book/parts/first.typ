#import "/publication/layout/style.typ": *
#import "/book/metadata.typ": *
#chapter("三 / 智能体", "10", "第一次会话", "在自己的机器上实际完成上一章的那几步：交出一件小事，观察智能体怎样做，再对照记录收回结果。")<first>
上一章那个导出函数漏掉了收益为零的行。这一章在自己的机器上，于一个单独的目录里修复它：写一份委托交出去；宿主停下来询问时，读清它要做什么再决定是否放行；最后对照测试和会话记录核对结果。后面各章讲到委托、权限和会话记录，都以这一次为起点。

需要准备的有：一个已经安装并登录的宿主、Git、Python、jq，以及随书的练习包。宿主的安装和登录，按其官方说明进行；使用哪个账号、接入哪个模型，以所在团队当前的安排为准。本章的命令以 Claude Code 为例；用 Codex 的读者，交出任务、查看差异、运行测试的步骤相同，只是启动方式、询问的时机和会话记录有所不同，见“换一个宿主：Codex”一节。

== 准备一个可以随意修改的目录
把#link(<agent>)[上一章]那个导出函数及其测试复制到一个新目录，并提交一次。第一行等号后面的路径，请换成压缩包解压后“实战练习”目录所在的路径：

```sh
PACK=~/Downloads/重新理解工作/实战练习
mkdir ~/first-session && cd ~/first-session &&
  cp "$PACK/exercises/cases/export-regression/export_bug.py" export.py &&
  cp "$PACK/exercises/cases/export-regression/test_export.py" . &&
  git init -q -b main && git add -A &&
  git commit -q -m "base: export drops zero returns"
```

复制到新目录、不直接在练习包里修改，是因为练习包自带的检查要求原件 `export_bug.py` 仍然漏掉零收益的行。先提交一次，是为了稍后能看清智能体改了什么，改错了也能恢复。

如果提交时报错，提示无法确定你的身份，先用 `git config --global user.name "你的名字"` 和 `git config --global user.email "你的邮箱"` 设置用户名和邮箱，再重新执行最后那条 `git commit`。这两条命令写入的是当前用户的全局设置，对没有单独设定的其他仓库同样生效。提交成功后，自己运行一遍测试，查看测试当前的结果：

```sh
EXPORT_MODULE=export python3 -B -m unittest -v test_export.py
```

测试默认导入名为 `export_bug` 的模块，即练习包里的原件 `export_bug.py`；这个目录里的文件已改名为 `export.py`，前面的 `EXPORT_MODULE=export` 让测试改为导入它。输出中关键的是以下几行，其中的耗时因机器而异：

```
test_empty_input (…) ... ok
test_keeps_zero_and_negative_return (…) ... FAIL
Ran 2 tests in 0.000s
FAILED (failures=1)
```

两项测试中一项失败。完整输出中，`AssertionError` 那一行并列着实际结果和期望结果：实际结果里少了收益为零的那一行。这是交出任务之前你亲眼看到的事实。

== 交出一件事
在这个目录里启动宿主：

```sh
claude --permission-mode default
```

启动时所在的目录，就是它的工作目录；它能读写哪些位置，另由权限设置决定，见#link(<boundaries>)[第十三章]。主目录中还没有 Claude Code 的配置时，也就是第一次使用它时，启动后先出现两个画面：一个请你选择与终端相配的显示主题（深色、浅色等），以后可以用 `/theme` 更改；另一个是安全提示，按回车继续。此后，第一次在一个目录里启动时，它会问你是否信任这个目录：提示以“Quick safety check: Is this a project you created or one you trust?”开头。这个目录是你刚建的，选择“Yes, I trust this folder”。别人交给你的目录，先看过其中的文件再决定：目录里的设置可以预先放行一些操作，也可以带有#link(<tools>)[第十二章]讲的钩子。这一选择记在 `~/.claude.json` 中，以后在这个目录里启动不再询问。

选项 `--permission-mode` 决定它何时停下来询问你，可选的几种称为档位。初次使用宜选 `default`，`--help` 中列出的 `manual` 是它的别名。在这一档下，读取文件，以及 `ls`、`cat`、`git status` 这类只读的命令，它直接执行；修改文件、运行其他命令之前，除非设置文件中已经放行，都先停下来询问。不写这个选项，启动时的档位未必是 `default`。按官方文档，自 Claude Code 2.1.283 起，在终端里交互启动、设置文件中又没有设定档位时，以 `auto` 档启动，由一个分类模型代替你判断放行与否，不再逐项询问。`auto` 档不可用时（例如所用的模型不支持），改为逐项询问。本书所用的 2.1.311，以 API 密钥登录时，启动后的档位正是 `auto`。因此，本书每次交互启动都在命令中写明档位。各档的区别见#link(<boundaries>)[第十三章]。

在会话里输入上一章那份委托，只是另外写明了文件名：

#note("委托", [export.py 里的导出函数漏掉了零收益的行，请找出原因并修好。约定是：零、正数、负数都保留，只排除空值。测试命令：`EXPORT_MODULE=export python3 -B -m unittest -v test_export.py`])

== 它停下来询问时
它停下来询问你，实际上是宿主在问，而不是模型在问。是否放行，由你决定；#link(<boundaries>)[第十三章]讲的边界，在这里第一次用到。

先读它要执行的操作：是哪条命令，修改哪个文件的哪一行。同意的选项不止一种。`Yes` 只同意这一次。其余以 `Yes, and` 开头的几项，同意之外各附带一项改变。询问命令时，其中一项多为 `Yes, and don't ask again for:` 后接命令中的一段：或者原样写出这一段，或者只写出它的开头，再加 `*`。询问本章的测试命令时，这一项是 `Yes, and don't ask again for: EXPORT_MODULE=export python3 *`。选了带 `*` 的一项，此后在这个目录里，凡以 `*` 之前那段文字开头的命令都不再询问。这一项也有别的写法：在#link(<boundaries>)[第十三章]的练习中，询问一条把输出追加进文件的命令时，它显示为 `Yes, and always allow access to <目录> from this project`。

询问修改文件时，这一项是 `Yes, and switch to accept edits`，本次会话余下的修改和常见的文件命令都不再询问；有的提示里还有一项 `Yes, and switch to auto mode`，把档位换成 `auto`。

这几项附带的改变，此后会在这个目录或本次会话中持续生效，所以本章一律只选 `Yes`。看不懂的不要同意：选以 `No` 开头的那一项，可以在对话中问它为什么要这样做，或者告诉它换一种做法。

它完成后会交回一段报告。先不要读，输入 `/exit` 退出会话；报告保存在会话记录里，稍后再读。

== 对照记录收回结果
先看事实，再看它的陈述。三项事实都可以由你自己查验。

一是它改了什么：

```sh
git diff
git status --short
```

第一条显示尚未暂存的内容改动；第二条列出所有有变化的文件，已暂存的和新增的也在其中。后面提交时用的 `git add -A` 会把第二条列出的文件全部纳入，所以其中每个文件的改动都要读过：第一条没有显示的，比如已暂存的改动或新文件，要单独打开查看。

这份委托的三次运行记在#link(<case-records>)[附录 D]中，每次差异都只有一行：筛选条件从把收益当作真假来判断，改为 `is not None`，只排除空值。你这一次若多出了别的改动或文件，每一处都要查明它为什么出现。差异只有一行，也要读懂那一行：#link(<boundaries>)[第十三章]所记的一次钩子试验中，同一个条件被改成了 `not in (None, "")`，空字符串也被排除了，而那份委托同样没有写空字符串算不算空值。遇到这样的差异，先把空字符串算不算空值写进约定，再按补充后的约定核对改动；现有的两项测试都不涉及空字符串，判断不了。

二是行为是否正确。自己再运行一遍刚才那条测试，这一次两项都应通过，末尾显示 `Ran 2 tests` 和 `OK`。

三是它在整个过程中做了什么。Claude Code 的会话文件放在 `~/.claude/projects/` 下，按启动目录分开存放。下面几段命令用 `jq` 从中提取字段，照原样输入即可。先列出它的每一次工具调用：

```sh
f=$(/bin/ls -t ~/.claude/projects/*first-session*/*.jsonl | head -1)
echo "$f"
jq -r 'select(.type=="assistant") | .message.content[]?
  | select(.type=="tool_use")
  | [.name, (.input.command // .input.file_path // .input.pattern // ""
     | tostring | .[0:64])] | @tsv' "$f"
```

代码第一行从目录名含 `first-session` 的会话文件中，取最近修改的一个，通常就是刚才那次会话；下面列出的工具调用若对不上刚才的委托，就是取错了文件。确认之后，请把 `echo` 打印出的路径记下来：后面几章还会在这个目录里开启新的会话，届时要靠它找回这一次。jq 打印的每一行是一次工具调用：先是工具的名称，再是它运行的命令、涉及的文件或搜索的词，后一项只取前 64 个字符。附录 D 中的一次运行，列出的是下面三行，文件路径有删节：

```
Bash	ls; cat export.py; cat test_export.py
Edit	/…/export.py
Bash	EXPORT_MODULE=export python3 -B -m unittest -v test_export.py
```

工具带回了什么，记在另一类记录里。下面这条命令每行打印一项结果，只取前 90 个字符，换行替换为空格：

```sh
jq -r 'select(.type=="user") | .message.content | arrays | .[]
  | select(.type=="tool_result") | .content
  | if type=="array" then map(.text? // "") | join(" ") else . end
  | .[0:90] | gsub("\n";" ")' "$f"
```

附录 D 中的同一次运行，这条命令打印的也是三行，依次是：目录中的文件名和函数的开头，文件已修改的确认，测试输出的开头。每行只是开头；要读完整的结果，须查看会话文件本身。

现在读它的报告。报告也在这个会话文件中，下面这条命令按先后提取它写的每一条文字：前面几条是它在过程中写的说明，最后一条才是交回的报告：

```sh
jq -r 'select(.type=="assistant") | .message.content[]?
  | select(.type=="text") | .text' "$f"
```

报告里说做过的每一件事、给出的每一个结果，都要在上面两份列表中找到依据：做过的事，看有没有那次调用；给出的结果，看工具带回了什么。“两个测试都通过了”，对应最后那一次测试运行；第二份列表看不到输出末尾的 `OK`，这一项以你自己刚才运行的测试为准。找不到依据的，比如报告说“其他调用方不受影响”，列表中却没有查找调用方的那一步，这一句就先记为未经核实。

确认改动可以接受之后提交，在提交说明中写明理由和排除的做法（这里是#link(<agent>)[上一章]第六条中那份委托提出的空值补零）；再给这次提交加一个名为 `fix` 的标签，后面几章还要用到它：

```sh
git add -A
git commit -q -m "fix: keep zero returns" \
  -m "Zero is a value (the price did not move); None means unknown.
Rejected: filling None with 0, which would hide missing data."
git tag fix
```

== 刚才发生了什么
对照上一章的那几步，看 jq 列出的工具调用中是否都有：读取文件、修改一行、运行测试。三层也都出现了：模型决定下一步做什么，宿主负责执行，需要时停下来询问你，工具带回了测试的输出。

本章的做法对应六个性质中的两个。一是第一条：零收益算不算一个值，是这件事的约定；测试命令要用本章为副本指定的模块名。这两项它都无从得知，所以由你写进委托。二是第五条：它的报告是续写，不是记录，所以你先看了差异和测试，再读它的陈述。

还有三件事由你亲手完成，因为核对智能体的事，不能交给智能体自己：交出任务之前，你先亲眼看到了那一项失败；宿主停下来询问时，你读懂之后才同意；收回结果时，你对照记录逐项核对。怎样限定它能触及什么，见#link(<boundaries>)[第十三章]；怎样交出任务、怎样收回结果，第四部各有一章。

== 换一个宿主：Codex
用 Codex 的读者，把“交出一件事”中的启动命令换成：

```sh
codex
```

第一次在一个目录里启动时，Codex 同样先问是否信任这个目录（Trust this folder?），并提醒目录里的设置可以不经模型请求就自动运行代码。你的选择会保存下来。

已经用 Claude Code 做完的读者，也可以用 Codex 再做一遍，两相对照。开始之前，`git status --short` 应当没有输出。先恢复有错的那一版：

```sh
git checkout fix~1 -- export.py
```

这条命令把旧版同时写进了暂存区，所以 Codex 做完之后，`git diff` 显示的正是它相对旧版的改动。核对之后，再恢复修复后的那一版：

```sh
git checkout fix -- export.py
```

Codex 若还改动或新增了别的文件，也要一并还原或删除，直到 `git status --short` 再无输出。

两个宿主询问的时机不同。Codex 把它能触及什么和何时询问人分成两项设置（见#link(<boundaries>)[第十三章]）。在信任的目录里，默认的 `workspace-write` 沙箱可以读取文件，可以在这个目录和临时目录（如 `/tmp`）中修改文件、运行命令，不能联网；不信任的目录是 `read-only`，只能读取。需要越出沙箱的命令，能否请你批准后在沙箱外执行，取决于审批设置。按默认设置，在这个目录里，它修改 `export.py`、运行测试都不会停下来问你；启动选项或设置文件另有设定的，以这次会话的设置为准。它交回之后，你用同样的 `git diff`、`git status --short` 和那条测试命令核对。两种做法怎样取舍，见#link(<boundaries>)[第十三章]。

Codex 的会话记录按日期存放在 `~/.codex/sessions/<年>/<月>/<日>/` 下，每次会话一个以 `rollout-` 开头的 `.jsonl` 文件，格式与 Claude Code 的不同。取最近的一次会话，先确认这次会话的工作目录，再列出工具调用、它写的文字和工具带回的结果：

```sh
f=$(/bin/ls -t ~/.codex/sessions/*/*/*/rollout-*.jsonl | head -1)
jq -r 'select(.type=="session_meta") | .payload.cwd' "$f"
jq -r 'select(.type=="response_item") | .payload
  | select(.type | test("call$"))
  | [.name, ((.input // .arguments // "") | tostring
     | .[0:64] | gsub("\n";" "))] | @tsv' "$f"
jq -r 'select(.type=="response_item") | .payload
  | select(.type=="message" and .role=="assistant") | .content[]
  | select(.type=="output_text") | .text' "$f"
jq -r 'select(.type=="response_item") | .payload
  | select(.type | test("call_output$"))
  | (.output | if type=="array" then map(.text? // "") | join(" ") else tostring end)
  | .[0:90] | gsub("\n";" ")' "$f"
```

第二条命令应当打印 `first-session` 所在的完整路径；若不是，就在 `~/.codex/sessions/` 下按刚才运行的日期找到对应的文件，把 `f` 换成它。同一个目录可能有几次会话，还要看列出的工具调用是否对得上刚才的委托。第三条打印的每一行是一次工具调用：工具的名称和参数的开头，名称和参数的写法随 Codex 的版本而变。第四条按先后提取它写的文字，最后一条就是报告。第五条每行打印一项工具带回的结果，只取前 90 个字符。对照报告的办法与上面相同。

== 接续会话与非交互运行
会话保存在磁盘上，之后可以接续。需要继续时，从下面三条中选用一条。Claude Code 用前两条：`--continue` 接续这个目录里最近的一次会话，`--resume` 从列表中选择一次会话。接续时同样要写明档位；不写，启动时的档位仍按上文的规则确定，可能是 `auto`。Codex 用第三条，它只在当前目录的会话中找最近的一次，加 `--all` 则不限目录：

```sh
claude --continue --permission-mode default
claude --resume --permission-mode default
codex resume --last
```

接续时，因为目录里有 `.py` 文件，Claude Code 可能询问是否安装一个语言服务器插件（LSP 插件，`pyright-lsp`），默认选中的是安装；本书的练习不需要它，选第二项（2.1.311 上写作 `No, not now`，2.1.329 上写作 `Not now`）。拒绝之后，它还可能再问。#link(<case-records>)[附录 D]记有按书中步骤运行的经过，其中一次，第十二章的练习做到中途，它又问了一次。

两个宿主都支持以非交互方式运行，把结果交给下一条命令，这是将智能体接入脚本和流水线的入口。下面两条各对应一个宿主。每运行一次都要消耗额度，一次运行中模型还可能被调用多次：

```sh
claude -p "列出这个目录里每个文件的用途，一行一个" --output-format json
codex exec "列出这个目录里每个文件的用途，一行一个" --json -o /tmp/codex-last.txt
```

第一条返回的 JSON 中，`total_cost_usd` 是宿主按标价估算的本次花费。这条命令没有写档位：用 `-p` 启动时，2.1.302 及以后的版本，只要设置文件中没有设定档位，就以 `default` 档启动（见#link(<boundaries>)[第十三章]）。`-p` 不会询问是否信任目录，所以只在自己信任的目录里使用。Codex 的 `exec` 对应 `-p`。`--json` 逐行打印事件，其中 `turn.completed` 一行记有消耗的 token 数，但不记花费。`-o` 把最后一条回复另存在 `/tmp` 下，练习目录里不会新增文件。

#matrix(columns: (1.2fr, 2fr), [*选项（Claude Code）*], [*作用*], [`-c`, `--continue` / `-r`, `--resume`], [接续会话：最近一次，或从列表中选择], [`-p`, `--print`], [以非交互方式运行，回答完毕即退出], [`--output-format text|json|stream-json`], [`text` 供人阅读；`json` 在运行结束时输出一份结果，供程序读取；`stream-json` 在运行过程中逐行输出过程记录，须同时加 `--verbose`])

其余选项列在#link(<quickref>)[附录 B]。
