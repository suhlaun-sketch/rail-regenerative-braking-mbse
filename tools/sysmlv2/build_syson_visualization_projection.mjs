import crypto from "node:crypto";
import fs from "node:fs";
import path from "node:path";

const root = process.cwd();
const mappingPath = path.join(root, "work", "sysmlv2", "full_engineering_model", "02_mapping", "mapping_payload.json");
const ssiManifestPath = path.join(root, "work", "sysmlv2", "ssi_integration", "02_projection_all16", "projection_manifest.json");
const systemPath = path.join(root, "work", "sysmlv2", "full_engineering_model", "01_generated", "07_SystemDefinition.sysml");
const allocationsPath = path.join(root, "work", "sysmlv2", "full_engineering_model", "01_generated", "08_FunctionAllocations.sysml");
const netsPath = path.join(root, "work", "sysmlv2", "full_engineering_model", "01_generated", "09_PhysicalNetworks.sysml");
const outputRoot = path.join(root, "work", "sysmlv2", "syson_integration", "projection", "generated");

const mapping = JSON.parse(fs.readFileSync(mappingPath, "utf8"));
const ssi = JSON.parse(fs.readFileSync(ssiManifestPath, "utf8"));
const systemText = fs.readFileSync(systemPath, "utf8");
const allocationText = fs.readFileSync(allocationsPath, "utf8");
const netsText = fs.readFileSync(netsPath, "utf8");

fs.mkdirSync(outputRoot, { recursive: true });

const products = mapping.product_hierarchy;
const productByCode = new Map(products.map((product) => [product.Product_Code, product]));
const childrenByParent = new Map();
for (const product of products) {
  const key = product.Parent_Code ?? "ROOT";
  if (!childrenByParent.has(key)) childrenByParent.set(key, []);
  childrenByParent.get(key).push(product);
}
for (const children of childrenByParent.values()) {
  children.sort((a, b) => a.Product_Code.localeCompare(b.Product_Code));
}

function descendants(code, includeSelf = true) {
  const result = [];
  const visit = (current) => {
    const product = productByCode.get(current);
    if (product) result.push(product);
    for (const child of childrenByParent.get(current) ?? []) visit(child.Product_Code);
  };
  if (includeSelf) visit(code);
  else for (const child of childrenByParent.get(code) ?? []) visit(child.Product_Code);
  return result;
}

function topL1(code) {
  let current = productByCode.get(code);
  while (current?.Parent_Code) current = productByCode.get(current.Parent_Code);
  return current?.Product_Code ?? code;
}

function l2Of(code) {
  let current = productByCode.get(code);
  while (current && Number(current.Level) > 2) current = productByCode.get(current.Parent_Code);
  return current && Number(current.Level) === 2 ? current.Product_Code : null;
}

function quoted(value) {
  return JSON.stringify(String(value));
}

function viewText(name, exposures, indent = "") {
  const unique = [...new Set(exposures)];
  const lines = [`${indent}view ${name} {`];
  for (const exposure of unique) lines.push(`${indent}    expose ${exposure};`);
  lines.push(`${indent}}`);
  return lines.join("\n");
}

const l1Products = products.filter((product) => Number(product.Level) === 1).sort((a, b) => a.Product_Code.localeCompare(b.Product_Code));
const l2Products = products.filter((product) => Number(product.Level) === 2).sort((a, b) => a.Product_Code.localeCompare(b.Product_Code));

const productViews = [];
productViews.push({
  name: "RV_00_RAIL_FULL_ARCHITECTURE_OVERVIEW",
  category: "00_overview",
  label: "Rail Full Architecture Overview",
  product_codes: products.filter((product) => Number(product.Level) <= 2).map((product) => product.Product_Code),
});
for (const l1 of l1Products) {
  productViews.push({
    name: `RV_01_L1_${l1.Product_Code}_ARCHITECTURE`,
    category: "01_l1",
    label: `L1 ${l1.Product_Code} ${l1.Product_Name}`,
    product_codes: descendants(l1.Product_Code).map((product) => product.Product_Code),
  });
}
for (const l2 of l2Products) {
  productViews.push({
    name: `RV_02_L2_${l2.Product_Code}_DETAIL`,
    category: "02_l2",
    label: `L2 ${l2.Product_Code} ${l2.Product_Name} Detailed View`,
    product_codes: descendants(l2.Product_Code).map((product) => product.Product_Code),
  });
  productViews.push({
    name: `RV_04_L2_${l2.Product_Code}_LEAF_PORTS`,
    category: "04_ports_interfaces",
    label: `L2 ${l2.Product_Code} Leaf Ports and Interfaces`,
    product_codes: descendants(l2.Product_Code).filter((product) => product.Leaf_Status).map((product) => product.Product_Code),
  });
}
const productViewSource = productViews
  .map((view) => viewText(view.name, view.product_codes.map((code) => productByCode.get(code).SysML_Definition.split("::").at(-1))))
  .join("\n\n") + "\n";
fs.writeFileSync(path.join(outputRoot, "01_product_views.sysml"), productViewSource, "utf8");

const functionViews = [];
for (const l1 of l1Products) {
  const functions = mapping.function_allocations.filter((item) => topL1(item.Allocated_Product_Code) === l1.Product_Code);
  functionViews.push({
    name: `RV_06_FUNCTIONS_L1_${l1.Product_Code}`,
    category: "06_functions",
    label: `Functions allocated under L1 ${l1.Product_Code}`,
    function_ids: functions.map((item) => item.Function_ID),
    exposures: functions.map((item) => item.SysML_Function_Path.split("::").at(-1)),
  });
}
fs.writeFileSync(
  path.join(outputRoot, "02_function_views.sysml"),
  functionViews.map((view) => viewText(view.name, view.exposures)).join("\n\n") + "\n",
  "utf8",
);

const allocationRelations = new Map();
for (const match of allocationText.matchAll(/allocation\s+(\w+)\s+allocate\s+(\w+)\s+to\s+(\w+)\s*;/g)) {
  allocationRelations.set(match[1], { function_usage: match[2], product_usage: match[3] });
}
const allocationViews = [];
for (const l1 of l1Products) {
  const allocations = mapping.function_allocations.filter((item) => topL1(item.Allocated_Product_Code) === l1.Product_Code);
  const exposures = [];
  for (const item of allocations) {
    const allocationName = item.SysML_Allocation_Path.split("::").at(-1);
    const relation = allocationRelations.get(allocationName);
    if (!relation) throw new Error(`Allocation relation missing: ${allocationName}`);
    exposures.push(relation.function_usage, relation.product_usage, allocationName);
  }
  allocationViews.push({
    name: `RV_07_ALLOCATIONS_L1_${l1.Product_Code}`,
    category: "07_allocations",
    label: `Function Allocations under L1 ${l1.Product_Code}`,
    allocation_ids: allocations.map((item) => item.Function_ID),
    exposures,
  });
}
fs.writeFileSync(
  path.join(outputRoot, "03_allocation_views.sysml"),
  allocationViews.map((view) => viewText(view.name, view.exposures)).join("\n\n") + "\n",
  "utf8",
);

const interfaceTypeByConnection = new Map();
const endpointPathByConnection = new Map();
for (const match of systemText.matchAll(/interface\s+c_([A-Za-z0-9_]+)\s*:\s*([A-Za-z0-9_]+)\s+connect\s+(\S+)\s+to\s+(\S+)\s*\{/g)) {
  interfaceTypeByConnection.set(match[1].replaceAll("_", "-"), match[2]);
  endpointPathByConnection.set(match[1].replaceAll("_", "-"), { source: match[3], target: match[4] });
}
const rawPortById = new Map(mapping.raw_ports.map((port) => [port.Raw_Port_ID, port]));
const traceByConnection = new Map(
  mapping.traceability.filter((trace) => trace.Connection_ID).map((trace) => [trace.Connection_ID, trace]),
);
const connectionGroups = new Map(l1Products.map((l1) => [l1.Product_Code, []]));
for (const connection of mapping.final_connections) {
  connectionGroups.get(topL1(connection.Source_Leaf)).push(connection);
}

const connectionProjectionViews = [];
const connectionTrace = [];
const connectionLines = ["package RailSysONConnectionViews {", "    private import ScalarValues::*;", "    private import ProductDefinitions::*;", "    private import InterfaceDefinitions::*;"];
const definitionForCode = (code) => productByCode.get(code)?.SysML_Definition.split("::").at(-1) ?? `B_${code.replaceAll("-", "_")}`;
const usageForCode = (code) => `leaf_${definitionForCode(code).replace(/^[PB]_/, "")}`;
for (const l1 of l1Products) {
  const group = connectionGroups.get(l1.Product_Code);
  const leaves = [...new Set(group.flatMap((connection) => [connection.Source_Leaf, connection.Target_Leaf]))].sort();
  connectionLines.push(`    package BySourceL1_${l1.Product_Code} {`);
  for (const leaf of leaves) {
    const definition = definitionForCode(leaf);
    connectionLines.push(`        part ${usageForCode(leaf)} : ${definition};`);
  }
  for (const connection of group) {
    const sourcePort = rawPortById.get(connection.Source_Port);
    const targetPort = rawPortById.get(connection.Target_Port);
    const connectionName = connection.SysML_Connection_Path.split(".").at(-1);
    const type = interfaceTypeByConnection.get(connection.Connection_ID);
    const endpointPaths = endpointPathByConnection.get(connection.Connection_ID);
    if (!endpointPaths || !type) throw new Error(`Connection metadata missing: ${connection.Connection_ID}`);
    const sourcePortName = sourcePort?.SysML_Port_Path.split(".").at(-1) ?? endpointPaths.source.split(".").at(-1);
    const targetPortName = targetPort?.SysML_Port_Path.split(".").at(-1) ?? endpointPaths.target.split(".").at(-1);
    connectionLines.push(`        interface ${connectionName} : ${type} connect ${usageForCode(connection.Source_Leaf)}.${sourcePortName} to ${usageForCode(connection.Target_Leaf)}.${targetPortName} {`);
    connectionLines.push(`            attribute originalConnectionId : String = ${quoted(connection.Connection_ID)};`);
    connectionLines.push(`            attribute originalSysMLPath : String = ${quoted(connection.SysML_Connection_Path)};`);
    connectionLines.push("        }");
    const trace = traceByConnection.get(connection.Connection_ID) ?? {};
    connectionTrace.push({
      derived_element: `RailSysONConnectionViews::BySourceL1_${l1.Product_Code}::${connectionName}`,
      original_connection_id: connection.Connection_ID,
      original_sysml_path: connection.SysML_Connection_Path,
      source_product: connection.Source_Leaf,
      source_port_id: connection.Source_Port,
      target_product: connection.Target_Leaf,
      target_port_id: connection.Target_Port,
      source_file: trace.Source_File ?? null,
      source_sheet: trace.Source_Sheet ?? null,
      source_row: trace.Source_Row ?? null,
    });
  }
  const viewName = `RV_05_CONNECTIONS_SOURCE_L1_${l1.Product_Code}`;
  connectionLines.push(`        view ${viewName} {`);
  for (const leaf of leaves) {
    connectionLines.push(`            expose ${usageForCode(leaf)};`);
  }
  for (const connection of group) connectionLines.push(`            expose ${connection.SysML_Connection_Path.split(".").at(-1)};`);
  connectionLines.push("        }");
  connectionLines.push("    }");
  connectionProjectionViews.push({
    name: viewName,
    category: "05_connections",
    label: `Final Connections sourced under L1 ${l1.Product_Code}`,
    connection_ids: group.map((connection) => connection.Connection_ID),
  });
}
connectionLines.push("}");
fs.writeFileSync(path.join(outputRoot, "04_connection_projection.sysml"), connectionLines.join("\n") + "\n", "utf8");

const portByRelativePath = new Map(
  mapping.raw_ports.map((port) => [port.SysML_Port_Path.replace(/^SystemDefinition::railSystem\./, ""), port]),
);
const netRecords = [];
for (const match of netsText.matchAll(/connection\s+(net_[A-Za-z0-9_]+)\s+connect\s+\(([^)]*)\)\s*\{([\s\S]*?)\n\s*\}/g)) {
  const body = match[3];
  const netId = body.match(/attribute\s+netId\s*:\s*String\s*=\s*"([^"]+)"/)?.[1];
  const itemCode = body.match(/attribute\s+itemCode\s*:\s*String\s*=\s*"([^"]+)"/)?.[1];
  const members = match[2].split(",").map((member) => member.trim()).filter(Boolean);
  netRecords.push({ name: match[1], net_id: netId, item_code: itemCode, members });
}
if (netRecords.length !== 9) throw new Error(`Expected 9 physical nets, found ${netRecords.length}`);

const netProjectionViews = [];
const netTrace = [];
const netLines = ["package RailSysONPhysicalNetworkViews {", "    private import ScalarValues::*;", "    private import ProductDefinitions::*;"];
for (const net of netRecords) {
  const memberPorts = net.members.map((member) => {
    const port = portByRelativePath.get(member);
    if (!port) throw new Error(`Physical net member not mapped: ${member}`);
    return port;
  });
  const leaves = [...new Set(memberPorts.map((port) => port.Leaf_Code))].sort();
  const packageName = net.net_id.replaceAll("-", "_");
  netLines.push(`    package ${packageName} {`);
  for (const leaf of leaves) {
    const definition = productByCode.get(leaf).SysML_Definition.split("::").at(-1);
    netLines.push(`        part leaf_${definition.replace(/^P_/, "")} : ${definition};`);
  }
  const endpoints = memberPorts.map((port) => {
    const leaf = productByCode.get(port.Leaf_Code).SysML_Definition.split("::").at(-1).replace(/^P_/, "");
    return `leaf_${leaf}.${port.SysML_Port_Path.split(".").at(-1)}`;
  });
  netLines.push(`        connection ${net.name} connect (${endpoints.join(", ")}) {`);
  netLines.push(`            attribute originalNetId : String = ${quoted(net.net_id)};`);
  netLines.push(`            attribute originalSysMLPath : String = ${quoted(`PhysicalNetworks::physicalNetworkContext.${net.name}`)};`);
  netLines.push("        }");
  const viewName = `RV_08_PHYSICAL_NET_${packageName}`;
  netLines.push(`        view ${viewName} {`);
  for (const leaf of leaves) netLines.push(`            expose leaf_${productByCode.get(leaf).SysML_Definition.split("::").at(-1).replace(/^P_/, "")};`);
  netLines.push(`            expose ${net.name};`);
  netLines.push("        }");
  netLines.push("    }");
  netProjectionViews.push({
    name: viewName,
    category: "08_physical_nets",
    label: `Physical Network ${net.net_id}`,
    physical_net_ids: [net.net_id],
  });
  netTrace.push({
    derived_element: `RailSysONPhysicalNetworkViews::${packageName}::${net.name}`,
    original_net_id: net.net_id,
    original_sysml_path: `PhysicalNetworks::physicalNetworkContext.${net.name}`,
    item_code: net.item_code,
    member_ports: memberPorts.map((port) => ({ product_code: port.Leaf_Code, port_id: port.Raw_Port_ID, sysml_path: port.SysML_Port_Path })),
  });
}
netLines.push("}");
fs.writeFileSync(path.join(outputRoot, "05_physical_network_projection.sysml"), netLines.join("\n") + "\n", "utf8");

const l2BoundaryView = {
  name: "RV_00_ALL16_L2_BOUNDARY_OVERVIEW",
  category: "00_overview",
  label: "Full L2 Interface Overview (All 16 L2)",
  component_codes: ssi.l2_inventory.map((item) => item.code),
  connection_ids: ssi.connection_mapping.map((item) => item.connection_id),
};
const coreCodes = new Set(["3100", "3500", "4200", "4500", "5100", "5300", "7200", "X100"]);
const coreConnections = ssi.connection_mapping.filter((item) => coreCodes.has(item.source_l2) && coreCodes.has(item.target_l2));
const regenerativeView = {
  name: "RV_09_REGENERATIVE_BRAKING_CORE",
  category: "09_regenerative_braking",
  label: "Regenerative Braking Core",
  component_codes: [...coreCodes],
  connection_ids: coreConnections.map((item) => item.connection_id),
};
const ssiViewSource = [
  viewText(l2BoundaryView.name, [
    ...l2BoundaryView.component_codes.map((code) => `L2_${code}`),
    ...ssi.connection_mapping.map((item) => item.connection_usage),
  ]),
  viewText(regenerativeView.name, [
    ...regenerativeView.component_codes.map((code) => `L2_${code}`),
    ...coreConnections.map((item) => item.connection_usage),
  ]),
].join("\n\n") + "\n";
fs.writeFileSync(path.join(outputRoot, "06_ssi_l2_views.sysml"), ssiViewSource, "utf8");

const allViews = [
  ...productViews,
  ...functionViews,
  ...allocationViews,
  ...connectionProjectionViews,
  ...netProjectionViews,
  l2BoundaryView,
  regenerativeView,
];
const sourceHashes = {};
for (const filename of fs.readdirSync(outputRoot).filter((filename) => filename.endsWith(".sysml")).sort()) {
  const content = fs.readFileSync(path.join(outputRoot, filename));
  sourceHashes[filename] = crypto.createHash("sha256").update(content).digest("hex");
}
const manifest = {
  authoritative_full_sysml: ssi.authoritative_source,
  authoritative_full_sysml_sha256: ssi.full_model_sha256,
  generation_type: "DERIVED_SYSON_VISUALIZATION_ONLY",
  manually_maintained_second_model: false,
  counts: {
    products: products.length,
    ports: mapping.raw_ports.length,
    functions: mapping.function_allocations.length,
    allocations: mapping.function_allocations.length,
    final_connections: mapping.final_connections.length,
    physical_nets: netRecords.length,
    l2: l2Products.length,
    planned_views: allViews.length,
  },
  view_definitions: allViews,
  connection_projection_trace: connectionTrace,
  physical_network_projection_trace: netTrace,
  source_hashes: sourceHashes,
};
fs.writeFileSync(path.join(outputRoot, "SysON_View_Projection_Manifest.json"), `${JSON.stringify(manifest, null, 2)}\n`, "utf8");

process.stdout.write(`${JSON.stringify(manifest.counts, null, 2)}\n`);
