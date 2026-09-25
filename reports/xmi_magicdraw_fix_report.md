# MagicDraw 2022x SysML XMI fix report

- Installed MagicDraw/SysML Plugin: `2022x` / `202200000`
- Old UML XML namespace: `https://www.omg.org/spec/UML/20161101`
- New UML XML namespace: `http://www.omg.org/spec/UML/20131001`
- XMI XML namespace: `http://www.omg.org/spec/XMI/20131001`
- UML 2.5.1 metamodel package URI remains: `http://www.omg.org/spec/UML/20161101`
- SysML Profile strategy: `MAGICDRAW_BUILTIN_OMG_SYSML17_PROFILE`
- Applied Profile: `http://www.omg.org/spec/SysML/20181001/SysML.xmi#SysML`
- Neutral export: no fake MagicDraw exporter metadata

## Semantic Probe

- Product Blocks: 8 + 1 System Context Block
- Composite Part Properties: 8
- 5111 Block stereotype: PASS; `part_5111` owner: 5110
- 4235 owns `part_5111`: NO
- ProxyPorts: 2; InterfaceBlock: 1 + 1 conjugated; FlowProperty: 1
- NestedConnectorEnds: 2; both property paths follow the real Context-to-leaf compositions
- ItemFlow direction: 4235 output → 5111 input, PASS
- Activity/Allocate: 1/1, PASS
- MDMAP QA: 30 PASS / 0 FAIL
- All static QA: 46 PASS / 0 FAIL
- `CAMEO_IMPORT_TEST = PENDING`

Probe: `C:\Users\AUSA\Desktop\牵引制动能量回收\work\Rail_MBSE_SysML17_probe_MD2022x_v3.xmi`

No new full XMI was generated or published. If MagicDraw still reports model inconsistency, capture the **More...** log before changing ProfileApplication, NestedConnectorEnd, ~InterfaceBlock, ItemFlow, or Allocate serialization.
