# Rail MBSE Toolchain Status

## Authoritative Data

- Primary Excel: `C:\Users\AUSA\Desktop\牵引制动能量回收\Rail_MBSE_Function_Interface_v1_final.xlsx`
- Full SysML: `C:\Users\AUSA\Desktop\牵引制动能量回收\work\sysmlv2\full_engineering_model\01_generated\Rail_MBSE_Full_v1.sysml`
- Full SysML SHA-256: `a15cf7170dc5458738080a146c391e438fe57b85f9687857f34a081b8efdf0d5`
- Products: 147
- Items: 144
- Raw Ports: 517
- Functions: 191
- Allocations: 191
- Connections: 184
- Physical Nets: 9

## Official SysML Validation

- Official Pilot Version: 0.59.0
- Syntax Errors: 0
- Semantic Errors: 0
- Warnings: 0
- Status: **PASS**

## SSI

- SSI Version: SSI_v1.0.0
- SSI Repository: `C:\Users\AUSA\Desktop\牵引制动能量回收\third_party\ssi_transformer\Standard-System-Interface`
- Commit: `ad6cae115d05a0fb45dada962fed5b0d9eed61ac`
- Author Source Modified: **NO**
- All16 Projection: **PASS**
- L2 Components: 16/16
- Promoted Ports: 138
- Interface Definitions: 51
- Cross-L2 Connections: 74
- SSI Validation Errors: 0
- SSD: `C:\Users\AUSA\Desktop\牵引制动能量回收\work\sysmlv2\ssi_integration\03_ssd\Rail_MBSE_L2_All16_v1.ssd`
- SSD Components: 16
- SSD Connectors: 138
- SSD Connections: 74
- Component Mapping: 16/16
- Port Mapping: 138/138
- Connection Mapping: 74/74
- **RAIL_L2_ALL16_TO_SSI = PASS**

## SysIDE

- Version: 0.10.3
- Standard Library: `C:\Users\AUSA\Desktop\牵引制动能量回收\work\sysmlv2\syside_integration\config\syside-0.10.3\share\sysml.library`
- Files Parsed: 1
- Syntax Diagnostics: 0
- Semantic Diagnostics: 0
- Warnings: 0
- Unsupported Constructs: 0 reported
- **SYSIDE_FULL_RAIL = PASS**

## SysON

- Version: v2026.7.0
- Deployment Method: Official Eclipse SysON application JAR + PostgreSQL 15.19
- URL: http://localhost:8080
- Project ID: `4db1e0e8-09cd-45e3-b97f-562eb6ae3cdf`
- Full SysML Import: **PASS**
- Semantic Projection: **NOT_NEEDED**
- Visualization-only Projection: **GENERATED**
- Persisted Views: 76/76
- Actual SVG Exports: 76/76
- Valid SVG Envelopes: 76/76 (1229909881 bytes)
- Products Visualized: 147/147
- Ports Visualized: 517/517
- Functions Visualized: 191/191
- Allocations Visualized: 191/191
- Connections Visualized: 184/184
- Physical Nets Visualized: 9/9
- L2 Detailed Views: 16/16
- Full Architecture Overview: PASS
- Full L2 Interface Overview: PASS
- Regenerative Braking View: PASS
- Actual diagram edges: allocations 191, final connections 184, physical nets 9, L2 boundary 74
- **SYSON_FULL_RAIL_VISUALIZATION = PASS**

## Integrity

- Original Excel Modified: **NO**
- Original Full SysML Modified: **NO**
- Original Final Connections Modified: **NO**
- Author SSI Source Modified: **NO**
- Second Manually Maintained SysML Model Created: **NO**
- SysON visualization projection: generated, traceable, derived-only

## Unified Toolchain

```text
Rail_MBSE_Function_Interface_v1_final.xlsx
        ↓
Full Rail SysML v2
        ↓
Official SysML v2 Pilot Validation
        ↓
        ├──────── SysIDE
        │         Full textual/model validation
        │
        ├──────── SysON
        │         Full graphical model visualization
        │
        └──────── SSI-compatible L2 Projection
                  ↓
             Original SSI Transformer
                  ↓
             All16 SSD
                  ↓
          [NEXT STAGE: Simulation]
```

SysIDE, SysON, and SSI are independent consumers of the same authoritative `Rail_MBSE_Full_v1.sysml`; none is a second authoritative model.

## Final Status

- OFFICIAL_SYSML_V2 = PASS
- RAIL_L2_ALL16_TO_SSI = PASS
- SYSIDE_FULL_RAIL = PASS
- SYSON_FULL_RAIL_VISUALIZATION = PASS
- ORIGINAL_FULL_SYSML_MODIFIED = NO
- SSI_AUTHOR_SOURCE_MODIFIED = NO

**RAIL_MBSE_MODEL_TOOLCHAIN = PASS**
