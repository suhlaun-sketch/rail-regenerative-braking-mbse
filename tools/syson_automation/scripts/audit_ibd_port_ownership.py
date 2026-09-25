"""Audit semantic versus graphical PortUsage ownership for two IBD pilots."""
from __future__ import annotations

import json
import re
from collections import defaultdict
from collections import Counter
from pathlib import Path

import psycopg2

from tools.syson_automation.src.representation_service import RepresentationService
from tools.syson_automation.src.syson_client import SysONClient

ROOT = Path(__file__).resolve().parents[3]
REPORTS = ROOT / "work/reports"


def read(path):
    return json.loads(path.read_text(encoding="utf-8"))


def literal_attribute(element, name):
    for rel in (element.get("data") or {}).get("ownedRelationship", []):
        for attr in (rel.get("data") or {}).get("ownedRelatedElement", []):
            if (attr.get("data") or {}).get("declaredName") == name:
                for val in (attr.get("data") or {}).get("ownedRelationship", []):
                    for lit in (val.get("data") or {}).get("ownedRelatedElement", []):
                        if "value" in (lit.get("data") or {}):
                            return lit["data"]["value"]
    return None


def main():
    state = read(ROOT / "tools/syson_automation/cache/full_final_project.json")
    index = read(ROOT / "tools/syson_automation/cache/full_final_element_index.json")
    hierarchy = read(REPORTS / "FULL_PRODUCT_HIERARCHY.json")
    relations = read(REPORTS / "FULL_RELATION_ENDPOINTS.json")["relations"]
    trace = read(ROOT / "work/sysmlv2/full_engineering_model/03_full_boundary/FULL_PORT_TRACEABILITY.json")
    old_views = read(REPORTS / "FULL_SYSON_VIEW_REGISTRY.json")
    products = {p["product_code"]: p for p in hierarchy["products"]}
    entry_by_oid = {e["syson_object_id"]: e for e in index["entries"]}
    code_by_definition = {p["definition_id"]: p["product_code"] for p in hierarchy["products"]}
    owner_by_port = {}
    for e in index["entries"]:
        if e["sysml_type"] == "PortUsage":
            parts = e["qualified_name"].split("::")
            if len(parts) == 3 and parts[0] == "ProductDefinitions":
                owner_by_port[e["syson_object_id"]] = code_by_definition.get(parts[1])
    boundary_by_id = {p["port_id"]: p for p in trace["port_usages"]}
    live_service = RepresentationService(SysONClient(timeout=60), state["editing_context_id"])

    conn = psycopg2.connect(host="127.0.0.1", dbname="postgres", user="syson")
    conn.set_session(readonly=True)
    cur = conn.cursor()
    cur.execute("select content from document where id=%s", (state["model_document_id"],))
    document = json.loads(cur.fetchone()[0])
    semantic_objects = {}
    def semantic_walk(value):
        if isinstance(value, list):
            for item in value:
                semantic_walk(item)
        elif isinstance(value, dict):
            if "id" in value and "eClass" in value:
                semantic_objects[value["id"]] = value
            for child in value.values():
                if isinstance(child, (list, dict)):
                    semantic_walk(child)
    semantic_walk(document)

    def diagram(rep_id):
        cur.execute("select content from representation_content where id like %s", ("%" + rep_id,))
        result = cur.fetchone()
        return json.loads(result[0]) if result else None

    def graph(diag):
        nodes = {}
        parent = {}
        def walk(items, parent_id):
            for node in items:
                nodes[node["id"]] = node
                parent[node["id"]] = parent_id
                walk(node.get("childNodes") or [], node["id"])
                walk(node.get("borderNodes") or [], node["id"])
        walk(diag["nodes"], None)
        return nodes, parent

    def graph_owner(node_id, nodes, parents):
        parent_id = parents.get(node_id)
        while parent_id:
            node = nodes[parent_id]
            entry = entry_by_oid.get(node["targetObjectId"], {})
            if entry.get("sysml_type") in ("PartUsage", "PartDefinition"):
                return {"graphical_parent_id": parent_id, "graphical_parent_type": entry["sysml_type"],
                        "current_graphical_owner": entry["semantic_id"],
                        "current_graphical_owner_id": node["targetObjectId"]}
            parent_id = parents.get(parent_id)
        return {"graphical_parent_id": None, "graphical_parent_type": "Diagram",
                "current_graphical_owner": "DIAGRAM_BACKGROUND", "current_graphical_owner_id": None}

    def is_visible(node_id, nodes, parents):
        while node_id:
            if nodes[node_id].get("state") != "Normal":
                return False
            node_id = parents.get(node_id)
        return True

    def real_product_name(product_code):
        definition_id = index["by_semantic_id"][products[product_code]["definition_id"]][0]
        definition = semantic_objects[definition_id]
        return literal_attribute(definition, "chineseName") or literal_attribute(definition, "englishName")

    def real_port_name(port, entry):
        direct = literal_attribute(port, "portName")
        if direct:
            return direct
        boundary = boundary_by_id.get(entry["semantic_id"])
        if not boundary:
            return None
        definition_ids = index["by_semantic_id"].get(boundary["port_type"], [])
        if len(definition_ids) != 1:
            return None
        definition = semantic_objects[definition_ids[0]]
        for relation in (definition.get("data") or {}).get("ownedRelationship", []):
            for member in (relation.get("data") or {}).get("ownedRelatedElement", []):
                if member.get("eClass", "").endswith("ItemUsage"):
                    for typing in (member.get("data") or {}).get("ownedRelationship", []):
                        ref = (typing.get("data") or {}).get("type")
                        item = semantic_objects.get(str(ref).split("#")[-1], {}) if ref else {}
                        name = literal_attribute(item, "chineseName") or literal_attribute(item, "englishName")
                        if name:
                            return name
        return None

    for code in ("X130", "3110"):
        scope = {code, *products[code]["direct_children"]}
        required_relations = [r for r in relations if r["relation_metaclass"] in ("ConnectionUsage", "InterfaceUsage") and
                              owner_by_port.get(r["source_object_id"]) in scope and
                              owner_by_port.get(r["target_object_id"]) in scope]
        required_port_ids = {r[side] for r in required_relations for side in ("source_object_id", "target_object_id")}
        connection_by_port = defaultdict(list)
        for r in relations:
            if r["relation_metaclass"] in ("ConnectionUsage", "InterfaceUsage"):
                for side in ("source_object_id", "target_object_id"):
                    connection_by_port[r[side]].append(r["relation_id"])
        old_id = old_views["AUTO_IBD_" + code]["representation_id"]
        old = diagram(old_id)
        new_name = "AUTO_V3_IBD_" + code
        cur.execute("select id from representation_metadata where label=%s and id like %s", (new_name, state["editing_context_id"] + "#%"))
        hit = cur.fetchone()
        new_rep_id = hit[0].rsplit("#", 1)[1] if hit else None
        new = diagram(new_rep_id) if new_rep_id else None
        live = live_service.diagram(new_rep_id, deep=True) if new_rep_id else None
        old_nodes, old_parents = graph(old)
        original_visible_relation_ids = set()
        for edge in old["edges"]:
            source = old_nodes.get(edge["sourceId"], {}).get("targetObjectId")
            target = old_nodes.get(edge["targetId"], {}).get("targetObjectId")
            if owner_by_port.get(source) in scope and owner_by_port.get(target) in scope:
                required_port_ids.update((source, target))
                original_visible_relation_ids.add(edge["targetObjectId"])
                connection_by_port[source].append(edge["targetObjectId"])
                connection_by_port[target].append(edge["targetObjectId"])
        old_visible = defaultdict(list)
        for node in old_nodes.values():
            entry = entry_by_oid.get(node["targetObjectId"], {})
            if entry.get("sysml_type") == "PortUsage" and (node.get("borderNode") or old_parents[node["id"]] is None) and is_visible(node["id"], old_nodes, old_parents):
                old_visible[node["targetObjectId"]].append((node, graph_owner(node["id"], old_nodes, old_parents)))
        new_nodes, new_parents = graph(new) if new else ({}, {})
        live_queryback_ok = bool(live and live["id"] == new["id"] and
                                 live["top_level_node_count"] == len(new["nodes"]) and
                                 Counter(n["targetObjectId"] for n in live["nodes"]) ==
                                 Counter(n["targetObjectId"] for n in new_nodes.values()) and
                                 Counter(e["targetObjectId"] for e in live["edges"]) ==
                                 Counter(e["targetObjectId"] for e in new["edges"]))
        new_visible = defaultdict(list)
        for node in new_nodes.values():
            entry = entry_by_oid.get(node["targetObjectId"], {})
            if entry.get("sysml_type") == "PortUsage" and (node.get("borderNode") or new_parents[node["id"]] is None) and is_visible(node["id"], new_nodes, new_parents):
                new_visible[node["targetObjectId"]].append((node, graph_owner(node["id"], new_nodes, new_parents)))
        audited = set(required_port_ids) | set(old_visible) | set(new_visible)
        audited.update(oid for oid, owner in owner_by_port.items() if owner == code and
                       entry_by_oid[oid]["semantic_id"] in boundary_by_id)
        port_rows = []
        for oid in sorted(audited, key=lambda x: entry_by_oid.get(x, {}).get("semantic_id", x)):
            entry = entry_by_oid.get(oid, {})
            if entry.get("sysml_type") != "PortUsage":
                continue
            port = semantic_objects.get(oid, {})
            owner_code = owner_by_port.get(oid)
            category = "ROOT_CONTAINER_BOUNDARY" if owner_code == code and entry["semantic_id"] in boundary_by_id else (
                "CHILD_PART_ENDPOINT" if owner_code in products[code]["direct_children"] and oid in required_port_ids else "NOT_NEEDED")
            semantic_owner_name = products[owner_code]["definition_id"] if owner_code in products else None
            semantic_owner_id = index["by_semantic_id"].get(semantic_owner_name, [None])[0] if semantic_owner_name else None
            typing = next((z for z in (port.get("data") or {}).get("ownedRelationship", []) if
                           str(z.get("eClass", "")).split(":")[-1] in ("FeatureTyping", "ConjugatedPortTyping")), None)
            typed = (typing or {}).get("data") or {}
            type_ref = typed.get("type") or typed.get("conjugatedPortDefinition")
            type_id = str(type_ref).split("#")[-1] if type_ref else None
            type_name = (semantic_objects.get(type_id, {}).get("data") or {}).get("declaredName") if type_id else None
            source_direction = literal_attribute(port, "direction") or boundary_by_id.get(entry["semantic_id"], {}).get("direction")
            expected_owner_id = (semantic_owner_id if category == "ROOT_CONTAINER_BOUNDARY" else
                                 index["by_semantic_id"].get(products[owner_code]["usage_id"], [None])[0]
                                 if category == "CHILD_PART_ENDPOINT" else None)
            def seen(items):
                return [{"graphical_node_id": n["id"], "border_node": bool(n.get("borderNode")),
                         "displayed_label": ((n.get("insideLabel") or {}).get("text") or
                                             ((n.get("outsideLabels") or [{}])[0] or {}).get("text")), **g}
                        for n, g in items]
            old_seen, new_seen = seen(old_visible.get(oid, [])), seen(new_visible.get(oid, []))
            def valid(items):
                return any(x["border_node"] and x["current_graphical_owner_id"] == expected_owner_id for x in items)
            status = "NOT_NEEDED" if category == "NOT_NEEDED" else (
                "PASS" if valid(new_seen) else "WRONG_PARENT" if new_seen else "MISSING")
            port_rows.append({"port_name": entry["semantic_id"], "port_object_id": oid,
                "port_definition_or_type": type_name or type_ref, "direction": source_direction,
                "semantic_owner_id": semantic_owner_id, "semantic_owner_name": semantic_owner_name,
                "semantic_owner_metaclass": "PartDefinition" if semantic_owner_id else None,
                "owning_product_code": owner_code, "is_direct_owned": bool(semantic_owner_id),
                "is_inherited_from_definition": bool(owner_code in scope and semantic_owner_id),
                "semantic_display_name": real_port_name(port, entry),
                "category": category, "expected_graphical_owner": products[owner_code]["usage_id"] if
                    category == "CHILD_PART_ENDPOINT" else semantic_owner_name if category == "ROOT_CONTAINER_BOUNDARY" else None,
                "expected_graphical_owner_id": expected_owner_id,
                "current_graphical_owner": [x["current_graphical_owner"] for x in old_seen],
                "graphical_parent_id": [x["graphical_parent_id"] for x in old_seen],
                "graphical_parent_type": [x["graphical_parent_type"] for x in old_seen],
                "old_graphical_instances": old_seen, "smoke_graphical_instances": new_seen,
                "is_container_boundary_port": category == "ROOT_CONTAINER_BOUNDARY",
                "is_child_part_port": category == "CHILD_PART_ENDPOINT",
                "used_by_visible_connection": any(oid in (old_nodes.get(e[k], {}).get("targetObjectId") for k in ("sourceId", "targetId"))
                                                   for e in old["edges"]),
                "used_by_current_level_connection": oid in required_port_ids,
                "connection_ids": sorted(set(connection_by_port.get(oid, []))), "status": status})
        def edge_rows(diag, nodes, parents):
            result = []
            for edge in diag["edges"]:
                endpoints = []
                for side, key in (("source", "sourceId"), ("target", "targetId")):
                    node = nodes.get(edge[key])
                    entry = entry_by_oid.get(node["targetObjectId"], {}) if node else {}
                    endpoints.append({"side": side, "graphical_node_id": edge[key],
                                      "semantic_object_id": node["targetObjectId"] if node else None,
                                      "semantic_name": entry.get("semantic_id"), "semantic_type": entry.get("sysml_type"),
                                      **graph_owner(edge[key], nodes, parents)})
                result.append({"edge_id": edge["id"], "semantic_relation_id": edge["targetObjectId"],
                               "semantic_relation_name": entry_by_oid.get(edge["targetObjectId"], {}).get("semantic_id"),
                               "source": endpoints[0], "target": endpoints[1],
                               "source_port_id": endpoints[0]["semantic_object_id"] if endpoints[0]["semantic_type"] == "PortUsage" else None,
                               "target_port_id": endpoints[1]["semantic_object_id"] if endpoints[1]["semantic_type"] == "PortUsage" else None,
                               "displayed_label": (edge.get("centerLabel") or {}).get("text"),
                               "label_visibility": ((edge.get("centerLabel") or {}).get("style") or {}).get("visibility"),
                               "visible": edge.get("state") == "Normal" and all(is_visible(edge[k], nodes, parents) for k in ("sourceId", "targetId")),
                               "port_to_port": all(e["semantic_type"] == "PortUsage" for e in endpoints)})
            return result
        old_edges = edge_rows(old, old_nodes, old_parents)
        new_edges = edge_rows(new, new_nodes, new_parents) if new else []
        root_rows = [x for x in port_rows if x["category"] == "ROOT_CONTAINER_BOUNDARY"]
        child_rows = [x for x in port_rows if x["category"] == "CHILD_PART_ENDPOINT"]
        expected_relation_ids = {r["relation_id"] for r in required_relations} | original_visible_relation_ids
        visible_new_edges = [x for x in new_edges if x["visible"]]
        covered_relation_ids = {x["semantic_relation_id"] for x in visible_new_edges}
        root_oid = index["by_semantic_id"][products[code]["definition_id"]][0]
        visible_parts = []
        other_visible_parts = []
        for node in new_nodes.values():
            entry = entry_by_oid.get(node["targetObjectId"], {})
            if entry.get("sysml_type") not in ("PartDefinition", "PartUsage") or not is_visible(node["id"], new_nodes, new_parents):
                continue
            if node["targetObjectId"] == root_oid and new_parents.get(node["id"]) is not None:
                continue
            if node["targetObjectId"] != root_oid and not node.get("borderNodes"):
                continue
            code_of_part = next((p["product_code"] for p in products.values() if
                                 p["definition_id"] == entry["semantic_id"] or p["usage_id"] == entry["semantic_id"]), None)
            part_record = {"product_code": code_of_part, "graphical_node_id": node["id"],
                                      "semantic_type": entry["sysml_type"],
                                      "displayed_label": (node.get("insideLabel") or {}).get("text"),
                                      "human_name_in_model": real_product_name(code_of_part) if code_of_part else None,
                                      **graph_owner(node["id"], new_nodes, new_parents)}
            if code_of_part in scope:
                visible_parts.append(part_record)
            else:
                other_visible_parts.append(part_record)
        child_part_rows = [x for x in visible_parts if x["product_code"] != code]
        visible_child_codes = {x["product_code"] for x in child_part_rows}
        hierarchy_ok = len([x for x in visible_parts if x["product_code"] == code]) == 1 and \
            visible_child_codes == set(products[code]["direct_children"]) and \
            all(x["current_graphical_owner_id"] == root_oid for x in child_part_rows) and not other_visible_parts
        internal_label = re.compile(r"(?:^|[\s\^«])(?:p_[A-Z0-9]+|P_[A-Z0-9]+|bp_[A-Z0-9_]+|rp_[A-Za-z0-9_]+|fc_[A-Za-z0-9_]+|net_[A-Za-z0-9_]+)", re.I)
        block_label_failures = [x for x in visible_parts if internal_label.search(x["displayed_label"] or "")]
        port_label_failures = [x for x in port_rows if any(internal_label.search(y.get("displayed_label") or "") for y in x["smoke_graphical_instances"])]
        connection_label_failures = [x for x in visible_new_edges if x["label_visibility"] != "hidden" and
                                     internal_label.search(x["displayed_label"] or "")]
        description_id = new["descriptionId"] if new else None
        actual_description = ("Interconnection View" if description_id and "74c5d045" in description_id else
                              "General View" if description_id and "8dcd14b0" in description_id else "UNKNOWN")
        view_object = semantic_objects.get(new["targetObjectId"], {}) if new else {}
        view_type_ref = next(((r.get("data") or {}).get("type") for r in (view_object.get("data") or {}).get("ownedRelationship", [])
                              if r.get("eClass", "").endswith("FeatureTyping")), None)
        semantic_view_type = "InterconnectionView" if view_type_ref and str(view_type_ref).endswith("#6518462a-2f51-5276-b95e-69ee5193db38") else str(view_type_ref)
        summary = {"semantic_ports": len(port_rows), "inherited_ports": sum(x["is_inherited_from_definition"] for x in port_rows),
                   "root_boundary_ports_expected": len(root_rows),
                   "root_boundary_ports_rendered": sum(x["status"] == "PASS" for x in root_rows),
                   "root_boundary_ports_standalone": sum(any(y["current_graphical_owner"] == "DIAGRAM_BACKGROUND" for y in x["smoke_graphical_instances"]) for x in root_rows),
                   "child_endpoint_ports_expected": len(child_rows),
                   "child_endpoint_ports_rendered": sum(x["status"] == "PASS" for x in child_rows),
                   "connected_child_parts": len({x["owning_product_code"] for x in child_rows}),
                   "connected_child_parts_with_visible_endpoint_ports": len({x["owning_product_code"] for x in child_rows if x["status"] == "PASS"}),
                   "old_standalone_ports": sum(any(y["current_graphical_owner"] == "DIAGRAM_BACKGROUND" for y in x["old_graphical_instances"]) for x in port_rows),
                   "smoke_standalone_ports": sum(any(y["current_graphical_owner"] == "DIAGRAM_BACKGROUND" for y in x["smoke_graphical_instances"]) for x in port_rows),
                   "smoke_orphan_ports": sum(x["category"] == "NOT_NEEDED" and bool(x["smoke_graphical_instances"]) for x in port_rows),
                   "old_port_to_port_edges": sum(x["port_to_port"] and x["visible"] for x in old_edges),
                   "smoke_port_to_port_edges": sum(x["port_to_port"] for x in visible_new_edges),
                   "expected_current_level_edges": len(expected_relation_ids),
                   "visible_current_level_edges": len(covered_relation_ids & expected_relation_ids),
                   "missing_current_level_relation_ids": sorted(expected_relation_ids - covered_relation_ids),
                   "view_kind": actual_description, "semantic_view_type": semantic_view_type,
                   "part_count": len(child_part_rows), "port_count": sum(bool(x["smoke_graphical_instances"]) for x in port_rows),
                   "edge_count": len(visible_new_edges), "hierarchy_ok": hierarchy_ok,
                   "grandchild_or_external_part_leakage": len(other_visible_parts),
                   "live_queryback_ok": live_queryback_ok,
                   "block_internal_id_label_failures": len(block_label_failures),
                   "port_internal_id_label_failures": len(port_label_failures),
                   "connection_internal_id_label_failures": len(connection_label_failures)}
        ownership_ok = root_rows and all(x["status"] == "PASS" for x in root_rows + child_rows) and \
            summary["smoke_standalone_ports"] == 0 and summary["smoke_orphan_ports"] == 0 and hierarchy_ok
        smoke_ok = ownership_ok and live_queryback_ok and actual_description == "Interconnection View" and \
            not (expected_relation_ids - covered_relation_ids) and all(x["port_to_port"] for x in visible_new_edges) and \
            not (block_label_failures or port_label_failures or connection_label_failures)
        report = {"view": "AUTO_IBD_" + code, "smoke_view": new_name, "root_product": code,
                  "smoke_representation_id": new_rep_id,
                  "smoke_url": f"http://localhost:8080/projects/{state['project_id']}/edit/{new_rep_id}" if new_rep_id else None,
                  "live_queryback": {"top_level_nodes": live["top_level_node_count"],
                                     "graphical_nodes": len(live["nodes"]), "graphical_edges": len(live["edges"]),
                                     "matches_persisted": live_queryback_ok} if live else None,
                  "direct_children": products[code]["direct_children"], "model_semantic_ownership": "PartDefinition-owned ports inherited by PartUsage",
                  "summary": summary, "ports": port_rows, "old_edges": old_edges, "smoke_edges": new_edges,
                  "visible_parts": visible_parts,
                  "block_display_labels": [x["displayed_label"] for x in visible_parts],
                  "port_display_labels": [y["displayed_label"] for x in port_rows for y in x["smoke_graphical_instances"]],
                  "connection_display_labels": [x["displayed_label"] for x in visible_new_edges if x["label_visibility"] != "hidden"],
                  "ownership_status": "PASS" if ownership_ok else "FAIL",
                  "status": "PASS" if smoke_ok else "FAIL"}
        out = REPORTS / f"IBD_PORT_OWNERSHIP_AUDIT_{code}.json"
        out.write_text(json.dumps(report, ensure_ascii=False, indent=2), encoding="utf-8")
        print(f"AUDIT_{code}={report['status']} OWNERSHIP={report['ownership_status']} ROOT={summary['root_boundary_ports_rendered']}/{summary['root_boundary_ports_expected']} CHILD={summary['child_endpoint_ports_rendered']}/{summary['child_endpoint_ports_expected']} STANDALONE={summary['smoke_standalone_ports']} EDGES={summary['visible_current_level_edges']}/{summary['expected_current_level_edges']} DESC={actual_description}")
    cur.close()
    conn.close()


if __name__ == "__main__":
    main()
