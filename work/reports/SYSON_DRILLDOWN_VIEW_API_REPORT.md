# SysON Drill-down View API Report

## 1. 结构修正

旧 `AUTO_IBD_L1`～`L4` 每张都投影整个 closure，L3 有 29 个产品、L4 有 77 个产品，因此不支持从一个产品逐层看其内部。现在正式 IBD identity 是 container product：`ROOT → X000 → X100 → X110` 等。默认计划仅加载 ROOT、X000、X100，其余由 `POST /api/syson/ibd/container` 按点击动态构建。`full_hierarchy_projection` 保留旧四层数据供审计；closure 未裁剪，仍是 93 产品、152 条 directed edges、6 轮 fixed point，原 scope 的 19 Products / 68 Flows 保持。

| Container | 直接子产品 | 内部连接 | 真实边框 Port | 虚拟边框投影 | 外部端点 | 外部连接 |
|---|---:|---:|---:|---:|---:|---:|
| ROOT | 8 | 64 | 0 | 0 | 0 | 0 |
| X000 | 1 | 0 | 0 | 2 | 1 | 6 |
| X100 | 3 | 9 | 0 | 3 | 1 | 4 |

X100 直接子产品：X110、X120、X130。外部端点只显示 8100；真实对端 8122 作为 `actual_endpoint_product_ids` 保留在证据中，未在 X100 内部展开其子树。9 条内部连接均携带真实 connector/flow/interface refs。X100 的 3 个派生边框投影没有可唯一对应的、由 X100 拥有且带同一证据引用的 SysON PortUsage，因此全部是 `VIRTUAL_BOUNDARY_PROJECTION`，仅在本地计划中显示；SysON 未创建任何 Port。若今后索引中出现有明确 connector/interface refs 的真实容器 PortUsage，builder 才会提升为 `REAL_BOUNDARY_PORT` 并使用其真实 object ID。不存在直接 5100↔X100 的虚构 L2 接口。

## 2. Resolver 与元素索引

Explorer 真正使用 `ws://localhost:8080/subscriptions` 的 `explorerEvent` 订阅，`representationId` 形如 `explorer://?treeDescriptionId=...&expandedIds=[...]`。脚本沿 Explorer 文档、Namespace、OwningMembership、Package 展开，读取真实 SysON object ID，生成 `tools/syson_automation/cache/current_element_index.json`。缓存绑定当前 Project、EditingContext 和两份已导入 SysML 文件的合成 fingerprint；Project/EditingContext 变化时从 live Project 查询触发重建。产品代码和需求正式 ID 的别名来自冻结 SysML 中的显式 `productCode`、`requirementID` 属性，未依赖相近名称。

- Element index size：**3649**，其中 ActionDefinition 191、PartDefinition 151、AllocationUsage 191、RequirementUsage 46；正式产品 hierarchy 仍是 147 项。
- 已解析当前 Scope：Function **10/10**，seed Product **8/8**；本地索引包含 191 个 Function 定义和 151 个 PartDefinition。
- `FN_F_3110_01` → `4f835bd6-1684-4535-9ef1-8716f1cab65f`（ActionDefinition）。
- `FN_F_X100_01` → `e9b9e933-036c-44ed-9f80-4c287c7289b6`（ActionDefinition）。
- `REQ-BRK-007` → `cb90511e-f9bd-429f-bbd1-4dfd53891ffe`（RequirementUsage）。
- X100、X110、X111、X112、X121、X123、7211、5311 均解析为唯一真实 PartDefinition object ID；完整表见 `tools/syson_automation/generated/reports/SYSON_ELEMENT_INDEX_REPORT.md`。

原 8 秒超时的原因是旧 global search 请求设置了 `searchInAttributes=true`，引发全属性扫描。`FN_F_3110_01` 在该路径的 5 秒和 15 秒探测都超时；设为 `false` 后指定 Function 的精确搜索约 0.1 秒成功。宽泛的 `FunctionDefinitions` 即使关闭属性搜索，在 5 秒与 15 秒仍可超时，因此最终 resolver 优先级是 **当前元素索引 → Explorer 树重建 → 仅标签 global search fallback**。`TIMEOUT` 与 `NOT_FOUND` 分别返回，基准 29 次运行详见 `tools/syson_automation/generated/reports/SYSON_RESOLVER_BENCHMARK.md`。

## 3. Representation description inventory

live `representationDescriptions(objectId)` 对 ActionDefinition、RequirementUsage、PartDefinition、Package 均返回 General View、Action Flow View、Interconnection View、Requirements Table View、State Transition View 共五种。General View description ID：`siriusComponents://representationDescription?kind=diagramDescription&sourceKind=view&sourceId=8dcd14b0-6259-3193-ad2c-743f394c68e4&sourceElementId=db495705-e917-319b-af55-a32ad63f4089`；Interconnection View description ID：`siriusComponents://representationDescription?kind=diagramDescription&sourceKind=view&sourceId=74c5d045-51d7-359f-9634-611d0f1bef3d&sourceElementId=e1bd3b6d-357b-3068-b2e9-e0c1e19d6856`。创建参数由 live schema 确认：`id`、`editingContextId`、`objectId`、`representationDescriptionId`、`representationName`。原有两张 `view1` 使用 General View；完整 inventory 见 `tools/syson_automation/generated/reports/representation_description_inventory.json`。

## 4. 真实 mutation 与 query-back

SysON Project `3e060c9b-36ee-43c5-b6cb-1448c230bce7`；EditingContext `967a4588-11d1-435d-ba59-2412f2e63002`。每次创建使用稳定名称和本地 ownership registry；仅 `AUTO_` 且登记为 `syson_automation` 的图允许更新。实际向已有模型图添加语义对象的操作是 `dropOnDiagram`。`dropNodes` 是图内拖动工具，不能用于添加模型树对象。

| View | Representation ID | Kind | Query-back 节点 | Query-back 边 | 状态 |
|---|---|---|---:|---:|---|
| `AUTO_API_SMOKE_TEST` | `191435ec-48f2-4958-83f1-06948e88eb0d` | General View | 2 个真实 Function | 0 | CREATED |
| `AUTO_REQ_6289f72770e3` | `372ff54d-3b0e-4f08-b271-91f96209722d` | General View | 5 个真实 Requirement | 0 | CREATED |
| `AUTO_FP_6289f72770e3` | `db7ce4b0-9272-4847-8afe-ac4e0379596f` | General View | 5 Function + 5 Product + 5 真实 AllocationUsage | 0 | CREATED |
| `AUTO_IBD_ROOT_6289f72770e3` | `3fbaed54-7cf8-4756-a22a-c643e4ca1c4f` | Interconnection View | 8 个 L1 Product | 0 | CREATED |
| `AUTO_IBD_X000_6289f72770e3` | `7792b02d-60e4-436c-87a7-b2dee94db2fa` | Interconnection View | 1 个 child + 1 个外部端点 | 0 | CREATED |
| `AUTO_IBD_X100_6289f72770e3` | `668d136a-c4e4-4b49-a3ce-7b2147e8f5aa` | Interconnection View | 3 个 child + 8100 外部端点 | 0 | CREATED |

6 张 AUTO_ representation 均重新订阅 `diagramEvent` 核验目标 object ID，`arrangeAll` 在首次填充时成功。用户原有两张 `view1` 的 ID 仍为 `a4bea9d1-a489-4e50-874f-67170636bfbc`、`31dde202-6ea5-48ca-b9f5-3a1794e9d61f`，节点数分别仍为 3、0；未更新。`/api/syson/views/generate` 最终返回 `CREATED 5/5`；再次请求 mutation 数 **0**，证实复用。

`mutations_attempted=true`。本轮审计日志共有 **33 次**实际 GraphQL mutation 调用：`createRepresentation` 6、`dropOnDiagram` 9、`arrangeAll` 17、一次未成功的 `dropNodes` 探测。首次 smoke 创建虽 HTTP 超时，后续从 SysON 查询出真实 representation；Requirement 创建曾因查询 mutation 返回中的嵌套 `description` 字段触发服务器错误，但创建已提交并经 query-back 验证。两处已通过精简查询字段修复。操作日志在 `tools/syson_automation/generated/syson_operations/`，无凭据。

当前图中边数均为 0：General View 将真实 AllocationUsage 绘为语义节点，未以连线显示 Function→Product allocation；Interconnection View 也未自动生成由叶级 connector 投影而来的父级连线。**LOCAL_PLAN_FULL** 在 X100 为 9 条内部连接、4 条外部连接和 3 个虚拟边框投影；**SYSON_SEMANTIC_RENDERABLE** 为 4 个真实产品节点、0 条可验证图形边。未为了补画而创建语义 Port、Connector 或 Allocation。正式 View 创建成功与“全部关系已图形化”是不同的验收项。

## 5. 校验与冻结资产

- 单元测试：`python -m unittest tools.syson_automation.tests.test_hierarchical_ibd tools.syson_automation.tests.test_container_ibd -q` → **25 PASS**。
- 前端 `npm run build` → **PASS**。后端 `/openapi.json` 与前端 `http://127.0.0.1:5173/` 均返回 HTTP 200。
- 冻结 SysML SHA-256：`a15cf7170dc5458738080a146c391e438fe57b85f9687857f34a081b8efdf0d5`。
- 正式需求 V2 Excel SHA-256：`496736980a493689339eb35df85ec9603f5f9d0fa5e484ef049f990bf0829f01`。
- 失败的正式 View：**0**。尚未图形化的关系：FP allocation 连线与 container IBD 投影连线；完整真实证据留在本地计划和 SysON 真实 AllocationUsage 节点中。
