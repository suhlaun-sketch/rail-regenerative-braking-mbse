import json
from pathlib import Path
import psycopg2
root=Path(__file__).resolve().parents[3]
s=json.loads((root/'tools/syson_automation/cache/full_final_project.json').read_text(encoding='utf-8'))
c=psycopg2.connect(host='127.0.0.1',dbname='postgres',user='syson');c.set_session(readonly=True)
u=c.cursor();u.execute('select content from document where id=%s',(s['requirements_document_id'],)); d=json.loads(u.fetchone()[0])
target='c45b0d4b-432c-48cc-bdf6-a9f3e86a64c5'
def walk(x,path):
 if isinstance(x,list):
  for y in x:walk(y,path)
 elif isinstance(x,dict):
  if 'eClass' in x and 'id' in x:
   path=path+[(x['id'],x['eClass'].split(':')[-1],(x.get('data') or {}).get('declaredName'))]
   if x['id']==target:print('PATH',path)
  for y in x.values():
   if isinstance(y,(list,dict)):walk(y,path)
walk(d,[])
