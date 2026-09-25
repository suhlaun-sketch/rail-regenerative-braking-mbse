# SysON 2026.9 isolated Interconnection View smoke

Conclusion: **The current `createRepresentation` route in v2026.9.0 replaces the requested Interconnection View representation description with General View.** This does not establish that SysON 2026.9 lacks Interconnection View functionality. The live API advertises that view. Diagram population stopped immediately; no formal IBD was changed.

## Current environment (`127.0.0.1:8080`)

| Field | Verified value |
|---|---|
| `EXPECTED_VERSION` | 2026.9.0 |
| `CONFIGURED_IMAGE` | `eclipsesyson/syson:v2026.9.0` in `tools/syson-local/docker-compose.yml` |
| `RUNNING_CONTAINER_IMAGE` / `RUNNING_IMAGE_ID` | N/A: no container serves port 8080 |
| Actual server | Local Java process running `third_party/syson/runtime/syson-application.jar` |
| `RUNNING_VERSION` | 2026.7.0, from the running JAR manifest `Implementation-Version` |
| `VERSION_MATCH` | false |

The current GraphQL API advertises Interconnection View for the smoke roots. Existing 2026.7 audit shows correct root/child border-Port ownership and zero standalone Ports, but only 1/6 X130 and 1/4 3110 current-level Port-to-Port edges. Its persisted description is General View; the `CreateRepresentationInputProcessor.getRepresentationDescriptionId` bytecode explicitly maps the Interconnection description ID (`74c5d045…`) to General (`8dcd14b0…`). This is a server-side mapping, not an automation parameter or root-object selection error.

## Independent v2026.9.0 test (`127.0.0.1:8090`)

| Field | Verified value |
|---|---|
| Compose file | `tools/syson-local-2026.9-test/compose.yaml` |
| App / database containers | `rail-syson-2026-9-test-app` / `rail-syson-2026-9-test-db` |
| Image / ID | `eclipsesyson/syson:v2026.9.0` / `sha256:f9b5f51c2dc1bfded8f3ef946f043ec7cc52806cae6bc5910a6232d251c8ffa7` |
| Actual version | 2026.9.0, confirmed by image label **and container JAR manifest** |
| Isolation | Dedicated Docker network `rail_syson_2026_9_test_network`, volume `rail_syson_2026_9_test_pgdata`; database port is not published |
| Test Project ID | `0439b7dc-430b-46a7-b25c-cb02b88975b8` |
| Imported sources | Existing final FullBoundary SysML and existing AllInOne requirements SysML; no regeneration |

| Test view | Root | Requested description | Persisted description | Expected edges | Actual edges | Parts / Ports / standalone / labels |
|---|---|---|---|---:|---|---|
| `TEST_2026_9_IBD_X130` | `P_X130` | Interconnection View | **General View** | 6 | Not evaluated | Not evaluated: stopped before population |
| `TEST_2026_9_IBD_3110` | `P_N_3110` | Interconnection View | **General View** | 4 | Not evaluated | Not evaluated: stopped before population |

The 2026.9 GraphQL `representationDescriptions` query lists Interconnection View for both `PartDefinition` and `PartUsage` roots. The exact Interconnection description ID was supplied to both mutations. A direct PostgreSQL query of `representation_metadata.description_id` returned the General ID for both views. The 2026.9 `syson-tree-explorer-view` JAR bytecode still contains the same explicit `getRepresentationDescriptionId` rewrite. Thus the blocker remains in this server route; testing child containment, inherited border Ports, Port-to-Port/InterfaceUsage edges, and display labels in a **genuine** Interconnection View is not possible here. No General View fallback was accepted as a pass.

Port label text customization also has no obvious new GraphQL input: `EditLabelAppearanceInput` exposes the same appearance-only fields in both versions. Because the genuine view failed at creation, label presentation was not claimed to pass.

The 57 formal IBDs and formal project were not touched. Port 8080 remained available. Frozen v1 and Requirement V2 hashes still match the prior recorded values (`A15CF717…` and `49673698…`); the FullBoundary v3 source was read-only. No batch migration was started.

## Description-routing follow-up

The 2026.9 live GraphQL inventory is `live_description_inventory.json`. `p_X130`, `P_X130`, `p_N_3110`, and `P_N_3110` each expose five descriptions, including distinct Interconnection and General diagram IDs. The exact live Interconnection ID is `siriusComponents://representationDescription?kind=diagramDescription&sourceKind=view&sourceId=74c5d045-51d7-359f-9634-611d0f1bef3d&sourceElementId=e1bd3b6d-357b-3068-b2e9-e0c1e19d6856`; General uses `sourceId=8dcd14b0-6259-3193-ad2c-743f394c68e4` and `sourceElementId=db495705-e917-319b-af55-a32ad63f4089`.

The actual logged `createRepresentation` mutation inputs for the old formal-project V3 smokes (`20260924T143958252015_createRepresentation.json` for X130 and `20260924T140616192926_createRepresentation.json` for 3110) both contain the exact Interconnection ID. Automation selected neither the General ID nor an inapplicable ID. The request roots were `b6888ba7-00ef-416f-88c5-920004d11b60` (`P_X130`) and `b264eb3b-2a82-4502-a731-7913c5d4159c` (`P_N_3110`).

One new empty test view, `TEST_TRUE_INTERCONNECTION_X130`, was created on live-applicable Usage `p_X130` (`053855ce-5314-4393-a906-c542e657f3c2`). Its representation ID is `f563f725-1fc5-41b9-bc22-74d1a90fd86b`. The requested ID is Interconnection; GraphQL-returned metadata, PostgreSQL `representation_metadata.description_id`, and stored diagram `descriptionId` all identify General View. Separately, its semantic `ViewUsage` has a FeatureTyping reference to the live library `InterconnectionView` object (`6518462a-2f51-5276-b95e-69ee5193db38`). Thus semantic type A is correct while graphical description B is wrong. `TEST_TRUE_INTERCONNECTION_3110` was not created because X130 failed the stated gate.

The `syson-tree-explorer-view-2026.9.0.jar` implementation of `CreateRepresentationInputProcessor.getRepresentationDescriptionId` explicitly rewrites the Interconnection description ID to the General description ID. The bundled 2026.9 frontend creates representations with `representationDescriptionId` equal to the selected menu item's `id`; its menu is populated from the live descriptions, which include Interconnection for these four roots. Direct UI clicking/request capture was attempted, but the in-app Browser runtime failed before connecting (`failed to write kernel assets: path not found`), so actual UI request fields remain unobserved. The bundled frontend code path, live menu data, and backend bytecode are recorded as separate evidence. No assertion of a successful UI click is made.
