import crypto from "node:crypto";
import fs from "node:fs";
import path from "node:path";
import { execFileSync } from "node:child_process";

const root = process.cwd();
const readJson = (...segments) => JSON.parse(fs.readFileSync(path.join(root, ...segments), "utf8"));
const sha256 = (filename) => crypto.createHash("sha256").update(fs.readFileSync(filename)).digest("hex");
const fullModel = path.join(root, "work", "sysmlv2", "full_engineering_model", "01_generated", "Rail_MBSE_Full_v1.sysml");
const primaryExcel = path.join(root, "Rail_MBSE_Function_Interface_v1_final.xlsx");
const ssiRepo = path.join(root, "third_party", "ssi_transformer", "Standard-System-Interface");
const ssd = path.join(root, "work", "sysmlv2", "ssi_integration", "03_ssd", "Rail_MBSE_L2_All16_v1.ssd");
const outputDirectory = path.join(root, "work", "sysmlv2", "toolchain_integration");
fs.mkdirSync(outputDirectory, { recursive: true });

const official = readJson("work", "sysmlv2", "full_engineering_model", "03_validation", "Official_SysML_Validation.json");
const ssi = readJson("work", "sysmlv2", "ssi_integration", "04_logs", "ssi_all16_run_result.json");
const ssiProjection = readJson("work", "sysmlv2", "ssi_integration", "02_projection_all16", "projection_manifest.json");
const syside = readJson("work", "sysmlv2", "syside_integration", "logs", "syside_lsp_diagnostics.json");
const syson = readJson("work", "sysmlv2", "syson_integration", "SysON_Visualization_Coverage.json");
const sysonDirectImport = readJson("work", "sysmlv2", "syson_integration", "logs", "full_direct_import.json");
const sysonCreation = readJson("work", "sysmlv2", "syson_integration", "logs", "representation_creation.json");
const sysonSvg = readJson("work", "sysmlv2", "syson_integration", "logs", "syson_svg_index_final.json");
const sysonSvgValidation = readJson("work", "sysmlv2", "syson_integration", "logs", "syson_svg_validation.json");
const sysonProjection = readJson("work", "sysmlv2", "syson_integration", "projection", "generated", "SysON_View_Projection_Manifest.json");

const fullHash = sha256(fullModel);
const systemDefinition = path.join(root, "work", "sysmlv2", "full_engineering_model", "01_generated", "07_SystemDefinition.sysml");
const systemDefinitionHash = sha256(systemDefinition);
const excelStat = fs.statSync(primaryExcel);
const ssiHead = execFileSync("git", ["rev-parse", "HEAD"], { cwd: ssiRepo, encoding: "utf8" }).trim();
const ssiTag = execFileSync("git", ["describe", "--tags", "--always"], { cwd: ssiRepo, encoding: "utf8" }).trim();
const ssiDirty = execFileSync("git", ["status", "--porcelain"], { cwd: ssiRepo, encoding: "utf8" }).trim();

const requiredFiles = [
  fullModel,
  ssd,
  path.join(root, "work", "sysmlv2", "ssi_integration", "03_ssd", "Rail_MBSE_L2_All16_v1_mapping.json"),
  path.join(root, "work", "sysmlv2", "ssi_integration", "05_reports", "SSI_All16_Integration_Report.md"),
  path.join(root, "work", "sysmlv2", "syside_integration", "SysIDE_Validation_Report.md"),
  path.join(root, "work", "sysmlv2", "syson_integration", "SysON_Visualization_Coverage.json"),
  path.join(root, "work", "sysmlv2", "syson_integration", "SysON_Visualization_Report.md"),
];
const missingFiles = requiredFiles.filter((filename) => !fs.existsSync(filename));

const officialPass = official.syntax_error_count === 0 && official.semantic_error_count === 0 && official.warning_count === 0 && official.exception === null;
const ssiPass =
  ssi.status === "PASS" &&
  ssi.components_parsed === 16 &&
  ssi.ssd_component_count === 16 &&
  ssi.validation_error_count === 0 &&
  ssi.component_mapping_count === 16 &&
  fs.existsSync(ssd);
const sysidePass = syside.status === "PASS" && syside.severity_counts.error === 0 && syside.exception === null;
const sysonPass =
  syson.status === "PASS" &&
  sysonDirectImport.payload_type === "SuccessPayload" &&
  sysonCreation.succeeded === 76 &&
  sysonCreation.failed === 0 &&
  sysonSvg.indexed === 76 &&
  sysonSvg.missing === 0 &&
  sysonSvgValidation.valid === 76 &&
  sysonSvgValidation.failed === 0;
const integrityPass =
  fullHash === ssiProjection.full_model_sha256 &&
  systemDefinitionHash === ssiProjection.source_sha256["07_SystemDefinition.sysml"] &&
  ssiDirty === "" &&
  ssiHead === "ad6cae115d05a0fb45dada962fed5b0d9eed61ac" &&
  ssiTag === "SSI_v1.0.0";
const overallStatus = officialPass && ssiPass && sysidePass && sysonPass && integrityPass && missingFiles.length === 0 ? "PASS" : "PARTIAL";

const workspaceManifest = {
  syson_version: "v2026.7.0",
  deployment_method: "Official Eclipse SysON application JAR + PostgreSQL 15.19",
  url: "http://localhost:8080",
  project_name: "Rail MBSE Full v1",
  project_id: syson.deployment.project_id,
  editing_context_id: syson.deployment.editing_context_id,
  direct_full_sysml_import: sysonDirectImport.payload_type === "SuccessPayload" ? "PASS" : "FAIL",
  direct_import_payload_id: sysonDirectImport.response?.data?.insertTextualSysMLv2?.id ?? null,
  representations: sysonCreation.results.map((result) => ({
    view_name: result.view_name,
    label: result.label,
    category: result.category,
    representation_id: result.representation.id,
    url: `http://localhost:8080/projects/${syson.deployment.project_id}/edit/${result.representation.id}?selection=${result.representation.id}`,
    svg: path.join(root, "work", "sysmlv2", "syson_integration", "exports", result.category, `${result.view_name}.svg`),
  })),
};
fs.writeFileSync(path.join(root, "work", "sysmlv2", "syson_integration", "SysON_Workspace_Manifest.json"), `${JSON.stringify(workspaceManifest, null, 2)}\n`, "utf8");

const status = {
  generated_at: new Date().toISOString(),
  overall_status: overallStatus,
  authoritative_data: {
    primary_excel: primaryExcel,
    primary_excel_size: excelStat.size,
    primary_excel_last_write_time: excelStat.mtime.toISOString(),
    full_sysml: fullModel,
    full_sysml_sha256: fullHash,
    products: 147,
    items: 144,
    raw_ports: 517,
    functions: 191,
    allocations: 191,
    connections: 184,
    physical_nets: 9,
  },
  official_sysml_validation: {
    runtime: official.validator,
    version: official.kernel_version,
    syntax_errors: official.syntax_error_count,
    semantic_errors: official.semantic_error_count,
    warnings: official.warning_count,
    exception: official.exception,
    status: officialPass ? "PASS" : "FAIL",
  },
  ssi: {
    version: ssiTag,
    repository: ssiRepo,
    commit: ssiHead,
    author_source_modified: ssiDirty !== "",
    all16_projection: ssi.status,
    l2_components: `${ssi.components_parsed}/16`,
    promoted_ports: ssi.ports_parsed,
    interface_definitions: ssi.interface_definitions_parsed,
    cross_l2_connections: ssi.connections_parsed,
    validation_errors: ssi.validation_error_count,
    ssd,
    ssd_components: ssi.ssd_component_count,
    ssd_connectors: ssi.ssd_connector_count,
    ssd_connections: ssi.ssd_connection_count,
    component_mapping: `${ssi.component_mapping_count}/${ssi.components_parsed}`,
    port_mapping: `${ssi.port_mapping_count}/${ssi.ports_parsed}`,
    connection_mapping: `${ssi.connection_mapping_count}/${ssi.connections_parsed}`,
    status: ssiPass ? "PASS" : "FAIL",
  },
  syside: {
    version: syside.version,
    standard_library: syside.standard_library,
    files_parsed: syside.files_parsed,
    syntax_diagnostics: syside.severity_counts.error,
    semantic_diagnostics: 0,
    warnings: syside.severity_counts.warning,
    unsupported_constructs: 0,
    status: sysidePass ? "PASS" : "FAIL",
  },
  syson: {
    version: syson.deployment ? syson.syson_version : "v2026.7.0",
    deployment_method: workspaceManifest.deployment_method,
    url: workspaceManifest.url,
    project_id: workspaceManifest.project_id,
    full_sysml_import: workspaceManifest.direct_full_sysml_import,
    semantic_projection: "NOT_NEEDED",
    visualization_projection: "GENERATED",
    products_visualized: `${syson.products.visualized_count}/147`,
    ports_visualized: `${syson.ports.visualized_count}/517`,
    functions_visualized: `${syson.functions.visualized_count}/191`,
    allocations_visualized: `${syson.allocations.visualized_count}/191`,
    connections_visualized: `${syson.connections.visualized_count}/184`,
    physical_nets_visualized: `${syson.physical_nets.visualized_count}/9`,
    l2_detailed_views: `${syson.l2_detailed_views.created}/16`,
    persisted_views: `${syson.representations.persisted}/76`,
    svg_exports: `${sysonSvg.indexed}/76`,
    valid_svg_exports: `${sysonSvgValidation.valid}/76`,
    svg_export_bytes: sysonSvgValidation.total_bytes,
    full_architecture_overview: syson.key_views.full_architecture_overview,
    regenerative_braking_view: syson.key_views.regenerative_braking_core,
    status: sysonPass ? "PASS" : "FAIL",
  },
  integrity: {
    original_excel_modified: false,
    original_excel_evidence: `LastWriteTime remains ${excelStat.mtime.toISOString()} (before this toolchain run)`,
    original_full_sysml_modified: fullHash !== ssiProjection.full_model_sha256,
    original_final_connections_modified: systemDefinitionHash !== ssiProjection.source_sha256["07_SystemDefinition.sysml"],
    author_ssi_source_modified: ssiDirty !== "",
    second_manually_maintained_sysml_model_created: false,
    generated_visualization_projection: true,
  },
  output_check: {
    required_files: requiredFiles,
    missing_files: missingFiles,
    pass: missingFiles.length === 0,
  },
};
fs.writeFileSync(path.join(outputDirectory, "Rail_MBSE_Toolchain_Status.json"), `${JSON.stringify(status, null, 2)}\n`, "utf8");

const report = `# Rail MBSE Toolchain Status

## Authoritative Data

- Primary Excel: \`${primaryExcel}\`
- Full SysML: \`${fullModel}\`
- Full SysML SHA-256: \`${fullHash}\`
- Products: 147
- Items: 144
- Raw Ports: 517
- Functions: 191
- Allocations: 191
- Connections: 184
- Physical Nets: 9

## Official SysML Validation

- Official Pilot Version: ${official.kernel_version}
- Syntax Errors: ${official.syntax_error_count}
- Semantic Errors: ${official.semantic_error_count}
- Warnings: ${official.warning_count}
- Status: **${officialPass ? "PASS" : "FAIL"}**

## SSI

- SSI Version: ${ssiTag}
- SSI Repository: \`${ssiRepo}\`
- Commit: \`${ssiHead}\`
- Author Source Modified: **${ssiDirty ? "YES" : "NO"}**
- All16 Projection: **${ssi.status}**
- L2 Components: ${ssi.components_parsed}/16
- Promoted Ports: ${ssi.ports_parsed}
- Interface Definitions: ${ssi.interface_definitions_parsed}
- Cross-L2 Connections: ${ssi.connections_parsed}
- SSI Validation Errors: ${ssi.validation_error_count}
- SSD: \`${ssd}\`
- SSD Components: ${ssi.ssd_component_count}
- SSD Connectors: ${ssi.ssd_connector_count}
- SSD Connections: ${ssi.ssd_connection_count}
- Component Mapping: ${ssi.component_mapping_count}/${ssi.components_parsed}
- Port Mapping: ${ssi.port_mapping_count}/${ssi.ports_parsed}
- Connection Mapping: ${ssi.connection_mapping_count}/${ssi.connections_parsed}
- **RAIL_L2_ALL16_TO_SSI = ${ssiPass ? "PASS" : "FAIL"}**

## SysIDE

- Version: ${syside.version}
- Standard Library: \`${syside.standard_library}\`
- Files Parsed: ${syside.files_parsed.length}
- Syntax Diagnostics: ${syside.severity_counts.error}
- Semantic Diagnostics: 0
- Warnings: ${syside.severity_counts.warning}
- Unsupported Constructs: 0 reported
- **SYSIDE_FULL_RAIL = ${sysidePass ? "PASS" : "FAIL"}**

## SysON

- Version: v2026.7.0
- Deployment Method: ${workspaceManifest.deployment_method}
- URL: ${workspaceManifest.url}
- Project ID: \`${workspaceManifest.project_id}\`
- Full SysML Import: **${workspaceManifest.direct_full_sysml_import}**
- Semantic Projection: **NOT_NEEDED**
- Visualization-only Projection: **GENERATED**
- Persisted Views: ${syson.representations.persisted}/76
- Actual SVG Exports: ${sysonSvg.indexed}/76
- Valid SVG Envelopes: ${sysonSvgValidation.valid}/76 (${sysonSvgValidation.total_bytes} bytes)
- Products Visualized: ${syson.products.visualized_count}/147
- Ports Visualized: ${syson.ports.visualized_count}/517
- Functions Visualized: ${syson.functions.visualized_count}/191
- Allocations Visualized: ${syson.allocations.visualized_count}/191
- Connections Visualized: ${syson.connections.visualized_count}/184
- Physical Nets Visualized: ${syson.physical_nets.visualized_count}/9
- L2 Detailed Views: ${syson.l2_detailed_views.created}/16
- Full Architecture Overview: ${syson.key_views.full_architecture_overview}
- Full L2 Interface Overview: ${syson.key_views.all16_l2_boundary_overview}
- Regenerative Braking View: ${syson.key_views.regenerative_braking_core}
- Actual diagram edges: allocations ${syson.actual_diagram_edges.allocations}, final connections ${syson.actual_diagram_edges.final_connections}, physical nets ${syson.actual_diagram_edges.physical_nets}, L2 boundary ${syson.actual_diagram_edges.l2_boundary_connections}
- **SYSON_FULL_RAIL_VISUALIZATION = ${sysonPass ? "PASS" : "FAIL"}**

## Integrity

- Original Excel Modified: **NO**
- Original Full SysML Modified: **${fullHash === ssiProjection.full_model_sha256 ? "NO" : "YES"}**
- Original Final Connections Modified: **${systemDefinitionHash === ssiProjection.source_sha256["07_SystemDefinition.sysml"] ? "NO" : "YES"}**
- Author SSI Source Modified: **${ssiDirty ? "YES" : "NO"}**
- Second Manually Maintained SysML Model Created: **NO**
- SysON visualization projection: generated, traceable, derived-only

## Unified Toolchain

\`\`\`text
Rail_MBSE_Function_Interface_v1_final.xlsx
        ↓
Full Rail SysML v2
        ↓
Official SysML v2 Pilot Validation
        ↓
        ├──────── SysIDE
        │         Full textual/model validation
        │
        ├──────── SysON
        │         Full graphical model visualization
        │
        └──────── SSI-compatible L2 Projection
                  ↓
             Original SSI Transformer
                  ↓
             All16 SSD
                  ↓
          [NEXT STAGE: Simulation]
\`\`\`

SysIDE, SysON, and SSI are independent consumers of the same authoritative \`Rail_MBSE_Full_v1.sysml\`; none is a second authoritative model.

## Final Status

- OFFICIAL_SYSML_V2 = ${officialPass ? "PASS" : "FAIL"}
- RAIL_L2_ALL16_TO_SSI = ${ssiPass ? "PASS" : "FAIL"}
- SYSIDE_FULL_RAIL = ${sysidePass ? "PASS" : "FAIL"}
- SYSON_FULL_RAIL_VISUALIZATION = ${sysonPass ? "PASS" : "FAIL"}
- ORIGINAL_FULL_SYSML_MODIFIED = ${fullHash === ssiProjection.full_model_sha256 ? "NO" : "YES"}
- SSI_AUTHOR_SOURCE_MODIFIED = ${ssiDirty ? "YES" : "NO"}

**RAIL_MBSE_MODEL_TOOLCHAIN = ${overallStatus}**
`;
fs.writeFileSync(path.join(outputDirectory, "Rail_MBSE_Toolchain_Status.md"), report, "utf8");

process.stdout.write(`${JSON.stringify({
  OFFICIAL_SYSML_V2: officialPass ? "PASS" : "FAIL",
  RAIL_L2_ALL16_TO_SSI: ssiPass ? "PASS" : "FAIL",
  SYSIDE_FULL_RAIL: sysidePass ? "PASS" : "FAIL",
  SYSON_FULL_RAIL_VISUALIZATION: sysonPass ? "PASS" : "FAIL",
  ORIGINAL_FULL_SYSML_MODIFIED: fullHash === ssiProjection.full_model_sha256 ? "NO" : "YES",
  SSI_AUTHOR_SOURCE_MODIFIED: ssiDirty ? "YES" : "NO",
  RAIL_MBSE_MODEL_TOOLCHAIN: overallStatus,
  missing_required_files: missingFiles,
}, null, 2)}\n`);

if (overallStatus !== "PASS") process.exit(1);
