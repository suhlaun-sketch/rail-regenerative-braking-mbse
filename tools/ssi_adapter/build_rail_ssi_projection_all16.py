"""Generate the complete 16-L2 SSI view from the frozen Full Rail SysML."""

from __future__ import annotations

import hashlib
import json
import re
from collections import defaultdict
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
FULL = ROOT / "work/sysmlv2/full_engineering_model"
SOURCE = FULL / "01_generated"
MAPPING_PAYLOAD = FULL / "02_mapping/mapping_payload.json"
OUT = ROOT / "work/sysmlv2/ssi_integration/02_projection_all16"
REPORTS = ROOT / "work/sysmlv2/ssi_integration/05_reports"

PRODUCTS = SOURCE / "05_ProductDefinitions.sysml"
PORTS = SOURCE / "03_PortDefinitions.sysml"
INTERFACES = SOURCE / "04_InterfaceDefinitions.sysml"
SYSTEM = SOURCE / "07_SystemDefinition.sysml"


def definition_blocks(text: str, keyword: str) -> dict[str, str]:
    lines = text.splitlines()
    result: dict[str, str] = {}
    start_re = re.compile(rf"^\s*{re.escape(keyword)}\s+(\w+)\s*\{{")
    i = 0
    while i < len(lines):
        match = start_re.match(lines[i])
        if not match:
            i += 1
            continue
        name = match.group(1)
        depth = lines[i].count("{") - lines[i].count("}")
        chunk = [lines[i]]
        i += 1
        while i < len(lines) and depth > 0:
            chunk.append(lines[i])
            depth += lines[i].count("{") - lines[i].count("}")
            i += 1
        result[name] = "\n".join(chunk)
    return result


def code_from_definition(name: str) -> str:
    return name.removeprefix("P_N_").removeprefix("P_")


def definition_for(code: str) -> str:
    return f"P_N_{code}" if code.isdigit() else f"P_{code}"


def usage_token(code: str) -> str:
    return f"p_N_{code}" if code.isdigit() else f"p_{code}"


def attr(block: str, name: str) -> str | None:
    match = re.search(rf'attribute\s+{re.escape(name)}\s*:\s*\w+\s*=\s*(?:"([^"]*)"|([^;]+));', block)
    return (match.group(1) if match and match.group(1) is not None else match.group(2).strip()) if match else None


def parse_product_ports(block: str) -> dict[str, dict]:
    lines = block.splitlines()
    result = {}
    start_re = re.compile(r"^\s*port\s+(\w+)\s*:\s*([~]?\w+)\s*\{")
    i = 0
    while i < len(lines):
        match = start_re.match(lines[i])
        if not match:
            i += 1
            continue
        name, port_type = match.groups()
        depth = lines[i].count("{") - lines[i].count("}")
        chunk = [lines[i]]
        i += 1
        while i < len(lines) and depth > 0:
            chunk.append(lines[i])
            depth += lines[i].count("{") - lines[i].count("}")
            i += 1
        port_block = "\n".join(chunk)
        result[name] = {
            "port_type": port_type,
            "source_port_id": attr(port_block, "sourcePortId"),
            "port_name": attr(port_block, "portName"),
            "direction": attr(port_block, "direction"),
            "active": attr(port_block, "activeStatus"),
        }
    return result


def main() -> None:
    OUT.mkdir(parents=True, exist_ok=True)
    REPORTS.mkdir(parents=True, exist_ok=True)
    product_blocks = definition_blocks(PRODUCTS.read_text(encoding="utf-8"), "part def")
    port_blocks = definition_blocks(PORTS.read_text(encoding="utf-8"), "port def")
    interface_blocks = definition_blocks(INTERFACES.read_text(encoding="utf-8"), "interface def")

    products = {}
    product_ports = {}
    for definition, block in product_blocks.items():
        code = code_from_definition(definition)
        level = attr(block, "level")
        if not level:
            continue
        products[code] = {
            "code": code,
            "definition": definition,
            "name": attr(block, "chineseName") or "",
            "level": int(level),
            "parent": attr(block, "parentCode") or "",
        }
        product_ports[code] = parse_product_ports(block)

    l2_codes = sorted(code for code, product in products.items() if product["level"] == 2)
    if len(l2_codes) != 16:
        raise RuntimeError(f"Expected 16 L2 products from Full SysML, found {len(l2_codes)}: {l2_codes}")
    token_to_l2 = {usage_token(code): code for code in l2_codes}

    children = defaultdict(list)
    for code, product in products.items():
        if product["parent"]:
            children[product["parent"]].append(code)

    def descendants(code: str) -> list[str]:
        found = []
        stack = list(children[code])
        while stack:
            child = stack.pop()
            found.append(child)
            stack.extend(children[child])
        return found

    hierarchy_payload = json.loads(MAPPING_PAYLOAD.read_text(encoding="utf-8"))
    product_trace = {str(row["Product_Code"]): row for row in hierarchy_payload["product_hierarchy"]}
    raw_port_rows = {}
    for row in hierarchy_payload["raw_ports"]:
        raw_name = row["SysML_Port_Path"].split(".")[-1]
        raw_port_rows[(str(row["Leaf_Code"]), raw_name)] = row
    port_trace = {
        row["Port_ID"]: row
        for row in hierarchy_payload["traceability"]
        if row.get("Port_ID")
    }

    def l2_for(endpoint: str) -> str | None:
        for token in endpoint.split("."):
            if token in token_to_l2:
                return token_to_l2[token]
        return None

    conn_re = re.compile(
        r"^\s*interface\s+(\w+)\s*:\s*(\w+)\s+connect\s+([\w.]+)\s+to\s+([\w.]+)\s*\{",
        re.MULTILINE,
    )
    projected_connections = []
    promoted_ports: dict[str, dict[str, dict]] = defaultdict(dict)
    used_interfaces = set()
    used_port_defs = set()

    for match in conn_re.finditer(SYSTEM.read_text(encoding="utf-8")):
        usage_name, interface_type, source, target = match.groups()
        source_l2, target_l2 = l2_for(source), l2_for(target)
        if not source_l2 or not target_l2 or source_l2 == target_l2:
            continue
        source_tokens, target_tokens = source.split("."), target.split(".")
        source_leaf = source_tokens[-2].removeprefix("p_N_").removeprefix("p_")
        target_leaf = target_tokens[-2].removeprefix("p_N_").removeprefix("p_")
        source_raw, target_raw = source_tokens[-1], target_tokens[-1]
        source_meta = product_ports[source_leaf][source_raw]
        target_meta = product_ports[target_leaf][target_raw]
        source_promoted = f"p_{source_leaf}_{source_raw}"
        target_promoted = f"p_{target_leaf}_{target_raw}"
        interface_block = interface_blocks[interface_type]
        item_sysml = re.search(r"flow\s+of\s+(\w+)\s+from", interface_block).group(1)
        item_code = item_sysml.removeprefix("I_").replace("_", "-")
        connection_id = usage_name.removeprefix("c_")

        for l2, leaf, raw, promoted, original, meta in (
            (source_l2, source_leaf, source_raw, source_promoted, source, source_meta),
            (target_l2, target_leaf, target_raw, target_promoted, target, target_meta),
        ):
            row = raw_port_rows.get((leaf, raw), {})
            trace = port_trace.get(meta.get("source_port_id"), {})
            record = promoted_ports[l2].setdefault(
                promoted,
                {
                    "l2_code": l2,
                    "promoted_port": promoted,
                    "port_type": meta["port_type"],
                    "original_leaf_code": leaf,
                    "original_raw_port": raw,
                    "original_port_id": meta.get("source_port_id"),
                    "original_port_name": meta.get("port_name"),
                    "original_sysml_path": original,
                    "item_code": row.get("Item_Code") or item_code,
                    "item_name": row.get("Item_Name"),
                    "direction": meta.get("direction") or row.get("Direction"),
                    "active_status": meta.get("active") or row.get("Active_Status"),
                    "source_file": trace.get("Source_File"),
                    "source_sheet": trace.get("Source_Sheet"),
                    "source_row": trace.get("Source_Row"),
                    "connection_ids": [],
                },
            )
            if connection_id not in record["connection_ids"]:
                record["connection_ids"].append(connection_id)

        used_interfaces.add(interface_type)
        used_port_defs.update((source_meta["port_type"].lstrip("~"), target_meta["port_type"].lstrip("~")))
        projected_connections.append(
            {
                "connection_id": connection_id,
                "connection_usage": usage_name,
                "interface_type": interface_type,
                "item_sysml": item_sysml,
                "item_code": item_code,
                "source_original": source,
                "target_original": target,
                "source_l2": source_l2,
                "target_l2": target_l2,
                "source_promoted_port": source_promoted,
                "target_promoted_port": target_promoted,
                "source_port_type": source_meta["port_type"],
                "target_port_type": target_meta["port_type"],
            }
        )

    used_items = set()
    for port_type in used_port_defs:
        match = re.search(r"out\s+item\s+\w+\s*:\s*(\w+)\s*;", port_blocks[port_type])
        if match:
            used_items.add(match.group(1))

    general_lines = ["package general_definition {"]
    for code in l2_codes:
        general_lines.append(f"    part def {definition_for(code)};")
    for item in sorted(used_items):
        general_lines.append(f"    item def {item};")
    general_lines.append("}")

    port_lines = ["package port_definition {", "    private import general_definition::*;"]
    for name in sorted(used_port_defs):
        port_lines.extend("    " + line.strip() for line in port_blocks[name].splitlines())
    port_lines.append("}")

    interface_lines = [
        "package interface_definition {",
        "    private import general_definition::*;",
        "    private import port_definition::*;",
    ]
    for name in sorted(used_interfaces):
        interface_lines.extend("    " + line.strip() for line in interface_blocks[name].splitlines())
    interface_lines.append("}")

    system_lines = [
        "package system_definition {",
        "    private import general_definition::*;",
        "    private import port_definition::*;",
        "    private import interface_definition::*;",
    ]
    for code in l2_codes:
        system_lines.append(f"    part L2_{code} : {definition_for(code)} {{")
        system_lines.append(f'        attribute sourceProductCode = "{code}";')
        for promoted, record in sorted(promoted_ports[code].items()):
            system_lines.append(f"        port {promoted} : {record['port_type']};")
        system_lines.append("    }")
    for conn in projected_connections:
        system_lines.append(
            f"    interface {conn['connection_usage']} : {conn['interface_type']} connect "
            f"L2_{conn['source_l2']}.{conn['source_promoted_port']} to "
            f"L2_{conn['target_l2']}.{conn['target_promoted_port']};"
        )
    system_lines.append("}")

    outputs = {
        "general_definition.sysml": "\n".join(general_lines) + "\n",
        "port_definition.sysml": "\n".join(port_lines) + "\n",
        "interface_definition.sysml": "\n".join(interface_lines) + "\n",
        "system_definition.sysml": "\n".join(system_lines) + "\n",
    }
    for name, text in outputs.items():
        (OUT / name).write_text(text, encoding="utf-8")

    inventory = []
    for code in l2_codes:
        desc = descendants(code)
        trace = product_trace.get(code, {})
        inventory.append(
            {
                "code": code,
                "name": products[code]["name"],
                "full_sysml_path": trace.get("SysML_Usage") or f"SystemDefinition::railSystem.{usage_token(products[code]['parent'])}.{usage_token(code)}",
                "parent_l1": products[code]["parent"],
                "l3_count": sum(products[d]["level"] == 3 for d in desc),
                "l4_count": sum(products[d]["level"] == 4 for d in desc),
            }
        )

    manifest = {
        "authoritative_source": str(SOURCE / "Rail_MBSE_Full_v1.sysml"),
        "full_model_sha256": hashlib.sha256((SOURCE / "Rail_MBSE_Full_v1.sysml").read_bytes()).hexdigest(),
        "source_sha256": {p.name: hashlib.sha256(p.read_bytes()).hexdigest() for p in (PRODUCTS, PORTS, INTERFACES, SYSTEM)},
        "l2_inventory": inventory,
        "components": len(l2_codes),
        "promoted_ports": sum(len(records) for records in promoted_ports.values()),
        "interface_definitions": len(used_interfaces),
        "cross_l2_connections": len(projected_connections),
        "promoted_port_mapping": [record for code in l2_codes for record in promoted_ports[code].values()],
        "connection_mapping": projected_connections,
        "generated_files": [str(OUT / name) for name in outputs],
    }
    (OUT / "projection_manifest.json").write_text(json.dumps(manifest, ensure_ascii=False, indent=2), encoding="utf-8")

    lines = [
        "# All 16 L2 Inventory",
        "",
        f"Authoritative source: `{SOURCE / 'Rail_MBSE_Full_v1.sysml'}`",
        "",
        "| L2 Code | L2 Name | Full SysML Path | Parent L1 | L3 Count | L4 Count |",
        "|---|---|---|---|---:|---:|",
    ]
    for row in inventory:
        lines.append(
            f"| {row['code']} | {row['name']} | `{row['full_sysml_path']}` | {row['parent_l1']} | {row['l3_count']} | {row['l4_count']} |"
        )
    lines.extend(["", f"L2 count: **{len(inventory)}**"])
    (REPORTS / "All16_L2_Inventory.md").write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(json.dumps({k: v for k, v in manifest.items() if k not in {"promoted_port_mapping", "connection_mapping"}}, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
