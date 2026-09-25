# Port Gap Audit

Frozen v1, formal SSD, implementation binding and current scope are read only.

## Frozen SysML element counts

- PartDefinition: 152
- PartUsage: 297
- PortDefinition: 144
- PortUsage: 521
- InterfaceDefinition: 144
- InterfaceUsage: 184
- ConnectionUsage: 9
- BindingConnector: 0
- FlowConnectionUsage: 144
- AllocationUsage: 191

## Evidence check

- Explicit SysML interface connections: 172
- Source/target leaf PortUsage missing: 0
- Cross-container interactions requiring a boundary PortUsage: 504
- SSD connections: 74
- Binding structural connectors: 138
- Binding structural cross-L2 connections: 74
- Binding executable signal connections: 87
- Binding L2 components: 16
- Scope seed/closure/edges: {'seed': 8, 'closure': 93, 'directed_edges': 152}

## X100 / 8100

- Existing X100 PortUsage: 0
- Existing 8100 PortUsage: 0
- Explicit X-subtree ↔ 8100-subtree leaf connections: 12
- Leaf endpoints already have real PortUsage; parent boundary ports are absent.
- See PORT_GAP_AUDIT.json for every connector, endpoint classification, and missing boundary record.
- No direct 5100 ↔ X100 interface is inferred.

## Largest boundary gaps

- 8100 ↔ 7211: 12
- 8000 ↔ 7211: 12
- X100 ↔ 8122: 12
- X000 ↔ 8122: 12
- 8120 ↔ 7211: 11
- X110 ↔ 8122: 11
- 8120 ↔ X112: 10
- 8100 ↔ X112: 10
- 8000 ↔ X112: 10
- 7220 ↔ 7211: 6
- 5100 ↔ 8122: 6
- 5000 ↔ 8122: 6
- X130 ↔ X112: 5
- 7280 ↔ 7211: 5
- 7200 ↔ 8121: 4
- 7000 ↔ 8121: 4
- 5000 ↔ 8125: 4
- 4210 ↔ 4238: 4
- 4230 ↔ 4212: 4
- X120 ↔ X112: 4
