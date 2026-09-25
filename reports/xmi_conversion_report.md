# SysML 1.7 XMI conversion report

- Standard files: formal-26-03-02.pdf, SysML.xmi, SysMLdi.xmi, UML.xmi, UMLpre.xmi, umlstandard.xmi, XMI.xsd
- SysML: 1.7 profile URI `https://www.omg.org/spec/SysML/20240101`
- UML: 2.5.1 (`http://www.omg.org/spec/UML/20161101`)
- XMI: namespace date `20131001`; normative SysML root has no `xmi:version` attribute
- Available PDF audit: SysML 2.0 (not used as the SysML 1.7 authority)
- Cameo/MagicDraw golden sample: not found

## Generated model

- Product Blocks: 147
- Composite Part Properties: 147
- ProxyPorts: 517
- InterfaceBlocks: 142 canonical + 126 standard conjugated types
- FlowProperties: 142
- Connectors: 193 total (184 Final + 9 n-ary PhysicalNet)
- Signal ItemFlows: 147
- PhysicalNets: 9
- Activities: 191
- Allocates: 191
- Function_Interface traces: 471
- Voltage anchors: 6

## QA

- Probe static QA: PASS
- XMI17 QA: 25 PASS / 0 FAIL
- Local XMI.xsd: `NOT_APPLICABLE_NAMESPACE_MISMATCH` — local XSD uses the legacy HTTP namespace and no local UML/SysML XSD set is present; XML well-formedness, ID/href/reference, profile, and model-semantic checks passed independently.
- Full XMI byte reproducibility: PASS
- `CAMEO_IMPORT_TEST = PENDING`

Probe: `C:\Users\AUSA\Desktop\牵引制动能量回收\work\Rail_MBSE_SysML17_probe.xmi`

Full XMI: `C:\Users\AUSA\Desktop\牵引制动能量回收\work\Rail_MBSE_SysML17_v1.xmi`
