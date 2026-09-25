// JavaScript executed by Node in module mode; edits a copy with @oai/artifact-tool.
import fs from "node:fs/promises";
import path from "node:path";
import { FileBlob, SpreadsheetFile } from "@oai/artifact-tool";

const root = path.resolve(process.cwd(), "..", "..");
const sourcePath = path.join(root, "Rail_MBSE_Function_Interface_v1.xlsx");
const outputPath = path.join(root, "Rail_MBSE_Function_Interface_v1_final.xlsx");
const jsonPath = path.join(root, "work", "architecture_xmi_ready_v1.json");
const previewDir = path.join(root, "tools", "function_pipeline", "work", "preflight_previews");

const architecture = JSON.parse(await fs.readFile(jsonPath, "utf8"));
const input = await FileBlob.load(sourcePath);
const workbook = await SpreadsheetFile.importXlsx(input);
const sheet = workbook.worksheets.getItem("Function");
await fs.mkdir(previewDir, {recursive:true});

const before = await workbook.render({sheetName:"Function", range:"A1:I16", scale:1, format:"png"});
await fs.writeFile(path.join(previewDir, "Function_before.png"), new Uint8Array(await before.arrayBuffer()));

const rowCount = architecture.functions.length;
const ids = sheet.getRange(`A5:A${rowCount + 4}`).values.flat();
const functions = new Map(architecture.functions.map(x => [x.function_id, x]));
if (ids.length !== rowCount || ids.some(id => !functions.has(id))) {
  throw new Error("Function worksheet IDs do not match frozen JSON");
}
sheet.getRange(`B5:B${rowCount + 4}`).values = ids.map(id => [functions.get(id).name_cn]);
sheet.getRange(`C5:C${rowCount + 4}`).values = ids.map(id => [functions.get(id).name_en]);
sheet.getRange(`H5:H${rowCount + 4}`).values = ids.map(id => [functions.get(id).description]);

workbook.recalculate();
const inspection = await workbook.inspect({kind:"region", sheetId:"Function", range:"A1:I16", maxChars:2600});
const errors = await workbook.inspect({kind:"match", searchTerm:"#REF!|#DIV/0!|#VALUE!|#NAME\\?|#N/A|#NUM!|#NULL!|#SPILL!|#CALC!", options:{useRegex:true,maxResults:50}, summary:"preflight formula error scan"});
const after = await workbook.render({sheetName:"Function", range:"A1:I16", scale:1, format:"png"});
await fs.writeFile(path.join(previewDir, "Function_after.png"), new Uint8Array(await after.arrayBuffer()));
const output = await SpreadsheetFile.exportXlsx(workbook);
await output.save(outputPath);
console.log(JSON.stringify({stage:10,status:"PASS",output:outputPath,function_rows:rowCount,inspection:Boolean(inspection.ndjson),formula_scan:Boolean(errors.ndjson)}));
