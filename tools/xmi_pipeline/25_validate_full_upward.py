from __future__ import annotations

import base64
import gzip
import hashlib
import importlib.util
import json
import re
import xml.etree.ElementTree as ET
from collections import Counter
from pathlib import Path


PIPELINE_DIR = Path(__file__).resolve().parent
ROOT = PIPELINE_DIR.parents[1]
WORK = ROOT / "work"
PIPELINE_WORK = PIPELINE_DIR / "work"
SOURCE = WORK / "architecture_xmi_ready_v1.json"
XMI_FILE = WORK / "Rail_MBSE_TractionBrake_Full_UpwardIBD_v1.xmi"
MDXML_FILE = WORK / "Rail_MBSE_TractionBrake_Full_UpwardIBD_v1.mdxml"
UPWARD = PIPELINE_WORK / "upward_port_inference_v1.json"
PROJECTION = PIPELINE_WORK / "hierarchical_connection_projection_v1.json"
PLAN = PIPELINE_WORK / "ibd_generation_plan_v1.json"
INFERENCE_QA = PIPELINE_WORK / "upward_ibd_inference_qa_v1.json"
NATIVE_MANIFEST = PIPELINE_WORK / "full_native_mdxml_manifest_v1.json"
VALIDATION = PIPELINE_WORK / "full_upward_validation_v1.json"
UP_REPORT = ROOT / "reports" / "upward_interface_inference_report.md"
IBD_REPORT = ROOT / "reports" / "hierarchical_ibd_generation_report.md"
CONTEXT = "__SYSTEM_CONTEXT__"


def local(element: ET.Element) -> str:
    return element.tag.rsplit("}", 1)[-1]


def attr_local(element: ET.Element, name: str) -> str | None:
    for key, value in element.attrib.items():
        if key.rsplit("}", 1)[-1] == name:
            return value
    return None


def child_ref(element: ET.Element, name: str) -> str | None:
    for child in element:
        if local(child) == name:
            return attr_local(child, "idref") or child.text
    return element.get(name)


def model_ref(element: ET.Element) -> str | None:
    return child_ref(element, "elementID")


def load_module(path: Path, name: str):
    spec = importlib.util.spec_from_file_location(name, path)
    module = importlib.util.module_from_spec(spec)
    assert spec.loader is not None
    spec.loader.exec_module(module)
    return module


def validate() -> dict:
    architecture = json.loads(SOURCE.read_text(encoding="utf-8"))
    products = {p["id"]: p for p in architecture["products"]}
    interfaces = {i["interface_instance_id"]: i for i in architecture["interfaces"]}
    items = {i["item_code"]: i for i in architecture["items"]}
    upward = json.loads(UPWARD.read_text(encoding="utf-8"))
    projection = json.loads(PROJECTION.read_text(encoding="utf-8"))
    plan = json.loads(PLAN.read_text(encoding="utf-8"))
    inference_qa = json.loads(INFERENCE_QA.read_text(encoding="utf-8"))
    native_manifest = json.loads(NATIVE_MANIFEST.read_text(encoding="utf-8"))
    promoted = {p["promoted_port_id"]: p for p in upward["promoted_ports"]}
    segments = {s["segment_id"]: s for s in projection["segments"]}
    net_projections = {n["projection_id"]: n for n in projection["physical_net_projections"]}

    xmi_bytes = XMI_FILE.read_bytes()
    mdxml_bytes = MDXML_FILE.read_bytes()
    xmi_root = ET.fromstring(xmi_bytes)
    native_root = ET.fromstring(mdxml_bytes)
    xmi_elements = list(xmi_root.iter())
    native_elements = list(native_root.iter())
    xmi_ids = [attr_local(e, "id") for e in xmi_elements if attr_local(e, "id")]
    xmi_id_map = {attr_local(e, "id"): e for e in xmi_elements if attr_local(e, "id")}
    native_id_map = {attr_local(e, "id"): e for e in native_elements if attr_local(e, "id")}

    product_xmi = {p["xmi_id"] for p in architecture["products"]}
    raw_port_xmi = {i["xmi_id"] for i in architecture["interfaces"]}
    promoted_xmi = {p["xmi_id"] for p in promoted.values()}
    final_connector_xmi = {c["xmi_id"] for c in architecture["connections"]}
    segment_connector_xmi = {s["xmi_id"] for s in segments.values()}
    signal_segments = [s for s in segments.values() if s["mode"] == "SIGNAL"]
    physical_segments = [s for s in segments.values() if s["mode"] != "SIGNAL"]
    net_connector_xmi = {
        f"XMI-HNETCONN-{hashlib.sha1((n['projection_id'] + '|' + str(index)).encode()).hexdigest()[:24].upper()}"
        for n in net_projections.values() for index in range(1, len(n["members"]) + 1)
    }

    block_apps = [e for e in xmi_root if local(e) == "Block"]
    block_bases = {e.get("base_Class") for e in block_apps}
    proxy_apps = [e for e in xmi_root if local(e) == "ProxyPort"]
    proxy_bases = {e.get("base_Port") for e in proxy_apps}
    itemflow_apps = [e for e in xmi_root if local(e) == "ItemFlow"]
    itemflow_bases = {e.get("base_InformationFlow") for e in itemflow_apps}
    allocate_apps = [e for e in xmi_root if local(e) == "Allocate"]

    # Raw Port ownership remains frozen on leaf Product classes.
    parents = {child: parent for parent in xmi_elements for child in parent}
    wrong_raw_owner = []
    for interface in architecture["interfaces"]:
        port = xmi_id_map[interface["xmi_id"]]
        owner = parents[port]
        if attr_local(owner, "id") != products[interface["owner_product_id"]]["xmi_id"] or not products[interface["owner_product_id"]]["leaf"]:
            wrong_raw_owner.append(interface["interface_instance_id"])

    info_by_id = {attr_local(e, "id"): e for e in xmi_elements if attr_local(e, "type") == "uml:InformationFlow"}
    missing_segment_model = []
    wrong_segment_item = []
    item_property_count = 0
    for segment in signal_segments:
        info_id = f"XMI-{segment['information_flow_id']}"
        itemflow_id = f"XMI-{segment['item_flow_id']}"
        if segment["xmi_id"] not in xmi_id_map or info_id not in info_by_id or itemflow_id not in xmi_id_map:
            missing_segment_model.append(segment["segment_id"])
            continue
        info = info_by_id[info_id]
        if (
            child_ref(info, "informationSource") != segment["source_port_xmi_id"]
            or child_ref(info, "informationTarget") != segment["target_port_xmi_id"]
            or child_ref(info, "conveyed") != items[segment["item_code"]]["xmi_id"]
            or child_ref(info, "realizingConnector") != segment["xmi_id"]
        ):
            wrong_segment_item.append(segment["segment_id"])
        app = xmi_id_map[itemflow_id]
        if app.get("itemProperty") or any(local(child) == "itemProperty" for child in app):
            item_property_count += 1

    # Native resources and diagram presentation checks.
    fileparts = {e.get("name"): e for e in native_elements if local(e) == "filePart" and e.get("name")}
    resource_ids = {r["resource_id"] for r in native_manifest["resources"]}
    binaries_part = fileparts["Binaries.properties"]
    binaries_text = gzip.decompress(base64.b64decode((binaries_part.text or "").strip())).decode("iso-8859-1")
    indexed_resources = {value.strip() for value in re.search(r"com\.nomagic\.magicdraw\.uml_model\.model=(.+)\r?\n", binaries_text).group(1).split(",")}
    mdxml_text = mdxml_bytes.decode("utf-8")
    diagram_by_id = {d["diagram_xmi_id"]: d for d in plan["diagrams"]}
    diagram_elements = [e for e in native_elements if local(e) == "ownedDiagram" and attr_local(e, "id") in diagram_by_id]
    direct_child_violations = []
    independent_info_paths = 0
    missing_connector_paths = []
    wrong_arrow = []
    wrong_label = []
    physical_arrow_count = 0
    solid_violations = []
    forbidden_relationship_paths = []
    part_type_violations = []
    unresolved_used_objects = []
    resource_hash_failures = []
    total_connector_paths = 0
    total_signal_paths = 0

    for diagram_element in diagram_elements:
        diagram = diagram_by_id[attr_local(diagram_element, "id")]
        binary = next(e for e in diagram_element.iter() if local(e) == "binaryObject")
        resource_id = binary.get("streamContentID")
        resource_part = fileparts[resource_id]
        presentation_root = next(e for e in resource_part if local(e) == "mdOwnedViews")
        presentations = [e for e in presentation_root.iter() if local(e) == "mdElement"]
        part_refs = {model_ref(e) for e in presentations if e.get("elementClass") == "Part"}
        expected_parts = {p["part_xmi_id"] for p in diagram["direct_parts"]}
        expected_parts |= {p["part_xmi_id"] for p in diagram["boundary_reference_parts"]}
        expected_parts |= {f"XMI-HNETREF-{hashlib.sha1(n.encode()).hexdigest()[:24].upper()}" for n in diagram["physical_nets"]}
        if part_refs != expected_parts:
            direct_child_violations.append({"diagram": diagram["name"], "extra": sorted(part_refs - expected_parts), "missing": sorted(expected_parts - part_refs)})
        for part_ref in part_refs:
            part_property = native_id_map.get(part_ref)
            part_type = part_property.get("type") if part_property is not None else None
            if part_type not in block_bases:
                part_type_violations.append({"diagram": diagram["name"], "part": part_ref, "type": part_type})
        forbidden_relationship_paths.extend(
            {"diagram": diagram["name"], "element_class": e.get("elementClass"), "model": model_ref(e)}
            for e in presentations if e.get("elementClass") in {"Dependency", "Association", "InformationFlow"}
        )
        paths = [e for e in presentations if e.get("elementClass") == "Connector"]
        total_connector_paths += len(paths)
        path_by_model = {model_ref(e): e for e in paths}
        for path in paths:
            if "DASH" in " ".join((entry.text or "") for entry in path.iter()).upper():
                solid_violations.append(model_ref(path))
        expected_connectors = {segments[s]["xmi_id"] for s in diagram["connectors"]}
        for projection_id in diagram["physical_nets"]:
            projection_entry = net_projections[projection_id]
            expected_connectors.update(
                f"XMI-HNETCONN-{hashlib.sha1((projection_id + '|' + str(index)).encode()).hexdigest()[:24].upper()}"
                for index in range(1, len(projection_entry["members"]) + 1)
            )
        if set(path_by_model) != expected_connectors:
            missing_connector_paths.append({"diagram": diagram["name"], "missing": sorted(expected_connectors - set(path_by_model)), "extra": sorted(set(path_by_model) - expected_connectors)})
        info_ids = set(info_by_id)
        independent_info_paths += sum(model_ref(e) in info_ids for e in presentations)
        for segment_id in diagram["connectors"]:
            segment = segments[segment_id]
            path = path_by_model[segment["xmi_id"]]
            compartments = [e for e in path if local(e) == "compartment"]
            conveyed = attr_local(compartments[0], "value") if compartments else None
            labels = [e for e in path.iter() if e.get("elementClass") == "TextBox"]
            if segment["mode"] == "SIGNAL":
                total_signal_paths += 1
                if conveyed != items[segment["item_code"]]["xmi_id"]:
                    wrong_arrow.append(segment_id)
                texts = [(next((c.text for c in e if local(c) == "text"), "") or "") for e in labels]
                if items[segment["item_code"]]["name_cn"] not in texts:
                    wrong_label.append(segment_id)
            elif conveyed:
                physical_arrow_count += 1
        marker = f"<filePart name='{resource_id}'"
        start = mdxml_text.index(marker)
        resource_start = mdxml_text.index("<mdOwnedViews", start)
        file_end = mdxml_text.index("</filePart>", resource_start)
        resource_end = mdxml_text.rindex("</mdOwnedViews>", resource_start, file_end) + len("</mdOwnedViews>")
        resource_bytes = b"<?xml version='1.0' encoding='UTF-8'?>\n" + mdxml_text[resource_start:resource_end].encode("utf-8")
        declared = next(e for e in diagram_element.iter() if local(e) == "diagramContents").get("contentHash")
        contents = next(e for e in diagram_element.iter() if local(e) == "diagramContents")
        for used in (e for e in contents if local(e) == "usedObjects"):
            reference = (used.get("href") or "").lstrip("#")
            if reference and reference not in native_id_map:
                unresolved_used_objects.append(reference)
        if hashlib.sha1(resource_bytes).hexdigest() != declared:
            resource_hash_failures.append(resource_id)

    # PhysicalNet star projection: every connector touches one network junction
    # Port and never directly joins two member Ports.
    net_clique_violations = []
    for connector_id in net_connector_xmi:
        connector = xmi_id_map[connector_id]
        roles = [child_ref(end, "role") for end in connector if attr_local(end, "type") == "uml:ConnectorEnd"]
        if sum("HNETPORT-" in (role or "") for role in roles) != 1:
            net_clique_violations.append(connector_id)

    function_ids = {f["xmi_id"] for f in architecture["functions"]}
    allocation_ids = {a["xmi_id"] for a in architecture["allocations"]}
    mapping_ids = {m["xmi_id"] for m in architecture["function_interface_mappings"]}
    net_ids = {n["xmi_id"] for n in architecture["physical_nets"]}

    # Two fresh complete generations must match the published files.
    model_builder = load_module(PIPELINE_DIR / "23_build_full_upward_model.py", "full_model_repeat")
    native_builder = load_module(PIPELINE_DIR / "24_build_full_native_mdxml.py", "full_native_repeat")
    repeat_xmi_a, _ = model_builder.build_bytes()
    repeat_xmi_b, _ = model_builder.build_bytes()
    repeat_md_a, _ = native_builder.build_bytes()
    repeat_md_b, _ = native_builder.build_bytes()
    deterministic = repeat_xmi_a == repeat_xmi_b == xmi_bytes and repeat_md_a == repeat_md_b == mdxml_bytes

    up_values = dict(inference_qa["upward"])
    up_values.update({
        "UP-FULL-01": "PASS" if product_xmi <= block_bases else "FAIL",
        "UP-FULL-02": "PASS" if raw_port_xmi <= proxy_bases and promoted_xmi <= proxy_bases else "FAIL",
        "UP-FULL-03": "PASS" if not wrong_raw_owner else "FAIL",
        "UP-FULL-04": "PASS" if final_connector_xmi <= set(xmi_id_map) and segment_connector_xmi <= set(xmi_id_map) else "FAIL",
    })
    ibd_values = dict(inference_qa["ibd"])
    ibd_values.update({
        "IBD-FULL-01": "PASS" if len(diagram_elements) == plan["diagram_count"] == 58 else "FAIL",
        "IBD-FULL-02": "PASS" if not direct_child_violations else "FAIL",
        "IBD-FULL-03": "PASS" if not missing_connector_paths else "FAIL",
        "IBD-FULL-04": "PASS" if resource_ids == indexed_resources and resource_ids <= set(fileparts) else "FAIL",
        "IBD-FULL-05": "PASS" if not resource_hash_failures else "FAIL",
        "IBD-FULL-06": "PASS" if independent_info_paths == 0 else "FAIL",
        "IBD-FULL-07": "PASS" if not forbidden_relationship_paths and not part_type_violations and not unresolved_used_objects else "FAIL",
    })
    item_values = dict(inference_qa["itemflow"])
    item_values.update({
        "ITEM-FULL-01": "PASS" if not missing_segment_model and len(signal_segments) == total_signal_paths else "FAIL",
        "ITEM-FULL-02": "PASS" if not wrong_segment_item else "FAIL",
        "ITEM-FULL-03": "PASS" if not wrong_arrow and not wrong_label else "FAIL",
        "ITEM-FULL-04": "PASS" if item_property_count == 0 else "FAIL",
        "ITEM-FULL-05": "PASS" if physical_arrow_count == 0 else "FAIL",
        "ITEM-FULL-06": "PASS" if not solid_violations else "FAIL",
    })
    phy_values = dict(inference_qa["physical_net"])
    phy_values.update({
        "PHY-FULL-01": "PASS" if net_ids <= block_bases and len(net_ids) == 9 else "FAIL",
        "PHY-FULL-02": "PASS" if not net_clique_violations else "FAIL",
        "PHY-FULL-03": "PASS" if net_connector_xmi <= set(xmi_id_map) else "FAIL",
    })
    preservation = {
        "Product": len(product_xmi), "RawPort": len(raw_port_xmi), "FinalConnection": len(final_connector_xmi),
        "PhysicalNet": len(net_ids), "Function": len(function_ids), "Allocation": len(allocation_ids),
        "FunctionInterface": len(mapping_ids), "VoltageAnchor": len(architecture["verification_anchors"]),
    }
    preservation_ok = (
        preservation == {"Product": 147, "RawPort": 517, "FinalConnection": 184, "PhysicalNet": 9, "Function": 191, "Allocation": 191, "FunctionInterface": 471, "VoltageAnchor": 6}
        and function_ids <= set(xmi_id_map) and allocation_ids <= set(xmi_id_map) and mapping_ids <= set(xmi_id_map)
        and len(allocate_apps) == 191
    )
    uniqueness_ok = len(xmi_ids) == len(set(xmi_ids))

    def summary(values: dict[str, str]) -> dict:
        passed = sum(v == "PASS" for v in values.values())
        return {"pass": passed, "fail": len(values) - passed, "status": "PASS" if passed == len(values) else "FAIL"}

    result = {
        "validation_id": "RAIL-MBSE-FULL-UPWARD-IBD-VALIDATION-V1",
        "counts": {
            **preservation,
            "PromotedPort": len(promoted),
            "SignalPromotedOut": sum(p["effective_direction"] == "out" for p in promoted.values()),
            "SignalPromotedIn": sum(p["effective_direction"] == "in" for p in promoted.values()),
            "PhysicalPromoted": sum(p["effective_direction"] == "inout" for p in promoted.values()),
            "HierarchicalConnectorSegment": len(segments),
            "HierarchicalItemFlow": len(signal_segments),
            "PhysicalNetProjection": len(net_projections),
            "PhysicalNetProjectionConnector": len(net_connector_xmi),
            "NonLeafBlock": sum(not p["leaf"] for p in products.values()),
            "IBD": len(diagram_elements),
            "NativeConnectorPath": total_connector_paths,
        },
        "violations": {
            "xmi_duplicate_ids": [] if uniqueness_ok else [key for key, count in Counter(xmi_ids).items() if count > 1],
            "wrong_raw_owner": wrong_raw_owner,
            "missing_segment_model": missing_segment_model,
            "wrong_segment_item": wrong_segment_item,
            "direct_child": direct_child_violations,
            "missing_connector_paths": missing_connector_paths,
            "independent_information_flow_paths": independent_info_paths,
            "wrong_itemflow_arrow": wrong_arrow,
            "wrong_itemflow_label": wrong_label,
            "physical_arrow": physical_arrow_count,
            "non_solid_connector": solid_violations,
            "forbidden_relationship_presentation": forbidden_relationship_paths,
            "part_type_non_block": part_type_violations,
            "unresolved_used_objects": sorted(set(unresolved_used_objects)),
            "item_property": item_property_count,
            "physical_net_clique": net_clique_violations,
            "resource_hash": resource_hash_failures,
        },
        "qa": {
            "upward": up_values,
            "ibd": ibd_values,
            "itemflow": item_values,
            "physical_net": phy_values,
            "preservation": "PASS" if preservation_ok else "FAIL",
            "xmi_unique": "PASS" if uniqueness_ok else "FAIL",
            "byte_deterministic": "PASS" if deterministic else "FAIL",
        },
        "summary": {
            "upward": summary(up_values),
            "ibd": summary(ibd_values),
            "itemflow": summary(item_values),
            "physical_net": summary(phy_values),
            "preservation": "PASS" if preservation_ok else "FAIL",
            "xmi_unique": "PASS" if uniqueness_ok else "FAIL",
            "byte_deterministic": "PASS" if deterministic else "FAIL",
        },
        "outputs": {"mdxml": str(MDXML_FILE), "xmi": str(XMI_FILE)},
        "MAGICDRAW_FULL_OPEN_TEST": "PENDING",
    }
    VALIDATION.write_text(json.dumps(result, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")

    critical_ok = all(group["status"] == "PASS" for group in result["summary"].values() if isinstance(group, dict)) and all(result["summary"][key] == "PASS" for key in ("preservation", "xmi_unique", "byte_deterministic"))
    if not critical_ok:
        raise AssertionError(json.dumps(result["summary"], ensure_ascii=False))

    counts = result["counts"]
    UP_REPORT.write_text(
        "\n".join([
            "# Upward Interface Inference Report", "",
            f"- Raw Ports: {counts['RawPort']}",
            f"- Promoted Ports: {counts['PromotedPort']} (out {counts['SignalPromotedOut']} / in {counts['SignalPromotedIn']} / physical inout {counts['PhysicalPromoted']})",
            f"- Hierarchical Connector Segments: {counts['HierarchicalConnectorSegment']}",
            f"- Hierarchical ItemFlows: {counts['HierarchicalItemFlow']}",
            f"- UP QA: {result['summary']['upward']['pass']} PASS / 0 FAIL",
            f"- Deterministic: {result['summary']['byte_deterministic']}",
        ]) + "\n", encoding="utf-8")
    IBD_REPORT.write_text(
        "\n".join([
            "# Hierarchical IBD Generation Report", "",
            f"- Non-leaf Product Blocks: {counts['NonLeafBlock']}",
            f"- Native IBDs: {counts['IBD']} (including System Context)",
            f"- Native Connector paths: {counts['NativeConnectorPath']}",
            f"- Direct-child violations: {len(direct_child_violations)}",
            f"- Independent InformationFlow paths: {independent_info_paths}",
            f"- PhysicalNet clique violations: {len(net_clique_violations)}",
            f"- IBD QA: {result['summary']['ibd']['pass']} PASS / 0 FAIL",
            f"- ItemFlow QA: {result['summary']['itemflow']['pass']} PASS / 0 FAIL",
            f"- MAGICDRAW_FULL_OPEN_TEST: PENDING",
        ]) + "\n", encoding="utf-8")
    return result


def main() -> None:
    result = validate()
    print(json.dumps(result["summary"], ensure_ascii=False))


if __name__ == "__main__":
    main()
