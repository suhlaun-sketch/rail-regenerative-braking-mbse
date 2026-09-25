"""Build a deterministic SSI-compatible L2 projection from frozen Rail SysML."""

from __future__ import annotations

import hashlib
import json
import re
from collections import defaultdict
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
SOURCE_DIR = ROOT / "work/sysmlv2/full_engineering_model/01_generated"
OUT = ROOT / "work/sysmlv2/ssi_integration/02_projection"
LOGS = ROOT / "work/sysmlv2/ssi_integration/04_logs"
SELECTED = ("4200", "4500", "5100", "5300", "7200", "X100", "3500", "3100")

PRODUCTS = SOURCE_DIR / "05_ProductDefinitions.sysml"
PORTS = SOURCE_DIR / "03_PortDefinitions.sysml"
INTERFACES = SOURCE_DIR / "04_InterfaceDefinitions.sysml"
SYSTEM = SOURCE_DIR / "07_SystemDefinition.sysml"


def blocks(text: str, keyword: str) -> dict[str, str]:
    lines = text.splitlines()
    result: dict[str, str] = {}
    i = 0
    start_re = re.compile(rf"^\s*{re.escape(keyword)}\s+(\w+)\s*\{{")
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


def l2_for(endpoint: str) -> str | None:
    tokens = endpoint.split(".")
    for code in SELECTED:
        expected = f"p_N_{code}" if code.isdigit() else f"p_{code}"
        if expected in tokens:
            return code
    return None


def product_code_from_def(name: str) -> str:
    return name.removeprefix("P_N_").removeprefix("P_")


def component_name(code: str) -> str:
    return f"L2_{code}"


def main() -> None:
    OUT.mkdir(parents=True, exist_ok=True)
    LOGS.mkdir(parents=True, exist_ok=True)

    product_blocks = blocks(PRODUCTS.read_text(encoding="utf-8"), "part def")
    port_blocks = blocks(PORTS.read_text(encoding="utf-8"), "port def")
    interface_blocks = blocks(INTERFACES.read_text(encoding="utf-8"), "interface def")

    product_port_types: dict[tuple[str, str], str] = {}
    product_names: dict[str, str] = {}
    for definition, block in product_blocks.items():
        code = product_code_from_def(definition)
        name_match = re.search(r'attribute\s+chineseName\s*:\s*String\s*=\s*"([^"]*)";', block)
        if name_match:
            product_names[code] = name_match.group(1)
        for match in re.finditer(r"^\s*port\s+(\w+)\s*:\s*([~]?\w+)\s*\{", block, re.MULTILINE):
            product_port_types[(code, match.group(1))] = match.group(2)

    conn_re = re.compile(
        r"^\s*interface\s+(\w+)\s*:\s*(\w+)\s+connect\s+([\w.]+)\s+to\s+([\w.]+)\s*\{",
        re.MULTILINE,
    )
    selected_connections = []
    component_ports: dict[str, dict[str, str]] = defaultdict(dict)
    used_interfaces: set[str] = set()
    used_port_defs: set[str] = set()

    for match in conn_re.finditer(SYSTEM.read_text(encoding="utf-8")):
        connection_id, interface_type, source, target = match.groups()
        source_l2, target_l2 = l2_for(source), l2_for(target)
        if not source_l2 or not target_l2 or source_l2 == target_l2:
            continue
        source_tokens, target_tokens = source.split("."), target.split(".")
        source_leaf = source_tokens[-2].removeprefix("p_N_").removeprefix("p_")
        target_leaf = target_tokens[-2].removeprefix("p_N_").removeprefix("p_")
        source_raw, target_raw = source_tokens[-1], target_tokens[-1]
        source_type = product_port_types[(source_leaf, source_raw)]
        target_type = product_port_types[(target_leaf, target_raw)]
        source_promoted = f"p_{source_leaf}_{source_raw}"
        target_promoted = f"p_{target_leaf}_{target_raw}"
        component_ports[source_l2][source_promoted] = source_type
        component_ports[target_l2][target_promoted] = target_type
        used_interfaces.add(interface_type)
        used_port_defs.update((source_type.lstrip("~"), target_type.lstrip("~")))
        selected_connections.append(
            {
                "connection_id": connection_id,
                "interface_type": interface_type,
                "source_original": source,
                "target_original": target,
                "source_l2": source_l2,
                "target_l2": target_l2,
                "source_port": source_promoted,
                "target_port": target_promoted,
                "source_port_type": source_type,
                "target_port_type": target_type,
            }
        )

    used_items = set()
    for port_type in used_port_defs:
        match = re.search(r"out\s+item\s+\w+\s*:\s*(\w+)\s*;", port_blocks[port_type])
        if match:
            used_items.add(match.group(1))

    general_lines = ["package general_definition {"]
    for code in SELECTED:
        definition = f"P_N_{code}" if code.isdigit() else f"P_{code}"
        general_lines.append(f"    part def {definition};")
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
    for code in SELECTED:
        definition = f"P_N_{code}" if code.isdigit() else f"P_{code}"
        system_lines.append(f"    part {component_name(code)} : {definition} {{")
        system_lines.append(f'        attribute sourceProductCode = "{code}";')
        for port_name, port_type in sorted(component_ports[code].items()):
            system_lines.append(f"        port {port_name} : {port_type};")
        system_lines.append("    }")
    for conn in selected_connections:
        system_lines.append(
            "    interface {id} : {itype} connect {src}.{sp} to {dst}.{tp};".format(
                id=conn["connection_id"],
                itype=conn["interface_type"],
                src=component_name(conn["source_l2"]),
                sp=conn["source_port"],
                dst=component_name(conn["target_l2"]),
                tp=conn["target_port"],
            )
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

    manifest = {
        "authoritative_source": str(SOURCE_DIR / "Rail_MBSE_Full_v1.sysml"),
        "source_files": [str(PRODUCTS), str(PORTS), str(INTERFACES), str(SYSTEM)],
        "source_sha256": {p.name: hashlib.sha256(p.read_bytes()).hexdigest() for p in (PRODUCTS, PORTS, INTERFACES, SYSTEM)},
        "selected_l2_codes": list(SELECTED),
        "components": len(SELECTED),
        "ports": sum(len(v) for v in component_ports.values()),
        "interfaces": len(used_interfaces),
        "connections": len(selected_connections),
        "component_names": {code: product_names.get(code, "") for code in SELECTED},
        "connections_mapping": selected_connections,
        "generated_files": [str(OUT / name) for name in outputs],
    }
    (OUT / "projection_manifest.json").write_text(
        json.dumps(manifest, ensure_ascii=False, indent=2), encoding="utf-8"
    )
    print(json.dumps({k: v for k, v in manifest.items() if k != "connections_mapping"}, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
