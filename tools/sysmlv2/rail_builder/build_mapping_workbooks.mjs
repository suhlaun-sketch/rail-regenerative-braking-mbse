import fs from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { SpreadsheetFile, Workbook } from "@oai/artifact-tool";

const toolDir = path.dirname(fileURLToPath(import.meta.url));
const projectRoot = path.resolve(toolDir, "..", "..", "..");
const mappingDir = path.join(projectRoot, "work", "sysmlv2", "full_engineering_model", "02_mapping");
const snapshotDir = path.join(projectRoot, "work", "sysmlv2", "full_engineering_model", "05_snapshots");
const payload = JSON.parse(await fs.readFile(path.join(mappingDir, "mapping_payload.json"), "utf8"));

const specs = [
  ["RawPort_to_SysMLPort_Mapping.xlsx", "Raw Port Mapping", payload.raw_ports],
  ["Function_to_Product_Allocation_Mapping.xlsx", "Function Allocation", payload.function_to_product],
  ["SysML_Element_Traceability.xlsx", "Traceability", payload.traceability],
  ["Product_Hierarchy_Mapping.xlsx", "Product Hierarchy", payload.product_hierarchy],
  ["Leaf_Port_Mapping.xlsx", "Leaf Port Mapping", payload.leaf_ports],
  ["Final_Connection_Mapping.xlsx", "Final Connections", payload.final_connections],
  ["Function_Allocation_Mapping.xlsx", "Function Mapping", payload.function_allocations],
];

function colName(index) {
  let out = "";
  for (let n = index + 1; n > 0; n = Math.floor((n - 1) / 26)) out = String.fromCharCode(65 + ((n - 1) % 26)) + out;
  return out;
}

await fs.mkdir(mappingDir, { recursive: true });
await fs.mkdir(snapshotDir, { recursive: true });

for (const [fileName, title, records] of specs) {
  const wb = Workbook.create();
  const ws = wb.worksheets.add("Mapping");
  ws.showGridLines = false;
  const headers = records.length ? Object.keys(records[0]) : ["Status"];
  const values = records.length
    ? records.map((row) => headers.map((h) => row[h] === undefined || row[h] === null ? null : (typeof row[h] === "object" ? JSON.stringify(row[h]) : row[h])))
    : [["No records"]];
  const lastCol = colName(headers.length - 1);
  const lastRow = 4 + values.length;
  ws.getRange("A2").values = [[title]];
  ws.getRange("A2").format.font = { name: "Arial", size: 14, bold: true, color: "#17365D" };
  ws.getRange("A3").values = [[`Source: Rail_MBSE_Function_Interface_v1_final.xlsx | Records: ${records.length}`]];
  ws.getRange("A3").format.font = { name: "Arial", size: 10, italic: true, color: "#666666" };
  ws.getRange(`A4:${lastCol}4`).values = [headers];
  ws.getRange(`A5:${lastCol}${lastRow}`).values = values;
  ws.getRange(`A4:${lastCol}${lastRow}`).format.font = { name: "Arial", size: 10, color: "#222222" };
  ws.getRange(`A4:${lastCol}4`).format = { fill: "#1F4E78", font: { name: "Arial", size: 10, bold: true, color: "#FFFFFF" }, horizontalAlignment: "center", verticalAlignment: "center", wrapText: true };
  ws.getRange(`A5:${lastCol}${lastRow}`).format.verticalAlignment = "center";
  ws.getRange(`A5:${lastCol}${lastRow}`).format.borders = { insideHorizontal: { style: "thin", color: "#D9E2F3" } };
  const table = ws.tables.add(`A4:${lastCol}${lastRow}`, true, `T_${fileName.replace(/[^A-Za-z0-9]/g, "_").slice(0, 150)}`);
  table.style = "TableStyleMedium2";
  ws.freezePanes.freezeRows(4);
  for (let c = 0; c < headers.length; c++) {
    const longest = Math.max(headers[c].length, ...values.slice(0, 100).map((r) => String(r[c] ?? "").length));
    ws.getRangeByIndexes(0, c, lastRow, 1).format.columnWidth = Math.min(42, Math.max(12, longest + 2));
  }
  ws.getRange("A2:A3").format.rowHeight = 22;
  wb.recalculate();
  const check = await wb.inspect({ kind: "table", range: `Mapping!A2:${lastCol}${Math.min(lastRow, 10)}`, include: "values,formulas", tableMaxRows: 10, tableMaxCols: Math.min(headers.length, 16) });
  const errors = await wb.inspect({ kind: "match", searchTerm: "#REF!|#DIV/0!|#VALUE!|#NAME\\?|#N/A|#NUM!|#NULL!|#SPILL!|#CALC!", options: { useRegex: true, maxResults: 100 }, summary: "final formula error scan" });
  if ((errors.ndjson || "").includes('"match"')) throw new Error(`Formula error in ${fileName}: ${errors.ndjson}`);
  const preview = await wb.render({ sheetName: "Mapping", range: `A1:${lastCol}${Math.min(lastRow, 30)}`, scale: 1, format: "png" });
  await fs.writeFile(path.join(snapshotDir, fileName.replace(/\.xlsx$/, ".png")), new Uint8Array(await preview.arrayBuffer()));
  const output = await SpreadsheetFile.exportXlsx(wb);
  await output.save(path.join(mappingDir, fileName));
  console.log(`${fileName}: rows=${records.length}; inspect=${(check.ndjson || "").length}`);
}
