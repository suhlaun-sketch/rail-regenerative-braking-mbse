"""Rename the verified requirement ViewUsage and remove orphan usages from failed owned attempts."""
from __future__ import annotations
import json,uuid
from pathlib import Path
from urllib.parse import quote
import psycopg2
from tools.syson_automation.src.syson_client import SysONClient

ROOT=Path(__file__).resolve().parents[3]
state=json.loads((ROOT/'tools/syson_automation/cache/full_final_project.json').read_text(encoding='utf-8'))
index=json.loads((ROOT/'tools/syson_automation/cache/full_final_element_index.json').read_text(encoding='utf-8'))
views=json.loads((ROOT/'work/reports/FULL_SYSON_VIEW_REGISTRY.json').read_text(encoding='utf-8'))
rep=views['AUTO_REQ_ALL']['representation_id']
candidate='c45b0d4b-432c-48cc-bdf6-a9f3e86a64c5'
orphans=('e423b24c-58d8-4e40-b401-ada4aa92bc71','15fecca8-7643-40e5-b0d5-c9b8f81659be','598df2d3-3ea9-450e-98e3-1e703ebc9d9f')
db=psycopg2.connect(host='127.0.0.1',dbname='postgres',user='syson');db.set_session(readonly=True)
cur=db.cursor();cur.execute('select content from representation_content where representation_metadata_id=%s',(rep,))
content=cur.fetchone()[0]
if candidate not in content or any(x in content for x in orphans):
    raise RuntimeError('Candidate/orphan representation references do not match')
cur.execute('select content from representation_content')
all_content=[x[0] for x in cur.fetchall()]
if any(any(oid in body for body in all_content) for oid in orphans):
    raise RuntimeError('Orphan ViewUsage still has representation content')
desc=index.get('explorer_description_id') or state['explorer_description_id']
cur.execute('select content from document where id=%s',(state['requirements_document_id'],))
document=json.loads(cur.fetchone()[0])
paths={}; labels={}
def walk(value, ancestors):
    if isinstance(value,list):
        for child in value: walk(child,ancestors)
    elif isinstance(value,dict):
        if 'eClass' in value and 'id' in value:
            oid=value['id']
            if oid in (candidate,)+orphans:
                paths[oid]=[state['requirements_document_id']]+ancestors
                labels[oid]=(value.get('data') or {}).get('declaredName')
            ancestors=ancestors+[oid]
        for child in value.values():
            if isinstance(child,(list,dict)): walk(child,ancestors)
walk(document,[])
if set(paths)!={candidate,*orphans}: raise RuntimeError('ViewUsage path missing')
def explorer(object_id):
    expanded=paths[object_id]
    return 'explorer://?treeDescriptionId='+quote(desc,safe='')+'&expandedIds=['+','.join(quote(x,safe='') for x in expanded)+']&activeFilterIds=[]'
client=SysONClient(timeout=60)
def mutation(name,input_type,object_id,extra):
    q=f'mutation($input:{input_type}! ){{{name}(input:$input){{__typename ... on ErrorPayload{{message}}}}}}'
    data={'id':str(uuid.uuid4()),'editingContextId':state['editing_context_id'],
          'representationId':explorer(object_id),'treeItemId':object_id}|extra
    result=client.execute(q,{'input':data})[name]
    if 'Success' not in result['__typename']:
        raise RuntimeError(f'{name} {object_id}: {result}')
    return result
if labels[candidate]=='AUTO_REQ_ALL_CANDIDATE':
    mutation('renameTreeItem','RenameTreeItemInput',candidate,{'newLabel':'AUTO_REQ_ALL'})
elif labels[candidate]!='AUTO_REQ_ALL':
    raise RuntimeError('Unexpected candidate ViewUsage label')
for orphan in orphans:
    mutation('deleteTreeItem','DeleteTreeItemInput',orphan,{})
print('FORMAL_REQ_VIEW_USAGE=PASS ORPHANS_REMOVED=3')
