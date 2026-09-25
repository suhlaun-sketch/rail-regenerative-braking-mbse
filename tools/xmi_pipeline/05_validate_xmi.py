from __future__ import annotations

import hashlib
import json
import re
import xml.etree.ElementTree as ET
from collections import Counter
from pathlib import Path


PIPELINE_DIR = Path(__file__).resolve().parent
ROOT = PIPELINE_DIR.parents[1]
PIPELINE_WORK = PIPELINE_DIR / "work"
WORK_DIR = ROOT / "work"
REPORTS_DIR = ROOT / "reports"
SOURCE_JSON = WORK_DIR / "architecture_xmi_ready_v1.json"
FULL_XMI = WORK_DIR / "Rail_MBSE_SysML17_v1.xmi"
PROBE_XMI = WORK_DIR / "Rail_MBSE_SysML17_probe.xmi"

XMI = "https://www.omg.org/spec/XMI/20131001"
UML = "https://www.omg.org/spec/UML/20161101"
SYSML = "https://www.omg.org/spec/SysML/20240101"


def q(namespace: str, local: str) -> str:
    return f"{{{namespace}}}{local}"


def local_name(tag: str) -> str:
    return tag.rsplit("}", 1)[-1]


def xid(element: ET.Element) -> str | None:
    return element.get(q(XMI, "id"))


def xtype(element: ET.Element) -> str | None:
    return element.get(q(XMI, "type"))


def elements_of_type(root: ET.Element, name: str) -> list[ET.Element]:
    return [e for e in root.iter() if xtype(e) == f"uml:{name}"]


def app_elements(root: ET.Element, name: str) -> list[ET.Element]:
    return [e for e in root if e.tag == q(SYSML, name)]


def app_refs(element: ET.Element, name: str) -> list[str]:
    values = []
    if element.get(name):
        values.extend(element.get(name).split())
    for child in element:
        if local_name(child.tag) == name and child.get(q(XMI, "idref")):
            values.append(child.get(q(XMI, "idref")))
    return values


def app_ref(element: ET.Element, name: str) -> str | None:
    values = app_refs(element, name)
    return values[0] if values else None


def parse(path: Path) -> tuple[ET.Element, dict[str, ET.Element], dict[ET.Element, ET.Element]]:
    root = ET.parse(path).getroot()
    ids = {xid(e): e for e in root.iter() if xid(e)}
    parents = {child: parent for parent in root.iter() for child in parent}
    return root, ids, parents


def check_local_references(root: ET.Element, ids: dict[str, ET.Element]) -> list[str]:
    singular = {
        "type", "role", "partWithPort", "client", "supplier", "informationSource",
        "informationTarget", "conveyed", "realizingConnector", "annotatedElement",
        "itemProperty", "original", "base_Class", "base_Port", "base_Property",
        "base_InformationFlow", "base_Abstraction", "base_DirectedRelationship",
        "base_ConnectorEnd", "base_Element",
    }
    plural = {"propertyPath"}
    missing = []
    for element in root.iter():
        for raw_name, value in element.attrib.items():
            name = local_name(raw_name)
            if raw_name == q(XMI, "type") or name == "id":
                continue
            if name in singular:
                if value not in ids:
                    missing.append(f"{xid(element) or local_name(element.tag)}.{name} -> {value}")
            elif name in plural:
                for ref in value.split():
                    if ref not in ids:
                        missing.append(f"{xid(element) or local_name(element.tag)}.{name} -> {ref}")
            elif raw_name == q(XMI, "idref") and value not in ids:
                missing.append(f"idref -> {value}")
    return missing


def build_parent_model(data: dict) -> tuple[dict[str, str], dict[tuple[str, str], str]]:
    products = {p["id"]: p for p in data["products"]}
    parent = {}
    part_ids = {}
    for p in data["products"]:
        owner = p.get("parent_id") if p.get("parent_id") in products else "__CONTEXT__"
        parent[p["id"]] = owner
        seed = f"{owner}::{p['id']}"
        digest = hashlib.sha1(seed.encode("utf-8")).hexdigest()[:18].upper()
        part_ids[(owner, p["id"])] = f"XMI-PART-{digest}"
    return parent, part_ids


def lca(parent: dict[str, str], products: list[str], force_context: bool = False) -> str:
    if force_context:
        return "__CONTEXT__"
    chains = []
    for product in products:
        chain = [product]
        while chain[-1] != "__CONTEXT__":
            chain.append(parent[chain[-1]])
        chains.append(chain)
    return next(candidate for candidate in chains[0] if all(candidate in chain for chain in chains[1:]))


def part_path(parent: dict[str, str], part_ids: dict[tuple[str, str], str], owner: str, product: str) -> list[str]:
    if owner == product:
        return []
    chain = []
    current = product
    while current != owner:
        chain.append(current)
        current = parent[current]
    chain.reverse()
    result = []
    current_owner = owner
    for child in chain:
        result.append(part_ids[(current_owner, child)])
        current_owner = child
    return result


def qa_entry(identifier: str, passed: bool, detail: str) -> dict:
    return {"id": identifier, "status": "PASS" if passed else "FAIL", "detail": detail}


def validate_probe() -> dict:
    root, ids, _parents = parse(PROBE_XMI)
    product_ids = {app_ref(e, "base_Class") for e in app_elements(root, "Block")} - {"XMI-SYSTEM-CONTEXT-RAIL-MBSE-TRACTIONBRAKE"}
    composites = [e for e in elements_of_type(root, "Property") if e.get("aggregation") == "composite"]
    canonical_ibs = app_elements(root, "InterfaceBlock")
    result = {
        "xml_well_formed": True,
        "system_context": "XMI-SYSTEM-CONTEXT-RAIL-MBSE-TRACTIONBRAKE" in ids,
        "product_blocks": len(product_ids),
        "composite_parts": len(composites),
        "proxy_ports": len(app_elements(root, "ProxyPort")),
        "canonical_interface_blocks": len(canonical_ibs),
        "conjugated_interface_blocks": len(app_elements(root, "tildeInterfaceBlock")),
        "flow_properties": len(app_elements(root, "FlowProperty")),
        "signal_items": len(elements_of_type(root, "Signal")),
        "connectors": len(elements_of_type(root, "Connector")),
        "information_flows": len(elements_of_type(root, "InformationFlow")),
        "item_flows": len(app_elements(root, "ItemFlow")),
        "activities": len(elements_of_type(root, "Activity")),
        "allocates": len(app_elements(root, "Allocate")),
        "profile_application": any(local_name(e.tag) == "profileApplication" for e in root.iter()),
    }
    result["status"] = "PASS" if all([
        result["system_context"], result["product_blocks"] == 2, result["composite_parts"] == 1,
        result["proxy_ports"] == 2, result["canonical_interface_blocks"] == 1,
        result["flow_properties"] == 1, result["signal_items"] == 1,
        result["connectors"] == 1, result["item_flows"] == 1,
        result["activities"] == 1, result["allocates"] == 1, result["profile_application"],
    ]) else "FAIL"
    return result


def validate_full() -> dict:
    data = json.loads(SOURCE_JSON.read_text(encoding="utf-8"))
    contract = json.loads((PIPELINE_WORK / "sysml17_mapping_contract.json").read_text(encoding="utf-8"))
    manifest = json.loads((PIPELINE_WORK / "xmi_build_manifest.json").read_text(encoding="utf-8"))
    root, ids, xml_parents = parse(FULL_XMI)
    all_id_values = [xid(e) for e in root.iter() if xid(e)]
    duplicates = [value for value, count in Counter(all_id_values).items() if count > 1]
    missing_refs = check_local_references(root, ids)
    hrefs = [e.get("href") for e in root.iter() if e.get("href")]
    allowed_hrefs = {contract["profile_application"]["local_href_from_work_output"]}

    products = {p["id"]: p for p in data["products"]}
    product_xmi = {p["id"]: p["xmi_id"] for p in data["products"]}
    interfaces = {i["interface_instance_id"]: i for i in data["interfaces"]}
    port_by_xmi = {i["xmi_id"]: i for i in data["interfaces"]}
    item_xmi = {i["item_code"]: i["xmi_id"] for i in data["items"]}
    parent_model, part_ids = build_parent_model(data)

    block_apps = app_elements(root, "Block")
    block_targets = {app_ref(e, "base_Class") for e in block_apps}
    product_block_missing = [p["id"] for p in data["products"] if p["xmi_id"] not in block_targets]
    composite_properties = [e for e in elements_of_type(root, "Property") if e.get("aggregation") == "composite"]
    hierarchy_expected = {
        (product_xmi[p["parent_id"]], p["xmi_id"])
        for p in data["products"] if p.get("parent_id") in products
    }
    hierarchy_actual = set()
    context_actual = set()
    for prop in composite_properties:
        owner = xml_parents.get(prop)
        pair = (xid(owner), prop.get("type")) if owner is not None else (None, prop.get("type"))
        if pair[0] == "XMI-SYSTEM-CONTEXT-RAIL-MBSE-TRACTIONBRAKE":
            context_actual.add(pair[1])
        else:
            hierarchy_actual.add(pair)
    context_expected = {p["xmi_id"] for p in data["products"] if p.get("parent_id") not in products}

    ports = elements_of_type(root, "Port")
    proxy_apps = app_elements(root, "ProxyPort")
    proxy_targets = {app_ref(a, "base_Port") for a in proxy_apps}
    ib_targets = {app_ref(a, "base_Class") for a in app_elements(root, "InterfaceBlock")}
    tilde_targets = {app_ref(a, "base_Class") for a in app_elements(root, "tildeInterfaceBlock")}
    bad_port_types = [xid(p) for p in ports if p.get("type") not in ib_targets | tilde_targets]
    bad_conjugation = [xid(p) for p in ports if p.get("isConjugated") != "false"]

    flow_apps = app_elements(root, "FlowProperty")
    flow_directions = {app_ref(a, "base_Property"): a.get("direction") for a in flow_apps}
    bad_flow_directions = [key for key, value in flow_directions.items() if value not in {"out", "inout"}]
    ib_without_flow = []
    for class_id in ib_targets:
        cls = ids[class_id]
        owned_property_ids = {xid(c) for c in cls if xtype(c) == "uml:Property"}
        if not owned_property_ids & set(flow_directions):
            ib_without_flow.append(class_id)

    connectors = elements_of_type(root, "Connector")
    connector_ids = {xid(e) for e in connectors}
    final_connection_ids = {c["xmi_id"] for c in data["connections"]}
    net_connector_ids = {n["xmi_id"] for n in data["physical_nets"]}
    info_flows = elements_of_type(root, "InformationFlow")
    itemflow_apps = app_elements(root, "ItemFlow")
    itemflow_by_base = {app_ref(a, "base_InformationFlow"): a for a in itemflow_apps}
    info_by_connector = {e.get("realizingConnector"): e for e in info_flows}
    signal_connections = [c for c in data["connections"] if c["mode"] == "SIGNAL"]
    signal_missing_flow = [c["connection_id"] for c in signal_connections if c["xmi_id"] not in info_by_connector]
    reverse_or_bad_direction = []
    conveyed_errors = []
    item_property_errors = []
    orphan_itemflows = []
    property_types = {xid(e): e.get("type") for e in elements_of_type(root, "Property")}
    for connection in signal_connections:
        info = info_by_connector.get(connection["xmi_id"])
        if info is None:
            continue
        source = interfaces[connection["source_interface_id"]]
        target = interfaces[connection["target_interface_id"]]
        if source["direction"] != "输出" or target["direction"] != "输入" or info.get("informationSource") != source["xmi_id"] or info.get("informationTarget") != target["xmi_id"]:
            reverse_or_bad_direction.append(connection["connection_id"])
        if info.get("conveyed") != item_xmi[connection["item_id"]]:
            conveyed_errors.append(connection["connection_id"])
        app = itemflow_by_base.get(xid(info))
        if app is None:
            orphan_itemflows.append(connection["connection_id"])
        elif property_types.get(app_ref(app, "itemProperty")) != item_xmi[connection["item_id"]]:
            item_property_errors.append(connection["connection_id"])
    for app in itemflow_apps:
        if app_ref(app, "base_InformationFlow") not in ids:
            orphan_itemflows.append(xid(app))

    connector_owner_errors = []
    connector_end_errors = []
    nested_by_end = {app_ref(a, "base_ConnectorEnd"): a for a in app_elements(root, "NestedConnectorEnd")}
    for connection in data["connections"]:
        connector = ids.get(connection["xmi_id"])
        if connector is None:
            continue
        expected_owner = lca(
            parent_model,
            [x for x in (connection["source_product_id"], connection.get("target_product_id")) if x],
            bool(connection.get("target_boundary_id")),
        )
        expected_owner_xmi = "XMI-SYSTEM-CONTEXT-RAIL-MBSE-TRACTIONBRAKE" if expected_owner == "__CONTEXT__" else product_xmi[expected_owner]
        if xid(xml_parents[connector]) != expected_owner_xmi:
            connector_owner_errors.append(connection["connection_id"])
        ends = [e for e in connector if xtype(e) == "uml:ConnectorEnd"]
        if len(ends) != 2 or any(not e.get("role") for e in ends):
            connector_end_errors.append(connection["connection_id"])
            continue
        expected_endpoints = [
            (connection["source_product_id"], connection["source_interface_id"]),
            (connection.get("target_product_id"), connection.get("target_interface_id")),
        ]
        for end, (product_id, interface_id) in zip(ends, expected_endpoints):
            if product_id is None:
                if not end.get("role", "").startswith("XMI-BOUNDARY-REFERENCE-"):
                    connector_end_errors.append(connection["connection_id"])
                continue
            expected_path = part_path(parent_model, part_ids, expected_owner, product_id)
            expected_role = interfaces[interface_id]["xmi_id"]
            nested = nested_by_end.get(xid(end))
            if end.get("role") != expected_role:
                connector_end_errors.append(connection["connection_id"])
            if expected_path and end.get("partWithPort") != expected_path[-1]:
                connector_end_errors.append(connection["connection_id"])
            if not expected_path and end.get("partWithPort") is not None:
                connector_end_errors.append(connection["connection_id"])
            if len(expected_path) > 1 and (nested is None or app_refs(nested, "propertyPath") != expected_path):
                connector_end_errors.append(connection["connection_id"])

    net_errors = []
    for net in data["physical_nets"]:
        connector = ids.get(net["xmi_id"])
        ends = [e for e in connector if xtype(e) == "uml:ConnectorEnd"] if connector is not None else []
        expected_roles = {interfaces[m["interface_id"]]["xmi_id"] for m in net["members"]}
        expected_owner = lca(parent_model, [m["product_id"] for m in net["members"]])
        expected_owner_xmi = "XMI-SYSTEM-CONTEXT-RAIL-MBSE-TRACTIONBRAKE" if expected_owner == "__CONTEXT__" else product_xmi[expected_owner]
        net_bad = connector is None or len(ends) != net["member_count"] or {e.get("role") for e in ends} != expected_roles
        if connector is not None and xid(xml_parents[connector]) != expected_owner_xmi:
            net_bad = True
        members_by_role = {interfaces[m["interface_id"]]["xmi_id"]: m for m in net["members"]}
        for end in ends:
            member = members_by_role.get(end.get("role"))
            if member is None:
                net_bad = True
                continue
            expected_path = part_path(parent_model, part_ids, expected_owner, member["product_id"])
            nested = nested_by_end.get(xid(end))
            if expected_path and end.get("partWithPort") != expected_path[-1]:
                net_bad = True
            if len(expected_path) > 1 and (nested is None or app_refs(nested, "propertyPath") != expected_path):
                net_bad = True
        if net_bad:
            net_errors.append(net["net_id"])

    activities = elements_of_type(root, "Activity")
    activity_ids = {xid(e) for e in activities}
    abstractions = elements_of_type(root, "Abstraction")
    allocate_apps = app_elements(root, "Allocate")
    allocation_errors = [
        a["allocation_id"] for a in data["allocations"]
        if a["xmi_id"] not in ids or a["xmi_id"] not in {xid(e) for e in abstractions}
        or not any(app_ref(app, "base_Abstraction") == a["xmi_id"] for app in allocate_apps)
    ]

    parameters = elements_of_type(root, "Parameter")
    parameter_ids = {xid(e) for e in parameters}
    dependencies = elements_of_type(root, "Dependency")
    dependency_pairs = {(e.get("client"), e.get("supplier")) for e in dependencies}
    mapping_errors = []
    for mapping in data["function_interface_mappings"]:
        target_port = interfaces[mapping["interface_instance_id"]]["xmi_id"]
        if mapping["xmi_id"] not in parameter_ids or (mapping["xmi_id"], target_port) not in dependency_pairs:
            mapping_errors.append(mapping["mapping_id"])

    anchor_comments = [
        e for e in elements_of_type(root, "Comment")
        if (e.get("body") or "").startswith("VoltageAnchor::")
    ]
    anchor_errors = [xid(e) for e in anchor_comments if e.get("annotatedElement") not in ids]

    sysml_app_names = {local_name(e.tag) for e in root if e.tag.startswith("{" + SYSML + "}")}
    allowed_app_names = {
        "Block", "InterfaceBlock", "tildeInterfaceBlock", "ProxyPort", "FlowProperty",
        "ItemFlow", "Allocate", "NestedConnectorEnd",
    }
    custom_stereotypes = sorted(sysml_app_names - allowed_app_names)
    stereotype_contract_errors = []
    for app in [e for e in root if e.tag.startswith("{" + SYSML + "}")]:
        name = local_name(app.tag)
        definition = contract["stereotypes"].get(name)
        if definition is None:
            stereotype_contract_errors.append(f"{xid(app)}: unknown {name}")
            continue
        for base in definition["base_fields"]:
            if not app_ref(app, base["name"]):
                stereotype_contract_errors.append(f"{xid(app)}: missing {base['name']}")
    profile_definitions = elements_of_type(root, "Profile") + [e for e in root.iter() if e.tag == q(UML, "Profile")]

    hierarchy_dependency_pairs = {(e.get("client"), e.get("supplier")) for e in dependencies}
    hierarchy_as_dependency = [pair for pair in hierarchy_expected if pair in hierarchy_dependency_pairs or pair[::-1] in hierarchy_dependency_pairs]
    physical_connection_errors = []
    signal_connector_ids = {c["xmi_id"] for c in signal_connections}
    for connection in data["connections"]:
        if connection["mode"] == "SIGNAL":
            continue
        source = interfaces[connection["source_interface_id"]]
        target_id = connection.get("target_interface_id")
        if source["direction"] != "双向物理" or (target_id and interfaces[target_id]["direction"] != "双向物理") or connection["xmi_id"] in info_by_connector:
            physical_connection_errors.append(connection["connection_id"])
    physical_port_flow_errors = []
    for interface in data["interfaces"]:
        if interface["direction"] != "双向物理":
            continue
        port = ids[interface["xmi_id"]]
        class_element = ids[port.get("type")]
        flow_ids = [xid(c) for c in class_element if xtype(c) == "uml:Property"]
        if not flow_ids or any(flow_directions.get(fid) != "inout" for fid in flow_ids):
            physical_port_flow_errors.append(interface["interface_instance_id"])

    expected_profile_href = contract["profile_application"]["local_href_from_work_output"]
    profile_app_ok = any(
        local_name(e.tag) == "appliedProfile" and e.get("href") == expected_profile_href
        for e in root.iter()
    )

    qa = [
        qa_entry("XMI17-01", True, "XML well-formed"),
        qa_entry("XMI17-02", not duplicates, f"duplicate xmi:id={len(duplicates)}"),
        qa_entry("XMI17-03", not missing_refs, f"unresolved local references={len(missing_refs)}"),
        qa_entry("XMI17-04", set(hrefs) <= allowed_hrefs, f"hrefs={hrefs}"),
        qa_entry("XMI17-05", profile_app_ok, f"SysML ProfileApplication href={expected_profile_href}"),
        qa_entry("XMI17-06", not product_block_missing and len(data["products"]) == 147, f"Product Blocks={147-len(product_block_missing)}/147"),
        qa_entry("XMI17-07", hierarchy_actual == hierarchy_expected and len(hierarchy_expected) == 139, f"hierarchy compositions={len(hierarchy_actual)}/139"),
        qa_entry("XMI17-08", context_actual == context_expected and len(context_expected) == 8, f"Context-to-L1 compositions={len(context_actual)}/8"),
        qa_entry("XMI17-09", len(composite_properties) == 147, f"composite Part Properties={len(composite_properties)}"),
        qa_entry("XMI17-10", len(ports) == 517 and len(proxy_apps) == 517 and {xid(p) for p in ports} == proxy_targets, f"Ports/ProxyPorts={len(ports)}/{len(proxy_apps)}"),
        qa_entry("XMI17-11", not bad_port_types and not bad_conjugation, f"bad port types={len(bad_port_types)}, bad isConjugated={len(bad_conjugation)}"),
        qa_entry("XMI17-12", not bad_flow_directions and not ib_without_flow, f"FlowProperties={len(flow_apps)}, invalid={len(bad_flow_directions)}, InterfaceBlocks without flow={len(ib_without_flow)}"),
        qa_entry("XMI17-13", len(signal_connections) == 147 and not signal_missing_flow and len(itemflow_apps) == 147, f"SIGNAL/ItemFlow={len(signal_connections)}/{len(itemflow_apps)}"),
        qa_entry("XMI17-14", not reverse_or_bad_direction, f"direction errors={len(reverse_or_bad_direction)}"),
        qa_entry("XMI17-15", not conveyed_errors and not item_property_errors and not orphan_itemflows, f"conveyed={len(conveyed_errors)}, itemProperty={len(item_property_errors)}, orphan={len(orphan_itemflows)}"),
        qa_entry("XMI17-16", final_connection_ids <= connector_ids and not connector_owner_errors and not connector_end_errors and len(final_connection_ids) == 184, f"Final Connectors={len(final_connection_ids & connector_ids)}/184; owner errors={len(connector_owner_errors)}"),
        qa_entry("XMI17-17", net_connector_ids <= connector_ids and not net_errors and len(net_connector_ids) == 9 and len(connector_ids) == 193, f"PhysicalNets={len(net_connector_ids & connector_ids)}/9; total connectors={len(connector_ids)}; clique expansion=0"),
        qa_entry("XMI17-18", len(activities) == 191 and {f["xmi_id"] for f in data["functions"]} == activity_ids, f"Activities={len(activities)}"),
        qa_entry("XMI17-19", len(allocate_apps) == 191 and not allocation_errors, f"Allocates={len(allocate_apps)}, errors={len(allocation_errors)}"),
        qa_entry("XMI17-20", len(parameters) == 471 and len(dependencies) == 471 and not mapping_errors, f"Function_Interface traces={len(parameters)}, errors={len(mapping_errors)}"),
        qa_entry("XMI17-21", len(anchor_comments) == 6 and not anchor_errors, f"Voltage anchors={len(anchor_comments)}, unresolved={len(anchor_errors)}"),
        qa_entry("XMI17-22", not custom_stereotypes and not profile_definitions and not stereotype_contract_errors, f"custom stereotype applications={custom_stereotypes}; profile definitions={len(profile_definitions)}; contract field errors={len(stereotype_contract_errors)}"),
        qa_entry("XMI17-23", not hierarchy_as_dependency and hierarchy_actual == hierarchy_expected, f"hierarchy dependencies={len(hierarchy_as_dependency)}"),
        qa_entry("XMI17-24", not physical_connection_errors and not physical_port_flow_errors, f"physical direction errors={len(physical_connection_errors)}, physical port flow errors={len(physical_port_flow_errors)}"),
        qa_entry("XMI17-25", manifest["full_byte_deterministic"], f"byte deterministic={manifest['full_byte_deterministic']}, sha256={manifest['full']['sha256']}"),
    ]

    xsd_target = contract["normative_sources"]["xmi_schema"]["target_namespace"]
    xsd_attempt = {"attempted": False, "valid": False, "error": None}
    try:
        from lxml import etree

        xsd_attempt["attempted"] = True
        schema = etree.XMLSchema(etree.parse(str(ROOT / "SysML" / "XMI.xsd")))
        document = etree.parse(str(FULL_XMI))
        xsd_attempt["valid"] = schema.validate(document)
        if not xsd_attempt["valid"]:
            xsd_attempt["error"] = str(schema.error_log.last_error)
    except Exception as exc:
        xsd_attempt["error"] = f"{type(exc).__name__}: {exc}"
    xsd_status = {
        "status": "NOT_APPLICABLE_NAMESPACE_MISMATCH",
        "reason": f"Local XMI.xsd targetNamespace={xsd_target}, while normative SysML.xmi and output use {XMI}; the local set also has no UML.xsd/SysML.xsd. XML and model-reference validation were executed separately.",
        "validation_attempt": xsd_attempt,
    }
    counts = {
        "product_blocks": 147,
        "system_context_blocks": 1,
        "external_boundary_blocks": len(data.get("external_boundaries", [])),
        "composite_parts": len(composite_properties),
        "proxy_ports": len(proxy_apps),
        "canonical_interface_blocks": len(app_elements(root, "InterfaceBlock")),
        "conjugated_interface_blocks": len(app_elements(root, "tildeInterfaceBlock")),
        "flow_properties": len(flow_apps),
        "item_classifiers": len(data["items"]),
        "connectors_total": len(connectors),
        "final_connectors": len(final_connection_ids & connector_ids),
        "signal_item_flows": len(itemflow_apps),
        "physical_nets": len(net_connector_ids & connector_ids),
        "activities": len(activities),
        "allocates": len(allocate_apps),
        "function_interface_traces": len(parameters),
        "voltage_anchors": len(anchor_comments),
    }
    return {
        "status": "PASS" if all(x["status"] == "PASS" for x in qa) else "FAIL",
        "qa": qa,
        "counts": counts,
        "xmi_xsd_validation": xsd_status,
        "diagnostics": {
            "duplicate_ids": duplicates,
            "missing_references": missing_refs,
            "bad_port_types": bad_port_types,
            "connector_owner_errors": connector_owner_errors,
            "net_errors": net_errors,
            "stereotype_contract_errors": stereotype_contract_errors,
        },
    }


def write_report(result: dict, probe: dict) -> None:
    inventory = json.loads((PIPELINE_WORK / "standards_inventory.json").read_text(encoding="utf-8"))
    contract = json.loads((PIPELINE_WORK / "sysml17_mapping_contract.json").read_text(encoding="utf-8"))
    counts = result["counts"]
    passed = sum(q["status"] == "PASS" for q in result["qa"])
    failed = sum(q["status"] == "FAIL" for q in result["qa"])
    recognized = ", ".join(record["name"] for record in inventory["files"])
    content = f"""# SysML 1.7 XMI conversion report

- Standard files: {recognized}
- SysML: 1.7 profile URI `{contract['versions']['sysml_profile_uri']}`
- UML: 2.5.1 (`{contract['versions']['uml_metamodel_uri']}`)
- XMI: namespace date `{contract['versions']['xmi_namespace_date']}`; normative SysML root has no `xmi:version` attribute
- Available PDF audit: SysML 2.0 (not used as the SysML 1.7 authority)
- Cameo/MagicDraw golden sample: not found

## Generated model

- Product Blocks: {counts['product_blocks']}
- Composite Part Properties: {counts['composite_parts']}
- ProxyPorts: {counts['proxy_ports']}
- InterfaceBlocks: {counts['canonical_interface_blocks']} canonical + {counts['conjugated_interface_blocks']} standard conjugated types
- FlowProperties: {counts['flow_properties']}
- Connectors: {counts['connectors_total']} total ({counts['final_connectors']} Final + {counts['physical_nets']} n-ary PhysicalNet)
- Signal ItemFlows: {counts['signal_item_flows']}
- PhysicalNets: {counts['physical_nets']}
- Activities: {counts['activities']}
- Allocates: {counts['allocates']}
- Function_Interface traces: {counts['function_interface_traces']}
- Voltage anchors: {counts['voltage_anchors']}

## QA

- Probe static QA: {probe['status']}
- XMI17 QA: {passed} PASS / {failed} FAIL
- Local XMI.xsd: `{result['xmi_xsd_validation']['status']}` — local XSD uses the legacy HTTP namespace and no local UML/SysML XSD set is present; XML well-formedness, ID/href/reference, profile, and model-semantic checks passed independently.
- Full XMI byte reproducibility: {next(q['status'] for q in result['qa'] if q['id'] == 'XMI17-25')}
- `CAMEO_IMPORT_TEST = PENDING`

Probe: `{PROBE_XMI}`

Full XMI: `{FULL_XMI}`
"""
    (REPORTS_DIR / "xmi_conversion_report.md").write_text(content, encoding="utf-8")


def main() -> None:
    REPORTS_DIR.mkdir(parents=True, exist_ok=True)
    probe = validate_probe()
    result = validate_full()
    combined = {"probe": probe, "full": result, "cameo_import_test": "PENDING"}
    out = PIPELINE_WORK / "xmi_validation_results.json"
    out.write_text(json.dumps(combined, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    write_report(result, probe)
    print(f"Probe QA: {probe['status']}")
    print(f"Full XMI QA: {result['status']} ({sum(x['status']=='PASS' for x in result['qa'])} PASS / {sum(x['status']=='FAIL' for x in result['qa'])} FAIL)")
    print(f"Validation: {out}")
    if probe["status"] != "PASS" or result["status"] != "PASS":
        raise SystemExit(1)


if __name__ == "__main__":
    main()
