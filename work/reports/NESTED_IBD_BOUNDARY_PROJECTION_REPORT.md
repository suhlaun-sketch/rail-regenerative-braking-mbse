# Nested IBD Boundary Projection Report

## 实现结果

已把层级 IBD 从仅按目标层聚合产品对，改为基于真实 Product hierarchy 路径的嵌套投影。原始 flow/connector 边被分配到其最低共同产品容器：同一父产品下的子产品关系进入该层 `internal_connections`；跨越顶层产品的关系进入边框端口间的 `external_connections`。经过的每级父边框生成 `boundary_ports` 与 `boundary_links`，并沿用原边的 interface、flow、connector refs。边框端口为 IBD plan 内的视图投影，不新增 SysML 元素。

每个 IBD view 现在包含 `view_id`、`level`、结构化 `products`、`internal_connections`、`boundary_ports`、`boundary_links`、`external_connections` 和 `evidence_summary`。连接记录保留 source/target product 与 element ID、三类证据 refs 和 `evidence_type`。有 connector ref 的边分类为 `EXPLICIT_CONNECTOR`；仅有 flow/interface 的边分类为 `EXPLICIT_FLOW`；投影边界连接分类为 `DERIVED_BOUNDARY`。缺少真实证据 refs 的边会被拒绝，不产生无证据连线。

旧 `projected_interactions`、`product_ids` 和 19 个旧 scope products / 68 个旧 scope flows 仍保留兼容；不再按产品对创建 view。Task Slice 的每层摘要展示产品、内部连接、边框端口、边框链接、外部连接及证据类型统计。

## 当前 query 统计

Query：`分析再生制动时超级电容储能相关的需求、功能和接口`

- Requirements 5；Functions 10；原 scope Products 19；原 scope Flows 68。
- Seed products 8；closure products 93；closure edges 152；hierarchy levels 1–4。
- 分层 views 4 张；产品闭包与功能 owner allocation 逻辑未改。

| View | 产品 | 内部连接 | 边框端口 | 边框链接 | 外部连接 | 证据类型统计 |
|---|---:|---:|---:|---:|---:|---|
| L1 | 8 | 19 | 20 | 20 | 64 | EXPLICIT_CONNECTOR 19; DERIVED_BOUNDARY 84 |
| L2 | 15 | 40 | 37 | 37 | 0 | EXPLICIT_CONNECTOR 40; DERIVED_BOUNDARY 37 |
| L3 | 29 | 29 | 96 | 96 | 0 | EXPLICIT_CONNECTOR 29; DERIVED_BOUNDARY 96 |
| L4 | 77 | 0 | 0 | 0 | 0 | 无连接落在 L4 容器层；L4 子组件间关系在其共同父层表达 |
| **合计** | **129** | **88** | **153** | **153** | **64** | **EXPLICIT_CONNECTOR 88; DERIVED_BOUNDARY 217** |

`evidence_summary.evidence_type_counts` 统计连接/边界链接；端口本身复用其支撑关系的 refs，不重复计入类型统计。当前模型边均包含显式 connector refs，因此此次真实 query 未产生 `EXPLICIT_FLOW` 边；分类器支持仅有 flow/interface refs 的数据。

## 校验与冻结资产

- `python -m unittest tools.syson_automation.tests.test_hierarchical_ibd -q`：19 tests PASS（含 EXPLICIT_FLOW 分类与无证据边拒绝）。
- `ui/frontend` `npm run build`：PASS；Vite 完成 3868 modules transform。构建只输出既有的大 chunk 提示。
- 冻结 SysML SHA-256 仍为 `a15cf7170dc5458738080a146c391e438fe57b85f9687857f34a081b8efdf0d5`。
- V2 Excel SHA-256 仍为 `496736980a493689339eb35df85ec9603f5f9d0fa5e484ef049f990bf0829f01`。
- SysON mutation：未调用。现有 view 未创建。当前已知前置阻塞是 SysON `editingContext.search` 对精确 Function 锚点查询超时（8 秒）；生成器会在任何 mutation 之前返回 `BLOCKED`，所以本次只更新并验证本地 plan。

## 修改文件

- `tools/syson_automation/src/nested_ibd_builder.py`（新增）
- `tools/syson_automation/src/ibd_hierarchy_builder.py`
- `tools/syson_automation/src/models.py`
- `tools/syson_automation/tests/test_hierarchical_ibd.py`
- `ui/frontend/src/pages/TaskSlicePage.tsx`


- 本地运行时 API：重启后端后 POST /api/syson/scope 返回 4 张带结构化字段的 IBD view；L1 返回 8 产品、19 内部连接、20 边框端口、20 边框链接、64 外部连接。
