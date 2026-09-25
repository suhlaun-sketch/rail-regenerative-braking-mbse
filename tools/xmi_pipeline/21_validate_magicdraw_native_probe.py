from __future__ import annotations

import hashlib
import importlib.util
import json
import re
import xml.etree.ElementTree as ET
from pathlib import Path


PIPELINE_DIR = Path(__file__).resolve().parent
ROOT = PIPELINE_DIR.parents[1]
GOLD = ROOT / "work" / "gold.mdxml"
PROBE = ROOT / "work" / "Rail_MBSE_ItemFlow_native_probe_v7.mdxml"
INVENTORY = PIPELINE_DIR / "work" / "gold_mdxml_inventory.json"
MANIFEST = PIPELINE_DIR / "work" / "magicdraw_native_probe_v7_manifest.json"
VALIDATION = PIPELINE_DIR / "work" / "magicdraw_native_probe_v7_validation.json"
REPORT = ROOT / "reports" / "magicdraw_gold_learning_report.md"


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


def find_one(elements: list[ET.Element], predicate, label: str) -> ET.Element:
    matches = [element for element in elements if predicate(element)]
    if len(matches) != 1:
        raise AssertionError(f"Expected one {label}, found {len(matches)}")
    return matches[0]


def model_ref(element: ET.Element) -> str | None:
    return child_ref(element, "elementID")


def validate() -> dict:
    gold_hash = hashlib.sha256(GOLD.read_bytes()).hexdigest()
    manifest = json.loads(MANIFEST.read_text(encoding="utf-8"))
    inventory = json.loads(INVENTORY.read_text(encoding="utf-8"))
    probe_bytes = PROBE.read_bytes()
    if hashlib.sha256(probe_bytes).hexdigest() != manifest["output_sha256"]:
        raise AssertionError("Probe hash differs from builder manifest")

    root = ET.fromstring(probe_bytes)
    elements = list(root.iter())
    parents = {child: parent for parent in elements for child in parent}
    ids: dict[str, ET.Element] = {}
    for element in elements:
        identifier = attr_local(element, "id")
        if not identifier:
            continue
        if identifier not in ids:
            ids[identifier] = element

    stable = manifest["stable_model_mapping"]
    connector = ids[stable["connector"]]
    information_flow = ids[stable["information_flow"]]
    item_flow = ids[stable["item_flow_application"]]
    source_part = ids[stable["source_part"]]
    target_part = ids[stable["target_part"]]
    source_port = ids[stable["source_port"]]
    target_port = ids[stable["target_port"]]
    signal = ids[stable["conveyed_signal"]]

    resource_id = manifest["presentation_resource_id"]
    filepart = find_one(elements, lambda e: local(e) == "filePart" and e.get("name") == resource_id, "native presentation filePart")
    presentation_root = find_one(list(filepart), lambda e: local(e) == "mdOwnedViews", "mdOwnedViews")
    presentation = [e for e in presentation_root.iter() if local(e) == "mdElement"]
    presentation_by_id = {attr_local(e, "id"): e for e in presentation if attr_local(e, "id")}
    connector_path = find_one(presentation, lambda e: e.get("elementClass") == "Connector" and model_ref(e) == stable["connector"], "Connector path")
    part_symbols = [e for e in presentation if e.get("elementClass") == "Part"]
    port_symbols = [e for e in presentation if e.get("elementClass") == "Port"]
    source_part_symbol = find_one(part_symbols, lambda e: model_ref(e) == stable["source_part"], "source Part symbol")
    target_part_symbol = find_one(part_symbols, lambda e: model_ref(e) == stable["target_part"], "target Part symbol")
    source_port_symbol = find_one(port_symbols, lambda e: model_ref(e) == stable["source_port"], "source Port symbol")
    target_port_symbol = find_one(port_symbols, lambda e: model_ref(e) == stable["target_port"], "target Port symbol")

    compartment = find_one(
        list(connector_path),
        lambda e: local(e) == "compartment" and e.get("compartmentID") == "CONVEYED_INFORMATION_A",
        "Connector conveyed-information A compartment",
    )
    label_id = child_ref(connector_path, "linkConveyedAID")
    label = presentation_by_id.get(label_id)
    label_text = next(((e.text or "") for e in label or [] if local(e) == "text"), "")

    first_symbol = presentation_by_id.get(child_ref(connector_path, "linkFirstEndID"))
    second_symbol = presentation_by_id.get(child_ref(connector_path, "linkSecondEndID"))
    first_model = model_ref(first_symbol) if first_symbol is not None else None
    second_model = model_ref(second_symbol) if second_symbol is not None else None

    source_type = child_ref(source_part, "type")
    target_type = child_ref(target_part, "type")
    part_bindings_ok = source_type == stable["source_product"] and target_type == stable["target_product"]
    def has_ancestor(element: ET.Element, ancestor: ET.Element) -> bool:
        cursor = parents.get(element)
        while cursor is not None:
            if cursor is ancestor:
                return True
            cursor = parents.get(cursor)
        return False

    port_parent_ok = has_ancestor(source_port_symbol, source_part_symbol) and has_ancestor(target_port_symbol, target_part_symbol)

    ends = [e for e in connector if attr_local(e, "type") == "uml:ConnectorEnd"]
    source_end = find_one(ends, lambda e: child_ref(e, "role") == stable["source_port"], "source ConnectorEnd")
    target_end = find_one(ends, lambda e: child_ref(e, "role") == stable["target_port"], "target ConnectorEnd")
    endpoint_model_ok = (
        child_ref(source_end, "partWithPort") == stable["source_part"]
        and child_ref(target_end, "partWithPort") == stable["target_part"]
        and second_model == stable["source_port"]
        and first_model == stable["target_port"]
    )

    direction_file = PIPELINE_DIR / "work" / "port_direction_resolution.json"
    directions = json.loads(direction_file.read_text(encoding="utf-8"))
    direction_records = directions.get("records", directions.get("ports", directions)) if isinstance(directions, dict) else directions
    by_owner_name = {(r["product_id"], r["port_name"]): r for r in direction_records}
    source_record = by_owner_name.get(("4235", source_port.get("name")))
    target_record = by_owner_name.get(("5111", target_port.get("name")))
    source_direction = source_record["effective_port_direction"] if source_record else None
    target_direction = target_record["effective_port_direction"] if target_record else None

    info_semantics_ok = (
        child_ref(information_flow, "informationSource") == stable["source_port"]
        and child_ref(information_flow, "informationTarget") == stable["target_port"]
        and child_ref(information_flow, "conveyed") == stable["conveyed_signal"]
        and child_ref(information_flow, "realizingConnector") == stable["connector"]
    )
    item_flow_ok = item_flow.get("base_InformationFlow") == stable["information_flow"]
    no_item_property = not item_flow.get("itemProperty") and not any(local(e) == "itemProperty" for e in item_flow)
    direction_ok = source_direction == "out" and target_direction == "in" and info_semantics_ok and endpoint_model_ok

    info_path_count = sum(model_ref(e) == stable["information_flow"] for e in presentation)
    item_path_count = sum(model_ref(e) == stable["item_flow_application"] for e in presentation)
    signal_name_ok = signal.get("name") == "高压线路电压"
    arrow_ok = (
        attr_local(compartment, "value") == stable["conveyed_signal"]
        and label is not None
        and first_model == stable["target_port"]
        and second_model == stable["source_port"]
    )

    # Gold expresses the solid path by a Connector mdElement with no dashed
    # line override. The conveyed-information compartment supplies the arrow.
    connector_children_text = " ".join((e.text or "") for e in connector_path.iter())
    solid_ok = "DASH" not in connector_children_text.upper() and connector_path.get("elementClass") == "Connector"

    gold_root = ET.parse(GOLD).getroot()
    gold_elements = list(gold_root.iter())
    gold_resource = find_one(
        gold_elements,
        lambda e: local(e) == "filePart" and e.get("name") == inventory["presentation"]["resource"],
        "gold presentation filePart",
    )
    gold_presentation_ids = {
        attr_local(e, "id")
        for e in gold_resource.iter()
        if local(e) == "mdElement" and attr_local(e, "id")
    }
    new_presentation_ids = {attr_local(e, "id") for e in presentation if attr_local(e, "id")}
    forbidden_reuse = sorted(gold_presentation_ids & new_presentation_ids)
    no_gold_ids = (
        not forbidden_reuse
        and inventory["diagrams"][0]["diagram_id"] not in ids
        and inventory["presentation"]["resource"] != resource_id
        and manifest["project_id"] != "PROJECT-9d229b7f23ee72e551be257697554fa5"
    )

    # Embedded standard profile snapshots legitimately repeat their own IDs.
    # Uniqueness for this probe concerns the active semantic model (before the
    # first filePart) plus the active presentation resource.
    probe_text = probe_bytes.decode("utf-8")
    active_text = probe_text[: probe_text.index("<filePart ")]
    resource_marker = f"<filePart name='{resource_id}'"
    resource_file_start = probe_text.index(resource_marker)
    resource_start = probe_text.index("<mdOwnedViews>", resource_file_start)
    resource_file_end = probe_text.index("</filePart>", resource_start)
    resource_end = probe_text.rindex("</mdOwnedViews>", resource_start, resource_file_end) + len("</mdOwnedViews>")
    active_text += probe_text[resource_start:resource_end]
    active_id_values = [a or b for a, b in re.findall(r"\bxmi:id=(?:'([^']+)'|\"([^\"]+)\")", active_text)]
    active_duplicate_ids = sorted({identifier for identifier in active_id_values if active_id_values.count(identifier) > 1})

    unresolved_refs = []
    active_ids = set(active_id_values)
    for element in presentation_root.iter():
        for key, value in element.attrib.items():
            if key.rsplit("}", 1)[-1] == "idref" and value not in active_ids:
                unresolved_refs.append(value)
        if local(element) in {"linkFirstEndID", "linkSecondEndID", "linkConveyedAID", "linkConveyedBID"}:
            value = (element.text or "").strip()
            if value and value not in presentation_by_id:
                unresolved_refs.append(value)

    spec = importlib.util.spec_from_file_location("native_builder", PIPELINE_DIR / "20_build_magicdraw_native_probe.py")
    builder = importlib.util.module_from_spec(spec)
    assert spec.loader is not None
    spec.loader.exec_module(builder)
    repeat_a, _ = builder.build_bytes()
    repeat_b, _ = builder.build_bytes()
    deterministic_ok = repeat_a == repeat_b == probe_bytes

    qa = {
        "PRES-QA-01": (connector_path is not None, "Connector path exists"),
        "PRES-QA-02": (solid_ok, "Connector path uses gold solid Connector presentation"),
        "PRES-QA-03": (arrow_ok, "ItemFlow arrow is encoded on Connector"),
        "PRES-QA-04": (direction_ok, "Arrow and model direction are source -> target"),
        "PRES-QA-05": (compartment.get("compartmentID") == "CONVEYED_INFORMATION_A", "Arrow presentation type matches gold"),
        "PRES-QA-06": (signal_name_ok and label_text == signal.get("name"), "Conveyed Signal Chinese name is displayed"),
        "PRES-QA-07": (label_text == "高压线路电压", "Displayed text is 高压线路电压"),
        "PRES-QA-08": (info_path_count == 0, "No independent InformationFlow path"),
        "PRES-QA-09": (part_bindings_ok, "Part symbols bind the correct typed Part Properties"),
        "PRES-QA-10": (port_parent_ok, "ProxyPort symbols bind existing Ports under their Parts"),
        "PRES-QA-11": (model_ref(connector_path) == stable["connector"], "Connector presentation binds the real Connector"),
        "PRES-QA-12": (info_semantics_ok and item_flow_ok and item_path_count == 0, "ItemFlow model semantics bind to the presented Connector"),
        "PRES-QA-13": (no_gold_ids, "No gold project/diagram/presentation IDs are copied"),
        "PRES-QA-14": (not active_duplicate_ids and not unresolved_refs, "All new presentation references resolve"),
        "PRES-QA-15": (deterministic_ok, "Two generations are byte-identical"),
    }
    results = {key: {"status": "PASS" if passed else "FAIL", "detail": detail} for key, (passed, detail) in qa.items()}
    pass_count = sum(value["status"] == "PASS" for value in results.values())
    fail_count = len(results) - pass_count
    conclusion = "READY_FOR_MAGICDRAW_IMPORT" if fail_count == 0 else "PRESENTATION_STILL_NEEDS_ADJUSTMENT"
    validation = {
        "validation_id": "RAIL-MBSE-MAGICDRAW-NATIVE-PROBE-V7-VALIDATION",
        "probe": str(PROBE),
        "gold_read_only_sha256": gold_hash,
        "counts": {
            "connector_model": 1,
            "connector_presentation": 1,
            "information_flow": 1,
            "item_flow": 1,
            "item_property_empty": 1 if no_item_property else 0,
            "independent_information_flow_path": info_path_count,
            "part_symbols": len(part_symbols),
            "port_symbols": len(port_symbols),
        },
        "evidence": {
            "connector_path_id": attr_local(connector_path, "id"),
            "conveyed_compartment": compartment.get("compartmentID"),
            "label_id": label_id,
            "label_text": label_text,
            "source_effective_direction": source_direction,
            "target_effective_direction": target_direction,
            "item_property": item_flow.get("itemProperty"),
            "unresolved_presentation_refs": sorted(set(unresolved_refs)),
            "duplicate_xmi_ids": active_duplicate_ids,
            "reused_gold_presentation_ids": forbidden_reuse,
        },
        "qa": results,
        "summary": {"pass": pass_count, "fail": fail_count, "conclusion": conclusion},
    }
    VALIDATION.write_text(json.dumps(validation, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")

    REPORT.write_text(
        "\n".join(
            [
                "# MagicDraw Gold Learning Report",
                "",
                f"- Golden Sample parsed: PASS (`{GOLD}`; SHA-256 `{gold_hash}`)",
                "- Native mechanism: solid `mdElement elementClass=Connector` path.",
                "- Arrow: Connector `CONVEYED_INFORMATION_A` compartment; source is graphical second end and target is first end.",
                "- Label: Connector-owned TextBox referenced by `linkConveyedAID`; text is conveyed Signal name `高压线路电压`.",
                "- Independent InformationFlow presentation path: 0.",
                "- Model semantics: one Connector + one InformationFlow + one SysML ItemFlow; itemProperty is empty.",
                f"- Native v7 QA: {pass_count} PASS / {fail_count} FAIL.",
                f"- Conclusion: `{conclusion}`.",
                f"- Probe: `{PROBE}`",
            ]
        )
        + "\n",
        encoding="utf-8",
    )
    return validation


def main() -> None:
    result = validate()
    print(json.dumps(result["summary"], ensure_ascii=False))


if __name__ == "__main__":
    main()
