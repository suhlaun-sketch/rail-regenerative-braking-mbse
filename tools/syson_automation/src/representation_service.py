from __future__ import annotations

import json
import uuid
from datetime import datetime, timezone
from pathlib import Path

from websockets.sync.client import connect

from .syson_client import SysONClient, SysONError

ROOT = Path(__file__).resolve().parents[3]
OPERATIONS = ROOT / "tools/syson_automation/generated/syson_operations"
REGISTRY = OPERATIONS / "registry.json"


class RepresentationService:
    def __init__(self, client: SysONClient, context_id: str):
        self.client, self.context_id, self.mutation_count = client, context_id, 0

    def mutation(self, name: str, query: str, variables: dict, representation_id: str | None = None) -> dict:
        self.client.require_mutation(name)
        record = {"operation_name": name, "timestamp": datetime.now(timezone.utc).isoformat(),
                  "variables": variables, "representation_id": representation_id, "response": None, "error": None}
        self.mutation_count += 1
        try:
            data = self.client.execute(query, variables)
            record["response"] = data
            return data
        except Exception as exc:
            record["error"] = str(exc)
            raise
        finally:
            OPERATIONS.mkdir(parents=True, exist_ok=True)
            filename = f"{datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%S%f')}_{name}.json"
            (OPERATIONS / filename).write_text(json.dumps(record, ensure_ascii=False, indent=2), encoding="utf-8")

    def representations(self) -> list[dict]:
        # The per-representation description resolver can hang even when the
        # lightweight metadata query is fast; description discovery is separate.
        q = "query($ctx:ID!){viewer{editingContext(editingContextId:$ctx){representations(first:200){edges{node{id label kind}}}}}}"
        d = self.client.execute(q, {"ctx": self.context_id})
        return [x["node"] for x in d["viewer"]["editingContext"]["representations"]["edges"]]

    def descriptions(self, object_id: str) -> list[dict]:
        q = "query($ctx:ID!,$obj:ID!){viewer{editingContext(editingContextId:$ctx){representationDescriptions(objectId:$obj){edges{node{id label defaultName documentation}}}}}}"
        d = self.client.execute(q, {"ctx": self.context_id, "obj": object_id})
        return [x["node"] for x in d["viewer"]["editingContext"]["representationDescriptions"]["edges"]]

    def diagram(self, representation_id: str, *, deep: bool = True) -> dict:
        def node_fields(depth: int) -> str:
            fields = "id targetObjectId type"
            if depth:
                child = node_fields(depth - 1)
                fields += f" childNodes{{{child}}} borderNodes{{{child}}}"
            return fields
        q = ("subscription Diagram($input:DiagramEventInput!){diagramEvent(input:$input){__typename "
             "... on DiagramRefreshedEventPayload{diagram{id targetObjectId nodes{" + node_fields(5 if deep else 0) + "} "
             "edges{id targetObjectId sourceId targetId}}} ... on ErrorPayload{message}}}")
        payload = {"query": q, "variables": {"input": {"id": str(uuid.uuid4()),
                   "editingContextId": self.context_id, "diagramId": representation_id}}}
        with connect("ws://localhost:8080/subscriptions", subprotocols=["graphql-ws"], open_timeout=30,
                     close_timeout=2, max_size=32 * 1024 * 1024, ping_interval=None) as ws:
            ws.send(json.dumps({"type": "connection_init", "payload": {}}))
            if json.loads(ws.recv(timeout=15)).get("type") != "connection_ack":
                raise SysONError("Diagram subscription handshake failed")
            ws.send(json.dumps({"id": "1", "type": "start", "payload": payload}))
            for _ in range(6):
                message = json.loads(ws.recv(timeout=300))
                if message.get("type") == "error":
                    raise SysONError(str(message.get("payload")))
                if message.get("type") == "data":
                    event = ((message.get("payload") or {}).get("data") or {}).get("diagramEvent") or {}
                    if event.get("__typename") != "DiagramRefreshedEventPayload":
                        errors = (message.get("payload") or {}).get("errors") or []
                        raise SysONError(event.get("message") or str(errors[:2]) or f"Diagram event: {event.get('__typename')}")
                    diagram = event["diagram"]
                    diagram["top_level_node_count"] = len(diagram["nodes"])
                    flat = []
                    def flatten(nodes: list[dict]) -> None:
                        for node in nodes:
                            flat.append(node)
                            flatten(node.get("childNodes") or [])
                            flatten(node.get("borderNodes") or [])
                    flatten(diagram["nodes"])
                    diagram["nodes"] = flat
                    return diagram
        raise SysONError("Diagram query-back produced no data")

    def create_or_reuse(self, *, stable_key: str, root_object_id: str, description_id: str, name: str) -> dict:
        if not name.startswith("AUTO_"):
            raise ValueError("Automation representations must use AUTO_ prefix")
        existing = [x for x in self.representations() if x["label"] == name]
        if len(existing) > 1:
            raise SysONError(f"Ambiguous representation name: {name}")
        if existing:
            rep = existing[0]
            registry = json.loads(REGISTRY.read_text(encoding="utf-8")) if REGISTRY.is_file() else {}
            owned = registry.get(stable_key, {}).get("id") == rep["id"]
            if not owned:
                # A timed-out create mutation can still commit. Its local audit
                # record proves this exact AUTO_ name was initiated by us.
                owned = any(json.loads(p.read_text(encoding="utf-8")).get("variables", {}).get("input", {}).get("representationName") == name
                            for p in OPERATIONS.glob("*_createRepresentation.json")) if OPERATIONS.is_dir() else False
                if owned:
                    registry[stable_key] = {"id": rep["id"], "name": name, "created_by": "syson_automation",
                                            "root_object_id": root_object_id, "description_id": description_id}
                    REGISTRY.write_text(json.dumps(registry, ensure_ascii=False, indent=2), encoding="utf-8")
            return {"id": rep["id"], "name": name, "kind": rep["kind"], "reused": True, "owned": owned}
        variables = {"input": {"id": str(uuid.uuid4()), "editingContextId": self.context_id,
                     "objectId": root_object_id, "representationDescriptionId": description_id,
                     "representationName": name}}
        q = ("mutation($input:CreateRepresentationInput!){createRepresentation(input:$input){__typename "
             "... on CreateRepresentationSuccessPayload{representation{id label kind}} "
             "... on ErrorPayload{message}}}")
        payload = self.mutation("createRepresentation", q, variables)["createRepresentation"]
        if payload["__typename"] != "CreateRepresentationSuccessPayload":
            raise SysONError(payload.get("message", "createRepresentation failed"))
        rep = payload["representation"]
        if not any(x["id"] == rep["id"] and x["label"] == name for x in self.representations()):
            raise SysONError("Representation missing from live query-back")
        registry = json.loads(REGISTRY.read_text(encoding="utf-8")) if REGISTRY.is_file() else {}
        registry[stable_key] = {"id": rep["id"], "name": name, "created_by": "syson_automation",
                                "root_object_id": root_object_id, "description_id": description_id}
        REGISTRY.write_text(json.dumps(registry, ensure_ascii=False, indent=2), encoding="utf-8")
        return {"id": rep["id"], "name": name, "kind": rep["kind"], "reused": False, "owned": True}

    def populate_and_verify(self, representation_id: str, object_ids: list[str], arrange: bool = True) -> dict:
        registry = json.loads(REGISTRY.read_text(encoding="utf-8")) if REGISTRY.is_file() else {}
        if not any(x.get("id") == representation_id and x.get("created_by") == "syson_automation" for x in registry.values()):
            raise SysONError("Representation is not registered as syson_automation-owned")
        before = self.diagram(representation_id)
        present = {x["targetObjectId"] for x in before["nodes"]}
        missing = [x for x in dict.fromkeys(object_ids) if x not in present]
        if missing:
            placed = before.get("top_level_node_count", len(before["nodes"]))
            variables = {"input": {"id": str(uuid.uuid4()), "editingContextId": self.context_id,
                         "representationId": representation_id, "diagramTargetElementId": representation_id,
                         "objectIds": missing, "startingPositionX": 80.0 + (placed % 8) * 300.0,
                         "startingPositionY": 80.0 + (placed // 8) * 220.0}}
            q = ("mutation($input:DropOnDiagramInput!){dropOnDiagram(input:$input){__typename "
                 "... on DropOnDiagramSuccessPayload{diagram{id}} ... on ErrorPayload{message}}}")
            payload = self.mutation("dropOnDiagram", q, variables, representation_id)["dropOnDiagram"]
            if payload["__typename"] != "DropOnDiagramSuccessPayload":
                raise SysONError(payload.get("message", "dropOnDiagram failed"))
        after = self.diagram(representation_id)
        rendered = {x["targetObjectId"] for x in after["nodes"]}
        absent = sorted(set(object_ids) - rendered)
        if absent:
            return {"status": "POPULATE_FAILED", "verified_object_ids": sorted(rendered & set(object_ids)),
                    "missing_object_ids": absent, "node_count": len(after["nodes"]), "edge_count": len(after["edges"]), "layout": "NOT_ATTEMPTED"}
        layout = "NOT_ATTEMPTED"
        if arrange and missing:
            variables = {"input": {"id": str(uuid.uuid4()), "editingContextId": self.context_id,
                         "representationId": representation_id}}
            q = "mutation($input:ArrangeAllInput!){arrangeAll(input:$input){__typename ... on ErrorPayload{message}}}"
            try:
                payload = self.mutation("arrangeAll", q, variables, representation_id)["arrangeAll"]
                layout = "PASS" if payload["__typename"] == "SuccessPayload" else "FAILED"
            except Exception:
                layout = "FAILED"
        final = self.diagram(representation_id)
        final_ids = {x["targetObjectId"] for x in final["nodes"]}
        return {"status": "CREATED" if set(object_ids) <= final_ids else "VERIFY_FAILED",
                "verified_object_ids": sorted(final_ids & set(object_ids)),
                "missing_object_ids": sorted(set(object_ids) - final_ids),
                "node_count": len(final["nodes"]), "edge_count": len(final["edges"]), "layout": layout}
