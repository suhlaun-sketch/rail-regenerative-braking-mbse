# NEBULA 工程知识图谱 UI 融合与关系演示验收报告

## 结论

独立路由 `/knowledge-graph/nebula-engineering` 已完成融合重构。页面保留 Agent Display NEBULA 的 Three.js 星云、粒子、星核、轨道、后处理和镜头系统，同时恢复旧工程知识图谱实现中有效的阶段播放、暂停、前后跳转、重播、节点检查与证据追溯。

工程模式已经隐藏 CRAWLER 蜘蛛、Agent HUD、Agent 工位标签、模拟任务、评分、负载和吞吐状态。原生验收路由 `/knowledge-graph/nebula-native` 保留，上游 LICENSE 与 NOTICE 保留，正式 `/trace` 未替换。

## 实际源码对比

| 对比维度 | 原版优势（实测） | 新版优势（实测） | 融合结果 |
|---|---|---|---|
| 视觉效果 | KnowledgeNebulaGraph 信息直接但为二维 React Flow；CrawlerView 有工程分组 | 原生 NEBULA 有高密度粒子、轨道、Bloom、镜头和稳定星团 | 使用原生渲染器，工程模式关闭蜘蛛和 Agent HUD |
| 信息布局 | CrawlerView 有阶段轨道、证据面板和播放控制 | 第一版工程接入保留真实查询与关系来源 | 顶部查询/演示、中央星云、按需属性卡、可折叠分层结果 |
| 节点交互 | 节点选择、组件展开、证据查看 | 星团聚焦和稳定 ID 布局 | 单击属性、双击聚焦、邻居展开、反向追溯 |
| 查询流程 | buildCrawlPlan 将真实结果转成阶段事件 | GraphQL/Neo4j 真实查询和有向路径 | 查询只构建计划，播放与请求生命周期分离 |
| 演示播放 | pause/advance/jump/reset 状态清晰 | 关系动画与原生镜头效果较好 | 0～6 阶段、暂停/继续、上一步/下一步、重播 |
| 关系追溯 | EvidencePanel 字段筛选较清晰 | 正式/派生/AI候选/仿真分类完整 | 关系点击显示 ID、类型、来源、依据和状态 |

## 真实数据映射

当前 Neo4j 不存在正式 Logical 节点，因此界面明确显示 `Logical 0`，没有创建替代节点。

- Requirement → 需求星团
- Function → 功能星团
- Product / Profile → 架构与产品星团
- Port → 接口星团
- Item → 参数与信号星团
- PhysicalNet → 物理网络星团
- ExternalBoundary → 外部边界星团

Item 只在真实实体存在时显示。端口中的方向、单位、物理量和信号属性直接显示为属性，不派生虚构节点。

## 真实查询验收案例

查询：**常用制动平均减速度需求**

实际路径：

1. `REQ-BRK-001` 常用制动平均减速度需求
2. `TRACE_TO_FUNCTION`
3. `FN_F_3111_01` 通过车轮耗散能量
4. `ALLOCATED_TO`
5. `3111` 车轮
6. `HAS_PORT`
7. `PORT::3111::轮轨纵向机械作用端口::ITM-PHY-006::双向物理`
8. `TERMINATES_AT`
9. `BOUNDARY-RAIL`

证据分别来自正式需求库 V2、冻结需求功能映射、正式 SysML allocation、approved interface instance 和 formal final connection。完整节点与关系证据见 `reports/nebula_real_query_case.json`。

## 播放验收

浏览器自动回放得到的阶段统计：

| 阶段 | 对象 | 关系 |
|---|---:|---:|
| 需求检索 | 1 | 0 |
| 关联功能 | 2 | 1 |
| 架构承接 | 9 | 7 |
| 接口展开 | 15 | 13 |
| 参数与信号 | 32 | 27 |
| 完整路径 | 36 | 35 |

已通过：

- 自动播放完整过程
- 暂停后对象/关系数量保持不变
- 暂停与继续
- 上一步与下一步
- 重播
- 查询全貌和全图视图
- 鼠标滚轮后自动进入自由探索并停止自动镜头
- 节点点击和属性卡
- 关系点击和证据卡
- 邻居展开与反向追溯
- 新查询取消
- CRAWLER 可见状态为 false
- Agent HUD 可见状态为 false

## 性能

1600×900 Chrome 硬件 WebGL 验收：

| 指标 | 融合前工程页 | 融合后 |
|---|---:|---:|
| FPS | 48 | 48 |
| Draw Calls | 143 | 89 |
| Triangles | 14,962 | 10,926 |
| Points | 78,264 | 72,668 |
| Console errors | 0 | 0 |
| Page errors | 0 | 0 |

工程模式隐藏蜘蛛、腿、触须和 Agent HUD 后，Draw Calls 和三角形数量下降；真实工程节点与关系没有因性能优化而删除。两条 `ERR_ABORTED` 分别来自 React StrictMode 清理旧 summary 请求和验收脚本主动执行查询取消，均为预期取消，没有未预期请求失败。

## 构建与保护

- TypeScript：PASS
- Vite production build：PASS
- Neo4j：READ ONLY
- 正式 SysML、FMU、SSP、V2 Excel、仿真结果：未修改
- `/trace`：未替换
- `/knowledge-graph/nebula-native`：保留
- 上游 LICENSE / NOTICE：保留
- 当前开发分支：`feature/nebula-engineering-workbench`

## 能力边界

- 当前图谱没有独立 Logical 实体，无法展示正式 Logical 层。
- Item 是当前参数/信号的正式实体来源；缺少独立实体时只展示 Port 属性。
- 全局总览只对本次已加载的真实查询子图计算视野，没有一次性加载 1058 个节点。
- 场景中的关系线按类型星团聚合；完整单条关系选择位于底部真实关系列表，避免 3D 图面过载。

## 修改文件

- `ui/frontend/src/pages/NebulaEngineeringPage.tsx`
- `ui/frontend/src/pages/nebulaEngineering.css`
- `ui/frontend/src/scenes/nebula/nebulaPlayback.ts`
- `ui/frontend/src/scenes/nebula/nebulaRenderer.ts`
- `ui/frontend/src/scenes/nebula/nebulaAdapter.ts`
- `ui/frontend/src/scenes/nebula/nebulaTypes.ts`
- `ui/frontend/src/components/scenes/NebulaScene.tsx`
- `ui/frontend/scripts/qa-nebula-workbench.mjs`
- `ui/frontend/scripts/create-nebula-comparison.mjs`
- `reports/assets/nebula_engineering_workbench_qa.json`
- `reports/assets/nebula_workbench_stages/*`
- `reports/assets/nebula_engineering_ui_comparison.png`
