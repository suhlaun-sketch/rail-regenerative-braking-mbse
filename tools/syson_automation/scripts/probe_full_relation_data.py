import json
from pathlib import Path
import psycopg2
root=Path(__file__).resolve().parents[3]
state=json.loads((root/'tools/syson_automation/cache/full_final_project.json').read_text(encoding='utf-8'))
conn=psycopg2.connect(host='127.0.0.1',dbname='postgres',user='syson'); conn.set_session(readonly=True)
cur=conn.cursor(); cur.execute('select content from document where id=%s',(state['requirements_document_id'],))
data=json.loads(cur.fetchone()[0]); seen=set()
def walk(x):
    if isinstance(x,list):
        for v in x: walk(v)
    elif isinstance(x,dict):
        if 'eClass' in x and x['eClass'] in ('sysml:SatisfyRequirementUsage',) and x['eClass'] not in seen:
            seen.add(x['eClass']); d=x.get('data') or {}
            print(x['eClass'],d.get('declaredName'),x['id'],[(k,str(v)[:100]) for k,v in d.items() if k not in ('ownedRelationship','ownedFeatureMembership')][:18])
            print('OWNED_KEYS',[(k,len(v) if isinstance(v,list) else type(v).__name__) for k,v in d.items() if isinstance(v,(list,dict))])
            for rel in (d.get('ownedRelationship') or [])[:3]:
                print('REL',rel.get('eClass'),list((rel.get('data') or {}).keys()),str(rel)[:450])
                ref=(rel.get('data') or {}).get('ownedRelatedElement',[{}])[0]
                sub=(ref.get('data') or {}).get('ownedRelationship',[{}])[0]
                print('SUB',sub.get('eClass'),sub.get('data'))
        for v in x.values():
            if isinstance(v,(dict,list)): walk(v)
walk(data)
