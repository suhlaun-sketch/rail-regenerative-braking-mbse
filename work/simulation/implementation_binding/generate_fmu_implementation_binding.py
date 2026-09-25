from __future__ import annotations

import csv
import hashlib
import json
import re
import sys
import zipfile
from collections import Counter, defaultdict
from datetime import datetime, timedelta, timezone
from pathlib import Path
import xml.etree.ElementTree as ET


ROOT = Path(__file__).resolve().parents[3]
OUT = Path(__file__).resolve().parent
COMPONENT_OUT = OUT / "components"

SSD_REL = Path("work/sysmlv2/ssi_integration/03_ssd/Rail_MBSE_L2_All16_v1.ssd")
MAPPING_REL = Path("work/sysmlv2/ssi_integration/03_ssd/Rail_MBSE_L2_All16_v1_mapping.json")
FULL_SYSML_REL = Path("work/sysmlv2/full_engineering_model/01_generated")
PRODUCT_DEFS_REL = FULL_SYSML_REL / "05_ProductDefinitions.sysml"
ITEM_DEFS_REL = FULL_SYSML_REL / "02_ItemDefinitions.sysml"
TRACE_REL = Path("work/sysmlv2/full_engineering_model/02_mapping/SysML_Element_Traceability.json")
LEGACY_REL = Path("Rail_MBSE_L2_SysML_Simulink_Interface_Contract_v1.xlsx")

SSD = ROOT / SSD_REL
MAPPING = ROOT / MAPPING_REL
FULL_SYSML = ROOT / FULL_SYSML_REL
PRODUCT_DEFS = ROOT / PRODUCT_DEFS_REL
ITEM_DEFS = ROOT / ITEM_DEFS_REL
TRACE = ROOT / TRACE_REL
LEGACY = ROOT / LEGACY_REL

EXPECTED_COMPONENTS = 16
EXPECTED_CONNECTORS = 138
EXPECTED_CONNECTIONS = 74

JSON_OUT = OUT / "Rail_MBSE_FMU_Implementation_Binding_v1.json"
REPORT_OUT = OUT / "Rail_MBSE_FMU_Implementation_Binding_Report.md"

SSD_NS = "http://ssp-standard.org/SSP1/SystemStructureDescription"
MAIN_NS = "http://schemas.openxmlformats.org/spreadsheetml/2006/main"
REL_NS = "http://schemas.openxmlformats.org/officeDocument/2006/relationships"
PKG_REL_NS = "http://schemas.openxmlformats.org/package/2006/relationships"


def rel(path: Path) -> str:
    return path.as_posix()


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest().upper()


def tree_hash(path: Path) -> str:
    digest = hashlib.sha256()
    for file_path in sorted(p for p in path.rglob("*") if p.is_file()):
        digest.update(file_path.relative_to(path).as_posix().encode("utf-8"))
        digest.update(b"\0")
        digest.update(sha256_file(file_path).encode("ascii"))
        digest.update(b"\n")
    return digest.hexdigest().upper()


def named_blocks(text: str, declaration: str) -> list[tuple[str, str]]:
    pattern = re.compile(rf"\b{declaration}\s+([A-Za-z0-9_]+)\s*\{{")
    results: list[tuple[str, str]] = []
    for match in pattern.finditer(text):
        opening = text.find("{", match.start())
        depth = 0
        closing = None
        for index in range(opening, len(text)):
            if text[index] == "{":
                depth += 1
            elif text[index] == "}":
                depth -= 1
                if depth == 0:
                    closing = index
                    break
        if closing is None:
            raise ValueError(f"Unclosed SysML block: {declaration} {match.group(1)}")
        results.append((match.group(1), text[opening + 1 : closing]))
    return results


def string_attributes(block: str) -> dict[str, str]:
    return dict(
        re.findall(
            r'attribute\s+([A-Za-z0-9_]+)\s*:\s*[A-Za-z0-9_]+\s*=\s*"([^"]*)"\s*;',
            block,
        )
    )


def port_blocks(block: str) -> list[tuple[str, str, str]]:
    pattern = re.compile(r"\bport\s+([A-Za-z0-9_]+)\s*:\s*([~A-Za-z0-9_]+)\s*\{")
    results: list[tuple[str, str, str]] = []
    for match in pattern.finditer(block):
        opening = block.find("{", match.start())
        depth = 0
        closing = None
        for index in range(opening, len(block)):
            if block[index] == "{":
                depth += 1
            elif block[index] == "}":
                depth -= 1
                if depth == 0:
                    closing = index
                    break
        if closing is None:
            raise ValueError(f"Unclosed SysML port block: {match.group(1)}")
        results.append((match.group(1), match.group(2), block[opening + 1 : closing]))
    return results


def parse_full_sysml() -> tuple[dict[str, dict], dict[str, dict], dict[tuple[str, str], dict]]:
    product_text = PRODUCT_DEFS.read_text(encoding="utf-8")
    item_text = ITEM_DEFS.read_text(encoding="utf-8")

    products: dict[str, dict] = {}
    ports: dict[tuple[str, str], dict] = {}
    for definition_name, block in named_blocks(product_text, "part def"):
        attrs = string_attributes(block)
        product_code = attrs.get("productCode")
        if not product_code:
            continue
        product = {
            "definition": definition_name,
            "product_code": product_code,
            "product_name": attrs.get("chineseName"),
            "parent_code": attrs.get("parentCode"),
        }
        products[product_code] = product
        for port_name, port_type, port_block in port_blocks(block):
            port_attrs = string_attributes(port_block)
            port = {
                "product_code": product_code,
                "product_name": attrs.get("chineseName"),
                "raw_port": port_name,
                "port_type": port_type,
                "port_id": port_attrs.get("sourcePortId"),
                "port_name": port_attrs.get("portName"),
                "direction": port_attrs.get("direction"),
            }
            ports[(product_code, port_name)] = port

    items: dict[str, dict] = {}
    for definition_name, block in named_blocks(item_text, "item def"):
        attrs = string_attributes(block)
        item_code = attrs.get("itemCode")
        if item_code:
            items[item_code] = {
                "definition": definition_name,
                "item_code": item_code,
                "item_name": attrs.get("chineseName"),
                "item_name_en": attrs.get("englishName"),
                "family": attrs.get("family"),
                "domain": attrs.get("domain"),
                "datatype": attrs.get("datatype"),
                "unit_or_medium": attrs.get("unitOrMedium"),
                "semantic_definition": attrs.get("semanticDefinition"),
                "aliases": attrs.get("aliases"),
            }
    return products, items, ports


def column_number(cell_ref: str) -> int:
    letters = re.match(r"[A-Z]+", cell_ref).group(0)
    result = 0
    for char in letters:
        result = result * 26 + ord(char) - 64
    return result


def read_legacy_workbook(path: Path) -> dict[str, list[dict[str, str | None]]]:
    ns = {"m": MAIN_NS, "r": REL_NS}
    with zipfile.ZipFile(path) as archive:
        shared_strings: list[str] = []
        if "xl/sharedStrings.xml" in archive.namelist():
            root = ET.fromstring(archive.read("xl/sharedStrings.xml"))
            for item in root.findall("m:si", ns):
                shared_strings.append("".join(node.text or "" for node in item.findall(".//m:t", ns)))

        workbook = ET.fromstring(archive.read("xl/workbook.xml"))
        relationships = ET.fromstring(archive.read("xl/_rels/workbook.xml.rels"))
        relationship_map = {
            node.attrib["Id"]: node.attrib["Target"].lstrip("/")
            for node in relationships.findall(f"{{{PKG_REL_NS}}}Relationship")
        }
        sheets: dict[str, list[dict[str, str | None]]] = {}
        for sheet_node in workbook.find("m:sheets", ns):
            sheet_name = sheet_node.attrib["name"]
            relationship_id = sheet_node.attrib[f"{{{REL_NS}}}id"]
            sheet_path = relationship_map[relationship_id]
            sheet_root = ET.fromstring(archive.read(sheet_path))
            matrix: list[list[str | None]] = []
            for row in sheet_root.findall(".//m:sheetData/m:row", ns):
                cells: dict[int, str | None] = {}
                for cell in row.findall("m:c", ns):
                    cell_type = cell.attrib.get("t")
                    value_node = cell.find("m:v", ns)
                    inline_node = cell.find("m:is/m:t", ns)
                    value: str | None = None
                    if inline_node is not None:
                        value = inline_node.text
                    elif value_node is not None:
                        value = value_node.text
                        if cell_type == "s" and value is not None:
                            value = shared_strings[int(value)]
                    cells[column_number(cell.attrib["r"])] = value
                if cells:
                    width = max(cells)
                    matrix.append([cells.get(i) for i in range(1, width + 1)])
            if not matrix:
                sheets[sheet_name] = []
                continue
            headers = [str(value) if value is not None else "" for value in matrix[0]]
            records = []
            for values in matrix[1:]:
                padded = values + [None] * (len(headers) - len(values))
                records.append(dict(zip(headers, padded)))
            sheets[sheet_name] = records
        return sheets


def split_legacy_ids(value: str | None) -> list[str]:
    if not value:
        return []
    return [part.strip() for part in re.split(r"\s*\|\s*", value) if part.strip()]


def normalize_unit(value: str | None) -> str | None:
    if value is None:
        return None
    normalized = value.strip().replace(" ", "").lower()
    aliases = {
        "1": "[-]",
        "dimensionless": "[-]",
        "unitless": "[-]",
        "无量纲": "[-]",
        "n·m": "n*m",
        "nm": "n*m",
    }
    return aliases.get(normalized, normalized)


def fmi_type_compatible(ssd_type: str | None, legacy_type: str | None) -> bool:
    if not ssd_type or not legacy_type:
        return True
    compatible = {
        "Real": {"Real", "Float32", "Float64", "Double", "Single"},
        "Integer": {"Integer", "Int8", "Int16", "Int32", "Int64"},
        "Boolean": {"Boolean", "Bool"},
        "String": {"String"},
    }
    return legacy_type in compatible.get(ssd_type, {ssd_type})


def legacy_candidates_for(
    master_rows: list[dict[str, str | None]],
    l2_code: str,
    original_port_id: str | None,
) -> list[dict]:
    if not original_port_id:
        return []
    candidates: list[dict] = []
    for row in master_rows:
        if original_port_id in split_legacy_ids(row.get("Source_Raw_Port_IDs")) and row.get(
            "Sim_Driver_Code"
        ) == l2_code:
            candidates.append(
                {
                    "side": "driver",
                    "contract_id": row.get("Contract_ID"),
                    "item_code": row.get("Item_Code"),
                    "interface_kind": row.get("Interface_Kind"),
                    "simulation_variable": row.get("Simulation_Variable"),
                    "variable_semantics": row.get("Variable_Semantics"),
                    "simulink_port_suggestion": row.get("Driver_Port"),
                    "fmi_variable_suggestion": row.get("FMI_Variable_Driver"),
                    "causality": row.get("Driver_Causality"),
                    "fmi_type": row.get("FMI_Type"),
                    "unit": row.get("Simulation_Unit"),
                    "legacy_status": row.get("Mapping_Status"),
                }
            )
        if original_port_id in split_legacy_ids(row.get("Target_Raw_Port_IDs")) and row.get(
            "Sim_Receiver_Code"
        ) == l2_code:
            candidates.append(
                {
                    "side": "receiver",
                    "contract_id": row.get("Contract_ID"),
                    "item_code": row.get("Item_Code"),
                    "interface_kind": row.get("Interface_Kind"),
                    "simulation_variable": row.get("Simulation_Variable"),
                    "variable_semantics": row.get("Variable_Semantics"),
                    "simulink_port_suggestion": row.get("Receiver_Port"),
                    "fmi_variable_suggestion": row.get("FMI_Variable_Receiver"),
                    "causality": row.get("Receiver_Causality"),
                    "fmi_type": row.get("FMI_Type"),
                    "unit": row.get("Simulation_Unit"),
                    "legacy_status": row.get("Mapping_Status"),
                }
            )
    unique: dict[tuple, dict] = {}
    for candidate in candidates:
        key = tuple(candidate.get(field) for field in candidate)
        unique[key] = candidate
    return list(unique.values())


def simulink_safe_name(name: str) -> tuple[str, str | None]:
    sanitized = re.sub(r"\s+", "_", name)
    sanitized = re.sub(r"[^A-Za-z0-9_]", "_", sanitized)
    sanitized = re.sub(r"_+", "_", sanitized)
    if sanitized and sanitized[0].isdigit():
        sanitized = "p_" + sanitized
    if not sanitized:
        sanitized = "port"
    if sanitized == name:
        return name, None
    return sanitized, "SSD connector name sanitized for Simulink/FMI identifier compatibility"


def choose_binding_status(flags: list[str]) -> str:
    precedence = [
        "DIRECTION_REVIEW_REQUIRED",
        "TYPE_MISSING",
        "UNIT_MISSING",
        "LEGACY_CONTRACT_CONFLICT",
        "SEMANTIC_REVIEW_REQUIRED",
    ]
    for status in precedence:
        if status in flags:
            return status
    return "READY"


def csv_value(value):
    if isinstance(value, list):
        return " | ".join(str(item) for item in value)
    if isinstance(value, dict):
        return json.dumps(value, ensure_ascii=False, separators=(",", ":"))
    return value


def write_csv(path: Path, records: list[dict], columns: list[str] | None = None) -> None:
    if columns is None:
        columns = list(records[0]) if records else []
    with path.open("w", encoding="utf-8-sig", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=columns, extrasaction="ignore")
        writer.writeheader()
        for record in records:
            writer.writerow({key: csv_value(record.get(key)) for key in columns})


def main() -> int:
    OUT.mkdir(parents=True, exist_ok=True)
    COMPONENT_OUT.mkdir(parents=True, exist_ok=True)

    source_hashes_before = {
        "ssd_sha256": sha256_file(SSD),
        "mapping_sha256": sha256_file(MAPPING),
        "full_sysml_tree_sha256": tree_hash(FULL_SYSML),
        "legacy_contract_sha256": sha256_file(LEGACY),
    }

    mapping = json.loads(MAPPING.read_text(encoding="utf-8"))
    products, items, full_sysml_ports = parse_full_sysml()
    legacy = read_legacy_workbook(LEGACY)
    legacy_master = legacy.get("01_L2_Mapping_Master", [])

    ns = {"ssd": SSD_NS}
    ssd_root = ET.parse(SSD).getroot()
    ssd_system = ssd_root.find("ssd:System", ns)
    component_nodes = ssd_system.findall("./ssd:Elements/ssd:Component", ns)
    connection_nodes = ssd_system.findall("./ssd:Connections/ssd:Connection", ns)

    component_map = {row["ssd_component"]: row for row in mapping["component_mapping"]}
    port_map = {
        (row["ssd_component"], row["ssd_connector"]): row
        for row in mapping["port_mapping"]
    }
    connection_map = {
        (row["ssd_start_connector"], row["ssd_end_connector"]): row
        for row in mapping["connection_mapping"]
    }
    connection_by_id = {row["connection_id"]: row for row in mapping["connection_mapping"]}

    components: list[dict] = []
    connector_bindings: list[dict] = []
    connector_index: dict[str, dict] = {}

    for component_node in component_nodes:
        component_name = component_node.attrib["name"]
        component_mapping = component_map.get(component_name)
        l2_code = (
            component_mapping.get("rail_l2_code")
            if component_mapping
            else component_name.removeprefix("L2_")
        )
        l2_product = products.get(l2_code, {})
        connector_nodes = component_node.findall("./ssd:Connectors/ssd:Connector", ns)
        component = {
            "ssd_component_id": component_name,
            "ssd_component_name": component_name,
            "l2_code": l2_code,
            "l2_engineering_name": l2_product.get("product_name"),
            "full_sysml_path": component_mapping.get("full_sysml_path")
            if component_mapping
            else None,
            "simulation_model_name": f"L2_{l2_code}.slx",
            "future_fmu_file": f"L2_{l2_code}.fmu",
            "ssd_expected_source": component_node.attrib.get("source"),
            "connector_count": len(connector_nodes),
            "ssd_component_id_source": "SSD component name (SSD has no separate component id attribute)",
        }
        components.append(component)

        for connector_node in connector_nodes:
            connector_name = connector_node.attrib["name"]
            qualified_connector = f"{component_name}.{connector_name}"
            mapped_port = port_map.get((component_name, connector_name), {})
            original_leaf_code = mapped_port.get("original_leaf_code")
            original_raw_port = mapped_port.get("original_raw_port")
            full_port = full_sysml_ports.get((original_leaf_code, original_raw_port), {})
            item_code = mapped_port.get("item_code")
            item = items.get(item_code, {})

            signal_node = next(iter(connector_node), None)
            data_type = signal_node.tag.split("}")[-1] if signal_node is not None else None
            unit = signal_node.attrib.get("unit") if signal_node is not None else None
            direction = connector_node.attrib.get("kind")
            simulink_port_name, alias_reason = simulink_safe_name(connector_name)

            source_connection_ids = mapped_port.get("connection_ids") or []
            interface_types = sorted(
                {
                    connection_by_id[connection_id].get("interface_type")
                    for connection_id in source_connection_ids
                    if connection_id in connection_by_id
                    and connection_by_id[connection_id].get("interface_type")
                }
            )

            legacy_candidates = legacy_candidates_for(
                legacy_master, l2_code, full_port.get("port_id")
            )
            legacy_conflicts: list[str] = []
            if not legacy_candidates:
                legacy_match = "NOT_FOUND"
            elif len(legacy_candidates) > 1:
                legacy_match = "AMBIGUOUS"
            else:
                candidate = legacy_candidates[0]
                if candidate.get("item_code") and item_code and candidate["item_code"] != item_code:
                    legacy_conflicts.append("item_code")
                if (
                    candidate.get("causality") in {"input", "output"}
                    and direction in {"input", "output"}
                    and candidate["causality"] != direction
                ):
                    legacy_conflicts.append("direction/causality")
                if not fmi_type_compatible(data_type, candidate.get("fmi_type")):
                    legacy_conflicts.append("data_type")
                if (
                    normalize_unit(unit) is not None
                    and normalize_unit(candidate.get("unit")) is not None
                    and normalize_unit(unit) != normalize_unit(candidate.get("unit"))
                ):
                    legacy_conflicts.append("unit")
                legacy_match = "CONFLICT" if legacy_conflicts else "MATCHED"

            flags: list[str] = []
            notes: list[str] = []
            if direction not in {"input", "output"}:
                flags.append("DIRECTION_REVIEW_REQUIRED")
                notes.append("SSD connector direction is absent or unsupported; no direction was guessed.")
            if not data_type:
                flags.append("TYPE_MISSING")
                notes.append("SSD connector data type is missing.")
            if unit is None or str(unit).strip() == "":
                flags.append("UNIT_MISSING")
                notes.append("SSD connector unit is missing.")
            if legacy_match == "CONFLICT":
                flags.append("LEGACY_CONTRACT_CONFLICT")
                notes.append(
                    "Legacy contract conflicts with authoritative SSD fields: "
                    + ", ".join(legacy_conflicts)
                    + ". SSD values were retained."
                )

            semantic_reasons: list[str] = []
            if not item_code or not item:
                semantic_reasons.append("item definition missing")
            if not interface_types:
                semantic_reasons.append("interface type unresolved from mapped connections")
            if len(interface_types) > 1:
                semantic_reasons.append("multiple interface types associated with connector")
            item_datatype = item.get("datatype")
            if item_datatype and item_datatype not in {"Real", "Float32", "Float64"}:
                semantic_reasons.append(
                    f"Full SysML item datatype {item_datatype} requires implementation interpretation against SSD {data_type}"
                )
            sysml_unit = item.get("unit_or_medium")
            if (
                unit == "[-]"
                and sysml_unit
                and normalize_unit(sysml_unit) not in {"[-]", None}
            ):
                semantic_reasons.append(
                    f"SSD unit [-] does not encode Full SysML unit/medium {sysml_unit}"
                )
            if not item.get("semantic_definition"):
                semantic_reasons.append("item semantic definition missing")
            if semantic_reasons:
                flags.append("SEMANTIC_REVIEW_REQUIRED")
                notes.extend(semantic_reasons)

            flags = list(dict.fromkeys(flags))
            binding_status = choose_binding_status(flags)
            binding = {
                "binding_id": f"BIND::{component_name}::{connector_name}",
                "ssd_component_id": component_name,
                "ssd_component_name": component_name,
                "l2_code": l2_code,
                "l2_name": l2_product.get("product_name"),
                "ssd_connector_name": connector_name,
                "ssd_connector_id": qualified_connector,
                "ssd_connector_id_source": "Derived qualified identity because SSD Connector has no id attribute",
                "direction": direction,
                "data_type": data_type,
                "unit": unit,
                "quantity": item.get("item_name_en") or item.get("item_name"),
                "item_type": item_datatype,
                "item_code": item_code,
                "item_name": item.get("item_name"),
                "item_name_en": item.get("item_name_en"),
                "item_family": item.get("family"),
                "item_domain": item.get("domain"),
                "item_unit_or_medium": sysml_unit,
                "item_semantic_definition": item.get("semantic_definition"),
                "interface_type": interface_types[0] if len(interface_types) == 1 else interface_types,
                "original_sysml_path": mapped_port.get("original_sysml_path"),
                "original_product_code": original_leaf_code,
                "original_product_name": full_port.get("product_name"),
                "original_port_name": full_port.get("port_name"),
                "original_port_id": full_port.get("port_id"),
                "original_port_direction": full_port.get("direction"),
                "source_connection_ids": source_connection_ids,
                "simulink_model": f"L2_{l2_code}.slx",
                "simulink_port_name": simulink_port_name,
                "simulink_port_type": (
                    "Inport" if direction == "input" else "Outport" if direction == "output" else None
                ),
                "future_fmu_file": f"L2_{l2_code}.fmu",
                "future_fmu_variable": simulink_port_name,
                "future_fmu_causality": direction if direction in {"input", "output"} else None,
                "future_fmu_variability": "continuous" if data_type == "Real" else None,
                "alias_reason": alias_reason,
                "legacy_match": legacy_match,
                "legacy_candidates": legacy_candidates,
                "legacy_conflict_fields": legacy_conflicts,
                "review_flags": flags,
                "binding_status": binding_status,
                "notes": " | ".join(notes) if notes else None,
            }
            connector_bindings.append(binding)
            connector_index[qualified_connector] = binding

    connection_bindings: list[dict] = []
    component_peers: dict[str, set[str]] = defaultdict(set)
    for node in connection_nodes:
        start_connector = node.attrib.get("startConnector")
        end_connector = node.attrib.get("endConnector")
        start_component = node.attrib.get("startElement")
        end_component = node.attrib.get("endElement")
        mapped_connection = connection_map.get((start_connector, end_connector), {})
        source = connector_index.get(start_connector)
        target = connector_index.get(end_connector)
        review_reasons: list[str] = []
        if source is None:
            review_reasons.append("source connector does not exist in SSD connector inventory")
        if target is None:
            review_reasons.append("target connector does not exist in SSD connector inventory")
        if source and target:
            if source.get("direction") != "output" or target.get("direction") != "input":
                review_reasons.append(
                    f"direction incompatible: {source.get('direction')} -> {target.get('direction')}"
                )
            if source.get("data_type") != target.get("data_type"):
                review_reasons.append(
                    f"type mismatch: {source.get('data_type')} -> {target.get('data_type')}"
                )
            if source.get("unit") != target.get("unit"):
                review_reasons.append(
                    f"unit mismatch: {source.get('unit')} -> {target.get('unit')}"
                )
        status = "CONNECTION_BINDING_REVIEW_REQUIRED" if review_reasons else "READY"
        connection_id = mapped_connection.get("connection_id")
        record = {
            "connection_id": connection_id,
            "source_component": start_component,
            "source_connector": start_connector,
            "target_component": end_component,
            "target_connector": end_connector,
            "source_future_fmu": source.get("future_fmu_file") if source else None,
            "source_future_fmu_variable": source.get("future_fmu_variable") if source else None,
            "target_future_fmu": target.get("future_fmu_file") if target else None,
            "target_future_fmu_variable": target.get("future_fmu_variable") if target else None,
            "source_direction": source.get("direction") if source else None,
            "target_direction": target.get("direction") if target else None,
            "source_data_type": source.get("data_type") if source else None,
            "target_data_type": target.get("data_type") if target else None,
            "source_unit": source.get("unit") if source else None,
            "target_unit": target.get("unit") if target else None,
            "interface_type": mapped_connection.get("interface_type"),
            "item_code": mapped_connection.get("item_code"),
            "status": status,
            "review_reasons": review_reasons,
        }
        connection_bindings.append(record)
        if start_component and end_component:
            component_peers[start_component].add(end_component)
            component_peers[end_component].add(start_component)

    connector_status_counts = Counter(row["binding_status"] for row in connector_bindings)
    legacy_counts = Counter(row["legacy_match"] for row in connector_bindings)
    ready_connectors = connector_status_counts.get("READY", 0)
    review_connectors = len(connector_bindings) - ready_connectors
    valid_connections = sum(row["status"] == "READY" for row in connection_bindings)
    review_connections = len(connection_bindings) - valid_connections

    binding_ids = [row["binding_id"] for row in connector_bindings]
    component_ids = [row["ssd_component_id"] for row in components]
    ssd_connector_ids = set(connector_index)
    bound_connector_ids = {row["ssd_connector_id"] for row in connector_bindings}
    ssd_connection_pairs = {
        (node.attrib.get("startConnector"), node.attrib.get("endConnector"))
        for node in connection_nodes
    }
    bound_connection_pairs = {
        (row["source_connector"], row["target_connector"])
        for row in connection_bindings
    }

    structural_checks = {
        "component_binding": f"{len(components)}/{EXPECTED_COMPONENTS}",
        "connector_binding_records": f"{len(connector_bindings)}/{EXPECTED_CONNECTORS}",
        "connection_binding_records": f"{len(connection_bindings)}/{EXPECTED_CONNECTIONS}",
        "no_orphan_ssd_connector": ssd_connector_ids == bound_connector_ids,
        "no_invented_connector": bound_connector_ids <= ssd_connector_ids,
        "no_invented_connection": bound_connection_pairs <= ssd_connection_pairs,
        "no_duplicate_binding_id": len(binding_ids) == len(set(binding_ids)),
        "no_duplicate_component_mapping": len(component_ids) == len(set(component_ids)),
        "mapping_component_join": f"{sum(name in component_map for name in component_ids)}/{len(component_ids)}",
        "mapping_connector_join": f"{sum((row['ssd_component_name'], row['ssd_connector_name']) in port_map for row in connector_bindings)}/{len(connector_bindings)}",
        "mapping_connection_join": f"{sum((row['source_connector'], row['target_connector']) in connection_map for row in connection_bindings)}/{len(connection_bindings)}",
    }
    structural_pass = (
        len(components) == EXPECTED_COMPONENTS
        and len(connector_bindings) == EXPECTED_CONNECTORS
        and len(connection_bindings) == EXPECTED_CONNECTIONS
        and all(
            structural_checks[key]
            for key in [
                "no_orphan_ssd_connector",
                "no_invented_connector",
                "no_invented_connection",
                "no_duplicate_binding_id",
                "no_duplicate_component_mapping",
            ]
        )
        and structural_checks["mapping_component_join"] == "16/16"
        and structural_checks["mapping_connector_join"] == "138/138"
        and structural_checks["mapping_connection_join"] == "74/74"
    )

    connection_review_components = {
        component
        for row in connection_bindings
        if row["status"] != "READY"
        for component in (row["source_component"], row["target_component"])
    }
    bindings_by_component: dict[str, list[dict]] = defaultdict(list)
    for row in connector_bindings:
        bindings_by_component[row["ssd_component_name"]].append(row)

    for component in components:
        name = component["ssd_component_name"]
        rows = bindings_by_component[name]
        component_review = any(row["binding_status"] != "READY" for row in rows) or name in connection_review_components
        component["connected_l2_peers"] = sorted(component_peers.get(name, set()))
        component["readiness"] = "REVIEW_REQUIRED" if component_review else "READY"
        summary = {
            "ssd_component_id": component["ssd_component_id"],
            "ssd_component_name": name,
            "l2_code": component["l2_code"],
            "l2_engineering_name": component["l2_engineering_name"],
            "inputs": [
                {
                    "binding_id": row["binding_id"],
                    "ssd_connector_name": row["ssd_connector_name"],
                    "simulink_port_name": row["simulink_port_name"],
                    "future_fmu_variable": row["future_fmu_variable"],
                    "binding_status": row["binding_status"],
                }
                for row in rows
                if row["direction"] == "input"
            ],
            "outputs": [
                {
                    "binding_id": row["binding_id"],
                    "ssd_connector_name": row["ssd_connector_name"],
                    "simulink_port_name": row["simulink_port_name"],
                    "future_fmu_variable": row["future_fmu_variable"],
                    "binding_status": row["binding_status"],
                }
                for row in rows
                if row["direction"] == "output"
            ],
            "total_connectors": len(rows),
            "connected_l2_peers": component["connected_l2_peers"],
            "future_simulink": component["simulation_model_name"],
            "future_fmu": component["future_fmu_file"],
            "readiness": component["readiness"],
        }
        (COMPONENT_OUT / f"L2_{component['l2_code']}_binding.json").write_text(
            json.dumps(summary, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
        )

    source_hashes_after = {
        "ssd_sha256": sha256_file(SSD),
        "mapping_sha256": sha256_file(MAPPING),
        "full_sysml_tree_sha256": tree_hash(FULL_SYSML),
        "legacy_contract_sha256": sha256_file(LEGACY),
    }
    original_ssd_modified = source_hashes_before["ssd_sha256"] != source_hashes_after["ssd_sha256"]
    mapping_modified = source_hashes_before["mapping_sha256"] != source_hashes_after["mapping_sha256"]
    full_sysml_modified = (
        source_hashes_before["full_sysml_tree_sha256"]
        != source_hashes_after["full_sysml_tree_sha256"]
    )
    legacy_modified = (
        source_hashes_before["legacy_contract_sha256"]
        != source_hashes_after["legacy_contract_sha256"]
    )

    if original_ssd_modified or mapping_modified or full_sysml_modified or legacy_modified:
        structural_pass = False

    overall_status = (
        "FAIL"
        if not structural_pass
        else "PASS_WITH_REVIEW_ITEMS"
        if review_connectors or review_connections
        else "PASS"
    )

    readiness = {
        "components_total": len(components),
        "connectors_total": len(connector_bindings),
        "READY_connectors": connector_status_counts.get("READY", 0),
        "UNIT_MISSING": connector_status_counts.get("UNIT_MISSING", 0),
        "TYPE_MISSING": connector_status_counts.get("TYPE_MISSING", 0),
        "DIRECTION_REVIEW_REQUIRED": connector_status_counts.get(
            "DIRECTION_REVIEW_REQUIRED", 0
        ),
        "SEMANTIC_REVIEW_REQUIRED": connector_status_counts.get(
            "SEMANTIC_REVIEW_REQUIRED", 0
        ),
        "LEGACY_CONTRACT_CONFLICT": connector_status_counts.get(
            "LEGACY_CONTRACT_CONFLICT", 0
        ),
        "review_required_connectors": review_connectors,
        "connections_total": len(connection_bindings),
        "connection_bindings_valid": valid_connections,
        "connection_bindings_review_required": review_connections,
    }

    baseline = {
        "name": "FMU Implementation Binding Baseline",
        "authority_statement": "This is not a new interface standard. The final All16 SSD remains authoritative.",
        "authoritative_ssd": rel(SSD_REL),
        "mapping": rel(MAPPING_REL),
        "components": EXPECTED_COMPONENTS,
        "connectors": EXPECTED_CONNECTORS,
        "connections": EXPECTED_CONNECTIONS,
        "generated_at": datetime.now(timezone(timedelta(hours=8))).isoformat(),
        "status": overall_status,
    }
    result = {
        "baseline": baseline,
        "source_priority": [
            rel(SSD_REL),
            rel(MAPPING_REL),
            rel(TRACE_REL),
            rel(LEGACY_REL) + " (enrichment only)",
        ],
        "source_integrity": {
            "before": source_hashes_before,
            "after": source_hashes_after,
            "original_ssd_modified": original_ssd_modified,
            "all16_mapping_modified": mapping_modified,
            "full_sysml_modified": full_sysml_modified,
            "legacy_contract_modified": legacy_modified,
        },
        "components": components,
        "connector_bindings": connector_bindings,
        "connection_bindings": connection_bindings,
        "readiness": readiness,
        "legacy_contract_comparison": {
            "role": "enrichment only; never used to add or override an SSD connector",
            "MATCHED": legacy_counts.get("MATCHED", 0),
            "AMBIGUOUS": legacy_counts.get("AMBIGUOUS", 0),
            "NOT_FOUND": legacy_counts.get("NOT_FOUND", 0),
            "CONFLICT": legacy_counts.get("CONFLICT", 0),
        },
        "validation": structural_checks
        | {
            "original_ssd_modified": not original_ssd_modified,
            "all16_mapping_modified": not mapping_modified,
            "full_sysml_modified": not full_sysml_modified,
            "legacy_contract_modified": not legacy_modified,
            "result": overall_status,
        },
    }
    JSON_OUT.write_text(
        json.dumps(result, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )

    component_columns = [
        "ssd_component_id",
        "ssd_component_name",
        "l2_code",
        "l2_engineering_name",
        "full_sysml_path",
        "simulation_model_name",
        "future_fmu_file",
        "connector_count",
        "connected_l2_peers",
        "readiness",
    ]
    connector_columns = [
        "binding_id",
        "ssd_component_id",
        "ssd_component_name",
        "l2_code",
        "l2_name",
        "ssd_connector_name",
        "ssd_connector_id",
        "direction",
        "data_type",
        "unit",
        "quantity",
        "item_type",
        "item_code",
        "item_name",
        "item_name_en",
        "item_unit_or_medium",
        "interface_type",
        "original_sysml_path",
        "original_product_code",
        "original_product_name",
        "original_port_name",
        "original_port_id",
        "source_connection_ids",
        "simulink_model",
        "simulink_port_name",
        "simulink_port_type",
        "future_fmu_file",
        "future_fmu_variable",
        "future_fmu_causality",
        "future_fmu_variability",
        "alias_reason",
        "legacy_match",
        "legacy_conflict_fields",
        "review_flags",
        "binding_status",
        "notes",
    ]
    connection_columns = list(connection_bindings[0]) if connection_bindings else []
    write_csv(OUT / "Component_Inventory.csv", components, component_columns)
    write_csv(OUT / "Connector_Bindings.csv", connector_bindings, connector_columns)
    write_csv(OUT / "Connection_Bindings.csv", connection_bindings, connection_columns)

    status_rows = "\n".join(
        f"| {status} | {connector_status_counts.get(status, 0)} |"
        for status in [
            "READY",
            "UNIT_MISSING",
            "TYPE_MISSING",
            "DIRECTION_REVIEW_REQUIRED",
            "SEMANTIC_REVIEW_REQUIRED",
            "LEGACY_CONTRACT_CONFLICT",
        ]
    )
    component_rows = "\n".join(
        f"| {row['ssd_component_name']} | {row['l2_engineering_name'] or ''} | {row['connector_count']} | {row['simulation_model_name']} | {row['future_fmu_file']} | {row['readiness']} |"
        for row in components
    )
    connection_review_rows = "\n".join(
        f"| {row['connection_id']} | {row['source_connector']} | {row['target_connector']} | {'; '.join(row['review_reasons'])} |"
        for row in connection_bindings
        if row["status"] != "READY"
    ) or "| — | — | — | None |"
    conflict_rows = "\n".join(
        f"| {row['binding_id']} | {', '.join(row['legacy_conflict_fields'])} | {row['ssd_connector_name']} |"
        for row in connector_bindings
        if row["legacy_match"] == "CONFLICT"
    ) or "| — | None | — |"

    report = f"""# FMU Implementation Binding Baseline

## 基线声明

本实施绑定基线不是新的接口标准。唯一权威接口仍然是最终 All16 SSD：`{rel(SSD_REL)}`。

本文件只建立以下可追溯实施链：

`SSD Connector → Simulink external port → FMU exposed variable`

旧合同 `{rel(LEGACY_REL)}` 仅用于工程名称、单位、语义及历史命名建议的 enrichment。任何冲突均保留 SSD 值，并标记 `LEGACY_CONTRACT_CONFLICT`。旧合同中的额外端口没有加入本基线。

## 冻结基线与覆盖率

- Component Binding: **{len(components)}/{EXPECTED_COMPONENTS}**
- Connector Binding Records: **{len(connector_bindings)}/{EXPECTED_CONNECTORS}**
- Connection Binding Records: **{len(connection_bindings)}/{EXPECTED_CONNECTIONS}**
- No orphan SSD connector: **{'YES' if structural_checks['no_orphan_ssd_connector'] else 'NO'}**
- No invented connector: **{'YES' if structural_checks['no_invented_connector'] else 'NO'}**
- No invented connection: **{'YES' if structural_checks['no_invented_connection'] else 'NO'}**
- No duplicate binding_id: **{'YES' if structural_checks['no_duplicate_binding_id'] else 'NO'}**
- Original SSD Modified: **{'YES' if original_ssd_modified else 'NO'}**
- Full SysML Modified: **{'YES' if full_sysml_modified else 'NO'}**

## Connector Readiness

状态为互斥主状态；`review_flags` 保留同一 Connector 的全部复核原因。

| Status | Count |
|---|---:|
{status_rows}

Review-required connectors: **{review_connectors}**

## Connection Binding Validation

- Valid connection bindings: **{valid_connections}/{len(connection_bindings)}**
- Review required: **{review_connections}/{len(connection_bindings)}**

| Connection ID | Source | Target | Review reason |
|---|---|---|---|
{connection_review_rows}

不在本任务中修改 SSD 或修正方向；上述问题留给后续接口评审。

## Component Inventory

| Component | Engineering name | Connectors | Future Simulink | Future FMU | Readiness |
|---|---|---:|---|---|---|
{component_rows}

每个组件的 Inputs、Outputs、连接对端和 readiness 已写入 `components/L2_<code>_binding.json`，共 16 份。

## Legacy Contract Comparison

- MATCHED: {legacy_counts.get('MATCHED', 0)}
- AMBIGUOUS: {legacy_counts.get('AMBIGUOUS', 0)}
- NOT_FOUND: {legacy_counts.get('NOT_FOUND', 0)}
- CONFLICT: {legacy_counts.get('CONFLICT', 0)}

| Binding | Conflict fields | Authoritative SSD connector |
|---|---|---|
{conflict_rows}

`AMBIGUOUS` 通常表示旧合同把一个物理接口展开为多个仿真量。该历史展开不会自动变成新的 SSD Connector 或 FMU variable。

## 命名与映射规则

- Simulink external port 默认等于 SSD Connector name。
- FMU variable 默认等于 SSD Connector name。
- 本基线未使用 hash 或 UUID 生成别名。
- 若名称技术上不合法，仅进行可读的字符清洗，并在 `alias_reason` 中记录。
- SSD `input` 映射为 Simulink `Inport` 和 FMU `input`。
- SSD `output` 映射为 Simulink `Outport` 和 FMU `output`。
- SSD 未提供显式 Connector `id` 属性，因此 `ssd_connector_id` 使用 `<component>.<connector>` 的限定身份，并显式记录其来源。

## 未来实施流程

```text
SSD
↓
Binding Baseline
↓
16 Simulink models
↓
FMU export
↓
FMU interface validation
↓
SSD-driven co-simulation
```

本次仅完成 Binding Baseline；未生成 Simulink 模型、Skeleton 或 FMU，也未运行 MATLAB、联合仿真、SSI Simulator、SysON 或 SysIDE。

## 最终状态

```text
FMU_BINDING_COMPONENTS = {len(components)}/{EXPECTED_COMPONENTS}
FMU_BINDING_CONNECTORS = {len(connector_bindings)}/{EXPECTED_CONNECTORS}
FMU_BINDING_CONNECTIONS = {len(connection_bindings)}/{EXPECTED_CONNECTIONS}
READY_CONNECTORS = {ready_connectors}
REVIEW_REQUIRED_CONNECTORS = {review_connectors}
LEGACY_CONTRACT_CONFLICTS = {legacy_counts.get('CONFLICT', 0)}
ORIGINAL_SSD_MODIFIED = {'YES' if original_ssd_modified else 'NO'}
FULL_SYSML_MODIFIED = {'YES' if full_sysml_modified else 'NO'}
FMU_IMPLEMENTATION_BINDING_BASELINE = {overall_status}
```
"""
    REPORT_OUT.write_text(report, encoding="utf-8")

    print(f"FMU_BINDING_COMPONENTS = {len(components)}/{EXPECTED_COMPONENTS}")
    print(f"FMU_BINDING_CONNECTORS = {len(connector_bindings)}/{EXPECTED_CONNECTORS}")
    print(f"FMU_BINDING_CONNECTIONS = {len(connection_bindings)}/{EXPECTED_CONNECTIONS}")
    print(f"READY_CONNECTORS = {ready_connectors}")
    print(f"REVIEW_REQUIRED_CONNECTORS = {review_connectors}")
    print(f"LEGACY_CONTRACT_CONFLICTS = {legacy_counts.get('CONFLICT', 0)}")
    print(f"ORIGINAL_SSD_MODIFIED = {'YES' if original_ssd_modified else 'NO'}")
    print(f"FULL_SYSML_MODIFIED = {'YES' if full_sysml_modified else 'NO'}")
    print(f"FMU_IMPLEMENTATION_BINDING_BASELINE = {overall_status}")
    return 0 if structural_pass else 1


if __name__ == "__main__":
    sys.exit(main())
