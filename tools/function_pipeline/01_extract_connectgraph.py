"""Extract the frozen KG v1 and ConnectGraph v1 into a read-only synthesis source."""
from __future__ import annotations

import hashlib
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
KG = ROOT / "tools" / "kg_pipeline" / "work" / "graph_data.json"
TOPO = ROOT / "tools" / "topology_pipeline" / "work"
WORK = Path(__file__).resolve().parent / "work"


def read(path: Path):
    return json.loads(path.read_text(encoding="utf-8"))


def write(path: Path, data) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


def digest(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main() -> None:
    graph = read(KG)
    connection_doc = read(TOPO / "final_connections.json")
    net_doc = read(TOPO / "final_nets.json")
    coverage_doc = read(TOPO / "final_port_coverage.json")
    role_doc = read(TOPO / "product_role_map.json")

    actual = {
        "Product": len(graph["products"]),
        "Item": len(graph["items"]),
        "Profile": 1,
        "CONTAINS": len(graph["contains"]),
        "EXPOSES": len(graph["exposes"]),
        "Active_EXPOSES": sum(bool(x["profile_active"]) for x in graph["exposes"]),
        "Inactive_EXPOSES": sum(not bool(x["profile_active"]) for x in graph["exposes"]),
        "CONNECTS_TO": len(connection_doc["connections"]),
        "PhysicalNet": len(net_doc["physical_nets"]),
        "NET_MEMBER": len(net_doc["net_memberships"]),
        "Port_nodes": 0,
    }
    expected = {
        "Product": 147, "Item": 144, "Profile": 1, "CONTAINS": 139,
        "EXPOSES": 517, "Active_EXPOSES": 511, "Inactive_EXPOSES": 6,
        "CONNECTS_TO": 184, "PhysicalNet": 9, "NET_MEMBER": 82,
        "Port_nodes": 0,
    }
    if actual != expected:
        raise RuntimeError(f"Frozen ConnectGraph baseline mismatch: {actual}")

    role_by_code = {x["product_code"]: x for x in role_doc["roles"]}
    if set(role_by_code) != {x["code"] for x in graph["products"]}:
        raise RuntimeError("Product role map does not cover all frozen Products")

    source = {
        "metadata": {
            "project_id": "RAIL_MBSE_TRACTION_BRAKE",
            "profile_id": "CRH_AC25KV_SC",
            "source_layer": "KG v1 + ConnectGraph v1 (frozen)",
            "baseline_counts": actual,
            "source_sha256": {
                "graph_data": digest(KG),
                "final_connections": digest(TOPO / "final_connections.json"),
                "final_nets": digest(TOPO / "final_nets.json"),
                "final_port_coverage": digest(TOPO / "final_port_coverage.json"),
                "product_role_map": digest(TOPO / "product_role_map.json"),
            },
        },
        "profile": graph["meta"]["profile"],
        "products": sorted(graph["products"], key=lambda x: (int(x["level"]), x["code"])),
        "items": sorted(graph["items"], key=lambda x: x["item_code"]),
        "interfaces": sorted(graph["exposes"], key=lambda x: x["port_id"]),
        "connections": sorted(connection_doc["connections"], key=lambda x: x["connection_id"]),
        "physical_nets": sorted(net_doc["physical_nets"], key=lambda x: x["net_id"]),
        "net_memberships": sorted(net_doc["net_memberships"], key=lambda x: x["membership_id"]),
        "external_boundaries": sorted(net_doc["external_boundaries"], key=lambda x: x["boundary_id"]),
        "product_roles": sorted(role_doc["roles"], key=lambda x: x["product_code"]),
        "port_coverage": sorted(coverage_doc["coverage"], key=lambda x: x["port_id"]),
    }
    write(WORK / "source_architecture.json", source)
    print(json.dumps({"stage": 1, "status": "PASS", "baseline": actual}, ensure_ascii=False))


if __name__ == "__main__":
    main()
