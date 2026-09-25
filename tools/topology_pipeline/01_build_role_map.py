"""Derive auditable Product roles and local Port-side semantics."""
from collections import Counter
from common import *

def infer(p,ps,explicit):
 c=p['code']; evidence=[]
 if c in explicit:return explicit[c],['explicit topology rule keyed by Product code']
 if not p['leaf']:return 'HIERARCHY_CONTAINER',['non-leaf Product level container']
 phys=[x for x in ps if is_physical(x)];outs=[x for x in ps if x['direction']=='输出'];name=p['name']+p['node_role']
 if '安全' in name:return 'SAFETY_LOGIC',['Product name/node_role contains 安全']
 if '控制' in name:return 'CONTROLLER',['Product name/node_role contains 控制']
 if ('传感器' in name or '互感器' in name or '检测' in name) and len(phys)==1 and outs:return 'SENSOR_TAP',['one physical sensing port plus signal output']
 if ('传感器' in name or '互感器' in name) and len(phys)>=2:return 'SERIES_SENSOR',['two or more physical traversal ports plus measurement']
 if len(phys)>=2 and len({x['item_code'] for x in phys})==1:return 'SERIES_ELECTRICAL' if '电气' in phys[0]['unit_medium'] else 'PNEUMATIC_ELEMENT' if '空气' in phys[0]['unit_medium'] else 'SERIES_MECHANICAL',['two equal-domain physical ports']
 if outs and not phys:return 'CONTROLLER',['signal-only active boundary']
 return 'UNCLASSIFIED',['insufficient topology evidence; kept auditable and conservative']

def main():
 g=graph();cfg=rules();products,_,_,by_product,_=indexes(g);rows=[]
 for code,p in sorted(products.items()):
  role,evidence=infer(p,by_product.get(code,[]),cfg['explicit_roles']);rows.append({'product_code':code,'product_name':p['name'],'level':p['level'],'leaf':p['leaf'],'node_role_source':p['node_role'],'derived_role':role,'evidence':evidence,'active_port_count':len(by_product.get(code,[])),'port_semantics':[{'port_id':x['port_id'],'item_code':x['item_code'],'direction':x['direction'],'port_category':x['port_category'],'local_sides':local_sides(x['port_name'])} for x in by_product.get(code,[])]})
 out={'meta':freeze_snapshot(),'roles':rows,'counts':dict(sorted(Counter(x['derived_role'] for x in rows).items()))};write(WORK/'product_role_map.json',out);print(json.dumps({'products':len(rows),'role_counts':out['counts']},ensure_ascii=False))
if __name__=='__main__':main()
