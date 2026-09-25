# ItemFlow Display Fix Report

- Scope: corrected ItemFlow semantics, human-readable interface names, code metadata, and presentation strategy only.
- Block/Part hierarchy, Ports, ConnectGraph, Functions, Allocations, and frozen inputs: unchanged.
- Full XMI: not published.

## Result

- SIGNAL Connections / InformationFlows / ItemFlows: 147 / 147 / 147
- Illegal ItemFlow.itemProperty: 0
- Distinct conveyed Signals with Chinese names: 79
- Directional InterfaceBlocks with Chinese names: 221
- InterfaceBlocks with all code metadata: 221 (884 standard UML String Properties)
- Independent InformationFlow diagram symbols: 0
- QA: 22 PASS / 0 FAIL; Probe PASS
- Failed checks: None

## MagicDraw Presentation

- Installed MagicDraw examples confirm ItemFlow without itemProperty and InformationFlow.realizingConnector.
- Exact diagram paths, line styles, markers, and label placement are stored in proprietary binary streams inside mdzip, not portable neutral XMI.
- Status: GOLDEN_SAMPLE_REQUIRED
- Required golden sample: minimal MagicDraw-saved IBD containing two parts, two ProxyPorts, one solid Connector, and one displayed ItemFlow.

## Probe

- `C:\Users\AUSA\Desktop\牵引制动能量回收\work\Rail_MBSE_SysML17_itemflow_probe_v5.xmi`
