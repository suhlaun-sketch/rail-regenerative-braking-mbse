from __future__ import annotations
import json
from pathlib import Path
from tools.syson_automation.src.syson_client import SysONClient
from tools.syson_automation.src.representation_service import RepresentationService
root=Path(__file__).resolve().parents[3]
state=json.loads((root/'tools/syson_automation/cache/full_final_project.json').read_text(encoding='utf-8'))
index=json.loads((root/'tools/syson_automation/cache/full_final_element_index.json').read_text(encoding='utf-8'))
c=SysONClient(timeout=90); s=RepresentationService(c,state['editing_context_id'])
for name in ('req_REQ_BRK_015','req_REQ_BRK_016'):
    ids=index['by_semantic_id'].get(name,[])
    print(name,len(ids),ids[:1],flush=True)
    if len(ids)!=1: continue
    ds=s.descriptions(ids[0]); print('desc',[(x['label']) for x in ds],flush=True)
    rep=s.create_or_reuse(stable_key=state['project_id']+':PROBE:'+name,root_object_id=ids[0],description_id=next(x['id'] for x in ds if x['label']=='General View'),name='AUTO_FULL_PROBE_'+name)
    try: print('result',s.populate_and_verify(rep['id'],[ids[0]],arrange=False),flush=True)
    except Exception as exc: print('FAIL',str(exc),flush=True)
package=index['by_semantic_id']['RequirementTraceabilityAllInOneV2'][0]
ds=s.descriptions(package)
rep=s.create_or_reuse(stable_key=state['project_id']+':PROBE:PACKAGE',root_object_id=package,description_id=next(x['id'] for x in ds if x['label']=='General View'),name='AUTO_FULL_PROBE_REQ_PACKAGE')
for name in ('req_REQ_BRK_007','req_REQ_BRK_015','req_REQ_BRK_004','req_REQ_BRK_003','req_REQ_BRK_002','req_REQ_BRK_001'):
    try: print('package',name,s.populate_and_verify(rep['id'],index['by_semantic_id'][name],arrange=False)['status'],flush=True)
    except Exception as exc: print('package',name,'FAIL',str(exc),flush=True)
