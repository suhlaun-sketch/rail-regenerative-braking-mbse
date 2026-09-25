# SysIDE Full Rail Validation Report

## Tool

- Product: Syside Editor by Sensmetry
- VS Code extension: `sensmetry.syside-editor` 0.10.3
- Engine: `syside.exe` 0.10.3 (`b6e216cb48b5336ea48283e99c68a0e10e17b8cc`)
- Validation interface: official Editor language server (LSP)
- Standard library: bundled `share\sysml.library`; README identifies the Sensmetry fixes branch of SysML-v2-Release

The standalone `syside check` command requires a Modeler license. The free Editor license was therefore exercised through the same official executable's LSP diagnostic interface, which is the validation engine used by the installed Editor.

## Scope

- Isolated workspace: `work\sysmlv2\syside_integration\session_full_rail`
- File parsed: `work\sysmlv2\full_engineering_model\01_generated\Rail_MBSE_Full_v1.sysml`
- Files parsed: **1** complete aggregated authoritative model
- Full model SHA-256: `a15cf7170dc5458738080a146c391e438fe57b85f9687857f34a081b8efdf0d5`
- Authoritative file modified: **NO**

The isolated workspace is intentional: scanning `01_generated` would load both the aggregated model and its component package files, producing duplicate global packages. The final run opened only the authoritative aggregate.

## Diagnostics

- Syntax diagnostics: **0**
- Semantic diagnostics: **0**
- Warnings: **0**
- Unsupported constructs: **0 reported**
- Exceptions: **none**
- stderr: **empty**

Raw LSP evidence: `logs\syside_lsp_diagnostics.json`

## Classification

No `REAL_MODEL_ERROR`, `VERSION_DIFFERENCE`, `STANDARD_LIBRARY_DIFFERENCE`, or `TOOL_IMPLEMENTATION_DIFFERENCE` remained in the isolated final run.

`SYSIDE_FULL_RAIL = PASS`
