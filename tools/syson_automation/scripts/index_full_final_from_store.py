"""Build a complete read-only SysON persisted-object index and spot-check API IDs."""
from __future__ import annotations

import json
from collections import Counter, defaultdict
from pathlib import Path

import psycopg2

from tools.syson_automation.src.syson_client import SysONClient

ROOT = Path(__file__).resolve().parents[3]
STATE = ROOT / "tools/syson_automation/cache/full_final_project.json"
OUT = ROOT / "tools/syson_automation/cache/full_final_element_index.json"
TRACE = ROOT / "work/sysmlv2/full_engineering_model/03_full_boundary/FULL_PORT_TRACEABILITY.json"


def main() -> None:
    state = json.loads(STATE.read_text(encoding="utf-8"))
    trace = json.loads(TRACE.read_text(encoding="utf-8"))
    port_props = {p["port_id"]: p for p in trace["port_usages"]}
    conn_props = {p["connection_id"]: p for p in trace["connection_usages"]}
    conn = psycopg2.connect(host="127.0.0.1", dbname="postgres", user="syson")
    conn.set_session(readonly=True)
    cur = conn.cursor()
    cur.execute("select id,name,content from document where id in (%s,%s)",
                (state["model_document_id"], state["requirements_document_id"]))
    docs = cur.fetchall()
    if len(docs) != 2:
        raise RuntimeError(f"Expected two imported SysON documents, got {len(docs)}")
    entries: list[dict] = []
    by_name: dict[str, list[str]] = defaultdict(list)

    def walk(value, document: str, ancestors: list[str]):
        if isinstance(value, list):
            for item in value:
                walk(item, document, ancestors)
            return
        if not isinstance(value, dict):
            return
        if "eClass" in value and "id" in value:
            data = value.get("data") or {}
            label = data.get("declaredName") or data.get("name")
            kind = str(value["eClass"]).split(":")[-1]
            synthetic = False
            if not label and kind == "SatisfyRequirementUsage":
                label = "satisfy_" + value["id"]
                synthetic = True
            if label and isinstance(label, str):
                oid = value["id"]
                props = port_props.get(label) or conn_props.get(label) or ({"synthetic_index_key": True} if synthetic else {})
                entry = {"semantic_id": label, "label": label, "sysml_type": kind,
                         "syson_object_id": oid, "qualified_name": "::".join(ancestors + [label]),
                         "parent_object_id": None, "source_model": document, "properties": props}
                entries.append(entry)
                by_name[label].append(oid)
                ancestors = ancestors + [label]
            for key, child in data.items():
                if isinstance(child, (dict, list)):
                    walk(child, document, ancestors)
        else:
            for child in value.values():
                if isinstance(child, (dict, list)):
                    walk(child, document, ancestors)

    for doc_id, name, content in docs:
        walk(json.loads(content), name, [])
    api = SysONClient(timeout=40)
    for label in ("P_X100", "FN_F_X100_01", "req_REQ_BRK_007"):
        hits = [x["id"] for x in api.search(state["editing_context_id"], label) if x["label"] == label]
        if len(hits) != 1 or hits[0] not in by_name[label]:
            raise RuntimeError(f"Persisted object/API mismatch for {label}")
    output = {"project_id": state["project_id"], "editing_context_id": state["editing_context_id"],
              "model_fingerprint": state["model_fingerprint"], "source": "SysON PostgreSQL document read-only + GraphQL spot-check",
              "entries": entries, "by_semantic_id": dict(by_name),
              "type_counts": dict(Counter(e["sysml_type"] for e in entries))}
    OUT.write_text(json.dumps(output, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"PERSISTED_INDEX=PASS ENTRIES={len(entries)} PORTS={output['type_counts'].get('PortUsage',0)} CONNECTIONS={output['type_counts'].get('ConnectionUsage',0)}")


if __name__ == "__main__":
    main()
