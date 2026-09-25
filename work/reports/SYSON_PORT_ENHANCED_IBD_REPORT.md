# SysON Port-Enhanced IBD Report

- Project: `Rail_Regenerative_Braking_MBSE_PortEnhanced_v2` / `2d2dc96d-f9ea-4f06-96e7-166fda18e550`
- EditingContext: `12d630bc-f763-4c58-8385-152cbec448e9`
- New element index: **3986** entries; fingerprint `065537756fd6cece6f54107bccc08bf030acd34423b3a5b988d38313405461e4`.
- SysON indexed PortUsage: **83**.

| Product | Added boundary PortUsage |
|---|---:|
| X100 | 12 |
| X110 | 9 |
| X120 | 4 |
| X130 | 5 |
| 8100 | 12 |

| View | ID | Nodes | Port nodes | Graphical edges |
|---|---|---:|---:|---:|
| port_smoke | `b8556ea6-8bac-40a3-bb4d-8ed086e63fb0` | 5 | 2 | 9 |
| connection_smoke | `3563d110-e390-4473-a3af-848749f8e0f3` | 4 | 2 | 12 |
| fp | `ca117b60-091e-4e74-9b88-2cfae71b9826` | 18 | 0 | 10 |
| x100_ibd | `df6f637f-99f3-4a91-a65b-6712363d77d0` | 10 | 5 | 21 |
| x100_internal | `eab3be09-3ec6-4453-97cd-340f87f0c965` | 4 | 0 | 9 |
| x110_ibd | `38389a92-8c9d-4478-b75b-497421e3dd3d` | 4 | 0 | 16 |

- Port smoke visible PortUsage: **2**.
- Connector smoke genuine ConnectionUsage edges: **12**.
- Function–Product graphical Allocation edges: **10**; endpoints are actual ActionUsage and PartUsage.
- X100 IBD internal graphical edges: **9**; external boundary edges: **12**.
- X100 IBD visible PortUsage: **5**; direct children: X110, X120, X130; external endpoint: 8100.
- X100 semantic-root internal drilldown: **9** graphical internal edges.
- X110 drilldown: **16** graphical edges.
- View kind: Interconnection for Port/Connector/X100/X110 and the final Function–Product view. A verified General View with the same 10 allocation edges is retained as an explicitly named fallback.
- Relation edges appeared automatically when true PartUsage endpoints were represented. A relation drop alone did not render an edge.
- Layout limit: SysON places X100 and its direct children as separate top-level visual nodes in the combined railSystem view. The separate X100-root Interconnection smoke verified all 9 internal edges, but a single physically nested X100 frame with all 12 external edges is not yet achieved.
- No user `view1` was modified; all mutations targeted the new Project.
- Query-back used live `diagramEvent`, including edge target object IDs; HTTP status alone was not used as proof.
- Added 5100↔X100 direct relation: **NO**.
