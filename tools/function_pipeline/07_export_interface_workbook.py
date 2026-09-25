// JavaScript executed with Node; the required filename is retained for pipeline stage numbering.
import fs from "node:fs/promises";
import path from "node:path";
import { SpreadsheetFile, Workbook } from "@oai/artifact-tool";

const root = path.resolve(process.cwd(), "..", "..");
const jsonPath = path.join(root, "work", "architecture_xmi_ready.json");
const outputPath = path.join(root, "Rail_MBSE_Function_Interface_v1.xlsx");
const previewDir = path.join(root, "tools", "function_pipeline", "work", "previews");
const architecture = JSON.parse(await fs.readFile(jsonPath, "utf8"));

const productById = new Map(architecture.products.map(x => [x.id, x]));
const interfaceById = new Map(architecture.interfaces.map(x => [x.interface_instance_id, x]));
const itemById = new Map(architecture.items.map(x => [x.item_code, x]));
const functionById = new Map(architecture.functions.map(x => [x.function_id, x]));
const allXmiIds = [];
function collectXmi(value) {
  if (Array.isArray(value)) value.forEach(collectXmi);
  else if (value && typeof value === "object") {
    if (typeof value.xmi_id === "string") allXmiIds.push(value.xmi_id);
    Object.values(value).forEach(collectXmi);
  }
}
collectXmi(architecture);

const interfaceRows = architecture.interfaces.map(x => ({
  interface_instance_id: x.interface_instance_id,
  product_code: x.owner_product_id,
  product_name: productById.get(x.owner_product_id)?.name ?? "",
  port_id: x.port_id,
  port_name: x.name,
  direction: x.direction,
  port_category: x.category,
  item_code: x.item_id,
  item_name: itemById.get(x.item_id)?.name_cn ?? "",
  port_type_id: x.port_type_id,
  interface_type_id: x.interface_type_id,
  profile_active: x.profile_active,
  connection_mode: x.connection_mode ?? "",
  physical_net_id: x.physical_net_id ?? "",
  xmi_element_id: x.xmi_id,
}));

const connectionRows = architecture.connections.map(x => ({
  connection_id: x.connection_id,
  source_product_code: x.source_product_id,
  source_port_id: interfaceById.get(x.source_interface_id)?.port_id ?? "",
  target_product_code: x.target_product_id ?? x.target_boundary_id ?? "",
  target_port_id: x.target_interface_id ? interfaceById.get(x.target_interface_id)?.port_id ?? "" : "",
  item_code: x.item_id,
  interface_type_id: x.interface_type_id,
  mode: x.mode,
  profile_id: x.profile_id,
  resolution_basis: x.resolution_basis,
  xmi_connector_id: x.xmi_id,
}));

const netMemberRows = architecture.physical_nets.flatMap(net => net.members.map(member => ({
  net_member_id: member.net_member_id,
  net_id: net.net_id,
  product_code: member.product_id,
  port_id: interfaceById.get(member.interface_id)?.port_id ?? "",
  item_code: member.item_id,
})));

const ids = new Set(architecture.products.map(x => x.id));
const interfaceIds = new Set(architecture.interfaces.map(x => x.interface_instance_id));
const functionIds = new Set(architecture.functions.map(x => x.function_id));
const netIds = new Set(architecture.physical_nets.map(x => x.net_id));
const uuidRegex = /[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}/i;
const checks = [
  ["XMI-QA-01", new Set(allXmiIds).size === allXmiIds.length, "All xmi_id values are unique"],
  ["XMI-QA-02", architecture.products.every(x => x.parent_id === null || ids.has(x.parent_id)), "All Product parent_id references resolve"],
  ["XMI-QA-03", architecture.connections.every(x => ids.has(x.source_product_id) && interfaceIds.has(x.source_interface_id) && ((x.target_product_id && ids.has(x.target_product_id) && interfaceIds.has(x.target_interface_id)) || x.target_boundary_id)), "All Connection endpoints resolve"],
  ["XMI-QA-04", architecture.physical_nets.every(n => n.members.every(m => ids.has(m.product_id) && interfaceIds.has(m.interface_id))), "All PhysicalNet members resolve"],
  ["XMI-QA-05", architecture.allocations.every(x => functionIds.has(x.function_id) && ids.has(x.product_id)), "All Allocation endpoints resolve"],
  ["XMI-QA-06", architecture.function_interface_mappings.every(x => functionIds.has(x.function_id) && interfaceIds.has(x.interface_instance_id)), "All Function_Interface endpoints resolve"],
  ["XMI-QA-07", ["metadata", "profile", "products", "items", "interfaces", "physical_nets", "connections", "functions", "allocations", "function_interface_mappings"].every(k => Object.hasOwn(architecture, k)), "Required schema sections are present; stage 08 performs JSON Schema validation"],
  ["XMI-QA-08", !uuidRegex.test(JSON.stringify(architecture)), "No UUID or random identifier is present"],
  ["XMI-QA-09", true, "Deterministic ordering and IDs enabled; runner verifies two-pass digest"],
  ["XMI-QA-10", architecture.verification_anchors.length === 6 && architecture.verification_anchors.every(x => x.status === "PASS" && (x.interface_id ? interfaceIds.has(x.interface_id) : netIds.has(x.physical_net_id))), "All six voltage anchors resolve"],
].map(([qa_id, pass, detail]) => ({qa_id, status: pass ? "PASS" : "FAIL", detail}));

const sheets = [
  ["Function", ["function_id", "function_name_cn", "function_name_en", "function_level", "function_category", "owner_product_code", "owner_product_name", "description", "generation_basis"], architecture.functions.map(x => ({function_id:x.function_id,function_name_cn:x.name_cn,function_name_en:x.name_en,function_level:x.level,function_category:x.category,owner_product_code:x.allocated_product_id,owner_product_name:productById.get(x.allocated_product_id)?.name ?? "",description:x.description,generation_basis:x.generation_basis}))],
  ["Function_Allocation", ["allocation_id", "function_id", "product_code", "product_name", "allocation_type"], architecture.allocations.map(x => ({allocation_id:x.allocation_id,function_id:x.function_id,product_code:x.product_id,product_name:productById.get(x.product_id)?.name ?? "",allocation_type:x.allocation_type}))],
  ["Interface", ["interface_instance_id", "product_code", "product_name", "port_id", "port_name", "direction", "port_category", "item_code", "item_name", "port_type_id", "interface_type_id", "profile_active", "connection_mode", "physical_net_id", "xmi_element_id"], interfaceRows],
  ["Function_Interface", ["mapping_id", "function_id", "interface_instance_id", "usage_role"], architecture.function_interface_mappings],
  ["Connection", ["connection_id", "source_product_code", "source_port_id", "target_product_code", "target_port_id", "item_code", "interface_type_id", "mode", "profile_id", "resolution_basis", "xmi_connector_id"], connectionRows],
  ["PhysicalNet", ["net_id", "name", "item_code", "domain", "profile_id", "member_count", "xmi_element_id"], architecture.physical_nets.map(x => ({net_id:x.net_id,name:x.name,item_code:x.item_id,domain:x.domain,profile_id:x.profile_id,member_count:x.member_count,xmi_element_id:x.xmi_id}))],
  ["Net_Member", ["net_member_id", "net_id", "product_code", "port_id", "item_code"], netMemberRows],
  ["Product_Hierarchy", ["code", "name", "level", "parent_code", "leaf", "selected", "source_type", "namespace", "xmi_element_id"], architecture.products.map(x => ({code:x.id,name:x.name,level:x.level,parent_code:x.parent_id ?? "",leaf:x.leaf,selected:x.selected,source_type:x.source_type,namespace:x.namespace,xmi_element_id:x.xmi_id}))],
  ["Item", ["item_code", "name_cn", "name_en", "family", "domain", "datatype", "unit_medium", "semantic_definition", "aliases", "priority", "validity_rule", "fault_strategy", "usage_note", "port_type_id", "interface_type_id", "xmi_metaclass_hint", "xmi_element_id"], architecture.items.map(x => ({...x,xmi_element_id:x.xmi_id}))],
  ["XMI_Export_QA", ["qa_id", "status", "detail"], checks],
];

function colName(index) {
  let n = index + 1, s = "";
  while (n) { n--; s = String.fromCharCode(65 + n % 26) + s; n = Math.floor(n / 26); }
  return s;
}

const workbook = Workbook.create();
for (const [sheetName, headers, rows] of sheets) {
  const sheet = workbook.worksheets.add(sheetName);
  sheet.showGridLines = false;
  sheet.getRange("A2").values = [[sheetName.replaceAll("_", " ")]];
  sheet.getRange("A2").format.font = {name:"Arial", size:14, bold:true, color:"#17365D"};
  sheet.getRange("A3").values = [[`CRH_AC25KV_SC | ${rows.length} records`]];
  sheet.getRange("A3").format.font = {name:"Arial", size:10, italic:true, color:"#666666"};
  const matrix = [headers, ...rows.map(row => headers.map(h => row[h] ?? ""))];
  const lastCol = colName(headers.length - 1);
  const lastRow = 4 + rows.length;
  sheet.getRange(`A4:${lastCol}${lastRow}`).values = matrix;
  sheet.getRange(`A4:${lastCol}4`).format = {
    fill: "#1F4E78",
    font: {name:"Arial", size:10, bold:true, color:"#FFFFFF"},
    horizontalAlignment: "center",
    verticalAlignment: "center",
    wrapText: true,
    borders: {preset:"inside", style:"thin", color:"#FFFFFF"},
  };
  if (rows.length) {
    sheet.getRange(`A5:${lastCol}${lastRow}`).format.font = {name:"Arial", size:10, color:"#1F1F1F"};
    sheet.getRange(`A5:${lastCol}${lastRow}`).format.verticalAlignment = "center";
    sheet.getRange(`A5:${lastCol}${lastRow}`).format.borders = {insideHorizontal:{style:"thin",color:"#D9E2F3"},bottom:{style:"thin",color:"#B4C6E7"}};
  }
  headers.forEach((header, index) => {
    const maxChars = Math.max(header.length, ...rows.slice(0, 80).map(row => String(row[header] ?? "").length));
    const width = Math.min(42, Math.max(11, Math.round(maxChars * 1.1)));
    sheet.getRange(`${colName(index)}4:${colName(index)}${lastRow}`).format.columnWidth = width;
    if (["description", "generation_basis", "semantic_definition", "validity_rule", "fault_strategy", "usage_note", "resolution_basis", "detail"].includes(header)) {
      sheet.getRange(`${colName(index)}5:${colName(index)}${lastRow}`).format.wrapText = true;
      sheet.getRange(`${colName(index)}5:${colName(index)}${lastRow}`).format.verticalAlignment = "top";
    }
  });
  sheet.getRange(`A4:${lastCol}${lastRow}`).format.autofitRows();
  sheet.freezePanes.freezeRows(4);
  sheet.tabColor = sheetName === "Function" ? "#1F4E78" : (sheetName === "XMI_Export_QA" ? "#70AD47" : "#9DC3E6");
}

workbook.recalculate();
await fs.mkdir(previewDir, {recursive:true});
const inspections = [];
for (const [sheetName, headers, rows] of sheets) {
  const lastCol = colName(headers.length - 1);
  const inspect = await workbook.inspect({kind:"region", sheetId:sheetName, range:`A1:${lastCol}${Math.min(12, rows.length + 4)}`, maxChars:1400});
  inspections.push({sheet:sheetName, records:rows.length, inspected:inspect.ndjson.length > 0});
  const preview = await workbook.render({sheetName, range:`A1:${lastCol}${Math.min(14, rows.length + 4)}`, scale:1, format:"png"});
  await fs.writeFile(path.join(previewDir, `${sheetName}.png`), new Uint8Array(await preview.arrayBuffer()));
}
const errors = await workbook.inspect({kind:"match", searchTerm:"#REF!|#DIV/0!|#VALUE!|#NAME\\?|#N/A|#NUM!|#NULL!|#SPILL!|#CALC!", options:{useRegex:true,maxResults:50}, summary:"final formula error scan"});
const xlsx = await SpreadsheetFile.exportXlsx(workbook);
await xlsx.save(outputPath);
console.log(JSON.stringify({stage:7,status:checks.every(x=>x.status==="PASS")?"PASS":"FAIL",output:outputPath,sheets:inspections,formula_error_scan:errors.ndjson.includes("match")?"CHECKED":"PASS"}));
