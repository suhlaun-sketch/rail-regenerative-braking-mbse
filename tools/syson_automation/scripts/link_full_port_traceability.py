"""Attach live SysON object IDs to evidence-backed boundary-port provenance."""
from __future__ import annotations
import json
from pathlib import Path

ROOT=Path(__file__).resolve().parents[3]
TRACE=ROOT/'work/sysmlv2/full_engineering_model/03_full_boundary/FULL_PORT_TRACEABILITY.json'
HIER=ROOT/'work/reports/FULL_PRODUCT_HIERARCHY.json'
INDEX=ROOT/'tools/syson_automation/cache/full_final_element_index.json'
REL=ROOT/'work/reports/FULL_RELATION_ENDPOINTS.json'

def main():
    trace=json.loads(TRACE.read_text(encoding='utf-8'))
    hierarchy={x['product_code']:x for x in json.loads(HIER.read_text(encoding='utf-8'))['products']}
    index=json.loads(INDEX.read_text(encoding='utf-8'))
    relations={x['relation_name']:x for x in json.loads(REL.read_text(encoding='utf-8'))['relations']
               if x['relation_name']}
    by_name=index['by_semantic_id']
    for port in trace['port_usages']:
        definition=hierarchy[port['owner_product']]['definition_id']
        owners=by_name.get(definition,[])
        ports=by_name.get(port['port_id'],[])
        if len(owners)!=1 or len(ports)!=1:
            raise RuntimeError(f"Unresolved owner/port: {port['port_id']}")
        port['owner_object_id']=owners[0]
        port['port_object_id']=ports[0]
    for connection in trace['connection_usages']:
        relation=relations.get(connection['connection_id'])
        if not relation or relation['relation_metaclass']!='ConnectionUsage':
            raise RuntimeError(f"Missing semantic connection: {connection['connection_id']}")
        for key in ('relation_id','source_object_id','source_metaclass','source_label',
                    'target_object_id','target_metaclass','target_label'):
            connection[key]=relation[key]
    TRACE.write_text(json.dumps(trace,ensure_ascii=False,indent=2),encoding='utf-8')
    print(f"PORT_TRACEABILITY=PASS PORTS={len(trace['port_usages'])} CONNECTIONS={len(trace['connection_usages'])}")

if __name__=='__main__': main()
