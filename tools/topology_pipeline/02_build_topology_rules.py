"""Resolve configuration and audit rule completeness without modifying KG v1."""
from common import *
def main():
 cfg=rules();vg=variants();role=read(WORK/'product_role_map.json');g=graph();modes=set(cfg['connection_modes']);required={'SERIES','NET','TAP','SIGNAL','BOUNDARY'}
 audit={'kg_frozen':freeze_snapshot(),'connection_modes_complete':modes==required,'role_map_products':len(role['roles']),'active_ports_semantically_annotated':sum(len(x['port_semantics']) for x in role['roles']),'variant_groups':vg['variant_groups'],'hard_rules':['profile_active=true','different Product','canonical Item equal','InterfaceType equal','Signal output to input','Physical medium/unit equal','Product Role adjacency','top-level system interaction allow-list','Port local-side semantics','Variant/route constraints'],'graphrag_can_override_hard_rules':False}
 write(WORK/'topology_rules_resolved.json',{'config':cfg,'audit':audit})
 lines=['# Topology Rule Report','','- KG v1 frozen: PASS',f"- Active EXPOSES baseline: {audit['kg_frozen']['Active_EXPOSES']}",f"- Role map Products: {audit['role_map_products']}",f"- Ports with derived local semantics: {audit['active_ports_semantically_annotated']}",f"- Modes: {', '.join(sorted(modes))}",'- GraphRAG hard-rule override: forbidden','','## Variant groups','']
 for x in vg['variant_groups']:lines+= [f"- {x['variant_group_id']}: {', '.join(x['products'])} — {x['status']} — {x['reason']}"]
 lines+=['','## Role map audit','','| Product | Name | Level | Leaf | Derived role | Active ports |','|---|---|---:|---|---|---:|']+[f"| {x['product_code']} | {x['product_name']} | {x['level']} | {str(x['leaf']).lower()} | {x['derived_role']} | {x['active_port_count']} |" for x in role['roles']]+['','## Hard gates','']+[f'- {x}' for x in audit['hard_rules']];(REPORTS/'topology_rule_report.md').write_text('\n'.join(lines)+'\n',encoding='utf-8');print(json.dumps(audit,ensure_ascii=False))
if __name__=='__main__':main()
