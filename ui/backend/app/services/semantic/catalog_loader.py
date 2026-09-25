from __future__ import annotations

import json
from pathlib import Path


class SemanticCatalog:
    def __init__(self, root: Path):
        self.root = root
        self.requirements = self._load("requirement_catalog.json")["requirements"]
        self.functions = self._load("function_catalog.json")["functions"]
        self.products = self._load("product_catalog.json")["products"]
        self.requirement_function = self._load("requirement_function_map.json")
        self.function_product = self._load("function_product_map.json")
        self.aggregate = self._load("requirement_function_product_map.json")
        self.manifest = self._load("data_build_manifest.json")
        self.requirement_by_id = {x["requirement_id"]: x for x in self.requirements}
        self.function_by_id = {x["function_id"]: x for x in self.functions}
        self.product_by_id = {x["product_id"]: x for x in self.products}

    def _load(self, name):
        return json.loads((self.root / name).read_text(encoding="utf-8"))

    def requirement_detail(self, requirement_id):
        return self.aggregate.get(requirement_id)

    def function_detail(self, function_id):
        fn = self.function_by_id.get(function_id)
        if not fn: return None
        req_rel = [x for x in self.requirement_function["relations"] if x["function_id"] == function_id]
        product_rel = [x for x in self.function_product["relations"] if x["function_id"] == function_id]
        return {"function": fn, "requirements": [{**self.requirement_by_id[x["requirement_id"]], "mapping": x} for x in req_rel],
                "products": [{**self.product_by_id[x["product_id"]], "mapping": x} for x in product_rel]}

    def product_detail(self, product_id):
        product = self.product_by_id.get(product_id)
        if not product: return None
        rels = [x for x in self.function_product["relations"] if x["product_id"] == product_id]
        return {"product": product, "functions": [{**self.function_by_id[x["function_id"]], "mapping": x} for x in rels]}
