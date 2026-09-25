from __future__ import annotations

import hashlib
import json
from collections import Counter
from pathlib import Path


PIPELINE_DIR = Path(__file__).resolve().parent
ROOT = PIPELINE_DIR.parents[1]
SOURCE = ROOT / "work" / "architecture_xmi_ready_v1.json"
PIPELINE_WORK = PIPELINE_DIR / "work"
COMPATIBILITY = PIPELINE_WORK / "magicdraw2022x_compatibility_contract.json"


def stable_id(prefix: str, seed: str, length: int = 18) -> str:
    digest = hashlib.sha1(seed.encode("utf-8")).hexdigest()[:length].upper()
    return f"{prefix}-{digest}"


def write_json(path: Path, value: object) -> None:
    path.write_text(json.dumps(value, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


def resolve_direction(raw: str) -> str:
    mapping = {
        "输入": "in",
        "输出": "out",
        "双向物理": "inout",
        "in": "in",
        "out": "out",
        "inout": "inout",
    }
    return mapping.get(raw, "unknown")


def build() -> dict:
    architecture = json.loads(SOURCE.read_text(encoding="utf-8"))
    compatibility = json.loads(COMPATIBILITY.read_text(encoding="utf-8"))
    products = architecture["products"]
    interfaces = architecture["interfaces"]
    product_ids = {product["id"] for product in products}
    hierarchy = sorted(
        (
            {
                "parent_product_id": product["parent_id"],
                "child_product_id": product["id"],
                "owner_block_xmi_id": next(p["xmi_id"] for p in products if p["id"] == product["parent_id"]),
                "child_block_xmi_id": product["xmi_id"],
                "part_property_name": f"part_{product['id']}",
                "part_property_xmi_id": stable_id("XMI-PART", f"STRUCTURE-V2::{product['parent_id']}::{product['id']}"),
                "aggregation": "composite",
            }
            for product in products
            if product.get("parent_id") is not None
        ),
        key=lambda row: (row["parent_product_id"], row["child_product_id"]),
    )

    direction_records = []
    for interface in sorted(interfaces, key=lambda row: row["interface_instance_id"]):
        effective = resolve_direction(interface["direction"])
        projection_seed = "::".join(
            (interface["interface_type_id"], interface["item_id"], effective)
        )
        direction_records.append(
            {
                "port_id": interface["port_id"],
                "interface_instance_id": interface["interface_instance_id"],
                "product_id": interface["owner_product_id"],
                "port_name": interface["name"],
                "raw_direction": interface["direction"],
                "canonical_interface_type_id": interface["interface_type_id"],
                "canonical_item_id": interface["item_id"],
                "interface_block_id": stable_id("XMI-IB-DIR", projection_seed),
                "flow_property_id": stable_id("XMI-FLOWPROPERTY-DIR", projection_seed),
                "flow_property_direction": effective,
                "effective_port_direction": effective,
                "resolution_method": "STANDARD_DIRECTIONAL_INTERFACEBLOCK_FLOWPROPERTY",
                "exposed_upward": False,
            }
        )
    counts = Counter(record["effective_port_direction"] for record in direction_records)
    projections = {
        (record["interface_block_id"], record["flow_property_id"])
        for record in direction_records
    }
    direction_output = {
        "contract_id": "RAIL-MBSE-PORT-DIRECTION-RESOLUTION-V2",
        "source": str(SOURCE),
        "method": (
            "Each frozen Port is typed by a deterministic standard SysML InterfaceBlock "
            "directional projection containing one standard FlowProperty. No direction "
            "attribute is added to uml:Port."
        ),
        "statistics": {
            "total": len(direction_records),
            "input": counts["in"],
            "output": counts["out"],
            "inout": counts["inout"],
            "unknown": counts["unknown"],
            "unique_interface_block_projections": len(projections),
        },
        "records": direction_records,
    }
    write_json(PIPELINE_WORK / "port_direction_resolution.json", direction_output)

    active_preview = compatibility["reference_architecture_realization"]
    structure_contract = {
        "contract_id": "RAIL-MBSE-SYSML17-STRUCTURE-MAPPING-V2",
        "frozen_source": str(SOURCE),
        "target": "OMG SysML 1.7 / UML 2.5.1 with MagicDraw 2022x compatible serialization",
        "product_definition": {
            "count": len(products),
            "uml_metaclass": "uml:Class",
            "standard_stereotype": "SysML::Block",
            "xmi_id_source": "products[].xmi_id",
            "allowed_for_every_level_and_leaf_shape": True,
            "forbidden_metaclasses": [
                "uml:Signal", "uml:DataType", "uml:Property", "uml:Port", "uml:InstanceSpecification"
            ],
        },
        "product_hierarchy": {
            "source": "products[].parent_id",
            "relationship_count": len(hierarchy),
            "unique_key": ["parent_product_id", "child_product_id"],
            "uml_owner": "Parent Product uml:Class",
            "uml_feature": "ownedAttribute / uml:Property",
            "property_name": "part_<child_product_id>",
            "property_type": "Child Product uml:Class xmi_id only",
            "aggregation": "composite",
            "multiplicity": "[1]",
            "forbidden_property_types": ["Signal", "Item", "InterfaceBlock", "FlowProperty", "PortType"],
            "relationships": hierarchy,
        },
        "feature_separation": {
            "part_property": {
                "uml_metaclass": "uml:Property",
                "owner": "Parent Product Block",
                "type": "Child Product Block",
                "aggregation": "composite",
            },
            "proxy_port": {
                "uml_metaclass": "uml:Port",
                "standard_stereotype": "SysML::ProxyPort",
                "owner": "Port owner Product Block",
                "type": "standard SysML InterfaceBlock directional projection",
            },
        },
        "port_direction": {
            "record_count": len(direction_records),
            "projection_count": len(projections),
            "raw_to_effective": {"输入": "in", "输出": "out", "双向物理": "inout"},
            "representation": "standard InterfaceBlock with standard FlowProperty.direction",
            "uml_port_direction_attribute": "FORBIDDEN",
            "canonical_trace_fields": ["canonical_interface_type_id", "canonical_item_id"],
            "unknown_allowed": False,
            "resolution_file": str(PIPELINE_WORK / "port_direction_resolution.json"),
        },
        "bdd_projection": {
            "purpose": "Block definitions, direct hierarchy composition, optional Port compartments",
            "block_symbol_unique_key": ["diagram_id", "product_id"],
            "composition_symbol_unique_key": ["diagram_id", "parent_product_id", "child_product_id"],
            "draw_part_as_second_block_symbol": False,
            "allowed_relationships": ["STRUCTURAL_COMPOSITION"],
            "forbidden_content": ["Connector", "InformationFlow", "ItemFlow", "PhysicalNet", "Function_Interface"],
            "templates": [
                {"diagram_id": "BDD_L1_System", "root": "System Context", "direct_products": ["3000", "4000", "5000", "7000", "8000", "D000", "E000", "X000"]},
                {"diagram_id": "BDD_5000_Traction", "root_product": "5000", "direct_children_only": True},
                {"diagram_id": "BDD_5100", "root_product": "5100", "direct_children_only": True},
            ],
        },
        "ibd_projection": {
            "frame": "one Product Block",
            "internal_parts": "only direct owned composite Part Properties",
            "part_symbol_type": "Child Product Block",
            "block_definitions_inside_frame": "FORBIDDEN_AS_INSTANCE_SYMBOL",
            "connections": "ConnectGraph Final Connection, keyed by connection_id",
            "signal_flow": "one InformationFlow + one standard ItemFlow per SIGNAL connection",
            "physical_flow": "Connector with inout interfaces; no forced one-way flow",
            "upward_interface_promotion": "DEFERRED",
            "exposed_upward_default": False,
        },
        "solution_space_and_reference": {
            "product_library_block_definitions": len(products),
            "reference_active_product_preview_count": active_preview["reference_active_product_preview_count"],
            "omitted_reference_product_ids": active_preview["omitted_reference_product_ids"],
            "rule": active_preview["rule"],
            "note": "This task does not publish a new full XMI or infer upward parent Ports.",
        },
        "frozen_baseline": {
            "products": len(products),
            "hierarchy_relationships": len(hierarchy),
            "interfaces": len(interfaces),
            "connections": len(architecture["connections"]),
            "signal_connections": sum(c["mode"] == "SIGNAL" for c in architecture["connections"]),
            "physical_nets": len(architecture["physical_nets"]),
            "allocations": len(architecture["allocations"]),
        },
        "invariants": {
            "all_parent_ids_resolve": all(p.get("parent_id") is None or p["parent_id"] in product_ids for p in products),
            "hierarchy_unique": len({(h["parent_product_id"], h["child_product_id"]) for h in hierarchy}) == len(hierarchy),
            "all_port_owners_resolve": all(i["owner_product_id"] in product_ids for i in interfaces),
            "all_port_directions_resolve": counts["unknown"] == 0,
        },
    }
    write_json(PIPELINE_WORK / "structure_mapping_contract_v2.json", structure_contract)

    relationship_contract = {
        "contract_id": "RAIL-MBSE-BLOCK-RELATIONSHIP-CONTRACT-V2",
        "principle": "One engineering semantic has one authoritative model representation; diagrams are projections only.",
        "relationships": {
            "A_STRUCTURAL_COMPOSITION": {
                "source": "Product parent_id",
                "representation": "Parent Block owns composite uml:Property typed only by Child Block",
                "model_unique_key": ["parent_product_id", "child_product_id"],
                "diagram_scope": "BDD and owning Block IBD part compartment",
                "forbidden_parallel_forms": ["Association", "Dependency", "duplicate Property", "duplicate Composition"],
            },
            "B_INTERFACE_CONNECTION": {
                "source": "Final ConnectGraph Connection",
                "representation": "uml:Connector between Part/ProxyPort endpoints",
                "model_unique_key": ["connection_id"],
                "duplicate_equivalence_key": ["source_port_id", "target_port_id", "item_code", "mode"],
                "diagram_scope": "IBD only",
            },
            "C_ITEM_FLOW": {
                "source": "SIGNAL Final Connection",
                "representation": "one uml:InformationFlow + one SysML::ItemFlow realized by Connector",
                "model_unique_key": ["connection_id"],
                "direction": "source effective out -> target effective in",
                "diagram_scope": "IBD only",
            },
            "D_PHYSICAL_CONNECTION": {
                "source": "physical SERIES/TAP/BOUNDARY Final Connection",
                "representation": "uml:Connector with inout ProxyPort interface semantics",
                "direction": "inout",
                "forbidden": "unidirectional Block relationship",
                "diagram_scope": "IBD only",
            },
            "E_ALLOCATION": {
                "source": "Function Allocation",
                "representation": "uml:Abstraction + standard SysML::Allocate",
                "model_unique_key": ["allocation_id"],
                "structural_relationship": False,
                "diagram_scope": "Allocation/behavior views only",
            },
            "F_EXTERNAL_BOUNDARY": {
                "source": "ExternalBoundary",
                "representation": "reference property or standard modeling Block",
                "product_composite_child": False,
                "diagram_scope": "System context IBD",
            },
        },
        "physical_net": {
            "count": len(architecture["physical_nets"]),
            "representation": "one shared standard network construct per net_id",
            "unique_key": ["net_id"],
            "pairwise_clique_generation": "FORBIDDEN",
            "real_final_series_or_tap_connectors_remain_allowed": True,
        },
        "diagram_guards": {
            "BDD_connector_count": 0,
            "BDD_itemflow_count": 0,
            "BDD_block_symbol_key": ["diagram_id", "product_id"],
            "IBD_direct_part_only": True,
        },
    }
    write_json(PIPELINE_WORK / "block_relationship_contract.json", relationship_contract)

    return {
        "products": len(products),
        "hierarchy": len(hierarchy),
        "directions": direction_output["statistics"],
    }


def main() -> None:
    result = build()
    print(json.dumps(result, ensure_ascii=False))


if __name__ == "__main__":
    main()
