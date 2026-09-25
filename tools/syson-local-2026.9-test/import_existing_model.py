"""Import the two unchanged final SysML files into the isolated SysON 2026.9 test."""
from __future__ import annotations

import json
import uuid
from pathlib import Path

from tools.syson_automation.scripts.create_full_final_project import _document
from tools.syson_automation.src.explorer_client import ExplorerClient, flatten_tree
from tools.syson_automation.src.syson_client import SysONClient

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent
MODEL = ROOT / "work/sysmlv2/full_engineering_model/03_full_boundary/Rail_MBSE_Full_v3_FullBoundary.sysml"
REQUIREMENTS = ROOT / "work/sysmlv2/requirements_traceability_v2/06_RequirementTraceability_AllInOne_v2.sysml"
STATE = HERE / "test_project.json"
NAME = "TEST_2026_9_Rail_MBSE_FullBoundary"


def main() -> None:
    client = SysONClient(endpoint="http://127.0.0.1:8090/api/graphql", timeout=1200)
    query = "query{viewer{allProjectTemplates{id label} projects(first:100){edges{node{id name currentEditingContext{id}}}}}}"
    viewer = client.execute(query)["viewer"]
    projects = [edge["node"] for edge in viewer["projects"]["edges"] if edge["node"]["name"] == NAME]
    if len(projects) > 1:
        raise RuntimeError("Ambiguous test project")
    if projects:
        project = projects[0]
    else:
        template = next(item["id"] for item in viewer["allProjectTemplates"] if item["label"] == "SysMLv2")
        mutation = ("mutation($input:CreateProjectInput!){createProject(input:$input){__typename "
                    "... on CreateProjectSuccessPayload{project{id name currentEditingContext{id}}} "
                    "... on ErrorPayload{message}}}")
        payload = client.execute(mutation, {"input": {"id": str(uuid.uuid4()), "name": NAME,
                                               "templateId": template, "libraryIds": []}})["createProject"]
        if payload["__typename"] != "CreateProjectSuccessPayload":
            raise RuntimeError(f"createProject: {payload}")
        project = payload["project"]
    context = project["currentEditingContext"]["id"]
    description_query = "query($id:ID!){viewer{editingContext(editingContextId:$id){explorerDescriptions{id label}}}}"
    descriptions = client.execute(description_query, {"id": context})["viewer"]["editingContext"]["explorerDescriptions"]
    explorer_description = next(item["id"] for item in descriptions if item["label"] == "SysON Explorer")
    explorer = ExplorerClient(context, explorer_description, endpoint="ws://127.0.0.1:8090/subscriptions", timeout=120)

    def document(path: Path) -> str:
        roots = flatten_tree(explorer.tree([]))
        existing = [row for row in roots if row["label"] == path.name]
        if len(existing) > 1:
            raise RuntimeError(f"Duplicate test document: {path.name}")
        if existing:
            return existing[0]["id"]
        return _document(client, explorer, context, path)

    state = {"project_name": NAME, "project_id": project["id"], "editing_context_id": context,
             "model_document_id": None, "requirements_document_id": None,
             "model_path": str(MODEL), "requirements_path": str(REQUIREMENTS),
             "explorer_description_id": explorer_description}
    STATE.write_text(json.dumps(state, ensure_ascii=False, indent=2), encoding="utf-8")
    state["model_document_id"] = document(MODEL)
    STATE.write_text(json.dumps(state, ensure_ascii=False, indent=2), encoding="utf-8")
    print("MODEL_IMPORT=PASS", flush=True)
    state["requirements_document_id"] = document(REQUIREMENTS)
    STATE.write_text(json.dumps(state, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"REQUIREMENTS_IMPORT=PASS PROJECT_ID={project['id']}", flush=True)


if __name__ == "__main__":
    main()
