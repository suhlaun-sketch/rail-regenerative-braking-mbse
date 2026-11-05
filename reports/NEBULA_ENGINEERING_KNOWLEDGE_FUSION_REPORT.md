# NEBULA 真实工程知识融合与查询驱动关系展开报告

日期：2026-11-05
独立测试路由：`http://127.0.0.1:5173/knowledge-graph/nebula-engineering`

## 结论

原生 NEBULA 渲染器已接入本机 `motor-brake-system` Neo4j 图谱。工程问题会先检索真实实体，再按 Neo4j 返回的真实关系逐条展开。星团布局、78,264 个粒子、星核、轨道、CRAWLER、镜头和 bloom 后处理保持不变。

工程模式会停止原版固定演示状态机和随机任务关系。节点激活、持久关系线、流星高亮、CRAWLER 跳转、右侧证据和底部展开记录均由当前查询结果驱动。

## Neo4j 只读审计

连接验证：`verify_connectivity()` 和 `RETURN 1` 均通过。服务使用 `default_access_mode=READ`，新增查询只包含 `MATCH / RETURN`。

真实 KG V2 实体：

| 标签 | 数量 | NEBULA 表达 |
|---|---:|---|
| Requirement | 46 | 需求星团 |
| Function | 191 | 功能星团 |
| Product | 147 | 产品架构星团 |
| Port | 517 | 接口星团 |
| Item | 144 | 传递项星团 |
| PhysicalNet | 9 | 物理网络星团 |
| ExternalBoundary | 3 | 外部物理边界星团 |
| Profile | 1 | 证据/配置星团 |

图谱没有 `Logical`、`LogicalComponent` 或其他正式逻辑实体标签。页面明确显示 `Logical = 0 · 无正式实体`，没有把 Product、Port 或名称相近对象改名为 Logical。

展示层映射：

- Requirement：Neo4j `Requirement`
- Function：Neo4j `Function`
- Logical：空；保留正式缺口
- Architecture：Neo4j `Product / Port / Item`
- Physical：Neo4j `PhysicalNet / ExternalBoundary`

真实关系类型包括 `TRACE_TO_FUNCTION`、`SUPPORTS_IMPLEMENTATION`、`ALLOCATED_TO`、`PARTICIPATES_IN`、`USES_PORT`、`HAS_PORT`、`EXPOSES`、`CONNECTS_TO`、`DERIVED_CONNECTS_TO`、`TERMINATES_AT`、`CONNECTED_VIA`、`CONNECTS`、`CONTAINS`、`DERIVED_FROM`。

完整审计数据见 `reports/nebula_kg_schema_audit.json`。

## 独立工程数据适配层

`nebulaAdapter.ts` 负责：

- GraphQL `GraphNode / GraphEdge` 到 NEBULA 节点、星团和关系的转换
- 节点类型到固定星团的映射
- 基于真实节点 ID 的稳定槽位哈希，重复查询不会随机重排
- 节点和边去重
- 环路防护
- 有界主链排序
- 正式模型、证据派生、AI 候选、仿真执行关系分类

关系颜色：

- `FORMAL_MODEL`：青色
- `EVIDENCE_DERIVED`：紫色
- `AI_CANDIDATE`：粉色
- `SIMULATION_EXECUTION`：金色

当前图谱没有 `PREDICTED / AI / LLM` 关系，因此 AI 候选数量真实为 0，没有生成示例候选。

## 查询与交互

支持：

1. 主链模式：问题 → Requirement 种子 → 真实结构化追溯
2. 邻居展开：从任意已选节点继续获取一层真实邻居
3. 反向追溯：沿有向工程关系回查到 Requirement
4. 场景内节点标签点击
5. 节点清单和关系清单点击
6. 查询取消
7. 24 / 36 / 60 / 80 节点上限
8. 重复节点和重复边合并
9. 循环路径 visited 防护
10. Neo4j 不可用时保留空星云并显示不可用状态

反向追溯新增 GraphQL 字段 `reverseTrace(nodeId, maxNodes)`。查询只沿已存在、方向正确且 `kg_v2=true` 的关系返回路径。

## 真实验收案例

输入：`常用制动平均减速度需求`

种子：

- `Requirement REQ-BRK-001`
- 名称：常用制动平均减速度需求
- 来源：`Req/牵引制动能量回收系统_正式需求库_v2_扩展版.xlsx`

完整真实路径：

1. `REQ-BRK-001` — `TRACE_TO_FUNCTION` → `FN_F_3111_01`
2. `FN_F_3111_01` — `ALLOCATED_TO` → `3111`
3. `3111` — `HAS_PORT` → `PORT::3111::轮轨纵向机械作用端口::ITM-PHY-006::双向物理`
4. 该 Port — `TERMINATES_AT` → `BOUNDARY-RAIL`

节点：

- Function `FN_F_3111_01`：通过车轮耗散能量
- Product `3111`：车轮
- Port：轮轨纵向机械作用端口
- ExternalBoundary `BOUNDARY-RAIL`：Rail mechanical and traction-return boundary

关系证据：

- `TRACE_TO_FUNCTION`：`requirement_function_map_v2.json`，`FROZEN_V2`
- `ALLOCATED_TO`：正式 SysML `Rail_MBSE_Full_v1.sysml:11161`，`AUTHORITATIVE`
- `HAS_PORT`：`cleaned_ports.json`，`AUTHORITATIVE`
- `TERMINATES_AT`：`final_connections.json`，`AUTHORITATIVE`

完整 ID、来源、证据文本和状态见 `reports/nebula_real_query_case.json`。

浏览器主链受 36 节点上限控制，实际工程模式内部为 36 nodes / 32 relations，包含 Requirement、Function、Product、Port、Item、ExternalBoundary；场景清单为减少遮挡只显示前 28 个节点卡片，星云内仍承载全部 36 个稳定节点标签。

## 动画同步

- 每加入一个真实节点，目标星团立即激活
- 每加入一条真实关系，持久关系线进入场景
- 关系同时触发对应颜色的流星
- CRAWLER 从关系源星团跳向目标星团
- 当前节点和当前关系高亮状态与证据面板同步
- 工程模式不运行原固定任务、随机交接或模拟关系

## 测试结果

后端烟测：`NEBULA_ENGINEERING_SMOKE = 4/4`

- Neo4j connectivity / read-only：PASS
- 真实 Requirement 搜索：PASS
- Requirement → Physical 证据链：PASS
- bounded reverse trace：PASS

浏览器验收：PASS

- 主链查询：PASS
- 场景内真实节点点击：PASS
- 邻居展开：PASS
- 反向追溯：PASS
- 关系来源证据：PASS
- 查询取消：PASS
- 节点上限：PASS
- 控制台错误：0
- 页面错误：0
- 请求失败：0

WebGL 指标：

- Points：78,264
- Draw calls：143
- Rendered triangles：14,962
- 验收时 FPS：48

生产构建：PASS，NEBULA 工程页面保持独立懒加载。

## 产物

- `reports/assets/nebula_engineering_real_query_1600x900.png`
- `reports/assets/nebula_engineering_interaction_1600x900.png`
- `reports/assets/nebula_engineering_qa.json`
- `reports/nebula_kg_schema_audit.json`
- `reports/nebula_real_query_case.json`

## 主要文件

新增：

- `ui/frontend/src/pages/NebulaEngineeringPage.tsx`
- `ui/frontend/src/pages/nebulaEngineering.css`
- `ui/frontend/src/scenes/nebula/nebulaAdapter.ts`
- `ui/frontend/scripts/qa-nebula-engineering.mjs`
- `ui/backend/tests/nebula_engineering_smoke_test.py`

修改：

- `ui/frontend/src/scenes/nebula/nebulaRenderer.ts`
- `ui/frontend/src/scenes/nebula/nebulaTypes.ts`
- `ui/frontend/src/components/scenes/NebulaScene.tsx`
- `ui/frontend/src/api/knowledgeGraph.ts`
- `ui/frontend/src/App.tsx`
- `ui/backend/app/kg_v2_query_service.py`
- `ui/backend/app/graphql_schema.py`

正式 `/trace` 入口和旧 `KnowledgeNebulaGraph.tsx` 仍未替换。本阶段继续使用独立测试路由。

## Git 状态

开发分支：`feature/nebula-real-kg`。

本地仓库开始本轮时没有任何提交，`main` 是 unborn branch，全部既有工程文件均为未跟踪状态。本轮只暂存 NEBULA 两阶段运行所需代码、只读 API、测试、许可证和报告，未清理或覆盖其他本地资产。

GitHub 直连在提交前两次失败：`Failed to connect to github.com port 443`。本地提交完成后继续重试正常推送；不使用 `--force`，不写入 `main`。
