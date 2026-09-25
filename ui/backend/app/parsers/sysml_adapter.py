from __future__ import annotations

import json
import re
import xml.etree.ElementTree as ET
from collections import Counter, defaultdict
from functools import lru_cache
from pathlib import Path

L2_LANES = {
    "4100": ("外部能源", 0),
    "4200": ("高压供电", 1), "4400": ("高压供电", 2), "4500": ("高压供电", 2),
    "5100": ("功率变换", 3),
    "5300": ("牵引机械", 4), "3500": ("牵引机械", 5),
    "3100": ("车辆", 6), "3600": ("车辆", 5), "3800": ("车辆", 6),
    "7100": ("控制", 2), "7200": ("控制", 5), "8100": ("控制", 3),
    "X100": ("储能", 3), "D100": ("控制", 0), "E100": ("控制", 1),
}
LANE_ORDER = ["外部能源", "高压供电", "功率变换", "牵引机械", "车辆", "控制", "储能"]


class SysMLAdapter:
    """Purpose-built, read-only adapter for Rail_MBSE_Full_v1.sysml."""

    def __init__(self, project_root: Path):
        self.root = project_root
        self.source = project_root / "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml"
        self.mapping_path = project_root / "work/sysmlv2/ssi_integration/03_ssd/Rail_MBSE_L2_All16_v1_mapping.json"

    @lru_cache(maxsize=1)
    def _model(self) -> dict:
        text = self.source.read_text(encoding="utf-8")
        lines = text.splitlines()
        mapping = json.loads(self.mapping_path.read_text(encoding="utf-8"))["component_mapping"]
        codes = [str(x["rail_l2_code"]) for x in mapping]
        products = {}
        part_pattern = re.compile(r"^\s*part def P_(?:N_)?([0-9A-Z]+)\s*\{")
        for i, line in enumerate(lines):
            m = part_pattern.match(line)
            if not m or m.group(1) not in codes:
                continue
            code = m.group(1)
            block = "\n".join(lines[i:i + 18])
            name_match = re.search(r'attribute chineseName\s*:\s*String\s*=\s*"([^"]+)"', block)
            lane, rank = L2_LANES.get(code, ("车辆", 4))
            products[code] = {
                "id": f"L2_{code}", "code": code,
                "name": name_match.group(1) if name_match else f"L2 {code}",
                "type": "Product", "parent": re.search(r'parentCode\s*:\s*String\s*=\s*"([^"]+)"', block).group(1) if "parentCode" in block else None,
                "lane": lane, "laneOrder": LANE_ORDER.index(lane), "rank": rank,
                "source": {"file": str(self.source.relative_to(self.root)).replace("\\", "/"), "line": i + 1},
            }

        connections = []
        conn_re = re.compile(r"interface\s+c_(CG_[A-F0-9]+)\s*:\s*(\w+)\s+connect\s+(\S+)\s+to\s+(\S+)")
        for i, line in enumerate(lines):
            m = conn_re.search(line)
            if not m:
                continue
            endpoints = []
            for endpoint in (m.group(3), m.group(4)):
                matches = re.findall(r"p_(?:N_)?([0-9A-Z]+)", endpoint)
                endpoints.append(next((c for c in matches if c in products), None))
            if endpoints[0] and endpoints[1] and endpoints[0] != endpoints[1]:
                connections.append({
                    "id": m.group(1), "interfaceType": m.group(2),
                    "source": f"L2_{endpoints[0]}", "target": f"L2_{endpoints[1]}",
                    "sourcePath": m.group(3), "targetPath": m.group(4),
                    "sourceLocation": {"file": str(self.source.relative_to(self.root)).replace("\\", "/"), "line": i + 1},
                })

        packages = [{"id": m.group(1), "name": m.group(1), "type": "Package", "source": {"line": i + 1}}
                    for i, line in enumerate(lines) if (m := re.match(r"^\s*package\s+(\w+)", line))]
        functions = [{"id": m.group(1), "name": m.group(1), "type": "Function", "source": {"line": i + 1}}
                     for i, line in enumerate(lines) if (m := re.match(r"^\s*action def\s+(FN_F_\w+)", line))]
        ports = [{"id": m.group(1), "name": m.group(1), "type": "Port", "source": {"line": i + 1}}
                 for i, line in enumerate(lines) if (m := re.match(r"^\s*(?:port def|port)\s+(\w+)", line))]
        allocations = [{"id": f"allocation_{i+1}", "name": line.strip(), "type": "Allocation", "source": {"line": i + 1}}
                       for i, line in enumerate(lines) if re.match(r"^\s*allocation\s+.*\sallocate\s+", line)]
        return {"products": products, "connections": connections, "packages": packages,
                "functions": functions, "ports": ports, "allocations": allocations}

    def summary(self) -> dict:
        m = self._model()
        return {
            "authority": str(self.source.relative_to(self.root)).replace("\\", "/"),
            "packages": len(m["packages"]), "parts": len(m["products"]), "functions": len(m["functions"]),
            "ports": len(m["ports"]), "connections": len(m["connections"]), "allocations": len(m["allocations"]),
            "l2Components": len(m["products"]), "defaultLevel": 1, "portsExpanded": False,
        }

    def tree(self) -> dict:
        groups = defaultdict(list)
        for item in self._model()["products"].values():
            groups[item["parent"] or "ROOT"].append({"id": item["id"], "name": item["name"], "type": "Product"})
        return {"id": "railSystem", "name": "轨道列车系统", "type": "System",
                "children": [{"id": f"L1_{k}", "name": f"L1 {k}", "type": "Package", "children": sorted(v, key=lambda x: x["id"])}
                             for k, v in sorted(groups.items())]}

    def graph(self, level: int = 1, focus: str | None = None) -> dict:
        m = self._model(); products = m["products"]; conns = m["connections"]
        selected = set(products)
        focus_code = focus.removeprefix("L2_") if focus else None
        if level in (3, 4) and focus_code in products:
            component = products[focus_code]
            nodes = [{"data": component}]; edges = []
            if level == 3:
                ns = {"ssd": "http://ssp-standard.org/SSP1/SystemStructureDescription"}
                root = ET.parse(self.root / "work/sysmlv2/ssi_integration/03_ssd/Rail_MBSE_L2_All16_v1.ssd").getroot()
                target = next(x for x in root.findall(".//ssd:Component", ns) if x.attrib.get("name") == component["id"])
                for index, port in enumerate(target.findall("./ssd:Connectors/ssd:Connector", ns)):
                    pid = f"{component['id']}::{port.attrib['name']}"
                    nodes.append({"data": {"id": pid, "name": port.attrib["name"], "type": "Port", "kind": port.attrib.get("kind"),
                                                   "lane": component["lane"], "laneOrder": component["laneOrder"], "rank": component["rank"] + 1}})
                    source, target_id = (pid, component["id"]) if port.attrib.get("kind") == "input" else (component["id"], pid)
                    edges.append({"data": {"id": f"owns_{index}", "source": source, "target": target_id, "label": port.attrib.get("kind", "connector")}})
            else:
                path = self.root / f"work/simulation/implementation_binding/components/L2_{focus_code}_executable_interface.json"
                data = json.loads(path.read_text(encoding="utf-8"))
                variables = []
                for group in ("inputs", "outputs", "parameters", "states_monitoring_outputs"):
                    value = data.get(group, []) or []
                    variables.extend(value if isinstance(value, list) else [value])
                for index, variable in enumerate(variables):
                    name = variable.get("variable_name", f"variable_{index}"); vid = f"{component['id']}::FMI::{name}"
                    causality = variable.get("fmi_causality", "local")
                    nodes.append({"data": {"id": vid, "name": name, "type": "FMI Variable", "causality": causality,
                                                   "unit": variable.get("unit"), "datatype": variable.get("datatype"),
                                                   "lane": component["lane"], "laneOrder": component["laneOrder"], "rank": component["rank"] + 1}})
                    source, target_id = (vid, component["id"]) if causality == "input" else (component["id"], vid)
                    edges.append({"data": {"id": f"binds_{index}", "source": source, "target": target_id, "label": causality}})
            return {"level": level, "focus": focus, "nodes": nodes, "edges": edges,
                    "meta": {"nodeCount": len(nodes), "portNodes": len(nodes) - 1, "portsExpanded": level == 3,
                             "edgeAggregation": False, "source": self.summary()["authority"],
                             "layout": {"name": "elk", "algorithm": "layered", "direction": "RIGHT", "edgeRouting": "ORTHOGONAL"},
                             "lanes": LANE_ORDER}}
        if level == 2 and focus_code in products:
            selected = {focus_code}
            for c in conns:
                a, b = c["source"].removeprefix("L2_"), c["target"].removeprefix("L2_")
                if focus_code in (a, b): selected.update((a, b))
        nodes = [{"data": p} for c, p in products.items() if c in selected]
        relevant = [c for c in conns if c["source"].removeprefix("L2_") in selected and c["target"].removeprefix("L2_") in selected]
        grouped = defaultdict(list)
        for c in relevant:
            a, b = c["source"], c["target"]
            key = tuple(sorted((a, b)))
            grouped[key].append(c)
        edges = []
        for (a, b), items in grouped.items():
            pa, pb = products[a.removeprefix("L2_")], products[b.removeprefix("L2_")]
            source, target = (a, b) if pa["rank"] <= pb["rank"] else (b, a)
            directions = {(x["source"], x["target"]) for x in items}
            edges.append({"data": {"id": f"agg_{a}_{b}", "source": source, "target": target,
                                    "label": f"{len(items)}个接口", "connectionCount": len(items),
                                    "bidirectional": len(directions) > 1, "connections": items}})
        return {"level": level, "focus": focus, "nodes": nodes, "edges": edges,
                "meta": {"nodeCount": len(nodes), "portNodes": 0, "portsExpanded": False,
                         "edgeAggregation": True, "source": self.summary()["authority"],
                         "layout": {"name": "elk", "algorithm": "layered", "direction": "RIGHT", "edgeRouting": "ORTHOGONAL"},
                         "lanes": LANE_ORDER}}

    def element(self, element_id: str) -> dict | None:
        m = self._model()
        if element_id.startswith("L2_"):
            return m["products"].get(element_id[3:])
        for kind in ("packages", "functions", "ports", "allocations"):
            for item in m[kind]:
                if item["id"] == element_id: return item
        return None
