from __future__ import annotations
import json,sys,uuid
from pathlib import Path
from tools.syson_automation.src.syson_client import SysONClient
from tools.syson_automation.src.representation_service import REGISTRY,RepresentationService
root=Path(__file__).resolve().parents[3]
state=json.loads((root/'tools/syson_automation/cache/full_final_project.json').read_text(encoding='utf-8'))
name=sys.argv[1]
registry=json.loads(REGISTRY.read_text(encoding='utf-8'))
rep=registry[state['project_id']+':'+name]
if rep['created_by']!='syson_automation': raise RuntimeError('Unowned view')
svc=RepresentationService(SysONClient(timeout=120),state['editing_context_id'])
q='mutation($input:ArrangeAllInput!){arrangeAll(input:$input){__typename}}'
r=svc.mutation('arrangeAll',q,{'input':{'id':str(uuid.uuid4()),'editingContextId':state['editing_context_id'],'representationId':rep['id']}},rep['id'])['arrangeAll']
print(name,r['__typename'])
