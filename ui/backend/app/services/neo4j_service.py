from __future__ import annotations

import logging
from typing import Any

from neo4j import GraphDatabase

from ..config import settings

log = logging.getLogger("rail_mbse.neo4j")

class Neo4jService:
    def __init__(self): self.driver = None; self.error = "未配置"; self.connected = False

    def connect(self):
        password = settings.neo4j_password.get_secret_value() if settings.neo4j_password else ""
        if not password:
            log.warning("NEO4J = UNAVAILABLE"); return
        try:
            self.driver = GraphDatabase.driver(settings.neo4j_uri, auth=(settings.neo4j_user, password))
            self.driver.verify_connectivity()
            with self.driver.session(database=settings.neo4j_db) as session: session.run("RETURN 1 AS ok").single(strict=True)
            self.connected = True; self.error = ""; log.info("NEO4J = CONNECTED")
        except Exception:
            self.connected = False; self.error = "连接失败"; log.warning("NEO4J = UNAVAILABLE")

    def close(self):
        if self.driver: self.driver.close()

    def _records(self, query: str, **params) -> list[dict]:
        if not self.connected or not self.driver: return []
        forbidden = ("CREATE", "MERGE", "DELETE", "DETACH", " SET ", "REMOVE", "DROP")
        upper = f" {query.upper()} "
        if any(x in upper for x in forbidden): raise ValueError("Read-only Neo4j service rejected a write query")
        with self.driver.session(database=settings.neo4j_db, default_access_mode="READ") as session:
            return [dict(x) for x in session.run(query, **params)]

    @staticmethod
    def _node(record: dict) -> dict:
        props = record.get("properties", {}) or {}; labels = record.get("labels", []) or []
        display = next((props.get(k) for k in ("chineseName", "chinese_name", "中文名称", "name", "displayName", "symbol") if props.get(k)), record.get("id"))
        return {"id": record.get("id"), "display_name": display, "labels": labels, "properties": props}

    def status(self) -> dict:
        return {"status": "CONNECTED" if self.connected else "UNAVAILABLE", "configured": bool(settings.neo4j_password), "database": settings.neo4j_db, "readOnly": True}

    def summary(self) -> dict:
        if not self.connected: return {**self.status(), "nodeCount": 0, "relationshipCount": 0}
        row = self._records("MATCH (n) WITH count(n) AS nodes MATCH ()-[r]->() RETURN nodes, count(r) AS relationships")[0]
        return {**self.status(), "nodeCount": row["nodes"], "relationshipCount": row["relationships"]}

    def search(self, q: str) -> list[dict]:
        rows = self._records("MATCH (n) WHERE any(k IN ['name','chineseName','chinese_name','code','componentId','component_id','alias'] WHERE n[k] IS NOT NULL AND toLower(toString(n[k])) CONTAINS toLower($q)) RETURN elementId(n) AS id, labels(n) AS labels, properties(n) AS properties LIMIT 25", q=q.strip())
        return [self._node(x) for x in rows]

    def node(self, node_id: str) -> dict | None:
        rows = self._records("MATCH (n) WHERE elementId(n)=$id RETURN elementId(n) AS id, labels(n) AS labels, properties(n) AS properties LIMIT 1", id=node_id)
        return self._node(rows[0]) if rows else None

    def neighbors(self, node_id: str) -> dict:
        rows = self._records("MATCH (n)-[r]-(m) WHERE elementId(n)=$id RETURN elementId(m) AS id, labels(m) AS labels, properties(m) AS properties, type(r) AS relationship LIMIT 100", id=node_id)
        return {"center": node_id, "neighbors": [{**self._node(x), "relationship": x["relationship"]} for x in rows]}

    def path(self, source: str, target: str) -> list[dict]:
        return self._records("MATCH (a),(b) WHERE elementId(a)=$source AND elementId(b)=$target MATCH p=shortestPath((a)-[*..8]-(b)) RETURN [n IN nodes(p) | {id:elementId(n), labels:labels(n), properties:properties(n)}] AS nodes, [r IN relationships(p) | type(r)] AS relationships LIMIT 1", source=source, target=target)

    def resolve_l2(self, component: dict) -> dict:
        if not self.connected: return {"matched": False, "reason": "知识图谱未连接"}
        candidates = [("explicit_component_id", 1.0, [component.get("id")]), ("code", .95, [component.get("code")]),
                      ("sysml_name", .9, [component.get("raw_name")]), ("chinese_name", .9, [component.get("display_name")])]
        for match_type, confidence, values in candidates:
            values = [x for x in values if x]
            if not values: continue
            rows = self._records("MATCH (n) WHERE any(k IN ['componentId','component_id','id','code','name','chineseName','chinese_name','alias'] WHERE n[k] IS NOT NULL AND toString(n[k]) IN $values) RETURN elementId(n) AS id, labels(n) AS labels, properties(n) AS properties LIMIT 2", values=values)
            if len(rows) == 1: return {"matched": True, "match_type": match_type, "confidence": confidence, "neo4j_node_id": rows[0]["id"], "node": self._node(rows[0])}
        return {"matched": False, "reason": "未匹配知识实体"}

kg = Neo4jService()
