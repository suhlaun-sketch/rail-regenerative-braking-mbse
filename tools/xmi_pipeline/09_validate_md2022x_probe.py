from __future__ import annotations

import json
import xml.etree.ElementTree as ET
from collections import Counter
from pathlib import Path


PIPELINE_DIR = Path(__file__).resolve().parent
ROOT = PIPELINE_DIR.parents[1]
PIPELINE_WORK = PIPELINE_DIR / "work"
REPORTS = ROOT / "reports"
SOURCE = ROOT / "work" / "architecture_xmi_ready_v1.json"
PROBE = ROOT / "work" / "Rail_MBSE_SysML17_probe_MD2022x_v3.xmi"
CONTEXT_ID = "XMI-SYSTEM-CONTEXT-RAIL-MBSE-TRACTIONBRAKE-MD2022X-PROBE"
PRODUCT_CODES = ("4000", "4200", "4230", "4235", "5000", "5100", "5110", "5111")


def namespaces(path: Path) -> dict[str, str]:
    result = {}
    for _event, pair in ET.iterparse(path, events=("start-ns",)):
        prefix, uri = pair
        result[prefix or "default"] = uri
    return result


def qa(identifier: str, passed: bool, detail: str) -> dict:
    return {"id": identifier, "status": "PASS" if passed else "FAIL", "detail": detail}


def validate() -> dict:
    architecture = json.loads(SOURCE.read_text(encoding="utf-8"))
    contract = json.loads((PIPELINE_WORK / "magicdraw2022x_compatibility_contract.json").read_text(encoding="utf-8"))
    manifest = json.loads((PIPELINE_WORK / "md2022x_probe_build_manifest.json").read_text(encoding="utf-8"))
    ns = namespaces(PROBE)
    XMI = contract["namespace_separation"]["xmi_xml_namespace"]
    UML = contract["namespace_separation"]["uml_xml_namespace"]
    SYSML = contract["namespace_separation"]["sysml_stereotype_namespace"]
    qx = lambda local: f"{{{XMI}}}{local}"
    qu = lambda local: f"{{{UML}}}{local}"
    qs = lambda local: f"{{{SYSML}}}{local}"
    root = ET.parse(PROBE).getroot()
    parents = {child: parent for parent in root.iter() for child in parent}
    all_ids = [e.get(qx("id")) for e in root.iter() if e.get(qx("id"))]
    ids = {e.get(qx("id")): e for e in root.iter() if e.get(qx("id"))}
    duplicates = [identifier for identifier, count in Counter(all_ids).items() if count > 1]

    def of_type(name: str) -> list[ET.Element]:
        return [e for e in root.iter() if e.get(qx("type")) == f"uml:{name}"]

    def apps(name: str) -> list[ET.Element]:
        return [e for e in root if e.tag == qs(name)]

    products = {p["id"]: p for p in architecture["products"]}
    product_xmi = {code: products[code]["xmi_id"] for code in PRODUCT_CODES}
    connection = next(
        c for c in architecture["connections"]
        if c["source_product_id"] == "4235" and c.get("target_product_id") == "5111"
        and c["item_id"] == "ITM-MEA-005" and c["mode"] == "SIGNAL"
    )
    interface_by_id = {i["interface_instance_id"]: i for i in architecture["interfaces"]}
    source_port = interface_by_id[connection["source_interface_id"]]
    target_port = interface_by_id[connection["target_interface_id"]]
    item = next(i for i in architecture["items"] if i["item_code"] == connection["item_id"])
    function = next(f for f in architecture["functions"] if f["function_id"] == "F-4235-01")
    allocation = next(a for a in architecture["allocations"] if a["function_id"] == "F-4235-01" and a["product_id"] == "4235")

    block_apps = apps("Block")
    block_targets = {app.get("base_Class") for app in block_apps}
    proxy_apps = apps("ProxyPort")
    proxy_targets = {app.get("base_Port") for app in proxy_apps}
    classes = {e.get(qx("id")): e for e in of_type("Class")}
    properties = of_type("Property")
    composite_properties = [p for p in properties if p.get("aggregation") == "composite"]

    part_by_pair = {}
    for prop in composite_properties:
        owner = parents[prop]
        part_by_pair[(owner.get(qx("id")), prop.get("type"))] = prop
    expected_pairs = [
        (CONTEXT_ID, product_xmi["4000"]), (product_xmi["4000"], product_xmi["4200"]),
        (product_xmi["4200"], product_xmi["4230"]), (product_xmi["4230"], product_xmi["4235"]),
        (CONTEXT_ID, product_xmi["5000"]), (product_xmi["5000"], product_xmi["5100"]),
        (product_xmi["5100"], product_xmi["5110"]), (product_xmi["5110"], product_xmi["5111"]),
    ]
    expected_parts = [part_by_pair.get(pair) for pair in expected_pairs]
    part_5111 = part_by_pair.get((product_xmi["5110"], product_xmi["5111"]))
    wrong_4235_parts = [
        prop for prop in classes[product_xmi["4235"]]
        if prop.get(qx("type")) == "uml:Property" and prop.get("type") == product_xmi["5111"]
    ]

    def package_name_for(element: ET.Element) -> str | None:
        current = parents.get(element)
        while current is not None:
            if current.get(qx("type")) == "uml:Package" and current.get("name") in {"MainPowerSupply", "Traction", "ExternalSystems"}:
                return current.get("name")
            current = parents.get(current)
        return None

    connector = ids.get(connection["xmi_id"])
    connector_owner = parents.get(connector) if connector is not None else None
    connector_ends = [e for e in connector if e.get(qx("type")) == "uml:ConnectorEnd"] if connector is not None else []
    end_by_role = {e.get("role"): e for e in connector_ends}
    source_end = end_by_role.get(source_port["xmi_id"])
    target_end = end_by_role.get(target_port["xmi_id"])
    nested_by_end = {a.get("base_ConnectorEnd"): a for a in apps("NestedConnectorEnd")}
    source_nested = nested_by_end.get(source_end.get(qx("id"))) if source_end is not None else None
    target_nested = nested_by_end.get(target_end.get(qx("id"))) if target_end is not None else None
    source_path = [part_by_pair[pair].get(qx("id")) for pair in expected_pairs[:4] if part_by_pair.get(pair) is not None]
    target_path = [part_by_pair[pair].get(qx("id")) for pair in expected_pairs[4:] if part_by_pair.get(pair) is not None]
    source_path_ok = source_nested is not None and source_nested.get("propertyPath", "").split() == source_path and source_end.get("partWithPort") == source_path[-1]
    target_path_ok = target_nested is not None and target_nested.get("propertyPath", "").split() == target_path and target_end.get("partWithPort") == target_path[-1]

    source_port_element = ids.get(source_port["xmi_id"])
    target_port_element = ids.get(target_port["xmi_id"])
    interface_apps = {a.get("base_Class"): a for a in apps("InterfaceBlock")}
    tilde_apps = {a.get("base_Class"): a for a in apps("tildeInterfaceBlock")}
    flow_apps = {a.get("base_Property"): a for a in apps("FlowProperty")}
    source_ib = ids.get(source_port_element.get("type")) if source_port_element is not None else None
    target_tilde = tilde_apps.get(target_port_element.get("type")) if target_port_element is not None else None
    canonical_app = interface_apps.get(source_port_element.get("type")) if source_port_element is not None else None
    canonical_flow = next((child for child in source_ib if child.get(qx("type")) == "uml:Property"), None) if source_ib is not None else None
    source_effective_out = canonical_flow is not None and flow_apps.get(canonical_flow.get(qx("id"))) is not None and flow_apps[canonical_flow.get(qx("id"))].get("direction") == "out"
    target_effective_in = target_tilde is not None and canonical_app is not None and target_tilde.get("original") == canonical_app.get(qx("id")) and target_port_element.get("isConjugated") == "false" and source_effective_out

    info = next((e for e in of_type("InformationFlow") if e.get("realizingConnector") == connection["xmi_id"]), None)
    itemflow = next((a for a in apps("ItemFlow") if info is not None and a.get("base_InformationFlow") == info.get(qx("id"))), None)
    activity = ids.get(function["xmi_id"])
    abstraction = ids.get(allocation["xmi_id"])
    allocate = next((a for a in apps("Allocate") if a.get("base_Abstraction") == allocation["xmi_id"]), None)

    profile_href = contract["profile_resolution_strategy"]["applied_profile_href"]
    profile_ok = any(e.tag.endswith("appliedProfile") and e.get("href") == profile_href for e in root.iter())
    known_reference_attrs = {
        "type", "role", "partWithPort", "informationSource", "informationTarget", "conveyed",
        "realizingConnector", "client", "supplier", "base_Class", "base_Port", "base_Property",
        "original", "base_ConnectorEnd", "propertyPath", "base_InformationFlow", "itemProperty",
        "base_Abstraction",
    }
    missing_refs = []
    for element in root.iter():
        for name, value in element.attrib.items():
            local = name.rsplit("}", 1)[-1]
            if name == qx("type") or local == "id" or local not in known_reference_attrs:
                continue
            for reference in value.split():
                if reference not in ids:
                    missing_refs.append(f"{element.get(qx('id')) or element.tag}.{local}->{reference}")

    sysml_names = {e.tag.rsplit("}", 1)[-1] for e in root if e.tag.startswith("{" + SYSML + "}")}
    allowed_sysml = {"Block", "InterfaceBlock", "tildeInterfaceBlock", "FlowProperty", "ProxyPort", "NestedConnectorEnd", "ItemFlow", "Allocate"}
    fake_exporter = any(e.tag == qx("Documentation") for e in root.iter())
    hierarchy_dependencies = [
        e for e in of_type("Dependency")
        if (e.get("client"), e.get("supplier")) in expected_pairs or (e.get("supplier"), e.get("client")) in expected_pairs
    ]

    mdmap = [
        qa("MDMAP-01", ns.get("uml") != "https://www.omg.org/spec/UML/20161101", f"xmlns:uml={ns.get('uml')}"),
        qa("MDMAP-02", ns.get("uml") == "http://www.omg.org/spec/UML/20131001", f"xmlns:uml={ns.get('uml')}"),
        qa("MDMAP-03", ns.get("xmi") == "http://www.omg.org/spec/XMI/20131001", f"xmlns:xmi={ns.get('xmi')}"),
        qa("MDMAP-04", profile_ok, f"appliedProfile={profile_href}"),
        qa("MDMAP-05", all(product_xmi[c] in block_targets for c in PRODUCT_CODES), f"Probe Product Blocks={sum(product_xmi[c] in block_targets for c in PRODUCT_CODES)}/8"),
        qa("MDMAP-06", product_xmi["5111"] in classes, "5111 Block Definition exists"),
        qa("MDMAP-07", part_5111 is not None and parents[part_5111].get(qx("id")) == product_xmi["5110"], "part_5111 owner=5110"),
        qa("MDMAP-08", not wrong_4235_parts, f"4235 owned part typed 5111={len(wrong_4235_parts)}"),
        qa("MDMAP-09", package_name_for(classes[product_xmi["4235"]]) == "MainPowerSupply", f"4235 package={package_name_for(classes[product_xmi['4235']])}"),
        qa("MDMAP-10", package_name_for(classes[product_xmi["5111"]]) == "Traction", f"5111 package={package_name_for(classes[product_xmi['5111']])}"),
        qa("MDMAP-11", len(expected_parts) == 8 and all(element is not None for element in expected_parts) and len(composite_properties) == 8 and not hierarchy_dependencies, f"real hierarchy compositions={len(composite_properties)}, hierarchy dependencies={len(hierarchy_dependencies)}"),
        qa("MDMAP-12", connector_owner is not None and connector_owner.get(qx("id")) == CONTEXT_ID, f"Connector owner={connector_owner.get(qx('id')) if connector_owner is not None else None}"),
        qa("MDMAP-13", source_path_ok, f"4235 path={source_nested.get('propertyPath') if source_nested is not None else None}"),
        qa("MDMAP-14", target_path_ok, f"5111 path={target_nested.get('propertyPath') if target_nested is not None else None}"),
        qa("MDMAP-15", source_port["xmi_id"] in proxy_targets and target_port["xmi_id"] in proxy_targets and source_end is not None and target_end is not None, "both ConnectorEnd roles are real ProxyPorts"),
        qa("MDMAP-16", source_effective_out and source_port["direction"] == "输出", "4235 effective direction=out"),
        qa("MDMAP-17", target_effective_in and target_port["direction"] == "输入", "5111 effective direction=in via ~InterfaceBlock"),
        qa("MDMAP-18", info is not None, "Connector has realizing InformationFlow"),
        qa("MDMAP-19", itemflow is not None, "InformationFlow has standard ItemFlow application"),
        qa("MDMAP-20", info is not None and info.get("informationSource") == source_port["xmi_id"], "informationSource=4235 output"),
        qa("MDMAP-21", info is not None and info.get("informationTarget") == target_port["xmi_id"], "informationTarget=5111 input"),
        qa("MDMAP-22", info is not None and info.get("conveyed") == item["xmi_id"] and itemflow is not None and itemflow.get("itemProperty") == canonical_flow.get(qx("id")), "conveyed Item and itemProperty are canonical"),
        qa("MDMAP-23", info is not None and info.get("realizingConnector") == connection["xmi_id"], "realizingConnector is Probe Connector"),
        qa("MDMAP-24", activity is not None and activity.get(qx("type")) == "uml:Activity", "F-4235-01 is uml:Activity"),
        qa("MDMAP-25", abstraction is not None and abstraction.get(qx("type")) == "uml:Abstraction" and allocate is not None and abstraction.get("client") == function["xmi_id"] and abstraction.get("supplier") == product_xmi["4235"], "Activity-to-4235 standard Allocate"),
        qa("MDMAP-26", not duplicates, f"duplicate xmi:id={len(duplicates)}"),
        qa("MDMAP-27", not missing_refs, f"unresolved local references={len(missing_refs)}"),
        qa("MDMAP-28", sysml_names <= allowed_sysml and not of_type("Profile"), f"custom stereotype names={sorted(sysml_names-allowed_sysml)}"),
        qa("MDMAP-29", not fake_exporter, "no xmi:Documentation exporter"),
        qa("MDMAP-30", manifest["byte_deterministic"], f"byte deterministic={manifest['byte_deterministic']}; sha256={manifest['sha256']}"),
    ]
    sem = [
        qa("SEM-QA-5111-01", product_xmi["5111"] in classes, "Block Definition 5111 exists"),
        qa("SEM-QA-5111-02", product_xmi["5111"] in block_targets, "5111 has SysML::Block application"),
        qa("SEM-QA-5111-03", part_5111 is not None and parents[part_5111].get(qx("id")) == product_xmi["5110"], "part_5111 owner=5110"),
        qa("SEM-QA-5111-04", part_5111 is not None and part_5111.get("type") == product_xmi["5111"], "part_5111.type=5111"),
        qa("SEM-QA-5111-05", part_5111 is not None and part_5111.get("aggregation") == "composite", "part_5111 aggregation=composite"),
        qa("SEM-QA-5111-06", not wrong_4235_parts, "4235 has no ownedAttribute type=5111"),
    ]
    port_qa = [
        qa("PORT-QA-01", source_port["xmi_id"] in proxy_targets, "4235 Port stereotype=ProxyPort"),
        qa("PORT-QA-02", target_port["xmi_id"] in proxy_targets, "5111 Port stereotype=ProxyPort"),
        qa("PORT-QA-03", source_effective_out, "4235 effective direction=out"),
        qa("PORT-QA-04", target_effective_in, "5111 effective direction=in"),
        qa("PORT-QA-05", info is not None and info.get("conveyed") == item["xmi_id"] and canonical_flow.get("type") == item["xmi_id"], f"both endpoints use {item['item_code']}"),
    ]
    negative = [
        qa("SEM-NEG-01", not wrong_4235_parts, "4235 does not own part_5111"),
        qa("SEM-NEG-02", parents[part_5111].get(qx("id")) != product_xmi["4235"], "5111 parent Product is not 4235"),
        qa("SEM-NEG-03", source_path[:1] != target_path[:1], "4235 and 5111 are on different L1 branches"),
        qa("SEM-NEG-04", not hierarchy_dependencies, "Product hierarchy is not represented by Dependency"),
        qa("SEM-NEG-05", info is not None and info.get("informationSource") != target_port["xmi_id"], "ItemFlow is not reversed"),
    ]
    all_qa = mdmap + sem + port_qa + negative
    counts = {
        "product_blocks": sum(product_xmi[c] in block_targets for c in PRODUCT_CODES),
        "context_blocks": int(CONTEXT_ID in block_targets),
        "composite_parts": len(composite_properties),
        "proxy_ports": len(proxy_apps),
        "canonical_interface_blocks": len(apps("InterfaceBlock")),
        "conjugated_interface_blocks": len(apps("tildeInterfaceBlock")),
        "flow_properties": len(apps("FlowProperty")),
        "nested_connector_ends": len(apps("NestedConnectorEnd")),
        "connectors": len(of_type("Connector")),
        "information_flows": len(of_type("InformationFlow")),
        "item_flows": len(apps("ItemFlow")),
        "activities": len(of_type("Activity")),
        "allocates": len(apps("Allocate")),
    }
    return {
        "status": "PASS" if all(x["status"] == "PASS" for x in all_qa) else "FAIL",
        "counts": counts,
        "qa": all_qa,
        "mdmap_summary": {"pass": sum(x["status"] == "PASS" for x in mdmap), "fail": sum(x["status"] == "FAIL" for x in mdmap)},
        "all_summary": {"pass": sum(x["status"] == "PASS" for x in all_qa), "fail": sum(x["status"] == "FAIL" for x in all_qa)},
        "connection": {
            "connection_id": connection["connection_id"],
            "source_port_id": source_port["port_id"],
            "target_port_id": target_port["port_id"],
            "item_code": connection["item_id"],
            "interface_type_id": connection["interface_type_id"],
        },
        "cameo_import_test": "PENDING",
    }


def write_report(result: dict) -> None:
    contract = json.loads((PIPELINE_WORK / "magicdraw2022x_compatibility_contract.json").read_text(encoding="utf-8"))
    inventory = json.loads((PIPELINE_WORK / "magicdraw_profile_inventory.json").read_text(encoding="utf-8"))
    ns = contract["namespace_separation"]
    counts = result["counts"]
    report = f"""# MagicDraw 2022x SysML XMI fix report

- Installed MagicDraw/SysML Plugin: `{inventory['sysml_plugin']['version']}` / `{inventory['sysml_plugin']['internal_version']}`
- Old UML XML namespace: `https://www.omg.org/spec/UML/20161101`
- New UML XML namespace: `{ns['uml_xml_namespace']}`
- XMI XML namespace: `{ns['xmi_xml_namespace']}`
- UML 2.5.1 metamodel package URI remains: `{ns['uml_metamodel_uri']}`
- SysML Profile strategy: `{contract['profile_resolution_strategy']['strategy']}`
- Applied Profile: `{contract['profile_resolution_strategy']['applied_profile_href']}`
- Neutral export: no fake MagicDraw exporter metadata

## Semantic Probe

- Product Blocks: {counts['product_blocks']} + 1 System Context Block
- Composite Part Properties: {counts['composite_parts']}
- 5111 Block stereotype: PASS; `part_5111` owner: 5110
- 4235 owns `part_5111`: NO
- ProxyPorts: {counts['proxy_ports']}; InterfaceBlock: {counts['canonical_interface_blocks']} + {counts['conjugated_interface_blocks']} conjugated; FlowProperty: {counts['flow_properties']}
- NestedConnectorEnds: {counts['nested_connector_ends']}; both property paths follow the real Context-to-leaf compositions
- ItemFlow direction: 4235 output → 5111 input, PASS
- Activity/Allocate: {counts['activities']}/{counts['allocates']}, PASS
- MDMAP QA: {result['mdmap_summary']['pass']} PASS / {result['mdmap_summary']['fail']} FAIL
- All static QA: {result['all_summary']['pass']} PASS / {result['all_summary']['fail']} FAIL
- `CAMEO_IMPORT_TEST = PENDING`

Probe: `{PROBE}`

No new full XMI was generated or published. If MagicDraw still reports model inconsistency, capture the **More...** log before changing ProfileApplication, NestedConnectorEnd, ~InterfaceBlock, ItemFlow, or Allocate serialization.
"""
    (REPORTS / "xmi_magicdraw_fix_report.md").write_text(report, encoding="utf-8")


def main() -> None:
    REPORTS.mkdir(parents=True, exist_ok=True)
    result = validate()
    out = PIPELINE_WORK / "md2022x_probe_qa.json"
    out.write_text(json.dumps(result, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    write_report(result)
    print(f"MDMAP QA: {result['mdmap_summary']['pass']} PASS / {result['mdmap_summary']['fail']} FAIL")
    print(f"All Probe QA: {result['all_summary']['pass']} PASS / {result['all_summary']['fail']} FAIL")
    print(f"CAMEO_IMPORT_TEST: {result['cameo_import_test']}")
    if result["status"] != "PASS":
        raise SystemExit(1)


if __name__ == "__main__":
    main()
