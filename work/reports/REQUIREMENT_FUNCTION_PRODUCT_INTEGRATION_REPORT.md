# Requirement–Function–Product Integration Report

Generated: 2026-09-22

## Implementation

The existing MBSE workbench now includes a requirements semantic entry that resolves a natural-language question to formal Requirements, then follows local, inspectable mappings to SysML Functions and Products. The LLM is limited to reranking candidate Requirement IDs. Function and Product facts always come from local catalogs.

## Sources read

- `Req/牵引制动能量回收系统_正式需求库_v1.xlsx`: all six sheets were read; `正式需求库` supplies the authoritative 34 requirements and `Codex导入视图` is cross-checked by ID.
- `work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml`: supplies 191 allocated Functions, 147 Products and 191 formal allocation relations.
- Existing `model_graph_service` and Task Slice APIs provide the downstream model projection.

## Data counts

- Requirements: 34
- Functions: 191
- Products: 147
- Requirement → Function relations: 96
- Function → Product relations: 191
- Unresolved Requirements: 0
- Functions without Product allocation: 0
- VERIFIED / PARTIALLY_VERIFIED / NOT_VERIFIED: 6 / 11 / 17

The 93 rule-based Requirement → Function relations are deterministic local suggestions with source evidence. Their confidence values are semantic-ranking values, not V&V conclusions. Three relations come directly from `known_function_id` and are marked `EXPLICIT`.

## APIs

- `POST /api/semantic/query`
- `GET /api/semantic/catalog`
- `GET /api/semantic/status`
- `GET /api/semantic/requirements`
- `GET /api/semantic/functions`
- `GET /api/semantic/products`
- `GET /api/semantic/requirement/{requirement_id}`
- `GET /api/semantic/function/{function_id}`
- `GET /api/semantic/product/{product_id}`

## Qwen and local fallback

`QWEN_ENABLED=false` is the delivered state. The local matcher remains fully usable without an API key. When enabled later, Qwen receives only the local Top-K Requirement candidates and may return only IDs in that candidate set. Timeouts, HTTP failures, rate limits and invalid JSON fall back to `LOCAL_FALLBACK` with HTTP 200.

## Frontend

The new `/semantic` page is integrated into the existing sidebar and project overview. It includes the natural-language search, Broad/Focused scope, dynamic metrics, an interactive Requirement → Function → Product graph, three result columns, complete catalogs, filters, evidence drawers, Task Slice navigation and SysML focus navigation.

## Query validation

| Query | Scope | Result summary |
| --- | --- | --- |
| 我想看制动系统 | broad | Multiple braking requirements; mechanical and coordinated braking Functions and Products |
| 我想看再生制动 | focused | `REQ-BRK-007`; `FN_F_X100_01`, `FN_F_7211_02`; `X100`, `7211` |
| 我想看能量回收 | broad | Energy-storage Requirements and X100-family Functions and Products |
| 我只想看X100 | focused | X100-linked formal requirements and `FN_F_X100_01` → `X100` |
| 我想看牵引系统 | broad | Traction-domain Requirements and allocated traction Products |
| 我想看制动时为什么需要机械制动 | focused | `REQ-BRK-009` and dual-braking Requirements with mechanical braking Functions |
| 制动产生的能量是怎么进入超级电容的 | focused | `PRJ-ENE-001`, `REQ-ENE-001` → `FN_F_X100_01` → `X100`/`X121` |
| 今天天气怎么样 | focused | Empty result; no unrelated engineering entity is invented |

## Files

Added: semantic data build script, ten semantic JSON files, semantic/LLM services, semantic API router, semantic HTTP test, frontend semantic API, trace graph and semantic page.

Modified: backend requirements/config/main/model graph cache version; frontend router, overview, Task Slice query-param intake, SysML focus intake and shared styles.

## Known limits

- Qwen cannot be exercised until the user supplies an account-specific endpoint and API key.
- Rule-based Requirement → Function relations are traceable semantic mappings, not newly validated SysML relations.
- Neo4j is independent of this feature and was unavailable in the current local environment.
