from __future__ import annotations

import asyncio
import hashlib
import json
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(ROOT)); sys.path.insert(0, str(ROOT / "ui/backend"))

from app.services.model_graph_service import ModelGraphService
from app.services.semantic.query_service import SemanticQueryService
from app.services.task_slice_service import TaskSliceService
from tools.syson_automation.src.ibd_hierarchy_builder import aggregate_projected_interactions, build_hierarchical_ibd_views
from tools.syson_automation.src.models import CanonicalProduct, HierarchyNode, ProductClosureEdge, ProductClosureNode
from tools.syson_automation.src.nested_ibd_builder import build_nested_ibd_plans
from tools.syson_automation.src.product_canonicalizer import canonicalize_products, merge_visual_occurrences
from tools.syson_automation.src.product_closure import build_product_adjacency, compute_interface_product_closure
from tools.syson_automation.src.product_hierarchy import load_product_hierarchy, reconstruct_scope_hierarchy, resolve_ancestor
from tools.syson_automation.src.scope_builder import build_scope


def products(*codes):
    return [{"id": f"product::{c}", "code": c, "sysml_id": f"P_{c}", "display_name": f"Product {c}", "level": 1,
             "parent_code": None, "source_path": f"model.sysml:{i+1}"} for i, c in enumerate(codes)]


def edge(source, target, flow, interface, connector, kind="physical", direction="source_to_target"):
    return {"source_product_id": source, "target_product_id": target, "flow_refs": [flow], "interface_refs": [interface],
            "connector_refs": [connector], "directions": [direction], "flow_kinds": [kind], "evidence_sources": ["test fixture"]}


class HierarchicalIBDTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.graph_service = ModelGraphService(ROOT)
        cls.task_slice = TaskSliceService(cls.graph_service)
        cls.semantic = SemanticQueryService(ROOT / "ui/backend/data/semantic_slice")
        cls.query = "分析再生制动时超级电容储能相关的需求、功能和接口"
        result = asyncio.run(cls.semantic.query(cls.query, "local"))
        cls.scope = build_scope(cls.query, result, cls.task_slice)
        cls.full = cls.graph_service.get_full_model_graph()

    def test_seed_products_are_exact_real_owner_allocations(self):
        expected = {f.owner_product_id for f in self.scope.functions}
        self.assertEqual(set(self.scope.seed_products), expected)
        catalog = self.task_slice.catalog()["functions"]
        self.assertEqual(len(catalog), 191)
        self.assertTrue(all(len(x["allocations"]) == 1 for x in catalog))
        self.assertEqual(sum(len(x["allocations"]) for x in catalog), 191)
        self.assertTrue({f.id for f in self.scope.functions} <= {x["id"] for x in catalog})

    def test_closure_round_zero_is_seed_set_and_reaches_fixed_point(self):
        self.assertEqual({x.product_id for x in self.scope.product_closure if x.introduced_at_round == 0}, set(self.scope.seed_products))
        self.assertTrue(all(x.introduced_at_round >= 0 for x in self.scope.product_closure))
        closure = {x.product_id for x in self.scope.product_closure}
        self.assertEqual(closure, {e.source_product_id for e in self.scope.closure_edges} | {e.target_product_id for e in self.scope.closure_edges} | set(self.scope.seed_products))
        self.assertGreater(self.scope.closure_stats["closure_rounds"], 0)
        allocation = self.task_slice.project([x.id for x in self.scope.functions])
        interfaces = allocation["stages"][3]["interfaces"] + allocation["stages"][4]["interfaces"]
        relations = json.loads((ROOT / "ui/backend/data/semantic_slice/l2_interaction_catalog.json").read_text(encoding="utf-8"))["interactions"]
        adjacency, _ = build_product_adjacency([n["data"] for n in self.full["nodes"]], relations, self.full, interfaces)
        for node in closure:
            for relation in adjacency.get(node, []):
                neighbor = relation["target_product_id"] if node == relation["source_product_id"] else relation["source_product_id"]
                self.assertIn(neighbor, closure, f"closure stopped before fixed point at {node}→{neighbor}")

    def test_closure_uses_only_real_undirected_product_edges(self):
        nodes = products("A", "B", "C", "unrelated")
        graph = {"leaf_interfaces": [{"id": "leaf::C1", "source": {"node_id": "product::A", "port": {"id": "portA"}},
                  "target": {"node_id": "product::B", "port": {"id": "portB"}}, "flow_items": [{"id": "flow::F1", "kind": "signal"}],
                  "leaf_connection_ids": ["C1"], "direction": "source_to_target"}], "flows": []}
        adjacency, _ = build_product_adjacency(nodes, [], graph)
        closure, _, _ = compute_interface_product_closure({"B"}, adjacency, {n["code"]: n for n in nodes})
        self.assertEqual({x.product_id for x in closure}, {"A", "B"})
        self.assertNotIn("unrelated", {x.product_id for x in closure})

    def test_real_direction_survives_undirected_closure_discovery(self):
        node_map = {n["code"]: n for n in products("A", "B")}
        adjacency = {"A": [edge("A", "B", "flow::A_B", "leaf::A_B", "C_A_B")],
                     "B": [edge("A", "B", "flow::A_B", "leaf::A_B", "C_A_B")]}
        closure, edges, _ = compute_interface_product_closure({"B"}, adjacency, node_map)
        self.assertEqual({x.product_id for x in closure}, {"A", "B"})
        self.assertEqual(edges[0].source_product_id, "A")
        self.assertEqual(edges[0].target_product_id, "B")
        self.assertEqual(edges[0].directions, ["source_to_target"])

    def test_same_name_products_with_distinct_codes_are_not_identity_merged(self):
        node_map = {"A": {"id": "product::A", "sysml_id": "P_A"}, "B": {"id": "product::B", "sysml_id": "P_B"}}
        closure = [ProductClosureNode(product_id=x, product_name="同名产品", canonical_name="同名产品", source_element_ids=[f"product::{x}"], seed=True, introduced_at_round=0) for x in ("A", "B")]
        result, mapping = canonicalize_products(closure, node_map, [])
        self.assertEqual(len(result), 2)
        self.assertNotEqual(mapping["A"], mapping["B"])

    def test_explicit_visual_merge_preserves_all_provenance(self):
        rows = [{"semantic_usage_id": "usage-1", "display_name": "同名产品", "source_product_ids": [x],
                 "source_element_ids": [f"element-{x}"], "source_allocation_refs": [f"alloc-{x}"],
                 "interface_refs": [f"if-{x}"], "connector_refs": [f"conn-{x}"], "flow_refs": [f"flow-{x}"]} for x in ("A", "B")]
        merged = merge_visual_occurrences(rows)
        self.assertEqual(len(merged), 1)
        for field in ("source_product_ids", "source_element_ids", "source_allocation_refs", "interface_refs", "connector_refs", "flow_refs"):
            self.assertEqual(len(merged[0][field]), 2)

    def test_name_only_visual_merge_does_not_merge(self):
        rows = [{"display_name": "同名产品", "source_product_ids": [x]} for x in ("A", "B")]
        self.assertEqual(len(merge_visual_occurrences(rows)), 2)

    def test_hierarchy_comes_from_real_model_not_closure_round(self):
        hierarchy = load_product_hierarchy([n["data"] for n in self.full["nodes"]])
        self.assertTrue(all(x.level == hierarchy[x.product_id]["level"] for x in self.scope.hierarchy_nodes))
        self.assertTrue(all(x.introduced_at_round == 0 or x.introduced_at_round <= self.scope.closure_stats["closure_rounds"] for x in self.scope.product_closure))
        self.assertNotEqual(self.scope.closure_stats["hierarchy_levels_present"], sorted({x.introduced_at_round for x in self.scope.product_closure}))

    def test_hierarchy_ancestor_and_paths_are_reconstructed(self):
        hierarchy = load_product_hierarchy([n["data"] for n in self.full["nodes"]])
        seed = next(x for x in self.scope.seed_products if hierarchy[x]["level"] == 4)
        path = next(x.hierarchy_path for x in self.scope.hierarchy_nodes if x.product_id == seed)
        self.assertEqual(path[0], next(x for x in path if hierarchy[x]["level"] == 1))
        self.assertEqual(path[-1], seed)
        self.assertEqual(len(path), hierarchy[seed]["level"])

    def test_hierarchy_projection_preserves_underlying_evidence_and_bidirectionality(self):
        hierarchy = {"A4": {"product_id": "A4", "level": 4, "parent_product_id": "A2"},
                     "B4": {"product_id": "B4", "level": 4, "parent_product_id": "B2"},
                     "A2": {"product_id": "A2", "level": 2, "parent_product_id": None},
                     "B2": {"product_id": "B2", "level": 2, "parent_product_id": None}}
        edges = [ProductClosureEdge(source_product_id="A4", target_product_id="B4", flow_refs=["f1"], interface_refs=["i1"], connector_refs=["c1"], directions=["source_to_target"]),
                 ProductClosureEdge(source_product_id="B4", target_product_id="A4", flow_refs=["f2"], interface_refs=["i2"], connector_refs=["c2"], directions=["source_to_target"])]
        result = aggregate_projected_interactions(edges, hierarchy, 2, {}, {"f1": "energy", "f2": "signal"})
        self.assertEqual(len(result), 1)
        interaction = result[0]
        self.assertEqual(set(interaction["aggregated_from_flow_refs"]), {"f1", "f2"})
        self.assertEqual(set(interaction["aggregated_from_interface_refs"]), {"i1", "i2"})
        self.assertEqual(set(interaction["aggregated_from_connector_refs"]), {"c1", "c2"})
        self.assertEqual(set(interaction["directions"]), {"FORWARD", "REVERSE"})

    def test_same_ancestor_projection_hides_internal_edge_at_that_level(self):
        hierarchy = {"A4": {"product_id": "A4", "level": 4, "parent_product_id": "A2"}, "B4": {"product_id": "B4", "level": 4, "parent_product_id": "A2"}, "A2": {"product_id": "A2", "level": 2, "parent_product_id": None}}
        edge_row = ProductClosureEdge(source_product_id="A4", target_product_id="B4", flow_refs=["f"], interface_refs=["i"], connector_refs=["c"], directions=["source_to_target"])
        self.assertEqual(aggregate_projected_interactions([edge_row], hierarchy, 2, {}, {"f": "physical"}), [])

    def test_nested_projection_keeps_siblings_internal_and_cross_root_on_boundaries(self):
        nodes = [
            HierarchyNode(product_id="R1", product_name="Root 1", level=1, child_product_ids=["A2"], hierarchy_path=["R1"], role="HIERARCHY_ANCESTOR"),
            HierarchyNode(product_id="A2", product_name="Subsystem A", level=2, parent_product_id="R1", child_product_ids=["A3"], hierarchy_path=["R1", "A2"], role="HIERARCHY_ANCESTOR"),
            HierarchyNode(product_id="A3", product_name="Branch A", level=3, parent_product_id="A2", child_product_ids=["A4", "B4"], hierarchy_path=["R1", "A2", "A3"], role="HIERARCHY_ANCESTOR"),
            HierarchyNode(product_id="A4", product_name="Part A", level=4, parent_product_id="A3", hierarchy_path=["R1", "A2", "A3", "A4"], role="INTERACTION_NEIGHBOR"),
            HierarchyNode(product_id="B4", product_name="Part B", level=4, parent_product_id="A3", hierarchy_path=["R1", "A2", "A3", "B4"], role="INTERACTION_NEIGHBOR"),
            HierarchyNode(product_id="R2", product_name="Root 2", level=1, child_product_ids=["C2"], hierarchy_path=["R2"], role="HIERARCHY_ANCESTOR"),
            HierarchyNode(product_id="C2", product_name="Subsystem C", level=2, parent_product_id="R2", child_product_ids=["C3"], hierarchy_path=["R2", "C2"], role="HIERARCHY_ANCESTOR"),
            HierarchyNode(product_id="C3", product_name="Branch C", level=3, parent_product_id="C2", child_product_ids=["C4"], hierarchy_path=["R2", "C2", "C3"], role="HIERARCHY_ANCESTOR"),
            HierarchyNode(product_id="C4", product_name="Part C", level=4, parent_product_id="C3", hierarchy_path=["R2", "C2", "C3", "C4"], role="INTERACTION_NEIGHBOR"),
        ]
        edges = [
            ProductClosureEdge(source_product_id="A4", target_product_id="B4", flow_refs=["flow_internal"], interface_refs=["if_internal"], connector_refs=["conn_internal"]),
            ProductClosureEdge(source_product_id="A3", target_product_id="B4", flow_refs=["flow_only"], interface_refs=["if_only"]),
            ProductClosureEdge(source_product_id="A4", target_product_id="C4", flow_refs=["flow_cross"], interface_refs=["if_cross"], connector_refs=["conn_cross"]),
        ]
        plans = {p["level"]: p for p in build_nested_ibd_plans("test", nodes, edges, [])}
        self.assertEqual(plans[3]["internal_connections"][0]["source_product_id"], "A4")
        self.assertEqual(plans[3]["internal_connections"][0]["evidence_type"], "EXPLICIT_CONNECTOR")
        self.assertIn("EXPLICIT_FLOW", {x["evidence_type"] for p in plans.values() for x in p["internal_connections"]})
        self.assertEqual(plans[1]["external_connections"][0]["evidence_type"], "DERIVED_BOUNDARY")
        self.assertEqual(plans[1]["external_connections"][0]["flow_refs"], ["flow_cross"])
        self.assertFalse(any({x["source_product_id"], x["target_product_id"]} == {"A4", "C4"}
                             for plan in plans.values() for x in plan["external_connections"]))
        self.assertGreater(sum(len(p["boundary_links"]) for p in plans.values()), 0)
        for plan in plans.values():
            for row in plan["internal_connections"] + plan["boundary_links"] + plan["external_connections"]:
                self.assertTrue(row["flow_refs"])
                self.assertTrue(row["interface_refs"])

    def test_nested_projection_rejects_edges_without_real_evidence(self):
        hierarchy = [HierarchyNode(product_id="A", product_name="A", level=1, hierarchy_path=["A"], role="OWNER"),
                     HierarchyNode(product_id="B", product_name="B", level=1, hierarchy_path=["B"], role="OWNER")]
        edge_row = ProductClosureEdge(source_product_id="A", target_product_id="B")
        with self.assertRaisesRegex(ValueError, "no real evidence refs"):
            build_nested_ibd_plans("test", hierarchy, [edge_row], [])

    def test_actual_scope_has_at_most_four_hierarchical_views_not_pair_views(self):
        views = self.scope.view_plan.hierarchical_ibd_views
        self.assertLessEqual(len(views), 4)
        self.assertEqual(len(views), len(self.scope.closure_stats["hierarchy_levels_present"]))
        self.assertTrue(all(v.name.startswith("AUTO_IBD_L") and "→" not in v.name for v in views))
        self.assertEqual([v.hierarchy_level for v in views], self.scope.closure_stats["hierarchy_levels_present"])
        for index, view in enumerate(views):
            self.assertEqual(view.parent_view_name, views[index - 1].name if index else None)
            self.assertEqual(view.child_view_names, [views[index + 1].name] if index + 1 < len(views) else [])

    def test_68_scope_flows_do_not_create_22_pair_views(self):
        self.assertEqual(len(self.scope.products), 19)
        self.assertEqual(len(self.scope.flows), 68)
        self.assertEqual(len(self.scope.view_plan.hierarchical_ibd_views), 4)

    def test_every_projected_interaction_retains_real_flow_interface_connector_refs(self):
        flow_refs = {x["id"] for x in self.full["flows"]}
        canonical_ids = {x.canonical_id for x in self.scope.canonical_products}
        for view in self.scope.hierarchical_ibd_views:
            self.assertTrue(set(view.canonical_product_ids) <= canonical_ids)
            for edge_row in view.projected_interactions:
                refs = edge_row["aggregated_from_flow_refs"]
                self.assertTrue(refs)
                self.assertTrue(set(refs) <= flow_refs)
                self.assertTrue(edge_row["aggregated_from_interface_refs"])
                self.assertTrue(edge_row["aggregated_from_connector_refs"])

    def test_forbidden_direct_l2_edge_is_absent(self):
        self.assertFalse(any({e.source_product_id, e.target_product_id} == {"5100", "X100"} for e in self.scope.closure_edges))
        self.assertFalse(any({e["source"], e["target"]} == {"5100", "X100"} for v in self.scope.hierarchical_ibd_views for e in v.projected_interactions))

    def test_frozen_sysml_and_v2_workbook_hashes(self):
        sysml = ROOT / "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml"
        workbook = ROOT / "Req/牵引制动能量回收系统_正式需求库_v2_扩展版.xlsx"
        self.assertEqual(hashlib.sha256(sysml.read_bytes()).hexdigest(), "a15cf7170dc5458738080a146c391e438fe57b85f9687857f34a081b8efdf0d5")
        self.assertEqual(hashlib.sha256(workbook.read_bytes()).hexdigest(), "496736980a493689339eb35df85ec9603f5f9d0fa5e484ef049f990bf0829f01")

    def test_pair_focused_planner_is_removed_from_scope_builder_output(self):
        self.assertEqual(self.scope.view_plan.ibd_views, self.scope.view_plan.hierarchical_ibd_views)
        self.assertFalse(any("→" in view.name for view in self.scope.view_plan.ibd_views))


if __name__ == "__main__":
    unittest.main()
