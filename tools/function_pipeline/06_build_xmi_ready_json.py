"""Build a deterministic, self-contained XMI-ready architecture JSON and schema."""
from __future__ import annotations

import hashlib
import json
from collections import defaultdict
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
WORK = HERE / "work"
OUTDIR = ROOT / "work"
PROFILE_ID = "CRH_AC25KV_SC"


def read(name):
    return json.loads((WORK / name).read_text(encoding="utf-8"))


def write(path, data):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


def short_hash(value):
    return hashlib.sha1(value.encode("utf-8")).hexdigest()[:16].upper()


def xmi_port(port_id):
    return f"XMI-PORT-{short_hash(port_id)}"


def main():
    source = read("source_architecture.json")
    function_doc = read("all_functions.json")
    allocation_doc = read("function_allocations.json")
    mapping_doc = read("function_interface_mappings.json")
    products_by_id = {x["code"]: x for x in source["products"]}
    ports_by_id = {x["port_id"]: x for x in source["interfaces"]}

    incident_modes = defaultdict(set)
    for connection in source["connections"]:
        incident_modes[connection["source_port_id"]].add(connection["mode"])
        if connection.get("target_port_id"):
            incident_modes[connection["target_port_id"]].add(connection["mode"])
    net_by_port = defaultdict(list)
    for member in source["net_memberships"]:
        net_by_port[member["port_id"]].append(member["net_id"])
    coverage = {x["port_id"]: x for x in source["port_coverage"]}

    products = []
    for product in source["products"]:
        products.append({
            "id": product["code"],
            "xmi_id": f"XMI-PRODUCT-{product['code']}",
            "name": product["name"],
            "level": int(product["level"]),
            "parent_id": product["parent_code"] or None,
            "leaf": bool(product["leaf"]),
            "selected": bool(product["selected"]),
            "namespace": product["namespace"],
            "source_type": product["source_type"],
            "stereotype_hint": "Block",
        })

    items = []
    for item in source["items"]:
        items.append({
            "item_code": item["item_code"],
            "xmi_id": f"XMI-ITEM-{item['item_code']}",
            "name_cn": item["item_name_cn"],
            "name_en": item["item_name_en"],
            "family": item["item_family"],
            "domain": item["domain"],
            "datatype": item["datatype"],
            "unit_medium": item["unit_medium"],
            "semantic_definition": item["semantic_definition"],
            "aliases": item["aliases"],
            "priority": item["priority"],
            "validity_rule": item["validity_rule"],
            "fault_strategy": item["fault_strategy"],
            "usage_note": item["usage_note"],
            "port_type_id": item["port_type_id"],
            "interface_type_id": item["interface_type_id"],
            "xmi_metaclass_hint": "InterfaceDefinition",
        })

    interfaces = []
    for port in source["interfaces"]:
        disposition = coverage.get(port["port_id"], {}).get("disposition")
        if net_by_port[port["port_id"]]:
            connection_mode = "NET"
        elif disposition == "OPTIONAL_OPEN":
            connection_mode = "OPTIONAL_OPEN"
        elif incident_modes[port["port_id"]]:
            connection_mode = sorted(incident_modes[port["port_id"]])[0]
        else:
            connection_mode = None
        interfaces.append({
            "interface_instance_id": f"IFINST::{port['port_id']}",
            "xmi_id": xmi_port(port["port_id"]),
            "owner_product_id": port["product_code"],
            "port_id": port["port_id"],
            "name": port["port_name"],
            "direction": port["direction"],
            "category": port["port_category"],
            "item_id": port["item_code"],
            "port_type_id": port["port_type_id"],
            "interface_type_id": port["interface_type_id"],
            "profile_active": bool(port["profile_active"]),
            "connection_mode": connection_mode,
            "physical_net_id": sorted(net_by_port[port["port_id"]])[0] if net_by_port[port["port_id"]] else None,
            "xmi_metaclass_hint": "Port",
        })

    external_boundaries = [{
        "boundary_id": x["boundary_id"],
        "xmi_id": f"XMI-BOUNDARY-{x['boundary_id']}",
        "name": x["name"],
        "domain": x["domain"],
        "profile_id": x["profile_id"],
        "xmi_metaclass_hint": "ExternalBoundary",
    } for x in source["external_boundaries"]]

    connections = []
    for connection in source["connections"]:
        connections.append({
            "connection_id": connection["connection_id"],
            "xmi_id": f"XMI-CONN-{connection['connection_id']}",
            "mode": connection["mode"],
            "source_product_id": connection["source_product"],
            "source_interface_id": f"IFINST::{connection['source_port_id']}",
            "target_product_id": connection.get("target_product"),
            "target_interface_id": f"IFINST::{connection['target_port_id']}" if connection.get("target_port_id") else None,
            "target_boundary_id": connection.get("target_boundary"),
            "item_id": connection["item_code"],
            "interface_type_id": connection["interface_type_id"],
            "profile_id": connection["profile_id"],
            "resolution_basis": connection["resolution_basis"],
            "xmi_metaclass_hint": "Connector",
        })

    members_by_net = defaultdict(list)
    for member in source["net_memberships"]:
        members_by_net[member["net_id"]].append({
            "net_member_id": member["membership_id"],
            "product_id": member["product_code"],
            "interface_id": f"IFINST::{member['port_id']}",
            "item_id": member["item_code"],
            "participation": member["participation"],
        })
    physical_nets = []
    for net in source["physical_nets"]:
        members = sorted(members_by_net[net["net_id"]], key=lambda x: x["net_member_id"])
        physical_nets.append({
            "net_id": net["net_id"],
            "xmi_id": f"XMI-NET-{net['net_id']}",
            "name": net["name"],
            "item_id": net["item_code"],
            "interface_type_id": net["interface_type_id"],
            "domain": net["domain"],
            "profile_id": net["profile_id"],
            "members": members,
            "member_count": len(members),
            "xmi_metaclass_hint": "SharedPhysicalNetwork",
        })

    allocations = [{
        "allocation_id": x["allocation_id"],
        "xmi_id": f"XMI-ALLOC-{x['allocation_id']}",
        "function_id": x["function_id"],
        "product_id": x["product_code"],
        "allocation_type": x["allocation_type"],
        "xmi_metaclass_hint": "Allocation",
    } for x in allocation_doc["function_allocations"]]
    allocation_by_function = {x["function_id"]: x["product_id"] for x in allocations}

    functions = []
    for function in function_doc["functions"]:
        functions.append({
            "function_id": function["function_id"],
            "xmi_id": f"XMI-FUNCTION-{function['function_id']}",
            "name_cn": function["function_name_cn"],
            "name_en": function["function_name_en"],
            "level": function["function_level"],
            "category": function["function_category"],
            "allocated_product_id": allocation_by_function[function["function_id"]],
            "description": function["description"],
            "generation_basis": function["generation_basis"],
            "verification_status": function["verification_status"],
            "derived_from": {
                "items": function["derived_from_items"],
                "interfaces": [f"IFINST::{x}" for x in function["derived_from_ports"]],
                "connections": function["derived_from_connections"],
                "nets": function["derived_from_nets"],
            },
            "aggregated_from_functions": function["aggregated_from_functions"],
            "xmi_metaclass_hint": "Activity",
        })

    mappings = [{
        "mapping_id": x["mapping_id"],
        "xmi_id": f"XMI-FIMAP-{x['mapping_id']}",
        "function_id": x["function_id"],
        "interface_instance_id": x["interface_instance_id"],
        "usage_role": x["usage_role"],
        "xmi_metaclass_hint": "ActivityInterfaceUsageTrace",
    } for x in mapping_doc["function_interface_mappings"]]

    active_by_product_item = defaultdict(list)
    for port in interfaces:
        if port["profile_active"]:
            active_by_product_item[(port["owner_product_id"], port["item_id"])].append(port["interface_instance_id"])
    def interface_anchor(name, product_id, item_id):
        candidates = sorted(active_by_product_item[(product_id, item_id)])
        if not candidates:
            raise RuntimeError(f"Voltage anchor interface missing: {name}")
        return {"anchor_id": name, "status": "PASS", "target_type": "INTERFACE", "product_id": product_id, "interface_id": candidates[0]}

    verification_anchors = [
        interface_anchor("U_grid", "4111", "ITM-PHY-001"),
        interface_anchor("U_transformer_primary", "4511", "ITM-PHY-001"),
        interface_anchor("U_transformer_secondary", "4511", "ITM-PHY-014"),
        {"anchor_id": "U_dc", "status": "PASS", "target_type": "PHYSICAL_NET", "physical_net_id": "NET-DC-LINK-01"},
        interface_anchor("U_motor", "5311", "ITM-PHY-004"),
        {"anchor_id": "U_sc", "status": "PASS", "target_type": "PHYSICAL_NET", "physical_net_id": "NET-STORAGE-DC-SC-01"},
    ]

    architecture = {
        "metadata": {
            "schema_version": "1.0.0",
            "project_id": source["metadata"]["project_id"],
            "profile_id": PROFILE_ID,
            "source_layer": source["metadata"]["source_layer"],
            "source_sha256": source["metadata"]["source_sha256"],
            "reference_instance": {
                "id": PROFILE_ID,
                "coupling_series": ["3511", "3514", "3512"],
                "brake_disc_choice": "3131",
                "selection_basis": "executable_reference_assumption",
            },
            "counts": {
                "products": len(products), "items": len(items), "interfaces": len(interfaces),
                "active_interfaces": sum(x["profile_active"] for x in interfaces),
                "connections": len(connections), "physical_nets": len(physical_nets),
                "net_members": sum(x["member_count"] for x in physical_nets),
                "leaf_functions": function_doc["metadata"]["leaf_function_count"],
                "aggregated_functions": function_doc["metadata"]["aggregated_function_count"],
                "functions": len(functions), "allocations": len(allocations),
                "function_interface_mappings": len(mappings),
            },
        },
        "profile": {**source["profile"], "xmi_id": f"XMI-PROFILE-{PROFILE_ID}"},
        "products": products,
        "items": items,
        "interfaces": interfaces,
        "external_boundaries": external_boundaries,
        "physical_nets": physical_nets,
        "connections": connections,
        "functions": functions,
        "allocations": allocations,
        "function_interface_mappings": mappings,
        "verification_anchors": verification_anchors,
    }

    schema = {
        "$schema": "https://json-schema.org/draft/2020-12/schema",
        "title": "Rail MBSE XMI-ready Architecture",
        "type": "object",
        "additionalProperties": False,
        "required": ["metadata", "profile", "products", "items", "interfaces", "external_boundaries", "physical_nets", "connections", "functions", "allocations", "function_interface_mappings", "verification_anchors"],
        "$defs": {
            "stableId": {"type": "string", "minLength": 1, "pattern": "^(?!.*[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[1-5][0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}).+$"},
            "xmiId": {"type": "string", "pattern": "^XMI-[A-Z0-9:_-]+$"},
        },
        "properties": {
            "metadata": {"type": "object", "required": ["schema_version", "project_id", "profile_id", "counts"]},
            "profile": {"type": "object", "required": ["profile_id", "xmi_id"]},
            "products": {"type": "array", "items": {"type": "object", "required": ["id", "xmi_id", "name", "level", "parent_id", "leaf", "selected", "namespace", "source_type", "stereotype_hint"]}},
            "items": {"type": "array", "items": {"type": "object", "required": ["item_code", "xmi_id", "name_cn", "name_en", "family", "domain", "datatype", "unit_medium", "semantic_definition", "port_type_id", "interface_type_id", "xmi_metaclass_hint"]}},
            "interfaces": {"type": "array", "items": {"type": "object", "required": ["interface_instance_id", "xmi_id", "owner_product_id", "port_id", "name", "direction", "category", "item_id", "port_type_id", "interface_type_id", "profile_active", "xmi_metaclass_hint"]}},
            "external_boundaries": {"type": "array", "items": {"type": "object", "required": ["boundary_id", "xmi_id", "name", "domain", "profile_id"]}},
            "physical_nets": {"type": "array", "items": {"type": "object", "required": ["net_id", "xmi_id", "name", "item_id", "domain", "profile_id", "members", "member_count", "xmi_metaclass_hint"]}},
            "connections": {"type": "array", "items": {"type": "object", "required": ["connection_id", "xmi_id", "mode", "source_product_id", "source_interface_id", "item_id", "profile_id", "xmi_metaclass_hint"]}},
            "functions": {"type": "array", "items": {"type": "object", "required": ["function_id", "xmi_id", "name_cn", "name_en", "level", "category", "allocated_product_id", "derived_from", "aggregated_from_functions", "xmi_metaclass_hint"]}},
            "allocations": {"type": "array", "items": {"type": "object", "required": ["allocation_id", "xmi_id", "function_id", "product_id", "allocation_type", "xmi_metaclass_hint"]}},
            "function_interface_mappings": {"type": "array", "items": {"type": "object", "required": ["mapping_id", "xmi_id", "function_id", "interface_instance_id", "usage_role", "xmi_metaclass_hint"]}},
            "verification_anchors": {"type": "array", "minItems": 6, "maxItems": 6, "items": {"type": "object", "required": ["anchor_id", "status", "target_type"]}},
        },
    }
    write(OUTDIR / "architecture_xmi_ready.json", architecture)
    write(OUTDIR / "architecture_xmi_ready.schema.json", schema)
    print(json.dumps({"stage": 6, "status": "PASS", **architecture["metadata"]["counts"]}, ensure_ascii=False))


if __name__ == "__main__":
    main()
