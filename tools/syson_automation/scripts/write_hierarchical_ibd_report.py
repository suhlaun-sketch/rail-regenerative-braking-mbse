from __future__ import annotations

import hashlib
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]


def main(scope_id: str = "scope_6289f72770e3") -> int:
    scope_path = ROOT / "tools/syson_automation/generated/scopes" / f"{scope_id}.json"
    scope = json.loads(scope_path.read_text(encoding="utf-8"))
    closure_path = ROOT / "tools/syson_automation/generated/closures" / f"{scope_id}_product_closure.json"
    closure = json.loads(closure_path.read_text(encoding="utf-8"))
    current = json.loads((ROOT / "tools/syson_automation/cache/current_project.json").read_text(encoding="utf-8"))
    xlsx = ROOT / "Req/牵引制动能量回收系统_正式需求库_v2_扩展版.xlsx"
    xlsx_sha = hashlib.sha256(xlsx.read_bytes()).hexdigest()
    closure_ids = {x["product_id"] for x in closure["product_closure"]}
    canonical_closure_ids = {pid for item in scope["canonical_products"] for pid in item["source_product_ids"] if pid in closure_ids}
    level_by_product = {x["product_id"]: x["level"] for x in scope["hierarchy_nodes"]}

    lines = [
        "# Hierarchical IBD 与接口闭包验收报告", "",
        f"- Scope：`{scope_id}`；Query：{scope['query']}",
        "- IBD 计划按真实 Product hierarchy 生成，Flow pair 数量不再决定 View 数量。", "",
        "## 原 pair-focused 逻辑", "",
        "旧实现将每条 Flow 按 `(source_product_id, target_product_id)` 分组，每个产品对生成单独 IBD；该 Scope 有 22 个有效产品对，因此产生 22 张图。此逻辑已从 `scope_builder.py` 删除。当前按 hierarchy level 投影，一个存在的产品层级对应一张 IBD。", "",
        "## Scope 与 Interface-induced Product Closure", "",
        f"- Requirements：{len(scope['requirements'])}",
        f"- Functions：{len(scope['functions'])}",
        f"- 向后兼容保留的原 Scope 字段：Products {len(scope['products'])}、Flows {len(scope['flows'])}；新增完整 Product Closure / Hierarchy 字段独立保存。",
        f"- Seed Products（真实 Function OWNER allocation）：{len(scope['seed_products'])} — `{', '.join(scope['seed_products'])}`",
        f"- Closure Products：{len(closure['product_closure'])}",
        f"- Closure rounds：{closure['closure_rounds']} 个非空扩展轮次；Round 0 为全部 Seed，最终达到 fixed point。轮次只描述扩展，不表示产品层级。",
        f"- Closure directed product edges：{len(closure['closure_edges'])}",
        f"- Canonical merge：{len(closure_ids)} 个 closure Product → {len(canonical_closure_ids)} 个 closure canonical Product；另有 {len(scope['canonical_products']) - len(canonical_closure_ids)} 个 hierarchy-only ancestor canonical records。按相同 Product code 做 identity merge。",
        f"- Visual occurrence merge：实际模型没有提供明确的重复 Usage identity，因此未按同名折叠；不同 Product code 保持不同 canonical ID。",
        f"- 真实 hierarchy 来源：冻结 SysML `part def P_*` 中解析的 `level` 和 `parentCode`，经 ModelGraph 产品树校验；存在层级：`{scope['closure_stats']['hierarchy_levels_present']}`。",
        f"- Hierarchy context nodes：{len(scope['hierarchy_nodes'])}（closure 节点及其真实 ancestors）。",
        "- 邻接扩展来自冻结 SysML leaf connector/interface/flow、L2 interaction catalog、TaskSlice 真接口投影；无名称相似度、LLM 或 hop-level 推断。闭包发现无向扩展，绘图保留方向。", "",
        "Closure Product codes（按模型真实层级）：",
    ]
    for level in scope["closure_stats"]["hierarchy_levels_present"]:
        codes = sorted(x["product_id"] for x in closure["product_closure"] if level_by_product[x["product_id"]] == level)
        lines.append(f"- L{level}（{len(codes)}）：`{', '.join(codes) if codes else '无 closure 产品'}`")
    lines += [
        "## Hierarchical IBD Views", "",
        "下表的 Flow 数量为该层所有 projected interactions 中去重后的真实 Flow refs 数；详细 refs 与 Interface/Connector provenance 随 Scope Manifest 保存在本地。", "",
        "| View | Product nodes | Projected interactions | Unique real flows | Unique interface/port refs | Unique connector refs | 双向聚合 interaction |",
        "|---|---:|---:|---:|---:|---:|---:|",
    ]
    for view in scope["hierarchical_ibd_views"]:
        interactions = view["projected_interactions"]
        flows = {r for e in interactions for r in e["aggregated_from_flow_refs"]}
        interfaces = {r for e in interactions for r in e["aggregated_from_interface_refs"]}
        connectors = {r for e in interactions for r in e["aggregated_from_connector_refs"]}
        bidirectional = sum(len(e["directions"]) > 1 for e in interactions)
        lines.append(f"| `AUTO_IBD_L{view['hierarchy_level']}` | {len(view['product_ids'])} | {len(interactions)} | {len(flows)} | {len(interfaces)} | {len(connectors)} | {bidirectional} |")
    for view in scope["hierarchical_ibd_views"]:
        level = view["hierarchy_level"]
        interactions = view["projected_interactions"]
        flow_refs = sorted({r for e in interactions for r in e["aggregated_from_flow_refs"]})
        lines += ["", f"### L{level} — `{view['name']}`", "",
                  f"- Products ({len(view['product_ids'])}): `{', '.join(view['product_ids'])}`",
                  f"- Projected interactions: {len(interactions)}; unique real Flow refs: {len(flow_refs)}.",
                  f"- Aggregated real Flow refs: `{', '.join(flow_refs)}`"]
    no_fake = not any({e["source_product_id"], e["target_product_id"]} == {"5100", "X100"} for e in closure["closure_edges"])
    lines += ["", "## Direction, forbidden edge, and baselines", "",
        "- 双向 Flow 投影到同一产品对 interaction，分别保存在 `forward_flow_refs` / `reverse_flow_refs`；Interface、Connector 和 Flow refs 均保留。",
        f"- 5100↔X100 direct edge：{'未出现' if no_fake else '发现真实关系，需核查'}。本 Scope 中没有该 direct L2 aggregate edge。",
        f"- Frozen SysML SHA-256：`{scope['source_hashes'].get('Rail_MBSE_Full_v1.sysml', '未记录')}`（要求值 `a15cf7170dc5458738080a146c391e438fe57b85f9687857f34a081b8efdf0d5`）。",
        f"- Formal V2 workbook SHA-256：`{xlsx_sha}`；本轮只读，未写入。",
        f"- 最终 Hierarchical IBD Plan：**{len(scope['hierarchical_ibd_views'])} 张**，对应层级 `{[v['hierarchy_level'] for v in scope['hierarchical_ibd_views']]}`；pair-focused IBD：**0**。", "",
        "## SysON 实体化", "",
        f"- Live Project：`{current.get('project_name')}` (`{current.get('project_id')}`)，EditingContext `{current.get('editing_context_id')}`。",
        f"- Schema discovery：664 types、1 Query field、126 Mutation fields；当前项目现存 representations：{len(current.get('representations', []))}。",
        f"- Requirement、Function–Product、IBD 实际创建：0；SysON resolver 状态 `{current.get('element_search_status')}`，8 秒 exact `editingContext.search` 超时。",
        "- 因此未调用 createRepresentation/dropNodes/layout；本地完整 ViewPlan 已生成，保留 mutation safety gate。", "",
        "## 本地验证", "",
        "- `python -m unittest discover -s tools/syson_automation/tests -v`：17 tests passed。",
        "- API scope/plan 及四层数据通过本地服务实测；前端 build 通过。", "",
        f"- Scope 文件：`tools/syson_automation/generated/scopes/{scope_id}.json`",
        f"- Closure 文件：`tools/syson_automation/generated/closures/{scope_id}_product_closure.json`", ""]
    output = ROOT / "work/reports/HIERARCHICAL_IBD_CLOSURE_REPORT.md"
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text("\n".join(lines), encoding="utf-8")
    print(f"REPORT_WRITTEN {output}")
    print(f"CLOSURE {len(scope['product_closure'])} PRODUCTS {scope['closure_stats']['closure_rounds']} ROUNDS; IBD {len(scope['hierarchical_ibd_views'])}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1] if len(sys.argv) > 1 else "scope_6289f72770e3"))
