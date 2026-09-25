"""Remove this run's exploratory views and their orphan semantic ViewUsages."""
from __future__ import annotations
import json,uuid
from pathlib import Path
from urllib.parse import quote
import psycopg2
from tools.syson_automation.src.syson_client import SysONClient
from tools.syson_automation.src.representation_service import REGISTRY,RepresentationService

ROOT=Path(__file__).resolve().parents[3]
state=json.loads((ROOT/'tools/syson_automation/cache/full_final_project.json').read_text(encoding='utf-8'))
index=json.loads((ROOT/'tools/syson_automation/cache/full_final_element_index.json').read_text(encoding='utf-8'))
registry=json.loads(REGISTRY.read_text(encoding='utf-8'))
probes=[x for x in index['entries'] if x['sysml_type']=='ViewUsage' and x['label'].startswith('AUTO_FULL_PROBE_')]
db=psycopg2.connect(host='127.0.0.1',dbname='postgres',user='syson');db.set_session(readonly=True)
cur=db.cursor();cur.execute('select content from document where id=%s',(state['requirements_document_id'],))
document=json.loads(cur.fetchone()[0])
ids={x['syson_object_id'] for x in probes}; paths={}
def walk(value,ancestors):
 if isinstance(value,list):
  for child in value:walk(child,ancestors)
 elif isinstance(value,dict):
  if 'eClass' in value and 'id' in value:
   oid=value['id']
   if oid in ids:paths[oid]=[state['requirements_document_id']]+ancestors
   ancestors=ancestors+[oid]
  for child in value.values():
   if isinstance(child,(list,dict)):walk(child,ancestors)
walk(document,[])
if set(paths)!=ids:raise RuntimeError('Probe ViewUsage ancestry incomplete')
client=SysONClient(timeout=60);svc=RepresentationService(client,state['editing_context_id'])
live={x['label']:x['id'] for x in svc.representations()}
for entry in probes:
 name,oid=entry['label'],entry['syson_object_id']
 matches=[(key,value) for key,value in registry.items() if value.get('name')==name and value.get('id')==live.get(name)]
 if len(matches)!=1:
  raise RuntimeError(f'Probe is not uniquely registered: {name}')
 key,owned=matches[0]
 if owned['created_by']!='syson_automation':
  raise RuntimeError(f'Probe is not owned: {name}')
 cur.execute('select content from representation_content where representation_metadata_id=%s',(owned['id'],))
 content=cur.fetchone()[0]
 if oid not in content:raise RuntimeError(f'Probe ViewUsage not linked to representation: {name}')
 q='mutation($input:DeleteRepresentationInput!){deleteRepresentation(input:$input){__typename}}'
 result=client.execute(q,{'input':{'id':str(uuid.uuid4()),'editingContextId':state['editing_context_id'],
     'representationId':owned['id']}})['deleteRepresentation']
 if 'Success' not in result['__typename']:raise RuntimeError(f'Delete representation failed: {name}')
 desc=state['explorer_description_id']
 explorer='explorer://?treeDescriptionId='+quote(desc,safe='')+'&expandedIds=['+','.join(quote(x,safe='') for x in paths[oid])+']&activeFilterIds=[]'
 q='mutation($input:DeleteTreeItemInput!){deleteTreeItem(input:$input){__typename ... on ErrorPayload{message}}}'
 result=client.execute(q,{'input':{'id':str(uuid.uuid4()),'editingContextId':state['editing_context_id'],
     'representationId':explorer,'treeItemId':oid}})['deleteTreeItem']
 if 'Success' not in result['__typename']:raise RuntimeError(f'Delete ViewUsage failed: {name}: {result}')
 registry.pop(key)
 REGISTRY.write_text(json.dumps(registry,ensure_ascii=False,indent=2),encoding='utf-8')
 print('REMOVED_PROBE',name,flush=True)
