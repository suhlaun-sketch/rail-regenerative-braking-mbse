import json
import sys
import urllib.request

BASE = sys.argv[1] if len(sys.argv) > 1 else "http://127.0.0.1:8000"

def get(path):
    with urllib.request.urlopen(BASE + path, timeout=20) as response:
        assert response.status == 200
        return json.load(response)

def graphql(query, variables):
    request = urllib.request.Request(
        BASE + "/graphql",
        data=json.dumps({"query": query, "variables": variables}).encode(),
        headers={"Content-Type": "application/json"},
    )
    with urllib.request.urlopen(request, timeout=30) as response:
        payload = json.load(response)
        assert response.status == 200 and not payload.get("errors"), payload.get("errors")
        return payload["data"]

summary = get("/api/kg/summary")
assert summary["status"] == "CONNECTED" and summary["readOnly"] is True
print("NEBULA_KG connectivity/read-only = PASS")

search = graphql(
    "query($q:String!){search(text:$q,types:[\"Requirement\"]){id nodeType name properties}}",
    {"q": "常用制动平均减速度需求"},
)["search"]
assert search and search[0]["nodeType"] == "Requirement"
print("NEBULA_KG real requirement search = PASS")

trace = graphql(
    "query($id:String!){requirementTrace(requirementId:$id){nodes{id nodeType name} edges{id relationType sourceId targetId evidence{status source sourceFile provenanceClass}} truncated}}",
    {"id": "REQ-BRK-001"},
)["requirementTrace"]
node_types = {node["nodeType"] for node in trace["nodes"]}
relation_types = {edge["relationType"] for edge in trace["edges"]}
assert {"Requirement", "Function", "Product", "Port", "ExternalBoundary"} <= node_types
assert {"TRACE_TO_FUNCTION", "ALLOCATED_TO", "HAS_PORT", "TERMINATES_AT"} <= relation_types
assert all(edge["evidence"]["sourceFile"] or edge["evidence"]["source"] for edge in trace["edges"])
print("NEBULA_KG requirement-to-physical evidence chain = PASS")

reverse = graphql(
    "query($id:String!){reverseTrace(nodeId:$id,maxNodes:36){nodes{id nodeType} edges{id relationType} truncated}}",
    {"id": "3111"},
)["reverseTrace"]
assert len(reverse["nodes"]) <= 36
assert {"TRACE_TO_FUNCTION", "ALLOCATED_TO"} <= {edge["relationType"] for edge in reverse["edges"]}
print("NEBULA_KG bounded reverse trace = PASS")
print("NEBULA_ENGINEERING_SMOKE = 4/4")
