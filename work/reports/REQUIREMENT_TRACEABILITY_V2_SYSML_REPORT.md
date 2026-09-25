# Requirement Traceability V2 SysML Overlay Report

## Result

- Requirement: 46 = 34 original + 12 derived.
- Requirement→Function mappings read directly from V2 Excel: 289 (unique pairs: 289).
- Functions: 191; direct formal Requirement→Function map coverage: 178; implementation-support source coverage: 13; with any Requirement upstream per V2 coverage audit: 191; unresolved: 0.
- Function→OWNER Product allocations parsed from frozen SysML: 191.
- Parent→Derived links from V2 Parent_Requirement_IDs: 27.
- Frozen Product interaction references: 74 flow records.
- Requirement rows directly connected to at least one Function: 46; original requirements: 34; derived requirements: 12.
- Original requirements with linked derived-requirement Functions: 14.
- Maximum Functions per Requirement: 21; maximum Requirements per Function: 11; mean mappings per Requirement: 6.28.
- Coverage audit categories from V2: {"DERIVED_REQUIREMENT": 103, "EXISTING_REQUIREMENT": 75, "IMPLEMENTATION_SUPPORT": 13}.
- Product comparison: 无 Product_ID 不一致。

## Validation

- Structural / ID / reference checks: PASS.
- UTF-8 and brace balance: PASS.
- Frozen SysML SHA-256: PASS (`a15cf7170dc5458738080a146c391e438fe57b85f9687857f34a081b8efdf0d5`; expected `a15cf7170dc5458738080a146c391e438fe57b85f9687857f34a081b8efdf0d5`).
- V2 Excel SHA-256 (input snapshot): `496736980a493689339eb35df85ec9603f5f9d0fa5e484ef049f990bf0829f01`.
- Official SysML Pilot 0.59.0 parser: `OFFICIAL_PARSE_NOT_RUN`.
- Overall internal structure: PASS.

### Checks

- PASS requirements
- PASS requirement_function
- PASS functions
- PASS function_coverage
- PASS allocations
- PASS requirements_unique
- PASS mapping_pairs_unique
- PASS function_ids_resolve
- PASS product_ids_resolve
- PASS parents_resolve
- PASS audit_all_191_covered
- PASS interactions_resolve_products
- PASS product_interaction_records
- PASS interaction_interface_refs_resolve
- PASS interaction_connector_refs_resolve
- PASS generated_requirement_usages
- PASS generated_satisfy_edges
- PASS generated_satisfy_edges_match_excel
- PASS generated_requirement_metadata_matches_excel
- PASS generated_parent_derived_edges
- PASS generated_support_records
- PASS generated_product_flow_records
- PASS generated_owner_allocation_records
- PASS generated_interaction_reference_records
- PASS brace balance `01_RequirementDefinitions_v2.sysml` (depth=0; quote=False; block_comment=False)
- PASS brace balance `02_RequirementHierarchy_v2.sysml` (depth=0; quote=False; block_comment=False)
- PASS brace balance `03_RequirementFunctionTrace_v2.sysml` (depth=0; quote=False; block_comment=False)
- PASS brace balance `04_FunctionProductAllocationTrace_v2.sysml` (depth=0; quote=False; block_comment=False)
- PASS brace balance `05_ProductInteractionReference_v2.sysml` (depth=0; quote=False; block_comment=False)
- PASS brace balance `06_RequirementTraceability_AllInOne_v2.sysml` (depth=0; quote=False; block_comment=False)

## Anomalies and dangling references

- None.

## Generated Files

- `work/sysmlv2/requirements_traceability_v2/01_RequirementDefinitions_v2.sysml`
- `work/sysmlv2/requirements_traceability_v2/02_RequirementHierarchy_v2.sysml`
- `work/sysmlv2/requirements_traceability_v2/03_RequirementFunctionTrace_v2.sysml`
- `work/sysmlv2/requirements_traceability_v2/04_FunctionProductAllocationTrace_v2.sysml`
- `work/sysmlv2/requirements_traceability_v2/05_ProductInteractionReference_v2.sysml`
- `work/sysmlv2/requirements_traceability_v2/06_RequirementTraceability_AllInOne_v2.sysml`
- `work/sysmlv2/requirements_traceability_v2/requirement_function_trace_v2.json`
- `work/sysmlv2/requirements_traceability_v2/SYSON_IMPORT_ORDER_V2.md`

No UI, V2 Excel, or frozen SysML source was written by this generator.
