# KG Import Report

## 执行结论

- 执行日期：2026-09-08（Asia/Shanghai）
- URI：`neo4j://127.0.0.1:7687`
- database：`motor-brake-system`
- authentication：PASS
- driver connectivity：PASS
- database existence/access：PASS（`SHOW DATABASES` 已列出目标数据库，且目标库查询成功）
- 完整 pipeline：已连续执行两次；两次均实际完成抽取、schema 初始化、Product/Item/Profile/CONTAINS/EXPOSES UPSERT 和 KG QA
- 全部 KG QA：PASS
- 幂等性：PASS（第二次运行未增加任何受管节点或关系）

运行中发现抽取器曾将全部 `profile_active` 硬编码为 `true`，导致第一次试运行得到 Active/Inactive=`517/0`。已依据既有 `interface_layer_audit.md` 中确认的 6 条 DC Variant 修复为 `511/6`。未修改层级模型、Item、Raw Port、PortType、InterfaceType 或 `graph_schema`。

## Neo4j 实际数据库计数

以下结果均来自 pipeline 写入后的 Neo4j 实际回查，不是离线 JSON 推算。

| 指标 | 第一次完整运行后 | 第二次完整运行后 | 差值 |
|---|---:|---:|---:|
| Product | 147 | 147 | 0 |
| level 1 | 8 | 8 | 0 |
| level 2 | 16 | 16 | 0 |
| level 3 | 34 | 34 | 0 |
| level 4 | 89 | 89 | 0 |
| standard_299 | 120 | 120 | 0 |
| project_extension | 25 | 25 | 0 |
| external_system | 2 | 2 | 0 |
| selected leaf | 90 | 90 | 0 |
| Item | 144 | 144 | 0 |
| Profile | 1 | 1 | 0 |
| CONTAINS | 139 | 139 | 0 |
| EXPOSES | 517 | 517 | 0 |
| Active EXPOSES | 511 | 511 | 0 |
| Inactive EXPOSES | 6 | 6 | 0 |
| Port 节点 | 0 | 0 | 0 |

## KG QA

| 检查项 | Neo4j 实际结果 | 结论 |
|---|---:|---|
| 计数与确认基线逐项一致 | 全部一致 | PASS |
| 离线 graph_data 与 Neo4j 受管计数一致 | 一致 | PASS |
| E100 状态 | `level=2, leaf=true` | PASS |
| 带 EXPOSES 的非叶 Product 数量 | 0 | PASS |
| EXPOSES 端点不是 Product→Item 的数量 | 0 | PASS |
| CONTAINS 端点不是 Product→Product 的数量 | 0 | PASS |
| Product code 重复组 | 0 | PASS |
| Item item_code 重复组 | 0 | PASS |
| Profile profile_id 重复组 | 0 | PASS |
| CONTAINS relation_id 重复组 | 0 | PASS |
| EXPOSES port_id 重复组 | 0 | PASS |
| 外部 project_id 的受管节点 | 0 | PASS |
| 外部 project_id 的受管关系 | 0 | PASS |
| Port 节点 | 0 | PASS |
| CONNECTS_TO 关系 | 0 | PASS |
| 离线单元测试 | 1/1 通过 | PASS |

## `kg_validation_queries.cypher` 关键查询实跑结果

对原文件查询执行了等价的只读聚合 Cypher，以保留可核对的实际返回数量。

| 查询 | 实际返回数量 |
|---|---:|
| `5000` CONTAINS 层级节点（含根） | 19 |
| `5311` EXPOSES | 6 |
| `旋转机械能` Item 的 EXPOSES | 15 |
| 当前 Profile Active 物理 EXPOSES | 134 |
| 当前 Profile Inactive EXPOSES | 6 |
| `X000` CONTAINS 层级节点（含根） | 15 |
| `ITM-PHY-003` 的 EXPOSES | 7 |
| `MATCH (n:Port) RETURN count(n)` | 0 |

## 幂等性证据

- 第一次回查快照：`tools/kg_pipeline/work/first_run_qa.json`
- 第二次回查快照：`tools/kg_pipeline/work/second_run_qa.json`
- 两个快照的 `actual` 对象逐字段相等：`true`
- 第二次执行后的全部节点/关系差值均为 0，因此幂等性 PASS。

本次未生成 `CONNECTS_TO`、Connection、Connection Candidate、GraphRAG 候选、SysML、XMI、SSD 或 Simulink 连接。
