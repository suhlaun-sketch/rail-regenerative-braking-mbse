"""Read live SysON semantic relation endpoints without inferring them from names."""
from __future__ import annotations
import json,re
from collections import Counter
from pathlib import Path
import psycopg2

ROOT=Path(__file__).resolve().parents[3]
STATE=ROOT/'tools/syson_automation/cache/full_final_project.json'
OUT=ROOT/'work/reports/FULL_RELATION_ENDPOINTS.json'

def main():
    state=json.loads(STATE.read_text(encoding='utf-8'))
    db=psycopg2.connect(host='127.0.0.1',dbname='postgres',user='syson'); db.set_session(readonly=True)
    cur=db.cursor(); cur.execute('select name,content from document where id in (%s,%s)',(state['model_document_id'],state['requirements_document_id']))
    by_id={}; relations=[]
    def walk(x,doc):
        if isinstance(x,list):
            for v in x: walk(v,doc)
        elif isinstance(x,dict):
            if 'eClass' in x and 'id' in x:
                by_id[x['id']]=x
                kind=x['eClass'].split(':')[-1]
                if kind in ('AllocationUsage','ConnectionUsage','InterfaceUsage','SatisfyRequirementUsage'):
                    relations.append((x,doc))
            for v in x.values():
                if isinstance(v,(list,dict)): walk(v,doc)
    for name,content in cur.fetchall(): walk(json.loads(content),name)

    def endpoint(member):
        ref=(member.get('data') or {}).get('ownedRelatedElement',[{}])[0]
        subset=next((v for v in (ref.get('data') or {}).get('ownedRelationship',[])
                     if v.get('eClass','').endswith('ReferenceSubsetting')),None)
        if not subset: return {'object_id':None,'metaclass':None,'label':None}
        value=subset['data'].get('referencedFeature')
        if not isinstance(value,str): return {'object_id':None,'metaclass':None,'label':None}
        obj=by_id.get(value)
        if obj and obj.get('eClass')=='sysml:Feature':
            chain=[v.get('data',{}).get('chainingFeature') for v in obj.get('data',{}).get('ownedRelationship',[])
                   if v.get('eClass')=='sysml:FeatureChaining']
            if chain: value=chain[-1]; obj=by_id.get(value)
        return {'object_id':value,'metaclass':obj['eClass'].split(':')[-1] if obj else None,
                'label':(obj.get('data') or {}).get('declaredName') if obj else None}

    result=[]
    for rel,doc in relations:
        kind=rel['eClass'].split(':')[-1]
        if kind=='SatisfyRequirementUsage':
            relationships=(rel.get('data') or {}).get('ownedRelationship',[])
            subset=next((x for x in relationships if x.get('eClass')=='sysml:ReferenceSubsetting'),None)
            subject=next((x for x in relationships if x.get('eClass')=='sysml:SubjectMembership'),None)
            target_id=(subset.get('data') or {}).get('referencedFeature') if subset else None
            subject_text=json.dumps(subject,ensure_ascii=False) if subject else ''
            member=re.search(r'sysml:ActionUsage [^"\\]+#([0-9a-f-]{36})',subject_text)
            source_id=member.group(1) if member else None
            source_obj=by_id.get(source_id); target_obj=by_id.get(target_id)
            result.append({'relation_id':rel['id'],'relation_name':'satisfy_'+rel['id'],
                           'relation_metaclass':kind,'source_object_id':source_id,
                           'source_metaclass':source_obj['eClass'].split(':')[-1] if source_obj else None,
                           'source_label':(source_obj.get('data') or {}).get('declaredName') if source_obj else None,
                           'target_object_id':target_id,
                           'target_metaclass':target_obj['eClass'].split(':')[-1] if target_obj else None,
                           'target_label':(target_obj.get('data') or {}).get('declaredName') if target_obj else None,
                           'document':doc})
            continue
        members=[v for v in (rel.get('data') or {}).get('ownedRelationship',[])
                 if v.get('eClass')=='sysml:EndFeatureMembership']
        if len(members)!=2: continue
        source,target=map(endpoint,members)
        result.append({'relation_id':rel['id'],'relation_name':(rel.get('data') or {}).get('declaredName'),
                       'relation_metaclass':kind,'source_object_id':source['object_id'],
                       'source_metaclass':source['metaclass'],'source_label':source['label'],
                       'target_object_id':target['object_id'],'target_metaclass':target['metaclass'],
                       'target_label':target['label'],'document':doc})
    stats=Counter(x['relation_metaclass'] for x in result)
    unresolved=[x['relation_name'] for x in result if x['source_metaclass'] is None or x['target_metaclass'] is None]
    OUT.write_text(json.dumps({'project_id':state['project_id'],'relations':result,'counts':dict(stats),
                               'unresolved_endpoint_count':len(unresolved),'unresolved_sample':unresolved[:10]},
                              ensure_ascii=False,indent=2),encoding='utf-8')
    print('RELATION_ENDPOINTS',dict(stats),'UNRESOLVED',len(unresolved))

if __name__=='__main__': main()
