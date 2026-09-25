from __future__ import annotations

import hashlib
import json
import re
from collections import Counter, defaultdict
from pathlib import Path
from typing import Any

from ..parsers.sysml_adapter import L2_LANES, LANE_ORDER


def repair_text(value: str | None) -> str | None:
    if not value: return value
    try:
        fixed = value.encode("gbk").decode("utf-8")
        original_cjk = sum("\u4e00" <= char <= "\u9fff" for char in value)
        fixed_cjk = sum("\u4e00" <= char <= "\u9fff" for char in fixed)
        if fixed and "�" not in fixed and fixed_cjk > original_cjk: return fixed
    except (UnicodeEncodeError, UnicodeDecodeError):
        pass
    return value


def attrs(block: str) -> dict[str, Any]:
    result: dict[str, Any] = {}
    for key, typ, raw in re.findall(r'attribute\s+(\w+)\s*:\s*(\w+)\s*=\s*("[^"]*"|true|false|-?\d+)', block):
        value: Any = raw.strip('"')
        if typ == "Integer": value = int(value)
        elif typ == "Boolean": value = value == "true"
        elif isinstance(value, str): value = repair_text(value)
        result[key] = value
    return result


def block_at(text: str, start: int) -> str:
    opening = text.find("{", start); depth = 0
    for i in range(opening, len(text)):
        if text[i] == "{": depth += 1
        elif text[i] == "}":
            depth -= 1
            if depth == 0: return text[start:i + 1]
    return text[start:]


class ModelGraphService:
    def __init__(self, root: Path):
        self.root = root
        self.source = root / "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml"
        self.binding = root / "work/simulation/implementation_binding/Rail_MBSE_Executable_FMU_Interface_v1.json"
        self.cache_root = root / "ui/backend/cache/model"

    def _sha(self) -> str:
        return hashlib.sha256(self.source.read_bytes()).hexdigest()

    def _cache_dir(self) -> Path:
        p = self.cache_root / f"{self._sha()}-v2"; p.mkdir(parents=True, exist_ok=True); return p

    def _read_cache(self, name: str) -> dict | None:
        p = self._cache_dir() / name
        return json.loads(p.read_text(encoding="utf-8")) if p.exists() else None

    def _write_cache(self, name: str, value: dict):
        (self._cache_dir() / name).write_text(json.dumps(value, ensure_ascii=False, indent=2), encoding="utf-8")

    def get_full_model_graph(self) -> dict:
        cached = self._read_cache("full_model_graph.json")
        if cached: return cached
        text = self.source.read_text(encoding="utf-8")
        line_starts = [0]
        for m in re.finditer("\n", text): line_starts.append(m.end())
        def line_of(pos: int):
            import bisect
            return bisect.bisect_right(line_starts, pos)

        products: dict[str, dict] = {}
        product_blocks: dict[str, str] = {}
        for m in re.finditer(r"(?m)^\s*part def P_(?:N_)?([0-9A-Z]+)\s*\{", text):
            block = block_at(text, m.start()); a = attrs(block); code = str(a.get("productCode") or m.group(1))
            if not a.get("level") or not a.get("chineseName"): continue
            pid = f"product::{code}"; parent_code = str(a.get("parentCode") or "")
            products[code] = {"id": pid, "display_name": a.get("chineseName"), "name": a.get("chineseName"),
                "raw_name": m.group(0).strip().split()[2], "type": "产品/部件", "level": int(a["level"]),
                "parent_code": parent_code or None, "parent": f"product::{parent_code}" if parent_code else None,
                "code": code, "sysml_id": f"P_{code}", "raw_id": m.group(1),
                "source_path": f"{self.source.relative_to(self.root).as_posix()}:{line_of(m.start())}",
                "definition_type": "part def", "leaf": bool(a.get("leaf", False))}
            product_blocks[code] = block

        children = Counter(x["parent_code"] for x in products.values() if x["parent_code"])
        def l2_ancestor(code: str) -> str | None:
            current = products.get(code)
            while current and current["level"] > 2: current = products.get(current["parent_code"])
            return current["code"] if current and current["level"] == 2 else None
        for code, node in products.items():
            l2 = l2_ancestor(code); lane, rank = L2_LANES.get(l2 or code, ("其他", 8))
            node.update({"children_count": children[code], "lane": lane, "laneOrder": LANE_ORDER.index(lane) if lane in LANE_ORDER else len(LANE_ORDER), "rank": rank, "l2_code": l2})

        item_defs: dict[str, dict] = {}
        for m in re.finditer(r"(?m)^\s*item def (I_ITM_\w+)\s*\{", text):
            a = attrs(block_at(text, m.start())); item_defs[m.group(1)] = {
                "id": m.group(1), "display_name": a.get("chineseName") or a.get("englishName") or m.group(1),
                "raw_name": a.get("englishName") or m.group(1), "item_code": a.get("itemCode"),
                "unit": a.get("unitOrMedium") or None, "family": a.get("family"), "domain": a.get("domain"),
                "datatype": a.get("datatype"), "source_evidence": [f"SysML ItemDefinition::{m.group(1)}"]}
        interface_items = {}
        for m in re.finditer(r"(?m)^\s*interface def (IF_IF_\w+)\s*\{", text):
            b = block_at(text, m.start()); flow = re.search(r"flow of (I_ITM_\w+)", b)
            if flow: interface_items[m.group(1)] = flow.group(1)

        ports: dict[tuple[str, str], dict] = {}
        for code, block in product_blocks.items():
            for m in re.finditer(r"port\s+(rp_\w+)\s*:\s*(~?\w+)\s*\{", block):
                pblock = block_at(block, m.start()); a = attrs(pblock); raw = m.group(1)
                ports[(code, raw)] = {"id": f"port::{code}::{raw}", "owner_node_id": f"product::{code}",
                    "display_name": a.get("portName") or raw, "raw_name": raw, "raw_id": raw,
                    "direction": a.get("direction"), "definition_type": m.group(2), "source_port_id": a.get("sourcePortId")}

        binding = json.loads(self.binding.read_text(encoding="utf-8"))
        exec_by_connection: dict[str, list[dict]] = defaultdict(list)
        for e in binding.get("executable_signal_connections", []):
            exec_by_connection[str(e.get("structural_connection_id", "")).replace("-", "_")].append(e)

        def kind_of(item: dict) -> str:
            code = str(item.get("item_code") or ""); english = str(item.get("raw_name") or "").lower()
            if code.startswith("ITM-CMD"): return "control"
            if code.startswith("ITM-STA"): return "state"
            if code.startswith("ITM-PHY") or any(x in english for x in ("power", "energy", "voltage", "current", "torque", "speed", "force", "pressure")): return "physical"
            if code.startswith(("ITM-MEA", "ITM-ACC", "ITM-LIM")): return "data"
            return "unknown"

        leaf_interfaces = []; flows: dict[str, dict] = {}; port_use_count = Counter()
        conn_re = re.compile(r"(?m)^\s*interface\s+c_(CG_[A-F0-9]+)\s*:\s*(IF_IF_\w+)\s+connect\s+(\S+)\s+to\s+(\S+)\s*\{")
        for m in conn_re.finditer(text):
            cid, idef, source_path, target_path = m.groups()
            def endpoint(path: str):
                codes = [x for x in re.findall(r"p_(?:N_)?([0-9A-Z]+)", path) if x in products]
                raw = path.rsplit(".", 1)[-1]; code = codes[-1] if codes else None
                return code, raw, ports.get((code, raw)) if code else None
            sc, sp, spd = endpoint(source_path); tc, tp, tpd = endpoint(target_path)
            if not sc or not tc: continue
            item = item_defs.get(interface_items.get(idef, ""), {"id": idef, "display_name": idef, "raw_name": idef, "unit": None, "source_evidence": [f"SysML InterfaceDefinition::{idef}"]})
            execs = exec_by_connection.get(cid, [])
            fid = f"flow::{cid}"; fmi = sorted({x.get("source_variable") for x in execs if x.get("source_variable")} | {x.get("target_variable") for x in execs if x.get("target_variable")})
            flows[fid] = {"id": fid, "display_name": item["display_name"], "raw_name": item.get("raw_name") or idef,
                "kind": kind_of(item), "unit": item.get("unit"), "direction": "source_to_target", "fmi_variables": fmi,
                "source_evidence": item.get("source_evidence", []) + [f"SysML Connection::{cid}"]}
            iid = f"leaf::{cid}"; port_use_count[sc] += 1; port_use_count[tc] += 1
            leaf_interfaces.append({"id": iid, "level": max(products[sc]["level"], products[tc]["level"]),
                "owner_node_id": f"product::{sc}", "display_name": item["display_name"], "raw_name": cid,
                "direction": "source_to_target", "source": {"node_id": f"product::{sc}", "port": spd or {"raw_name": sp}},
                "target": {"node_id": f"product::{tc}", "port": tpd or {"raw_name": tp}}, "flow_items": [flows[fid]],
                "child_interface_ids": [], "leaf_connection_ids": [cid], "derived": False,
                "source_path": f"{self.source.relative_to(self.root).as_posix()}:{line_of(m.start())}",
                "raw_source_ports": [sp], "raw_target_ports": [tp]})

        for code, node in products.items(): node["interface_count"] = port_use_count[code]
        def ancestor(code: str, level: int) -> str | None:
            n = products.get(code)
            while n and n["level"] > level: n = products.get(n["parent_code"])
            return n["code"] if n and n["level"] == level else None
        grouped: dict[tuple, list[dict]] = defaultdict(list)
        for leaf in leaf_interfaces:
            sc = leaf["source"]["node_id"].split("::", 1)[1]; tc = leaf["target"]["node_id"].split("::", 1)[1]
            for level in (1, 2, 3):
                sa, ta = ancestor(sc, level), ancestor(tc, level)
                if sa and ta and sa != ta:
                    grouped[(level, sa, ta, leaf["flow_items"][0]["kind"])].append(leaf)
        aggregates = []
        for (level, sc, tc, domain), leaves in grouped.items():
            flow_map = {f["id"]: f for x in leaves for f in x["flow_items"]}; names = list(dict.fromkeys(f["display_name"] for f in flow_map.values()))
            label = "、".join(names) if len(names) <= 3 else f"{len(names)}项传递量"
            aid = f"aggregate::L{level}::{sc}::{tc}::{domain}"
            aggregates.append({"id": aid, "level": level, "source_node_id": f"product::{sc}", "target_node_id": f"product::{tc}",
                "display_name": label, "direction": "source_to_target", "flow_domain": domain, "flow_items": list(flow_map.values()),
                "child_interfaces": [], "leaf_connections": [x["id"] for x in leaves],
                "raw_source_ports": sorted({p for x in leaves for p in x["raw_source_ports"]}),
                "raw_target_ports": sorted({p for x in leaves for p in x["raw_target_ports"]}),
                "derived": True, "derivation_method": "hierarchical_boundary_aggregation", "source": "由下层接口归纳"})
        by_level = defaultdict(list)
        for x in aggregates: by_level[x["level"]].append(x)
        for parent in aggregates:
            if parent["level"] >= 3: continue
            pset = set(parent["leaf_connections"])
            parent["child_interfaces"] = [x["id"] for x in by_level[parent["level"] + 1] if set(x["leaf_connections"]) & pset]
        for a in by_level[3]: a["child_interfaces"] = list(a["leaf_connections"])

        containment = [{"data": {"id": f"contains::{x['parent_code']}::{code}", "source": x["parent"], "target": x["id"], "relation": "containment", "label": ""}}
                       for code, x in products.items() if x["parent"] in {n["id"] for n in products.values()}]
        stats = {f"level_{i}_nodes": sum(1 for x in products.values() if x["level"] == i) for i in range(1, 5)}
        stats.update({"total_nodes": len(products), "leaf_interfaces": len(leaf_interfaces), "leaf_flows": len(flows),
                      "aggregated_l3_interfaces": len(by_level[3]), "aggregated_l2_interfaces": len(by_level[2]), "aggregated_l1_interfaces": len(by_level[1])})
        result = {"authority": self.source.relative_to(self.root).as_posix(), "source_sha256": self._sha(),
            "nodes": [{"data": x} for x in products.values()], "containment": containment,
            "leaf_interfaces": leaf_interfaces, "flows": list(flows.values()), "aggregated_interfaces": aggregates,
            "swimlanes": LANE_ORDER + (["其他"] if any(x["lane"] == "其他" for x in products.values()) else []), "statistics": stats}
        self._write_cache("full_model_graph.json", result)
        self._write_cache("interface_hierarchy.json", {"leaf_interfaces": leaf_interfaces, "flows": list(flows.values()), "aggregated_interfaces": aggregates, "statistics": stats})
        return result

    def get_l2_application_graph(self) -> dict:
        cached = self._read_cache("l2_projection.json")
        if cached:
            interfaces = cached.get("aggregated_interfaces", [])
            for node in cached.get("nodes", []):
                node_id = node["data"]["id"]
                node["data"]["interface_count"] = sum(1 for item in interfaces if node_id in (item["source_node_id"], item["target_node_id"]))
            return cached
        full = self.get_full_model_graph(); nodes = [x for x in full["nodes"] if x["data"]["level"] == 2]
        interfaces = [x for x in full["aggregated_interfaces"] if x["level"] == 2]
        edges = [{"data": {"id": x["id"], "source": x["source_node_id"], "target": x["target_node_id"],
                           "label": x["display_name"], "flow_kind": x["flow_domain"], "flow_items": x["flow_items"],
                           "trace_to_leaf_interfaces": x["leaf_connections"], "interface": x}} for x in interfaces]
        result = {"nodes": nodes, "edges": edges, "aggregated_interfaces": interfaces,
                  "meta": {"projection": "L2 application graph", "nodeCount": len(nodes), "portsExpanded": False,
                           "source": full["authority"], "layout": {"name": "elk", "algorithm": "layered", "direction": "RIGHT", "edgeRouting": "ORTHOGONAL"},
                           "lanes": full["swimlanes"]}, "statistics": full["statistics"]}
        for node in result["nodes"]:
            node_id = node["data"]["id"]
            node["data"]["interface_count"] = sum(1 for item in interfaces if node_id in (item["source_node_id"], item["target_node_id"]))
        self._write_cache("l2_projection.json", result); return result

    def interface(self, interface_id: str) -> dict | None:
        full = self.get_full_model_graph()
        return next((x for x in full["leaf_interfaces"] + full["aggregated_interfaces"] if x["id"] == interface_id), None)

    def node_interfaces(self, node_id: str) -> list[dict]:
        full = self.get_full_model_graph()
        return [x for x in full["leaf_interfaces"] if x["source"]["node_id"] == node_id or x["target"]["node_id"] == node_id] + [x for x in full["aggregated_interfaces"] if x["source_node_id"] == node_id or x["target_node_id"] == node_id]

    def node_flows(self, node_id: str) -> list[dict]:
        values = {f["id"]: f for x in self.node_interfaces(node_id) for f in x.get("flow_items", [])}
        return list(values.values())
