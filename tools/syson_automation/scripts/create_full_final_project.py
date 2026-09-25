"""Create/import the isolated final full SysON project after Pilot PASS."""
from __future__ import annotations

import hashlib
import json
import uuid
from pathlib import Path

from tools.syson_automation.src.explorer_client import ExplorerClient, flatten_tree
from tools.syson_automation.src.syson_client import SysONClient

ROOT = Path(__file__).resolve().parents[3]
MODEL = ROOT / "work/sysmlv2/full_engineering_model/03_full_boundary/Rail_MBSE_Full_v3_FullBoundary.sysml"
VALIDATION = MODEL.parent / "Official_Validation.json"
REQUIREMENTS = ROOT / "work/sysmlv2/requirements_traceability_v2/06_RequirementTraceability_AllInOne_v2.sysml"
STATE = ROOT / "tools/syson_automation/cache/full_final_project.json"
NAME = "Rail_Regenerative_Braking_MBSE_FULL"


def _namespace(explorer: ExplorerClient, doc_id: str) -> str:
    rows = flatten_tree(explorer.tree([doc_id]))
    return next(x["id"] for x in rows if x["parent_object_id"] == doc_id and x["label"] == "Namespace")


def _insert(c: SysONClient, context: str, object_id: str, text: str) -> None:
    q = ("mutation($input:InsertTextualSysMLv2Input!){insertTextualSysMLv2(input:$input){__typename "
         "... on ErrorPayload{messages{body level}} ... on SuccessPayload{messages{body level}}}}")
    result = c.execute(q, {"input": {"id": str(uuid.uuid4()), "editingContextId": context,
                                       "objectId": object_id, "textualContent": text}})["insertTextualSysMLv2"]
    if result["__typename"] != "SuccessPayload":
        raise RuntimeError(f"SysON textual import failed: {result.get('messages', [])[:3]}")


def _document(c: SysONClient, explorer: ExplorerClient, context: str, path: Path) -> str:
    q = ("mutation($input:CreateDocumentInput!){createDocument(input:$input){__typename "
         "... on CreateDocumentSuccessPayload{document{id name}} ... on ErrorPayload{message}}}")
    result = c.execute(q, {"input": {"id": str(uuid.uuid4()), "editingContextId": context,
                                       "stereotypeId": "empty_sysmlv2", "name": path.name}})["createDocument"]
    if result["__typename"] != "CreateDocumentSuccessPayload":
        raise RuntimeError(f"SysON document creation failed: {result}")
    document_id = result["document"]["id"]
    _insert(c, context, _namespace(explorer, document_id), path.read_text(encoding="utf-8"))
    return document_id


def main() -> None:
    validation = json.loads(VALIDATION.read_text(encoding="utf-8"))
    if any(validation.get(k) for k in ("syntax_error_count", "semantic_error_count", "exception")):
        raise RuntimeError("Pilot did not pass; final import forbidden")
    fingerprint = hashlib.sha256(MODEL.read_bytes() + REQUIREMENTS.read_bytes()).hexdigest()
    c = SysONClient(timeout=1200)
    live = c.execute("query{viewer{allProjectTemplates{id label} projects(first:100){edges{node{id name currentEditingContext{id}}}}}}")
    projects = [x["node"] for x in live["viewer"]["projects"]["edges"] if x["node"]["name"] == NAME]
    if len(projects) > 1:
        raise RuntimeError("Final project name is ambiguous")
    if projects:
        project = projects[0]
        if STATE.is_file():
            saved = json.loads(STATE.read_text(encoding="utf-8"))
            if saved["project_id"] != project["id"] or saved["model_fingerprint"] != fingerprint:
                raise RuntimeError("Existing final project fingerprint mismatch")
        elif project["id"] != "e44ac856-b4b0-4fb8-a94a-0ce1a6d722b8":
            raise RuntimeError("Unregistered project cannot be adopted")
    else:
        template = next(x["id"] for x in live["viewer"]["allProjectTemplates"] if x["label"] == "SysMLv2")
        q = ("mutation($input:CreateProjectInput!){createProject(input:$input){__typename "
             "... on CreateProjectSuccessPayload{project{id name currentEditingContext{id}}} "
             "... on ErrorPayload{message}}}")
        result = c.execute(q, {"input": {"id": str(uuid.uuid4()), "name": NAME,
                                           "templateId": template, "libraryIds": []}})["createProject"]
        if result["__typename"] != "CreateProjectSuccessPayload":
            raise RuntimeError(f"Final project creation failed: {result}")
        project = result["project"]
    context = project["currentEditingContext"]["id"]
    descs = c.execute("query($id:ID!){viewer{editingContext(editingContextId:$id){explorerDescriptions{id label}}}}",
                      {"id": context})["viewer"]["editingContext"]["explorerDescriptions"]
    description = next(x["id"] for x in descs if x["label"] == "SysON Explorer")
    explorer = ExplorerClient(context, description, timeout=60)
    roots = flatten_tree(explorer.tree([]))
    def existing_or_import(path: Path, check_label: str, check_kind: str) -> str:
        existing = [x for x in roots if x["label"] == path.name]
        if len(existing) > 1:
            raise RuntimeError(f"Duplicate document {path.name}")
        if existing:
            matches = [x for x in c.search(context, check_label)
                       if x["label"] == check_label and x["kind"].endswith("entity=" + check_kind)]
            if len(matches) != 1:
                raise RuntimeError(f"Existing document {path.name} lacks unique {check_label}")
            return existing[0]["id"]
        return _document(c, explorer, context, path)
    model_doc = existing_or_import(MODEL, "P_X100", "PartDefinition")
    req_doc = existing_or_import(REQUIREMENTS, "req_REQ_BRK_007", "RequirementUsage")
    for label, kind in (("P_X100", "PartDefinition"), ("FN_F_X100_01", "ActionDefinition"),
                        ("req_REQ_BRK_007", "RequirementUsage")):
        matches = [x for x in c.search(context, label) if x["label"] == label and x["kind"].endswith("entity=" + kind)]
        if len(matches) != 1:
            raise RuntimeError(f"Imported semantic element {label} query-back count {len(matches)}")
    state = {"project_name": NAME, "project_id": project["id"], "editing_context_id": context,
             "model_document_id": model_doc, "requirements_document_id": req_doc,
             "model_fingerprint": fingerprint, "model_path": str(MODEL), "requirements_path": str(REQUIREMENTS),
             "explorer_description_id": description, "created_by": "syson_automation",
             "generation": "FULL_FINAL"}
    STATE.parent.mkdir(parents=True, exist_ok=True)
    STATE.write_text(json.dumps(state, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"FINAL_PROJECT=CREATED ID={project['id']} CONTEXT={context} MODEL_DOC={model_doc} REQ_DOC={req_doc}")


if __name__ == "__main__":
    main()
