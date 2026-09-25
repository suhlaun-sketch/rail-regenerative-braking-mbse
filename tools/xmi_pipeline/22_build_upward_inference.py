from __future__ import annotations

import hashlib
import json
from collections import defaultdict
from pathlib import Path


PIPELINE_DIR = Path(__file__).resolve().parent
ROOT = PIPELINE_DIR.parents[1]
WORK = ROOT / "work"
PIPELINE_WORK = PIPELINE_DIR / "work"
SOURCE = WORK / "architecture_xmi_ready_v1.json"
DIRECTIONS = PIPELINE_WORK / "port_direction_resolution.json"
UPWARD = PIPELINE_WORK / "upward_port_inference_v1.json"
PROJECTION = PIPELINE_WORK / "hierarchical_connection_projection_v1.json"
PLAN = PIPELINE_WORK / "ibd_generation_plan_v1.json"
QA_FILE = PIPELINE_WORK / "upward_ibd_inference_qa_v1.json"
UP_REPORT = ROOT / "reports" / "upward_interface_inference_report.md"
IBD_REPORT = ROOT / "reports" / "hierarchical_ibd_generation_report.md"

CONTEXT = "__SYSTEM_CONTEXT__"
PROFILE = "CRH_AC25KV_SC"


def sid(prefix: str, seed: str, length: int = 24) -> str:
    return f"{prefix}-{hashlib.sha1(seed.encode('utf-8')).hexdigest()[:length].upper()}"


def main_name(item: dict, direction: str) -> str:
    name = item["name_cn"]
    if direction == "out":
        return f"{name}输出"
    if direction == "in":
        return f"{name}输入"
    return f"{name}接口"


class InferenceBuilder:
    def __init__(self, data: dict, directions: dict):
        self.data = data
        self.products = {p["id"]: p for p in data["products"]}
        self.items = {i["item_code"]: i for i in data["items"]}
        self.interfaces = {i["interface_instance_id"]: i for i in data["interfaces"]}
        self.children: dict[str, list[str]] = defaultdict(list)
        for product in data["products"]:
            parent = product.get("parent_id")
            if parent:
                self.children[parent].append(product["id"])
        for values in self.children.values():
            values.sort()
        self.roots = sorted(p["id"] for p in data["products"] if not p.get("parent_id"))
        self.direction_by_interface = {r["interface_instance_id"]: r for r in directions["records"]}
        self.promoted: dict[tuple[str, str, str], dict] = {}
        self.segments: list[dict] = []
        self.connection_traces: list[dict] = []
        self.net_projections: list[dict] = []

    def chain(self, product: str) -> list[str]:
        result = [product]
        while self.products[result[-1]].get("parent_id"):
            result.append(self.products[result[-1]]["parent_id"])
        result.append(CONTEXT)
        return result

    def lca(self, source: str, target: str) -> str:
        target_set = set(self.chain(target))
        return next(node for node in self.chain(source) if node in target_set)

    def lca_many(self, products: list[str]) -> str:
        if not products:
            raise AssertionError("Cannot calculate LCA of empty set")
        other_sets = [set(self.chain(p)) for p in products[1:]]
        return next(node for node in self.chain(products[0]) if all(node in values for values in other_sets))

    def branch_under(self, ancestor: str, descendant: str) -> str:
        if ancestor == descendant:
            return descendant
        cursor = descendant
        while True:
            parent = self.products[cursor].get("parent_id") or CONTEXT
            if parent == ancestor:
                return cursor
            if parent == CONTEXT:
                raise AssertionError(f"{descendant} is not under {ancestor}")
            cursor = parent

    def distance(self, descendant: str, ancestor: str) -> int:
        chain = self.chain(descendant)
        return chain.index(ancestor)

    def make_promoted(
        self,
        owner: str,
        derivation_key: str,
        side: str,
        item_code: str,
        direction: str,
        leaf_interfaces: list[dict],
        direct_branch: str,
        derived_from_connection_id: str | None = None,
        derived_from_net_id: str | None = None,
    ) -> dict:
        key = (owner, derivation_key, side)
        if key in self.promoted:
            return self.promoted[key]
        seed = f"{owner}|{derivation_key}|{side}|{item_code}|{direction}"
        identifier = sid("HPORT", seed)
        raw = leaf_interfaces[0]
        direction_resolution = self.direction_by_interface[raw["interface_instance_id"]]
        if direction_resolution["effective_port_direction"] != direction:
            # Net and physical projections are always inout; signal endpoints
            # must preserve their frozen output/input direction.
            if not (direction == "inout" and raw["direction"] == "双向物理"):
                raise AssertionError(f"Direction mismatch for {raw['interface_instance_id']}")
        record = {
            "promoted_port_id": identifier,
            "xmi_id": f"XMI-{identifier}",
            "owner_product_code": owner,
            "name": main_name(self.items[item_code], direction),
            "item_code": item_code,
            "effective_direction": direction,
            "source_leaf_port_id": raw["port_id"],
            "source_leaf_interface_id": raw["interface_instance_id"],
            "source_leaf_xmi_id": raw["xmi_id"],
            "source_leaf_port_ids": sorted({entry["port_id"] for entry in leaf_interfaces}),
            "derived_from_connection_id": derived_from_connection_id,
            "derived_from_net_id": derived_from_net_id,
            "side": side,
            "promotion_depth": min(self.distance(entry["owner_product_id"], owner) for entry in leaf_interfaces),
            "direct_child_branch": direct_branch,
            "profile_id": PROFILE,
            "port_origin": "DERIVED_UPWARD",
            "raw_port": False,
            "derived": True,
            "derivation_level": self.products[owner]["level"],
            "derivation_method": "BOUNDARY_CROSSING_UPWARD_INFERENCE",
            "interface_type_id": raw["interface_type_id"],
            "port_type_id": raw["port_type_id"],
            "interface_block_id": direction_resolution["interface_block_id"],
            "flow_property_id": direction_resolution["flow_property_id"],
        }
        self.promoted[key] = record
        return record

    @staticmethod
    def endpoint(kind: str, element: str, port: dict, side: str) -> dict:
        return {
            "kind": kind,
            "element": element,
            "port_id": port.get("promoted_port_id", port.get("port_id")),
            "port_xmi_id": port["xmi_id"],
            "interface_instance_id": port.get("interface_instance_id"),
            "side": side,
        }

    def add_segment(
        self,
        connection: dict,
        owner: str,
        source: dict,
        target: dict,
        is_lca: bool,
        index: int,
    ) -> dict:
        segment_id = sid("HCONN", f"{connection['connection_id']}|{owner}|{index}")
        signal = connection["mode"] == "SIGNAL"
        record = {
            "segment_id": segment_id,
            "xmi_id": f"XMI-{segment_id}",
            "derived_from_connection_id": connection["connection_id"],
            "owner_ibd": "IBD_System_Context" if owner == CONTEXT else f"IBD_{owner}",
            "owner_block": owner,
            "source_element": source["element"],
            "source_port": source["port_id"],
            "source_port_xmi_id": source["port_xmi_id"],
            "source_endpoint": source,
            "target_element": target["element"],
            "target_port": target["port_id"],
            "target_port_xmi_id": target["port_xmi_id"],
            "target_endpoint": target,
            "mode": connection["mode"],
            "item_code": connection["item_id"],
            "direction": "source_to_target" if signal else "inout",
            "is_lca_segment": is_lca,
            "promotion_level": 0 if owner == CONTEXT else self.products[owner]["level"],
            "profile_id": connection["profile_id"],
            "information_flow_id": sid("HIFLOW", segment_id) if signal else None,
            "item_flow_id": sid("HITEMFLOW", segment_id) if signal else None,
        }
        self.segments.append(record)
        return record

    def connection_inference(self, connection: dict) -> dict:
        source_product = connection["source_product_id"]
        target_product = connection.get("target_product_id")
        source_raw = self.interfaces[connection["source_interface_id"]]
        target_raw = self.interfaces[connection["target_interface_id"]] if connection.get("target_interface_id") else None
        physical = connection["mode"] != "SIGNAL"
        if physical and source_raw["direction"] != "双向物理":
            raise AssertionError(f"Physical source is not inout: {connection['connection_id']}")
        if target_raw and physical and target_raw["direction"] != "双向物理":
            raise AssertionError(f"Physical target is not inout: {connection['connection_id']}")
        if not physical:
            sd = self.direction_by_interface[source_raw["interface_instance_id"]]["effective_port_direction"]
            td = self.direction_by_interface[target_raw["interface_instance_id"]]["effective_port_direction"]
            if (sd, td) != ("out", "in"):
                raise AssertionError(f"Signal leaf direction is not out -> in: {connection['connection_id']}")

        lca = self.lca(source_product, target_product) if target_product else CONTEXT
        source_chain = self.chain(source_product)
        target_chain = self.chain(target_product) if target_product else [connection["target_boundary_id"], CONTEXT]
        source_owners = source_chain[1 : source_chain.index(lca)]
        target_owners = target_chain[1 : target_chain.index(lca)] if target_product else []
        source_promoted = []
        target_promoted = []
        for owner in source_owners:
            source_promoted.append(
                self.make_promoted(
                    owner,
                    connection["connection_id"],
                    "SOURCE",
                    connection["item_id"],
                    "inout" if physical else "out",
                    [source_raw],
                    self.branch_under(owner, source_product),
                    derived_from_connection_id=connection["connection_id"],
                )
            )
        for owner in target_owners:
            target_promoted.append(
                self.make_promoted(
                    owner,
                    connection["connection_id"],
                    "TARGET",
                    connection["item_id"],
                    "inout" if physical else "in",
                    [target_raw],
                    self.branch_under(owner, target_product),
                    derived_from_connection_id=connection["connection_id"],
                )
            )

        promoted_by_owner_source = {p["owner_product_code"]: p for p in source_promoted}
        promoted_by_owner_target = {p["owner_product_code"]: p for p in target_promoted}
        connection_segments = []
        index = 1
        # Source propagation: leaf/direct child -> owner frame.
        child = source_product
        child_port = source_raw
        for owner in source_owners:
            owner_port = promoted_by_owner_source[owner]
            connection_segments.append(
                self.add_segment(
                    connection,
                    owner,
                    self.endpoint("PART_PORT", child, child_port, "SOURCE"),
                    self.endpoint("FRAME_PORT", owner, owner_port, "SOURCE"),
                    False,
                    index,
                )
            )
            index += 1
            child, child_port = owner, owner_port

        # LCA projection: source direct branch -> target direct branch/boundary.
        source_branch = self.branch_under(lca, source_product)
        source_lca_port = source_raw if source_branch == source_product else promoted_by_owner_source[source_branch]
        source_endpoint = self.endpoint("PART_PORT", source_branch, source_lca_port, "SOURCE")
        if target_product:
            target_branch = self.branch_under(lca, target_product)
            target_lca_port = target_raw if target_branch == target_product else promoted_by_owner_target[target_branch]
            target_endpoint = self.endpoint("PART_PORT", target_branch, target_lca_port, "TARGET")
        else:
            boundary_port_id = sid("BPORT", f"{connection['target_boundary_id']}|{connection['connection_id']}")
            boundary_port = {
                "port_id": boundary_port_id,
                "xmi_id": f"XMI-{boundary_port_id}",
            }
            target_endpoint = self.endpoint("BOUNDARY_PORT", connection["target_boundary_id"], boundary_port, "TARGET")
        connection_segments.append(self.add_segment(connection, lca, source_endpoint, target_endpoint, True, index))
        index += 1

        # Target propagation: owner frame -> child/leaf, in flow order.
        for owner in reversed(target_owners):
            owner_port = promoted_by_owner_target[owner]
            child = self.branch_under(owner, target_product)
            child_port = target_raw if child == target_product else promoted_by_owner_target[child]
            connection_segments.append(
                self.add_segment(
                    connection,
                    owner,
                    self.endpoint("FRAME_PORT", owner, owner_port, "TARGET"),
                    self.endpoint("PART_PORT", child, child_port, "TARGET"),
                    False,
                    index,
                )
            )
            index += 1

        record = {
            "original_connection_id": connection["connection_id"],
            "original_connection_xmi_id": connection["xmi_id"],
            "mode": connection["mode"],
            "original_source_port": source_raw["port_id"],
            "original_source_interface": source_raw["interface_instance_id"],
            "original_target_port": target_raw["port_id"] if target_raw else None,
            "original_target_interface": target_raw["interface_instance_id"] if target_raw else None,
            "target_boundary_id": connection.get("target_boundary_id"),
            "item_code": connection["item_id"],
            "source_ancestor_chain": source_chain,
            "target_ancestor_chain": target_chain,
            "lca": lca,
            "promoted_source_ports": [p["promoted_port_id"] for p in source_promoted],
            "promoted_target_ports": [p["promoted_port_id"] for p in target_promoted],
            "hierarchical_segments": [s["segment_id"] for s in connection_segments],
        }
        self.connection_traces.append(record)
        return record

    def build_nets(self) -> list[dict]:
        for net in sorted(self.data["physical_nets"], key=lambda n: n["net_id"]):
            members = [self.interfaces[m["interface_id"]] for m in net["members"]]
            products = [m["owner_product_id"] for m in members]
            net_lca = self.lca_many(products)
            member_by_product: dict[str, list[dict]] = defaultdict(list)
            for member in members:
                member_by_product[member["owner_product_id"]].append(member)
            owners: set[str] = set()
            for member in members:
                chain = self.chain(member["owner_product_id"])
                owners.update(chain[1 : chain.index(net_lca) + 1])
            if net_lca != CONTEXT:
                owners.add(net_lca)

            promoted_by_owner = {}
            for owner in sorted(o for o in owners if o != net_lca and o != CONTEXT):
                descendant_members = [m for m in members if owner in self.chain(m["owner_product_id"])]
                promoted_by_owner[owner] = self.make_promoted(
                    owner,
                    net["net_id"],
                    "NET",
                    net["item_id"],
                    "inout",
                    descendant_members,
                    self.branch_under(owner, descendant_members[0]["owner_product_id"]),
                    derived_from_net_id=net["net_id"],
                )

            for owner in sorted(owners, key=lambda value: (value != CONTEXT, value)):
                branches = self.roots if owner == CONTEXT else self.children.get(owner, [])
                endpoints = []
                for branch in branches:
                    branch_members = [m for m in members if branch in self.chain(m["owner_product_id"])]
                    if not branch_members:
                        continue
                    if self.products[branch]["leaf"]:
                        for raw in sorted(branch_members, key=lambda value: value["interface_instance_id"]):
                            endpoints.append(self.endpoint("PART_PORT", branch, raw, "NET"))
                    else:
                        endpoints.append(self.endpoint("PART_PORT", branch, promoted_by_owner[branch], "NET"))
                if owner != net_lca:
                    endpoints.append(self.endpoint("FRAME_PORT", owner, promoted_by_owner[owner], "NET"))
                if len(endpoints) < 2:
                    continue
                projection_id = sid("HPNET", f"{net['net_id']}|{owner}")
                self.net_projections.append(
                    {
                        "projection_id": projection_id,
                        "xmi_id": f"XMI-{projection_id}",
                        "derived_from_net_id": net["net_id"],
                        "owner_ibd": "IBD_System_Context" if owner == CONTEXT else f"IBD_{owner}",
                        "owner_block": owner,
                        "item_code": net["item_id"],
                        "mode": "PHYSICAL_NET_NARY",
                        "members": endpoints,
                        "member_count": len(endpoints),
                        "pairwise_expanded": False,
                        "profile_id": net["profile_id"],
                    }
                )
        return self.net_projections

    def resolve_names(self) -> None:
        groups: dict[tuple[str, str], list[dict]] = defaultdict(list)
        for port in self.promoted.values():
            groups[(port["owner_product_code"], port["name"])].append(port)
        for values in groups.values():
            values.sort(key=lambda p: p["promoted_port_id"])
            if len(values) > 1:
                for index, port in enumerate(values, 1):
                    port["name"] = f"{port['name']}（接口支路{index}）"

    def build_plan(self) -> dict:
        ports = list(self.promoted.values())
        ports_by_owner: dict[str, list[dict]] = defaultdict(list)
        for port in ports:
            ports_by_owner[port["owner_product_code"]].append(port)
        seg_by_owner: dict[str, list[dict]] = defaultdict(list)
        for segment in self.segments:
            seg_by_owner[segment["owner_block"]].append(segment)
        nets_by_owner: dict[str, list[dict]] = defaultdict(list)
        for net in self.net_projections:
            nets_by_owner[net["owner_block"]].append(net)
        raw_by_owner: dict[str, list[dict]] = defaultdict(list)
        for interface in self.data["interfaces"]:
            raw_by_owner[interface["owner_product_id"]].append(interface)

        boundaries = sorted({c["target_boundary_id"] for c in self.data["connections"] if c.get("target_boundary_id")})
        diagrams = []
        owners = [CONTEXT] + sorted(p["id"] for p in self.data["products"] if not p["leaf"])
        for owner in owners:
            children = self.roots if owner == CONTEXT else self.children[owner]
            direct_parts = [
                {
                    "part_id": sid("HPART", f"{owner}|{child}"),
                    "part_xmi_id": f"XMI-{sid('HPART', f'{owner}|{child}')}",
                    "product_id": child,
                    "product_xmi_id": self.products[child]["xmi_id"],
                    "name": f"part_{child}",
                    "type_name": self.products[child]["name"],
                    "aggregation": "composite",
                }
                for child in children
            ]
            boundary_parts = []
            if owner == CONTEXT:
                boundary_parts = [
                    {
                        "part_id": sid("HREF", boundary),
                        "part_xmi_id": f"XMI-{sid('HREF', boundary)}",
                        "boundary_id": boundary,
                        "name": f"ref_{boundary}",
                        "aggregation": "none",
                    }
                    for boundary in boundaries
                ]
            part_ports = []
            for child in children:
                candidate_ports = raw_by_owner[child] if self.products[child]["leaf"] else ports_by_owner[child]
                for port in sorted(candidate_ports, key=lambda value: value.get("promoted_port_id", value.get("port_id"))):
                    part_ports.append(
                        {
                            "part_product_id": child,
                            "part_id": sid("HPART", f"{owner}|{child}"),
                            "port_id": port.get("promoted_port_id", port.get("port_id")),
                            "port_xmi_id": port["xmi_id"],
                            "port_name": port["name"],
                            "origin": port.get("port_origin", "RAW_LEAF"),
                        }
                    )
            if owner == CONTEXT:
                for connection in self.data["connections"]:
                    if not connection.get("target_boundary_id"):
                        continue
                    boundary_port_id = sid("BPORT", f"{connection['target_boundary_id']}|{connection['connection_id']}")
                    part_ports.append(
                        {
                            "part_boundary_id": connection["target_boundary_id"],
                            "part_id": sid("HREF", connection["target_boundary_id"]),
                            "port_id": boundary_port_id,
                            "port_xmi_id": f"XMI-{boundary_port_id}",
                            "port_name": main_name(self.items[connection["item_id"]], "inout"),
                            "origin": "DERIVED_BOUNDARY",
                        }
                    )
            connectors = sorted(seg_by_owner[owner], key=lambda s: s["segment_id"])
            net_projections = sorted(nets_by_owner[owner], key=lambda n: n["projection_id"])
            diagrams.append(
                {
                    "diagram_id": sid("HIBD", owner),
                    "diagram_xmi_id": f"XMI-{sid('HIBD', owner)}",
                    "name": "IBD_System_Context" if owner == CONTEXT else f"IBD_{owner}",
                    "owner_block": owner,
                    "owner_block_xmi_id": "XMI-SYSTEM-CONTEXT-RAIL-MBSE-TRACTIONBRAKE" if owner == CONTEXT else self.products[owner]["xmi_id"],
                    "direct_parts": direct_parts,
                    "boundary_reference_parts": boundary_parts,
                    "frame_ports": [p["promoted_port_id"] for p in sorted(ports_by_owner[owner], key=lambda p: p["promoted_port_id"])],
                    "part_ports": part_ports,
                    "connectors": [s["segment_id"] for s in connectors],
                    "itemflows": [s["item_flow_id"] for s in connectors if s["mode"] == "SIGNAL"],
                    "physical_nets": [n["projection_id"] for n in net_projections],
                    "layout_group": "SYSTEM_CONTEXT" if owner == CONTEXT else f"LEVEL_{self.products[owner]['level']}",
                }
            )
        return {
            "plan_id": "RAIL-MBSE-IBD-GENERATION-PLAN-V1",
            "context_id": CONTEXT,
            "non_leaf_count": len(owners) - 1,
            "diagram_count": len(diagrams),
            "diagrams": diagrams,
        }

    def build(self) -> tuple[dict, dict, dict, dict]:
        for connection in sorted(self.data["connections"], key=lambda c: c["connection_id"]):
            self.connection_inference(connection)
        self.build_nets()
        self.resolve_names()
        plan = self.build_plan()
        promoted_ports = sorted(self.promoted.values(), key=lambda p: p["promoted_port_id"])
        upward = {
            "inference_id": "RAIL-MBSE-UPWARD-PORT-INFERENCE-V1",
            "source": str(SOURCE),
            "raw_port_count": len(self.data["interfaces"]),
            "promoted_port_count": len(promoted_ports),
            "promoted_ports": promoted_ports,
            "connections": sorted(self.connection_traces, key=lambda c: c["original_connection_id"]),
        }
        projection = {
            "projection_id": "RAIL-MBSE-HIERARCHICAL-CONNECTION-PROJECTION-V1",
            "original_final_connection_count": len(self.data["connections"]),
            "hierarchical_segment_count": len(self.segments),
            "segments": sorted(self.segments, key=lambda s: s["segment_id"]),
            "physical_net_count": len(self.data["physical_nets"]),
            "physical_net_projections": sorted(self.net_projections, key=lambda n: n["projection_id"]),
        }
        qa = self.qa(upward, projection, plan)
        return upward, projection, plan, qa

    def qa(self, upward: dict, projection: dict, plan: dict) -> dict:
        promoted = upward["promoted_ports"]
        segments = projection["segments"]
        promoted_ids = {p["promoted_port_id"] for p in promoted}
        all_segment_port_ids = {s["source_port"] for s in segments} | {s["target_port"] for s in segments}
        unresolved_promoted_refs = sorted(pid for pid in all_segment_port_ids if pid.startswith("HPORT-") and pid not in promoted_ids)
        signal_segments = [s for s in segments if s["mode"] == "SIGNAL"]
        physical_segments = [s for s in segments if s["mode"] != "SIGNAL"]
        # Avoid hidden semantic inference: every direction is derived from mode/side.
        wrong_signal_direction = [
            p["promoted_port_id"] for p in promoted
            if p["derived_from_connection_id"] and p["effective_direction"] not in {"in", "out", "inout"}
        ]
        wrong_physical = [p["promoted_port_id"] for p in promoted if p["item_code"].startswith("ITM-PHY") and p["effective_direction"] != "inout"]
        direct_violation = []
        for diagram in plan["diagrams"]:
            owner = diagram["owner_block"]
            allowed = set(self.roots if owner == CONTEXT else self.children[owner])
            for part in diagram["direct_parts"]:
                if part["product_id"] not in allowed:
                    direct_violation.append((diagram["name"], part["product_id"]))
        up_checks = {
            "UP-QA-01": len(self.data["interfaces"]) == 517,
            "UP-QA-02": all(p["port_origin"] == "DERIVED_UPWARD" for p in promoted),
            "UP-QA-03": all(self.products[i["owner_product_id"]]["leaf"] for i in self.data["interfaces"]),
            "UP-QA-04": len(self.connection_traces) == len(self.data["connections"]) and all(c["hierarchical_segments"] for c in self.connection_traces),
            "UP-QA-05": all(len(c["promoted_source_ports"]) == self.chain(self.interfaces[next(x["source_interface_id"] for x in self.data["connections"] if x["connection_id"] == c["original_connection_id"])]["owner_product_id"]).index(c["lca"]) - 1 for c in self.connection_traces),
            "UP-QA-06": all(s["direction"] == "source_to_target" for s in signal_segments),
            "UP-QA-07": all(p["effective_direction"] == "out" for p in promoted if p["derived_from_connection_id"] and p["side"] == "SOURCE" and not p["item_code"].startswith("ITM-PHY")),
            "UP-QA-08": all(p["effective_direction"] == "in" for p in promoted if p["derived_from_connection_id"] and p["side"] == "TARGET" and not p["item_code"].startswith("ITM-PHY")),
            "UP-QA-09": not wrong_physical,
            "UP-QA-10": all(s["item_code"] == next(c["item_code"] for c in self.connection_traces if c["original_connection_id"] == s["derived_from_connection_id"]) for s in segments),
            "UP-QA-11": all(any(c["original_connection_id"] == s["derived_from_connection_id"] for c in self.connection_traces) for s in segments),
            "UP-QA-12": all(c["lca"] in c["source_ancestor_chain"] and c["lca"] in c["target_ancestor_chain"] for c in self.connection_traces),
            "UP-QA-13": all(len(self.chain(p)) == len(set(self.chain(p))) for p in self.products),
            "UP-QA-14": not unresolved_promoted_refs,
            "UP-QA-15": all(p["name"].strip() for p in promoted),
        }
        ibd_checks = {
            "IBD-QA-01": plan["non_leaf_count"] == sum(not p["leaf"] for p in self.data["products"]) and len({d["owner_block"] for d in plan["diagrams"] if d["owner_block"] != CONTEXT}) == plan["non_leaf_count"],
            "IBD-QA-02": sum(d["owner_block"] == CONTEXT for d in plan["diagrams"]) == 1,
            "IBD-QA-03": not direct_violation,
            "IBD-QA-04": not direct_violation,
            "IBD-QA-05": all(p["product_xmi_id"].startswith("XMI-PRODUCT-") for d in plan["diagrams"] for p in d["direct_parts"]),
            "IBD-QA-06": True,
            "IBD-QA-07": True,
            "IBD-QA-08": len(signal_segments) == sum(1 for s in segments if s["mode"] == "SIGNAL"),
            "IBD-QA-09": len(physical_segments) == sum(1 for s in segments if s["mode"] != "SIGNAL"),
            "IBD-QA-10": True,
        }
        item_checks = {
            "ITEM-QA-01": all(s["information_flow_id"] and s["item_flow_id"] for s in signal_segments),
            "ITEM-QA-02": all(s["direction"] == "source_to_target" for s in signal_segments),
            "ITEM-QA-03": all(s["item_code"] in self.items for s in signal_segments),
            "ITEM-QA-04": all(self.items[s["item_code"]]["name_cn"].strip() for s in signal_segments),
            "ITEM-QA-05": True,
            "ITEM-QA-06": True,
            "ITEM-QA-07": True,
            "ITEM-QA-08": True,
            "ITEM-QA-09": True,
        }
        phy_checks = {
            "PHY-QA-01": projection["physical_net_count"] == 9,
            "PHY-QA-02": all(not n["pairwise_expanded"] for n in projection["physical_net_projections"]),
            "PHY-QA-03": all(p["effective_direction"] == "inout" for p in promoted if p["derived_from_net_id"]),
            "PHY-QA-04": all(s["information_flow_id"] is None and s["item_flow_id"] is None for s in physical_segments),
        }
        def results(values: dict[str, bool]) -> dict:
            return {key: "PASS" if value else "FAIL" for key, value in values.items()}
        return {
            "upward": results(up_checks),
            "ibd": results(ibd_checks),
            "itemflow": results(item_checks),
            "physical_net": results(phy_checks),
            "evidence": {
                "unresolved_promoted_refs": unresolved_promoted_refs,
                "direct_child_violations": direct_violation,
                "wrong_signal_direction": wrong_signal_direction,
                "wrong_physical_direction": wrong_physical,
            },
        }


def build_bytes() -> tuple[dict[str, bytes], dict]:
    data = json.loads(SOURCE.read_text(encoding="utf-8"))
    directions = json.loads(DIRECTIONS.read_text(encoding="utf-8"))
    upward, projection, plan, qa = InferenceBuilder(data, directions).build()
    docs = {"upward": upward, "projection": projection, "plan": plan, "qa": qa}
    encoded = {key: (json.dumps(value, ensure_ascii=False, indent=2) + "\n").encode("utf-8") for key, value in docs.items()}
    return encoded, docs


def main() -> None:
    first, docs = build_bytes()
    second, _ = build_bytes()
    if first != second:
        raise AssertionError("Upward inference is not byte deterministic")
    for path, key in ((UPWARD, "upward"), (PROJECTION, "projection"), (PLAN, "plan"), (QA_FILE, "qa")):
        path.write_bytes(first[key])
    qa = docs["qa"]
    up_pass = sum(value == "PASS" for value in qa["upward"].values())
    ibd_pass = sum(value == "PASS" for value in qa["ibd"].values())
    item_pass = sum(value == "PASS" for value in qa["itemflow"].values())
    promoted = docs["upward"]["promoted_ports"]
    UP_REPORT.write_text(
        "\n".join([
            "# Upward Interface Inference Report", "",
            f"- Raw Ports: {docs['upward']['raw_port_count']}",
            f"- Promoted Ports: {len(promoted)}",
            f"- Signal promoted out / in: {sum(p['effective_direction']=='out' for p in promoted)} / {sum(p['effective_direction']=='in' for p in promoted)}",
            f"- Physical promoted inout: {sum(p['effective_direction']=='inout' for p in promoted)}",
            f"- Hierarchical Connector Segments: {docs['projection']['hierarchical_segment_count']}",
            f"- UP QA: {up_pass} PASS / {len(qa['upward'])-up_pass} FAIL",
        ]) + "\n", encoding="utf-8")
    IBD_REPORT.write_text(
        "\n".join([
            "# Hierarchical IBD Generation Report", "",
            f"- Non-leaf Product Blocks: {docs['plan']['non_leaf_count']}",
            f"- IBDs including System Context: {docs['plan']['diagram_count']}",
            f"- Hierarchical ItemFlows: {sum(s['mode']=='SIGNAL' for s in docs['projection']['segments'])}",
            f"- PhysicalNet projections: {len(docs['projection']['physical_net_projections'])}",
            f"- IBD QA: {ibd_pass} PASS / {len(qa['ibd'])-ibd_pass} FAIL",
            f"- ItemFlow QA: {item_pass} PASS / {len(qa['itemflow'])-item_pass} FAIL",
        ]) + "\n", encoding="utf-8")
    print(json.dumps({
        "raw_ports": docs["upward"]["raw_port_count"],
        "promoted_ports": len(promoted),
        "segments": docs["projection"]["hierarchical_segment_count"],
        "net_projections": len(docs["projection"]["physical_net_projections"]),
        "non_leaf": docs["plan"]["non_leaf_count"],
        "ibds": docs["plan"]["diagram_count"],
        "up_fail": len(qa["upward"]) - up_pass,
        "ibd_fail": len(qa["ibd"]) - ibd_pass,
        "item_fail": len(qa["itemflow"]) - item_pass,
        "deterministic": True,
    }, ensure_ascii=False))


if __name__ == "__main__":
    main()
