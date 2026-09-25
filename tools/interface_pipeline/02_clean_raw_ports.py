"""Apply explicit semantic cleaning rules to Raw Ports without generating links."""

from __future__ import annotations

import argparse
from collections import Counter
from pathlib import Path

from common import RAW_PORT_COLUMNS, WORK_DIR, read_json, write_json
from rules import ADD_PORT_RULES, DELETE_PORT_RULES, MODIFY_PORT_RULES, port_rule_key


def clean_ports(inventory: dict) -> dict:
    source_ports = inventory["primary_audit"]["ports"]
    cleaned: list[dict[str, str]] = []
    deleted: list[dict[str, str]] = []
    modified: list[dict[str, object]] = []

    matched_deletions: set[tuple[str, str, str]] = set()
    matched_modifications: set[tuple[str, str, str]] = set()
    for original in source_ports:
        port = dict(original)
        key = port_rule_key(port)
        if key in DELETE_PORT_RULES:
            matched_deletions.add(key)
            deleted.append({**port, "reason": DELETE_PORT_RULES[key]})
            continue
        if key in MODIFY_PORT_RULES:
            matched_modifications.add(key)
            before = dict(port)
            port.update(MODIFY_PORT_RULES[key])
            modified.append(
                {
                    "before": before,
                    "after": dict(port),
                    "reason": MODIFY_PORT_RULES[key].get("reason", "确定性清洗规则修改。"),
                }
            )
            port.pop("reason", None)
        cleaned.append(port)

    unmatched_delete = set(DELETE_PORT_RULES) - matched_deletions
    unmatched_modify = set(MODIFY_PORT_RULES) - matched_modifications
    if unmatched_delete or unmatched_modify:
        raise ValueError(
            f"清洗规则未匹配输入。DELETE={sorted(unmatched_delete)} MODIFY={sorted(unmatched_modify)}"
        )

    added: list[dict[str, str]] = []
    for rule in ADD_PORT_RULES:
        missing = [column for column in RAW_PORT_COLUMNS if column not in rule]
        if missing:
            raise ValueError(f"新增Port规则缺少字段: {missing}")
        port = {column: str(rule[column]).strip() for column in RAW_PORT_COLUMNS}
        cleaned.append(port)
        added.append({**port, "reason": rule.get("reason", "确定性新增规则。")})

    duplicate_keys = [
        key
        for key, count in Counter(tuple(port[column] for column in RAW_PORT_COLUMNS) for port in cleaned).items()
        if count > 1
    ]
    if duplicate_keys:
        raise ValueError(f"清洗后出现完全重复Raw Port: {duplicate_keys[:5]}")

    return {
        "before_count": len(source_ports),
        "after_count": len(cleaned),
        "deleted_count": len(deleted),
        "modified_count": len(modified),
        "added_count": len(added),
        "deleted": deleted,
        "modified": modified,
        "added": added,
        "ports": cleaned,
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--input", type=Path, default=WORK_DIR / "input_inventory.json")
    parser.add_argument("--output", type=Path, default=WORK_DIR / "cleaned_ports.json")
    args = parser.parse_args()
    result = clean_ports(read_json(args.input))
    write_json(args.output, result)
    print(f"清洗前Port数: {result['before_count']}")
    print(f"清洗后Port数: {result['after_count']}")
    print(
        f"删除/修改/新增: {result['deleted_count']}/"
        f"{result['modified_count']}/{result['added_count']}"
    )
    print(f"清洗结果: {args.output.resolve()}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
