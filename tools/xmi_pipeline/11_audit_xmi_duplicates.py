from __future__ import annotations

import json
import xml.etree.ElementTree as ET
from collections import Counter, defaultdict
from pathlib import Path


PIPELINE_DIR = Path(__file__).resolve().parent
ROOT = PIPELINE_DIR.parents[1]
SOURCE = ROOT / "work" / "architecture_xmi_ready_v1.json"
OLD_FULL = ROOT / "work" / "Rail_MBSE_SysML17_v1.xmi"
OUTPUT = PIPELINE_DIR / "work" / "xmi_duplicate_audit.json"


def namespaces(path: Path) -> dict[str, str]:
    result: dict[str, str] = {}
    for _event, pair in ET.iterparse(path, events=("start-ns",)):
        prefix, uri = pair
        result[prefix or "default"] = uri
    return result


def excess(counter: Counter) -> int:
    return sum(count - 1 for count in counter.values() if count > 1)


def duplicate_values(counter: Counter) -> list[dict]:
    return [
        {"key": list(key) if isinstance(key, tuple) else key, "count": count}
        for key, count in sorted(counter.items(), key=lambda pair: str(pair[0]))
        if count > 1
    ]


def audit() -> dict:
    architecture = json.loads(SOURCE.read_text(encoding="utf-8"))
    ns = namespaces(OLD_FULL)
    xmi_ns = ns["xmi"]
    qx = lambda name: f"{{{xmi_ns}}}{name}"
    root = ET.parse(OLD_FULL).getroot()
    parents = {child: parent for parent in root.iter() for child in parent}
    elements = list(root.iter())

    def identifier(element: ET.Element) -> str | None:
        return element.get(qx("id"))

    def uml_type(element: ET.Element) -> str | None:
        return element.get(qx("type"))

    def reference(element: ET.Element, field: str) -> str | None:
        if element.get(field):
            return element.get(field)
        child = element.find(field)
        if child is not None:
            return child.get(qx("idref")) or child.get("href")
        return None

    ids = Counter(identifier(element) for element in elements if identifier(element))
    product_xmi = {p["id"]: p["xmi_id"] for p in architecture["products"]}
    product_xmi_set = set(product_xmi.values())

    product_classes = Counter(
        identifier(element)
        for element in elements
        if uml_type(element) == "uml:Class" and identifier(element) in product_xmi_set
    )

    stereotype_apps: defaultdict[str, list[ET.Element]] = defaultdict(list)
    for element in elements:
        local = element.tag.rsplit("}", 1)[-1]
        if local in {"Block", "InterfaceBlock", "ProxyPort", "FlowProperty", "ItemFlow", "Allocate"}:
            stereotype_apps[local].append(element)
    block_targets = Counter(
        reference(app, "base_Class")
        for app in stereotype_apps["Block"]
        if reference(app, "base_Class") in product_xmi_set
    )

    hierarchy_pairs = {(p["parent_id"], p["id"]) for p in architecture["products"] if p.get("parent_id")}
    hierarchy_xmi_pairs = {(product_xmi[parent], product_xmi[child]) for parent, child in hierarchy_pairs}
    part_pairs = Counter()
    part_non_block = []
    all_composition_pairs = Counter()
    for element in elements:
        if uml_type(element) != "uml:Property" or element.get("aggregation") != "composite":
            continue
        owner = parents.get(element)
        owner_id = identifier(owner) if owner is not None else None
        target = element.get("type") or reference(element, "type")
        key = (owner_id, target)
        all_composition_pairs[key] += 1
        if key in hierarchy_xmi_pairs:
            part_pairs[key] += 1
        if owner_id in product_xmi_set and target not in product_xmi_set:
            part_non_block.append(
                {"part_xmi_id": identifier(element), "owner_xmi_id": owner_id, "type_xmi_id": target}
            )

    connection_by_xmi = {c["xmi_id"]: c for c in architecture["connections"]}
    connector_counts = Counter(
        identifier(element)
        for element in elements
        if uml_type(element) == "uml:Connector" and identifier(element) in connection_by_xmi
    )
    all_connectors = [element for element in elements if uml_type(element) == "uml:Connector"]
    physical_net_xmi = {net["xmi_id"] for net in architecture["physical_nets"]}
    physical_net_connector_counts = Counter(
        identifier(element) for element in all_connectors if identifier(element) in physical_net_xmi
    )
    frozen_connection_ids = Counter(c["connection_id"] for c in architecture["connections"])
    frozen_connection_equivalence = Counter(
        (
            c["source_interface_id"],
            c["target_interface_id"],
            c["item_id"],
            c["mode"],
        )
        for c in architecture["connections"]
    )

    signal_by_conn_xmi = {c["xmi_id"]: c for c in architecture["connections"] if c["mode"] == "SIGNAL"}
    info_by_connector = Counter()
    info_ids_by_connector: defaultdict[str, list[str]] = defaultdict(list)
    for element in elements:
        if uml_type(element) != "uml:InformationFlow":
            continue
        connector_ref = reference(element, "realizingConnector")
        if connector_ref in signal_by_conn_xmi:
            info_by_connector[connector_ref] += 1
            info_ids_by_connector[connector_ref].append(identifier(element) or "")
    itemflow_by_info = Counter(
        reference(app, "base_InformationFlow") for app in stereotype_apps["ItemFlow"]
    )
    duplicate_signal_itemflows = Counter()
    for connector_id, info_ids in info_ids_by_connector.items():
        total = sum(itemflow_by_info[info_id] for info_id in info_ids)
        if total:
            duplicate_signal_itemflows[connector_id] = total

    allocation_by_xmi = {a["xmi_id"]: a for a in architecture["allocations"]}
    abstraction_counts = Counter(
        identifier(element)
        for element in elements
        if uml_type(element) == "uml:Abstraction" and identifier(element) in allocation_by_xmi
    )
    allocate_by_abstraction = Counter(
        reference(app, "base_Abstraction") for app in stereotype_apps["Allocate"]
        if reference(app, "base_Abstraction") in allocation_by_xmi
    )

    # The neutral old XMI contains no vendor diagram-interchange symbols. If a
    # later file does, these conservative tag/type tests audit them separately.
    diagram_symbols = []
    relationship_symbols = []
    for element in elements:
        signature = " ".join((element.tag, uml_type(element) or "", element.get("name") or "")).lower()
        if "diagram" in signature or "presentationelement" in signature or "shapeelement" in signature:
            diagram_symbols.append(element)
            if any(token in signature for token in ("relationship", "path", "edge", "connectorview")):
                relationship_symbols.append(element)
    diagram_block_keys = Counter(
        (element.get("diagram_id"), element.get("product_id") or element.get("element"))
        for element in diagram_symbols
        if element.get("product_id") or element.get("element") in product_xmi_set
    )
    diagram_relationship_keys = Counter(
        (element.get("diagram_id"), element.get("relationship_id") or element.get("element"))
        for element in relationship_symbols
    )

    categories = {
        "duplicate_xmi_id": {"excess": excess(ids), "details": duplicate_values(ids)},
        "duplicate_product_block_definition": {"excess": excess(product_classes), "details": duplicate_values(product_classes)},
        "duplicate_block_stereotype_application": {"excess": excess(block_targets), "details": duplicate_values(block_targets)},
        "duplicate_parent_child_part_property": {"excess": excess(part_pairs), "details": duplicate_values(part_pairs)},
        "duplicate_composition": {"excess": excess(all_composition_pairs), "details": duplicate_values(all_composition_pairs)},
        "part_typed_by_non_block": {"count": len(part_non_block), "details": part_non_block},
        "duplicate_connector_connection_id": {"excess": excess(connector_counts), "details": duplicate_values(connector_counts)},
        "duplicate_frozen_connection_id": {"excess": excess(frozen_connection_ids), "details": duplicate_values(frozen_connection_ids)},
        "duplicate_connector_semantic_tuple": {"excess": excess(frozen_connection_equivalence), "details": duplicate_values(frozen_connection_equivalence)},
        "duplicate_information_flow": {"excess": excess(info_by_connector), "details": duplicate_values(info_by_connector)},
        "duplicate_item_flow": {"excess": excess(duplicate_signal_itemflows), "details": duplicate_values(duplicate_signal_itemflows)},
        "duplicate_allocation_abstraction": {"excess": excess(abstraction_counts), "details": duplicate_values(abstraction_counts)},
        "duplicate_allocate_stereotype": {"excess": excess(allocate_by_abstraction), "details": duplicate_values(allocate_by_abstraction)},
        "duplicate_diagram_block_symbol": {"excess": excess(diagram_block_keys), "details": duplicate_values(diagram_block_keys)},
        "duplicate_diagram_relationship_symbol": {"excess": excess(diagram_relationship_keys), "details": duplicate_values(diagram_relationship_keys)},
    }
    model_keys = [key for key in categories if not key.startswith("duplicate_diagram") and key != "part_typed_by_non_block"]
    relationship_keys = [
        "duplicate_parent_child_part_property", "duplicate_composition",
        "duplicate_connector_connection_id", "duplicate_frozen_connection_id",
        "duplicate_connector_semantic_tuple", "duplicate_information_flow",
        "duplicate_item_flow", "duplicate_allocation_abstraction", "duplicate_allocate_stereotype",
    ]
    result = {
        "audit_id": "RAIL-MBSE-XMI-DUPLICATE-AUDIT-V2",
        "audited_file": str(OLD_FULL),
        "scope_note": "Read-only audit of the previously generated full XMI; Block definition and typed Part Property are deliberately distinct and are not treated as duplicates.",
        "baseline": {
            "products": len(architecture["products"]),
            "product_hierarchy": len(hierarchy_pairs),
            "connections": len(architecture["connections"]),
            "signal_connections": len(signal_by_conn_xmi),
            "allocations": len(architecture["allocations"]),
            "physical_nets": len(architecture["physical_nets"]),
        },
        "observed": {
            "product_block_definitions": sum(product_classes.values()),
            "product_block_stereotype_applications": sum(block_targets.values()),
            "parent_child_part_properties": sum(part_pairs.values()),
            "uml_ports": sum(uml_type(element) == "uml:Port" for element in elements),
            "proxy_port_stereotypes": len(stereotype_apps["ProxyPort"]),
            "all_uml_connectors": len(all_connectors),
            "final_connectors": sum(connector_counts.values()),
            "physical_net_connectors": sum(physical_net_connector_counts.values()),
            "signal_information_flows": sum(info_by_connector.values()),
            "signal_itemflows": sum(duplicate_signal_itemflows.values()),
            "allocation_abstractions": sum(abstraction_counts.values()),
            "allocate_stereotypes": sum(allocate_by_abstraction.values()),
            "diagram_elements_detected": len(diagram_symbols),
        },
        "categories": categories,
        "summary": {
            "MODEL_DUPLICATE": sum(categories[key]["excess"] for key in model_keys),
            "DIAGRAM_DUPLICATE": categories["duplicate_diagram_block_symbol"]["excess"] + categories["duplicate_diagram_relationship_symbol"]["excess"],
            "RELATIONSHIP_DUPLICATE": sum(categories[key]["excess"] for key in relationship_keys),
            "PART_TYPED_BY_NON_BLOCK": len(part_non_block),
        },
    }
    OUTPUT.write_text(json.dumps(result, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    return result


def main() -> None:
    result = audit()
    print(json.dumps(result["summary"], ensure_ascii=False))


if __name__ == "__main__":
    main()
