# SSI All16 Integration Report

## Authoritative input

- Full SysML: `C:\Users\AUSA\Desktop\牵引制动能量回收\work\sysmlv2\full_engineering_model\01_generated\Rail_MBSE_Full_v1.sysml`
- Baseline SHA-256: `a15cf7170dc5458738080a146c391e438fe57b85f9687857f34a081b8efdf0d5`
- Original Full SysML modified: **NO**
- Author SSI source modified: **NO**

## Automatic L2 discovery

- L2 products discovered from `05_ProductDefinitions.sysml`: **16**
- Inventory: `All16_L2_Inventory.md`
- Codes: 3100, 3500, 3600, 3800, 4100, 4200, 4400, 4500, 5100, 5300, 7100, 7200, 8100, D100, E100, X100

## Projection

- Directory: `..\02_projection_all16`
- Components: **16**
- Promoted ports: **138**
- Interface definitions: **51**
- Cross-L2 Final Connections: **74**
- Same-L2 connections excluded from the boundary projection: **110**
- Created relationships: **0**
- Source trace: `..\02_projection_all16\projection_manifest.json`

Each promoted port record preserves its original leaf code, raw port ID/name, Full SysML path, item, direction, active state, participating Connection IDs, and Excel sheet/row when present in the frozen traceability mapping.

## Original SSI_v1.0.0 execution

- Entry: `third_party\ssi_transformer\Standard-System-Interface\source\SSI_transformer.py`
- Components parsed: **16**
- Ports parsed: **138**
- Interface definitions parsed: **51**
- Connections parsed: **74**
- `validate_connections()` errors: **0**
- Author parser/generator source diff: **none**

## Generated SSD

- File: `..\03_ssd\Rail_MBSE_L2_All16_v1.ssd`
- System count: **1**
- Component count: **16**
- Connector count: **138**
- Connection count: **74**
- DefaultExperiment startTime: **0.0**
- DefaultExperiment stopTime: **10.0**
- Component mapping: **16/16**
- Port mapping: **138/138**
- Connection mapping: **74/74**
- Mapping: `..\03_ssd\Rail_MBSE_L2_All16_v1_mapping.json`
- Execution record: `..\04_logs\ssi_all16_run_result.json`

## Result

`RAIL_L2_ALL16_TO_SSI = PASS`
