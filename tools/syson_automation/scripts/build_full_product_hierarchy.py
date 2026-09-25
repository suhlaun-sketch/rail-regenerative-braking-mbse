"""Validate the authoritative Product hierarchy in frozen SysML v1."""
from __future__ import annotations

import json
import re
from collections import Counter, defaultdict
from pathlib import Path

from tools.syson_automation.scripts.audit_port_gaps import MODEL, _blocks

ROOT = Path(__file__).resolve().parents[3]
OUT = ROOT / "work/reports/FULL_PRODUCT_HIERARCHY.json"


def build_hierarchy() -> dict:
    source = MODEL.read_text(encoding="utf-8")
    rows = []
    for definition, body in _blocks(source).items():
        code_match = re.search(r'attribute productCode\s*:\s*String\s*=\s*"([^"]+)"', body)
        if not code_match:
            continue
        level_match = re.search(r'attribute level\s*:\s*Integer\s*=\s*(\d+)', body)
        parent_match = re.search(r'attribute parentCode\s*:\s*String\s*=\s*"([^"]*)"', body)
        if not level_match or not parent_match:
            raise ValueError(f"Product {definition} lacks formal level/parentCode")
        code = code_match.group(1)
        rows.append({"product_code": code, "definition_id": definition,
                     "usage_id": "p_" + definition[2:],
                     "level": int(level_match.group(1)), "parent_code": parent_match.group(1) or None})
    by_code = {r["product_code"]: r for r in rows}
    errors = []
    if len(by_code) != len(rows):
        errors.append("duplicate productCode")
    children = defaultdict(list)
    for row in rows:
        code, level, parent = row["product_code"], row["level"], row["parent_code"]
        if level not in (1, 2, 3, 4):
            errors.append(f"{code}: invalid level {level}")
        if level == 1 and parent:
            errors.append(f"{code}: L1 has parent {parent}")
        if level > 1:
            if not parent or parent not in by_code:
                errors.append(f"{code}: orphan parent {parent}")
            else:
                if by_code[parent]["level"] >= level:
                    errors.append(f"{code}: parent level not below child")
                if by_code[parent]["level"] != level - 1:
                    errors.append(f"{code}: nonconsecutive formal level")
                children[parent].append(code)
        seen, cur = set(), code
        while cur and cur in by_code:
            if cur in seen:
                errors.append(f"{code}: hierarchy cycle")
                break
            seen.add(cur)
            cur = by_code[cur]["parent_code"]
    for row in rows:
        code = row["product_code"]
        row["direct_children"] = sorted(children.get(code, []))
        path = [code]
        cur = row["parent_code"]
        while cur and cur in by_code and cur not in path:
            path.append(cur)
            cur = by_code[cur]["parent_code"]
        row["hierarchy_path"] = list(reversed(path))
    levels = dict(sorted(Counter(x["level"] for x in rows).items()))
    expected = {1: 8, 2: 16, 3: 34, 4: 89}
    if levels != expected:
        errors.append(f"level counts {levels} != {expected}")
    result = {"source_model": str(MODEL), "total": len(rows), "level_counts": levels,
              "container_codes": sorted(x["product_code"] for x in rows if x["direct_children"]),
              "products": sorted(rows, key=lambda x: (x["level"], x["product_code"])),
              "errors": errors, "status": "PASS" if not errors else "FAIL"}
    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text(json.dumps(result, ensure_ascii=False, indent=2), encoding="utf-8")
    if errors:
        raise ValueError("; ".join(errors[:5]))
    return result


if __name__ == "__main__":
    data = build_hierarchy()
    print(f"HIERARCHY=PASS TOTAL={data['total']} LEVELS={data['level_counts']} CONTAINERS={len(data['container_codes'])}")
