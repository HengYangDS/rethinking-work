#import "/publication/layout/style.typ": *
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

#matrix([*事实层*], [*记录支持什么*], [*仍不能说什么*], [原生安装元数据], [本次检查范围内存在相应软件包、App 或命令入口], [所有功能、账号、插件都已正常], [完整实战记录], [指定对象曾走通指定输入到结果], [每个用户、平台或数据都适用], [采用建议], [按任务、代价与维护选择最小组合], [已测团队收益或行业最佳], [未知与保留], [哪些边界缺证、由谁继续判断], [没有读到就等于不存在])

=== 没有进入默认组合的对象
先保留条件，再决定采用。GitNexus 的已读版本有非商业许可条件，不能直接推广为公司标准；muse.ai GUI 与 Muse Code 不是同一产品，mac-computer-use 的精确来源仍需确认。它们不因名称相近获得安装或使用结论。

Prime Agent、Muse Code、Qoder、WorkBuddy、Trae 与 Grok/OpenRouter 等入口，在账号、供应商配置或完整任务使用上仍有未核验的环节，不能据此要求同事再添一个主 Agent。OMP/OMX 的版本命令也只能确认入口报告的版本，不能证明其中的方法已融入日常工作、运行中的连接已加载新版，或已通过独立效果评测。

Lume、Cua Bench、Cua-S1 和 Obscura 只在明确桌面环境或专项评测需求出现时考虑；不为演示创建另一套虚拟化或专用模型。Tencent Agent Memory 保留研究与成品资格边界；Tavily 的原提取记录有配额拒绝；这些条件不能被一段流畅介绍抹去。

Jev/Laya、Clef/Clef-flash 的有限离线试验，尚不足以支持推广到自主维护；Qwen 对比仍按用户决定暂停。是否采用 Temporal、Argo、DolphinDB、Milvus、SeaTunnel 或湖仓类方案，要看实际负载、组织身份、数据使用权和恢复条件，不能由已有工具的数量决定。OpenUI/OpenShip 与 Vercel 生态也应按既有产品的需要选择，不为使用这些工具另建一套管理整台工作站的系统。

#takeaway("把未知放在正确位置", [仍未完成全部项目环境、嵌套或未注册 App、虚拟机软件与服务镜像的完整依赖盘点；没有证明所有软件配置和实际使用。写作可先交付已证实经验，但应把未证实边界留在采用条件里，不把有限记录写成完整环境认证。])

#chapter("附录", "B", "案例出处与限制", "每项结论都有其适用范围。正文的来源编号可跳转到以下说明；原始记录的保管方保留精确路径、完整原件和校验记录，这些材料不随源仓库或练习包分享。")<case-records>
#small[以下说明作者所依据的案例及其证明范围，不是随书公开的原始日志。原件未随书提供的案例，读者不能仅凭这段说明独立复现实验；可独立练习的合成输入见#link(<companion>)[附录 C]。]

== 本册的编辑与试验范围
编写工作包括写作、原生只读盘点与公开合成样例；原版、完整源和必要证据由原证据库保留。写作不包含软件安装，也不改变服务、账号、模型、项目锁或人工版本约束。作者自审和逐页检查与独立外部评审、实际教学反馈分别记录。

#block[
#set text(size: 9pt)
#set par(first-line-indent: 0pt, leading: 5.5pt, spacing: 9pt)
#metadata((case: "S1"))<case-S1> *S1* Quarto：2026-11-07，记录原生发布的精确执行边界、完整正文与视觉验收；不证明所有出版环境均可用。

#metadata((case: "S2"))<case-S2> *S2* Hermes：2026-11-06，在原会话中完整读取选定 Skills 并核对 RepoWise 连接。未完成全部工具执行，也未验证一般运行状态下的恢复。

#metadata((case: "S3"))<case-S3> #metadata((case: "S4"))<case-S4> *S3–S4* Orca/Multica：2026-11-06 至 07，核对原包与 CLI，并恢复选定配置档的运行环境。显示 online 不代表各供应商的实际任务均已验证。

#metadata((case: "S5"))<case-S5> *S5* TeamAI：2026-11-06，原生入口返回 NotInitialized。本地 CLI 样例与团队代码托管平台上的实际流程分别判断。

#metadata((case: "S6"))<case-S6> #metadata((case: "S15"))<case-S15> *S6/S15* Semble/CRG：2026-11-03 及 07，核对原 UV 安装、查询、图的保留和停机恢复。大型图、预热（warm）与持续监测（watch）等能力仍有未验证部分。

#metadata((case: "S7"))<case-S7> *S7* RepoWise：2026-11-07，CJK 全文案例所用材料仍未满足完整源码要求。元数据不能证明全库已刷新。

#metadata((case: "S8"))<case-S8> *S8* Understand Anything：2026-11-05，在公开小样例中检查图、搜索与源码打开；未证明能理解完整应用，也未证明产品优越。

#metadata((case: "S9"))<case-S9> #metadata((case: "S10"))<case-S10> #metadata((case: "S11"))<case-S11> *S9–S11* Agent Reach、MarkItDown、Agent Desktop：分别保留公开材料读取、完整转换、TextEdit 保存与重开的具体样例。结果不外推到平台全部内容、视觉理解能力或未验证的焦点操作。

#metadata((case: "S12"))<case-S12> #metadata((case: "L3"))<case-L3> *S12/L3* Mise：2026-11-06 至 07，完整配置试验通过，ETHOS 的两文件副本却因遗漏补充锁定文件改变了 npm 工具的解析路径。复制逻辑修复后，原三个项目的检查通过：其中两份完整结果经过直接读取，一份来自负责人报告，并非三份独立实测。技术验收不撤销人的版本锁定决定。

#metadata((case: "S13"))<case-S13> *S13* Paperclip：2026-11-07，官方新候选的完整依赖组合通过资格检查，不等于当时 pnpm 所选安装根目录也通过检查；不以自建包装层绕过。

#metadata((case: "S14"))<case-S14> *S14* OMC/OpenRewrite：2026-11-06，仅作源码研究，未执行，也不宣称已采用。

#metadata((case: "H1"))<case-H1> #metadata((case: "H2"))<case-H2> *H1/H2* Hindsight：2026-11-07 的 diagnose、sync、search、完整 Skill 读取及 reflect 失败记录；2026-11-05 在前端读取完整知识页并导出 Markdown 的记录。知识页仍可能失真；这些检查不证明完整数据库能够恢复。

#metadata((case: "K1"))<case-K1> #metadata((case: "K2"))<case-K2> *K1/K2* Semantica/Obsidian：2026-11-06 已查到当前版本的文档，页面 DOM 完整，但可见布局受限；2026-11-03 完整读取原笔记库（vault）。未验证一般情况下的材料撤下与恢复。

#metadata((case: "Q1"))<case-Q1> *Q1* Semgrep：2026-11-07，记录公开 Python/Go 离线规则样例、安装与旧版的精确移除；核心仍有未能完整识别的部分，已批准的依赖限制仍予保留。

#metadata((case: "I1"))<case-I1> #metadata((case: "E1"))<case-E1> *I1/E1* 编写期间读取的原生安装清单，以及完全合成的对账、失败与通过测试。DuckDB 入口报告 v2.0.0，Brew 收据为 2.0.0_1（包装修订）；agent mode 的展示范围依据该版本原生帮助。结论仅限这些元数据和样例约定，未接入企业数据、账号或服务。

== 历史事件：区分决定、报告与观察
以下事件依据案例中的人类请求与批准、源代码及原始操作记录整理。人类作出的决定、操作者报告的结果和直接观察所得，分别保留，不把批准写成执行成功。

#metadata((case: "L1"))<case-L1> *L1* 全机升级范围：最初只按 Homebrew 清单检查，随后补查了此前遗漏的 npm、UV、Mise 等安装与运行环境。

#metadata((case: "L2"))<case-L2> *L2* Agent Desktop 安装警告：postinstall 脚本被阻止执行。包已安装，不足以证明所需安装步骤全部完成。

#metadata((case: "L4"))<case-L4> *L4* SQLite 隔离恢复：验收目录缺少可写临时路径，出现 `SQLITE_IOERR_GETTEMPPATH`。在同一隔离范围内提供临时目录后，写入与重开通过；这不是旧数据库损坏的证据。

#metadata((case: "L5"))<case-L5> *L5* Hermes Gateway：默认由一个主机 Gateway 服务多个配置档；standalone/force 是兼容性例外，不能据此认定每个配置档都需要一个 Gateway。

#metadata((case: "L6"))<case-L6> *L6* 项目 389 的 CI：当时只有 Darwin Runner，缺少对应的 Linux review/protected Runner；CI 还缺少标签路由和精确镜像摘要。只增加 Runner，不能保证作业会到正确节点执行。

#metadata((case: "L7"))<case-L7> *L7* RepoWise 恢复材料：当时找不到原恢复包，保存位置与保管记录不明。不能据此断言所有副本都已消失、判断由谁删除，更不能生成新材料冒充原证据。

找不到材料，只说明当时无法定位，不证明其他地方没有副本；不能重新生成内容，冒充原恢复材料。授权允许执行具体动作，不代表动作已经执行或结果已经通过验收。版本、安装根目录与来源选择，都须结合记录的日期和对象理解。

== 支撑方法讨论的实践材料
#metadata((case: "G1"))<case-G1> *G1* 部门工作指南，仓库版本 `27bab1ee93792e9be5e67b80e7fb1c66718ef527`：说明业务与数据建模、实现、技术和产品各自的责任，讨论共享发行主体标识变更，以及如何通过真实决策帮助同事形成独立判断。这是一份规范性指南；其中的标识案例用于说明方法，不是事故记录，也不证明部门已全面采用这些方法或测得学习效果。

#metadata((case: "G2"))<case-G2> *G2* 同一仓库版本的数据指南，以“revised market history”案例说明：首次可用时间未知，与已知晚于模拟决策，是两种不同情况。历史研究是否有效、持续供数需要什么条件、哪些用途可以获准，须分别判断。正文的对话与变式据此编写，用于教学，不是逐字实录，也不是实际回测结果。

#metadata((case: "G3"))<case-G3> *G3* Alphasim 仓库版本 `07651c4196be11770eb8b4103e2484b15fcbd85c` 中的 `docs/doc/alpha.md`：教程要求按信号时点实际可见的信息计算，并说明 delay、日频动态复权和日内原始价格的使用条件。本册引用这些文档要求，并未据此验证完整实现、研究数据或任何策略收益。

#metadata((case: "G4"))<case-G4> *G4* 2026-11-12，只读核对 Alphasim-dmgr 仓库版本 `513211af9e31482a649c98746e14c5dc115f5def` 中的 `mapped.py`、`manager_metadata.py` 与 `checkpoints/discard.py`。源码说明了如何记录连续完成的区段、在同步后写入检查点、检查构建是否相容，以及如何保存完整元数据并在成功后清除检查点。#link(<interrupted-build>)[构建中断案例]中的四个日期与工作请求为教学重构；本次未执行业务代码、实际恢复或断电试验，不能证明生产发布、全局事务或研究用途已得到验证。

#metadata((case: "R2"))<case-R2> *R2* 2026-10-08，招聘材料仓库的原 CI 配置、Linux 失败与后续成功记录、任务的最终收尾记录，以及代码托管端对同一 SHA 的校验回执。最终源码版本为 `6256682af3311029d72dcd6f93bc66e4b44593a7`；作业内独立锁定格式器，并保留已通过验收的基础镜像。回执只证明当时的操作，不代表当前远端状态。方案比较与会话指导属于教学解释，不能据此认定候选题目已发布、招聘有效、依赖完全安全或文件已送达企业微信云端。

#metadata((case: "N1"))<case-N1> *N1* 2026-11-07，完整读取 19 项原生命令的帮助，以及与所用 Orca 版本对应的指南，核对命令语法、执行租约（lease）、人工确认（HITL）、终端会话句柄（handle）和返回字段的含义。读过帮助，不等于实际采用了这些流程。

#metadata((case: "N2"))<case-N2> *N2* 2026-11-07 实际 jq/yq/fd/rg 入口及公开教学选择结果：确认小工具的身份和有限表达式，不宣称全部已安装 Brew 软件都得到有效使用。

#metadata((case: "D1"))<case-D1> *D1* 2026-10-11 至 12，使用原生 dlt、DuckDB、SQLMesh 与 Dagster 处理 ECB 公共快照，核对全部数据值、计算截止时点、审计对坏值的拒绝、重放结果和取消后的实际影响。记录来自当时的环境，不证明这些工具今天是最新版，也不证明企业身份与权限管理（IAM）或投资判断已得到验证。

#metadata((case: "V1"))<case-V1> *V1* Inspect 原 `accepted-native-probe.py`：用固定返回 `READY` 的模拟模型（mock）执行一项 Task/Sample，再重新打开 `.eval`，核对完整输出、状态和评分器（scorer）记录。这只验证了评测框架的记录流程，没有测量真实模型的效果。

#metadata((case: "O1"))<case-O1> *O1* Office 文档读写与出版验收记录中的非敏感元数据：五张工作表、215 个非空单元格及其坐标和跨度、13 页，以及原始文件的保留记录。这里只引用这些元数据，不读取或共享文档的业务内容。

#metadata((case: "M1"))<case-M1> *M1* 2026-11-04 的 Multica 任务 LOCA-26：三份指定材料的完整内容、原生完整评论、八项资产条件的对应关系，以及任务结束时的状态、保留和收尾记录。完整任务与备忘录直接从已有归档读取。备忘录中的建议不代表企业数据方案已实现或通过验收。

#metadata((case: "B1"))<case-B1> *B1* 2026-11-07，使用 Browser Use 在自建公开页面中输入中文、保存，再重新载入完整正文和图像。未使用账号或模型；stop 命令的退出码 0 未被视为停止成功的证据，另已核对相关进程退出和临时对象的清理。

#metadata((case: "L8"))<case-L8> *L8* 2026-11-07 的 MLX-Audio 兼容依赖升级：验证 WAV 解码、重采样（resample）、mel 特征处理、字段结构使用及旧代码恢复。分词器接口的检查不等于模型推理或 TTS 合成，也不能据此认定声音已获认可。

#metadata((case: "P1"))<case-P1> *P1* 案例执行时适用的 AGENTS 共享规则：从整体目标判断完成，限定每批操作范围，在约每小时的安全操作边界复盘，沿用原任务进度记录，保留证据并精确收尾。本文将其提炼为教学建议，不替其他团队创建新政策或定时任务。

#metadata((case: "X1"))<case-X1> *X1* 2026-11-07，使用原生 ast-grep/oasdiff 验收合成样例：按语法树（AST）找到一处与指定模式完全匹配的代码；删除路径的改动被拒绝，未修改接口规范的对照样例通过。#metadata((case: "N3"))<case-N3> *N3* 同日，完整读取十项原生命令的帮助并核对语法。Context7 因月配额用尽而拒绝请求，原拒绝记录得到保留；没有重试、更换密钥或扩大权限。命令帮助的核对不等于所有功能都已通过验收。

#metadata((case: "X2"))<case-X2> *X2* 2026-11-09，使用原生工具执行随册量化数据部门合成练习。旧 Python 程序的一项业务断言失败，对照测试通过；修复后的程序两项测试均通过。AST 搜索找到一处完整匹配，字节范围为 58–75。删除 `GET /research-snapshot` 的改动被拒绝；未修改接口规范时，对照检查返回空数组 `[]`。历史快照应选入 S01/S02/S03/S06，覆盖率为 4/6，与污染快照有四项差异；截止时点后移，覆盖率变为 5/6，只剩 S06 仍被快照遗漏。质量清单另行记录缺值、当时不可用和范围外问题。这些结果只证明所选公开合成输入与查询的表现，不证明企业数据、模型效果、组合收益、业务部署或教学成效。

#metadata((case: "X3"))<case-X3> *X3* 2026-11-10 随册合成练习扩展：显式 UTC 截止时点在 UTC 与 Asia/Shanghai 会话中保持同一结果；来源选择按必要条件得到 new_vendor，现有源覆盖补齐后改选 incumbent，撤去新源许可则无合格候选；实体级对账揭示总量相等时的 −2000/+2000；有效期映射区分唯一匹配、无匹配与重叠歧义。原生测试核对完整输出，不调用模型或业务数据。它支持这些教学规则与边界，不证明实际供应商、专利、财报或数据管理系统已通过验收。

#metadata((case: "N4"))<case-N4> *N4* 2026-11-08 Open Code Review 1.13.6 的原生版本、delegate/preview/rule 完整帮助及已安装的官方评审与委派 Skill：核对文件范围、规则解析、输出字段和命令语法。本文的零收益评审意见依据随册合成样例的行为要求编写，不是 OCR 模型结果；未调用模型、测试供应商、读取凭据或证明团队采用收益。

#metadata((case: "T1"))<case-T1> *T1* 2026-11-08，直接读取 Hermes 源码版本 `1af0577348cb23440b413846798dd75de3ee1cf4` 中的 `agent/turn_tool_round.py`、`agent/tool_executor.py` 与 `run_agent.py` 相关执行入口，核对工具调用的校验、先保存调用记录再由宿主执行、失败或触及边界时停止，以及取得结果后继续的顺序。本册据此解释所选实现；未运行模型或验收所有分支，也不将其视为每种 Agent 的统一实现。正文只用于教学，没有改变 Hermes 安装。

#metadata((case: "I2"))<case-I2> *I2* 2026-11-07 05:44 UTC 原生管理工具、App 顶层检查范围与命令入口的快照；#metadata((case: "R1"))<case-R1> *R1* 原 71 项请求的完整编辑去向，以及编写期间对原有 38 份来源文件的逐字节核对；新增源码案例另见 G4。请求记录是导航与历史决定，不是运行证明。先前版本有作者自审记录，但读者随后指出版式缺陷；该记录不能充当新版审美验收。各版的编辑、逐页视觉与交付检查只适用于其具体成品，不由旧版自动延续；作者自审也不等于读者认可，团队学习效果尚未测量。

#metadata((case: "T2"))<case-T2> *T2* 2026-11-08 读取 OpenAI 公开 Prompt engineering、Function calling、Retrieval 与 Supervised fine-tuning 文档：非确定性输出、上下文与 RAG、调用回路、向量相似性和按训练样例更新参数。仅用于解释所选技术关系；不把文档中的供应商能力、通道或例子当作所有产品的保证。原始记录的保管方保留了所读取的完整返回正文及相关段落；未执行模型 API 请求、训练或模型对比。

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
若你收到本册及配套练习包，请先解压，阅读其中的“开始阅读.txt”与 exercises/reader-guide.zh.md；再按#link(<practice-code>)[零收益修复]、#link(<practice-data>)[历史快照核验]或#link(<practice-research>)[来源选择]进入。PDF 不依赖某台机器的文件路径，也不提供未经发布的下载链接；未收到练习包时，仍可先读正文中的完整示例。

随册源仓库的 exercises 目录保存合成数据、SQL、预期差异，以及修改前后的 Python 函数和 unittest 测试。每个文件均可完整阅读；先读各题的要求与预期结果，再跑离线命令。练习文件不绑定个人用户名或业务路径，不需要账号。Python 题只用标准库；数据题需要已有 DuckDB，接口题需要已有 oasdiff，选做的结构匹配题需要 ast-grep。没有这些工具时，仍可读完整输入、预测结果并完成判断题；安装须按团队原供应流程另行处理。

*历史快照*：source-observations.csv、universe.csv、research-snapshot.csv、reconcile.sql、expected-differences.csv、quality.sql、expected-quality.csv。

*来源选择*：source-candidates.csv、source-selection.sql。*实体对账*：entity-expected.csv、entity-observed.csv、entity-reconciliation.sql。*有效期映射*：entity-mappings.csv、entity-events.csv、entity-mapping.sql。

*编码练习*：export_bug.py、export_fixed.py、test_export.py。*接口练习*：openapi-before.yaml、openapi-after.yaml。*工作模板*：task-brief.md、source-table.csv、evaluation-card.md、team-asset-review.md、work-chain-design.md、long-task-checkpoint.md、transfer-cases.json。完整的工作站验收记录仍由原保管方保存，不装入可分享的练习包。

== 读完之后做一件真实的事
选一项你熟悉质量标准、又被重复劳动拖慢的任务。把材料与边界交清楚，先看一个样品，用实际工具做成一份可检查的成果。随后让同事接续，看方法在哪里需要改进。

当经验能由另一个人在另一个任务里重新判断并使用，个人的熟练才开始变成团队的能力。
