# SysML 1.7 mapping contract

- SysML Profile URI: `https://www.omg.org/spec/SysML/20240101`
- SysML namespace: `https://www.omg.org/spec/SysML/20240101`
- UML: `2.5.1`; metamodel URI `http://www.omg.org/spec/UML/20161101`
- XMI namespace: `https://www.omg.org/spec/XMI/20131001` (normative root has no `xmi:version` attribute)
- PrimitiveTypes URI: `http://www.omg.org/spec/PrimitiveTypes/20161101`
- StandardProfile URI: `http://www.omg.org/spec/UML/20161101/StandardProfile`
- ProfileApplication href: `../SysML/SysML.xmi#SysML`

## Normative stereotype fields

- `SysML::Block` (`SysML.Block`): base_Class → https://www.omg.org/spec/UML/20161101/UML.xmi#Class
- `SysML::InterfaceBlock` (`SysML.InterfaceBlock`): base_Class → https://www.omg.org/spec/UML/20161101/UML.xmi#Class
- `SysML::ProxyPort` (`SysML.ProxyPort`): base_Port → https://www.omg.org/spec/UML/20161101/UML.xmi#Port
- `SysML::FlowProperty` (`SysML.FlowProperty`): base_Property → https://www.omg.org/spec/UML/20161101/UML.xmi#Property
- `SysML::ItemFlow` (`SysML.ItemFlow`): base_InformationFlow → https://www.omg.org/spec/UML/20161101/UML.xmi#InformationFlow
- `SysML::Allocate` (`SysML.Allocate`): base_DirectedRelationship → https://www.omg.org/spec/UML/20161101/UML.xmi#DirectedRelationship, base_Abstraction → https://www.omg.org/spec/UML/20161101/UML.xmi#Abstraction
- `SysML::NestedConnectorEnd` (`SysML.NestedConnectorEnd`): base_Element → https://www.omg.org/spec/UML/20161101/UML.xmi#Element, base_ConnectorEnd → https://www.omg.org/spec/UML/20161101/UML.xmi#ConnectorEnd
- `SysML::~InterfaceBlock` (`SysML.tildeInterfaceBlock`): base_Class → https://www.omg.org/spec/UML/20161101/UML.xmi#Class

## Serialization decisions

- Product hierarchy uses 139 composite properties plus 8 Context-to-L1 composite properties.
- All 517 ports are `uml:Port` + standard `ProxyPort`.
- The profile forbids UML Port `isConjugated=true` for InterfaceBlock-typed ports. Signal inputs therefore use deterministic standard `~InterfaceBlock` types; physical flows remain `inout`.
- Final connections are LCA-owned connectors. Multi-level ends use standard `NestedConnectorEnd.propertyPath`.
- Each SIGNAL connector has one directed UML InformationFlow plus standard ItemFlow. Physical connectors do not receive a fake directed ItemFlow.
- Each PhysicalNet is one n-ary UML Connector, preserving shared-network semantics without a clique.
- Function-interface mappings use Activity parameters and standard UML Dependencies; no custom stereotype is introduced.

## Source audit

- Cameo/MagicDraw golden sample: `NOT_FOUND`.
- SysML 1.7 PDF present: `False`.
- The available specification PDF was detected as SysML 2.0 and is not used as the 1.7 serialization authority.
