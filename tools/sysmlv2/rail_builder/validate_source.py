import json, sys
from collections import Counter
from common import build_model, VALIDATION, dump_json

def main():
    m=build_model(); pids={str(x['code']) for x in m['products']}; items={x['item_code'] for x in m['items']}; ports={x['port_id'] for x in m['ports']}
    checks={"product_count":len(pids)==147,"level_counts":Counter(x['level'] for x in m['products'])==Counter({1:8,2:16,3:34,4:89}),"item_count":len(items)==144,"raw_port_count":len(m['ports'])==517,
        "active_ports":sum(bool(x['profile_active']) for x in m['ports'])==511,"inactive_ports":sum(not bool(x['profile_active']) for x in m['ports'])==6,"function_count":len(m['functions'])==191,
        "allocation_count":len(m['allocations'])==191,"connection_count":len(m['connections'])==184,"physical_net_count":len(m['nets'])==9,
        "raw_ports_leaf_only":all(m['product_by_code'][str(x['product_code'])]['leaf'] for x in m['ports']),"connection_source_ports_resolve":all(x['source_port_id'] in ports for x in m['connections']),
        "connection_items_resolve":all(x['item_code'] in items for x in m['connections']),"connection_ids_unique":len({x['connection_id'] for x in m['connections']})==184,
        "generated_endpoints_complete":all(x.get('source_path') and x.get('target_path') for x in m['connections']),
        "signal_directions_valid":all(x['physical_or_signal']!='SIGNAL' or (m['port_by_id'][x['source_port_id']]['direction']=='输出' and (not x.get('target_port_id') or m['port_by_id'][x['target_port_id']]['direction']=='输入')) for x in m['connections']),
        "physical_directions_valid":all(x['physical_or_signal']!='PHYSICAL' or m['port_by_id'][x['source_port_id']]['direction']=='双向物理' for x in m['connections']),
        "upper_functions_trace_to_leaf":all(m['product_by_code'][str(f['owner_product_code'])]['leaf'] or bool(f.get('aggregated_from_functions')) for f in m['functions']),
        "anchor_4235_5111":any(str(x['source_product_code'])=='4235' and str(x['target_product_code'])=='5111' for x in m['connections']),
        "anchor_7211_8125":any(str(x['source_product_code'])=='7211' and str(x['target_product_code'])=='8125' for x in m['connections']),"forbidden_7211_5112":not any(str(x['source_product_code'])=='7211' and str(x['target_product_code'])=='5112' for x in m['connections']),
        "leaf_3131_3132_3133":all(m['product_by_code'].get(x,{}).get('leaf') for x in ('3131','3132','3133')),"x100_complete":all(x in pids for x in ('X100','X110','X111','X112','X113','X120','X121','X122','X123','X124','X130','X131','X132','X133'))}
    report={"status":"PASS" if all(checks.values()) else "FAIL","checks":checks}; dump_json(VALIDATION/"Source_Validation.json",report); print(json.dumps(report,ensure_ascii=False)); return 0 if all(checks.values()) else 1
if __name__=="__main__": sys.exit(main())
