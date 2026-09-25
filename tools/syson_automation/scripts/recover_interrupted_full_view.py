"""Recover a final-project AUTO view whose create completed before local registry write."""
from __future__ import annotations
import json
import sys
from pathlib import Path
from tools.syson_automation.src.syson_client import SysONClient
from tools.syson_automation.src.representation_service import REGISTRY,RepresentationService
import psycopg2
root=Path(__file__).resolve().parents[3]
state=json.loads((root/'tools/syson_automation/cache/full_final_project.json').read_text(encoding='utf-8'))
index=json.loads((root/'tools/syson_automation/cache/full_final_element_index.json').read_text(encoding='utf-8'))
name,label=sys.argv[1:3]
client=SysONClient(timeout=60); svc=RepresentationService(client,state['editing_context_id'])
reps=[x for x in svc.representations() if x['label']==name]
ids=index['by_semantic_id'].get(label,[])
if len(reps)!=1 or len(ids)!=1: raise RuntimeError('Ambiguous representation/root')
diagram=svc.diagram(reps[0]['id'])
db=psycopg2.connect(host='127.0.0.1',dbname='postgres',user='syson')
db.set_session(readonly=True)
cur=db.cursor()
cur.execute('select created_on from representation_metadata where representation_metadata_id=%s', (reps[0]['id'],))
record=cur.fetchone()
if not record or record[0].date().isoformat()!='2026-09-24':
    raise RuntimeError('Existing representation is not from this run')
desc=next(x['id'] for x in svc.descriptions(ids[0]) if x['label']=='Interconnection View')
data=json.loads(REGISTRY.read_text(encoding='utf-8'))
key=state['project_id']+':'+name
if key in data and data[key]['id']!=reps[0]['id']: raise RuntimeError('Conflicting registry entry')
data[key]={'id':reps[0]['id'],'name':name,'created_by':'syson_automation',
           'root_object_id':ids[0],'description_id':desc}
REGISTRY.write_text(json.dumps(data,ensure_ascii=False,indent=2),encoding='utf-8')
print('RECOVERED',name,reps[0]['id'])
