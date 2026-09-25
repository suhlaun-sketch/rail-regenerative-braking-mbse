# Natural-language Engineering Scope → SysON Views

This implementation reuses the existing local semantic query, frozen SysML allocation parser, V2 requirement mappings, ModelGraph product hierarchy, and real interface/flow catalogs. It creates a persisted `EngineeringScopeManifest` with real seed products, fixed-point interface-induced closure, provenance-preserving canonical products, and at most one IBD per present hierarchy level. Flow-pair count never determines View count.

## Run

From the project root in PowerShell:

```powershell
python tools/syson_automation/scripts/discover_syson.py
python -m unittest discover -s tools/syson_automation/tests -v
Push-Location ui/frontend; npm run build; Pop-Location
python tools/syson_automation/scripts/write_hierarchical_ibd_report.py
Push-Location ui/backend
python -m uvicorn app.main:app --host 127.0.0.1 --port 8000
Pop-Location
```

The frontend task-slice page contains a natural-language scope panel. The same API can be used directly:

```powershell
$scope = Invoke-RestMethod -Method Post http://127.0.0.1:8000/api/syson/scope `
  -ContentType 'application/json' -Body '{"query":"分析再生制动时超级电容储能相关的需求、功能和接口"}'
Invoke-RestMethod -Method Post http://127.0.0.1:8000/api/syson/views/plan `
  -ContentType 'application/json' -Body (@{scope_id=$scope.scope_id} | ConvertTo-Json)
Invoke-RestMethod -Method Post http://127.0.0.1:8000/api/syson/views/generate `
  -ContentType 'application/json' -Body (@{scope_id=$scope.scope_id} | ConvertTo-Json)
```

Generated scope manifests are stored under `generated/scopes/`, and fixed-point closure evidence under `generated/closures/`. The level-projected views retain raw Flow, Interface, and Connector references. `generate` will only mutate SysON after live model element IDs and representation metadata resolve uniquely. Current SysON element search times out; the API accurately returns `BLOCKED` and does not call any mutation. Do not treat a `PLANNED` response as a created diagram.

## Important local records

- `schemas/engineering_scope.schema.json`: manifest schema.
- `cache/graphql_schema.json`: live SysON GraphQL introspection; refreshed by the discovery script.
- `cache/current_project.json`: live project/context/representation snapshot.
- `generated/reports/SYSON_GRAPHQL_DISCOVERY.md`: live schema/query capability report.
- `../../work/reports/SYSON_DYNAMIC_VIEW_GENERATION_REPORT.md`: implementation and acceptance record.
- `../../work/reports/HIERARCHICAL_IBD_CLOSURE_REPORT.md`: query-specific closure and hierarchy projection report.
