from __future__ import annotations

import json
from pathlib import Path


PIPELINE_DIR = Path(__file__).resolve().parent
ROOT = PIPELINE_DIR.parents[1]
WORK_DIR = PIPELINE_DIR / "work"
REPORTS_DIR = ROOT / "reports"


def load(name: str) -> dict:
    return json.loads((WORK_DIR / name).read_text(encoding="utf-8"))


def compact_stereotype(detail: dict) -> dict:
    base_fields = [a for a in detail["all_attributes"] if a["name"].startswith("base_")]
    semantic_fields = [a for a in detail["all_attributes"] if not a["name"].startswith("base_")]
    return {
        "xmi_id": detail["xmi_id"],
        "name": detail["name"],
        "qualified_name": detail["qualified_name"],
        "generalizations": detail["generalizations"],
        "extension_ids": detail["extension_ids"],
        "base_fields": base_fields,
        "semantic_fields": semantic_fields,
    }


def build_contract() -> dict:
    inventory = load("standards_inventory.json")
    parsed = load("sysml17_profile_parse.json")
    stereotypes = parsed["stereotypes"]
    selected = {
        key.split(".")[-1]: compact_stereotype(stereotypes[key])
        for key in (
            "SysML.Block", "SysML.InterfaceBlock", "SysML.ProxyPort", "SysML.FlowProperty",
            "SysML.ItemFlow", "SysML.Allocate", "SysML.NestedConnectorEnd",
            "SysML.tildeInterfaceBlock",
        )
    }
    uml_fields = parsed["uml_metamodel"]["metaclass_owned_attributes"]
    return {
        "contract_id": "RAIL-MBSE-SYSML17-MAPPING-CONTRACT-V1",
        "normative_sources": {
            "sysml_profile": parsed["sysml_profile"],
            "uml_metamodel": parsed["uml_metamodel"],
            "primitive_types": parsed["primitive_types"],
            "standard_profile": parsed["standard_profile"],
            "xmi_schema": parsed["xmi_schema"],
            "sysml_di": inventory["recognized_roles"].get("sysml_di_profile", []),
            "pdf_audit": {
                "sysml_1_7_pdf_found": bool(inventory["sysml_1_7_specification_pdfs"]),
                "version_mismatches": inventory["version_mismatched_pdfs"],
                "decision": "Use local normative SysML.xmi; the available PDF is not a SysML 1.7 source.",
            },
            "cameo_golden_sample": inventory["golden_sample_status"],
        },
        "versions": {
            "sysml": "1.7 (identified by OMG SysML profile URI date 20240101)",
            "sysml_namespace_uri": parsed["sysml_profile"]["namespace_declarations"].get("SysML"),
            "sysml_profile_uri": parsed["sysml_profile"]["URI"],
            "uml": "2.5.1",
            "uml_metamodel_uri": parsed["uml_metamodel"]["URI"],
            "uml_namespace_uri_for_sysml_exchange": parsed["sysml_profile"]["namespace_declarations"].get("uml"),
            "primitive_types_uri": parsed["primitive_types"]["URI"],
            "standard_profile_uri": parsed["standard_profile"]["URI"],
            "xmi_namespace_uri": parsed["xmi_serialization"]["namespace"],
            "xmi_namespace_date": parsed["xmi_serialization"]["namespace_date"],
            "xmi_root_version_attribute_in_normative_profile": parsed["xmi_serialization"]["root_version_attribute"],
        },
        "profile_application": {
            "profile_xmi_id": parsed["sysml_profile"]["xmi_id"],
            "profile_uri": parsed["sysml_profile"]["URI"],
            "local_href_from_work_output": "../SysML/SysML.xmi#SysML",
            "representation": "uml:ProfileApplication/appliedProfile@href",
        },
        "stereotype_application_serialization": {
            "placement": "top-level children of xmi:XMI after uml:Model",
            "metaclass_and_model_reference_fields": "nested property elements with xmi:idref, matching stereotype applications embedded in local SysML.xmi",
            "datatype_and_enumeration_fields": "XML attributes",
        },
        "stereotypes": selected,
        "flow_direction_literals": parsed["flow_direction_literals"],
        "conjugation": {
            "uml_port_has_isConjugated": parsed["uml_metamodel"]["port_has_isConjugated"],
            "normative_constraint": parsed["conjugation_evidence"],
            "decision": "All InterfaceBlock-typed ports use isConjugated=false. Signal input ports are typed by deterministic standard ~InterfaceBlock classifiers whose reversed in feature is derived from the canonical out FlowProperty through the standard original reference. Physical FlowProperty is inout.",
        },
        "element_mapping": {
            "Product": "uml:Class + SysML::Block",
            "SystemContext": "uml:Class + SysML::Block (modeling context, not Product)",
            "ProductHierarchy": "uml:Property with aggregation=composite",
            "InterfaceDefinition": "uml:Class + SysML::InterfaceBlock",
            "ConjugatedInterfaceDefinition": "uml:Class + SysML::~InterfaceBlock",
            "PortInstance": "uml:Port + SysML::ProxyPort",
            "InterfaceFlowSemantic": "uml:Property + SysML::FlowProperty",
            "SignalItem": "uml:Signal",
            "PhysicalItem": "uml:DataType",
            "Function": "uml:Activity",
            "Allocation": "uml:Abstraction + SysML::Allocate",
            "FinalConnection": "uml:Connector",
            "SignalFlow": "uml:InformationFlow + SysML::ItemFlow",
            "PhysicalNet": "one standard n-ary uml:Connector; no custom stereotype and no pairwise clique",
            "FunctionInterface": "Activity ownedParameter plus standard uml:Dependency from Parameter to Port",
            "VoltageAnchor": "standard uml:Comment annotatedElement pointing to Port or network Connector",
            "ExternalBoundary": "uml:Class + SysML::Block modeling artifact; context reference Property is non-composite",
        },
        "connector_ownership": {
            "owner": "lowest common ancestor Product Block, or System Context",
            "direct_end": "ConnectorEnd.role references Port and partWithPort references the direct part Property",
            "nested_end": "SysML::NestedConnectorEnd with inherited propertyPath ordered from connector owner to the part whose type owns the Port",
            "evidence": parsed["nested_connector_evidence"],
        },
        "item_flow": {
            "scope": "SIGNAL connectors only",
            "uml_information_flow_fields_from_UML_xmi": uml_fields["InformationFlow"],
            "selected_uml_fields": ["informationSource", "informationTarget", "conveyed", "realizingConnector"],
            "sysml_item_flow_fields_from_SysML_xmi": selected["ItemFlow"]["base_fields"] + selected["ItemFlow"]["semantic_fields"],
            "selected_sysml_fields": ["base_InformationFlow", "itemProperty"],
            "directed_property_path_note": "Local SysML.xmi defines no ItemFlow generalization to DirectedRelationshipPropertyPath; source/target and realizingConnector are therefore carried by the base UML InformationFlow.",
            "itemProperty": "canonical InterfaceBlock FlowProperty typed by the conveyed Item classifier",
        },
        "uml_metaclass_fields": {
            "Connector": uml_fields["Connector"],
            "ConnectorEnd": uml_fields["ConnectorEnd"],
            "Port": uml_fields["Port"],
            "Abstraction": uml_fields["Abstraction"],
            "Activity": uml_fields["Activity"],
            "Parameter": uml_fields["Parameter"],
        },
        "prohibitions": [
            "No project-defined stereotype definitions or applications",
            "No Dependency in place of Product composition",
            "No pairwise expansion of PhysicalNet",
            "No UUID, random number, or timestamp identifiers",
            "No physical connector converted into a directed signal ItemFlow",
        ],
    }


def write_markdown(contract: dict, path: Path) -> None:
    versions = contract["versions"]
    stereo_lines = []
    for name, detail in contract["stereotypes"].items():
        bases = ", ".join(f"{x['name']} → {x['type']}" for x in detail["base_fields"]) or "inherited/no direct extension"
        stereo_lines.append(f"- `{detail['qualified_name']}` (`{detail['xmi_id']}`): {bases}")
    pdf = contract["normative_sources"]["pdf_audit"]
    content = f"""# SysML 1.7 mapping contract

- SysML Profile URI: `{versions['sysml_profile_uri']}`
- SysML namespace: `{versions['sysml_namespace_uri']}`
- UML: `{versions['uml']}`; metamodel URI `{versions['uml_metamodel_uri']}`
- XMI namespace: `{versions['xmi_namespace_uri']}` (normative root has no `xmi:version` attribute)
- PrimitiveTypes URI: `{versions['primitive_types_uri']}`
- StandardProfile URI: `{versions['standard_profile_uri']}`
- ProfileApplication href: `{contract['profile_application']['local_href_from_work_output']}`

## Normative stereotype fields

{chr(10).join(stereo_lines)}

## Serialization decisions

- Product hierarchy uses 139 composite properties plus 8 Context-to-L1 composite properties.
- All 517 ports are `uml:Port` + standard `ProxyPort`.
- The profile forbids UML Port `isConjugated=true` for InterfaceBlock-typed ports. Signal inputs therefore use deterministic standard `~InterfaceBlock` types; physical flows remain `inout`.
- Final connections are LCA-owned connectors. Multi-level ends use standard `NestedConnectorEnd.propertyPath`.
- Each SIGNAL connector has one directed UML InformationFlow plus standard ItemFlow. Physical connectors do not receive a fake directed ItemFlow.
- Each PhysicalNet is one n-ary UML Connector, preserving shared-network semantics without a clique.
- Function-interface mappings use Activity parameters and standard UML Dependencies; no custom stereotype is introduced.

## Source audit

- Cameo/MagicDraw golden sample: `{contract['normative_sources']['cameo_golden_sample']}`.
- SysML 1.7 PDF present: `{pdf['sysml_1_7_pdf_found']}`.
- The available specification PDF was detected as SysML 2.0 and is not used as the 1.7 serialization authority.
"""
    path.write_text(content, encoding="utf-8")


def main() -> None:
    WORK_DIR.mkdir(parents=True, exist_ok=True)
    REPORTS_DIR.mkdir(parents=True, exist_ok=True)
    contract = build_contract()
    json_path = WORK_DIR / "sysml17_mapping_contract.json"
    report_path = REPORTS_DIR / "sysml17_mapping_contract.md"
    json_path.write_text(json.dumps(contract, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    write_markdown(contract, report_path)
    print(f"Mapping contract: {json_path}")
    print(f"Mapping report: {report_path}")


if __name__ == "__main__":
    main()
