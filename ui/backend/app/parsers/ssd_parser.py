from __future__ import annotations

import xml.etree.ElementTree as ET
from collections import defaultdict
from pathlib import Path

from .sysml_adapter import L2_LANES, LANE_ORDER

NS = {"ssd": "http://ssp-standard.org/SSP1/SystemStructureDescription"}


class SSDParser:
    def __init__(self, project_root: Path):
        self.root = project_root
        self.source = project_root / "work/sysmlv2/ssi_integration/03_ssd/Rail_MBSE_L2_All16_v1.ssd"

    def _read(self):
        root = ET.parse(self.source).getroot()
        system = root.find("ssd:System", NS)
        components = system.findall("./ssd:Elements/ssd:Component", NS)
        connectors = system.findall(".//ssd:Connector", NS)
        connections = system.findall("./ssd:Connections/ssd:Connection", NS)
        return components, connectors, connections

    def summary(self) -> dict:
        c, p, e = self._read()
        return {"authority": str(self.source.relative_to(self.root)).replace("\\", "/"),
                "components": len(c), "connectors": len(p), "crossL2Connections": len(e)}

    def graph(self) -> dict:
        components, _, connections = self._read()
        names = {c.attrib["name"] for c in components}
        nodes = []
        for name in sorted(names):
            code = name.removeprefix("L2_"); lane, rank = L2_LANES.get(code, ("车辆", 4))
            count = len(next(c for c in components if c.attrib["name"] == name).findall("./ssd:Connectors/ssd:Connector", NS))
            nodes.append({"data": {"id": name, "code": code, "name": name, "type": "SSD Component",
                                     "lane": lane, "laneOrder": LANE_ORDER.index(lane), "rank": rank, "connectorCount": count}})
        grouped = defaultdict(list)
        for c in connections:
            a, b = c.attrib.get("startElement"), c.attrib.get("endElement")
            if a in names and b in names and a != b:
                grouped[tuple(sorted((a, b)))].append({"id": c.attrib.get("name"), **c.attrib})
        node_map = {n["data"]["id"]: n["data"] for n in nodes}; edges = []
        for (a, b), items in grouped.items():
            source, target = (a, b) if node_map[a]["rank"] <= node_map[b]["rank"] else (b, a)
            directions = {(x.get("startElement"), x.get("endElement")) for x in items}
            edges.append({"data": {"id": f"ssd_agg_{a}_{b}", "source": source, "target": target,
                                    "label": f"{len(items)}个接口", "connectionCount": len(items),
                                    "bidirectional": len(directions) > 1, "connections": items}})
        return {"level": 1, "nodes": nodes, "edges": edges,
                "meta": {"nodeCount": len(nodes), "portsExpanded": False, "portNodes": 0,
                         "edgeAggregation": True, "layout": {"name": "elk", "algorithm": "layered", "direction": "RIGHT", "edgeRouting": "ORTHOGONAL"},
                         "lanes": LANE_ORDER}}
