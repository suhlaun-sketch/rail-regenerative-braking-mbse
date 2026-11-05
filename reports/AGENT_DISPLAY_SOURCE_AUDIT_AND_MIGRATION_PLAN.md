# Agent Display 源码审计与原生 UI 移植方案

> 审计日期：2026-11-04
> 目标工程：`D:\AUSA\Projects\Experiments\牵引制动能量回收`
> 参考快照：`D:\AUSA\Projects\Experiments_reference_agent-display`
> 审计范围：PARK / SPIDER / NEBULA 的实际 `index.html` 实现、本地运行基线、React 封装和真实工程数据接入边界。

## 审计结论

三个参考主题都不是普通节点图。PARK 是自建原生 WebGL 场景与后期管线，SPIDER 是多层 Canvas 2D + DOM 作战室，NEBULA 是 three.js 粒子、丝带网格、线和 DOM HUD 组成的三维动画系统。现有工程中的 `EngineeringPark.tsx`、`SpiderKnowledgeFlow.tsx` 和 `KnowledgeNebulaGraph.tsx` 分别是 CSS 伪 3D、SVG 流程和 React Flow 节点图，与参考源码的渲染架构不同。移植应保留原生场景、镜头、动画和交互循环，只替换模拟业务层。

本轮没有覆盖现有页面，没有修改 SysML、需求 Excel、Neo4j 数据或任何正式仿真数据。

## 1. 三个主题的真实源码位置

参考仓库当前主分支只有 `README.md`、`CHANGELOG.md`、`LICENSE`、`index.html` 四个文件。主题模板、CSS、渲染器、模拟器和路由都在单文件 `index.html` 中。

| 主题 | DOM/CSS 模板 | 挂载函数 | 路由注册 |
|---|---:|---:|---:|
| SPIDER | `index.html:279-532` | `mountSpider(host, SR)`，`index.html:4157-5659` | `index.html:21104` |
| NEBULA | `index.html:1117-1400` | `mountNebula(host, SR)`，`index.html:8780-9945` | `index.html:21107` |
| PARK | `index.html:2358-2931` | `mountPark(host, SR)`，`index.html:14919-18313` | `index.html:21111` |

共享 three.js 按需加载器位于 `index.html:21097-21102`，参考版本为 three.js `0.147.0`，包括 `EffectComposer`、`RenderPass`、`ShaderPass`、`UnrealBloomPass` 等脚本。

`git clone --depth 1` 因本机到 `github.com:443` 的 Git 网络连接失败，审计改用 GitHub 连接器读取主分支递归 tree 和四个 blob。本地文件经 `git hash-object` 验证与上游 blob 一致：

| 文件 | Git blob SHA |
|---|---|
| `README.md` | `a6bbcdd12fe7e3614ca850893d12ff9e4831719b` |
| `CHANGELOG.md` | `860465aa89febc871ad148db03592f3f287011e0` |
| `LICENSE` | `ebceeb4ed8bfa71f807f7ce7c4bf392bf393e20a` |
| `index.html` | `0cf90348d7ad7f179e6f851562ed92be2530b92c` |

## 2. 各主题使用的渲染技术

### PARK

- 使用原生 WebGL2，失败时回退 WebGL1；不使用 three.js。
- 源码自实现向量/矩阵、几何构建、缓冲上传、GLSL 材质、摄像机和拾取。
- 主渲染管线包含 2048 阴影贴图、9-tap 阴影取样、天空/环境/点光、空气透视、ACES 色调映射、移轴模糊和四分之一分辨率泛光。
- 主场景为 WebGL，HUD/状态卡为 DOM，吞吐、甘特图等小图使用 Canvas 2D。
- 性能调节器持续评估帧时间，逐级关闭 MSAA、下调 DPR、再关闭阴影。

### SPIDER

- 原生 JavaScript + CSS + DOM + 四层 Canvas 2D，没有 WebGL 和 three.js。
- 固定 `1920×1080` 画板等比缩放。作战室、工位、大屏、任务包、巡检蛛和右侧飞轮分别由静态底图、动态 Canvas 和 DOM 面板组合。
- 巡检蛛是全屏 Canvas 叠加层，八条腿使用两段骨骼几何求解，根据工位/卡片/规则/日志的实际 DOM 边界移动和抓取。
- 短时蛛网由 `makeWeb()` 以中心点 + 12 个随机辐射点生成，每个辐射点连接中心和两个最近邻居，按生长/淡出时间渲染。
- 右侧飞轮用多个离屏 Canvas 缓存静态线网/圆环，每帧只叠加流光、脉冲、交付光束、刻度和文本块。

### NEBULA

- three.js WebGL 场景，使用 `THREE.Points`、`THREE.Line/LineLoop`、`THREE.Sprite`、自定义 `ShaderMaterial` 和 `BufferGeometry`。
- `EffectComposer + RenderPass + UnrealBloomPass` 实现辉光；后处理不可用时自动回退直接渲染。
- DOM 覆盖层显示星团名称、词标签、左上任务状态、顶部章节和底部六面板；雷达/热力/评分小图使用 Canvas 2D。
- 与目标工程已安装的 three.js `0.186.1` 存在版本差异。移植时应使用 ES module 导入和当前版本的 `three/examples/jsm/postprocessing/*`，并对 shader attribute/uniform 做视觉回归。

## 3. 关键函数和依赖

### PARK 关键实现

| 职责 | 源码函数/状态 |
|---|---|
| 六座厂房与 28 道工序 | `WS`，两排位置最终是 `x=-16/0/16`、`z=-11/11` |
| 园区几何 | `buildPark()`、`buildHub()`、`box()`、`sphere()`、`lathe()`、`tube()`、`rail()` |
| 道路与传送带 | `ROUTES`、`pathMake()`、`pathAt()`、`conveyor()`；每个车间有进料和回收两条路径 |
| WebGL | `glSetup()`、`upload()`、`drawList()`、`drawAll()`、`shadowSetup()` |
| 镜头 | `camGoal()`、`startFly()`、`camUpdate()`、`tourStep()` |
| 场景切换 | `goScene()`，园区 `-1`、中枢 `-2`、车间 `0..5` |
| 展开动画 | `roofE` 在 `step()` 中缓动，场景内绘制屋顶接启和近侧墙下降 |
| 拾取 | `rectOf()`、`boxPts()`、`pick()`，点击厂房/中枢/机器后进入相应场景 |
| 园区调度模拟 | `newOrder()`、`updatePark()`、`updateHall()`、`completeStation()` |
| 控制台 | `hallAct()`、`setSpd()`、`globalAct()` |

PARK 园区包含中央圆形调度中枢、六座厂房、中轴物流走廊、外环路、两条纵向道路、12 条高架传送带、水塘、大门、绿化、外围工业设施、车辆和行人。厂房可从园区全景飞入，依次打开屋顶/侧墙并显示真实工位模型。

### SPIDER 关键实现

| 职责 | 源码函数/状态 |
|---|---|
| 作战室布局 | `SW=1340`、`SH=562`、`COLS`、`ROWS`、`AISLE`、`GAPS` |
| 任务路由 | `route()` 通过水平通道和最近垂直空隙规划折线 |
| 任务状态机 | `dispatch()`、`startWork()`、`finishStage()`、`deliver()`、`recordReview()`、`simStep()` |
| 任务包动画 | `packet()` + 二次贝塞尔 `bez()` |
| 巡检蛛 | `SP`、`spiderGo()`、`patrol()`、`spiderStep()`、`knee()`、`drawSpider()` |
| 蛛网 | `makeWeb()` |
| 飞轮中枢 | `buildThreads()`、`buildRing()`、`buildBlocks()`、`drawFly()` |
| 任务交接 | `flyDispatch()` 产生汇聚脉冲，`flyDeliver()` 推高转速并射出光束 |
| 打回 | `flyRework()` 降低转速并射出红色光束，配合 PROOF 评审锁定 |

中央不是一张静态蛛网图，而是带 12 个工位的作战室。任务在工位之间交接，巡检蛛跨越全画板巡检 DOM 目标。右侧飞轮是汇总工作流、Token 和交付状态的另一个 Canvas 子系统。

### NEBULA 关键实现

| 职责 | 源码函数/状态 |
|---|---|
| 星团布局 | `ORBITS=[(19.5,11.2,3,150s),(30,16.8,4,230s),(40.5,22.4,5,320s)]` |
| 星团粒子 | `buildNebulae()`；每团约 3,400 点，fiber 类约 1,900 点，附加纤维粒子 |
| 六种形态 | `puff / swirl / ring / stream / twin / fiber` |
| 中央星核 | `buildCore()`、`makeRibbonBall()`、`ribbonGeo()`、`ribbonMat()` |
| 三圈近核轨道 | 半径 `8.0 / 9.4 / 10.6`，各自倾斜、带运动光点 |
| 十二团公转 | `orbitStep()`，速度与对应轨道周期绑定 |
| CRAWLER | `buildSpider()`、`walkTo()`、`spiderMove()`、`legsStep()` |
| 词级触须和轨迹 | `threadTo()`、`buildThreads()`、`threadsStep()` |
| 关系流星 | `comet()`、`cometStep()`、`cometsDraw()` |
| 镜头 | `camWant()`、`camStep()`、`fitCamera()`；跟随/俯瞰/斜看/环绕四模式 |
| 点击聚焦 | `pickAt()`、`setFocus()`，缓动镜头目标与位置 |
| 底部六面板 | `.p-log / .p-sec / .p-rad / .p-heat / .p-score / .p-code` |

星团不是相同点云的换色复制。`buildNebulae()` 为六种形态分别使用旋臂、环形密度、拖尾、双瓣高斯团和纤维线束等算法。星团在三条椭圆轨道上公转，群组沿轨道切线旋转。CRAWLER 使用八腿三段求解和交替踏步，在星团局部坐标内爬行、跨星团跳跃，并在读取词元时伸出点线触须。

## 4. 可直接移植的代码范围

“直接移植”指保留算法、几何、渲染和动画行为，以 TypeScript/ES module 做最小包装，不包括连同模拟数据原样上线。

| 主题 | 建议保留 | 需要工程化调整 |
|---|---|---|
| PARK | 几何构建器、园区/厂房/道路/传送带空间、WebGL shader、阴影与后期、镜头飞行、屋顶展开、拾取和自适应画质 | 把 `WS` 的文案/路由/指标改为 props；把任务箱/机器进度改为真实状态投影；实现完整 dispose |
| SPIDER | 作战室布局、Canvas 绘制、DOM 目标测量、巡检蛛骨骼与蛛网、飞轮渲染和任务包动画 | 用真实语义 API 事件代替 `simStep/tokenStep`；重定义工位为 Requirement/Function/Product/Evidence 处理阶段 |
| NEBULA | 三圈轨道、六种星云生成器、星核丝带、CRAWLER 骨骼/跳跃/触须、流星关系、镜头和点击聚焦、六面板空间 | 将 12 个模拟 Agent 星团改为工程实体分类/分组；将词级模拟改为查询事件、节点证据和关系递进 |

不建议直接拷贝整个 `index.html`。它包含十个主题、全局哈希路由、CDN 加载器和大量无关 CSS。三个渲染器应各自抽出，并共享一个生命周期协议。

## 5. 必须重写的模拟业务逻辑

### PARK

需删除或隔离：`newOrder()` 随机工单、`updatePark()` 自动派单、`updateHall()` 随机工序、`completeStation()` 随机质检、伪遥测、预置产能/交付数和 `hallAct/setSpd/globalAct` 的本地控制效果。

真实工程中的六个区域已由 `OverviewPage.tsx` 定义：需求语义、任务切片、知识图谱、SysML、SSI/FMI/SSP、联合仿真与 V&V。只把这些真实区域、现有路由和 API 状态投影到六厂房，不生成虚构的工单或设备指标。

### SPIDER

需删除或隔离：`AG/WF/CH/CHECKS/CODESETS`、任务随机初始化、`dispatch()`、`simStep()`、`tokenStep()`、模拟 Token 单价/成本/日产出、随机质检通过/打回和伪代码面板。

真实事件应来自 `semanticApi.query()` 的请求生命周期和返回数据：接收查询、解释 scope、Requirement 命中、Function 追溯、Product allocation、证据加载/无直接映射。“打回”只能表示 API 验证失败、证据缺失或用户重新查询，不能随机触发。

### NEBULA

需删除或隔离：`AG/WF/VAGUE/PASS/AXES`、`newTask()`、`readWord()` 中的随机模糊词与随机关联、`calcScore()` 中的演示公式、`simStep()` 生成的假负载/交付量、虚构问答和伪脚本。

星云中新节点和新连线必须由实际 API 响应驱动。若图谱模式中没有 `Logical` 或 `Physical` 标签，适配器必须显示“当前数据无此阶段”，不能从 Product/Port 名称猜造逻辑或物理节点。

## 6. React 封装方案

建议封装为三个轻 React 容器和三个无 React 渲染器。React 只管 props、路由、API 和销毁，原生渲染器保持每帧高频状态，避免每帧 setState。

```text
ParkScene.tsx    -> createParkRenderer(shadowRoot, options)
SpiderScene.tsx  -> createSpiderRenderer(shadowRoot, options)
NebulaScene.tsx  -> createNebulaRenderer(shadowRoot, options)
```

统一生命周期：

```ts
interface SceneController<TSnapshot, TEvent> {
  setSnapshot(snapshot: TSnapshot): void
  dispatch(event: TEvent): void
  resize(): void
  focus(id: string | null): void
  dispose(): void
}
```

`dispose()` 必须取消 `requestAnimationFrame`、`setInterval/setTimeout`、`ResizeObserver`、所有 document/window/canvas 事件，并释放 three.js/WebGL geometry、material、texture、render target 和 context 引用。参考源码当前不提供 unmount，这是 React 移植必须补齐的工程项。

样式隔离建议沿用参考项目的 Shadow DOM 思路：每个 Scene 创建自己的 `shadowRoot`，将对应 template CSS 放入 `adoptedStyleSheets` 或 `<style>`。Ant Design 的 reset/token 不进入 Shadow DOM，场景 CSS 也不外泄。对话框、Drawer 等 Ant Design 内容仍由 React 在主 DOM 渲染。

组件 props 建议：

- `ParkScene`: `zones`、`metrics`、`activeZoneId`、`onZoneOpen`、`quality`。
- `SpiderScene`: `query`、`pipelineStages`、`events`、`selectedEntityId`、`onEntityOpen`。
- `NebulaScene`: `clusters`、`nodes`、`relations`、`activePath`、`events`、`selectedNodeId`、`onNodeOpen`。

## 7. 与现有 API 的数据接口方案

### PARK 适配器

`OverviewPage.tsx` 已经并行读取：

- `/api/project/status`
- `/api/kg/summary`
- `/api/semantic/catalog`
- `/api/task-slice/catalog`
- `/api/digital-thread/summary`
- `/api/vv/summary`

保留这一真实聚合方式，将六个 `ParkZone` 适配到 PARK 的六座厂房。厂房点击直接使用现有 React Router 路由。厂房内部的“机器”可对应模块下的真实工程阶段，只在 API 有明确状态时显示进度。

### SPIDER 适配器

`semanticApi.ts` 已提供：

- `catalog / requirements / functions / products`
- `query(query, mode)`
- `requirement(id) / function(id) / product(id)`
- SysON scope/plan/generate/container IBD 接口

查询时生成不可伪造的事件序列：`QUERY_STARTED -> SCOPE_RESOLVED -> REQUIREMENT_MATCHED* -> FUNCTION_TRACED* -> PRODUCT_ALLOCATED* -> EVIDENCE_READY | NO_DIRECT_MAPPING -> QUERY_COMPLETED`。`semantic_score` 仅用于排序，不用作伪质量得分。巡检蛛根据事件去对应工位、右侧证据面板和底部日志。

### NEBULA 适配器

现有图谱接口已覆盖：

- REST: `/api/kg/summary`
- GraphQL: `searchEntities`、`getNeighbors`、`getRequirementTrace`、`getFunctionTrace`、`getFunctionRoute`、`getItemRoute`、`getProductContext`、`findPath`、`getSubgraph`
- 节点类型：`Requirement / Function / Product / Port / Item / PhysicalNet / ExternalBoundary`
- 关系带 `status/source/sourceFile/evidence/mappingType/allocationId/connectionId/provenanceClass/derivationBasis`

执行顺序设计为：

1. 查询命中的真实 Requirement 在当前星团中从暗态转为激活。
2. `TRACE_TO_FUNCTION` 逐条生成关系流星，Function 节点从星云中出现。
3. `ALLOCATED_TO` 和 `getFunctionRoute()` 将主链接入产品、端口和参与产品。
4. `PhysicalNet / Item / ExternalBoundary` 作为已有模式中的物理结构层展开。若后端未提供独立 `Logical` 类型，UI 明确标记该阶段无直接实体。
5. 右侧证据栏展示当前 node/edge 的原始属性和 evidence；底部六面板显示查询、阶段、证据完整性、关系展开计数、主链状态和实际 API 日志。

为保持主链连续，渲染器维护 `activePathNodeIds/activePathEdgeIds`，每次增量合并 `Subgraph`，已出现节点不重新布局，新节点从目标星团的确定性局部 seed 位置诞生。

## 8. 许可证和版权保留方案

参考项目是 `PolyForm-Noncommercial-1.0.0`。高校教学、学术研究和非商业竞赛可以落在其允许的非商业目的内，但 `LICENSE:32-40` 的 Notices 条款仍要求下游获得许可条款或其 URL，以及授权人提供的 Required Notice。因此，如果直接复制或实质性改编渲染源码，不能删除该声明。

建议落地：

- `ui/frontend/src/vendor/agent-display/LICENSE`：保留上游许可证全文。
- `ui/frontend/src/vendor/agent-display/NOTICE.md`：记录 `Required Notice: Copyright (c) 2026 赛博老爸`、上游 URL、快照 blob 信息和移植文件范围。
- 每个 renderer 顶部保留简短来源注释，产品 UI 中无需把长许可证文本放入工程操作流。
- 若后续不复制代码，而是只借鉴抽象思路独立重写，应在代码审查中单独判定是否存在实质性表达复制。本任务要求尽可能保留原场景生成和动画机制，因此应按直接改编方案保留 notice。

## 9. 预估修改文件清单

后续移植阶段建议新增：

```text
ui/frontend/src/components/scenes/ParkScene.tsx
ui/frontend/src/components/scenes/SpiderScene.tsx
ui/frontend/src/components/scenes/NebulaScene.tsx
ui/frontend/src/scenes/core/sceneTypes.ts
ui/frontend/src/scenes/park/parkRenderer.ts
ui/frontend/src/scenes/park/parkAdapter.ts
ui/frontend/src/scenes/park/parkTemplate.ts
ui/frontend/src/scenes/spider/spiderRenderer.ts
ui/frontend/src/scenes/spider/spiderAdapter.ts
ui/frontend/src/scenes/spider/spiderTemplate.ts
ui/frontend/src/scenes/nebula/nebulaRenderer.ts
ui/frontend/src/scenes/nebula/nebulaAdapter.ts
ui/frontend/src/scenes/nebula/nebulaTemplate.ts
ui/frontend/src/scenes/shared/shadowHost.ts
ui/frontend/src/vendor/agent-display/LICENSE
ui/frontend/src/vendor/agent-display/NOTICE.md
ui/frontend/src/scenes/__tests__/adapterFixtures.ts
```

在视觉回归通过后，才替换以下页面的场景入口：

```text
ui/frontend/src/pages/OverviewPage.tsx
ui/frontend/src/pages/SemanticRequirementPage.tsx
ui/frontend/src/pages/KnowledgeGraphPage.tsx 或当前 Crawler 入口
ui/frontend/src/components/overview/EngineeringPark.tsx
ui/frontend/src/components/semantic/SpiderKnowledgeFlow.tsx
ui/frontend/src/components/semantic/KnowledgeNebulaGraph.tsx
```

替换时先并行保留旧组件作为可回退实现，完成三个原生场景的数据、交互、性能和截图验收后再移除旧入口。不修改现有后端语义/图谱查询逻辑，除非发现渲染所需的事件字段无法从现有响应推导。

## 10. 原始主题与计划移植版本的视觉对照

| 视觉/交互项 | 原始 PARK | 计划 PARK | 原始 SPIDER | 计划 SPIDER | 原始 NEBULA | 计划 NEBULA |
|---|---|---|---|---|---|---|
| 主画面 | 全屏微缩 3D 园区 | 保留同一 WebGL 园区 | 粉色画框内的作战室 | 保留 Canvas 作战室 | 全屏 3D 星云 | 保留粒子星云，不换成节点框图 |
| 空间 | 6 厂房 + 中枢 + 道路 + 传送带 | 6 个真实工程模块 | 12 工位 + CHIEF + 右侧飞轮 | 语义处理工位 + 证据汇聚 | 12 星团 + 星核 + 三条公转轨道 | 工程实体分类星团 + 连续主链 |
| 镜头 | 全景/俯瞰/巡游/厂房飞入/工位特写 | 原样保留 | 无 3D 镜头，固定 1920×1080 画板 | 原样保留 | 跟随/俯瞰/斜看/环绕/星团聚焦 | 原样保留 |
| 动画 | 屋顶揭开、墙体下降、机械臂 IK、运输 | 保留绘制和过渡，状态来自 API | 任务包、巡检蛛、蛛网、飞轮 | 保留，事件来自真实查询 | 星团公转、自旋、漂移、CRAWLER、触须、流星 | 原样保留，关系由真实图谱驱动 |
| 面板 | 园区/车间/中枢调度 | 真实 API 状态与路由 | Agent/Token/质检/代码 | Requirement/Function/Product/Evidence 事件 | 底部 6 面板 | 查询、层次、证据、展开、主链、API 日志 |
| 虚构指标 | 工单/产能/质检为模拟 | 移除 | Token/成本/得分/任务为模拟 | 移除 | 需求/模糊词/评分/业务负载为模拟 | 移除 |

原始视觉基线均为 `1600×900`：

- `D:\AUSA\Projects\Experiments_reference_agent-display\visual-baseline\park.png`
- `D:\AUSA\Projects\Experiments_reference_agent-display\visual-baseline\spider.png`
- `D:\AUSA\Projects\Experiments_reference_agent-display\visual-baseline\nebula.png`
- 交互后截图：同目录下 `park-interaction.png`、`spider-interaction.png`、`nebula-interaction.png`

## 本地运行与性能基线

使用 `python -m http.server 8765 --bind 127.0.0.1` 启动参考页，Chrome/Playwright 在相同视口下分别打开 `#park`、`#spider`、`#nebula`。

| 主题 | 启动 | Canvas | WebGL 失败提示 | 交互 | 备注 |
|---|---|---:|---:|---|---|
| PARK | PASS | 4 | 0 | 拖动、缩放、点击厂房 PASS | WebGL2=true，MSAA=true；点击后 `scene=4` |
| SPIDER | PASS | 4 | 0 | 画板持续动画 PASS | 无 WebGL 依赖 |
| NEBULA | PASS | 5 | 0 | 拖动、缩放、点击 PASS | 实测 171 calls / 27,312 triangles / 78,264 points |

PARK 控制台唯一错误是浏览器请求未提供的 favicon 得到 404，不影响主题。NEBULA 的 jsDelivr three.js 与后处理脚本本次均加载成功。

## 移植实施顺序

1. 先抽出 `shadowHost` 和统一生命周期，将三个原生主题以静态 fixture 运行到 React 独立路由，达到与本报告截图同级的视觉基线。
2. 先移植 NEBULA 渲染器，完成 three.js 0.186.1 兼容、资源销毁和性能回归。
3. 接入图谱真实节点/关系事件，保持 Requirement -> Function -> 已存在的结构/物理实体主链。
4. 移植 SPIDER，用 `semanticApi` 请求事件替换任务/Token 模拟。
5. 移植 PARK，用现有六区域数据替换 `WS`，保留园区空间、厂房展开和路由。
6. 通过视觉、交互、数据真实性、资源释放、降级和 1600×900 对照验收后，再切换现有三个页面入口。
