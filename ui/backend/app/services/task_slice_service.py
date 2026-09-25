"""Task projection from declared functions/allocations and the existing model graph."""
import re
from functools import lru_cache

from .model_graph_service import attrs, block_at


class TaskSliceService:
    def __init__(self, model_graph):
        self.graph = model_graph

    @lru_cache(maxsize=1)
    def catalog(self):
        text = self.graph.source.read_text(encoding="utf-8")
        full = self.graph.get_full_model_graph()
        products = {n["data"]["code"]: n["data"] for n in full["nodes"]}
        allocations = {}
        for m in re.finditer(r"allocation\s+(\w+)\s+allocate\s+fu_(F_\w+)\s+to\s+ap_(?:N_)?([A-Z0-9]+)\s*;", text):
            allocations.setdefault("FN_" + m[2], []).append({"id": m[1], "product_code": m[3],
                "source_path": f"{full['authority']}:{text.count(chr(10), 0, m.start()) + 1}"})
        functions = []
        for m in re.finditer(r"action def\s+(FN_F_\w+)\s*\{", text):
            a = attrs(block_at(text, m.start()))
            links = [x for x in allocations.get(m[1], []) if x["product_code"] in products]
            if not links:
                continue
            functions.append({"id": m[1], "display_name": a.get("chineseName") or m[1],
                "category": a.get("category"), "level": a.get("functionLevel"), "allocations": links,
                "product_name": products[links[0]["product_code"]]["display_name"],
                "source_path": f"{full['authority']}:{text.count(chr(10), 0, m.start()) + 1}"})
        # Demonstration task: real functions from SysML that span the core traction chain
        # (主变压器 → 牵引变流器 → 牵引电机), so that Stage 3 exposes real L2 aggregated interfaces.
        # User can still freely replace these defaults from the full catalog.
        DEMO_FUNCTION_IDS = (
            "FN_F_4511_01",  # 主变压器次级电能转换 (4500)
            "FN_F_5111_01",  # 网侧变流器控制模块运行控制 (5100)
            "FN_F_5111_02",  # 网侧变流器控制模块接口交互协调 (5100)
            "FN_F_5311_01",  # 牵引电机机械-电能转换 (5300)
            "FN_F_X100_01",  # 吸收、存储并按需释放再生制动能量 (X100)
        )
        defaults = [fid for fid in DEMO_FUNCTION_IDS if fid in {f["id"] for f in functions}]
        if not defaults:
            # Fallback: any L4 functions allocated under traction converter/motor L2s
            defaults = [f["id"] for f in functions
                        if any(products[a["product_code"]].get("l2_code") in ("5100", "5300", "4500")
                               for a in f["allocations"])][:3]
        return {"functions": functions, "default_function_ids": defaults, "authority": full["authority"]}

    def project(self, requested=None):
        catalog = self.catalog()
        ids = set(catalog["default_function_ids"] if requested is None else requested)
        known = {f["id"] for f in catalog["functions"]}
        if not ids or not ids <= known:
            raise ValueError("请选择至少一个模型中声明的目标功能")
        full = self.graph.get_full_model_graph()
        products = {n["data"]["code"]: n["data"] for n in full["nodes"]}
        functions = [f for f in catalog["functions"] if f["id"] in ids]
        allocated, projected, allocations, promotions = {}, {}, [], []
        for f in functions:
            for a in f["allocations"]:
                p = products[a["product_code"]]
                allocated.setdefault(p["id"], {**p, "reasons": []})["reasons"].append({
                    "text": f"功能「{f['display_name']}」通过正式 allocation 分配到此产品", "source_path": a["source_path"]})
                allocations.append({**a, "source": f["id"], "target": p["id"], "function_name": f["display_name"], "product_name": p["display_name"]})
                targets = [products[p["l2_code"]]] if p.get("l2_code") else [n for n in products.values() if n["level"] == 2 and n["parent"] == p["id"]]
                for target in targets:
                    projected.setdefault(target["id"], {**target, "reasons": []})["reasons"].append({
                        "text": f"产品「{p['display_name']}」沿正式包含关系投影到该L2边界", "source_path": p["source_path"]})
                    promotions.append({"source": p["id"], "target": target["id"]})
        interfaces = [i for i in full["aggregated_interfaces"] if i["level"] == 2]
        core = set(projected)
        internal = [i for i in interfaces if i["source_node_id"] in core and i["target_node_id"] in core]
        # Least fixed point of incoming physical/control dependencies. Each added node records its witness edge.
        closed = dict(projected)
        changed = True
        while changed:
            changed = False
            for i in interfaces:
                src, dst = i["source_node_id"], i["target_node_id"]
                if dst in closed and src not in closed and i["flow_domain"] in ("physical", "control"):
                    p = products[src.split("::")[1]]
                    closed[src] = {**p, "reasons": [{"text": f"向「{closed[dst]['display_name']}」提供{i['display_name']}，补齐{p['lane']}依赖",
                        "interface_id": i["id"], "source_path": p["source_path"], "leaf_connections": i["leaf_connections"]}], "dependency": True}
                    changed = True
        closure_edges = [i for i in interfaces if i["source_node_id"] in closed and i["target_node_id"] in closed]
        stages = [
            {"title": "目标 Functions", "functions": functions, "products": [], "allocations": [], "interfaces": [], "new_count": len(functions)},
            {"title": "Function Allocation", "functions": functions, "products": list(allocated.values()), "allocations": allocations, "interfaces": [], "new_count": len(allocated)},
            {"title": "L2 Products", "functions": functions, "products": list(projected.values()), "allocations": allocations, "promotions": promotions, "interfaces": [], "new_count": len(projected)},
            {"title": "L2 Aggregated Interfaces", "functions": functions, "products": list(projected.values()), "allocations": allocations, "interfaces": internal, "new_count": len(internal)},
            {"title": "Dependency Closure", "functions": functions, "products": list(closed.values()), "allocations": allocations, "interfaces": closure_edges, "new_count": len(closed) - len(projected)},
        ]
        return {"stages": stages, "authority": full["authority"], "closure_rule": "沿真实L2物理/控制输入接口迭代加入上游组件，直到集合不再变化；其他类型接口在闭包内保留。"}
