from __future__ import annotations

import json
import uuid
from urllib.parse import quote

from websockets.sync.client import connect


def _fields(depth: int) -> str:
    base = "id kind hasChildren label { styledStringFragments { text } }"
    return base + (" children { " + _fields(depth - 1) + " }" if depth else "")


class ExplorerClient:
    """Read the same SysON explorerEvent tree subscription as the local UI."""

    def __init__(self, editing_context_id: str, description_id: str, endpoint: str = "ws://localhost:8080/subscriptions", timeout: int = 20):
        self.editing_context_id = editing_context_id
        self.description_id = description_id
        self.endpoint = endpoint
        self.timeout = timeout
        self.query = ("subscription Explorer($input:ExplorerEventInput!){explorerEvent(input:$input)"
                      "{__typename ... on TreeRefreshedEventPayload{tree{id children{" + _fields(7) + "}}}}}")

    def tree(self, expanded_ids: list[str] | None = None) -> dict:
        expanded_ids = expanded_ids or []
        rep = ("explorer://?treeDescriptionId=" + quote(self.description_id, safe="")
               + "&expandedIds=[" + ",".join(quote(x, safe="") for x in expanded_ids) + "]&activeFilterIds=[]")
        payload = {"query": self.query, "variables": {"input": {"id": str(uuid.uuid4()),
                   "editingContextId": self.editing_context_id, "representationId": rep}}}
        with connect(self.endpoint, subprotocols=["graphql-ws"], open_timeout=self.timeout, close_timeout=2) as ws:
            ws.send(json.dumps({"type": "connection_init", "payload": {}}))
            ack = json.loads(ws.recv(timeout=self.timeout))
            if ack.get("type") != "connection_ack":
                raise RuntimeError(f"Explorer subscription handshake: {ack.get('type')}")
            ws.send(json.dumps({"id": "1", "type": "start", "payload": payload}))
            for _ in range(5):
                message = json.loads(ws.recv(timeout=self.timeout))
                if message.get("type") == "error":
                    raise RuntimeError(str(message.get("payload")))
                if message.get("type") == "data":
                    event = ((message.get("payload") or {}).get("data") or {}).get("explorerEvent") or {}
                    if event.get("__typename") != "TreeRefreshedEventPayload":
                        raise RuntimeError(f"Explorer returned {event.get('__typename')}")
                    return event["tree"]
            raise TimeoutError("Explorer subscription did not return tree data")


def flatten_tree(tree: dict) -> list[dict]:
    rows: list[dict] = []

    def visit(item: dict, parent_id: str | None, path: list[str]):
        label = "".join(fragment.get("text", "") for fragment in item.get("label", {}).get("styledStringFragments", []))
        row = {"id": item["id"], "label": label, "kind": item.get("kind", ""),
               "has_children": bool(item.get("hasChildren")), "parent_object_id": parent_id,
               "qualified_name": "::".join(path + [label])}
        rows.append(row)
        for child in item.get("children") or []:
            visit(child, item["id"], path + [label])

    for root in tree.get("children") or []:
        visit(root, None, [])
    return rows
