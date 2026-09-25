import fs from "node:fs";
import path from "node:path";

const [inventoryPath, manifestPath, outputPath] = process.argv.slice(2);
if (!inventoryPath || !manifestPath || !outputPath) {
  process.stderr.write("Usage: node build_syson_representation_specs.mjs <inventory.json> <manifest.json> <output.json>\n");
  process.exit(2);
}

const inventory = JSON.parse(fs.readFileSync(path.resolve(inventoryPath), "utf8"));
const manifest = JSON.parse(fs.readFileSync(path.resolve(manifestPath), "utf8"));
const viewsByName = new Map(
  inventory.records
    .filter((record) => record.eclass === "sysml:ViewUsage" && record.declared_name)
    .map((record) => [record.declared_name, record]),
);

const specifications = [];
const missing = [];
for (const view of manifest.view_definitions) {
  const record = viewsByName.get(view.name);
  if (!record) {
    missing.push(view.name);
    continue;
  }
  specifications.push({
    view_name: view.name,
    object_id: record.id,
    semantic_path: record.qualified_path,
    label: view.label,
    category: view.category,
    expected_product_codes: view.product_codes ?? [],
    expected_port_scope_product_codes: view.name.includes("LEAF_PORTS") ? (view.product_codes ?? []) : [],
    expected_function_ids: view.function_ids ?? [],
    expected_allocation_function_ids: view.allocation_ids ?? [],
    expected_connection_ids: view.connection_ids ?? [],
    expected_physical_net_ids: view.physical_net_ids ?? [],
    expected_component_codes: view.component_codes ?? [],
  });
}

if (missing.length > 0) {
  process.stderr.write(`Missing ViewUsage elements: ${missing.join(", ")}\n`);
  process.exit(1);
}
fs.mkdirSync(path.dirname(path.resolve(outputPath)), { recursive: true });
fs.writeFileSync(path.resolve(outputPath), `${JSON.stringify(specifications, null, 2)}\n`, "utf8");
process.stdout.write(`${JSON.stringify({ expected: manifest.view_definitions.length, resolved: specifications.length, missing: missing.length }, null, 2)}\n`);
