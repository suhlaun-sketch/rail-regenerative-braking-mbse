import fs from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { SpreadsheetFile, Workbook } from "@oai/artifact-tool";

const outputDir = path.dirname(fileURLToPath(import.meta.url));
const jsonPath = path.join(outputDir, "Rail_MBSE_Executable_FMU_Interface_v1.json");
const xlsxPath = path.join(outputDir, "Rail_MBSE_Executable_FMU_Interface_v1.xlsx");
const previewDir = "C:/Users/AUSA/AppData/Local/Temp/codex_executable_fmu_interface_previews";
const data = JSON.parse(await fs.readFile(jsonPath, "utf8"));

const workbook = Workbook.create();
const summary = workbook.worksheets.add("Summary");
const componentSheet = workbook.worksheets.add("Components");
const connectorSheet = workbook.worksheets.add("Structural Connectors");
const variableSheet = workbook.worksheets.add("Executable Variables");
const connectionSheet = workbook.worksheets.add("Signal Connections");
const outputOutputSheet = workbook.worksheets.add("Output-Output");
const readme = workbook.worksheets.add("ReadMe");

const fontFamily = "Arial";
const navy = "#1F4E78";
const lightBlue = "#D9EAF7";
const green = "#E2F0D9";
const amber = "#FFF2CC";
const red = "#FCE4D6";
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

function styleTitle(sheet, address, title, ruleAddress) {
  sheet.getRange(address).values = [[title]];
  sheet.getRange(address).format.font = { name: fontFamily, size: 14, bold: true, color: navy };
  sheet.getRange(ruleAddress).format.borders = {
    bottom: { style: "medium", color: navy },
  };
}

function statusFormatting(range) {
  range.conditionalFormats.add("containsText", {
    text: "PASS",
    format: { fill: green, font: { color: "#375623", bold: true } },
  });
  range.conditionalFormats.add("containsText", {
    text: "RESOLVED",
    format: { fill: green, font: { color: "#375623", bold: true } },
  });
  range.conditionalFormats.add("containsText", {
    text: "EXPANSION",
    format: { fill: lightBlue, font: { color: navy, bold: true } },
  });
  range.conditionalFormats.add("containsText", {
    text: "INFERENCE",
    format: { fill: amber, font: { color: "#7F6000", bold: true } },
  });
  range.conditionalFormats.add("containsText", {
    text: "UNRESOLVED",
    format: { fill: red, font: { color: "#9C0006", bold: true } },
  });
  range.conditionalFormats.add("containsText", {
    text: "FAIL",
    format: { fill: red, font: { color: "#9C0006", bold: true } },
  });
}

function writeTable(sheet, headers, rows) {
  const endColumn = columnName(headers.length);
  sheet.getRange(`A1:${endColumn}1`).values = [headers];
  if (rows.length) sheet.getRange(`A2:${endColumn}${rows.length + 1}`).values = rows;
  sheet.freezePanes.freezeRows(1);
  styleHeader(sheet.getRange(`A1:${endColumn}1`));
}

function columnName(number) {
  let result = "";
  while (number > 0) {
    number -= 1;
    result = String.fromCharCode(65 + (number % 26)) + result;
    number = Math.floor(number / 26);
  }
  return result;
}

// Summary
styleTitle(summary, "A2", "Executable FMU Interface Resolution v1", "A2:H2");
summary.getRange("A4:B4").values = [["Authority", "Scope"]];
summary.getRange("A5:B8").values = [
  ["Final All16 SSD", "Component identity, structural connector identity, ownership and 74-link topology"],
  ["Full SysML", "Item/interface semantics, quantity, unit and medium"],
  ["Legacy contract", "Executable scalar names, datatype, units and causalization"],
  ["This workbook", "Implementation artifact only; it does not modify or replace the SSD"],
];
summary.getRange("D4:E4").values = [["Resolution metric", "Count"]];
summary.getRange("D5:E14").values = [
  ["Components resolved", data.statistics.components_resolved],
  ["Structural connectors reviewed", data.statistics.structural_connectors_reviewed],
  ["Resolved without expansion", data.statistics.resolved_without_expansion],
  ["Expanded structural connectors", data.statistics.expanded_structural_connectors],
  ["Executable variable bindings", data.statistics.executable_variable_bindings],
  ["Unique executable FMI variables", data.statistics.executable_fmi_variables],
  ["Engineering inference variables", data.statistics.engineering_inference_variables],
  ["Unresolved variables", data.statistics.unresolved_variables],
  ["Structural connections", data.statistics.structural_connections],
  ["Executable signal connections", data.statistics.executable_signal_connections],
];
summary.getRange("G4:H4").values = [["Gate", "Status"]];
summary.getRange("G5:H9").values = [
  ["Output-output structural links", data.statistics.output_output_structural_connections],
  ["Output-output executable resolution", data.statistics.output_output_executable_resolution],
  ["Original SSD modified", "NO"],
  ["Full SysML modified", "NO"],
  ["EXECUTABLE_FMU_INTERFACE_READY", data.artifact.status],
];
summary.getRange("A17").values = [["151 unique FMU variables come from 163 connector-to-variable bindings: 15 connectors expand, while 12 same-component fan-in/fan-out bindings reuse an existing exposed variable name. 87 executable links come from causal expansion of 74 structural links."]];
summary.getRange("A17:H17").format.fill = gray;
summary.getRange("A17").format.font = { name: fontFamily, size: 10, italic: true, color: darkText };

// Components
const componentHeaders = [
  "ssd_component",
  "l2_code",
  "l2_engineering_name",
  "future_simulink_model",
  "future_fmu_file",
  "source_structural_connector_count",
  "inputs",
  "outputs",
  "parameters",
  "states_monitoring_outputs",
  "total_executable_variables",
  "readiness",
];
const componentRows = data.components.map((row) => [
  row.ssd_component,
  row.l2_code,
  row.l2_engineering_name,
  row.future_simulink_model,
  row.future_fmu_file,
  row.source_structural_connectors.length,
  row.counts.inputs,
  row.counts.outputs,
  row.counts.parameters,
  row.counts.states_monitoring_outputs,
  row.counts.total_executable_variables,
  row.readiness,
]);
writeTable(componentSheet, componentHeaders, componentRows);
componentSheet.freezePanes.freezeColumns(3);

// Structural connector resolution
const connectorHeaders = [
  "ssd_component",
  "ssd_connector",
  "ssd_connector_id",
  "structural_direction",
  "ssd_datatype",
  "ssd_unit",
  "original_product_code",
  "original_product_name",
  "original_port_name",
  "original_port_id",
  "item_code",
  "item_name",
  "interface_type",
  "engineering_domain",
  "structural_semantics",
  "representation_kind",
  "implementation_reclassification",
  "executable_variable_count",
  "executable_variable_names",
  "resolution_status",
];
const connectorRows = data.structural_connectors.map((row) => [
  row.ssd_component,
  row.ssd_connector,
  row.ssd_connector_id,
  row.structural_direction,
  row.ssd_datatype,
  row.ssd_unit,
  row.original_product.code,
  row.original_product.name,
  row.original_port.name,
  row.original_port.id,
  row.item_code,
  row.item_name,
  flatten(row.interface_type),
  row.engineering_domain,
  row.structural_semantics,
  row.simulation_representation.representation_kind,
  row.implementation_reclassification,
  row.executable_variables.length,
  row.executable_variables.map((variable) => variable.variable_name).join(" | "),
  row.resolution_status,
]);
writeTable(connectorSheet, connectorHeaders, connectorRows);
connectorSheet.freezePanes.freezeColumns(3);

// Executable variables
const variableHeaders = [
  "executable_variable_id",
  "ssd_component",
  "source_ssd_connectors",
  "variable_name",
  "engineering_meaning",
  "quantity",
  "unit",
  "datatype",
  "fmi_causality",
  "fmi_variability",
  "simulink_port_type",
  "source_of_semantics",
  "source_of_unit",
  "source_of_causality",
  "confidence",
  "assumption",
  "legacy_contract_ids",
  "legacy_mapping_statuses",
  "structural_connection_ids",
  "binding_rule_ids",
  "source_sysml_elements",
  "resolution_status",
];
const variableRows = data.executable_variables.map((row) => variableHeaders.map((key) => flatten(row[key])));
writeTable(variableSheet, variableHeaders, variableRows);
variableSheet.freezePanes.freezeColumns(4);

// Executable signal connections
const connectionHeaders = [
  "executable_connection_id",
  "structural_connection_id",
  "source_component",
  "source_variable",
  "target_component",
  "target_variable",
  "quantity",
  "engineering_meaning",
  "unit",
  "datatype",
  "source_of_semantics",
  "source_of_unit",
  "source_of_causality",
  "legacy_contract_id",
  "binding_rule_id",
  "status",
];
const connectionRows = data.executable_signal_connections.map((row) => connectionHeaders.map((key) => flatten(row[key])));
writeTable(connectionSheet, connectionHeaders, connectionRows);
connectionSheet.freezePanes.freezeColumns(6);

// Output-output resolution
styleTitle(outputOutputSheet, "A2", "Output-Output Structural Connection Resolution", "A2:H2");
const oo = data.output_output_resolution;
const structural = oo.structural_connection;
outputOutputSheet.getRange("A4:B4").values = [["Finding", "Value"]];
outputOutputSheet.getRange("A5:B14").values = [
  ["Connection", structural.connection_id],
  ["Structural source", structural.structural_source_connector],
  ["Structural target", structural.structural_target_connector],
  ["Structural direction", structural.structural_direction_pair],
  ["Classification", oo.classification],
  ["A Projection causality error", "Not the independent root cause"],
  ["B Bidirectional physical interface compressed", "YES - primary finding"],
  ["C Shared physical net", "NO"],
  ["D Confirmed model error", "NO"],
  ["Resolution", oo.executable_resolution],
];
outputOutputSheet.getRange("D4:J4").values = [["Source component", "Source variable", "Target component", "Target variable", "Quantity", "Unit", "Datatype"]];
const ooRows = structural.executable_signal_connections.map((row) => [
  row.source_component,
  row.source_variable,
  row.target_component,
  row.target_variable,
  row.quantity,
  row.unit,
  row.datatype,
]);
outputOutputSheet.getRange(`D5:J${4 + ooRows.length}`).values = ooRows;
outputOutputSheet.getRange("A17:B17").values = [["Status", oo.status]];

// ReadMe
styleTitle(readme, "A2", "Executable Interface Notes", "A2:F2");
readme.getRange("A4:B4").values = [["Topic", "Definition"]];
readme.getRange("A5:B14").values = [
  ["Authority", "The final All16 SSD remains authoritative for structure and topology."],
  ["Implementation artifact", "This workbook resolves scalar variables for future Simulink Skeleton and FMU work; it is not a new MBSE authority."],
  ["FULL_SYSML", "Direct item/interface semantics, quantity, unit or medium."],
  ["LEGACY_CONTRACT", "Direct legacy implementation variable, datatype, unit or causalization."],
  ["DERIVED_FROM_PHYSICAL_INTERFACE", "A scalar follows directly from a physical interface decomposition."],
  ["ENGINEERING_INFERENCE", "An implementation decision not directly stated as a scalar source field; assumption and confidence are mandatory."],
  ["VALID_EXECUTION_EXPANSION", "One SSD structural connector maps to multiple causal executable variables."],
  ["SSD_SEMANTIC_LOSS_RECOVERED", "SSD Real[-] is retained structurally while executable datatype/unit are restored from supported semantics."],
  ["Shared exposed variable", "Multiple same-component structural connectors may trace to one unique FMU variable name; all source connectors remain listed."],
  ["No generated models", "This deliverable contains no Simulink model, Skeleton or FMU."],
];

for (const sheet of [summary, componentSheet, connectorSheet, variableSheet, connectionSheet, outputOutputSheet, readme]) applyBase(sheet);

for (const range of [summary.getRange("A4:B4"), summary.getRange("D4:E4"), summary.getRange("G4:H4"), outputOutputSheet.getRange("A4:B4"), outputOutputSheet.getRange("D4:J4"), readme.getRange("A4:B4")]) styleHeader(range);
styleHeader(componentSheet.getRange("A1:L1"));
styleHeader(connectorSheet.getRange("A1:T1"));
styleHeader(variableSheet.getRange("A1:V1"));
styleHeader(connectionSheet.getRange("A1:P1"));
styleTitle(summary, "A2", "Executable FMU Interface Resolution v1", "A2:H2");
styleTitle(outputOutputSheet, "A2", "Output-Output Structural Connection Resolution", "A2:J2");
styleTitle(readme, "A2", "Executable Interface Notes", "A2:F2");

summary.getRange("A5:A8").format.fill = lightBlue;
summary.getRange("D5:D14").format.fill = lightBlue;
summary.getRange("G5:G9").format.fill = lightBlue;
summary.getRange("A:A").format.columnWidth = 26;
summary.getRange("B:B").format.columnWidth = 76;
summary.getRange("C:C").format.columnWidth = 3;
summary.getRange("D:D").format.columnWidth = 36;
summary.getRange("E:E").format.columnWidth = 14;
summary.getRange("F:F").format.columnWidth = 3;
summary.getRange("G:G").format.columnWidth = 38;
summary.getRange("H:H").format.columnWidth = 22;
statusFormatting(summary.getRange("H5:H9"));

componentSheet.getRange("A:L").format.columnWidth = 18;
componentSheet.getRange("C:C").format.columnWidth = 26;
componentSheet.getRange("L:L").format.columnWidth = 16;
statusFormatting(componentSheet.getRange(`L2:L${componentRows.length + 1}`));

connectorSheet.getRange("A:T").format.columnWidth = 18;
for (const col of ["B", "C", "J", "O", "Q", "S"]) connectorSheet.getRange(`${col}:${col}`).format.columnWidth = 38;
connectorSheet.getRange("H:I").format.columnWidth = 26;
connectorSheet.getRange("R:R").format.numberFormat = "0";
statusFormatting(connectorSheet.getRange(`Q2:Q${connectorRows.length + 1}`));
statusFormatting(connectorSheet.getRange(`T2:T${connectorRows.length + 1}`));

variableSheet.getRange("A:V").format.columnWidth = 18;
for (const col of ["A", "C", "E", "P", "Q", "S", "U"]) variableSheet.getRange(`${col}:${col}`).format.columnWidth = 42;
variableSheet.getRange("D:D").format.columnWidth = 30;
statusFormatting(variableSheet.getRange(`M2:M${variableRows.length + 1}`));
statusFormatting(variableSheet.getRange(`V2:V${variableRows.length + 1}`));

connectionSheet.getRange("A:P").format.columnWidth = 18;
for (const col of ["A", "B", "D", "F", "H"]) connectionSheet.getRange(`${col}:${col}`).format.columnWidth = 38;
statusFormatting(connectionSheet.getRange(`L2:L${connectionRows.length + 1}`));
statusFormatting(connectionSheet.getRange(`P2:P${connectionRows.length + 1}`));

outputOutputSheet.getRange("A:A").format.columnWidth = 36;
outputOutputSheet.getRange("B:B").format.columnWidth = 70;
outputOutputSheet.getRange("C:C").format.columnWidth = 3;
outputOutputSheet.getRange("D:J").format.columnWidth = 24;
statusFormatting(outputOutputSheet.getRange("B17"));

readme.getRange("A:A").format.columnWidth = 38;
readme.getRange("B:B").format.columnWidth = 105;
readme.getRange("B5:B14").format.wrapText = true;
readme.getRange("B5:B14").format.rowHeight = 34;
statusFormatting(readme.getRange("A5:A14"));

workbook.recalculate();
const summaryInspect = await workbook.inspect({
  kind: "table",
  range: "Summary!A2:H17",
  include: "values,formulas",
  tableMaxRows: 20,
  tableMaxCols: 10,
});
console.log(summaryInspect.ndjson);
const variableInspect = await workbook.inspect({
  kind: "table",
  range: "Executable Variables!A1:V6",
  include: "values,formulas",
  tableMaxRows: 8,
  tableMaxCols: 22,
});
console.log(variableInspect.ndjson);
const errors = await workbook.inspect({
  kind: "match",
  searchTerm: "#REF!|#DIV/0!|#VALUE!|#NAME\\?|#N/A|#NUM!|#NULL!|#SPILL!|#CALC!",
  options: { useRegex: true, maxResults: 300 },
  summary: "final formula error scan",
});
console.log(errors.ndjson);

await fs.mkdir(previewDir, { recursive: true });
for (const [sheetName, range] of [
  ["Summary", "A1:H17"],
  ["Components", "A1:L17"],
  ["Structural Connectors", "A1:T16"],
  ["Executable Variables", "A1:V16"],
  ["Signal Connections", "A1:P16"],
  ["Output-Output", "A1:J18"],
  ["ReadMe", "A1:B15"],
]) {
  const preview = await workbook.render({ sheetName, range, scale: 1, format: "png" });
  await fs.writeFile(`${previewDir}/${sheetName.replaceAll(" ", "_")}.png`, new Uint8Array(await preview.arrayBuffer()));
  console.log(`RENDERED ${sheetName}`);
}

const output = await SpreadsheetFile.exportXlsx(workbook);
await output.save(xlsxPath);
console.log(`EXPORTED ${xlsxPath}`);
