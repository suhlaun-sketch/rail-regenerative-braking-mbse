# Requirement Library V2 Expansion Audit

## Results

- Original requirements: 34; newly derived: 12; total: 46.
- Real SysML Functions: 191; Function → OWNER Product source allocations: 191.
- Unique Functions with requirement upstream: 191/191; unresolved: 0.
- Function audit classifications: existing requirement 75; derived requirement 103; implementation support 13; unresolved 0.
- Requirement coverage: FULL 26; PARTIAL 20; SUPPORTING_ONLY 0.
- Requirement → Function relations: 289; average 6.28 per requirement.
- Search fields: 551 keywords; 358 synonyms; 249 user phrases; 10 topic clusters; 2291 term-to-requirement index rows.
- New requirements use `ENGINEERING_DERIVED`, have blank standard fields, and cite only the frozen SysML Functions and their real allocations. No standard number, clause, standard quotation or SysML model object was added.
- For original 34 records, Requirement_ID, Standard_No, Standard_Clause, Requirement_Type, Source_Type, Text, and Criteria were compared against v1 and kept unchanged.
- Function coverage labels describe traceability source type, not verification status. Original `Verification_Status` values are preserved; all new derived requirements are `NOT_VERIFIED`.
- `IMPLEMENTATION_SUPPORT` rows inherit listed parent Requirement context and do not assert a separate direct satisfaction relation.

## Added engineering-derived requirements

| ID | Name | Function count | Parent requirements |
|---|---|---:|---|
| DRV-TRAC-001 | 牵引传动机械能传递 | 10 | REQ-TRAC-001；REQ-TRAC-004 |
| DRV-TRAC-002 | 黏着增强撒砂控制 | 7 | REQ-TRAC-003；REQ-BRK-010 |
| DRV-PWR-001 | 高压受流与分配控制 | 21 | PRJ-PWR-001 |
| DRV-PWR-002 | 牵引回流与接地通路 | 5 | PRJ-PWR-001 |
| DRV-PWR-003 | 主变压器控制与状态监测 | 6 | PRJ-PWR-001；REQ-TRAC-004 |
| DRV-TRAC-003 | 牵引变流器控制与保护状态 | 13 | REQ-TRAC-001；REQ-TRAC-002；REQ-TRAC-004 |
| DRV-TRAC-004 | 中间直流环节预充与放电保护 | 10 | REQ-TRAC-004；PRJ-PWR-001 |
| DRV-BRK-001 | 制动供风与总风管压力可用性 | 7 | REQ-BRK-001；REQ-BRK-012 |
| DRV-BRK-002 | 气动压力分配与机械制动执行 | 17 | REQ-BRK-001；REQ-BRK-004；REQ-BRK-013 |
| DRV-CTL-001 | 司机操纵与ATP控制边界输入 | 10 | REQ-TRAC-002；REQ-BRK-001；REQ-BRK-002 |
| DRV-CTL-002 | 车载控制单元协调与状态报告 | 17 | REQ-TRAC-002；REQ-BRK-014；REQ-ENE-003 |
| DRV-CTL-003 | 牵引与高压安全回路逻辑及状态 | 7 | REQ-BRK-014；REQ-BRK-015；REQ-TRAC-003 |

## Function coverage audit

| Coverage type | Functions |
|---|---:|
| EXISTING_REQUIREMENT | 75 |
| DERIVED_REQUIREMENT | 103 |
| IMPLEMENTATION_SUPPORT | 13 |
| UNRESOLVED | 0 |

### Unresolved Functions

- None; all 191 Functions have either direct requirement links or an explicit implementation-support parent.

## Search-index acceptance

| Query | Status | Result count | Expected IDs present |
|---|---|---:|---|
| 我想看制动系统 | PASS | 19 | YES |
| 我想看再生制动 | PASS | 24 | YES |
| 制动的电去哪了 | PASS | 24 | YES |
| 机械制动什么时候介入 | PASS | 19 | YES |
| 储能坏了怎么办 | PASS | 13 | YES |
| 超级电容 | PASS | 13 | YES |
| 超级电容SOC上限 (focused) | PASS | 13 | PRJ-ENE-002, PRJ-ENE-004, REQ-ENE-003 in top 8; unrelated top 5=0 |

Query verification uses a bounded lexical check over the exported weighted term index; it validates one-to-many recall and focused topicality, and does not change the UI/Qwen matching algorithm.

## Output files

- `Req/牵引制动能量回收系统_正式需求库_v2_扩展版.xlsx` (created by the Artifact Tool workbook builder).
- `ui/backend/data/semantic_slice/requirement_catalog_v2.json`.
- `ui/backend/data/semantic_slice/requirement_function_map_v2.json`.
- `ui/backend/data/semantic_slice/requirement_search_index_v2.json`.
- `ui/backend/data/semantic_slice/requirement_topic_clusters.json`.
- `ui/backend/data/semantic_slice/function_requirement_coverage_v2.json`.
- Frozen SysML SHA-256 was checked by the upstream traceability validation; no frozen asset was written.
