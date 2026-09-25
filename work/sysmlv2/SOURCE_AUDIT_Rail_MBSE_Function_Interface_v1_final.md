# Rail MBSE Primary Excel Source Audit

Primary candidate: `C:\Users\AUSA\Desktop\牵引制动能量回收\Rail_MBSE_Function_Interface_v1_final.xlsx`

SHA-256: `e94490ec35060b5b7ac7f281df9983ac560c744a4de2e6270a0464c93bd2adc0`

Sheets read: 10

## Sheet inventory

### Function

- Data rows: 191
- Header row: 4
- Columns: function_id, function_name_cn, function_name_en, function_level, function_category, owner_product_code, owner_product_name, description, generation_basis
- Data types: function_id=str, function_name_cn=str, function_name_en=str, function_level=int, function_category=str, owner_product_code=str, owner_product_name=str, description=str, generation_basis=str
- Main content: Engineering functions and hierarchy level
- Participates in SysML generation: YES
- Duplicate `function_id`: 0
- Blank `function_id`: 0

### Function_Allocation

- Data rows: 191
- Header row: 4
- Columns: allocation_id, function_id, product_code, product_name, allocation_type
- Data types: allocation_id=str, function_id=str, product_code=str, product_name=str, allocation_type=str
- Main content: Function-to-product allocations
- Participates in SysML generation: YES
- Duplicate `allocation_id`: 0
- Blank `allocation_id`: 0

### Interface

- Data rows: 517
- Header row: 4
- Columns: interface_instance_id, product_code, product_name, port_id, port_name, direction, port_category, item_code, item_name, port_type_id, interface_type_id, profile_active, connection_mode, physical_net_id, xmi_element_id
- Data types: interface_instance_id=str, product_code=str, product_name=str, port_id=str, port_name=str, direction=str, port_category=str, item_code=str, item_name=str, port_type_id=str, interface_type_id=str, profile_active=bool, connection_mode=str, physical_net_id=str, xmi_element_id=str
- Main content: Leaf raw port instances and item/type bindings
- Participates in SysML generation: YES
- Duplicate `interface_instance_id`: 0
- Blank `interface_instance_id`: 0

### Function_Interface

- Data rows: 471
- Header row: 4
- Columns: mapping_id, function_id, interface_instance_id, usage_role
- Data types: mapping_id=str, function_id=str, interface_instance_id=str, usage_role=str
- Main content: Function-to-interface usage relations
- Participates in SysML generation: YES
- Duplicate `mapping_id`: 0
- Blank `mapping_id`: 0

### Connection

- Data rows: 184
- Header row: 4
- Columns: connection_id, source_product_code, source_port_id, target_product_code, target_port_id, item_code, interface_type_id, mode, profile_id, resolution_basis, xmi_connector_id
- Data types: connection_id=str, source_product_code=str, source_port_id=str, target_product_code=str, target_port_id=str, item_code=str, interface_type_id=str, mode=str, profile_id=str, resolution_basis=str, xmi_connector_id=str
- Main content: Formal final leaf connections
- Participates in SysML generation: YES
- Duplicate `connection_id`: 0
- Blank `connection_id`: 0

### PhysicalNet

- Data rows: 9
- Header row: 4
- Columns: net_id, name, item_code, domain, profile_id, member_count, xmi_element_id
- Data types: net_id=str, name=str, item_code=str, domain=str, profile_id=str, member_count=int, xmi_element_id=str
- Main content: N-ary physical network definitions
- Participates in SysML generation: YES
- Duplicate `net_id`: 0
- Blank `net_id`: 0

### Net_Member

- Data rows: 82
- Header row: 4
- Columns: net_member_id, net_id, product_code, port_id, item_code
- Data types: net_member_id=str, net_id=str, product_code=str, port_id=str, item_code=str
- Main content: Physical network member ports
- Participates in SysML generation: YES
- Duplicate `net_member_id`: 0
- Blank `net_member_id`: 0

### Product_Hierarchy

- Data rows: 147
- Header row: 4
- Columns: code, name, level, parent_code, leaf, selected, source_type, namespace, xmi_element_id
- Data types: code=str, name=str, level=int, parent_code=str, leaf=bool, selected=bool, source_type=str, namespace=str, xmi_element_id=str
- Main content: Complete L1-L4 product hierarchy
- Participates in SysML generation: YES
- Duplicate `code`: 0
- Blank `code`: 0

### Item

- Data rows: 144
- Header row: 4
- Columns: item_code, name_cn, name_en, family, domain, datatype, unit_medium, semantic_definition, aliases, priority, validity_rule, fault_strategy, usage_note, port_type_id, interface_type_id, xmi_metaclass_hint, xmi_element_id
- Data types: item_code=str, name_cn=str, name_en=str, family=str, domain=str, datatype=str, unit_medium=str, semantic_definition=str, aliases=str, priority=str, validity_rule=str, fault_strategy=str, usage_note=str, port_type_id=str, interface_type_id=str, xmi_metaclass_hint=str, xmi_element_id=str
- Main content: Canonical engineering item dictionary
- Participates in SysML generation: YES
- Duplicate `item_code`: 0
- Blank `item_code`: 0

### XMI_Export_QA

- Data rows: 10
- Header row: 4
- Columns: qa_id, status, detail
- Data types: qa_id=str, status=str, detail=str
- Main content: Source-side cross-check only
- Participates in SysML generation: NO (validation only)
- Duplicate `qa_id`: 0
- Blank `qa_id`: 0

## Relationships

- Product_Hierarchy.code owns Interface.product_code and Function.owner_product_code.
- Interface.item_code resolves to Item.item_code; only leaf products own raw ports.
- Connection endpoints resolve to raw leaf ports, except 12 explicit external-boundary targets with null target ports.
- Function_Allocation links every Function to one Product.
- Function_Interface links functions to raw interface instances.
- Net_Member links each PhysicalNet to member leaf raw ports.

## Completeness decision

The workbook contains the complete engineering tables and exact baseline counts. It is the PRIMARY ENGINEERING SOURCE. The architecture JSON is used only for the three external-boundary names/domains and cross-checking; derived fields are recorded in SOURCE_FIELD_PROVENANCE.json.
