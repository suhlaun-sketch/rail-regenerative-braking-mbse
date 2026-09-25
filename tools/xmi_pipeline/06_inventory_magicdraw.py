from __future__ import annotations

import hashlib
import io
import json
import re
import zipfile
import xml.etree.ElementTree as ET
from pathlib import Path


PIPELINE_DIR = Path(__file__).resolve().parent
ROOT = PIPELINE_DIR.parents[1]
WORK_DIR = PIPELINE_DIR / "work"
INSTALL = Path(r"C:\Program Files\MagicDraw")


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def xmi_attr(element: ET.Element, name: str) -> str | None:
    for namespace in ("http://www.omg.org/spec/XMI/20131001", "http://www.omg.org/XMI"):
        value = element.get(f"{{{namespace}}}{name}")
        if value is not None:
            return value
    return None


def read_zip_member(path: Path, member: str) -> str:
    with zipfile.ZipFile(path) as archive:
        return archive.read(member).decode("utf-8", errors="ignore")


def selected_alias_lines(path: Path, patterns: tuple[str, ...]) -> list[dict]:
    result = []
    for number, line in enumerate(path.read_text(encoding="utf-8", errors="ignore").splitlines(), 1):
        if any(pattern in line for pattern in patterns):
            result.append({"line": number, "text": line})
    return result


def find_first_sample(pattern: str) -> dict | None:
    for root in (INSTALL / "samples", INSTALL / "templates"):
        if not root.is_dir():
            continue
        for path in sorted(root.rglob("*.mdzip")):
            try:
                with zipfile.ZipFile(path) as archive:
                    for member in archive.namelist():
                        if archive.getinfo(member).file_size > 5_000_000:
                            continue
                        text = archive.read(member).decode("utf-8", errors="ignore")
                        position = text.find(pattern)
                        if position >= 0:
                            end = text.find("/>", position)
                            return {
                                "file": str(path),
                                "member": member,
                                "serialization": text[position:end + 2] if end >= 0 else text[position:position + 500],
                            }
            except (OSError, zipfile.BadZipFile):
                continue
    return None


def build_inventory() -> dict:
    if not INSTALL.is_dir():
        return {
            "magicdraw_installation": "NOT_DISCOVERED",
            "magicdraw_builtin_profile": "NOT_DISCOVERED",
        }

    plugin_xml = INSTALL / "plugins" / "com.nomagic.magicdraw.sysml" / "plugin.xml"
    plugin = ET.parse(plugin_xml).getroot()
    profile_zip = INSTALL / "profiles" / "SysML Profile.mdzip"
    standard_zip = INSTALL / "profiles" / "UML_Standard_Profile.mdzip"
    template_zip = INSTALL / "templates" / "SysML" / "SysML.mdzip"
    aliases = INSTALL / "data" / "sysml.alias.properties"
    uml_aliases = INSTALL / "data" / "alias.properties"

    shared_member = "com.nomagic.magicdraw.uml_model.shared_model"
    profile_text = read_zip_member(profile_zip, shared_member)
    profile_root = ET.parse(io.BytesIO(profile_text.encode("utf-8"))).getroot()
    profile_element = next(e for e in profile_root.iter() if e.tag.endswith("Profile") and e.get("name") == "SysML")
    comment = next((e.get("body") for e in profile_element if e.tag.endswith("ownedComment")), None)
    profile_namespace_match = re.search(r"xmlns:sysml=['\"]([^'\"]+)['\"]", profile_text)
    project_ids = []
    with zipfile.ZipFile(profile_zip) as archive:
        project_ids = sorted(name for name in archive.namelist() if name.startswith("PROJECT-"))

    template_member = "com.nomagic.magicdraw.uml_model.model"
    template_text = read_zip_member(template_zip, template_member)
    applied_href_match = re.search(r"<appliedProfile\s+href=['\"]([^'\"]+)['\"]", template_text)
    xmi_namespace_match = re.search(r"xmlns:xmi=['\"]([^'\"]+)['\"]", template_text)
    uml_namespace_match = re.search(r"xmlns:uml=['\"]([^'\"]+)['\"]", template_text)
    standard_namespace_match = re.search(r"xmlns:StandardProfile=['\"]([^'\"]+)['\"]", template_text)

    stereotype_patterns = {
        "Block": "<sysml:Block",
        "InterfaceBlock": "<sysml:InterfaceBlock",
        "ProxyPort": "<sysml:ProxyPort",
        "FlowProperty": "<sysml:FlowProperty",
        "NestedConnectorEnd": "<sysml:NestedConnectorEnd",
        "ItemFlow": "<sysml:ItemFlow",
        "Allocate": "<sysml:Allocate",
    }
    samples = {name: find_first_sample(pattern) for name, pattern in stereotype_patterns.items()}
    return {
        "magicdraw_installation": "DISCOVERED",
        "install_path": str(INSTALL),
        "sysml_plugin": {
            "status": "DISCOVERED",
            "plugin_xml": str(plugin_xml),
            "id": plugin.get("id"),
            "name": plugin.get("name"),
            "version": plugin.get("version"),
            "internal_version": plugin.get("internalVersion"),
            "provider": plugin.get("provider-name"),
        },
        "magicdraw_builtin_profile": "DISCOVERED",
        "builtin_sysml_profile": {
            "path": str(profile_zip),
            "sha256": sha256(profile_zip),
            "project_ids": project_ids,
            "shared_model_member": shared_member,
            "profile_xmi_id": xmi_attr(profile_element, "id"),
            "profile_name": profile_element.get("name"),
            "profile_uri": profile_element.get("URI"),
            "stereotype_namespace": profile_namespace_match.group(1) if profile_namespace_match else None,
            "profile_documentation": comment,
        },
        "uml_standard_profile": {
            "path": str(standard_zip),
            "sha256": sha256(standard_zip),
        },
        "magicdraw_sysml_template": {
            "path": str(template_zip),
            "sha256": sha256(template_zip),
            "model_member": template_member,
            "xmi_xml_namespace": xmi_namespace_match.group(1) if xmi_namespace_match else None,
            "uml_xml_namespace": uml_namespace_match.group(1) if uml_namespace_match else None,
            "standard_profile_namespace": standard_namespace_match.group(1) if standard_namespace_match else None,
            "applied_profile_href": applied_href_match.group(1) if applied_href_match else None,
        },
        "alias_configuration": {
            "sysml_alias_path": str(aliases),
            "uml_alias_path": str(uml_aliases),
            "sysml_evidence": selected_alias_lines(
                aliases,
                (
                    "mdprofile_to_standard_profile_uri", "profile.http\\://www.omg.org/spec/SysML/20181001/SysML.xmi",
                    "href_to_id.regexp.http\\://www\\.omg\\.org/spec/SysML/[0-9]+/SysML.xmi#SysML",
                    "id_to_href._11_5EAPbeta_be00301_1147424179914_458922_958",
                    "id_to_href._17_0_3_17530432_1320213131032_5397_2410",
                    "id_to_href._11_0_be00301_1147691436170_978680_223",
                    "id_to_href._11_5EAPbeta_be00301_1147866646230_488749_1541",
                    "id_to_href._11_5EAPbeta_be00301_1147431307463_773225_1455",
                ),
            ),
            "uml_evidence": selected_alias_lines(
                uml_aliases,
                ("uml_export.uml_namespace", "uml_export.uml_metatypes", "xmi_to_mof24_xmi", "uml_to_mof24_uml"),
            ),
        },
        "installed_serialization_samples": samples,
        "read_only_inventory": True,
    }


def main() -> None:
    WORK_DIR.mkdir(parents=True, exist_ok=True)
    inventory = build_inventory()
    out = WORK_DIR / "magicdraw_profile_inventory.json"
    out.write_text(json.dumps(inventory, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(f"MagicDraw inventory: {out}")
    print(f"MagicDraw: {inventory['magicdraw_installation']}; built-in SysML profile: {inventory['magicdraw_builtin_profile']}")


if __name__ == "__main__":
    main()
