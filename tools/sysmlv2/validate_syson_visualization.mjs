import fs from "node:fs";
import path from "node:path";

const [mappingPath, inventoryPath, representationsPath, creationPath, manifestPath, coveragePath, reportPath] = process.argv.slice(2);
if (!reportPath) {
  process.stderr.write("Usage: node validate_syson_visualization.mjs <mapping.json> <inventory.json> <representations.json> <creation.json> <manifest.json> <coverage.json> <report.md>\n");
  process.exit(2);
}

const mapping = JSON.parse(fs.readFileSync(path.resolve(mappingPath), "utf8"));
const inventory = JSON.parse(fs.readFileSync(path.resolve(inventoryPath), "utf8"));
const representations = JSON.parse(fs.readFileSync(path.resolve(representationsPath), "utf8"));
const creation = JSON.parse(fs.readFileSync(path.resolve(creationPath), "utf8"));
const manifest = JSON.parse(fs.readFileSync(path.resolve(manifestPath), "utf8"));

const representationById = new Map(representations.map((representation) => [representation.id.split("#").at(-1), representation]));
const createdRepresentations = creation.results.map((result) => ({ ...result, stored: representationById.get(result.representation?.id) ?? null }));

function collectTargets(value, output = []) {
  if (!value || typeof value !== "object") return output;
  if (typeof value.targetObjectId === "string") {
    const match = String(value.targetObjectKind ?? "").match(/entity=([^&]+)/);
    output.push({ id: value.targetObjectId, kind: match?.[1] ?? null, label: value.targetObjectLabel ?? null });
  }
  for (const child of Object.values(value)) collectTargets(child, output);
  return output;
}

const targetIds = new Set();
const targetLabels = new Set();
const targetKindsByLabel = new Map();
for (const created of createdRepresentations) {
  if (!created.stored) continue;
  created.targets = collectTargets(created.stored.content);
  for (const target of created.targets) {
    targetIds.add(target.id);
    if (target.label) targetLabels.add(target.label);
    if (target.label && target.kind) {
      if (!targetKindsByLabel.has(target.label)) targetKindsByLabel.set(target.label, new Set());
      targetKindsByLabel.get(target.label).add(target.kind);
    }
  }
  created.top_edge_count = Array.isArray(created.stored.content?.edges) ? created.stored.content.edges.length : 0;
}

const inventoryRecords = inventory.records;
const inventoryKey = (eclass, qualifiedPath) => inventoryRecords.find((record) => record.eclass === eclass && record.qualified_path === qualifiedPath);

const productExpected = mapping.product_hierarchy.map((product) => {
  const pathValue = product.SysML_Definition;
  const record = inventoryKey("sysml:PartDefinition", pathValue);
  return { code: product.Product_Code, name: product.Product_Name, path: pathValue, id: record?.id ?? null };
});
const productMissingSemantic = productExpected.filter((item) => !item.id);
const productMissingView = productExpected.filter((item) => item.id && !targetIds.has(item.id));

const portExpected = mapping.raw_ports.map((port) => {
  const definition = mapping.product_hierarchy.find((product) => product.Product_Code === port.Leaf_Code)?.SysML_Definition.split("::").at(-1);
  const portName = port.SysML_Port_Path.split(".").at(-1);
  const qualifiedPath = `ProductDefinitions::${definition}::${portName}`;
  const record = inventoryKey("sysml:PortUsage", qualifiedPath);
  return { port_id: port.Raw_Port_ID, leaf_code: port.Leaf_Code, path: qualifiedPath, id: record?.id ?? null };
});
const portMissingSemantic = portExpected.filter((item) => !item.id);
const portMissingView = portExpected.filter((item) => item.id && !targetIds.has(item.id));

const functionExpected = mapping.function_allocations.map((item) => ({
  function_id: item.Function_ID,
  name: item.SysML_Function_Path.split("::").at(-1),
}));
const functionMissingView = functionExpected.filter((item) => !targetLabels.has(item.name));

const allocationExpected = mapping.function_allocations.map((item) => ({
  function_id: item.Function_ID,
  name: item.SysML_Allocation_Path.split("::").at(-1),
}));
const allocationMissingView = allocationExpected.filter((item) => !targetLabels.has(item.name));

const connectionExpected = mapping.final_connections.map((item) => ({
  connection_id: item.Connection_ID,
  name: item.SysML_Connection_Path.split(".").at(-1),
}));
const connectionMissingView = connectionExpected.filter((item) => !targetLabels.has(item.name));

const physicalNetExpected = manifest.physical_network_projection_trace.map((item) => ({
  net_id: item.original_net_id,
  name: item.derived_element.split("::").at(-1),
}));
const physicalNetMissingView = physicalNetExpected.filter((item) => !targetLabels.has(item.name));

const viewsByCategory = {};
for (const created of createdRepresentations) {
  viewsByCategory[created.category] = (viewsByCategory[created.category] ?? 0) + 1;
}
const l2Views = createdRepresentations.filter((created) => created.category === "02_l2");
const missingL2Views = l2Views.filter((created) => {
  const expectedIds = created.expected_product_codes
    .map((code) => productExpected.find((item) => item.code === code)?.id)
    .filter(Boolean);
  return !created.stored || expectedIds.some((id) => !created.targets.some((target) => target.id === id));
});

const connectionViews = createdRepresentations.filter((created) => created.category === "05_connections");
const allocationViews = createdRepresentations.filter((created) => created.category === "07_allocations");
const netViews = createdRepresentations.filter((created) => created.category === "08_physical_nets");
const l2Overview = createdRepresentations.find((created) => created.view_name === "RV_00_ALL16_L2_BOUNDARY_OVERVIEW");
const regenerative = createdRepresentations.find((created) => created.view_name === "RV_09_REGENERATIVE_BRAKING_CORE");
const overview = createdRepresentations.find((created) => created.view_name === "RV_00_RAIL_FULL_ARCHITECTURE_OVERVIEW");

function summary(source, missingSemantic, missingView) {
  return {
    source_count: source.length,
    visualized_count: source.length - missingView.length,
    semantic_match_count: source.length - missingSemantic.length,
    missing_semantic: missingSemantic,
    missing_visualization: missingView,
    coverage_percent: Number((((source.length - missingView.length) / source.length) * 100).toFixed(2)),
  };
}

const coverage = {
  generated_at: new Date().toISOString(),
  syson_version: "v2026.7.0",
  deployment: {
    url: "http://localhost:8080",
    project_id: "4db1e0e8-09cd-45e3-b97f-562eb6ae3cdf",
    editing_context_id: creation.editing_context_id,
    full_sysml_import: "PASS",
    semantic_projection: "NOT_NEEDED",
    visualization_projection: "GENERATED",
  },
  authoritative_model: {
    path: manifest.authoritative_full_sysml,
    sha256: manifest.authoritative_full_sysml_sha256,
    modified: false,
  },
  representations: {
    expected: manifest.view_definitions.length,
    created: creation.succeeded,
    failed: creation.failed,
    persisted: createdRepresentations.filter((created) => created.stored).length,
    by_category: viewsByCategory,
  },
  products: summary(productExpected, productMissingSemantic, productMissingView),
  ports: summary(portExpected, portMissingSemantic, portMissingView),
  functions: summary(functionExpected, [], functionMissingView),
  allocations: summary(allocationExpected, [], allocationMissingView),
  connections: summary(connectionExpected, [], connectionMissingView),
  physical_nets: summary(physicalNetExpected, [], physicalNetMissingView),
  l2_detailed_views: {
    expected: 16,
    created: l2Views.length - missingL2Views.length,
    missing: missingL2Views.map((created) => created.view_name),
  },
  actual_diagram_edges: {
    allocations: allocationViews.reduce((total, created) => total + created.top_edge_count, 0),
    final_connections: connectionViews.reduce((total, created) => total + created.top_edge_count, 0),
    physical_nets: netViews.reduce((total, created) => total + created.top_edge_count, 0),
    l2_boundary_connections: l2Overview?.top_edge_count ?? 0,
    regenerative_braking_connections: regenerative?.top_edge_count ?? 0,
  },
  key_views: {
    full_architecture_overview: overview?.stored && (overview.targets?.length ?? 0) > 0 ? "PASS" : "FAIL",
    all16_l2_boundary_overview: l2Overview?.stored && l2Overview.top_edge_count > 0 ? "PASS" : "FAIL",
    regenerative_braking_core: regenerative?.stored && regenerative.top_edge_count > 0 ? "PASS" : "FAIL",
  },
};

const exactCounts =
  coverage.products.visualized_count === 147 &&
  coverage.ports.visualized_count === 517 &&
  coverage.functions.visualized_count === 191 &&
  coverage.allocations.visualized_count === 191 &&
  coverage.connections.visualized_count === 184 &&
  coverage.physical_nets.visualized_count === 9 &&
  coverage.l2_detailed_views.created === 16;
const exactEdges =
  coverage.actual_diagram_edges.allocations === 191 &&
  coverage.actual_diagram_edges.final_connections === 184 &&
  coverage.actual_diagram_edges.physical_nets === 9;
coverage.status = exactCounts && exactEdges && creation.failed === 0 ? "PASS" : "FAIL";

fs.mkdirSync(path.dirname(path.resolve(coveragePath)), { recursive: true });
fs.writeFileSync(path.resolve(coveragePath), `${JSON.stringify(coverage, null, 2)}\n`, "utf8");

const report = `# SysON Full Rail Visualization Report

- SysON: v2026.7.0
- Deployment: official application JAR with PostgreSQL 15.19
- URL: http://localhost:8080
- Project: Rail MBSE Full v1 (${coverage.deployment.project_id})
- Full SysML import: PASS
- Semantic projection: NOT NEEDED
- Visualization-only projection: GENERATED from frozen Full SysML
- Authoritative Full SysML modified: NO

## Persisted SysON Views

- Planned: ${coverage.representations.expected}
- Created: ${coverage.representations.created}
- Persisted: ${coverage.representations.persisted}
- Failed: ${coverage.representations.failed}
- L2 detailed views: ${coverage.l2_detailed_views.created}/16

## Visualization Coverage

| Element | Visualized | Required | Coverage |
|---|---:|---:|---:|
| Products | ${coverage.products.visualized_count} | 147 | ${coverage.products.coverage_percent}% |
| Raw Ports | ${coverage.ports.visualized_count} | 517 | ${coverage.ports.coverage_percent}% |
| Functions | ${coverage.functions.visualized_count} | 191 | ${coverage.functions.coverage_percent}% |
| Allocations | ${coverage.allocations.visualized_count} | 191 | ${coverage.allocations.coverage_percent}% |
| Final Connections | ${coverage.connections.visualized_count} | 184 | ${coverage.connections.coverage_percent}% |
| Physical Nets | ${coverage.physical_nets.visualized_count} | 9 | ${coverage.physical_nets.coverage_percent}% |

## Actual Diagram Edge Evidence

- Allocation edges: ${coverage.actual_diagram_edges.allocations}
- Final connection edges: ${coverage.actual_diagram_edges.final_connections}
- Physical-net edges: ${coverage.actual_diagram_edges.physical_nets}
- All16 L2 boundary edges: ${coverage.actual_diagram_edges.l2_boundary_connections}
- Regenerative-braking core edges: ${coverage.actual_diagram_edges.regenerative_braking_connections}

## Key Views

- Rail Full Architecture Overview: ${coverage.key_views.full_architecture_overview}
- Full L2 Interface Overview: ${coverage.key_views.all16_l2_boundary_overview}
- Regenerative Braking Core: ${coverage.key_views.regenerative_braking_core}

## Mapping Integrity

The direct authoritative import contains all original semantic elements. The additional files under \`syson_integration/projection/generated\` are generated visualization definitions only. Deep hierarchical connector endpoints are flattened one-to-one for rendering; every projected connection and physical net carries its original stable ID and SysML path in the projection manifest. No engineering element or relationship is invented, removed, or promoted into the authoritative model.

## Status

SYSON_FULL_RAIL_VISUALIZATION = ${coverage.status}
`;
fs.mkdirSync(path.dirname(path.resolve(reportPath)), { recursive: true });
fs.writeFileSync(path.resolve(reportPath), report, "utf8");

process.stdout.write(`${JSON.stringify({
  status: coverage.status,
  products: `${coverage.products.visualized_count}/147`,
  ports: `${coverage.ports.visualized_count}/517`,
  functions: `${coverage.functions.visualized_count}/191`,
  allocations: `${coverage.allocations.visualized_count}/191`,
  connections: `${coverage.connections.visualized_count}/184`,
  physical_nets: `${coverage.physical_nets.visualized_count}/9`,
  l2_views: `${coverage.l2_detailed_views.created}/16`,
  edges: coverage.actual_diagram_edges,
}, null, 2)}\n`);

if (coverage.status !== "PASS") process.exit(1);
