from __future__ import annotations
import json
from pathlib import Path
from tools.syson_automation.src.syson_client import SysONClient
from tools.syson_automation.src.representation_service import RepresentationService

root = Path(__file__).resolve().parents[3]
state = json.loads((root/'tools/syson_automation/cache/full_final_project.json').read_text(encoding='utf-8'))
c = SysONClient(timeout=60)
s = RepresentationService(c, state['editing_context_id'])
for label in ('P_X100','p_X100','P_N_3000','p_N_3000','req_REQ_BRK_007','FN_F_X100_01','a_F_X100_01','bp_X100_aa'):
    found=[x for x in c.search(state['editing_context_id'],label) if x['label']==label]
    print(label,[(x['id'],x['kind'].split('entity=')[-1]) for x in found[:4]])
    if found and label in ('P_X100','p_X100','req_REQ_BRK_007','FN_F_X100_01'):
        print('DESCRIPTIONS', label,[(x['label'],x['id']) for x in s.descriptions(found[0]['id'])])
