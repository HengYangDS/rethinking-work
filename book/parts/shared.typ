#import "/publication/layout/style.typ": *
#chapter("共用的环境", "五个人各自配置自己的智能体，同一条约定，有人写成了测试，有人没有写下来。怎样让一个团队的智能体读到同一份约定？")<shared>
设想一个五人的数据团队，每人都用 Claude Code 和 Codex，各自配置宿主：说明文件、技能、接入的 MCP 服务，都是本人在工作中陆续加上去的。“空值不补零”这条约定，有两个人写成了测试，放进了自己的仓库；另外三个人记得这条约定，却没有写在任何地方。

同样一句“空值补成零吧”，在前两个人的环境里，智能体指出这样做与测试中的约定相抵触，没有照办；在后三个人的环境里，它照办了。五个人用的是同样的宿主和模型，智能体的处理却分成了两种。

#link(<standing>)[上一章]说，智能体做得好不好，很大程度上取决于环境。那一章讲的环境，主要在团队共用的仓库里。开头那条约定，却有人只写进了个人的仓库，有人只记在头脑里。环境还有另一半在每个人的机器上，由各人自行配置，没有人看得全。这一章讲怎样让一条约定只存一份，送到每个人的机器上，成为团队共用的环境。

== 机器上的那一半
每次会话，智能体用到的不只是仓库里的内容。宿主还会读入说明文件、规则和技能，运行钩子，接入 MCP 服务，#chapref(<context>)和#chapref(<tools>)分别讲过。项目的说明文件随代码提交；其余的大多放在 `~/.claude/`、`~/.codex/` 这样的个人目录里，不经过任何评审。

过去，个人的工具配置近于个人习惯，编辑器选什么配色，与旁人无关。如今这些文件决定智能体知道哪些约定、运行哪些检查、能调用哪些工具；和代码一样，它们左右着交出去的是什么。每人各有一套配置，团队就同时运行着几套环境。

共用的环境要做到四点。

只有一个来源。约定写在一处，全组从这里取，否则就会出现开头那样的情形。

改动经过评审。一条规则会进入每个人的智能体会话，写错了，错的是全组的工作。所以它和代码一样，要经过评审、合并，才分发出去；怎样评审，#chapref(<review>)讲过。

送到每个人的机器上。规则只放在存放团队环境的仓库里，智能体读不到；送到之后，还要经由各宿主读取规则的途径进入会话。

查得出哪台机器上的副本落后了。智能体的表现反常时，先要能回答：它读到的是哪一版？

== 一个仓库，一套命令
TeamAI 是一个开源工具（MIT 许可证），做的正是这几件事：团队的环境放在一个 Git 仓库里，下文称团队仓库；每个成员在自己的机器上运行一次 `teamai init`，此后用 `pull` 取回，用 `push` 交回，用 `status` 核对，做法见本章“上手”。承担同一职能的工具还有 Magpie 的共享库等，列在#chapref(<toolmap>)。

第一次运行 `init`，它在团队仓库的 `main` 分支上建好目录结构，规则放在 `rules/`，技能放在 `skills/`；`teamai status` 列出的还有 MCP 服务、钩子、环境变量等十几类资源，本章只演示规则和技能。

运行 `init` 和第一次 `pull`，改动的不止工作目录。两个宿主的用户级设置里安装了会话钩子，Codex 的钩子记为已信任；工作目录里登记了 Git 钩子，放入了 TeamAI 自带的技能；`~/.zshenv` 等三个 shell 启动文件的末尾各追加了一段配置。团队的技能和规则由会话开始时的钩子或 `teamai pull` 同步。

卸载时先运行 `teamai hooks remove`，再运行 `teamai uninstall --force`，次序反了会留下 Codex 的钩子；`~/.teamai/` 目录和 `~/.codex/config.toml` 中的信任记录要另行删除。

== 一条规则怎样到达宿主
设想维护团队仓库的人在 `rules/` 里加了一条规则，写着“零是一个值，空表示不知道，空值不补零”等几项，又在 `skills/` 里加了一个技能，经评审后一并合并进 `main`。成员运行 `teamai pull` 之后，技能复制进了工作目录的 `.claude/skills/` 和 `.codex/skills/`，两个宿主各一份；规则复制进了 `.claude/rules/`。

两个宿主读规则的途径不同。Claude Code 自己把项目里的 `.claude/rules/*.md` 当作说明文件读入；会话开始时，TeamAI 的钩子对它什么也不返回。Codex 不读这个目录，规则由会话开始时的钩子交给它：钩子返回一段 JSON，其中 `additionalContext` 一项以 `Team rules (from teamai):` 一行开头，其后是规则的全文，Codex 把它加进会话开头的上下文。

送到机器上的是文件。文件到了，不等于规则的内容进了会话；是否读入，要在实际使用的宿主里检验，方法同#chapref(<context>)的“上手”：就规则里写着的一件事向它提问，再查这次会话的记录。读入之后是否照着做，也要在这个宿主里检验：#chapref(<agent>)那几次让它没有照办的，是目录里的测试连同委托里的测试命令；单靠写在规则里的一条约定能否起同样的作用，那几次运行没有试过。

== 改动先进分支
一位成员自己写了一个技能 `freeze-asof`，想让全组都用上，就用 `teamai push --skill` 推送它的目录 `.claude/skills/freeze-asof`。技能不直接进 `main`，而是推到一个新分支 `teamai/push/<用户名>/<时间>`。初始化时 `--provider` 选的是 `git`（见本章“上手”中的 `init` 命令），即普通的 Git 仓库，所以 `push` 不发起合并请求，以退出码 1 结束，分支却已推送；按帮助说明，选 GitLab、GitHub 等平台时，它会发起合并请求。

合并之前，这个技能只在作者的工作目录和待评审的分支上，其他成员运行 `pull` 取不到它。评审人读过分支上的 `SKILL.md`，再合并进 `main`；成员们下一次 `pull` 或开始会话时，它就送到了每个人的机器上，两个宿主各有一份。#link(<standing>)[上一章]说，个人的空间留作试验，试验成功了，再迁到按事情划分的地方；在这里，迁过去就是一次经过评审的合并。

== 副本不是第二个原件
TeamAI 用的是副本：同一条规则，每台机器上各有一份。它先把团队仓库克隆到每位成员本机的 `~/.teamai/` 下，再把其中的技能复制到各宿主读取的目录，规则复制到 Claude Code 读取的目录；这些目录里放的是复制来的文件，不是符号链接。#chapref(<tools>)的 skills-manager 则用符号链接把技能部署到宿主，链接指向同一台机器上的技能库。

用副本，前提是分清原件和副本：团队仓库是原件，各宿主读取的都是由它派生的副本，和#link(<standing>)[上一章]说的报表、索引、缓存一样，不应悄悄顶替原件；改了副本，要提交回原件。

`pull` 把送来的文件列进工作目录的 `.git/info/exclude`；这些文件尚未被 Git 跟踪时，`git status` 不再列出它们，也就不容易有人误把它们当作项目文件提交，让项目仓库里多出一个原件。

副本改了，`teamai status` 会列出一处尚未交回的本地改动。若团队这时又改了同一条规则，`pull` 不会覆盖这份副本，而是给出两种办法：把团队的改动合进自己的副本，用 `push` 交回评审；或者删掉副本，用 `pull --force` 取团队的版本。

副本改了而不交回，后果不止于这一台机器与团队不一致。同一台机器上，Claude Code 读的是改过的文件；Codex 从钩子拿到的仍是团队的版本。一个人的两个宿主，读到的已是两种约定。

规则有错，无论在团队仓库里改，还是改过本机的副本后用 `push` 交回，都要经过评审、合并，再发到每个人那里。智能体表现反常时，先运行一次 `teamai status`，看本机的副本是不是当前的版本；智能体实际读入了什么，仍要查会话的记录。

== 报告分支记的是什么
TeamAI 在团队仓库里另有一个报告分支 `teamai-reports`，不放环境本身，放成员的登记和统计。会话中的钩子记下几项计数，写进这个分支上各人名下的文件，比如 `stats/Exp-User.yaml`。记的是会话数，以及人打断智能体、拒绝工具调用、纠正它的次数；后三项是人介入的次数。加了一条规则之后纠正少了，可以当作线索，不能当作证明；这类数字能说明什么，#link(<improve>)[下一章]再讲。

== 上手
TeamAI 以 npm 包 `teamai-cli` 发布，安装见#chapref(<companion>)。下面的练习不需要真实的团队，也不连接任何代码托管平台：用一个临时目录充当 `HOME`，用本机的一个裸仓库（不带工作目录）充当团队仓库。`init` 和 `pull` 写进 `HOME` 的钩子和配置，连同下面几条 `git config --global` 的设置，都落在临时目录里；只要没有用环境变量另行指定宿主或 Git 的配置位置，你自己的设置就不受影响。另开一个终端窗口，在其中运行：

```sh
S=$(mktemp -d)
mkdir -p $S/home $S/remote
export HOME=$S/home
git config --global user.name "Exp User"
git config --global user.email exp@example.invalid
git config --global init.defaultBranch main
git init --bare -q $S/remote/agent-env.git
git config --global url."$S/remote/".insteadOf https://git.example.invalid/team/
```

最后一行需要解释。`teamai init` 不接受本地路径或 `file://` 地址，会报告 `Invalid Git repo URL`；Git 的 `url.<前缀>.insteadOf` 在连接之前把这个 `https://` 地址改写为本机裸仓库的路径。`.invalid` 是专为无效地址保留的顶级域名，即使改写没有生效，也连不到任何主机。建一个工作目录，用这个地址初始化，输出中应有一行 `✔ teamai initialized successfully!`：

```sh
mkdir $S/ws && cd $S/ws && git init -q
teamai init https://git.example.invalid/team/agent-env.git --provider git --agent claude,codex
```

先扮演维护团队仓库的人，另克隆一份，加一条规则并推送；回到工作目录，核对，取回，再核对：

```sh
git clone -q https://git.example.invalid/team/agent-env.git $S/admin
cd $S/admin
cat > rules/data-conventions.md <<'EOF'
# Data conventions

- Zero is a value; null means unknown. Never fill null with zero.
- Every timestamp carries a time zone.
EOF
git add rules && git commit -q -m "Add data conventions rule" && git push -q
cd $S/ws
teamai status
teamai pull
teamai status
git status --short
```

第一次 `status` 报告 `behind: 1 commit(s)`、`rules: 0`；`pull` 之后，`status` 的 `behind` 一行变为 `up to date`，`rules` 变为 `1`。规则此时在 `.claude/rules/data-conventions.md`，`git status --short` 却什么也不输出。

再看改了副本会怎样。在本机的副本里给这条规则加一行，再核对：

```sh
echo '- Fill null with zero when a report needs a number.' >> .claude/rules/data-conventions.md
teamai status
```

输出的最后两行报告一处本地改动，这里的 `new` 指尚未交回：

```
ℹ Local resources not yet pushed:
  [rules] 1 new
```

维护团队仓库的人这时也改了这条规则，你再取回：

```sh
cd $S/admin
echo '- A result that cannot be recomputed from its query is not a result.' \
  >> rules/data-conventions.md
git commit -q -a -m "Rule: results must be recomputable" && git push -q
cd $S/ws && teamai pull
```

这一次，`pull` 保留了你的副本，并给出提示（有删节）：

```
⚠ [workspace] Kept …/ws/.claude/rules/data-conventions.md: you changed it, and the version teamai would deploy there (rules/data-conventions.md) has changed since. Merge that change into your copy and share it with `teamai push`, or delete your copy and run `teamai pull --force` to take that version.
```

按提示中的第二种办法，删掉副本，取团队的版本：

```sh
rm .claude/rules/data-conventions.md
teamai pull --force
cat .claude/rules/data-conventions.md
```

打印出的文件里，你加的那一行不在了，团队新加的那一行出现了。做完后删除临时目录，再关掉这个终端窗口，因为它的 `HOME` 已经改过：

```sh
cd / && rm -rf "$S"
```

#closing[
团队定下的约定，写进一个仓库，经过评审送到每个人的机器上；每台机器上的副本都与原件核对一致，会话的记录里也看得到宿主读入了这条约定。做到这几点，五个人的智能体读到的才是同一条约定。
]
