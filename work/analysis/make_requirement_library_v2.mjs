import fs from "node:fs/promises";
import path from "node:path";
import { Workbook, SpreadsheetFile } from "@oai/artifact-tool";

const root = "C:/Users/AUSA/Desktop/牵引制动能量回收";
const bundlePath = path.join(root, "work/analysis/requirement_library_v2_bundle.json");
const outputPath = path.join(root, "Req/牵引制动能量回收系统_正式需求库_v2_扩展版.xlsx");
const previewDir = path.join(root, "work/analysis/requirement_library_v2_previews");
const data = JSON.parse(await fs.readFile(bundlePath, "utf8"));
const wb = Workbook.create();
const navy = "#17365D";
const pale = "#EAF0F7";
const ink = "#1F2937";
const line = "#D6DEE8";
let tableIndex = 0;

function cellValue(v) {
  if (v === null || v === undefined) return "";
  if (typeof v === "object") return JSON.stringify(v);
  return v;
}
function addTable(name, headers, rows, widths, tabColor = navy, bodyHeight = 32) {
  const sheet = wb.worksheets.add(name);
  sheet.showGridLines = false;
  sheet.tabColor = tabColor;
  const matrix = [headers, ...rows.map(row => row.map(cellValue))];
  const target = sheet.getRangeByIndexes(0, 0, matrix.length, headers.length);
  target.values = matrix;
  target.format = {
    font: { name: "Arial", size: 9, color: ink },
    verticalAlignment: "top",
    wrapText: true,
    borders: { bottom: { style: "thin", color: line } },
  };
  if (matrix.length > 1) sheet.getRangeByIndexes(1, 0, matrix.length - 1, headers.length).format = { rowHeightPx: bodyHeight };
  sheet.getRangeByIndexes(0, 0, 1, headers.length).format = {
    fill: navy,
    font: { name: "Arial", size: 9, bold: true, color: "#FFFFFF" },
    horizontalAlignment: "center",
    verticalAlignment: "middle",
    wrapText: true,
    rowHeightPx: 42,
  };
  widths.forEach((width, col) => {
    const range = sheet.getRangeByIndexes(0, col, matrix.length, 1);
    range.format = { columnWidthPx: width };
  });
  sheet.freezePanes.freezeRows(1);
  if (matrix.length > 1) {
    const endCol = colName(headers.length);
    tableIndex += 1;
    sheet.tables.add(`A1:${endCol}${matrix.length}`, true, `Tbl_${tableIndex}`);
  }
  return sheet;
}
function safeName(value) { return value.replace(/[^A-Za-z0-9]/g, "").slice(0, 18); }
function colName(index) {
  let n = index, out = "";
  while (n > 0) { const r = (n - 1) % 26; out = String.fromCharCode(65 + r) + out; n = Math.floor((n - 1) / 26); }
  return out;
}

const metricRows = [
  ["原正式需求数量", data.summary.original_requirement_count, "v1正式需求库；原始34条字段值保持不变"],
  ["新增工程派生需求数量", data.summary.new_requirement_count, "仅由现有真实Function缺口分组派生"],
  ["最终Requirement总数", data.summary.total_requirement_count, "原34条 + 新增派生需求"],
  ["真实SysML Function数量", data.summary.function_count, "源模型 action def"],
  ["有需求上游来源的Function数量", data.summary.covered_function_count, "含直接映射与明确父需求的实现支持"],
  ["未覆盖Function数量", data.summary.uncovered_function_count, "没有需求父项的Function"],
  ["已有需求直接覆盖Function", data.summary.existing_requirement_covered_function_count, "Coverage_Type=EXISTING_REQUIREMENT"],
  ["派生需求直接覆盖Function", data.summary.derived_requirement_covered_function_count, "Coverage_Type=DERIVED_REQUIREMENT"],
  ["Implementation Support Function", data.summary.implementation_support_function_count, "指向已有父需求；不声称独立satisfy"],
  ["FULL需求数量", data.summary.full_requirement_count, "表示主要功能有模型对象覆盖，不代表验证通过"],
  ["PARTIAL需求数量", data.summary.partial_requirement_count, "模型覆盖不完整或来源仍有限"],
  ["Requirement→Function关系数", data.summary.requirement_function_relation_count, "允许N:M"],
  ["平均每条需求关联Function数", data.summary.average_functions_per_requirement, "直接映射关系数 / 最终需求总数"],
  ["关键词索引行数", data.summary.keyword_index_row_count, "一词多需求；每行一个检索词与Requirement"],
  ["Topic Cluster数量", data.summary.topic_cluster_count, "用于语义扩散，不表示SysML派生关系"],
];
const summary = wb.worksheets.add("摘要");
summary.showGridLines = false; summary.tabColor = navy;
summary.getRange("A1:C1").values = [["牵引—制动—能量回收系统｜正式需求库 V2 扩展摘要", "", ""]];
summary.getRange("A1:C1").format = { font: { name: "Arial", size: 15, bold: true, color: navy }, verticalAlignment: "middle", rowHeightPx: 34 };
summary.getRange("A3:C3").values = [["统计项", "数量", "口径"]];
summary.getRange(`A4:C${3 + metricRows.length}`).values = metricRows;
summary.getRange(`A3:C${3 + metricRows.length}`).format = { font: { name: "Arial", size: 10, color: ink }, wrapText: true, verticalAlignment: "middle", borders: { bottom: { style: "thin", color: line } } };
summary.getRange("A3:C3").format = { fill: navy, font: { name: "Arial", size: 10, bold: true, color: "#FFFFFF" }, horizontalAlignment: "center", verticalAlignment: "middle", rowHeightPx: 28 };
summary.getRange(`A4:A${3 + metricRows.length}`).format = { fill: pale, font: { name: "Arial", size: 10, bold: true, color: ink }, verticalAlignment: "middle" };
summary.getRange("A1:A19").format = { columnWidthPx: 260 };
summary.getRange("B1:B19").format = { columnWidthPx: 110 };
summary.getRange("C1:C19").format = { columnWidthPx: 520 };
summary.getRange("A19:C19").values = [["来源与说明", "", "来源：v1正式需求库、191个真实SysML Function及allocation、Product目录和已审定的Requirement→Function关系。派生需求不声明标准条款；Function覆盖与Verification_Status分列记录。"]];
summary.getRange("A19:C19").format = { font: { name: "Arial", size: 9, italic: true, color: "#475569" }, wrapText: true, verticalAlignment: "top", rowHeightPx: 120 };
summary.freezePanes.freezeRows(3);

const formalWidths = data.fields.map(f => ({
  Requirement_ID:145, Parent_Requirement_IDs:190, Requirement_Level:115, Domain:90, Topic_Group:180, Name:210, Text:390,
  Requirement_Type:130, Source_Type:135, Standard_No:130, Standard_Clause:130, Criteria:310, Applicable_Conditions:260,
  Keywords:210, Synonyms:210, User_Phrases:300, Semantic_Topics:190, System_Terms:210, Action_Terms:160, Object_Terms:175,
  Expected_Function_Semantics:290, Linked_Function_IDs:250, Linked_Function_Names:320, Linked_Product_IDs:190,
  Linked_Product_Names:260, Function_Coverage_Count:105, Coverage_Status:115, Derivation_Reason:340,
  Related_Requirement_IDs:240, Verification_Status:145, Model_Coverage:115, Notes:300, Evidence_Source:300,
}[f] ?? 155));
const formalRows = data.requirements.map(r => data.fields.map(f => r[f]));
addTable("正式需求库", data.fields, formalRows, formalWidths, navy, 96);

const rawHeaders = data.raw_headers.map(x => x === null ? "" : String(x));
const rawRows = data.raw_rows.slice(1).map(row => rawHeaders.map((_,i) => row[i] ?? ""));
addTable("原始正式需求", rawHeaders, rawRows, rawHeaders.map((_,i) => i === 3 || i === 8 || i === 9 ? 340 : i === 10 || i === 11 || i === 12 ? 220 : 150), "#8492A6", 96);

const derivedRows = data.requirements.filter(x => x.Requirement_ID.startsWith("DRV-")).map(r => data.fields.map(f => r[f]));
addTable("工程派生需求", data.fields, derivedRows, formalWidths, "#2F75B5", 96);

const mapHeaders = ["Requirement_ID","Requirement_Name","Function_ID","Function_Name","Product_ID","Product_Name","Mapping_Type","Evidence"];
const mapRows = data.relations.map(r => [r.requirement_id,r.requirement_name,r.function_id,r.function_name,r.product_id,r.product_name,
  r.mapping_type,`${r.evidence}；真实allocation=${r.structural_evidence?.allocation_id ?? "n/a"}`]);
addTable("需求-功能映射", mapHeaders, mapRows, [145,240,175,270,115,230,155,500], "#548235", 58);

const coverageHeaders = ["Function_ID","Function_Name","Function_Level","Category","Owner_Product_ID","Owner_Product_Name","Covered_By_Requirement","Requirement_IDs","Coverage_Type"];
const coverageRows = data.coverage.map(r => coverageHeaders.map(h => r[h]));
addTable("Function覆盖审计", coverageHeaders, coverageRows, [175,300,115,175,145,240,170,330,200], "#C55A11", 45);

const indexHeaders = ["Search_Term","Term_Type","Requirement_ID","Requirement_Name","Topic_Group","Weight"];
// Recreate the worksheet index from each requirement's final multi-value fields.
const weights = {KEYWORD:1.0,SYNONYM:0.9,USER_PHRASE:1.25,SEMANTIC_TOPIC:0.7,SYSTEM_TERM:0.6,ACTION_TERM:0.55,OBJECT_TERM:0.75};
const termFields = [["Keywords","KEYWORD"],["Synonyms","SYNONYM"],["User_Phrases","USER_PHRASE"],["Semantic_Topics","SEMANTIC_TOPIC"],["System_Terms","SYSTEM_TERM"],["Action_Terms","ACTION_TERM"],["Object_Terms","OBJECT_TERM"]];
const searchRows = [];
for (const rel of data.search_index ?? []) searchRows.push(indexHeaders.map(h => rel[h]));
if (!searchRows.length) {
  for (const req of data.requirements) for (const [field,type] of termFields) {
    for (const term of String(req[field] ?? "").split("；").filter(Boolean)) searchRows.push([term,type,req.Requirement_ID,req.Name,req.Topic_Group,weights[type]]);
  }
}
const deDupeSearch = new Map();
for (const row of searchRows) deDupeSearch.set(`${String(row[0]).toLocaleLowerCase()}|${row[1]}|${row[2]}`,row);
addTable("关键词检索表", indexHeaders, [...deDupeSearch.values()], [260,150,150,250,280,95], "#8064A2", 34);

const clusterHeaders = ["Cluster_ID","Cluster_Name","Trigger_Terms","Requirement_IDs","Description"];
addTable("需求主题簇", clusterHeaders, data.clusters.map(c => clusterHeaders.map(h => c[h])), [230,260,360,560,460], "#70AD47", 128);

// Recalculate once, then inspect the key result ranges before exporting.
wb.recalculate();
const inspectSummary = await wb.inspect({kind:"table",range:`摘要!A1:C${3 + metricRows.length}`,include:"values,formulas",tableMaxRows:22,tableMaxCols:4});
if (!inspectSummary || typeof inspectSummary.ndjson !== "string") throw new Error("Workbook summary inspection failed");
const inspectCore = await wb.inspect({kind:"table",range:`正式需求库!A1:AG${data.requirements.length+1}`,include:"values",tableMaxRows:3,tableMaxCols:34});
if (!inspectCore || typeof inspectCore.ndjson !== "string") throw new Error("Formal requirements inspection failed");

await fs.mkdir(path.dirname(outputPath), {recursive:true});
const xlsx = await SpreadsheetFile.exportXlsx(wb);
await xlsx.save(outputPath);

// Render each sheet to temporary visual evidence for QA; these previews are not deliverables.
await fs.mkdir(previewDir,{recursive:true});
const previewRanges = {
  "摘要":"A1:C19", "正式需求库":"A1:G8", "原始正式需求":"A1:J8", "工程派生需求":"A1:G14",
  "需求-功能映射":"A1:H12", "Function覆盖审计":"A1:I14", "关键词检索表":"A1:F16", "需求主题簇":"A1:E11",
};
const previewNames = {"摘要":"summary","正式需求库":"formal_requirements","原始正式需求":"original_requirements",
  "工程派生需求":"derived_requirements","需求-功能映射":"requirement_function_map","Function覆盖审计":"function_coverage_audit",
  "关键词检索表":"keyword_search_index","需求主题簇":"requirement_topic_clusters"};
for (const [sheetName, range] of Object.entries(previewRanges)) {
  const blob = await wb.export({sheetName,range,format:"png",scale:1});
  await fs.writeFile(path.join(previewDir,`${previewNames[sheetName]}.png`),Buffer.from(await blob.arrayBuffer()));
}
console.log(`WORKBOOK=PASS SHEETS=${wb.worksheets.getSheetCount()} REQUIREMENTS=${data.requirements.length} RAW=${rawRows.length} MAPPINGS=${mapRows.length} FUNCTION_ROWS=${coverageRows.length} INDEX_ROWS=${deDupeSearch.size} OUTPUT=${outputPath}`);
