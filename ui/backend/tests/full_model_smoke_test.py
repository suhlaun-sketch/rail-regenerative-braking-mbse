from __future__ import annotations

import json
from urllib.parse import quote
from urllib.request import urlopen

BASE = "http://127.0.0.1:8000/api"


def get(path: str):
    with urlopen(f"{BASE}{path}", timeout=30) as response:
        assert response.status == 200, (path, response.status)
        return json.load(response)


full = get("/model/full")
stats = full["statistics"]
assert [stats[f"level_{level}_nodes"] for level in range(1, 5)] == [8, 16, 34, 89]
assert stats["total_nodes"] == 147
assert stats["leaf_interfaces"] == stats["leaf_flows"] == 172
assert stats["aggregated_l3_interfaces"] == 67
assert stats["aggregated_l2_interfaces"] == 38
assert stats["aggregated_l1_interfaces"] == 25

l2 = get("/model/l2")
assert len(l2["nodes"]) == 16
assert len(l2["aggregated_interfaces"]) == 38
assert all(node["data"]["display_name"] != f"L2_{node['data']['code']}" for node in l2["nodes"])

for code in ("5100", "5300", "7200", "X100"):
    node = next(node["data"] for node in l2["nodes"] if node["data"]["code"] == code)
    assert any("\u4e00" <= char <= "\u9fff" for char in node["display_name"])
    node_id = quote(node["id"], safe="")
    assert get(f"/model/node/{node_id}/interfaces")
    assert get(f"/model/node/{node_id}/flows")

aggregate = l2["aggregated_interfaces"][0]
aggregate_id = quote(aggregate["id"], safe="")
assert aggregate["flow_items"] and aggregate["leaf_connections"]
assert get(f"/model/interface/{aggregate_id}/children")
assert get(f"/model/interface/{aggregate_id}/leaf-connections")

assert len(get("/application/binding")["components"]) == 16
assert len(get("/application/fmu")["models"]) == 16
ssp = get("/application/ssp")
assert ssp["status"] == "PASS" and ssp["components"] == 16 and ssp["connections"] == 87
assert len(get("/digital-thread/summary")["stages"]) == 8

kg = get("/kg/status")
assert kg["database"] == "motor-brake-system" and kg["readOnly"] is True
if kg["status"] == "CONNECTED":
    summary = get("/kg/summary")
    assert summary["nodeCount"] >= 0 and summary["relationshipCount"] >= 0
    results = get("/kg/search?q=" + quote("牵引"))
    if results:
        get("/kg/neighbors/" + quote(str(results[0]["id"]), safe=""))

print("FULL_MODEL_HTTP_SMOKE = PASS")
print("FULL_MODEL_STATS = 8/16/34/89/147")
print("INTERFACES = 172/67/38/25")
print(f"NEO4J = {kg['status']}")
