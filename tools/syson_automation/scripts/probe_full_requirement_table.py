from __future__ import annotations
import json,uuid
from pathlib import Path
from websockets.sync.client import connect
from tools.syson_automation.src.syson_client import SysONClient
from tools.syson_automation.src.representation_service import RepresentationService

root=Path(__file__).resolve().parents[3]
state=json.loads((root/'tools/syson_automation/cache/full_final_project.json').read_text(encoding='utf-8'))
idx=json.loads((root/'tools/syson_automation/cache/full_final_element_index.json').read_text(encoding='utf-8'))
c=SysONClient(timeout=60); svc=RepresentationService(c,state['editing_context_id'])
for anchor in ('RequirementTraceabilityAllInOneV2','req_REQ_BRK_007'):
    oid=idx['by_semantic_id'][anchor][0]
    options=svc.descriptions(oid)
    desc=next(x['id'] for x in options if x['label']=='Requirements Table View')
    name='AUTO_FULL_PROBE_REQ_TABLE_'+('PACKAGE' if anchor.startswith('Requirement') else 'REQ')
    rep=svc.create_or_reuse(stable_key=state['project_id']+':'+name,root_object_id=oid,description_id=desc,name=name)
    q='subscription($input:TableEventInput!){tableEvent(input:$input){__typename ... on TableRefreshedEventPayload{table{id targetObjectId lines{id targetObjectId headerLabel hasChildren}}}}}'
    payload={'query':q,'variables':{'input':{'id':str(uuid.uuid4()),'representationId':rep['id'],'editingContextId':state['editing_context_id']}}}
    with connect('ws://localhost:8080/subscriptions',subprotocols=['graphql-ws'],open_timeout=20,close_timeout=2) as ws:
        ws.send(json.dumps({'type':'connection_init','payload':{}})); ws.recv(timeout=20)
        ws.send(json.dumps({'id':'1','type':'start','payload':payload}))
        for _ in range(5):
            msg=json.loads(ws.recv(timeout=30))
            if msg.get('type')=='data':
                ev=msg['payload']['data']['tableEvent']; print(name,ev['__typename'],len(ev.get('table',{}).get('lines',[])),flush=True); break
            if msg.get('type')=='error': print(name,'ERROR',str(msg.get('payload'))[:200],flush=True); break
