import json
from pathlib import Path
import psycopg2
root=Path(__file__).resolve().parents[3]
s=json.loads((root/'tools/syson_automation/cache/full_final_project.json').read_text(encoding='utf-8'))
c=psycopg2.connect(host='127.0.0.1',dbname='postgres',user='syson');c.set_session(readonly=True)
u=c.cursor();u.execute('select content from document where id=%s',(s['requirements_document_id'],)); d=json.loads(u.fetchone()[0])
def walk(x):
 if isinstance(x,list):
  for y in x: walk(y)
 elif isinstance(x,dict):
  if x.get('eClass')=='sysml:ViewUsage' and ('REQ_ALL' in (x.get('data') or {}).get('declaredName','')):
   print(x['id'],x['data'].get('declaredName'),[(k,str(v)[:130]) for k,v in x['data'].items() if not isinstance(v,(list,dict))])
  for y in x.values():
   if isinstance(y,(list,dict)):walk(y)
walk(d)
