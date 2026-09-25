"""Promote the verified 46-requirement candidate to its formal AUTO_REQ_ALL name."""
from __future__ import annotations
import json,uuid
from pathlib import Path
from tools.syson_automation.src.syson_client import SysONClient
from tools.syson_automation.src.representation_service import REGISTRY,RepresentationService

root=Path(__file__).resolve().parents[3]
state=json.loads((root/'tools/syson_automation/cache/full_final_project.json').read_text(encoding='utf-8'))
report=root/'work/reports/FULL_SYSON_VIEW_REGISTRY.json'
views=json.loads(report.read_text(encoding='utf-8'))
source='AUTO_REQ_ALL_CANDIDATE'; target='AUTO_REQ_ALL'
if views.get(source,{}).get('status')!='PASS' or len(views[source]['requested_object_ids'])!=46:
    raise RuntimeError('Candidate has not passed complete query-back')
registry=json.loads(REGISTRY.read_text(encoding='utf-8'))
src_key=state['project_id']+':'+source; tgt_key=state['project_id']+':'+target
candidate=registry[src_key]
client=SysONClient(timeout=90); svc=RepresentationService(client,state['editing_context_id'])
existing=[x for x in svc.representations() if x['label']==target]
if len(existing)>1: raise RuntimeError('Ambiguous target name')
if existing:
    old=registry.get(tgt_key)
    if not old or old['id']!=existing[0]['id'] or old['created_by']!='syson_automation':
        raise RuntimeError('Target is not an owned failed view')
    q='mutation($input:DeleteRepresentationInput!){deleteRepresentation(input:$input){__typename}}'
    result=client.execute(q,{'input':{'id':str(uuid.uuid4()),'editingContextId':state['editing_context_id'],
                                     'representationId':old['id']}})['deleteRepresentation']
    if 'Success' not in result['__typename']: raise RuntimeError(str(result))
    registry.pop(tgt_key)
q='mutation($input:RenameRepresentationInput!){renameRepresentation(input:$input){__typename}}'
result=client.execute(q,{'input':{'id':str(uuid.uuid4()),'editingContextId':state['editing_context_id'],
                                 'representationId':candidate['id'],'newLabel':target}})['renameRepresentation']
if 'Success' not in result['__typename']: raise RuntimeError(str(result))
actual=[x for x in svc.representations() if x['label']==target]
if len(actual)!=1 or actual[0]['id']!=candidate['id']: raise RuntimeError('Rename query-back mismatch')
entry=registry.pop(src_key); entry['name']=target; registry[tgt_key]=entry
REGISTRY.write_text(json.dumps(registry,ensure_ascii=False,indent=2),encoding='utf-8')
view=views.pop(source); views[target]=view
report.write_text(json.dumps(views,ensure_ascii=False,indent=2),encoding='utf-8')
print('AUTO_REQ_ALL=PASS REQUIREMENTS=46 ID='+candidate['id'])
