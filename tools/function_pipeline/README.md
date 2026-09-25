# Function Architecture Pipeline

This deterministic pipeline consumes the frozen `KG v1` and `ConnectGraph v1` JSON outputs. It does not connect to or modify Neo4j.

Run with the existing KG virtual environment:

```powershell
& tools/kg_pipeline/.venv/Scripts/python.exe tools/function_pipeline/run_function_pipeline.py
```

The runner executes all eight stages twice. It verifies byte-level determinism for the XMI-ready JSON and schema, semantic determinism for the workbook, Function QA, XMI-ready QA, workbook readback, and all six voltage traceability anchors.

Stage `07_export_interface_workbook.py` contains JavaScript and is passed to Node in module mode so the required stage filename is retained while workbook authoring uses `@oai/artifact-tool`.

Outputs:

- `Rail_MBSE_Function_Interface_v1.xlsx`
- `work/architecture_xmi_ready.json`
- `work/architecture_xmi_ready.schema.json`
- `reports/function_architecture_report.md`

The pipeline stops at Function, Allocation, Function-Interface Mapping, Interface engineering tables and XMI-ready JSON. It does not generate XMI, SysML, Simulink, SSD or FMU artifacts.
