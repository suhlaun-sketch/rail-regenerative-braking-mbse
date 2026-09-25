import fs from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { SpreadsheetFile, Workbook } from "@oai/artifact-tool";

const outputDir = path.dirname(fileURLToPath(import.meta.url));
const jsonPath = path.join(outputDir, "Rail_MBSE_FMU_Implementation_Binding_v1.json");
const xlsxPath = path.join(outputDir, "Rail_MBSE_FMU_Implementation_Binding_v1.xlsx");
const previewDir = "C:/Users/AUSA/AppData/Local/Temp/codex_fmu_binding_previews";
const data = JSON.parse(await fs.readFile(jsonPath, "utf8"));

const workbook = Workbook.create();
const summary = workbook.worksheets.add("Summary");
const components = workbook.worksheets.add("Components");
const connectors = workbook.worksheets.add("Connector Bindings");
const connections = workbook.worksheets.add("Connection Bindings");
const readme = workbook.worksheets.add("ReadMe");
const fontFamily = "Arial";
const navy = "#1F4E78";
const blue = "#D9EAF7";
const lightBlue = "#EAF3F8";
const amber = "#FFF2CC";
const red = "#FCE4D6";
const green = "#E2F0D9";
const gray = "#E7E6E6";
const darkText = "#1F2937";

function flatten(value) {
  if (Array.isArray(value)) return value.join(" | ");
  if (value && typeof value === "object") return JSON.stringify(value);
  return value ?? "";
}

function applyBase(sheet) {
  sheet.showGridLines = false;
  const used = sheet.getUsedRange();
  if (used) {
    used.format.font = { name: fontFamily, size: 10, color: darkText };
    used.format.verticalAlignment = "center";
  }
}

function styleHeader(range) {
  range.format = {
    fill: navy,
    font: { name: fontFamily, size: 10, bold: true, color: "#FFFFFF" },
    horizontalAlignment: "center",
    verticalAlignment: "center",
    wrapText: true,
    borders: { preset: "inside", style: "thin", color: "#FFFFFF" },
  };
  range.format.rowHeight = 32;
}

function addStatusFormatting(range) {
  range.conditionalFormats.add("containsText", {
    text: "READY",
    format: { fill: green, font: { color: "#375623", bold: true } },
  });
  range.conditionalFormats.add("containsText", {
    text: "REVIEW",
    format: { fill: amber, font: { color: "#7F6000", bold: true } },
  });
  range.conditionalFormats.add("containsText", {
    text: "CONFLICT",
    format: { fill: red, font: { color: "#9C0006", bold: true } },
  });
  range.conditionalFormats.add("containsText", {
    text: "MISSING",
    format: { fill: red, font: { color: "#9C0006", bold: true } },
  });
}

// Summary
summary.getRange("A2:H2").format.borders = {
  bottom: { style: "medium", color: navy },
};
summary.getRange("A2").values = [["FMU Implementation Binding Baseline"]];
summary.getRange("A2").format.font = { name: fontFamily, size: 14, bold: true, color: navy };
summary.getRange("A4:B4").values = [["Baseline", "Value"]];
summary.getRange("A5:B10").values = [
  ["Authority", "Final All16 SSD"],
  ["Authoritative SSD", data.baseline.authoritative_ssd],
  ["Components", data.baseline.components],
  ["Connectors", data.baseline.connectors],
  ["Connections", data.baseline.connections],
  ["Overall status", data.baseline.status],
];
styleHeader(summary.getRange("A4:B4"));
summary.getRange("A5:A10").format.fill = lightBlue;
summary.getRange("A5:A10").format.font = { name: fontFamily, size: 10, bold: true, color: darkText };
summary.getRange("D4:E4").values = [["Connector readiness", "Count"]];
summary.getRange("D5:E11").values = [
  ["READY", data.readiness.READY_connectors],
  ["UNIT_MISSING", data.readiness.UNIT_MISSING],
  ["TYPE_MISSING", data.readiness.TYPE_MISSING],
  ["DIRECTION_REVIEW_REQUIRED", data.readiness.DIRECTION_REVIEW_REQUIRED],
  ["SEMANTIC_REVIEW_REQUIRED", data.readiness.SEMANTIC_REVIEW_REQUIRED],
  ["LEGACY_CONTRACT_CONFLICT", data.readiness.LEGACY_CONTRACT_CONFLICT],
  ["Review-required connectors", data.readiness.review_required_connectors],
];
styleHeader(summary.getRange("D4:E4"));
summary.getRange("D5:D11").format.fill = lightBlue;
summary.getRange("D5:D11").format.font = { name: fontFamily, size: 10, bold: true, color: darkText };
addStatusFormatting(summary.getRange("D5:D11"));
summary.getRange("G4:H4").values = [["Connection validation", "Count"]];
summary.getRange("G5:H7").values = [
  ["Total", data.readiness.connections_total],
  ["Valid", data.readiness.connection_bindings_valid],
  ["Review required", data.readiness.connection_bindings_review_required],
];
styleHeader(summary.getRange("G4:H4"));
summary.getRange("G5:G7").format.fill = lightBlue;
summary.getRange("G5:G7").format.font = { name: fontFamily, size: 10, bold: true, color: darkText };
summary.getRange("A13:B13").values = [["Structural validation", "Result"]];
const validationRows = [
  ["Component Binding", data.validation.component_binding],
  ["Connector Binding Records", data.validation.connector_binding_records],
  ["Connection Binding Records", data.validation.connection_binding_records],
  ["No orphan SSD connector", data.validation.no_orphan_ssd_connector ? "YES" : "NO"],
  ["No invented connector", data.validation.no_invented_connector ? "YES" : "NO"],
  ["No invented connection", data.validation.no_invented_connection ? "YES" : "NO"],
  ["No duplicate binding_id", data.validation.no_duplicate_binding_id ? "YES" : "NO"],
  ["Original SSD Modified", data.source_integrity.original_ssd_modified ? "YES" : "NO"],
  ["Full SysML Modified", data.source_integrity.full_sysml_modified ? "YES" : "NO"],
];
summary.getRange(`A14:B${13 + validationRows.length}`).values = validationRows;
styleHeader(summary.getRange("A13:B13"));
summary.getRange(`A14:A${13 + validationRows.length}`).format.fill = lightBlue;
summary.getRange(`A14:A${13 + validationRows.length}`).format.font = { name: fontFamily, size: 10, bold: true, color: darkText };
summary.getRange("D13:E13").values = [["Legacy comparison", "Count"]];
summary.getRange("D14:E17").values = [
  ["MATCHED", data.legacy_contract_comparison.MATCHED],
  ["AMBIGUOUS", data.legacy_contract_comparison.AMBIGUOUS],
  ["NOT_FOUND", data.legacy_contract_comparison.NOT_FOUND],
  ["CONFLICT", data.legacy_contract_comparison.CONFLICT],
];
styleHeader(summary.getRange("D13:E13"));
summary.getRange("D14:D17").format.fill = lightBlue;
summary.getRange("D14:D17").format.font = { name: fontFamily, size: 10, bold: true, color: darkText };
addStatusFormatting(summary.getRange("D14:D17"));
summary.getRange("A25").values = [["This workbook is an implementation binding view, not a new interface standard. The final All16 SSD remains authoritative."]];
summary.getRange("A25:H25").format = {
  fill: gray,
  font: { name: fontFamily, size: 10, italic: true, color: darkText },
};
summary.getRange("A:A").format.columnWidth = 28;
summary.getRange("B:B").format.columnWidth = 68;
summary.getRange("C:C").format.columnWidth = 3;
summary.getRange("D:D").format.columnWidth = 34;
summary.getRange("E:E").format.columnWidth = 14;
summary.getRange("F:F").format.columnWidth = 3;
summary.getRange("G:G").format.columnWidth = 28;
summary.getRange("H:H").format.columnWidth = 14;
addStatusFormatting(summary.getRange("B10"));

// Component inventory
const componentHeaders = [
  "ssd_component_id",
  "ssd_component_name",
  "l2_code",
  "l2_engineering_name",
  "full_sysml_path",
  "simulation_model_name",
  "future_fmu_file",
  "connector_count",
  "connected_l2_peers",
  "readiness",
];
const componentRows = data.components.map((row) => componentHeaders.map((key) => flatten(row[key])));
components.getRange("A1:J1").values = [componentHeaders];
components.getRange(`A2:J${componentRows.length + 1}`).values = componentRows;
styleHeader(components.getRange("A1:J1"));
components.freezePanes.freezeRows(1);
components.freezePanes.freezeColumns(4);
components.getRange("A:J").format.columnWidth = 18;
components.getRange("D:D").format.columnWidth = 24;
components.getRange("E:E").format.columnWidth = 52;
components.getRange("I:I").format.columnWidth = 60;
components.getRange("J:J").format.columnWidth = 20;
components.getRange(`H2:H${componentRows.length + 1}`).format.numberFormat = "0";
addStatusFormatting(components.getRange(`J2:J${componentRows.length + 1}`));

// Connector bindings
const connectorHeaders = [
  "binding_id",
  "ssd_component_id",
  "ssd_component_name",
  "l2_code",
  "l2_name",
  "ssd_connector_name",
  "ssd_connector_id",
  "direction",
  "data_type",
  "unit",
  "quantity",
  "item_type",
  "item_code",
  "item_name",
  "item_name_en",
  "item_unit_or_medium",
  "interface_type",
  "original_sysml_path",
  "original_product_code",
  "original_product_name",
  "original_port_name",
  "original_port_id",
  "source_connection_ids",
  "simulink_model",
  "simulink_port_name",
  "simulink_port_type",
  "future_fmu_file",
  "future_fmu_variable",
  "future_fmu_causality",
  "future_fmu_variability",
  "alias_reason",
  "legacy_match",
  "legacy_conflict_fields",
  "review_flags",
  "binding_status",
  "notes",
];
const connectorRows = data.connector_bindings.map((row) => connectorHeaders.map((key) => flatten(row[key])));
connectors.getRange(`A1:AJ1`).values = [connectorHeaders];
connectors.getRange(`A2:AJ${connectorRows.length + 1}`).values = connectorRows;
styleHeader(connectors.getRange("A1:AJ1"));
connectors.freezePanes.freezeRows(1);
connectors.freezePanes.freezeColumns(7);
connectors.getRange("A:AJ").format.columnWidth = 18;
for (const col of ["A", "F", "G", "R", "V", "W", "Y", "AB"]) connectors.getRange(`${col}:${col}`).format.columnWidth = 34;
for (const col of ["AE", "AG", "AH", "AJ"]) connectors.getRange(`${col}:${col}`).format.columnWidth = 40;
connectors.getRange("S:S").format.columnWidth = 16;
connectors.getRange("T:T").format.columnWidth = 24;
connectors.getRange("U:U").format.columnWidth = 30;
connectors.getRange("AF:AF").format.columnWidth = 18;
connectors.getRange("AI:AI").format.columnWidth = 28;
addStatusFormatting(connectors.getRange(`AF2:AF${connectorRows.length + 1}`));
addStatusFormatting(connectors.getRange(`AI2:AI${connectorRows.length + 1}`));

// Connection bindings
const connectionHeaders = [
  "connection_id",
  "source_component",
  "source_connector",
  "target_component",
  "target_connector",
  "source_future_fmu",
  "source_future_fmu_variable",
  "target_future_fmu",
  "target_future_fmu_variable",
  "source_direction",
  "target_direction",
  "source_data_type",
  "target_data_type",
  "source_unit",
  "target_unit",
  "interface_type",
  "item_code",
  "status",
  "review_reasons",
];
const connectionRows = data.connection_bindings.map((row) => connectionHeaders.map((key) => flatten(row[key])));
connections.getRange("A1:S1").values = [connectionHeaders];
connections.getRange(`A2:S${connectionRows.length + 1}`).values = connectionRows;
styleHeader(connections.getRange("A1:S1"));
connections.freezePanes.freezeRows(1);
connections.freezePanes.freezeColumns(5);
connections.getRange("A:S").format.columnWidth = 18;
for (const col of ["A", "C", "E", "G", "I"]) connections.getRange(`${col}:${col}`).format.columnWidth = 38;
connections.getRange("R:R").format.columnWidth = 38;
connections.getRange("S:S").format.columnWidth = 48;
addStatusFormatting(connections.getRange(`R2:R${connectionRows.length + 1}`));

// ReadMe
readme.getRange("A2:F2").format.borders = {
  bottom: { style: "medium", color: navy },
};
readme.getRange("A2").values = [["Implementation Binding Notes"]];
readme.getRange("A2").format.font = { name: fontFamily, size: 14, bold: true, color: navy };
readme.getRange("A4:B4").values = [["Topic", "Definition"]];
readme.getRange("A5:B13").values = [
  ["Authority", "The final Rail_MBSE_L2_All16_v1.ssd is the only authoritative interface baseline."],
  ["Purpose", "SSD Connector → Simulink external port → FMU exposed variable"],
  ["Legacy contract", "Enrichment only. It cannot add a connector or override SSD direction, type, unit, or name."],
  ["Default name", "SSD Connector name = Simulink port name = future FMU variable name"],
  ["Input mapping", "SSD input → Simulink Inport → FMU causality input"],
  ["Output mapping", "SSD output → Simulink Outport → FMU causality output"],
  ["SEMANTIC_REVIEW_REQUIRED", "The SSD field exists, but Full SysML item semantics require implementation interpretation."],
  ["LEGACY_CONTRACT_CONFLICT", "A unique legacy candidate conflicts with the SSD. The SSD value is retained."],
  ["Connection review", "Direction, type, or unit compatibility requires review. No source model is modified here."],
];
styleHeader(readme.getRange("A4:B4"));
readme.getRange("A5:A13").format.fill = lightBlue;
readme.getRange("A5:A13").format.font = { name: fontFamily, size: 10, bold: true, color: darkText };
readme.getRange("A:A").format.columnWidth = 32;
readme.getRange("B:B").format.columnWidth = 100;
readme.getRange("B5:B13").format.wrapText = true;
readme.getRange("B5:B13").format.rowHeight = 34;

for (const sheet of [summary, components, connectors, connections, readme]) applyBase(sheet);
styleHeader(summary.getRange("A4:B4"));
styleHeader(summary.getRange("D4:E4"));
styleHeader(summary.getRange("G4:H4"));
styleHeader(summary.getRange("A13:B13"));
styleHeader(summary.getRange("D13:E13"));
styleHeader(components.getRange("A1:J1"));
styleHeader(connectors.getRange("A1:AJ1"));
styleHeader(connections.getRange("A1:S1"));
styleHeader(readme.getRange("A4:B4"));
summary.getRange("A2").format.font = { name: fontFamily, size: 14, bold: true, color: navy };
readme.getRange("A2").format.font = { name: fontFamily, size: 14, bold: true, color: navy };
summary.getRange("A25").format.font = { name: fontFamily, size: 10, italic: true, color: darkText };
workbook.recalculate();

const summaryInspect = await workbook.inspect({
  kind: "table",
  range: "Summary!A2:H25",
  include: "values,formulas",
  tableMaxRows: 30,
  tableMaxCols: 10,
});
console.log(summaryInspect.ndjson);
const connectorInspect = await workbook.inspect({
  kind: "table",
  range: "Connector Bindings!A1:AJ6",
  include: "values,formulas",
  tableMaxRows: 8,
  tableMaxCols: 36,
});
console.log(connectorInspect.ndjson);
const errors = await workbook.inspect({
  kind: "match",
  searchTerm: "#REF!|#DIV/0!|#VALUE!|#NAME\\?|#N/A|#NUM!|#NULL!|#SPILL!|#CALC!",
  options: { useRegex: true, maxResults: 300 },
  summary: "final formula error scan",
});
console.log(errors.ndjson);

await fs.mkdir(previewDir, { recursive: true });
for (const [sheetName, range] of [
  ["Summary", "A1:H25"],
  ["Components", "A1:J17"],
  ["Connector Bindings", "A1:AJ18"],
  ["Connection Bindings", "A1:S18"],
  ["ReadMe", "A1:B14"],
]) {
  const preview = await workbook.render({ sheetName, range, scale: 1, format: "png" });
  await fs.writeFile(`${previewDir}/${sheetName.replaceAll(" ", "_")}.png`, new Uint8Array(await preview.arrayBuffer()));
  console.log(`RENDERED ${sheetName}`);
}

const output = await SpreadsheetFile.exportXlsx(workbook);
await output.save(xlsxPath);
console.log(`EXPORTED ${xlsxPath}`);
