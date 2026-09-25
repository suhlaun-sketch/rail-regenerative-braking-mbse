"""Build the CRH_AC25KV_SC default-active profile and instance activity state."""

from __future__ import annotations

import argparse
from pathlib import Path

from common import PROFILE_CONFIG, PROFILE_ID, WORK_DIR, read_json, write_json


def load_profile() -> dict:
    config = read_json(PROFILE_CONFIG)
    matches = [profile for profile in config.get("profiles", []) if profile["profile_id"] == PROFILE_ID]
    if len(matches) != 1:
        raise ValueError(f"Profile {PROFILE_ID} 必须且只能定义一次")
    return matches[0]


def port_identity(port: dict[str, str]) -> tuple[str, str, str]:
    return port["code"], port["端口名称"], port["交换内容"]


def build_profile_state(inventory: dict, cleaned: dict, profile: dict) -> dict:
    selected_codes = {node["code"] for node in inventory["selection"]["leaves"]}
    selected_by_code = {node["code"]: node for node in inventory["selection"]["leaves"]}
    unknown_nodes = sorted(set(profile["node_rules"]) - selected_codes)
    if unknown_nodes:
        raise ValueError(f"Profile引用非入选叶节点: {unknown_nodes}")

    port_overrides: dict[tuple[str, str, str], dict] = {}
    for override in profile.get("port_overrides", []):
        key = (override["code"], override["port_name"], override["item"])
        if key in port_overrides:
            raise ValueError(f"Profile重复Port override: {key}")
        port_overrides[key] = override

    match_counts = {key: 0 for key in port_overrides}
    port_states = []
    for source_index, port in enumerate(cleaned["ports"], start=1):
        code = port["code"]
        node_rule = profile["node_rules"].get(code, {})
        node_active = bool(node_rule.get("active", profile["default_node_active"]))
        key = port_identity(port)
        port_override = port_overrides.get(key)
        if port_override:
            match_counts[key] += 1
        port_active = bool(
            port_override.get("active", profile["default_port_active"])
            if port_override
            else profile["default_port_active"]
        )
        active = node_active and port_active
        if not node_active:
            reason = node_rule.get("reason", "节点在当前Profile中停用。")
        elif port_override and not port_active:
            reason = port_override["reason"]
        else:
            reason = "默认Active；无当前方案停用override。"
        port_states.append(
            {
                "source_index": source_index,
                "code": code,
                "name": port["name"],
                "port_name": port["端口名称"],
                "item": port["交换内容"],
                "active": active,
                "reason": reason,
            }
        )

    bad_matches = {key: count for key, count in match_counts.items() if count != 1}
    if bad_matches:
        raise ValueError(f"Port override必须且只能匹配一个Clean Raw Port: {bad_matches}")

    profile_rows = []
    for code, rule in profile["node_rules"].items():
        node = selected_by_code[code]
        profile_rows.append(
            {
                "profile_id": profile["profile_id"],
                "profile_name": profile["profile_name"],
                "object_type": "NODE",
                "code": code,
                "port_name": "",
                "item": "",
                "active": bool(rule["active"]),
                "reason": rule["reason"],
                "applicability": rule["applicability"],
                "object_name": node["name"],
            }
        )
    for override in profile.get("port_overrides", []):
        profile_rows.append(
            {
                "profile_id": profile["profile_id"],
                "profile_name": profile["profile_name"],
                "object_type": "PORT",
                "code": override["code"],
                "port_name": override["port_name"],
                "item": override["item"],
                "active": bool(override["active"]),
                "reason": override["reason"],
                "applicability": "AC/DC Variant",
                "object_name": selected_by_code[override["code"]]["name"],
            }
        )

    return {
        "profile_id": profile["profile_id"],
        "profile_name": profile["profile_name"],
        "default_node_active": bool(profile["default_node_active"]),
        "default_port_active": bool(profile["default_port_active"]),
        "profile_rows": profile_rows,
        "port_states": port_states,
        "active_port_count": sum(state["active"] for state in port_states),
        "inactive_port_count": sum(not state["active"] for state in port_states),
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--inventory", type=Path, default=WORK_DIR / "input_inventory.json")
    parser.add_argument("--cleaned", type=Path, default=WORK_DIR / "cleaned_ports.json")
    parser.add_argument("--output", type=Path, default=WORK_DIR / "profile_state.json")
    args = parser.parse_args()
    result = build_profile_state(read_json(args.inventory), read_json(args.cleaned), load_profile())
    write_json(args.output, result)
    print(f"Profile: {result['profile_id']}")
    print(f"Active Port数: {result['active_port_count']}")
    print(f"Inactive Variant Port数: {result['inactive_port_count']}")
    print(f"Profile状态: {args.output.resolve()}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
