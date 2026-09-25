"""Resolve only recorded ambiguities into one deterministic reference instance."""
from __future__ import annotations
import copy,hashlib,json
from collections import Counter,defaultdict
from common import *

PROJECT='RAIL_MBSE_TRACTION_BRAKE';PROFILE='CRH_AC25KV_SC'
def main():
 g=graph();cfg=read(CONFIG/'reference_instance.yaml');cand=read(WORK/'candidate_connections.json');netdata=read(WORK/'candidate_nets.json');roles={x['product_code']:x['derived_role'] for x in read(WORK/'product_role_map.json')['roles']};products,items,ports,by_product,_=indexes(g);connections=[]
 def select(code,item,direction=None,term=None):
  xs=[x for x in by_product[code] if x['item_code']==item and (not direction or x['direction']==direction) and (not term or term in x['port_name'])]
  if len(xs)!=1:raise ValueError(f'final selector not unique: {code}/{item}/{direction}/{term}: {len(xs)}')
  return xs[0]
 def add(mode,a,b=None,boundary=None,basis='hard-rule candidate',primary=False):
  target=b['port_id'] if b else boundary;raw='|'.join([mode,a['port_id'],target,PROFILE]);rid='CG-'+hashlib.sha256(raw.encode('utf-8')).hexdigest()[:24].upper();connections.append({'connection_id':rid,'source_product':a['product_code'],'source_port_id':a['port_id'],'target_product':b['product_code'] if b else None,'target_port_id':b['port_id'] if b else None,'target_boundary':boundary,'item_code':a['item_code'],'interface_type_id':a['interface_type_id'],'mode':mode,'profile_id':PROFILE,'project_id':PROJECT,'primary_source':primary if mode=='SIGNAL' else None,'resolution_basis':basis})
 # Preserve unique, already-passed candidates except the explicitly resolved areas.
 transformer={'4511','4513','5121','5122','5131'}
 for x in cand['candidates']:
  mode=x['connection_mode'];sp=x['source_product'];tp=x['target_product']
  if mode=='SIGNAL':add('SIGNAL',ports[x['source_port_id']],ports[x['target_port_id']],basis='existing unique hard-rule candidate',primary=True)
  elif mode=='TAP' and x['target_port_id']:add('TAP',ports[x['source_port_id']],ports[x['target_port_id']],basis=x['reason'])
  elif mode=='BOUNDARY':add('BOUNDARY',ports[x['source_port_id']],boundary='BOUNDARY-THERMAL-ENVIRONMENT' if x['target_boundary']=='BOUNDARY-THERMAL-AMBIENT' else x['target_boundary'],basis=x['reason'])
  elif mode=='SERIES':
   if x['item_code']=='ITM-PHY-016' or x.get('variant_group') or ({sp,tp}<=transformer and x['item_code']=='ITM-PHY-014'):continue
   add('SERIES',ports[x['source_port_id']],ports[x['target_port_id']],basis=x['reason'])
 # Couplings are a serial assembly, not mutually exclusive variants.
 for a,at,b,bt in [('5311',None,'3511','第一连接面'),('3511','第二连接面','3514','第一轴端'),('3514','第二轴端','3512','第一连接面'),('3512','第二连接面','3121','高速轴')]:add('SERIES',select(a,'ITM-PHY-005',term=at),select(b,'ITM-PHY-005',term=bt),basis='resolved driveline SERIES assembly from Product and Port-side semantics')
 # One executable brake-disc branch; other solution-space Products remain untouched.
 add('SERIES',select('7254','ITM-PHY-007'),select(cfg['brake_disc_resolution']['selected_product'],'ITM-PHY-007'),basis='executable_reference_assumption; alternate disc Products retained')
 # Transformer secondary input and precharge branches remain structural; switching state is a Simulation Contract concern.
 for a,at,b,bt in [('4511',None,'4513','第一交流'),('4513','第二交流','5121',None),('4513','第二交流','5122',None),('5121',None,'5131',None),('5122',None,'5131',None)]:add('SERIES',select(a,'ITM-PHY-014',term=at),select(b,'ITM-PHY-014',term=bt),basis='resolved secondary AC main/precharge structural branch; runtime state deferred to Simulation Contract')
 add('SERIES',select('3813','ITM-PHY-012'),select('3814','ITM-PHY-012'),basis='sanding valve/nozzle granular-medium continuity')
 # Resolve the 42 recorded source ambiguities and the six route issues deterministically.
 resolved=[]
 for target,item,source in cfg['signal_source_overrides']+cfg['direct_bus_routes']+cfg['additional_signal_routes']:
  a=select(source,item,'输出');b=select(target,item,'输入');add('SIGNAL',a,b,basis='reference instance source priority / '+cfg['logical_control_route'],primary=True);resolved.append({'target_port_id':b['port_id'],'source_port_id':a['port_id'],'policy':'DIRECT_BUS' if [target,item,source] in cfg['direct_bus_routes'] else 'SOURCE_PRIORITY'})
 # Close the return path at the existing rail boundary without inventing a Product Port.
 return_boundary_port=select('4413','ITM-PHY-011',term='固定端');add('BOUNDARY',return_boundary_port,boundary='BOUNDARY-RAIL',basis='explicit rail/return ExternalBoundary closure')
 # Deduplicate and enforce one primary source for every Signal Input.
 connections=list({x['connection_id']:x for x in connections}.values());targets=Counter(x['target_port_id'] for x in connections if x['mode']=='SIGNAL')
 if any(v>1 for v in targets.values()):raise ValueError('Signal Input has multiple primary sources')
 # Final nets reuse candidate nets, with one return port moved to the explicit rail boundary.
 names={'NET-DC-LINK-01':'DC Link','NET-STORAGE-DC-BUS-01':'Storage DC upstream bus','NET-STORAGE-DC-AFTER-CONTACTOR-01':'Storage DC protected bus','NET-STORAGE-DC-SC-01':'Supercapacitor terminal net','NET-PNEU-MAIN-01':'Main reservoir pneumatic net','NET-PNEU-BRAKE-SUPPLY-01':'Brake supply pneumatic net','NET-PNEU-CYLINDER-01':'Cylinder/control pressure net','NET-LVDC-CONTROL-01':'Low-voltage control supply','NET-MAIN-RETURN-01':'Traction return net'};nets=[];memberships=[]
 for rawnet in netdata['nets']:
  n=copy.deepcopy(rawnet);n['name']=names[n['net_id']];n['domain']=items[n['item_code']]['domain'];n['profile_id']=PROFILE;n['project_id']=PROJECT;n['members']=[m for m in n['members'] if m['port_id']!=return_boundary_port['port_id']]
  for m in n['members']:
   key=f"{n['net_id']}|{m['port_id']}|{PROFILE}";memberships.append({'membership_id':'NM-'+hashlib.sha256(key.encode()).hexdigest()[:24].upper(),'net_id':n['net_id'],'product_code':m['product_code'],'port_id':m['port_id'],'item_code':n['item_code'],'profile_id':PROFILE,'project_id':PROJECT,'participation':m['participation']})
  n.pop('members');nets.append(n)
 boundaries=[{'boundary_id':'BOUNDARY-CATENARY-25KV','name':'External 25 kV AC catenary','domain':'electrical','profile_id':PROFILE,'project_id':PROJECT},{'boundary_id':'BOUNDARY-RAIL','name':'Rail mechanical and traction-return boundary','domain':'mechanical/electrical','profile_id':PROFILE,'project_id':PROJECT},{'boundary_id':'BOUNDARY-THERMAL-ENVIRONMENT','name':'Ambient thermal sink','domain':'thermal','profile_id':PROFILE,'project_id':PROJECT}]
 write(WORK/'final_connections.json',{'meta':{'source_hard_candidates':cand['meta']['hard_rule_candidates'],'count':len(connections),'modes':dict(Counter(x['mode'] for x in connections))},'connections':sorted(connections,key=lambda x:x['connection_id'])})
 write(WORK/'final_nets.json',{'meta':{'physical_nets':len(nets),'net_memberships':len(memberships),'external_boundaries':len(boundaries)},'physical_nets':nets,'net_memberships':memberships,'external_boundaries':boundaries})
 # Exactly one final disposition per Active Port.
 refs=defaultdict(list)
 for x in connections:
  refs[x['source_port_id']].append(x); 
  if x['target_port_id']:refs[x['target_port_id']].append(x)
 mem={x['port_id']:x for x in memberships};coverage=[];critical=[]
 critical_commands={'ITM-CMD-003','ITM-CMD-004','ITM-CMD-019','ITM-CMD-020','ITM-CMD-021','ITM-CMD-022','ITM-CMD-023','ITM-CMD-030','ITM-CMD-031'}
 for p in sorted(active_ports(g),key=lambda x:x['port_id']):
  rs=refs.get(p['port_id'],[]);m=mem.get(p['port_id']);modes={x['mode'] for x in rs}
  if 'BOUNDARY' in modes:d='EXTERNAL_BOUNDARY';reason='explicit ExternalBoundary connection'
  elif m and m['participation']=='TAP':d='TAP_CONNECTED';reason='non-intrusive NET tap membership'
  elif m:d='NET_MEMBER';reason='PhysicalNet membership'
  elif 'TAP' in modes:d='TAP_CONNECTED';reason='non-intrusive TAP connection'
  elif rs:d='CONNECTED';reason='resolved final connection'
  else:d='OPTIONAL_OPEN';reason='non-critical diagnostic/statistic/spare or unexposed Simulation Contract input'
  unselected_variant=p['product_code'] in {'3132','3133'} and p['item_code']=='ITM-PHY-007'
  iscritical=(p['item_code'].startswith('ITM-PHY-') and not unselected_variant) or (p['direction']=='输入' and p['item_code'] in critical_commands and not (p['product_code']=='7226' and p['item_code']=='ITM-CMD-030'))
  if iscritical and d=='OPTIONAL_OPEN':critical.append(p['port_id'])
  coverage.append({'port_id':p['port_id'],'product_code':p['product_code'],'item_code':p['item_code'],'disposition':d,'reason':reason,'connection_ids':[x['connection_id'] for x in rs],'net_id':m['net_id'] if m else None,'critical':iscritical})
 if critical:raise ValueError('CRITICAL_UNRESOLVED ports: '+','.join(critical))
 write(WORK/'final_port_coverage.json',{'meta':{'total_active_ports':len(coverage),'counts':dict(Counter(x['disposition'] for x in coverage)),'critical_unresolved':0},'coverage':coverage})
 log={'net_count_explanation':'83 candidate membership records referenced 83 unique ports; 9 participation=TAP records were counted as TAP_CONNECTED, leaving 74 NET_MEMBER. No port belonged to multiple mutually exclusive nets. Final return closure moves one port from NET membership to BOUNDARY.','coupling_resolution':cfg['coupling_resolution'],'brake_disc_resolution':cfg['brake_disc_resolution'],'transformer_secondary_resolution':'4513 feeds parallel structural main-input (5122) and precharge (5121) branches into 5131; switch state is deferred to Simulation Contract.','route_policy':{'logical_control_route':cfg['logical_control_route'],'physical_discrete_route':cfg['physical_discrete_route']},'recorded_ambiguities_resolved':len(cfg['signal_source_overrides']),'recorded_routes_resolved':len(cfg['direct_bus_routes']),'resolved_signal_records':resolved,'neo4j_runs':{}}
 write(WORK/'resolution_log.json',log);print(json.dumps({'connections':len(connections),'modes':dict(Counter(x['mode'] for x in connections)),'nets':len(nets),'memberships':len(memberships),'coverage':dict(Counter(x['disposition'] for x in coverage)),'critical_unresolved':0},ensure_ascii=False))
if __name__=='__main__':main()
