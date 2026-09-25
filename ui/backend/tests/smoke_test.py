import json
import sys
import urllib.request

base = sys.argv[1] if len(sys.argv) > 1 else "http://127.0.0.1:8000"
checks = {
    "/api/project/status": lambda x: x["fmiVariables"] == 151 and x["causalPaths"] == 77,
    "/api/sysml/summary": lambda x: x["l2Components"] == 16 and x["connections"] == 74,
    "/api/sysml/graph": lambda x: x["meta"]["nodeCount"] <= 30 and not x["meta"]["portsExpanded"] and x["meta"]["layout"]["name"] == "elk",
    "/api/ssd/summary": lambda x: (x["components"], x["connectors"], x["crossL2Connections"]) == (16, 138, 74),
    "/api/ssd/graph": lambda x: x["meta"]["edgeAggregation"] and x["meta"]["nodeCount"] == 16,
    "/api/vv/summary": lambda x: x["status"] == "PASS",
    "/api/cosim/replay/data": lambda x: x["count"] > 900 and x["defaultSpeed"] == 5,
}
for endpoint, predicate in checks.items():
    with urllib.request.urlopen(base + endpoint, timeout=15) as response:
        payload = json.load(response)
        assert response.status == 200 and predicate(payload), endpoint
    print(f"API_SMOKE {endpoint} = PASS")
print("API_SMOKE_TESTS = 7/7")
