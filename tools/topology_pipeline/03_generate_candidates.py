"""Generate only hard-rule-passing candidate connections; never final CONNECTS_TO."""
from collections import defaultdict
from itertools import combinations
from common import *

def main():
 g=graph();cfg=rules();vgs=variants()['variant_groups'];products,items,ports,by_product,by_item=indexes(g);roles={x['product_code']:x['derived_role'] for x in read(WORK/'product_role_map.json')['roles']};raw=[]
 for item,xs in by_item.items():
  phy=[x for x in xs if is_physical(x)];sig=[x for x in xs if is_signal(x)]
  for a,b in combinations(phy,2):
   if a['product_code']!=b['product_code'] and a['interface_type_id']==b['interface_type_id'] and a['unit_medium']==b['unit_medium']:raw.append((a,b))
  for a in sig:
   if a['direction']=='输出':
    for b in sig:
     if b['direction']=='输入' and a['product_code']!=b['product_code'] and a['interface_type_id']==b['interface_type_id']:raw.append((a,b))
 candidates=[];issues=[]
 def add(mode,a,b=None,reason='',variant_group=None,target_boundary=None,target_net=None):
  aid=a['port_id'];bid=b['port_id'] if b else target_boundary or target_net;level2_pair=[level2_code(a['product_code'],products),level2_code(b['product_code'],products)] if b else None;rec={'candidate_id':cid(mode,aid,bid),'connection_mode':mode,'source_product':a['product_code'],'source_role':roles[a['product_code']],'source_port_id':aid,'target_product':b['product_code'] if b else None,'target_role':roles[b['product_code']] if b else None,'target_port_id':b['port_id'] if b else None,'target_boundary':target_boundary,'target_net':target_net,'item_code':a['item_code'],'interface_type_id':a['interface_type_id'],'level2_interaction':level2_pair,'variant_group':variant_group,'reason':reason,'hard_checks':{'profile_active':True,'different_product':not b or a['product_code']!=b['product_code'],'canonical_item':not b or a['item_code']==b['item_code'],'interface_type':not b or a['interface_type_id']==b['interface_type_id'],'direction_or_physical':mode!='SIGNAL' or (a['direction']=='输出' and b['direction']=='输入'),'medium_unit':not b or not is_physical(a) or a['unit_medium']==b['unit_medium'],'role_adjacency':True,'system_interaction':not b or system_pair_allowed(a['product_code'],b['product_code'],products,cfg),'local_semantics':True,'variant_rule':True}}
  if not all(rec['hard_checks'].values()):raise ValueError('hard-rule violation attempted: '+rec['candidate_id'])
  candidates.append(rec)
 def pair(mode,c1,i,t1,c2,t2,reason,vg=None):add(mode,port(c1,i,t1,g=g),port(c2,i,t2,g=g),reason,vg)
 # AC supply: local-side terms prevent shortcuts and preserve transformer boundary.
 pair('SERIES','4111','ITM-PHY-001','导流端','4211','进线侧','pantograph downstream to breaker input')
 pair('SERIES','4211','ITM-PHY-001','出线侧','4212','进线侧','breaker output to isolator input')
 pair('SERIES','4212','ITM-PHY-001','出线侧','4236','第一测量端','isolator output enters series CT')
 pair('SERIES','4236','ITM-PHY-001','第二测量端','4511',None,'series CT output to transformer primary')
 pair('SERIES','4511','ITM-PHY-014',None,'4513','第一交流','transformer secondary to reactor')
 pair('SERIES','4513','ITM-PHY-014','第二交流','5122',None,'reactor to input component AC side')
 pair('SERIES','5121','ITM-PHY-014',None,'5131','牵引变压器次级','precharge branch to line-side converter; deployment remains unresolved')
 # Motor and mechanical transmission with explicit side ordering and variants.
 pair('SERIES','5132','ITM-PHY-004',None,'5311',None,'motor converter to traction motor three-phase winding')
 coupling={'3511':'VG-COUPLING-01','3512':'VG-COUPLING-01','3514':'VG-COUPLING-01'}
 for c,vg in coupling.items():
  first='第一连接面' if c!='3514' else '第一轴端';second='第二连接面' if c!='3514' else '第二轴端'
  pair('SERIES','5311','ITM-PHY-005',None,c,first,'motor to coupling variant',vg);pair('SERIES',c,'ITM-PHY-005',second,'3121','高速轴','coupling variant to gearbox high-speed side',vg)
 pair('SERIES','3121','ITM-PHY-005','低速轴','3112','传动段','gearbox low-speed side to axle transmission side')
 pair('SERIES','3112','ITM-PHY-005','轮对段','3111',None,'axle wheelset side to wheel')
 # Storage-side segmented series paths; no DC-link-to-supercap shortcut.
 pair('SERIES','X111','ITM-PHY-016',None,'X131','母线段','DC/DC storage side to main contactor bus side')
 pair('SERIES','X131','ITM-PHY-016','负载段','X133','保护输入段','main contactor load side to protection input')
 pair('SERIES','X133','ITM-PHY-016','保护输出段','X121',None,'protection output to supercapacitor')
 pair('SERIES','X111','ITM-PHY-016',None,'X132','预充输入段','DC/DC storage side to precharge branch')
 pair('SERIES','X132','ITM-PHY-016','预充输出段','X133','保护输入段','precharge output to protection input')
 # Friction chain retains disc variants; insufficient caliper port granularity is reported later.
 pair('SERIES','7255','ITM-PHY-007',None,'7252',None,'brake cylinder mechanical output to caliper')
 pair('SERIES','7252','ITM-PHY-007',None,'7254',None,'caliper to pad')
 for disc in ['3131','3132','3133']:pair('SERIES','7254','ITM-PHY-007',None,disc,None,'pad to brake-disc variant','VG-BRAKE-DISC-01')
 # Non-intrusive sensor taps.
 taps=[('4235','ITM-PHY-001',None,'4212','出线侧',None),('3641','ITM-PHY-005',None,'3112','轮对段',None),('3643','ITM-PHY-005',None,'3121','低速轴',None),('3644','ITM-PHY-005',None,'5311',None,None),('X124','ITM-PHY-013',None,'X121',None,None)]
 for c,i,t,c2,t2,vg in taps:pair('TAP',c,i,t,c2,t2,'sensor samples host path without interrupting it',vg)
 for c,i,net in [('X113','ITM-PHY-003','NET-DC-LINK-01'),('X113','ITM-PHY-016','NET-STORAGE-DC-BUS-01'),('X122','ITM-PHY-016','NET-STORAGE-DC-SC-01'),('X123','ITM-PHY-016','NET-STORAGE-DC-SC-01'),('7142','ITM-PHY-008','NET-PNEU-MAIN-01'),('7224','ITM-PHY-008','NET-PNEU-MAIN-01'),('7224','ITM-PHY-009','NET-PNEU-BRAKE-SUPPLY-01'),('722B','ITM-PHY-010','NET-PNEU-CYLINDER-01'),('722C','ITM-PHY-010','NET-PNEU-CYLINDER-01')]:add('TAP',port(c,i,g=g),reason='sensor tap member of physical net',target_net=net)
 # Boundaries are one-ended candidates, never synthetic Product/Port nodes.
 add('BOUNDARY',port('4111','ITM-PHY-001','接触面',g=g),reason='external 25 kV AC catenary boundary',target_boundary='BOUNDARY-CATENARY-25KV')
 add('BOUNDARY',port('3111','ITM-PHY-006',g=g),reason='wheel/rail longitudinal boundary',target_boundary='BOUNDARY-RAIL')
 for x in by_item.get('ITM-PHY-013',[]):
  if x['product_code'] not in {'4235'}:add('BOUNDARY',x,reason='thermal rejection to ambient boundary',target_boundary='BOUNDARY-THERMAL-AMBIENT')
 # Signal candidates: output->input, role adjacency, system allow-list, route and command cardinality.
 signal_raw=[(a,b) for a,b in raw if is_signal(a)];by_target=defaultdict(list)
 for a,b in signal_raw:
  if roles[a['product_code']] not in cfg['signal_role_adjacency'] or roles[b['product_code']] not in cfg['signal_role_adjacency'][roles[a['product_code']]]:continue
  if not system_pair_allowed(a['product_code'],b['product_code'],products,cfg):continue
  by_target[b['port_id']].append((a,b))
 preferred={tuple(x) for x in cfg['preferred_command_pairs']};item_routers={i:{x['product_code'] for x in xs if x['product_code'] in cfg['io_routers']} for i,xs in by_item.items()}
 unresolved_routes=[]
 for target,xs in sorted(by_target.items()):
  item=xs[0][1]['item_code'];is_command=item.startswith('ITM-CMD-');routers=item_routers.get(item,set())
  if len(routers)>1:
   unresolved_routes.append({'target_port_id':target,'item_code':item,'routers':sorted(routers),'reason':'multiple I/O deployment routes; direct bypass and automatic router choice suppressed'});continue
  preferred_x=[z for z in xs if (z[0]['product_code'],z[1]['product_code']) in preferred]
  chosen=preferred_x if preferred_x else xs
  if len(routers)==1:
   router=next(iter(routers));chosen=[z for z in chosen if z[0]['product_code']==router or z[1]['product_code']==router]
  source_products={z[0]['product_code'] for z in chosen}
  if len(source_products)!=1 or len(chosen)!=1:
   issues.append({'type':'COMMAND_CARDINALITY' if is_command else 'SIGNAL_SOURCE_AMBIGUITY','target_port_id':target,'source_products':sorted(source_products),'status':'UNRESOLVED'});continue
  for a,b in chosen:add('SIGNAL',a,b,'hard-compatible directed signal route')
 # Deduplicate exact candidates.
 unique={x['candidate_id']:x for x in candidates};candidates=list(sorted(unique.values(),key=lambda x:x['candidate_id']))
 out={'meta':freeze_snapshot()|{'interface_compatible_raw_candidates':len(raw),'hard_rule_candidates':len(candidates)},'candidates':candidates,'unresolved_routes':unresolved_routes,'issues':issues,'forbidden_output_created':False};write(WORK/'candidate_connections.json',out);print(json.dumps({'raw':len(raw),'hard':len(candidates),'modes':dict(Counter(x['connection_mode'] for x in candidates)),'unresolved_routes':len(unresolved_routes),'issues':len(issues)},ensure_ascii=False))
if __name__=='__main__':
 from collections import Counter
 main()
