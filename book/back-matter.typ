#import "/publication/style.typ": *
#import "/book/metadata.typ": *
#chapter("附录", "A", "案例环境与适用范围", "理解一项经验，先看它在哪些条件下成立。以下记录有明确日期，不是一套人人需要复制的工具清单。")<case-environment>
#small[以下采用 2026-11-07 05:44 UTC 的只读快照，范围包括 13 组软件管理与状态命令、/Applications 下 87 个顶层应用包，以及 25 个命令入口。Homebrew 清单有 457 行；npm 全局根包 13 个、pnpm 根包 1 个、UV 工具 25 个、Mise 工具身份 34 个、MAS 清单 21 行。这些统计范围有重叠，不能相加。此前的 97 项 App 盘点范围更宽，不能据两次计数之差断言移除了 10 个软件。I2 保存本次范围，I1 保留前次快照。]

#text(size: 8.8pt)[
#matrix([*层*], [*记录中的代表对象*], [*这份记录说明什么*], [主 Agent 与 App], [Codex、Claude、Cursor、JetBrains、Hermes、Qoder、WorkBuddy、Trae], [安装与入口信息；各项使用记录范围不同，不作统一推荐], [Homebrew 工具], [DuckDB 2.0.0_1、Typst 0.15.1、Quarto 1.11.9、JupyterLab 4.6.5、uv 0.13.7], [已读取当时的版本和入口；未验证全部项目环境与功能], [npm 全局包], [Hindsight 插件 0.8.6、Agent Desktop 1.2.0、Context Mode 2.1.5、TeamAI 0.29.0、OMX 0.21.46], [包的信息；独立运行环境与实际客户端仍须分别核验], [pnpm], [Paperclip 2026.1023.0], [已安装；候选包及安装根目录的资格检查仍有拒绝未解决], [UV 工具], [Semble 0.7.2、Serena 2.1.0、CRG 2.3.9、RepoWise 0.60.1、Hindsight 1.2.0、Semantica 0.7.0], [独立工具环境；不等于 RepoWise 容器环境], [其余 UV 工具], [Agent Reach、MarkItDown、Browser Use、Phoenix、Inspect、SQLMesh、MLX 工具、OpenEvolve], [已盘点工具根版本；使用结果限于具体样例], [Mise], [2026.11.3，Python/Node/npm 等多版本], [保留当时人为锁定的版本；项目所选版本不等于全部已安装版本], [其他包管理工具], [pipx、Cargo、Bun global、Pixi global], [本次所查清单为空；不代表没有相关项目], [其他 App], [Obsidian、Notion、Office、Blender、IINA、Raycast、Setapp、Ollama], [App 信息与已有使用记录；不推及账号、插件和内嵌运行环境], [虚拟机与容器], [3 台 CI 虚拟机；OrbStack、容器与服务], [当时的虚拟机运行信息；不证明项目作业与恢复已通过验收])
]

#takeaway("这个案例的证明范围", [当时的状态列表记录三台 CI 虚拟机在运行，另有一台 Rosetta 虚拟机已被人删除，不在恢复范围。列表只说明那个时刻的状态，不证明所有项目都已完成同一源码提交的 CI 验收。读者设计自己的流程，仍须确认源码、执行节点、权限和恢复责任。])

#small[未完成事项也照实保留：OMC 与 OpenRewrite 仅作源码研究，Qwen 对比暂停；新的编排方案、企业数据与身份权限接入、独立 RSI 试验和未通过验收的恢复，不能写成完成。Airflow、Dagster 等章节讨论的是适用场景与选择，不表示这些方案均已安装。]

#heading(level: 2, outlined: true)[从案例事实到采用判断]
安装清单回答“有什么”，实战记录回答“在什么条件下做过什么”；是否值得采用，还要结合团队的工作判断。编写本册时，71 项明确请求分别对应章节或采用条件，38 份来源记录及其引用关系经过逐项复核。这样做是为了减少遗漏与失真，不是要求团队照搬一份采购清单。确认原件存在、字节一致，只能证明出处得到保留，不能证明其中的工具今天都已配置妥当、能够使用或值得采用 \[#case("I2") / #case("R1")\]。

#matrix([*事实层*], [*记录支持什么*], [*仍不能说什么*], [原生安装元数据], [在本次选区中有包、App或入口], [所有功能、账号、插件都已正常], [完整实战记录], [指定对象曾走通指定输入到结果], [每个用户、平台或数据都适用], [采用建议], [按任务、代价与维护选择最小组合], [已测团队收益或行业最佳], [未知与保留], [哪些边界缺证、由谁继续判断], [没有读到就等于不存在])

=== 没有进入默认组合的对象
先保留条件，再决定采用。GitNexus 的已读版本有非商业许可条件，不能直接推广为公司标准；muse.ai GUI 与 Muse Code 不是同一产品，mac-computer-use 的精确来源仍需确认。它们不因名称相近获得安装或使用结论。

Prime Agent、Muse Code、Qoder、WorkBuddy、Trae 与 Grok/OpenRouter 等入口的账号、供应商和完整任务接受各有缺口；不应强制同事再添一个主 Agent。OMP/OMX 的自然方法采用、热更新与独立评测也不由版本命令决定。

Lume、Cua Bench、Cua-S1 和 Obscura 只在明确桌面环境或专项评测需求出现时考虑；不为演示创建另一套虚拟化或专用模型。Tencent Agent Memory 保留研究与成品资格边界；Tavily 的原提取记录有配额拒绝；这些条件不能被一段流畅介绍抹去。

Jev/Laya、Clef/Clef-flash 的有限离线试验未支持自主维护推广；Qwen 对比仍按人的暂停决定保留。Temporal、Argo、DolphinDB、Milvus、SeaTunnel 和湖仓类方案，应由实际负载、组织身份、数据权利与恢复来决定，不由已有工具的数量决定。OpenUI/OpenShip、Vercel 生态按既有产品需要选择，不新建全局控制面。

#takeaway("把未知放在正确位置", [仍未完成全部项目环境、嵌套或未注册 App、虚拟机软件与服务镜像的完整依赖盘点；没有证明所有软件配置和实际使用。写作可先交付已证实经验，但应把未证实边界留在采用条件里，不把有限记录写成完整环境认证。])

#chapter("附录", "B", "案例出处与限制", "每项结论都限定到实际记录的对象。来源编号连接正文与以下说明；精确路径、完整原件和校验记录由原证据拥有者保留，不随源仓库或练习包分享。")<case-records>
#small[以下是案例范围说明，不是公开原始日志。未随书提供的材料不能被视为读者已核验的证据；可独立练习的合成输入见#link(<companion>)[附录 C]。]

== 本册的编辑与试验范围
编写工作包括写作、原生只读盘点与公开合成样例；原版、完整源和必要证据由原证据库保留。写作不包含软件安装，也不改变服务、账号、模型、项目锁或人工版本约束。作者自审和逐页检查与独立外部评审、实际教学反馈分别记录。

#block[
#set text(size: 9pt)
#set par(first-line-indent: 0pt, leading: 5.5pt, spacing: 9pt)
#metadata((case: "S1"))<case-S1> *S1* Quarto：2026-11-07，原生发布的精确执行边界、完整正文与视觉验收，不是所有出版环境证明。

#metadata((case: "S2"))<case-S2> *S2* Hermes：2026-11-06，原会话选定Skills完整读取与RepoWise连接；完整工具执行与一般运行中恢复未接受。

#metadata((case: "S3"))<case-S3> #metadata((case: "S4"))<case-S4> *S3–S4* Orca/Multica：2026-11-06至07，原包/CLI与选定原配置档运行环境恢复；online不代替各供应商真实任务。

#metadata((case: "S5"))<case-S5> *S5* TeamAI：2026-11-06，原生NotInitialized；本地CLI样例与实际团队代码托管平台流程分开。

#metadata((case: "S6"))<case-S6> #metadata((case: "S15"))<case-S15> *S6/S15* Semble/CRG：2026-11-03及07，原UV安装、查询、保留图与停机恢复；大图/warm/watch等未知保留。

#metadata((case: "S7"))<case-S7> *S7* RepoWise：2026-11-07，原CJK全文仍有完整源码契约缺口；不能从元数据推全库刷新。

#metadata((case: "S8"))<case-S8> *S8* Understand Anything：2026-11-05，公开小样例图、搜索与打开源码；未证明全应用理解或产品优越。

#metadata((case: "S9"))<case-S9> #metadata((case: "S10"))<case-S10> #metadata((case: "S11"))<case-S11> *S9–S11* Agent Reach、MarkItDown、Agent Desktop：公开读取、完整转换、TextEdit保存/重开各有精确样例，平台全量、视觉语义与焦点限制未外推。

#metadata((case: "S12"))<case-S12> #metadata((case: "L3"))<case-L3> *S12/L3* Mise：2026-11-06至07，完整配置与实际锁旁文件消费差异、修复与既有门禁；两份完整门禁直读、一份负责人报告；人为锁定版本保留。

#metadata((case: "S13"))<case-S13> *S13* Paperclip：2026-11-07，官方新候选完整依赖组合合格不等于当前pnpm 安装根目录的资格检查通过；不以自建包装层绕过。

#metadata((case: "S14"))<case-S14> *S14* OMC/OpenRewrite：2026-11-06，仅源码研究，不执行或宣传已采用。

#metadata((case: "H1"))<case-H1> #metadata((case: "H2"))<case-H2> *H1/H2* Hindsight：2026-11-07 记录中的diagnose/sync/search/完整Skill与reflect终端失败；2026-11-05前端完整知识页读取和Markdown导出。当前memory页仍可失真，完整数据库恢复不推导。

#metadata((case: "K1"))<case-K1> #metadata((case: "K2"))<case-K2> *K1/K2* Semantica/Obsidian：2026-11-06当前文档版次存在/完整DOM但可见布局受限；2026-11-03原vault完整读取。一般源撤下/恢复不接受。

#metadata((case: "Q1"))<case-Q1> *Q1* Semgrep：2026-11-07，公开Python/Go离线规则样例、安装与精确旧版退休；无法完整识别的核心与已批准依赖限制保留。

#metadata((case: "I1"))<case-I1> #metadata((case: "E1"))<case-E1> *I1/E1* 编写期间的原生安装清单与完全合成对账/红绿tests：仅该metadata/合同，未接企业数据、账号或服务。

== 历史事件的来源角色
#metadata((case: "L1"))<case-L1> *L1* 整机范围被缩小到Brew、#metadata((case: "L2"))<case-L2> *L2* AgentDesktop script warning、#metadata((case: "L4"))<case-L4> *L4* SQLite temp路径、#metadata((case: "L5"))<case-L5> *L5* Gateway拓扑、#metadata((case: "L6"))<case-L6> *L6* Runner389 前提条件、#metadata((case: "L7"))<case-L7> *L7* 恢复包保存位置与保管记录缺失，来自案例中的人类请求与批准、源代码及原始操作记录。转述时保持人类决定、操作者报告和直接观察的区别。

材料丢失只说明当前不能定位，不证明全球没有副本；恢复材料不能重造冒充。人的授权能允许具体动作，不能让未执行或未接受的结果变真。版本、安装根目录与来源选择都以日期与对象限定。

== 支撑教学方法的实践材料
#metadata((case: "G1"))<case-G1> *G1* 部门工作指南，源版 `27bab1ee93792e9be5e67b80e7fb1c66718ef527`：业务/数据建模、实现、技术与产品责任；共享发行主体标识变更；基于真实决策的成员培养。它是规范性指导；标识案例明确为说明性案例，不是事故记录，亦不证明部门已全面采用或测得教学收益。

#metadata((case: "G2"))<case-G2> *G2* 同一源版的数据指南：“revised market history”说明性案例。保留首次可用未知与明确晚于模拟决策的区别，历史研究、生产供数与使用接受分别判断。正文对话与变式为据此编写的教学材料，不是逐字实录或实测回测。

#metadata((case: "G3"))<case-G3> *G3* Alphasim 源版 `07651c4196be11770eb8b4103e2484b15fcbd85c` 的 `docs/doc/alpha.md`：教程要求按信号时点实际可见信息计算，说明 delay、日频动态复权和日内原始价格。本文引用源文档约束，未由此验收完整实现、研究数据或任何策略收益。

#metadata((case: "R2"))<case-R2> *R2* 2026-10-08 招聘材料仓库的原 CI 配置、Linux 失败与后续成功记录、终端 closeout 及同 SHA 托管校验回执。最终源版为 `6256682af3311029d72dcd6f93bc66e4b44593a7`；作业内独立锁定格式器、保留已接受基础镜像。回执为历史操作证据，不是当前远端状态核验。对方案的比较与会话指导是教学解释；不外推候选题目发布、招聘效果、依赖完全安全或企业微信云端送达。

#metadata((case: "N1"))<case-N1> *N1* 2026-11-07 完整 19 项原生命令帮助与 Orca 版本匹配指南：语法、lease/HITL、终端 handle 与字段语义；帮助读取不等于流程已实际采用。

#metadata((case: "N2"))<case-N2> *N2* 2026-11-07 实际 jq/yq/fd/rg 入口及公开教学选择结果：确认小工具的身份和有限表达式，不宣称全部已安装 Brew 软件都得到有效使用。

#metadata((case: "D1"))<case-D1> *D1* 2026-10-11至12 ECB 公共快照原生 dlt/DuckDB/SQLMesh/Dagster：完整值、计算截止时点、审计拒绝、重放和取消效果；历史环境，不是当前最新版、企业 IAM 或投资证明。

#metadata((case: "V1"))<case-V1> *V1* Inspect 原 accepted-native-probe.py：固定 mock READY、完整 eval-log 重开；仅测试框架记录链，不是模型效能。

#metadata((case: "O1"))<case-O1> *O1* Office 原读写/出版接受的非秘密元数据：五表、215 非空格与坐标/跨度、13 页和保留原源；不读取或共享其业务内容。

#metadata((case: "M1"))<case-M1> *M1* 2026-11-04 原Multica任务LOCA-26：三份完整限定材料、原生完整comment、八项资产条件映射、原任务终态及保留/收尾。原完整task和memo从既有archive直读；备忘录建议不是企业数据实现或接受。

#metadata((case: "B1"))<case-B1> *B1* 2026-11-07 原Browser Use自建公开页面：中文输入、保存、重载完整正文和图像；无账号/模型，原stop命令exit 0未接受，精确进程与临时对象退出已核对。

#metadata((case: "L8"))<case-L8> *L8* 2026-11-07 原MLX-Audio兼容依赖升级：WAV解码、resample/mel与字段结构使用及旧代码恢复；tokenizer seam不是模型推理或TTS合成，本文不推出声音接受。

#metadata((case: "P1"))<case-P1> *P1* 案例执行时适用的 AGENTS 共享规则：整体终态、有界批次、约每小时安全检查点、原进度拥有者、证据和精确收尾。本文把它提炼为教学建议，不替其他团队创建新政策或定时任务。

#metadata((case: "X1"))<case-X1> *X1* 2026-11-07 原 ast-grep/oasdiff 的合成样例验收：一条精确AST匹配；删除路径被拒绝、未改spec控制通过。#metadata((case: "N3"))<case-N3> *N3* 2026-11-07 十项完整原生 help 核对语法；Context7月配额拒绝保留，没有重试、换key或扩大权限。help不是所有工具功能验收。

#metadata((case: "X2"))<case-X2> *X2* 2026-11-09 随册量化数据部门合成练习的原生执行：旧 Python 一项业务断言失败、控制通过，新版两项通过；完整 AST 匹配一处，字节范围 58–75；删除 `GET /research-snapshot` 被拒绝，未改合同控制为空数组。历史快照接受 S01/S02/S03/S06，覆盖 4/6，与污染快照有四项差异；截止点后移，覆盖为 5/6，仅 S06 快照遗漏仍在。质量清单分别保留缺值、不可用与范围外问题。它证明所选公开合成输入与查询的结果，不证明企业数据、模型效果、组合收益、业务部署或教学成效。

#metadata((case: "X3"))<case-X3> *X3* 2026-11-10 随册合成练习扩展：显式 UTC 截止时点在 UTC 与 Asia/Shanghai 会话中保持同一结果；来源选择按必要条件得到 new_vendor，现有源覆盖补齐后改选 incumbent，撤去新源许可则无合格候选；实体级对账揭示总量相等时的 −2000/+2000；有效期映射区分唯一匹配、无匹配与重叠歧义。原生测试核对完整输出，不调用模型或业务数据。它支持这些教学规则与边界，不证明实际供应商、专利、财报或数据管理系统已通过验收。

#metadata((case: "N4"))<case-N4> *N4* 2026-11-08 Open Code Review 1.13.6 的原生版本、delegate/preview/rule 完整帮助及已安装的官方评审与委派 Skill：核对文件范围、规则解析、输出字段和命令语法。本文的零收益评审意见来自随册合成合同，不是 OCR 模型结果；未调用模型、测试供应商、读取凭据或证明团队采用收益。

#metadata((case: "T1"))<case-T1> *T1* 2026-11-08 直接读取 Hermes 源版 `1af0577348cb23440b413846798dd75de3ee1cf4` 的 `agent/turn_tool_round.py`、`agent/tool_executor.py` 与 `run_agent.py` 相关执行入口：工具调用校验、调用记录先保存、宿主执行、失败或边界停止、结果后继续。它支持所选实现的源码解释；未运行模型、验收所有分支，也不外推为每种 Agent 的统一实现。正文将这项机制用于教学，并未改变 Hermes 安装。

#metadata((case: "I2"))<case-I2> *I2* 2026-11-07 05:44 UTC 原生管理者、App 顶层选区与入口快照；#metadata((case: "R1"))<case-R1> *R1* 原 71 项请求的完整编辑去向，以及 38 份来源在编写期间的字节复核。请求记录是导航与历史决定，不是运行证明。先前版本有作者自审记录，但读者随后指出版式缺陷；该记录不能充当新版审美验收。当前源仓库中的候选仍须完成编辑、逐页视觉检查与交付核验，团队教学效果尚未测量。

#metadata((case: "T2"))<case-T2> *T2* 2026-11-08 读取 OpenAI 公开 Prompt engineering、Function calling、Retrieval 与 Supervised fine-tuning 文档：非确定性输出、上下文与 RAG、调用回路、向量相似性和按训练样例更新参数。仅用于解释所选技术关系；不把文档中的供应商能力、通道或例子当作所有产品的保证。所选完整返回正文和相关段落由原证据拥有者保留，未执行模型 API 请求、训练或模型对比。

]

#chapter("附录", "C", "官方入口与随册练习", "先核对自己的产品版本与环境，再使用例子。文档入口不是运行授权。")<companion>
#block[
#set text(size: 9pt)
#set par(first-line-indent: 0pt, leading: 5.5pt, spacing: 9pt)
#link("https://learn.chatgpt.com/docs/cli")[Codex] · #link("https://code.claude.com/docs/en/overview")[Claude Code] · #link("https://github.com/NousResearch/hermes-agent")[Hermes]

#link("https://onorca.dev/")[Orca] · #link("https://github.com/multica-ai/multica")[Multica] · #link("https://github.com/Tencent/teamai-cli")[TeamAI]

#link("https://github.com/paperclipai/paperclip")[Paperclip] · #link("https://github.com/Yeachan-Heo/oh-my-codex")[OMX] · #link("https://github.com/Yeachan-Heo/oh-my-claudecode")[OMC] · #link("https://omp.sh")[OMP]

#link("https://github.com/MinishLab/semble")[Semble] · #link("https://github.com/repowise-dev/repowise")[RepoWise] · #link("https://github.com/tirth8205/code-review-graph")[Code Review Graph]

#link("https://github.com/oraios/serena")[Serena] · #link("https://github.com/Egonex-AI/Understand-Anything")[Understand Anything] · #link("https://github.com/microsoft/markitdown")[MarkItDown]

#link("https://docs.graphify.com")[Graphify] · #link(<code-search>)[代码检索的分工]

#link("https://github.com/alibaba/open-code-review")[Open Code Review] · #link(<quality>)[评审使用路径]

#link("https://developers.openai.com/api/docs/guides/prompt-engineering")[模型请求与上下文] · #link("https://developers.openai.com/api/docs/guides/function-calling")[工具调用] · #link("https://developers.openai.com/api/docs/guides/retrieval")[检索机制] · #link("https://developers.openai.com/api/docs/guides/supervised-fine-tuning")[微调机制]

#link("https://context7.com/docs/resources/all-clients")[Context7] · #link("https://github.com/Panniantong/Agent-Reach")[Agent Reach] · #link("https://duckdb.org/docs/stable/")[DuckDB] · #link("https://jupyter.org/")[Jupyter]

#link("https://docs.browser-use.com/open-source/quickstart")[Browser Use] · #link("https://github.com/vercel-labs/agent-desktop")[Agent Desktop] · #link("https://github.com/mksglu/context-mode")[Context Mode]

#link("https://quarto.org/docs/guide/")[Quarto] · #link("https://typst.app/docs/")[Typst] · #link("https://help.obsidian.md/")[Obsidian]

#link("https://github.com/HengYangDS/architecture-publisher")[Architecture Publisher] · #link(<generated-explanation>)[生成说明的核对]

#link("https://docs.getsemantica.ai/")[Semantica] · #link("https://docs.mem0.ai/introduction")[Mem0]

#link("https://hindsight.vectorize.io/")[Hindsight] · #link("https://github.com/vectorize-io/hindsight")[Hindsight 源码] · #link("https://brew.sh/")[Homebrew] · #link("https://docs.astral.sh/uv/")[UV] · #link("https://mise.jdx.dev/")[Mise]

#link("https://www.promptfoo.dev/docs/")[Promptfoo] · #link("https://inspect.aisi.org.uk/")[Inspect] · #link("https://arize.com/docs/phoenix/")[Phoenix]

#link("https://dlthub.com/docs/")[dlt] · #link("https://sqlmesh.readthedocs.io/")[SQLMesh] · #link("https://docs.dagster.io/")[Dagster] · #link("https://airflow.apache.org/docs/")[Airflow]

#link("https://semgrep.dev/docs/")[Semgrep] · #link("https://ast-grep.github.io/")[ast-grep] · #link("https://www.oasdiff.com/")[oasdiff]

#link("https://docs.openrewrite.org")[OpenRewrite] · #link(<case-S14>)[仅源码研究的采用边界]

#link("https://github.com/HengYangDS/aigw-cli")[AIGW] · #link(<reading-capabilities>)[主 Agent 与模型路由的分工]

#link("https://github.com/anchore/syft")[Syft] · #link("https://github.com/anchore/grype")[Grype] · #link("https://github.com/casey/just")[Just] · #link("https://difftastic.wilfred.me.uk/")[Difftastic]

]

== 随册练习文件 <companion-files>
若你收到本册及配套 ZIP，请先解压练习包，阅读其中的“开始阅读.txt”与 exercises/reader-guide.zh.md；再按#link(<practice-code>)[零收益修复]、#link(<practice-data>)[历史快照核验]或#link(<practice-research>)[来源选择]进入。PDF 不依赖某台机器的文件路径，也不提供未经发布的下载链接；未收到练习包时，仍可先读正文中的完整示例。

随册源仓库的 exercises 目录保存合成数据、SQL、预期差异、旧/新Python函数与unittest。每个文件均可完整阅读；先读契约，再跑离线命令。教学资产不绑定个人用户名或业务路径，不需要账号。Python 题只用标准库；数据题需要已有 DuckDB，接口题需要已有 oasdiff，选做的结构匹配题需要 ast-grep。没有这些工具时，仍可读完整输入、预测结果并完成判断题；安装须按团队原供应流程另行处理。

*历史快照*：source-observations.csv、universe.csv、research-snapshot.csv、reconcile.sql、expected-differences.csv、quality.sql、expected-quality.csv。

*来源选择*：source-candidates.csv、source-selection.sql。*实体对账*：entity-expected.csv、entity-observed.csv、entity-reconciliation.sql。*有效期映射*：entity-mappings.csv、entity-events.csv、entity-mapping.sql。

*编码练习*：export_bug.py、export_fixed.py、test_export.py。*接口练习*：openapi-before.yaml、openapi-after.yaml。*工作模板*：task-brief.md、source-table.csv、evaluation-card.md、team-asset-review.md、work-chain-design.md、long-task-checkpoint.md、transfer-cases.json。完整机器验收留在原证据拥有者，不装入可分享练习包。

== 读完之后做一件真实的事
选一项你熟悉质量标准、又被重复劳动拖慢的任务。把材料与边界交清楚，先看一个样品，用实际工具做成一份可检查的成果。随后让同事接续，看方法在哪里需要改进。

当经验能由另一个人在另一个任务里重新判断并使用，个人的熟练才开始变成团队的能力。
