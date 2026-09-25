from __future__ import annotations

import base64
import gzip
import hashlib
import json
import re
import xml.etree.ElementTree as ET
from collections import Counter, defaultdict
from pathlib import Path


PIPELINE_DIR = Path(__file__).resolve().parent
ROOT = PIPELINE_DIR.parents[1]
WORK = ROOT / "work"
PIPELINE_WORK = PIPELINE_DIR / "work"
REPORTS = ROOT / "reports"
PROBE = WORK / "Rail_MBSE_Gold2_Integrated_4235_5111_Probe_v2.mdxml"
GOLD2 = WORK / "gold2.mdxml"
CURRENT = WORK / "Rail_MBSE_TractionBrake_Full_UpwardIBD_v1.mdxml"
SOURCE = WORK / "architecture_xmi_ready_v1.json"
PROJECTION = PIPELINE_WORK / "hierarchical_connection_projection_v1.json"
KINDS = PIPELINE_WORK / "hierarchical_connector_kind_v2.json"
INVENTORY = PIPELINE_WORK / "gold2_full_inventory_v1.json"
MANIFEST = PIPELINE_WORK / "integrated_probe_v2_manifest.json"
ICD_ROWS = PIPELINE_WORK / "integrated_probe_icd_4235_5111_v2.json"
OUTPUT = PIPELINE_WORK / "integrated_probe_validation_v2.json"
LEARNING_REPORT = REPORTS / "gold2_learning_report_v2.md"
DIFF_REPORT = REPORTS / "gold2_vs_current_model_diff_v2.md"
VALIDATION_REPORT = REPORTS / "integrated_probe_validation_v2.md"

CONNECTION_ID = "CG-002543DBE0F9A7FBC2A3FDD3"
CONTEXT = "__SYSTEM_CONTEXT__"
CONTEXT_XMI = "XMI-SYSTEM-CONTEXT-RAIL-MBSE-TRACTIONBRAKE"
PRODUCT_CODES = ["4000", "4200", "4230", "4235", "5000", "5100", "5110", "5111"]
OWNER_ORDER = ["4230", "4200", "4000", CONTEXT, "5000", "5100", "5110"]


def local(value: str) -> str:
    return value.rsplit("}", 1)[-1]


def attr(element: ET.Element | None, name: str) -> str | None:
    if element is None:
        return None
    return next((value for key, value in element.attrib.items() if local(key) == name), None)


def child_ref(element: ET.Element, name: str) -> str | None:
    target = next((entry for entry in element if local(entry.tag) == name), None)
    return attr(target, "idref") if target is not None else element.get(name)


def model_ref(element: ET.Element) -> str | None:
    return child_ref(element, "elementID")


def parse_native(path: Path) -> tuple[ET.Element, ET.Element, list[ET.Element], dict[str, ET.Element], dict[ET.Element, ET.Element]]:
    root = ET.parse(path).getroot()
    model = next(entry for entry in root if local(entry.tag) == "Model")
    elements = list(root.iter())
    ids = {attr(entry, "id"): entry for entry in elements if attr(entry, "id")}
    parents = {child: parent for parent in elements for child in parent}
    return root, model, elements, ids, parents


def validate() -> dict:
    architecture = json.loads(SOURCE.read_text(encoding="utf-8"))
    products = {entry["id"]: entry for entry in architecture["products"]}
    projection = json.loads(PROJECTION.read_text(encoding="utf-8"))
    kinds = json.loads(KINDS.read_text(encoding="utf-8"))
    inventory = json.loads(INVENTORY.read_text(encoding="utf-8"))
    manifest = json.loads(MANIFEST.read_text(encoding="utf-8"))
    icd = json.loads(ICD_ROWS.read_text(encoding="utf-8"))
    kind_by_segment = {entry["segment_id"]: entry for entry in kinds["records"]}
    segments = {
        entry["owner_block"]: entry
        for entry in projection["segments"]
        if entry["derived_from_connection_id"] == CONNECTION_ID
    }
    root, model, elements, ids, parents = parse_native(PROBE)
    model_elements = list(model.iter())
    model_ids = {attr(entry, "id"): entry for entry in model_elements if attr(entry, "id")}
    root_apps = [entry for entry in root if entry is not model and attr(entry, "id")]
    apps_by_base: dict[str, list[ET.Element]] = defaultdict(list)
    for app in root_apps:
        for key, value in app.attrib.items():
            if local(key).startswith("base_"):
                apps_by_base[value].append(app)

    product_xmi = {products[code]["xmi_id"] for code in PRODUCT_CODES}
    product_elements = [model_ids.get(identifier) for identifier in sorted(product_xmi)]
    block_bases = {entry.get("base_Class") for entry in root_apps if local(entry.tag) == "Block"}
    interface_block_bases = {entry.get("base_Class") for entry in root_apps if local(entry.tag) == "InterfaceBlock"}
    proxy_bases = {entry.get("base_Port") for entry in root_apps if local(entry.tag) == "ProxyPort"}
    part_bases = {entry.get("base_Property") for entry in root_apps if local(entry.tag) == "PartProperty"}
    flow_apps = [entry for entry in root_apps if local(entry.tag) == "FlowProperty"]
    item_apps = [entry for entry in root_apps if local(entry.tag) == "ItemFlow"]

    packages = [entry for entry in model_elements if attr(entry, "type") == "uml:Package"]
    expected_package_names = {
        "01_产品定义",
        "主供电产品域",
        "牵引产品域",
        "02_接口定义",
        "InterfaceBlocks",
        "Signals",
        "04_参考架构",
        "08_ICD",
        "ICD_4235_5111_Trace",
    }
    product_package_violations = [
        code for code in PRODUCT_CODES if any(entry.get("name", "").startswith(code) for entry in packages)
    ]

    part_elements = [
        entry
        for entry in model_elements
        if attr(entry, "type") == "uml:Property" and entry.get("aggregation") == "composite" and attr(parents.get(entry), "type") == "uml:Class"
    ]
    expected_pairs = {
        (CONTEXT_XMI, products["4000"]["xmi_id"]),
        (CONTEXT_XMI, products["5000"]["xmi_id"]),
        (products["4000"]["xmi_id"], products["4200"]["xmi_id"]),
        (products["4200"]["xmi_id"], products["4230"]["xmi_id"]),
        (products["4230"]["xmi_id"], products["4235"]["xmi_id"]),
        (products["5000"]["xmi_id"], products["5100"]["xmi_id"]),
        (products["5100"]["xmi_id"], products["5110"]["xmi_id"]),
        (products["5110"]["xmi_id"], products["5111"]["xmi_id"]),
    }
    actual_pairs = {(attr(parents[entry], "id"), entry.get("type")) for entry in part_elements}
    non_block_parts = [attr(entry, "id") for entry in part_elements if entry.get("type") not in block_bases]
    machine_named_parts = [attr(entry, "id") for entry in part_elements if (entry.get("name") or "").startswith("part_")]
    missing_part_apps = [attr(entry, "id") for entry in part_elements if attr(entry, "id") not in part_bases]

    ports = [entry for entry in model_elements if attr(entry, "type") == "uml:Port"]
    port_ids = {attr(entry, "id") for entry in ports}
    port_owner = {attr(entry, "id"): attr(parents[entry], "id") for entry in ports}
    typed_port_violations = [attr(entry, "id") for entry in ports if entry.get("type") not in interface_block_bases]
    nonstandard_port_direction = [attr(entry, "id") for entry in ports if entry.get("direction") is not None]
    interface_blocks = [model_ids[identifier] for identifier in interface_block_bases if identifier in model_ids]
    flow_by_property = {entry.get("base_Property"): entry.get("direction") for entry in flow_apps}
    effective_directions = {}
    interface_flow_violations = []
    for port in ports:
        interface = model_ids.get(port.get("type"))
        flow_properties = [
            entry
            for entry in interface or []
            if attr(entry, "type") == "uml:Property" and attr(entry, "id") in flow_by_property
        ]
        if len(flow_properties) != 1:
            interface_flow_violations.append(attr(port, "id"))
        else:
            effective_directions[attr(port, "id")] = flow_by_property[attr(flow_properties[0], "id")]
    flow_direction_counts = Counter(flow_by_property.values())
    flow_direction_counts["unknown"] = sum(value not in {"in", "out", "inout"} for value in flow_by_property.values())

    connectors = [entry for entry in model_elements if attr(entry, "type") == "uml:Connector"]
    connector_ids = {attr(entry, "id") for entry in connectors}
    expected_connector_ids = {entry["xmi_id"] for entry in segments.values()}
    owner_violations = []
    end_violations = []
    direction_kind_counts = Counter()
    direction_kind_correct = Counter()
    expected_direction_pairs = {
        "DELEGATION_SOURCE": ("out", "out"),
        "ASSEMBLY_SIGNAL": ("out", "in"),
        "DELEGATION_TARGET": ("in", "in"),
    }
    for owner in OWNER_ORDER:
        segment = segments[owner]
        connector = model_ids.get(segment["xmi_id"])
        expected_owner = CONTEXT_XMI if owner == CONTEXT else products[owner]["xmi_id"]
        if connector is None or attr(parents.get(connector), "id") != expected_owner or local(connector.tag) != "ownedConnector":
            owner_violations.append(segment["segment_id"])
            continue
        ends = [entry for entry in connector if attr(entry, "type") == "uml:ConnectorEnd"]
        if len(ends) != 2:
            end_violations.append(segment["segment_id"])
            continue
        for end, endpoint in zip(ends, (segment["source_endpoint"], segment["target_endpoint"])):
            expected_part = None
            if endpoint["kind"] == "PART_PORT":
                expected_part = next(
                    attr(part, "id")
                    for part in part_elements
                    if attr(parents[part], "id") == expected_owner and part.get("type") == products[endpoint["element"]]["xmi_id"]
                )
            if child_ref(end, "role") != endpoint["port_xmi_id"] or child_ref(end, "partWithPort") != expected_part:
                end_violations.append(segment["segment_id"])
        kind = kind_by_segment[segment["segment_id"]]["connector_kind"]
        pair = (effective_directions.get(segment["source_port_xmi_id"]), effective_directions.get(segment["target_port_xmi_id"]))
        direction_kind_counts[kind] += 1
        if pair == expected_direction_pairs[kind]:
            direction_kind_correct[kind] += 1

    info_flows = [entry for entry in model_elements if attr(entry, "type") == "uml:InformationFlow"]
    info_by_connector = {child_ref(entry, "realizingConnector"): entry for entry in info_flows}
    item_by_info = {entry.get("base_InformationFlow"): entry for entry in item_apps}
    itemflow_violations = []
    for owner in OWNER_ORDER:
        segment = segments[owner]
        info = info_by_connector.get(segment["xmi_id"])
        if (
            info is None
            or child_ref(info, "conveyed") != "XMI-ITEM-ITM-MEA-005"
            or child_ref(info, "informationSource") != segment["source_port_xmi_id"]
            or child_ref(info, "informationTarget") != segment["target_port_xmi_id"]
            or child_ref(info, "realizingConnector") != segment["xmi_id"]
            or attr(info, "id") not in item_by_info
            or item_by_info[attr(info, "id")].get("itemProperty") is not None
        ):
            itemflow_violations.append(segment["segment_id"])

    diagrams = [entry for entry in model_elements if local(entry.tag) == "ownedDiagram"]
    fileparts = {entry.get("name"): entry for entry in elements if local(entry.tag) == "filePart" and entry.get("name")}
    probe_text = PROBE.read_text(encoding="utf-8")
    diagram_violations = []
    missing_connector_paths = []
    wrong_labels = []
    independent_info_paths = 0
    resource_hash_violations = []
    unresolved_used_objects = []
    presentation_gold_id_reuse = []
    solid_violations = []
    expected_diagram_names = {"IBD_System_Context", "IBD_4000", "IBD_4200", "IBD_4230", "IBD_5000", "IBD_5100", "IBD_5110"}
    for diagram in diagrams:
        owner_id = diagram.get("ownerOfDiagram")
        owner_element = model_ids.get(owner_id)
        if diagram.get("context") != owner_id or owner_element is None or diagram not in set(owner_element.iter()):
            diagram_violations.append(attr(diagram, "id"))
        representation = next(entry for entry in diagram.iter() if local(entry.tag) == "DiagramRepresentationObject")
        if representation.get("type") != "SysML Internal Block Diagram":
            diagram_violations.append(attr(diagram, "id"))
        contents = next(entry for entry in representation if local(entry.tag) == "diagramContents")
        resource_id = next(entry for entry in contents if local(entry.tag) == "binaryObject").get("streamContentID")
        resource = fileparts.get(resource_id)
        if resource is None:
            diagram_violations.append(attr(diagram, "id"))
            continue
        presentation = next(entry for entry in resource if local(entry.tag) == "mdOwnedViews")
        presentations = [entry for entry in presentation.iter() if local(entry.tag) == "mdElement"]
        paths = [entry for entry in presentations if entry.get("elementClass") == "Connector"]
        owner_code = CONTEXT if owner_id == CONTEXT_XMI else next(code for code in PRODUCT_CODES if products[code]["xmi_id"] == owner_id)
        segment = segments[owner_code]
        path_by_model = {model_ref(entry): entry for entry in paths}
        if set(path_by_model) != {segment["xmi_id"]}:
            missing_connector_paths.append(segment["segment_id"])
        else:
            path = path_by_model[segment["xmi_id"]]
            compartments = [entry for entry in path if local(entry.tag) == "compartment"]
            if not compartments or attr(compartments[0], "value") != "XMI-ITEM-ITM-MEA-005":
                wrong_labels.append(segment["segment_id"])
            texts = [(entry.text or "").strip() for entry in path.iter() if local(entry.tag) == "text"]
            if "高压线路电压" not in texts:
                wrong_labels.append(segment["segment_id"])
            if "DASH" in ET.tostring(path, encoding="unicode").upper():
                solid_violations.append(segment["segment_id"])
        independent_info_paths += sum(
            entry.get("elementClass") == "InformationFlow" or model_ref(entry) in {attr(info, "id") for info in info_flows}
            for entry in presentations
        )
        for used in (entry for entry in contents if local(entry.tag) == "usedObjects"):
            reference = (used.get("href") or "").lstrip("#")
            if reference and reference not in model_ids:
                unresolved_used_objects.append(reference)
        presentation_gold_id_reuse.extend(
            attr(entry, "id") for entry in presentation.iter() if (attr(entry, "id") or "").startswith("_2022x_2ee012b_178900")
        )
        marker = f"<filePart name='{resource_id}'"
        start = probe_text.index(marker)
        resource_start = probe_text.index("<mdOwnedViews", start)
        file_end = probe_text.index("</filePart>", resource_start)
        resource_end = probe_text.rindex("</mdOwnedViews>", resource_start, file_end) + len("</mdOwnedViews>")
        resource_bytes = b"<?xml version='1.0' encoding='UTF-8'?>\n" + probe_text[resource_start:resource_end].encode("utf-8")
        if hashlib.sha1(resource_bytes).hexdigest() != contents.get("contentHash"):
            resource_hash_violations.append(resource_id)

    binaries = fileparts["Binaries.properties"]
    binaries_text = gzip.decompress(base64.b64decode((binaries.text or "").strip())).decode("iso-8859-1")
    indexed_resources = {
        value.strip()
        for value in re.search(r"com\.nomagic\.magicdraw\.uml_model\.model=(.+)\r?\n", binaries_text).group(1).split(",")
    }
    diagram_resources = {
        next(entry for entry in diagram.iter() if local(entry.tag) == "binaryObject").get("streamContentID")
        for diagram in diagrams
    }
    records_text = gzip.decompress(base64.b64decode((fileparts["Records.properties"].text or "").strip())).decode("iso-8859-1")
    records_resources = {
        line.split("=", 1)[0]
        for line in records_text.replace("\r", "\n").split("\n")
        if line.startswith("BINARY-") and "=" in line
    }
    resource_index_ok = indexed_resources == diagram_resources and diagram_resources <= records_resources

    signal_elements = [entry for entry in model_elements if attr(entry, "type") == "uml:Signal"]
    illegal_packaged_comments = [entry for entry in model_elements if local(entry.tag) == "packagedElement" and attr(entry, "type") == "uml:Comment"]
    nested_apps = [entry for entry in root_apps if local(entry.tag) == "NestedConnectorEnd"]
    old_gold_business_ids = [attr(entry, "id") for entry in model_elements if (attr(entry, "id") or "").startswith("_2022x_2ee012b_178900")]
    icd_nonempty = sum(bool(row.get("Item Flow")) and bool(row.get("Conveyed Signal Name")) for row in icd["rows"])
    icd_connector_match = {row["Connector XMI ID"] for row in icd["rows"]} == expected_connector_ids

    # Run the generator twice again and compare with the published bytes.
    import importlib.util

    spec = importlib.util.spec_from_file_location("integrated_probe_repeat", PIPELINE_DIR / "28_build_gold2_integrated_probe.py")
    module = importlib.util.module_from_spec(spec)
    assert spec.loader is not None
    spec.loader.exec_module(module)
    repeat_a, repeat_manifest_a, repeat_rows_a = module.build_bytes()
    repeat_b, repeat_manifest_b, repeat_rows_b = module.build_bytes()
    deterministic = repeat_a == repeat_b == PROBE.read_bytes() and repeat_manifest_a == repeat_manifest_b == manifest and repeat_rows_a == repeat_rows_b == icd["rows"]

    qa = {
        "INT-QA-01": product_elements[0] is not None and products["4000"]["xmi_id"] in block_bases,
        "INT-QA-02": products["5000"]["xmi_id"] in block_bases,
        "INT-QA-03": all(entry is not None and attr(entry, "type") == "uml:Class" for entry in product_elements) and product_xmi <= block_bases,
        "INT-QA-04": not product_package_violations and {entry.get("name") for entry in packages} == expected_package_names,
        "INT-QA-05": not non_block_parts,
        "INT-QA-06": all(entry.get("name") == products[next(code for code in PRODUCT_CODES if products[code]["xmi_id"] == entry.get("type"))]["name"] for entry in part_elements),
        "INT-QA-07": not machine_named_parts,
        "INT-QA-08": actual_pairs == expected_pairs,
        "INT-QA-09": not diagram_violations and {entry.get("name") for entry in diagrams} == expected_diagram_names,
        "INT-QA-10": not owner_violations and connector_ids == expected_connector_ids,
        "INT-QA-11": not owner_violations,
        "INT-QA-12": not end_violations,
        "INT-QA-13": not end_violations,
        "INT-QA-14": not missing_connector_paths,
        "INT-QA-15": not missing_connector_paths and not unresolved_used_objects and resource_index_ok,
        "INT-QA-16": direction_kind_correct["DELEGATION_SOURCE"] == direction_kind_counts["DELEGATION_SOURCE"] == 3,
        "INT-QA-17": direction_kind_correct["ASSEMBLY_SIGNAL"] == direction_kind_counts["ASSEMBLY_SIGNAL"] == 1,
        "INT-QA-18": direction_kind_correct["DELEGATION_TARGET"] == direction_kind_counts["DELEGATION_TARGET"] == 3,
        "INT-QA-19": len(signal_elements) == 1 and signal_elements[0].get("name") == "高压线路电压",
        "INT-QA-20": len(ports) == len(proxy_bases) == 8 and port_ids == proxy_bases,
        "INT-QA-21": not typed_port_violations and len(interface_blocks) == 2,
        "INT-QA-22": not interface_flow_violations and not nonstandard_port_direction,
        "INT-QA-23": set(effective_directions.values()) <= {"in", "out", "inout"} and len(effective_directions) == 8,
        "INT-QA-24": len(info_by_connector) == len(connectors) == 7 and not itemflow_violations,
        "INT-QA-25": not itemflow_violations,
        "INT-QA-26": not itemflow_violations,
        "INT-QA-27": icd["row_count"] == 7 and icd_nonempty == 7 and icd_connector_match,
        "INT-QA-28": independent_info_paths == 0,
        "INT-QA-29": len(illegal_packaged_comments) == 0,
        "INT-QA-30": not any(
            [
                non_block_parts,
                machine_named_parts,
                missing_part_apps,
                typed_port_violations,
                interface_flow_violations,
                owner_violations,
                end_violations,
                itemflow_violations,
                diagram_violations,
                missing_connector_paths,
                wrong_labels,
                solid_violations,
                resource_hash_violations,
                unresolved_used_objects,
                presentation_gold_id_reuse,
                illegal_packaged_comments,
                nested_apps,
                old_gold_business_ids,
            ]
        )
        and resource_index_ok
        and deterministic,
    }
    qa_text = {key: "PASS" if value else "FAIL" for key, value in qa.items()}
    result = {
        "validation_id": "RAIL-MBSE-GOLD2-INTEGRATED-PROBE-VALIDATION-V2",
        "gold2_parse": "PASS" if inventory["integrity"]["connector_count"] == 7 and inventory["integrity"]["all_connectors_have_native_presentation"] else "FAIL",
        "gold2_block_structure_parse": "PASS" if inventory["integrity"]["business_block_count"] >= 9 and inventory["integrity"]["composite_part_count"] == 8 else "FAIL",
        "counts": {
            "ProbeProductBlock": len(product_xmi & block_bases),
            "ProbePackage": len(packages),
            "ProbePartProperty": len(part_elements),
            "NonBlockTypedPart": len(non_block_parts),
            "ProxyPort": len(proxy_bases),
            "InterfaceBlock": len(interface_blocks),
            "FlowPropertyIn": flow_direction_counts["in"],
            "FlowPropertyOut": flow_direction_counts["out"],
            "FlowPropertyInout": flow_direction_counts["inout"],
            "FlowPropertyUnknown": flow_direction_counts["unknown"],
            "Connector": len(connectors),
            "ConnectorOwnerCorrect": len(connectors) - len(owner_violations),
            "RelationsVisibleConnector": len(connectors) - len(owner_violations),
            "DelegationSource": direction_kind_counts["DELEGATION_SOURCE"],
            "DelegationSourceDirectionCorrect": direction_kind_correct["DELEGATION_SOURCE"],
            "AssemblySignal": direction_kind_counts["ASSEMBLY_SIGNAL"],
            "AssemblySignalDirectionCorrect": direction_kind_correct["ASSEMBLY_SIGNAL"],
            "DelegationTarget": direction_kind_counts["DELEGATION_TARGET"],
            "DelegationTargetDirectionCorrect": direction_kind_correct["DELEGATION_TARGET"],
            "UmlSignal": len(signal_elements),
            "InformationFlow": len(info_flows),
            "ItemFlow": len(item_apps),
            "RealizingConnectorCorrect": len(connectors) - len(itemflow_violations),
            "ICDItemFlowNonempty": icd_nonempty,
            "IndependentInformationFlowPath": independent_info_paths,
            "VoltageWarning": len(illegal_packaged_comments),
            "IBD": len(diagrams),
        },
        "violations": {
            "product_package": product_package_violations,
            "non_block_parts": non_block_parts,
            "machine_named_parts": machine_named_parts,
            "missing_part_property_apps": missing_part_apps,
            "typed_port": typed_port_violations,
            "interface_flow": interface_flow_violations,
            "nonstandard_port_direction": nonstandard_port_direction,
            "connector_owner": owner_violations,
            "connector_end": sorted(set(end_violations)),
            "itemflow": itemflow_violations,
            "diagram": sorted(set(diagram_violations)),
            "missing_connector_path": missing_connector_paths,
            "wrong_itemflow_label": sorted(set(wrong_labels)),
            "non_solid_connector": solid_violations,
            "resource_hash": resource_hash_violations,
            "unresolved_used_objects": sorted(set(unresolved_used_objects)),
            "gold_presentation_id_reuse": presentation_gold_id_reuse,
            "illegal_packaged_element_comment": [attr(entry, "id") for entry in illegal_packaged_comments],
            "nested_connector_end": [attr(entry, "id") for entry in nested_apps],
            "gold_business_id_reuse": old_gold_business_ids,
        },
        "native_resource_index": {
            "binaries": sorted(indexed_resources),
            "diagrams": sorted(diagram_resources),
            "records_contains_all": diagram_resources <= records_resources,
            "status": "PASS" if resource_index_ok else "FAIL",
        },
        "qa": qa_text,
        "summary": {
            "pass": sum(value == "PASS" for value in qa_text.values()),
            "fail": sum(value == "FAIL" for value in qa_text.values()),
            "status": "PASS" if all(value == "PASS" for value in qa_text.values()) else "FAIL",
            "model_inconsistency_precheck": "PASS" if qa_text["INT-QA-30"] == "PASS" else "FAIL",
            "byte_deterministic": "PASS" if deterministic else "FAIL",
        },
        "generation_mode": "NATIVE_MDXML",
        "probe": str(PROBE),
        "READY_FOR_MAGICDRAW_TEST": "YES" if all(value == "PASS" for value in qa_text.values()) else "NO",
    }
    OUTPUT.write_text(json.dumps(result, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    write_reports(result, inventory)
    if result["summary"]["status"] != "PASS":
        raise AssertionError(json.dumps({key: value for key, value in qa_text.items() if value == "FAIL"}, ensure_ascii=False))
    return result


def current_model_metrics() -> dict:
    if not CURRENT.exists():
        return {"available": False}
    _root, model, _elements, _ids, parents = parse_native(CURRENT)
    model_elements = list(model.iter())
    return {
        "available": True,
        "product_classes": sum(bool(attr(entry, "id")) and attr(entry, "id").startswith("XMI-PRODUCT-") and attr(entry, "type") == "uml:Class" for entry in model_elements),
        "machine_named_parts": sum(attr(entry, "type") == "uml:Property" and (entry.get("name") or "").startswith("part_") for entry in model_elements),
        "illegal_packaged_comments": sum(local(entry.tag) == "packagedElement" and attr(entry, "type") == "uml:Comment" for entry in model_elements),
        "owned_connectors": sum(local(entry.tag) == "ownedConnector" and attr(entry, "type") == "uml:Connector" for entry in model_elements),
        "ibds": sum(local(entry.tag) == "ownedDiagram" for entry in model_elements),
        "information_flows": sum(attr(entry, "type") == "uml:InformationFlow" for entry in model_elements),
        "context_parent_ok": all(local(parents[entry].tag) == "packagedElement" for entry in model_elements if attr(entry, "type") == "uml:Connector"),
    }


def write_reports(result: dict, inventory: dict) -> None:
    REPORTS.mkdir(parents=True, exist_ok=True)
    gold = inventory["integrity"]
    limits = inventory["learning_limits"]
    LEARNING_REPORT.write_text(
        "\n".join(
            [
                "# gold2 learning report v2",
                "",
                f"- Read-only SHA-256: `{inventory['sha256']}`",
                f"- Structure: {gold['business_block_count']} Block applications, {gold['composite_part_count']} composite Parts, {gold['ibd_count']} IBDs, {gold['connector_count']} owned Connectors.",
                f"- Binding: {gold['information_flow_count']} InformationFlows, {gold['item_flow_count']} ItemFlows, all realizingConnector links valid; independent InformationFlow paths = {gold['independent_information_flow_path_count']}.",
                "- Native presentation: every Connector has one solid Connector path with conveyed compartment and label.",
                f"- Not copied as semantics: InformationFlow source/target are Ports = {limits['information_source_target_are_ports']}; all Connector roles are Ports = {limits['all_connector_roles_are_ports']}; typed ProxyPorts = {limits['typed_proxy_ports']}; InterfaceBlocks = {limits['interface_block_count']}.",
            ]
        )
        + "\n",
        encoding="utf-8",
    )
    current = current_model_metrics()
    DIFF_REPORT.write_text(
        "\n".join(
            [
                "# gold2 vs current model diff v2",
                "",
                "- gold2 supplies the verified Block→IBD→Part→Port→Connector native ownership and presentation chain.",
                "- The current model supplies ProxyPort typing, directional InterfaceBlocks, FlowProperties, frozen technical IDs, and 724/587 upward projections.",
                f"- Current static metrics: Product Classes {current.get('product_classes', 'n/a')}; machine-named Parts {current.get('machine_named_parts', 'n/a')}; illegal packaged Comments {current.get('illegal_packaged_comments', 'n/a')}; owned Connectors {current.get('owned_connectors', 'n/a')}; IBDs {current.get('ibds', 'n/a')}.",
                "- Integrated Probe changes only the 4235→5111 slice: Chinese Part names, two directional InterfaceBlocks, eight typed ProxyPorts, seven correctly owned Connectors, and seven Connector-bound ItemFlows.",
            ]
        )
        + "\n",
        encoding="utf-8",
    )
    counts = result["counts"]
    VALIDATION_REPORT.write_text(
        "\n".join(
            [
                "# Integrated Probe validation v2",
                "",
                f"- QA: {result['summary']['pass']} PASS / {result['summary']['fail']} FAIL; model inconsistency precheck {result['summary']['model_inconsistency_precheck']}.",
                f"- Model: {counts['ProbeProductBlock']} Product Blocks, {counts['ProbePartProperty']} Parts, {counts['ProxyPort']} ProxyPorts, {counts['InterfaceBlock']} InterfaceBlocks.",
                f"- FlowProperty: in {counts['FlowPropertyIn']} / out {counts['FlowPropertyOut']} / inout {counts['FlowPropertyInout']} / unknown {counts['FlowPropertyUnknown']}.",
                f"- Connectors: {counts['ConnectorOwnerCorrect']}/{counts['Connector']} owners correct; native paths {counts['Connector'] - len(result['violations']['missing_connector_path'])}/{counts['Connector']}.",
                f"- ItemFlow: {counts['ItemFlow']} total; realizingConnector correct {counts['RealizingConnectorCorrect']}/{counts['Connector']}; ICD nonempty {counts['ICDItemFlowNonempty']}/7.",
                f"- Presentation: independent InformationFlow paths {counts['IndependentInformationFlowPath']}; Voltage warnings {counts['VoltageWarning']}.",
                f"- READY_FOR_MAGICDRAW_TEST: {result['READY_FOR_MAGICDRAW_TEST']}",
            ]
        )
        + "\n",
        encoding="utf-8",
    )


def main() -> None:
    result = validate()
    print(json.dumps({"summary": result["summary"], "counts": result["counts"], "READY_FOR_MAGICDRAW_TEST": result["READY_FOR_MAGICDRAW_TEST"]}, ensure_ascii=False))


if __name__ == "__main__":
    main()
