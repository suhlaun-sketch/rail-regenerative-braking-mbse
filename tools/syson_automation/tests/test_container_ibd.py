from __future__ import annotations

import hashlib
import json
import sys
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(ROOT))

from tools.syson_automation.src.container_ibd_builder import build_container_view
from tools.syson_automation.src.element_resolver import resolve_exact
from tools.syson_automation.src.representation_service import RepresentationService
from tools.syson_automation.src.syson_client import SysONError


class ContainerIBDTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.scope = json.loads((ROOT / "tools/syson_automation/generated/scopes/scope_6289f72770e3.json").read_text(encoding="utf-8"))
        cls.index = json.loads((ROOT / "tools/syson_automation/cache/current_element_index.json").read_text(encoding="utf-8"))

    def test_x100_shows_direct_children_and_only_external_boundary_endpoint(self):
        view = build_container_view(self.scope, "X100", self.index)
        self.assertEqual({x["product_id"] for x in view["direct_children"]}, {"X110", "X120", "X130"})
        self.assertEqual({x["product_id"] for x in view["external_endpoints"]}, {"8100"})
        self.assertFalse({"8121", "8122", "8128"} & {x["product_id"] for x in view["direct_children"] + view["external_endpoints"]})
        self.assertEqual(len(view["internal_connections"]), 9)
        self.assertEqual(len(view["virtual_boundary_projections"]), 3)
        self.assertEqual(len(view["real_boundary_ports"]), 0)
        self.assertTrue(all({x["source_product_id"], x["target_product_id"]} <= {"X110", "X120", "X130"}
                            for x in view["internal_connections"]))
        self.assertTrue(all(x["connector_refs"] or x["flow_refs"] or x["interface_refs"]
                            for x in view["internal_connections"] + view["boundary_links"]))

    def test_full_closure_and_frozen_hashes_survive_display_crop(self):
        self.assertEqual(len(self.scope["product_closure"]), 93)
        self.assertEqual(len(self.scope["closure_edges"]), 152)
        self.assertFalse(any({e["source_product_id"], e["target_product_id"]} == {"5100", "X100"}
                             for e in self.scope["closure_edges"]))
        for name, expected in [
            ("work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml", "a15cf7170dc5458738080a146c391e438fe57b85f9687857f34a081b8efdf0d5"),
            ("Req/牵引制动能量回收系统_正式需求库_v2_扩展版.xlsx", "496736980a493689339eb35df85ec9603f5f9d0fa5e484ef049f990bf0829f01")]:
            self.assertEqual(hashlib.sha256((ROOT / name).read_bytes()).hexdigest(), expected)
        for target in build_container_view(self.scope, "ROOT")["drilldown_targets"]:
            self.assertIn(target["product_id"], {x["product_id"] for x in self.scope["hierarchy_nodes"]})
        self.assertLessEqual(max(x["level"] for x in self.scope["hierarchy_nodes"]), 4)

    def test_real_port_requires_exact_provenance_and_virtual_port_is_local_only(self):
        base = build_container_view(self.scope, "X100", self.index)
        projection = base["virtual_boundary_projections"][0]
        self.assertNotIn("syson_object_id", projection)
        fake = {**self.index, "entries": self.index["entries"] + [{"sysml_type": "PortUsage", "label": "actual_boundary_port",
            "syson_object_id": "real-port-object-id", "properties": {"productCode": "X100",
            "connector_refs": projection["connector_refs"]}}]}
        resolved = build_container_view(self.scope, "X100", fake)
        self.assertEqual(len(resolved["real_boundary_ports"]), 1)
        self.assertEqual(resolved["real_boundary_ports"][0]["syson_object_id"], "real-port-object-id")
        self.assertEqual(len(resolved["virtual_boundary_projections"]), len(base["virtual_boundary_projections"]) - 1)

    def test_index_precedes_search_and_timeout_is_distinct_from_not_found(self):
        class Client:
            def __init__(self, error=None): self.error = error; self.calls = 0
            def search(self, *_):
                self.calls += 1
                if self.error: raise self.error
                return []
        client = Client(SysONError("TimeoutError: timed out"))
        with patch("tools.syson_automation.scripts.build_syson_element_index.build_index", return_value=self.index):
            found = resolve_exact(client, self.index["editing_context_id"], "FN_F_3110_01")
            self.assertEqual(found["object_id"], "4f835bd6-1684-4535-9ef1-8716f1cab65f")
            self.assertEqual(client.calls, 0)
            timed_out = resolve_exact(client, self.index["editing_context_id"], "definitely_missing")
            self.assertEqual(timed_out["status"], "TIMEOUT")
            self.assertEqual(resolve_exact(Client(), self.index["editing_context_id"], "definitely_missing")["status"], "NOT_FOUND")

    def test_auto_prefix_and_duplicate_reuse_do_not_touch_user_view(self):
        service = RepresentationService(object(), self.index["editing_context_id"])
        service.representations = lambda: [{"id": "user-view", "label": "view1", "kind": "Diagram"},
                                           {"id": "auto-view", "label": "AUTO_TEST", "kind": "Diagram"}]
        with self.assertRaises(ValueError):
            service.create_or_reuse(stable_key="user", root_object_id="x", description_id="d", name="view1")
        result = service.create_or_reuse(stable_key="test", root_object_id="x", description_id="d", name="AUTO_TEST")
        self.assertEqual(result["id"], "auto-view")
        self.assertEqual(service.mutation_count, 0)

    def test_query_back_is_required_before_created(self):
        with tempfile.TemporaryDirectory(dir=ROOT / "tools/syson_automation/cache") as tmp:
            import tools.syson_automation.src.representation_service as module
            registry = Path(tmp) / "registry.json"
            registry.write_text(json.dumps({"test": {"id": "rep", "created_by": "syson_automation"}}), encoding="utf-8")
            service = RepresentationService(object(), self.index["editing_context_id"])
            snapshots = iter([{"nodes": [], "edges": []}, {"nodes": [], "edges": []}])
            service.diagram = lambda _id: next(snapshots)
            service.mutation = lambda *args, **kwargs: {"dropOnDiagram": {"__typename": "DropOnDiagramSuccessPayload"}}
            with patch.object(module, "REGISTRY", registry):
                result = service.populate_and_verify("rep", ["real-object"], arrange=False)
            self.assertEqual(result["status"], "POPULATE_FAILED")


if __name__ == "__main__":
    unittest.main()
