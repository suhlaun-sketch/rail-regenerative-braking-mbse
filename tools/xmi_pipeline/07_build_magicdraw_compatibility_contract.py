from __future__ import annotations

import json
from pathlib import Path


PIPELINE_DIR = Path(__file__).resolve().parent
ROOT = PIPELINE_DIR.parents[1]
WORK_DIR = PIPELINE_DIR / "work"
ARCHITECTURE = ROOT / "work" / "architecture_xmi_ready_v1.json"
REFERENCE_CONFIG = ROOT / "tools" / "topology_pipeline" / "config" / "reference_instance.yaml"


def reference_realization_preview(architecture: dict) -> dict:
    products = {p["id"]: p for p in architecture["products"]}
    config = json.loads(REFERENCE_CONFIG.read_text(encoding="utf-8"))
    active_ports = {i["owner_product_id"] for i in architecture["interfaces"] if i["profile_active"]}
    connected = {
        product
        for connection in architecture["connections"]
        for product in (connection.get("source_product_id"), connection.get("target_product_id"))
        if product
    }
    net_members = {m["product_id"] for net in architecture["physical_nets"] for m in net["members"]}
    selected_disc = config["brake_disc_resolution"]["selected_product"]
    disc_solution_space = set(config["brake_disc_resolution"]["retained_solution_space"])
    selected_coupling = set(config["coupling_resolution"]["assembly_order"])
    selected = active_ports | connected | net_members | {selected_disc} | selected_coupling
    excluded = disc_solution_space - {selected_disc}
    selected -= excluded

    dc_candidate = "4121"
    dc_evidence = {
        "active_interfaces": sum(i["owner_product_id"] == dc_candidate and i["profile_active"] for i in architecture["interfaces"]),
        "final_connections": sum(dc_candidate in (c.get("source_product_id"), c.get("target_product_id")) for c in architecture["connections"]),
        "net_memberships": sum(m["product_id"] == dc_candidate for n in architecture["physical_nets"] for m in n["members"]),
    }
    if not any(dc_evidence.values()):
        selected.discard(dc_candidate)
        excluded.add(dc_candidate)

    for code in list(selected):
        current = code
        while products[current].get("parent_id") in products:
            current = products[current]["parent_id"]
            selected.add(current)
    return {
        "profile_id": config["profile_id"],
        "product_library_definitions": len(products),
        "reference_active_product_preview_count": len(selected),
        "selected_product_ids": sorted(selected),
        "omitted_reference_product_ids": sorted(set(products) - selected),
        "excluded_solution_space_product_ids": sorted(excluded),
        "brake_disc_choice": config["brake_disc_resolution"],
        "coupling_assembly": config["coupling_resolution"],
        "dc_4121_evidence": dc_evidence,
        "rule": "Final Connection/Net use or active profile port or explicit reference selection, plus necessary ancestors; explicit unselected variants remain Block definitions only.",
        "full_xmi_published": False,
    }


def build_contract() -> dict:
    inventory = json.loads((WORK_DIR / "magicdraw_profile_inventory.json").read_text(encoding="utf-8"))
    old = json.loads((WORK_DIR / "sysml17_mapping_contract.json").read_text(encoding="utf-8"))
    architecture = json.loads(ARCHITECTURE.read_text(encoding="utf-8"))
    template = inventory["magicdraw_sysml_template"]
    builtin = inventory["builtin_sysml_profile"]
    return {
        "contract_id": "RAIL-MBSE-SYSML17-MAGICDRAW-2022X-COMPAT-V3",
        "target_tool": "MagicDraw 2022x",
        "sysml_plugin_version": inventory["sysml_plugin"]["version"],
        "namespace_separation": {
            "xmi_xml_namespace": template["xmi_xml_namespace"],
            "uml_xml_namespace": template["uml_xml_namespace"],
            "uml_metamodel_uri": old["versions"]["uml_metamodel_uri"],
            "uml_metamodel_href": "http://www.omg.org/spec/UML/20131001/UML.xmi",
            "omg_sysml17_authority_profile_uri": old["versions"]["sysml_profile_uri"],
            "sysml_profile_uri": builtin["profile_uri"],
            "sysml_profile_href": template["applied_profile_href"],
            "sysml_stereotype_namespace": builtin["stereotype_namespace"],
            "standard_profile_namespace": template["standard_profile_namespace"],
        },
        "profile_resolution_strategy": {
            "strategy": "MAGICDRAW_BUILTIN_OMG_SYSML17_PROFILE",
            "applied_profile_href": template["applied_profile_href"],
            "reason": "The installed MagicDraw 2022x SysML template uses this href and resolves it to the installed SysML Profile.mdzip documented as OMG SysML 1.7 profile for MagicDraw.",
            "fallback_not_used": "../SysML/SysML.xmi#SysML",
            "builtin_profile_project_ids": builtin["project_ids"],
            "builtin_profile_xmi_id": builtin["profile_xmi_id"],
        },
        "magicdraw_serialization": {
            "stereotype_application_placement": "top-level children of xmi:XMI after uml:Model",
            "stereotype_references": "MagicDraw 2022x sample form: base_* and propertyPath as XML attributes",
            "nested_connector_end": "base_ConnectorEnd + ordered space-separated propertyPath; ConnectorEnd.role is leaf Port and partWithPort is final part Property",
            "documentation": "omit xmi:Documentation exporter; do not claim MagicDraw exporter",
            "port_isConjugated": False,
            "input_direction": "standard ~InterfaceBlock original reference; effective FlowProperty direction=in",
        },
        "semantic_authority": {
            "source": str(ROOT / "SysML" / "SysML.xmi"),
            "rule": "OMG profile defines semantics; installed MagicDraw resources define compatible namespace/profile resolution and serialization form.",
        },
        "reference_architecture_realization": reference_realization_preview(architecture),
        "frozen_baseline": {
            "products": len(architecture["products"]),
            "interfaces": len(architecture["interfaces"]),
            "active_interfaces": sum(i["profile_active"] for i in architecture["interfaces"]),
            "connections": len(architecture["connections"]),
            "physical_nets": len(architecture["physical_nets"]),
            "functions": len(architecture["functions"]),
            "allocations": len(architecture["allocations"]),
            "function_interface_mappings": len(architecture["function_interface_mappings"]),
        },
        "release_gate": "Probe must pass MagicDraw 2022x hands-on import before any new full XMI is published.",
    }


def main() -> None:
    contract = build_contract()
    out = WORK_DIR / "magicdraw2022x_compatibility_contract.json"
    out.write_text(json.dumps(contract, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(f"Compatibility contract: {out}")
    print(f"Profile resolution: {contract['profile_resolution_strategy']['strategy']}")


if __name__ == "__main__":
    main()
