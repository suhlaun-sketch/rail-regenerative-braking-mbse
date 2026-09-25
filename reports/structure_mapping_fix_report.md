# Structure Mapping Fix Report

- Scope: structure mapping, Port direction, relationship de-duplication, semantic Probe only.
- Frozen JSON/Excel/KG/ConnectGraph: unchanged.
- New full XMI: not published.

## Counts

- Product Block definitions: 147
- Product hierarchy Part Properties: 139
- Probe Product Blocks / Context Block: 10 / 1
- Probe composite Part Properties: 10
- Part typed by non-Block: 0
- Port direction: in=167, out=210, inout=140, unknown=0
- MODEL_DUPLICATE: 0
- DIAGRAM_DUPLICATE: 0
- RELATIONSHIP_DUPLICATE: 0

## QA

- STR-QA: 25 PASS / 0 FAIL
- Probe: PASS
- Failed checks: None
- CAMEO_IMPORT_TEST: PENDING

## Output

- Probe: `C:\Users\AUSA\Desktop\牵引制动能量回收\work\Rail_MBSE_SysML17_structure_probe_v4.xmi`
- Direction strategy: standard directional InterfaceBlock projection with standard FlowProperty in/out/inout; no non-standard Port direction attribute.
- BDD and IBD are projection contracts; this Probe does not serialize vendor-specific diagrams.
