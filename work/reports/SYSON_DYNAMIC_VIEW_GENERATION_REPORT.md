# SysON Dynamic View Generation — Implementation & Acceptance

## Result

The local natural-language → Engineering Scope → hierarchical View planning path is implemented and verified. The live SysON representation creation path remains **BLOCKED** because current-model element search does not return within the configured 8-second request timeout. The generator therefore reports `BLOCKED`, creates zero representations, and confirms `mutations_attempted=false`. The current hierarchy implementation and query-specific metrics are documented in [HIERARCHICAL_IBD_CLOSURE_REPORT.md](HIERARCHICAL_IBD_CLOSURE_REPORT.md).

## Implemented

- A versioned-style JSON Schema and strict Pydantic manifest model.
- Local semantic fallback, followed by expansion through the formal V2 Requirement→Function mapping.
- Function owner products from real frozen SysML `allocation` statements.
- Product/interface/flow neighborhood from the existing TaskSlice and L2 interaction catalog.
- `1 Requirement + 1 Function–Product + up to 4 hierarchy-level IBDs`; Flow pair count no longer controls View count.
- Schema-gated GraphQL client, dynamic project discovery, unique exact-label element resolver, and mutation preconditions.
- FastAPI routes and a natural-language scope panel on the existing task-slice page.
- Durable manifests under `tools/syson_automation/generated/scopes/`.

## Changed and added files

- Updated existing integration: `ui/backend/app/main.py`, `ui/frontend/src/pages/TaskSlicePage.tsx`, and `ui/frontend/src/services/semanticApi.ts`.
- Added schema/models/build logic/API/resolver/GraphQL adapter under `tools/syson_automation/src/`.
- Added live discovery script and snapshots under `tools/syson_automation/scripts/` and `tools/syson_automation/cache/`.
- Added hierarchical closure/projection tests under `tools/syson_automation/tests/test_hierarchical_ibd.py`.
- Added local command guide `tools/syson_automation/README.md` and this report.
- Scope manifests are generated in `tools/syson_automation/generated/scopes/`.
- Closure graph evidence is generated in `tools/syson_automation/generated/closures/`.

## Live local acceptance

- SysON endpoint: `http://localhost:8080/api/graphql`; introspection succeeded: 664 types, 1 Query field (`viewer`), 126 Mutation fields.
- Current project: `Rail_Regenerative_Braking_MBSE`, ID `3e060c9b-36ee-43c5-b6cb-1448c230bce7`.
- Current EditingContext: `967a4588-11d1-435d-ba59-2412f2e63002`.
- Existing representations discovered: 2, both labeled `view1`; no existing representations were changed.
- Confirmed schema capabilities include `createRepresentation`, `dropNodes`, `arrangeAll`, and `layoutDiagram`. Their presence alone is not proof that target model elements or a suitable representation description resolve.
- Live `editingContext.search` for exact anchor `FN_F_X100_01` timed out after 8 seconds. A prior domain/root-model read also timed out. Current element IDs therefore cannot be safely bound to the planned views.
- The current tested generation endpoint returned 6 planned (Requirement + Function–Product + 4 hierarchy levels), 0 created, `BLOCKED`, and `mutations_attempted=false`.
- SVG export through a server GraphQL/API operation was not found in the current introspected schema/client operations.
- Example Scope query preserves the original 5 Requirements, 10 Functions, 19 Products, and 68 catalog-backed Flow rows. Additive closure fields contain 8 allocation Seed Products and 93 interface-induced Products after 6 rounds; 129 closure-plus-ancestor nodes project to 4 hierarchy levels. Counts vary with the natural-language query.
- No direct 5100↔X100 flow was present in the tested scope.

## View-by-view outcome

- Requirement View: **not created**; the plan contains the selected formal Requirement IDs, but live SysON Requirement element IDs cannot be resolved.
- Function–Product Allocation View: **not created**; the plan points to verified direct allocation owner products. Allocation is represented as allocation evidence, never as a connector.
- IBD: **not created in SysON**; local hierarchy projection produces `AUTO_IBD_L1` through `AUTO_IBD_L4`, preserving aggregate references to real Flow, Interface, and Connector elements.
- Automatic hierarchy projection: **planning succeeded** (4 IBD views; 6 planned views including Requirement and Function–Product). Pair-focused IBD generation has been removed.
- Arrange: schema exposes `arrangeAll` and `layoutDiagram`; **not executed** because no representation can be safely created.
- SVG export: no server-side export API/GraphQL operation was found in the live schema and local SysON client operation bundle; no SVG was produced.
- Frontend: natural-language entry appears in the existing `/task-slice` page. Frontend production build passed; HTTP server returns 200. No browser automation was used.

## Validation

- `python -m unittest discover -s tools/syson_automation/tests -v`: 17 tests passed, covering closure fixed point, hierarchy, canonicalization, provenance, bidirectional aggregation, frozen baselines, and the forbidden edge.
- Scope schema JSON parsed; Pydantic validated saved manifests.
- Frozen SysML SHA-256 remained `a15cf7170dc5458738080a146c391e438fe57b85f9687857f34a081b8efdf0d5`.
- Formal V2 Excel SHA-256 is `496736980a493689339eb35df85ec9603f5f9d0fa5e484ef049f990bf0829f01`; it was read for the acceptance hash check and not written.
- FastAPI live HTTP: `/api/syson/scope`, `/api/syson/views/plan`, and `/api/syson/views/generate` exercised; health returned `ok`.
- Frontend `npm run build`: passed (Vite reports the pre-existing large bundle warning).

## Remaining blocker

SysON serves project/context metadata and schema introspection, but search and root/domain model reads do not complete in time. Since the current live Project's semantic object IDs and representation descriptions cannot be resolved, no honest `createRepresentation`/`dropNodes`/layout sequence can be run. The implementation intentionally retains an explicit generation gate; retry after SysON model search is responsive. No source model or formal requirement workbook was written by this task.
