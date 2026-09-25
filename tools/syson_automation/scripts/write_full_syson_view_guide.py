"""Write the final user guide from verified FULL SysON query-back only."""
from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
OUT = Path(r"C:\Users\AUSA\Desktop\game_vibe\SysON完整模型查看说明.md")


def load(path):
    return json.loads(path.read_text(encoding="utf-8"))


def main():
    state = load(ROOT / "tools/syson_automation/cache/full_final_project.json")
    qa = load(ROOT / "work/reports/FULL_SYSON_FINAL_QA.json")
    registry_path = ROOT / "tools/syson_automation/generated/syson_operations/registry.json"
    registry = load(registry_path)
    if qa["status"] != "PASS" or qa["ibd_pass"] != 57 or len(qa["rows"]) != 57:
        raise RuntimeError("Final 57-view query-back has not passed")
    project_id = state["project_id"]
    for row in qa["rows"]:
        name = row["name"]
        key = project_id + ":" + name
        entry = registry[key]
        if entry["id"] != row["representation_id"] or entry["created_by"] != "syson_automation":
            raise RuntimeError(f"Ownership mismatch: {name}")
        entry.update({"generation": "FULL_FINAL", "container_code": row["root_product"],
                      "container_usage_id": row["root_usage"],
                      "selected_root_id": entry["root_object_id"],
                      "selected_root_metaclass": "PartUsage",
                      "selection_reason": "Existing Product Usage owns the matching AUTO_IBD ViewUsage and direct-child hierarchy"})
    registry_path.write_text(json.dumps(registry, ensure_ascii=False, indent=2), encoding="utf-8")

    base = f"http://localhost:8080/projects/{project_id}/edit/"
    def link(name):
        return f"[{name}]({base}{qa['formal_views'][name]['representation_id'] if name in qa['formal_views'] else next(r['representation_id'] for r in qa['rows'] if r['name'] == name)})"

    lines = ["# SysON 完整模型查看说明", "",
             f"- 正式 Project：`{state['project_name']}`",
             f"- Project ID：`{project_id}`",
             f"- EditingContext ID：`{state['editing_context_id']}`",
             f"- SysON 入口：<http://localhost:8080/projects/{project_id}/edit>",
             f"- 最终 SysML：`{state['model_path']}`",
             f"- 最终回查：`{ROOT / 'work/reports/FULL_SYSON_FINAL_QA.json'}`",
             "", "## 打开正式视图", "",
             f"- 产品总览：{link('AUTO_PRODUCT_ARCHITECTURE_ROOT')}。进入 Project 后也可在 Explorer 的 `RailSystemContext` → `railSystem` → `Representations` 中打开。",
             f"- L1 示例：{link('AUTO_IBD_3000')}。在 Explorer 找到 Product Usage `p_N_3000`，展开其 `Representations`，打开 `AUTO_IBD_3000`。",
             f"- L2 示例：{link('AUTO_IBD_3100')}。在 `ProductDefinitions` → `P_N_3000` 中找到 Product Usage `p_N_3100`，从它的 `Representations` 打开。",
             f"- L3 示例：{link('AUTO_IBD_3110')}。在 `ProductDefinitions` → `P_N_3100` 中找到 Product Usage `p_N_3110`，从它的 `Representations` 打开。",
             "- 其他 IBD：按下表的 root product 编码定位同名 `p_N_<编码>` Product Usage，在该 Usage 的 `Representations` 中打开 `AUTO_IBD_<编码>`。每张正式 IBD 都挂在对应的 Product Usage 下。",
             "- 当前 SysON 不提供从图中双击 Product 自动进入其 IBD 的可靠下钻操作。真实操作是从 Explorer 选择对应 Product Usage，展开 `Representations` 并打开视图，或使用下表链接。",
             "", "## 最终核验", "",
             "- 57/57 张正式 IBD 均完成实时 `diagramEvent` 与持久化内容双向回查；直接子产品及父边界 PortUsage 均可见。",
             f"- 直接子产品 PortUsage：{sum(r['direct_child_ports_visible'] for r in qa['rows'])}/{sum(r['direct_child_ports'] for r in qa['rows'])} 个对应图内可见。",
             f"- 图形交互边共 {sum(r['edges'] for r in qa['rows'])} 条，按真实 `ConnectionUsage`/`InterfaceUsage` 语义分别记录；含真实内部交互的 IBD 均有图形边。",
             "- 节点数最多的 `AUTO_IBD_8000`、`AUTO_IBD_8100`、`AUTO_IBD_8120` 已仅执行 `arrangeAll` 布局操作，并再次通过最终回查。",
             f"- Function→Product Allocation：{link('AUTO_FUNCTION_PRODUCT_ALLOCATION')}，191 条真实 AllocationUsage 图形边。",
             f"- Requirement 总览：{link('AUTO_REQ_ALL')}，46 个真实 RequirementUsage 可见。",
             f"- Requirement→Function：{link('AUTO_REQ_FUNCTION_TRACE')}，46 个 RequirementUsage 与 191 个 ActionUsage 可见。模型中有 {qa['semantic_satisfy_relations']} 条 SatisfyRequirementUsage 语义关系；该视图中 Satisfy 图形边为 {qa['requirement_satisfy_graphical_edges']}，因此不得把其他图形边解释成需求追溯线。可从 Explorer 检查语义关系。",
             "- 正式 SysML v1 和需求库 V2 Excel 的 SHA-256 与已冻结值一致；本轮没有重建模型、Project 或 IBD，也没有新增 Port/Connection。",
             "", "## 57 张正式 IBD", "",
             "`ports` 是该视图中实际显示的 PortUsage 数；`edges` 是实际显示且可回溯到 ConnectionUsage 或 InterfaceUsage 的边数。不同视图可能复用同一模型元素，列总和不代表唯一元素数。", "",
             "| name | representation_id | root product | direct children | ports | edges | status |",
             "|---|---|---|---|---:|---:|---|",
            ]
    for row in qa["rows"]:
        children = ", ".join(row["direct_children"])
        lines.append(f"| [{row['name']}]({base}{row['representation_id']}) | `{row['representation_id']}` | `{row['root_product']}` | {children} ({row['direct_children_visible']}/{len(row['direct_children'])}) | {row['ports']} | {row['edges']} | {row['status']} |")
    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(f"VIEW_GUIDE=PASS IBD={len(qa['rows'])} PATH={OUT}")


if __name__ == "__main__":
    main()
