from __future__ import annotations

import json
import xml.etree.ElementTree as ET
from pathlib import Path


PIPELINE_DIR = Path(__file__).resolve().parent
ROOT = PIPELINE_DIR.parents[1]
WORK_DIR = PIPELINE_DIR / "work"
SYSML_PATH = ROOT / "SysML" / "SysML.xmi"
UML_PATH = ROOT / "SysML" / "UML.xmi"
PRIMITIVE_PATH = ROOT / "SysML" / "UMLpre.xmi"
STANDARD_PATH = ROOT / "SysML" / "umlstandard.xmi"
XMI_XSD_PATH = ROOT / "SysML" / "XMI.xsd"


def local_name(tag: str) -> str:
    return tag.rsplit("}", 1)[-1]


def xmi_attr(element: ET.Element, name: str) -> str | None:
    for namespace in ("https://www.omg.org/spec/XMI/20131001", "http://www.omg.org/spec/XMI/20131001"):
        value = element.get(f"{{{namespace}}}{name}")
        if value is not None:
            return value
    return element.get(f"xmi:{name}")


def namespace_declarations(path: Path) -> dict[str, str]:
    result: dict[str, str] = {}
    for _event, pair in ET.iterparse(path, events=("start-ns",)):
        prefix, uri = pair
        result[prefix or "default"] = uri
    return result


def index_by_id(root: ET.Element) -> dict[str, ET.Element]:
    return {identifier: element for element in root.iter() if (identifier := xmi_attr(element, "id"))}


def child_ref(element: ET.Element, child_name: str) -> str | None:
    child = next((c for c in element if local_name(c.tag) == child_name), None)
    return xmi_attr(child, "idref") if child is not None else None


def type_ref(attribute: ET.Element) -> str | None:
    child = next((c for c in attribute if local_name(c.tag) == "type"), None)
    if child is None:
        return attribute.get("type")
    return xmi_attr(child, "idref") or child.get("href")


def stereotype_detail(identifier: str, ids: dict[str, ET.Element], root: ET.Element) -> dict:
    element = ids[identifier]
    generalizations = []
    for child in element:
        if local_name(child.tag) == "generalization":
            ref = child.get("general") or child_ref(child, "general")
            if ref:
                generalizations.append(ref)
    attributes = []
    for child in element:
        if local_name(child.tag) != "ownedAttribute":
            continue
        attributes.append({
            "id": xmi_attr(child, "id"),
            "name": child.get("name"),
            "type": type_ref(child),
            "read_only": child.get("isReadOnly") == "true",
        })
    extension_ids = []
    for candidate in root.iter():
        if xmi_attr(candidate, "type") != "uml:Extension":
            continue
        member_refs = [xmi_attr(c, "idref") for c in candidate if local_name(c.tag) == "memberEnd"]
        if any(ref and ref.startswith(identifier + ".base_") for ref in member_refs):
            extension_ids.append(xmi_attr(candidate, "id"))
    comments = []
    for child in element.iter():
        if local_name(child.tag) == "ownedComment":
            body = child.get("body")
            if body:
                comments.append(" ".join(body.split()))
    return {
        "xmi_id": identifier,
        "name": element.get("name"),
        "qualified_name": f"SysML::{element.get('name')}",
        "generalizations": generalizations,
        "owned_attributes": attributes,
        "extension_ids": extension_ids,
        "documentation": comments[:4],
    }


def inherited_attributes(identifier: str, stereotypes: dict[str, dict]) -> list[dict]:
    seen: dict[str, dict] = {}

    def visit(current: str) -> None:
        detail = stereotypes.get(current)
        if not detail:
            return
        for parent in detail["generalizations"]:
            visit(parent)
        for attribute in detail["owned_attributes"]:
            seen[attribute["name"]] = {**attribute, "declared_by": current}

    visit(identifier)
    return list(seen.values())


def package_identity(path: Path) -> dict:
    tree = ET.parse(path)
    root = tree.getroot()
    package = next((e for e in root.iter() if local_name(e.tag) in ("Package", "Profile") or xmi_attr(e, "type") in ("uml:Package", "uml:Profile")), None)
    return {
        "path": path.relative_to(ROOT).as_posix(),
        "namespace_declarations": namespace_declarations(path),
        "xmi_id": xmi_attr(package, "id") if package is not None else None,
        "name": package.get("name") if package is not None else None,
        "URI": package.get("URI") if package is not None else None,
    }


def parse_profile() -> dict:
    sysml_tree = ET.parse(SYSML_PATH)
    sysml_root = sysml_tree.getroot()
    ids = index_by_id(sysml_root)
    profile = ids["SysML"]
    wanted = [
        "SysML.Block", "SysML.InterfaceBlock", "SysML.ProxyPort", "SysML.FlowProperty",
        "SysML.ItemFlow", "SysML.Allocate", "SysML.NestedConnectorEnd",
        "SysML.ElementPropertyPath", "SysML.DirectedRelationshipPropertyPath",
        "SysML.tildeInterfaceBlock",
    ]
    stereotypes = {identifier: stereotype_detail(identifier, ids, sysml_root) for identifier in wanted}
    for identifier in list(stereotypes):
        stereotypes[identifier]["all_attributes"] = inherited_attributes(identifier, stereotypes)

    imports = []
    for element in profile.iter():
        href = element.get("href")
        if href and href not in imports:
            imports.append(href)

    uml_tree = ET.parse(UML_PATH)
    uml_root = uml_tree.getroot()
    uml_ids = index_by_id(uml_root)
    port = uml_ids.get("Port")
    port_attributes = []
    if port is not None:
        port_attributes = [c.get("name") for c in port if local_name(c.tag) == "ownedAttribute"]
    metaclass_attributes = {}
    for metaclass_name in ("InformationFlow", "Connector", "ConnectorEnd", "Port", "Abstraction", "Activity", "Parameter"):
        metaclass = uml_ids.get(metaclass_name)
        metaclass_attributes[metaclass_name] = [
            {
                "name": child.get("name"),
                "type": child.get("type") or type_ref(child),
                "xmi_id": xmi_attr(child, "id"),
            }
            for child in (list(metaclass) if metaclass is not None else []) if local_name(child.tag) == "ownedAttribute"
        ]
    short_description = next((e.text for e in uml_root.iter() if local_name(e.tag) == "shortDescription"), None)

    xsd_tree = ET.parse(XMI_XSD_PATH)
    xsd_root = xsd_tree.getroot()
    xmi_ns = namespace_declarations(SYSML_PATH).get("xmi")
    xmi_version_attr = sysml_root.get(f"{{{xmi_ns}}}version") if xmi_ns else None

    flow_literals = []
    flow_enum = ids.get("SysML_dataType.FlowDirectionKind")
    if flow_enum is not None:
        flow_literals = [c.get("name") for c in flow_enum if local_name(c.tag) == "ownedLiteral"]

    conjugation_evidence = []
    nested_evidence = []
    for element in sysml_root.iter():
        if local_name(element.tag) != "ownedComment":
            continue
        body = " ".join((element.get("body") or "").split())
        if "isConjugated property set to false" in body and body not in conjugation_evidence:
            conjugation_evidence.append(body)
        if "NestedConnectorEnd stereotype" in body and "propertyPath" in body and body not in nested_evidence:
            nested_evidence.append(body)

    return {
        "sysml_profile": {
            "path": SYSML_PATH.relative_to(ROOT).as_posix(),
            "xmi_id": xmi_attr(profile, "id"),
            "name": profile.get("name"),
            "URI": profile.get("URI"),
            "namespace_declarations": namespace_declarations(SYSML_PATH),
            "imports": imports,
        },
        "uml_metamodel": {
            **package_identity(UML_PATH),
            "description": short_description,
            "port_has_isConjugated": "isConjugated" in port_attributes,
            "metaclass_owned_attributes": metaclass_attributes,
        },
        "primitive_types": package_identity(PRIMITIVE_PATH),
        "standard_profile": package_identity(STANDARD_PATH),
        "xmi_schema": {
            "path": XMI_XSD_PATH.relative_to(ROOT).as_posix(),
            "target_namespace": xsd_root.get("targetNamespace"),
        },
        "xmi_serialization": {
            "namespace": xmi_ns,
            "namespace_date": xmi_ns.rsplit("/", 1)[-1] if xmi_ns else None,
            "root_version_attribute": xmi_version_attr,
        },
        "stereotypes": stereotypes,
        "flow_direction_literals": flow_literals,
        "conjugation_evidence": conjugation_evidence,
        "nested_connector_evidence": nested_evidence[:2],
    }


def main() -> None:
    WORK_DIR.mkdir(parents=True, exist_ok=True)
    parsed = parse_profile()
    out = WORK_DIR / "sysml17_profile_parse.json"
    out.write_text(json.dumps(parsed, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(f"Profile parse: {out}")
    print(f"SysML URI: {parsed['sysml_profile']['URI']}")


if __name__ == "__main__":
    main()
