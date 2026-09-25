# SysML 1.7 XMI pipeline

This deterministic pipeline converts the frozen `work/architecture_xmi_ready_v1.json` into OMG SysML 1.7 / UML 2.5.1 XMI. It does not modify the frozen JSON, workbook, KG, or ConnectGraph.

Run:

```powershell
python -X utf8 tools\xmi_pipeline\run_xmi_pipeline.py
```

Outputs:

- `tools/xmi_pipeline/work/sysml17_mapping_contract.json`
- `reports/sysml17_mapping_contract.md`
- `work/Rail_MBSE_SysML17_probe.xmi`
- `work/Rail_MBSE_SysML17_v1.xmi`
- `tools/xmi_pipeline/work/xmi_validation_results.json`
- `reports/xmi_conversion_report.md`

The probe and full model use the same converter implementation. Each is generated twice in memory and compared byte-for-byte before being written. Cameo import is intentionally reported as pending unless a real Cameo/MagicDraw import is performed.

## MagicDraw 2022x semantic Probe

After the MagicDraw namespace/profile compatibility audit, run only the gated semantic Probe pipeline:

```powershell
python -X utf8 tools\xmi_pipeline\run_md2022x_probe_pipeline.py
```

This creates `work/Rail_MBSE_SysML17_probe_MD2022x_v3.xmi` and deliberately does not generate or overwrite a full XMI. A new full XMI remains gated on hands-on MagicDraw import acceptance of the Probe.

## Structure Mapping v2 Probe

Run:

```powershell
python -X utf8 tools\xmi_pipeline\run_structure_mapping_probe.py
```

This builds the Structure Mapping v2 contracts, resolves all frozen Port directions, audits the existing full XMI for model/diagram duplicates, and creates `work/Rail_MBSE_SysML17_structure_probe_v4.xmi`. It does not publish a new full XMI or vendor-specific diagrams.

## ItemFlow v2 Probe

Run:

```powershell
python -X utf8 tools\xmi_pipeline\run_itemflow_probe_pipeline.py
```

This removes the invalid InterfaceBlock FlowProperty reference from `ItemFlow.itemProperty`, keeps the conveyed Signal on the realizing Connector, assigns Chinese engineering names to directional InterfaceBlocks, and stores technical codes as standard UML String Properties. It creates `work/Rail_MBSE_SysML17_itemflow_probe_v5.xmi` without publishing a full XMI. Vendor diagram presentation remains gated on a readable MagicDraw golden sample.

## ItemFlow Connector display v6 Probe

Run:

```powershell
python -X utf8 tools\xmi_pipeline\run_itemflow_display_probe_pipeline.py
```

This matches the installed MagicDraw 2022x hand-authored InformationFlow reference form, keeps Item Property empty, and emits a presentation contract derived from the installed Connector conveyed-information symbol. It creates `work/Rail_MBSE_SysML17_itemflow_probe_v6.xmi`; no full XMI is published.

## Golden Sample native MDXML v7 Probe

Run:

```powershell
python -X utf8 tools\xmi_pipeline\run_gold_native_probe_pipeline.py
```

This reads `work/gold.mdxml` without modifying it, inventories MagicDraw's native diagram serialization, generates `work/Rail_MBSE_ItemFlow_native_probe_v7.mdxml` with new deterministic IDs, and executes all 15 PRES-QA checks. The frozen architecture inputs and full XMI remain untouched.

## Full upward-interface and hierarchical IBD model

Run:

```powershell
python -X utf8 tools\xmi_pipeline\run_full_upward_ibd_pipeline.py
```

The pipeline deterministically derives boundary-crossing ProxyPorts and hierarchical Connector segments from the frozen 184 Final Connections, projects the nine PhysicalNets as shared star structures, builds one IBD for each non-leaf Product plus the System Context, and writes both the standard semantic XMI and the MagicDraw 2022x native MDXML. It executes the complete build twice and gates both files on the upward, IBD, ItemFlow, PhysicalNet, preservation, reference, and byte-determinism checks.

## Gold2 integrated 4235→5111 Probe v2

Run:

```powershell
& 'D:\Computer\Anaconda\envs\mineru\python.exe' -X utf8 tools\xmi_pipeline\run_gold2_integrated_probe_pipeline.py
```

This reads `work/gold2.mdxml` and the frozen architecture sources without modifying them, classifies all 724 hierarchical segments deterministically, and creates only the seven-IBD `work/Rail_MBSE_Gold2_Integrated_4235_5111_Probe_v2.mdxml`. The Probe combines gold2 native Connector/IBD presentation with typed ProxyPorts, directional InterfaceBlocks, FlowProperties, Connector-bound ItemFlows, and a seven-row ICD trace contract. Full-model publication remains gated on the MagicDraw 2022x hands-on test.
