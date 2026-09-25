from __future__ import annotations

import hashlib
import json
import xml.etree.ElementTree as ET
from collections import Counter, defaultdict
from pathlib import Path


PIPELINE_DIR = Path(__file__).resolve().parent
ROOT = PIPELINE_DIR.parents[1]
GOLD2 = ROOT / "work" / "gold2.mdxml"
OUTPUT = PIPELINE_DIR / "work" / "gold2_full_inventory_v1.json"


def local(value: str) -> str:
    return value.rsplit("}", 1)[-1]


def attr(element: ET.Element, name: str) -> str | None:
    return next((value for key, value in element.attrib.items() if local(key) == name), None)


def child_ref(element: ET.Element, name: str) -> str | None:
    child = next((entry for entry in element if local(entry.tag) == name), None)
    return attr(child, "idref") if child is not None else element.get(name)


def namespaces(path: Path) -> dict[str, str]:
    result: dict[str, str] = {}
    for _event, pair in ET.iterparse(path, events=("start-ns",)):
        prefix, uri = pair
        result.setdefault(prefix or "default", uri)
    return result


def model_ref(element: ET.Element) -> str | None:
    return child_ref(element, "elementID")


def build_inventory() -> dict:
    ns = namespaces(GOLD2)
    root = ET.parse(GOLD2).getroot()
    elements = list(root.iter())
    parents = {child: parent for parent in elements for child in parent}
    semantic_model = next(entry for entry in root if local(entry.tag) == "Model")
    semantic_elements = list(semantic_model.iter())
    semantic_ids = {attr(entry, "id"): entry for entry in semantic_elements if attr(entry, "id")}
    root_ids = {attr(entry, "id"): entry for entry in root if attr(entry, "id")}

    applications = [
        entry
        for entry in root
        if local(entry.tag)
        in {
            "Block",
            "PartProperty",
            "ProxyPort",
            "NestedConnectorEnd",
            "ItemFlow",
            "InterfaceBlock",
            "FlowProperty",
            "DiagramInfo",
        }
    ]
    app_by_base: dict[str, list[ET.Element]] = defaultdict(list)
    for application in applications:
        for key, value in application.attrib.items():
            if local(key).startswith("base_"):
                app_by_base[value].append(application)

    blocks = []
    for element in semantic_elements:
        if attr(element, "type") != "uml:Class":
            continue
        identifier = attr(element, "id")
        block_apps = [entry for entry in app_by_base.get(identifier, []) if local(entry.tag) == "Block"]
        blocks.append(
            {
                "id": identifier,
                "name": element.get("name"),
                "owner": attr(parents.get(element), "id") if parents.get(element) is not None else None,
                "is_block": bool(block_apps),
                "block_application_ids": [attr(entry, "id") for entry in block_apps],
                "owned_part_ids": [
                    attr(entry, "id")
                    for entry in element
                    if attr(entry, "type") == "uml:Property" and entry.get("aggregation") == "composite"
                ],
                "owned_port_ids": [attr(entry, "id") for entry in element if attr(entry, "type") == "uml:Port"],
                "owned_connector_ids": [attr(entry, "id") for entry in element if attr(entry, "type") == "uml:Connector"],
                "owned_diagram_ids": [attr(entry, "id") for entry in element.iter() if local(entry.tag) == "ownedDiagram"],
            }
        )

    properties = []
    for element in semantic_elements:
        if attr(element, "type") != "uml:Property":
            continue
        identifier = attr(element, "id")
        owner = parents.get(element)
        part_apps = [entry for entry in app_by_base.get(identifier, []) if local(entry.tag) == "PartProperty"]
        properties.append(
            {
                "id": identifier,
                "name": element.get("name"),
                "owner": attr(owner, "id") if owner is not None else None,
                "owner_tag": local(owner.tag) if owner is not None else None,
                "type": child_ref(element, "type"),
                "aggregation": element.get("aggregation"),
                "association": element.get("association"),
                "is_composite_part": element.get("aggregation") == "composite",
                "part_property_application_ids": [attr(entry, "id") for entry in part_apps],
            }
        )

    ports = []
    for element in semantic_elements:
        if attr(element, "type") != "uml:Port":
            continue
        identifier = attr(element, "id")
        owner = parents[element]
        proxy_apps = [entry for entry in app_by_base.get(identifier, []) if local(entry.tag) == "ProxyPort"]
        ports.append(
            {
                "id": identifier,
                "name": element.get("name"),
                "owner": attr(owner, "id"),
                "type": child_ref(element, "type"),
                "aggregation": element.get("aggregation"),
                "is_proxy_port": bool(proxy_apps),
                "proxy_port_application_ids": [attr(entry, "id") for entry in proxy_apps],
            }
        )

    connectors = []
    for element in semantic_elements:
        if attr(element, "type") != "uml:Connector":
            continue
        identifier = attr(element, "id")
        owner = parents[element]
        ends = []
        for end in element:
            if attr(end, "type") != "uml:ConnectorEnd":
                continue
            end_id = attr(end, "id")
            nested = [entry for entry in app_by_base.get(end_id, []) if local(entry.tag) == "NestedConnectorEnd"]
            ends.append(
                {
                    "id": end_id,
                    "partWithPort": child_ref(end, "partWithPort"),
                    "role": child_ref(end, "role"),
                    "nested_connector_end": [
                        {
                            "application_id": attr(entry, "id"),
                            "propertyPath": entry.get("propertyPath"),
                        }
                        for entry in nested
                    ],
                }
            )
        connectors.append(
            {
                "id": identifier,
                "name": element.get("name"),
                "owner": attr(owner, "id"),
                "owner_name": owner.get("name"),
                "owner_tag": local(owner.tag),
                "ends": ends,
            }
        )

    information_flows = []
    for element in semantic_elements:
        if attr(element, "type") != "uml:InformationFlow":
            continue
        identifier = attr(element, "id")
        item_apps = [entry for entry in app_by_base.get(identifier, []) if local(entry.tag) == "ItemFlow"]
        information_flows.append(
            {
                "id": identifier,
                "name": element.get("name"),
                "owner": attr(parents[element], "id"),
                "conveyed": child_ref(element, "conveyed"),
                "informationSource": child_ref(element, "informationSource"),
                "informationTarget": child_ref(element, "informationTarget"),
                "realizingConnector": child_ref(element, "realizingConnector"),
                "item_flow_application_ids": [attr(entry, "id") for entry in item_apps],
                "item_flow_item_property": [entry.get("itemProperty") for entry in item_apps],
            }
        )

    fileparts = {entry.get("name"): entry for entry in elements if local(entry.tag) == "filePart" and entry.get("name")}
    diagrams = []
    presentation_model_refs: Counter[str] = Counter()
    for diagram in [entry for entry in semantic_elements if local(entry.tag) == "ownedDiagram"]:
        representation = next((entry for entry in diagram.iter() if local(entry.tag) == "DiagramRepresentationObject"), None)
        contents = next((entry for entry in diagram.iter() if local(entry.tag) == "diagramContents"), None)
        binary = next((entry for entry in diagram.iter() if local(entry.tag) == "binaryObject"), None)
        resource_id = binary.get("streamContentID") if binary is not None else None
        resource = fileparts.get(resource_id)
        presentation_root = (
            next((entry for entry in resource if local(entry.tag) == "mdOwnedViews"), None)
            if resource is not None
            else None
        )
        presentation_elements = (
            [entry for entry in presentation_root.iter() if local(entry.tag) == "mdElement"]
            if presentation_root is not None
            else []
        )
        records = []
        for presentation in presentation_elements:
            ref = model_ref(presentation)
            if ref:
                presentation_model_refs[ref] += 1
            records.append(
                {
                    "presentation_id": attr(presentation, "id"),
                    "element_class": presentation.get("elementClass"),
                    "model_element": ref,
                    "geometry": next(
                        ((entry.text or "").strip() for entry in presentation if local(entry.tag) == "geometry"),
                        None,
                    ),
                    "link_first_end": child_ref(presentation, "linkFirstEndID"),
                    "link_second_end": child_ref(presentation, "linkSecondEndID"),
                    "link_conveyed_a": child_ref(presentation, "linkConveyedAID"),
                    "link_conveyed_b": child_ref(presentation, "linkConveyedBID"),
                    "compartments": [
                        {
                            "id": entry.get("compartmentID"),
                            "value": attr(entry, "value"),
                        }
                        for entry in presentation
                        if local(entry.tag) == "compartment"
                    ],
                    "texts": [
                        (entry.text or "").strip()
                        for entry in presentation.iter()
                        if local(entry.tag) == "text" and (entry.text or "").strip()
                    ],
                }
            )
        diagrams.append(
            {
                "id": attr(diagram, "id"),
                "name": diagram.get("name"),
                "ownerOfDiagram": diagram.get("ownerOfDiagram"),
                "context": diagram.get("context"),
                "representation_type": representation.get("type") if representation is not None else None,
                "representation_uml_type": representation.get("umlType") if representation is not None else None,
                "representation_id": representation.get("ID") if representation is not None else None,
                "presentation_resource": resource_id,
                "content_hash": contents.get("contentHash") if contents is not None else None,
                "usedObjects": [
                    (entry.get("href") or "").lstrip("#")
                    for entry in contents or []
                    if local(entry.tag) == "usedObjects"
                ],
                "usedElements": [
                    (entry.text or "").strip()
                    for entry in contents or []
                    if local(entry.tag) == "usedElements"
                ],
                "presentation_class_counts": dict(
                    sorted(Counter(entry.get("elementClass") for entry in presentation_elements).items())
                ),
                "presentations": records,
            }
        )

    chain_records = []
    info_by_connector = {entry["realizingConnector"]: entry for entry in information_flows}
    diagram_by_owner = {entry["ownerOfDiagram"]: entry for entry in diagrams if entry["context"]}
    for block in [entry for entry in blocks if entry["owned_connector_ids"]]:
        diagram = diagram_by_owner.get(block["id"])
        for connector_id in block["owned_connector_ids"]:
            connector = next(entry for entry in connectors if entry["id"] == connector_id)
            info = info_by_connector.get(connector_id)
            chain_records.append(
                {
                    "block": {"id": block["id"], "name": block["name"]},
                    "diagram": {
                        "id": diagram["id"] if diagram else None,
                        "resource": diagram["presentation_resource"] if diagram else None,
                    },
                    "parts": [entry["partWithPort"] for entry in connector["ends"] if entry["partWithPort"]],
                    "ports_or_roles": [entry["role"] for entry in connector["ends"]],
                    "connector": connector_id,
                    "connector_presentation_count": presentation_model_refs[connector_id],
                    "information_flow": info,
                }
            )

    all_ids = [attr(entry, "id") for entry in elements if attr(entry, "id")]
    semantic_id_set = set(semantic_ids)
    connector_ids = {entry["id"] for entry in connectors}
    info_ids = {entry["id"] for entry in information_flows}
    itemflow_bases = {
        entry.get("base_InformationFlow")
        for entry in applications
        if local(entry.tag) == "ItemFlow"
    }
    invalid_info_refs = [
        entry["id"]
        for entry in information_flows
        if entry["realizingConnector"] not in connector_ids or entry["conveyed"] not in semantic_id_set
    ]
    independent_information_flow_paths = sum(presentation_model_refs[identifier] for identifier in info_ids)

    inventory = {
        "inventory_id": "RAIL-MBSE-GOLD2-FULL-INVENTORY-V1",
        "source": str(GOLD2),
        "sha256": hashlib.sha256(GOLD2.read_bytes()).hexdigest(),
        "read_only": True,
        "namespaces": ns,
        "document_counts": {
            "elements": len(elements),
            "xmi_ids_including_native_snapshots": len(all_ids),
            "duplicate_xmi_ids_including_native_snapshots": len(all_ids) - len(set(all_ids)),
            "tag_counts": dict(sorted(Counter(local(entry.tag) for entry in elements).items())),
            "xmi_type_counts": dict(sorted(Counter(attr(entry, "type") for entry in elements if attr(entry, "type")).items())),
        },
        "semantic_model": {
            "id": attr(semantic_model, "id"),
            "name": semantic_model.get("name"),
            "classes": blocks,
            "properties": properties,
            "ports": ports,
            "connectors": connectors,
            "information_flows": information_flows,
            "item_flows": [
                {
                    "application_id": attr(entry, "id"),
                    "base_InformationFlow": entry.get("base_InformationFlow"),
                    "itemProperty": entry.get("itemProperty"),
                }
                for entry in applications
                if local(entry.tag) == "ItemFlow"
            ],
            "nested_connector_ends": [
                {
                    "application_id": attr(entry, "id"),
                    "base_ConnectorEnd": entry.get("base_ConnectorEnd"),
                    "propertyPath": entry.get("propertyPath"),
                }
                for entry in applications
                if local(entry.tag) == "NestedConnectorEnd"
            ],
        },
        "diagrams": diagrams,
        "native_file_parts": [
            {
                "name": entry.get("name"),
                "type": entry.get("type"),
                "inline_child_tags": [local(child.tag) for child in entry],
                "binary_text_length": len((entry.text or "").strip()),
            }
            for entry in elements
            if local(entry.tag) == "filePart"
        ],
        "block_to_ibd_to_part_to_port_to_connector_chain": chain_records,
        "integrity": {
            "business_block_count": sum(entry["is_block"] for entry in blocks),
            "composite_part_count": sum(entry["is_composite_part"] for entry in properties),
            "diagram_count": len(diagrams),
            "ibd_count": sum(entry["representation_type"] == "SysML Internal Block Diagram" for entry in diagrams),
            "connector_count": len(connectors),
            "connector_end_count": sum(len(entry["ends"]) for entry in connectors),
            "proxy_port_count": sum(entry["is_proxy_port"] for entry in ports),
            "information_flow_count": len(information_flows),
            "item_flow_count": sum(local(entry.tag) == "ItemFlow" for entry in applications),
            "all_information_flows_realize_connector_and_convey_classifier": not invalid_info_refs,
            "all_information_flows_have_item_flow": info_ids == itemflow_bases,
            "all_connectors_have_native_presentation": all(presentation_model_refs[identifier] == 1 for identifier in connector_ids),
            "independent_information_flow_path_count": independent_information_flow_paths,
            "invalid_information_flow_ids": invalid_info_refs,
        },
        "learning_limits": {
            "information_source_target_are_ports": all(
                entry["informationSource"] in {port["id"] for port in ports}
                and entry["informationTarget"] in {port["id"] for port in ports}
                for entry in information_flows
            ),
            "all_connector_roles_are_ports": all(
                end["role"] in {port["id"] for port in ports}
                for connector in connectors
                for end in connector["ends"]
            ),
            "typed_proxy_ports": sum(bool(port["type"]) and port["is_proxy_port"] for port in ports),
            "interface_block_count": sum(local(entry.tag) == "InterfaceBlock" for entry in applications),
            "flow_property_count": sum(local(entry.tag) == "FlowProperty" for entry in applications),
        },
    }
    return inventory


def main() -> None:
    inventory = build_inventory()
    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT.write_text(json.dumps(inventory, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({"output": str(OUTPUT), "integrity": inventory["integrity"], "learning_limits": inventory["learning_limits"]}, ensure_ascii=False))


if __name__ == "__main__":
    main()
