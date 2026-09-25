from __future__ import annotations

import hashlib
import importlib.util
import json
import re
import textwrap
import xml.etree.ElementTree as ET
from collections import Counter
from pathlib import Path


PIPELINE_DIR = Path(__file__).resolve().parent
ROOT = PIPELINE_DIR.parents[1]
PIPELINE_WORK = PIPELINE_DIR / "work"
REPORTS = ROOT / "reports"
GOLD = ROOT / "work" / "gold.mdxml"
V6 = ROOT / "work" / "Rail_MBSE_SysML17_itemflow_probe_v6.xmi"
SOURCE = ROOT / "work" / "architecture_xmi_ready_v1.json"
INVENTORY = PIPELINE_WORK / "gold_mdxml_inventory.json"
CONTRACT = PIPELINE_WORK / "magicdraw_gold_presentation_contract_v1.json"


def namespaces(path: Path) -> dict[str, str]:
    result = {}
    for _event, pair in ET.iterparse(path, events=("start-ns",)):
        prefix, uri = pair
        result.setdefault(prefix or "default", uri)
    return result


def local(element: ET.Element) -> str:
    return element.tag.rsplit("}", 1)[-1]


def build() -> dict:
    ns = namespaces(GOLD)
    XMI = ns["xmi"]
    qx = lambda name: f"{{{XMI}}}{name}"
    root = ET.parse(GOLD).getroot()
    elements = list(root.iter())
    parents = {child: parent for parent in elements for child in parent}
    ids = {e.get(qx("id")): e for e in elements if e.get(qx("id"))}

    def of_type(name: str) -> list[ET.Element]:
        return [e for e in elements if e.get(qx("type")) == f"uml:{name}"]

    def child_ref(element: ET.Element, name: str) -> str | None:
        for child in element:
            if local(child) == name:
                return child.get(qx("idref"))
        return element.get(name)

    def by_name(name: str, uml_type: str | None = None) -> ET.Element:
        candidates = [e for e in elements if e.get("name") == name]
        if uml_type:
            candidates = [e for e in candidates if e.get(qx("type")) == f"uml:{uml_type}"]
        if len(candidates) != 1:
            raise AssertionError(f"Expected one {uml_type or '*'} named {name!r}, found {len(candidates)}")
        return candidates[0]

    product_4235 = by_name("高压电压互感器", "Class")
    product_5111 = by_name("网侧变流器控制模块", "Class")
    source_port = by_name("高压线路电压输出", "Port")
    target_port = by_name("高压线路电压输入", "Port")
    signal = by_name("高压线路电压", "Signal")

    diagrams = [e for e in elements if local(e) == "ownedDiagram"]
    diagram_records = []
    for diagram in diagrams:
        representation = next((e for e in diagram.iter() if local(e) == "DiagramRepresentationObject"), None)
        contents = next((e for e in diagram.iter() if local(e) == "diagramContents"), None)
        binary = next((e for e in diagram.iter() if local(e) == "binaryObject"), None)
        diagram_records.append(
            {
                "diagram_id": diagram.get(qx("id")),
                "name": diagram.get("name"),
                "type": representation.get("type") if representation is not None else None,
                "uml_type": representation.get("umlType") if representation is not None else None,
                "owner": diagram.get("ownerOfDiagram"),
                "context": diagram.get("context"),
                "representation_id": representation.get("ID") if representation is not None else None,
                "presentation_resource": binary.get("streamContentID") if binary is not None else None,
                "content_hash": contents.get("contentHash") if contents is not None else None,
                "used_objects": [e.get("href", "").lstrip("#") for e in contents or [] if local(e) == "usedObjects"],
                "used_elements": [(e.text or "").strip() for e in contents or [] if local(e) == "usedElements"],
            }
        )
    if len(diagram_records) != 1:
        raise AssertionError(f"Golden Sample must contain exactly one target diagram, found {len(diagram_records)}")
    diagram = diagram_records[0]
    resource_part = next(
        e for e in elements
        if local(e) == "filePart" and e.get("name") == diagram["presentation_resource"]
    )
    presentation_root = next(e for e in resource_part if local(e) == "mdOwnedViews")
    presentation_elements = [e for e in presentation_root.iter() if local(e) == "mdElement"]
    presentation_by_id = {e.get(qx("id")): e for e in presentation_elements if e.get(qx("id"))}

    def presentation_model_ref(element: ET.Element) -> str | None:
        return child_ref(element, "elementID")

    connector_path = next(e for e in presentation_elements if e.get("elementClass") == "Connector")
    connector_id = presentation_model_ref(connector_path)
    connector = ids[connector_id]
    information_flow = next(
        e for e in of_type("InformationFlow") if child_ref(e, "realizingConnector") == connector_id
    )
    item_flow = next(
        e for e in elements if local(e) == "ItemFlow" and e.get("base_InformationFlow") == information_flow.get(qx("id"))
    )
    connector_ends = [e for e in connector if e.get(qx("type")) == "uml:ConnectorEnd"]
    source_end = next(e for e in connector_ends if child_ref(e, "role") == source_port.get(qx("id")))
    target_end = next(e for e in connector_ends if child_ref(e, "role") == target_port.get(qx("id")))
    source_part = ids[child_ref(source_end, "partWithPort")]
    target_part = ids[child_ref(target_end, "partWithPort")]

    part_symbols = [e for e in presentation_elements if e.get("elementClass") == "Part"]
    port_symbols = [e for e in presentation_elements if e.get("elementClass") == "Port"]
    source_part_symbol = next(e for e in part_symbols if presentation_model_ref(e) == source_part.get(qx("id")))
    target_part_symbol = next(e for e in part_symbols if presentation_model_ref(e) == target_part.get(qx("id")))
    source_port_symbol = next(e for e in port_symbols if presentation_model_ref(e) == source_port.get(qx("id")))
    target_port_symbol = next(e for e in port_symbols if presentation_model_ref(e) == target_port.get(qx("id")))

    compartments = [e for e in connector_path if local(e) == "compartment"]
    conveyed_compartment = next(e for e in compartments if e.get(qx("value")) == signal.get(qx("id")))
    conveyed_side = conveyed_compartment.get("compartmentID")
    conveyed_link_name = "linkConveyedAID" if conveyed_side.endswith("_A") else "linkConveyedBID"
    label_id = child_ref(connector_path, conveyed_link_name)
    label = presentation_by_id[label_id]
    label_text = next((e.text or "" for e in label if local(e) == "text"), "")
    connector_first_symbol = presentation_by_id[child_ref(connector_path, "linkFirstEndID")]
    connector_second_symbol = presentation_by_id[child_ref(connector_path, "linkSecondEndID")]
    first_model = presentation_model_ref(connector_first_symbol)
    second_model = presentation_model_ref(connector_second_symbol)

    information_flow_symbols = [
        e for e in presentation_elements if presentation_model_ref(e) == information_flow.get(qx("id"))
    ]
    item_flow_symbols = [
        e for e in presentation_elements if presentation_model_ref(e) == item_flow.get(qx("id"))
    ]
    connector_style_id = next((e.text or "").strip() for e in connector_path if local(e) == "symbolStyleID")
    parent_map = {child: parent for parent in elements for child in parent}
    managers = {}
    for element in elements:
        manager_id = next(((e.text or "").strip() for e in element if local(e) == "propertyManagerID"), None)
        if manager_id:
            managers[manager_id] = element

    style_chain = []
    cursor = connector_style_id
    while cursor and cursor not in {entry["property_manager_id"] for entry in style_chain}:
        manager = managers.get(cursor)
        if manager is None:
            break
        properties = {}
        for prop_id in [e for e in manager.iter() if local(e) == "propertyID"]:
            prop = parent_map[prop_id]
            value_node = next((e for e in prop if local(e) == "value"), None)
            properties[(prop_id.text or "").strip()] = (
                value_node.get(qx("value")) if value_node is not None and value_node.get(qx("value")) is not None
                else (value_node.text or "").strip() if value_node is not None else None
            )
        parent_style = next(((e.text or "").strip() for e in manager if local(e) == "parentPropertyManager"), None)
        style_chain.append({"property_manager_id": cursor, "parent": parent_style, "properties": properties})
        cursor = parent_style

    project_elements = [e for e in elements if local(e) == "Project"]
    project_ids = [e.get("id") for e in project_elements if e.get("id")]
    file_parts = [e for e in elements if local(e) == "filePart"]
    current_project_candidates = [
        e.get("name") for e in file_parts
        if e.get("type") == "BINARY" and (e.get("name") or "").startswith("PROJECT-")
    ]
    class_counts = Counter(e.get("elementClass") for e in presentation_elements)
    raw_gold = GOLD.read_text(encoding="utf-8")
    file_marker = f"<filePart name='{diagram['presentation_resource']}'"
    file_start = raw_gold.index(file_marker)
    resource_start = raw_gold.index("<mdOwnedViews>", file_start)
    file_end = raw_gold.index("</filePart>", resource_start)
    resource_end = raw_gold.rindex("</mdOwnedViews>", resource_start, file_end) + len("</mdOwnedViews>")
    raw_resource = raw_gold[resource_start:resource_end]
    resource_header = "<?xml version='1.0' encoding='UTF-8'?>"
    hash_candidates = {
        "mdOwnedViews_only": hashlib.sha1(raw_resource.encode("utf-8")).hexdigest(),
        "mdOwnedViews_with_newline": hashlib.sha1((raw_resource + "\n").encode("utf-8")).hexdigest(),
        "header_newline_resource": hashlib.sha1((resource_header + "\n" + raw_resource).encode("utf-8")).hexdigest(),
        "header_newline_resource_newline": hashlib.sha1((resource_header + "\n" + raw_resource + "\n").encode("utf-8")).hexdigest(),
        "header_blankline_resource": hashlib.sha1((resource_header + "\n\n" + raw_resource).encode("utf-8")).hexdigest(),
        "header_blankline_resource_newline": hashlib.sha1((resource_header + "\n\n" + raw_resource + "\n").encode("utf-8")).hexdigest(),
        "header_blankline_dedented_resource": hashlib.sha1((resource_header + "\n\n" + textwrap.dedent(raw_resource)).encode("utf-8")).hexdigest(),
    }

    inventory = {
        "inventory_id": "RAIL-MBSE-GOLD-MDXML-INVENTORY-V1",
        "gold_path": str(GOLD),
        "gold_sha256": hashlib.sha256(GOLD.read_bytes()).hexdigest(),
        "format": "MagicDraw native plain-text MDXML with inline xmi:Extension filePart resources",
        "namespaces": ns,
        "project": {
            "exporter": next((e.text for e in elements if local(e) == "exporter"), None),
            "exporter_version": next((e.text for e in elements if local(e) == "exporterVersion"), None),
            "plugin_versions": [dict(e.attrib) for e in elements if local(e) == "plugin"],
            "project_ids": project_ids,
            "current_project_candidates": sorted(set(current_project_candidates)),
            "file_parts": [{"name": e.get("name"), "type": e.get("type"), "has_inline_children": bool(list(e))} for e in file_parts],
        },
        "diagrams": diagram_records,
        "presentation": {
            "resource": diagram["presentation_resource"],
            "resource_filepart_type": resource_part.get("type"),
            "content_hash_evidence": {
                "declared": diagram["content_hash"],
                "candidates": hash_candidates,
                "matching_candidate": next((name for name, value in hash_candidates.items() if value == diagram["content_hash"]), None),
            },
            "element_class_counts": dict(sorted(class_counts.items())),
            "shape_elements": [
                {"presentation_id": e.get(qx("id")), "element_class": e.get("elementClass"), "model_element": presentation_model_ref(e), "geometry": next((c.text for c in e if local(c) == "geometry"), None)}
                for e in presentation_elements if e.get("elementClass") in {"DiagramFrame", "Part", "Port", "TextBox"}
            ],
            "path_elements": [
                {"presentation_id": e.get(qx("id")), "element_class": e.get("elementClass"), "model_element": presentation_model_ref(e), "geometry": next((c.text for c in e if local(c) == "geometry"), None)}
                for e in presentation_elements if e.get("elementClass") in {"Connector", "ConnectorEnd"}
            ],
            "connector": {
                "presentation_id": connector_path.get(qx("id")),
                "model_connector_id": connector_id,
                "geometry": next((e.text for e in connector_path if local(e) == "geometry"), None),
                "link_first_end_presentation": connector_first_symbol.get(qx("id")),
                "link_first_end_model": first_model,
                "link_second_end_presentation": connector_second_symbol.get(qx("id")),
                "link_second_end_model": second_model,
                "conveyed_compartment": dict(conveyed_compartment.attrib),
                "conveyed_link": {"field": conveyed_link_name, "presentation_id": label_id},
                "label": {"presentation_id": label_id, "text": label_text, "geometry": next((e.text for e in label if local(e) == "geometry"), None)},
                "style_id": connector_style_id,
                "style_chain": style_chain,
            },
            "information_flow_presentation_count": len(information_flow_symbols),
            "item_flow_presentation_count": len(item_flow_symbols),
        },
        "target_model_chain": {
            "source_product": {"id": product_4235.get(qx("id")), "name": product_4235.get("name")},
            "source_part": {"id": source_part.get(qx("id")), "type": child_ref(source_part, "type"), "presentation": source_part_symbol.get(qx("id"))},
            "source_port": {"id": source_port.get(qx("id")), "name": source_port.get("name"), "presentation": source_port_symbol.get(qx("id"))},
            "target_product": {"id": product_5111.get(qx("id")), "name": product_5111.get("name")},
            "target_part": {"id": target_part.get(qx("id")), "type": child_ref(target_part, "type"), "presentation": target_part_symbol.get(qx("id"))},
            "target_port": {"id": target_port.get(qx("id")), "name": target_port.get("name"), "presentation": target_port_symbol.get(qx("id"))},
            "connector": {"id": connector_id, "owner": parents[connector].get(qx("id")), "presentation": connector_path.get(qx("id"))},
            "information_flow": {
                "id": information_flow.get(qx("id")), "name": information_flow.get("name"),
                "source": child_ref(information_flow, "informationSource"), "target": child_ref(information_flow, "informationTarget"),
                "conveyed": child_ref(information_flow, "conveyed"), "realizing_connector": child_ref(information_flow, "realizingConnector"),
                "presentation_count": len(information_flow_symbols),
            },
            "item_flow": {"application_id": item_flow.get(qx("id")), "base_information_flow": item_flow.get("base_InformationFlow"), "item_property": item_flow.get("itemProperty"), "presentation_count": len(item_flow_symbols)},
            "signal": {"id": signal.get(qx("id")), "name": signal.get("name")},
        },
        "read_only": True,
    }
    INVENTORY.write_text(json.dumps(inventory, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")

    contract = {
        "contract_id": "RAIL-MBSE-MAGICDRAW-GOLD-PRESENTATION-CONTRACT-V1",
        "source_gold_sha256": inventory["gold_sha256"],
        "generation_mode": "NATIVE_MDXML",
        "diagram_resource_type": "inline filePart type=XML containing mdOwnedViews",
        "diagram_type": {"type": diagram["type"], "umlType": diagram["uml_type"], "owner_scheme": "ownedDiagram under xmi:Extension/modelExtension of the IBD context uml:Class"},
        "shape_serialization": {"node": "mdElement", "class_attribute": "elementClass", "geometry": "geometry text", "evidence": inventory["presentation"]["shape_elements"]},
        "path_serialization": {"node": "mdElement elementClass=Connector", "geometry": inventory["presentation"]["connector"]["geometry"], "evidence_presentation_id": inventory["presentation"]["connector"]["presentation_id"]},
        "connector_path_mapping": {"model_reference": "Connector mdElement/elementID@xmi:idref", "first_end": "linkFirstEndID", "second_end": "linkSecondEndID", "evidence": inventory["presentation"]["connector"]},
        "itemflow_mapping": {"model": "uml:InformationFlow + sysml:ItemFlow(base_InformationFlow)", "presentation": "No separate ItemFlow mdElement; conveyed Signal is rendered by the Connector presentation", "evidence": inventory["target_model_chain"]["item_flow"]},
        "itemflow_arrow_mapping": {"field": conveyed_side, "semantics": "In gold, source Port is linkSecondEnd and target Port is linkFirstEnd; CONVEYED_INFORMATION_A therefore encodes source -> target on this Connector.", "evidence": {"source_port": source_port.get(qx("id")), "target_port": target_port.get(qx("id")), "link_first_model": first_model, "link_second_model": second_model, "compartment": dict(conveyed_compartment.attrib)}},
        "conveyed_label_mapping": {"source": "Connector conveyed compartment references uml:Signal; Connector-owned TextBox carries Signal.name", "link_field": conveyed_link_name, "text": label_text, "evidence": inventory["presentation"]["connector"]["label"]},
        "source_port_mapping": {"model": source_port.get(qx("id")), "presentation": source_port_symbol.get(qx("id")), "parent_part_presentation": source_part_symbol.get(qx("id"))},
        "target_port_mapping": {"model": target_port.get(qx("id")), "presentation": target_port_symbol.get(qx("id")), "parent_part_presentation": target_part_symbol.get(qx("id"))},
        "part_symbol_mapping": {"source": inventory["target_model_chain"]["source_part"], "target": inventory["target_model_chain"]["target_part"], "model_reference": "Part mdElement/elementID@xmi:idref"},
        "proxyport_symbol_mapping": {"serialization": "Port mdElement nested under Part/mdOwnedViews; elementID references existing uml:Port", "source": inventory["target_model_chain"]["source_port"], "target": inventory["target_model_chain"]["target_port"]},
        "style_mapping": {"connector_symbol_style_id": connector_style_id, "style_chain_evidence": style_chain, "solid_rule": "LINK_LINE_STYLE has no dashed override in gold; Connector uses the default solid link style", "conveyed_visibility": {"SHOW_CONVEYED_A": True, "SHOW_CONVEYED_B": True}},
        "model_element_reference_scheme": "xmi:idref to model elements; diagramContents uses #<model-id> and usedElements text",
        "presentation_id_scheme": "New deterministic SHA1 IDs by semantic role; no gold presentation ID is reused",
        "owner_scheme": "A standard Block presentation harness owns direct Part Properties and the Connector; the ownedDiagram context/ownerOfDiagram reference that harness",
        "answers": {
            "model_semantics": "YES: uml:Connector + uml:InformationFlow + SysML::ItemFlow",
            "solid_connector": "mdElement elementClass=Connector with geometry and default solid LINK_LINE_STYLE",
            "black_itemflow_arrow": f"Connector {conveyed_side} compartment referencing the conveyed Signal; visibility is enabled by SHOW_CONVEYED_A/B",
            "label_source": "Connector-owned TextBox linked by linkConveyedAID; its text equals conveyed Signal.name",
            "independent_information_flow_path": len(information_flow_symbols) > 0,
            "item_property_required": False,
        },
    }
    CONTRACT.write_text(json.dumps(contract, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")

    # The user subsequently opened/saved the on-disk v6 path in MagicDraw, so
    # it is now a native ZIP project. Rebuild the original deterministic v6
    # standard-XMI bytes in memory for a valid before/after comparison without
    # overwriting that user file.
    spec = importlib.util.spec_from_file_location("itemflow_display_v6_builder", PIPELINE_DIR / "17_build_itemflow_display_probe.py")
    module = importlib.util.module_from_spec(spec)
    assert spec.loader is not None
    spec.loader.exec_module(module)
    architecture = json.loads(SOURCE.read_text(encoding="utf-8"))
    mapping_contract = json.loads((PIPELINE_WORK / "itemflow_mapping_contract_v2.json").read_text(encoding="utf-8"))
    compatibility = json.loads((PIPELINE_WORK / "magicdraw2022x_compatibility_contract.json").read_text(encoding="utf-8"))
    v6_root = ET.fromstring(module.transform(architecture, mapping_contract, compatibility))
    v6_elements = list(v6_root.iter())
    v6_xmi = compatibility["namespace_separation"]["xmi_xml_namespace"]
    v6_qx = lambda name: f"{{{v6_xmi}}}{name}"
    v6_diagrams = sum(local(e) == "ownedDiagram" for e in v6_elements)
    v6_presentation = sum(local(e) == "mdElement" for e in v6_elements)
    diff_lines = [
        "# Gold vs v6 Presentation Diff",
        "",
        "## MODEL_LAYER_DIFFERENCE",
        "",
        "- Frozen Product Blocks, Ports, InterfaceBlocks, Signal names, and technical metadata are unchanged.",
        "- gold adds a dedicated standard Block IBD presentation harness with two direct Part Properties typed by 4235 and 5111.",
        "- gold hand-created a direct Connector owned by that harness and an InformationFlow/ItemFlow realized by it; the imported v6 nested Connector remains model-only and has no diagram symbol.",
        "- Native v7 will retain only one semantic Connector for the displayed path by moving the stable frozen Connector identity into the harness.",
        "",
        "## PRESENTATION_LAYER_DIFFERENCE",
        "",
        f"- v6 ownedDiagram / mdElement counts: {v6_diagrams} / {v6_presentation}.",
        f"- Current on-disk v6 container was subsequently saved by MagicDraw: {str(__import__('zipfile').is_zipfile(V6)).lower()} (not overwritten by this pipeline).",
        f"- gold ownedDiagram / mdElement counts: {len(diagrams)} / {len(presentation_elements)}.",
        "- gold has Part and nested Port symbols, one solid Connector path, ConnectorEnd symbols, a conveyed Signal compartment, and a Connector-owned TextBox label.",
        "- gold has no independent InformationFlow or ItemFlow path symbol.",
        "- Direct cause: v6 is standard model XMI without MagicDraw native ownedDiagram/filePart/mdOwnedViews resources; therefore it cannot reproduce the hand-authored IBD presentation.",
    ]
    REPORTS.mkdir(parents=True, exist_ok=True)
    (REPORTS / "gold_vs_probe_presentation_diff.md").write_text("\n".join(diff_lines) + "\n", encoding="utf-8")
    learning_lines = [
        "# MagicDraw Gold Learning Report",
        "",
        f"- Golden Sample parsed: PASS (`{GOLD}`; SHA-256 `{inventory['gold_sha256']}`)",
        f"- Diagram: {diagram['type']} / {diagram['uml_type']}",
        "- Connector line: `mdElement elementClass=Connector` with geometry and default solid link style.",
        f"- ItemFlow arrow: Connector `{conveyed_side}` compartment referencing `{signal.get(qx('id'))}`.",
        f"- Label: Connector-owned TextBox linked by `{conveyed_link_name}`, text `{label_text}`.",
        f"- Independent InformationFlow path: {len(information_flow_symbols)}.",
        "- Generation decision: NATIVE_MDXML.",
    ]
    (REPORTS / "magicdraw_gold_learning_report.md").write_text("\n".join(learning_lines) + "\n", encoding="utf-8")
    return {"gold_parsed": True, "diagram_count": len(diagrams), "presentation_elements": len(presentation_elements), "connector": connector_id, "arrow": conveyed_side, "label": label_text, "independent_information_flow_path": len(information_flow_symbols), "mode": "NATIVE_MDXML"}


def main() -> None:
    print(json.dumps(build(), ensure_ascii=False))


if __name__ == "__main__":
    main()
