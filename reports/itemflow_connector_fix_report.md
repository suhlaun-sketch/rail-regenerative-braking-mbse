# ItemFlow Connector Fix Report

- Scope: Connector + InformationFlow + ItemFlow mapping and MagicDraw display contract only.
- Frozen Product/Block/Part/Port/ConnectGraph/Function/Allocation inputs: unchanged.
- Full XMI: not published.

## Counts

- SIGNAL connections: 147
- Connectors: 147
- InformationFlows: 147
- ItemFlows: 147
- Item Property empty: 147
- Direction correct: 147
- v6 representative Probe Connector / InformationFlow / ItemFlow / empty Item Property: 1 / 1 / 1 / 1
- Unique Chinese Signal names: 79
- Chinese InterfaceBlock names: 221
- Independent dashed InformationFlow symbols: 0

## Result

- Connector + ItemFlow model style: PASS
- FLOW-DISPLAY QA: 10 PASS / 0 FAIL
- Probe static QA: PASS
- Automatic MagicDraw diagram presentation: PRESENTATION_STILL_NEEDS_ADJUSTMENT
- Conclusion: **PRESENTATION_STILL_NEEDS_ADJUSTMENT**

The installed MagicDraw sample represents conveyed information as Connector-owned `CONVEYED_INFORMATION_A/B` compartments and TextBox labels; it creates no separate InformationFlow path. These symbols live in a MagicDraw native diagram resource. The standard `.xmi` Probe therefore contains the correct importable model semantics, while automatic IBD layout/arrow/label placement still requires a native `.mdxml` golden sample or an in-tool presentation serializer.

Probe: `C:\Users\AUSA\Desktop\牵引制动能量回收\work\Rail_MBSE_SysML17_itemflow_probe_v6.xmi`
