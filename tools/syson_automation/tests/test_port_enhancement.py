from __future__ import annotations

import hashlib
import json
import re
import unittest
from pathlib import Path

from tools.syson_automation.src.container_ibd_builder import build_container_view
from tools.syson_automation.src.representation_service import RepresentationService
from tools.syson_automation.src.syson_client import SysONClient

ROOT = Path(__file__).resolve().parents[3]
FROZEN = ROOT / "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml"
ENHANCED = ROOT / "work/sysmlv2/full_engineering_model/02_port_enhanced/Rail_MBSE_Full_v2_PortEnhanced.sysml"
TRACE = ENHANCED.parent / "PORT_TRACEABILITY.json"
SCOPE = ROOT / "tools/syson_automation/generated/scopes/scope_6289f72770e3.json"
INDEX = ROOT / "tools/syson_automation/cache/port_enhanced_element_index.json"
VIEWS = ROOT / "tools/syson_automation/cache/port_enhanced_views.json"
EXCEL = ROOT / "Req/牵引制动能量回收系统_正式需求库_v2_扩展版.xlsx"


class PortEnhancementTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.original = FROZEN.read_text(encoding="utf-8")
        cls.enhanced = ENHANCED.read_text(encoding="utf-8")
        cls.trace = json.loads(TRACE.read_text(encoding="utf-8"))

    def test_frozen_hashes(self):
        self.assertEqual(hashlib.sha256(FROZEN.read_bytes()).hexdigest(),
                         "a15cf7170dc5458738080a146c391e438fe57b85f9687857f34a081b8efdf0d5")
        self.assertEqual(hashlib.sha256(EXCEL.read_bytes()).hexdigest(),
                         "496736980a493689339eb35df85ec9603f5f9d0fa5e484ef049f990bf0829f01")

    def test_port_ownership_and_evidence(self):
        connector_ids = set(re.findall(r"interface c_(CG_\w+)", self.original))
        for port in self.trace["port_usages"]:
            self.assertIn(port["owner_product"], {"X100", "X110", "X120", "X130", "8100"})
            self.assertIn(port["derived_from"], {"EXPLICIT_CONNECTOR", "EXPLICIT_FLOW", "SSI_INTERFACE",
                                                  "SSD_CONNECTOR", "IMPLEMENTATION_BINDING"})
            self.assertTrue(set(port["connector_refs"]) <= connector_ids)
            if port["owner_product"] in {"X100", "8100"}:
                self.assertEqual(len(port["ssd_refs"]), 1)
                self.assertEqual(port["binding_refs"], port["connector_refs"])
            self.assertRegex(self.enhanced, r"\bport " + re.escape(port["port_id"]) + r"\s*:")
            self.assertIn(port["direction"], {"in", "out"})

    def test_connection_endpoints_and_no_invented_connector(self):
        for connection in self.trace["connection_usages"]:
            self.assertIn("interface c_" + connection["derived_from_connector_id"], self.original)
            self.assertIn(connection["source_path"], self.enhanced)
            self.assertIn(connection["target_path"], self.enhanced)
            self.assertRegex(self.enhanced, r"\bconnection " + re.escape(connection["connection_id"]) + r"\s+connect")
        self.assertEqual(len({x["connection_id"] for x in self.trace["connection_usages"]}),
                         len(self.trace["connection_usages"]))

    def test_no_duplicate_allocation_and_no_bogus_l2_connection(self):
        pattern = r"\ballocation alloc_\w+ allocate fu_\w+ to ap_\w+;"
        self.assertEqual(re.findall(pattern, self.original), re.findall(pattern, self.enhanced))
        self.assertEqual(len(re.findall(pattern, self.enhanced)), 191)
        for connection in self.trace["connection_usages"]:
            path = connection["source_path"] + " " + connection["target_path"]
            self.assertFalse("p_N_5100" in path and "p_X100" in path)

    def test_boundary_projection_and_container_drilldown(self):
        scope = json.loads(SCOPE.read_text(encoding="utf-8"))
        index = json.loads(INDEX.read_text(encoding="utf-8"))
        x100 = build_container_view(scope, "X100", index)
        self.assertEqual(len(x100["internal_connections"]), 9)
        self.assertEqual(len(x100["real_boundary_ports"]), 12)
        self.assertEqual(len(x100["virtual_boundary_projections"]), 0)
        self.assertEqual({x["product_id"] for x in x100["direct_children"]}, {"X110", "X120", "X130"})
        x110 = build_container_view(scope, "X110", index)
        self.assertEqual({x["product_id"] for x in x110["direct_children"]}, {"X111", "X112", "X113"})

    def test_syson_query_back_edges(self):
        index = json.loads(INDEX.read_text(encoding="utf-8"))
        views = json.loads(VIEWS.read_text(encoding="utf-8"))
        service = RepresentationService(SysONClient(timeout=30), index["editing_context_id"])
        for key in ("connection_smoke", "fp", "x100_ibd", "x110_ibd"):
            diagram = service.diagram(views[key])
            self.assertGreater(len(diagram["edges"]), 0, key)


if __name__ == "__main__":
    unittest.main()
