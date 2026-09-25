# Rail SysML v2 to SSI_v1.0.0 Compatibility Matrix

The comparison below is based on the unmodified parser in `source/SSI_transformer.py` and the author's `sec_3`/`sec_4` examples.

| SSI parser expectation | Current Rail location/form | Direct compatibility | Concrete difference | Thin projection resolution |
|---|---|---:|---|---|
| `package` | All five Rail files use packages | Partial | Package declarations are ignored; names and imports are not resolved | Use author-style four package files; parser still consumes only interface/system files |
| `part def Name { ... }` | Product definitions are in `05_ProductDefinitions.sysml` | No runtime use | SSI system parser never loads part definitions | Preserve selected type names as declarations in projection general definition |
| `part instance : Type {` | Rail `07_SystemDefinition.sysml` has one root `part railSystem : RailSystemContext {`; child usages live in a different file | No | SSI does not expand `RailSystemContext`, imports, or nested compositions | Flatten eight selected existing L2 usages into eight top-level parts |
| `item def` | 144 item definitions in `02_ItemDefinitions.sysml` | Partial | SSI does not load the item file; it only captures the item/type token in interface flow text | Project only item names referenced by used interface types |
| `port def` | 144 definitions in `03_PortDefinitions.sysml` | Partial | SSI does not load port definitions; it compares type-name strings | Project the 12 used port definition blocks for traceable input packaging |
| `port name : Type;` directly inside a part | Rail raw ports are in leaf `part def` blocks and use `port ... : Type { metadata }` | No | SSI regex requires direct component ports ending in `;`; it does not traverse leaf definitions | Promote only the 29 existing leaf ports used by selected cross-L2 connections |
| `interface def Name {` | 144 definitions in `04_InterfaceDefinitions.sysml` | Yes | Names are ASCII identifiers and match `\w+` | Select the 12 definitions used by the slice without semantic changes |
| `end name : PortType;` | Rail uses `end source` and `end target` | Yes | Exact syntax matches the author parser | Copied into the projection subset |
| `flow of Item from end.payload to end.payload;` | Rail interface definitions use this exact form | Yes | Exact syntax matches the author parser | Copied into the projection subset |
| `interface id : Type connect component.port to component.port;` | Rail has 184 interface usages with deep paths such as `railSystem.a.b.c.port` and a following metadata block | No | SSI regex accepts exactly one dot per endpoint and expects the connection to end with `;` | Flatten endpoints to `L2_code.promoted_leaf_port` and emit one-line usages |
| Part `attribute name = value;` | Rail metadata is typed (`attribute name : Type = value;`) and mostly resides in definitions/connection blocks | No/unused | SSI only captures untyped assignments inside the currently parsed part | Projection includes only an untyped source code trace attribute; SSD mapping does not depend on it |
| `connection` keyword | Rail uses interface usages, not a standalone connection keyword | Not supported | SSI_v1.0.0 has no parser for `connection ...` syntax | Continue using the existing Rail interface usages |
| Colon typing | Rail uses `name : Type` consistently | Yes within regex subset | SSI recognizes only inline colon typing and optional `~` conjugation | Preserve the exact existing port and interface type names |
| `reference` / `ref` | Full model may contain references outside the five SSI inputs | Not supported | No corresponding parser branch | Not required in the projection |
| `import` | Rail packages have explicit imports | No resolution | SSI skips import lines and does not build a namespace | Projection is self-contained at the textual type-name level |

## Direct import evidence

- Interface definitions parsed: 144
- Rail system connection declarations: 184
- Components parsed: 1 (root only)
- Ports parsed: 0
- Connections parsed: 0
- SSI parser return code: 0
- Compatibility result: **FAIL** because the parse was structurally empty; zero validation errors do not represent a valid import.

The incompatibility is confined to the author's line-oriented parser and is resolved without changing the frozen Rail SysML.
