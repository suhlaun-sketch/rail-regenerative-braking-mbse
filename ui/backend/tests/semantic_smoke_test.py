from __future__ import annotations

import json
from urllib.request import Request, urlopen

BASE = "http://127.0.0.1:8000/api"


def get(path):
    with urlopen(BASE + path, timeout=20) as response: return json.load(response)


def query(text):
    body = json.dumps({"query": text, "mode": "local"}, ensure_ascii=False).encode("utf-8")
    with urlopen(Request(BASE + "/semantic/query", data=body, headers={"Content-Type": "application/json"}), timeout=20) as response:
        return json.load(response)


catalog = get("/semantic/catalog")
assert (catalog["requirement_count"], catalog["function_count"], catalog["product_count"]) == (34, 191, 147)
assert catalog["provider"] == "LOCAL"

cases = {
    "我想看制动系统": lambda r: r["interpretation"]["scope"] == "broad" and r["stats"]["requirement_count"] > 1,
    "我想看再生制动": lambda r: "REQ-BRK-007" in {x["requirement_id"] for x in r["requirements"]},
    "我想看能量回收": lambda r: any(x["requirement_id"].startswith(("REQ-ENE", "PRJ-ENE")) for x in r["requirements"]),
    "我只想看X100": lambda r: "X100" in {x["product_id"] for x in r["products"]},
    "我想看牵引系统": lambda r: any(x["domain"] == "牵引" for x in r["requirements"]),
    "我想看制动时为什么需要机械制动": lambda r: bool({"REQ-BRK-009", "REQ-BRK-004"} & {x["requirement_id"] for x in r["requirements"]}),
    "制动产生的能量是怎么进入超级电容的": lambda r: bool({"REQ-ENE-001", "PRJ-ENE-001"} & {x["requirement_id"] for x in r["requirements"]}) and bool({"X100", "X121"} & {x["product_id"] for x in r["products"]}),
    "今天天气怎么样": lambda r: r["stats"] == {"requirement_count": 0, "function_count": 0, "product_count": 0},
}
results = {}
for text, check in cases.items():
    result = query(text)
    assert result["provider"] == "LOCAL"
    assert check(result), (text, result["stats"], [x["requirement_id"] for x in result["requirements"]])
    results[text] = {"scope": result["interpretation"]["scope"], "requirements": [x["requirement_id"] for x in result["requirements"][:4]],
                     "functions": [x["function_id"] for x in result["functions"][:4]], "products": [x["product_id"] for x in result["products"][:4]]}

assert get("/semantic/requirement/REQ-ENE-001")["functions"]
assert get("/semantic/function/FN_F_X100_01")["products"]
assert get("/semantic/product/X100")["functions"]
print("SEMANTIC_HTTP_SMOKE = PASS")
print(json.dumps(results, ensure_ascii=False))
