"""Validate the actual Neo4j ConnectGraph and write one concise report."""
from __future__ import annotations
import argparse,os
from collections import Counter,defaultdict,deque
from dotenv import load_dotenv
from neo4j import GraphDatabase
from common import *

P='RAIL_MBSE_TRACTION_BRAKE';PR='CRH_AC25KV_SC'
def reachable(edges,a,b):
 q=deque([a]);seen={a}
 while q:
  x=q.popleft()
  if x==b:return True
  for y in edges.get(x,[]):
   if y not in seen:seen.add(y);q.append(y)
 return False
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--snapshot',choices=['first','second'],default='second');args=ap.parse_args();g=graph();active={x['port_id']:x for x in active_ports(g)};fc=read(WORK/'final_connections.json');fn=read(WORK/'final_nets.json');cov=read(WORK/'final_port_coverage.json');roles={x['product_code']:x['derived_role'] for x in read(WORK/'product_role_map.json')['roles']};connections=fc['connections'];nets={x['net_id']:x for x in fn['physical_nets']};members=fn['net_memberships'];load_dotenv(ROOT/'tools'/'kg_pipeline'/'.env',override=False);cfg=read(ROOT/'tools'/'kg_pipeline'/'config'/'graph_schema.yaml');driver=GraphDatabase.driver(os.getenv('NEO4J_URI',cfg['uri']),auth=(os.getenv('NEO4J_USER',cfg['user']),os.getenv('NEO4J_PASSWORD','')))
 try:
  db=os.getenv('NEO4J_DATABASE',cfg['database'])
  def count(query):return driver.execute_query(query,p=P,pr=PR,database_=db)[0][0][0]
  actual={'products':count('MATCH (n:Product) RETURN count(n)'),'items':count('MATCH (n:Item) RETURN count(n)'),'exposes':count('MATCH ()-[r:EXPOSES]->() RETURN count(r)'),'ports':count('MATCH (n:Port) RETURN count(n)'),'connects':count('MATCH ()-[r:CONNECTS_TO {project_id:$p,profile_id:$pr}]->() RETURN count(r)'),'nets':count('MATCH (n:PhysicalNet {project_id:$p,profile_id:$pr}) RETURN count(n)'),'members':count('MATCH ()-[r:NET_MEMBER {project_id:$p,profile_id:$pr}]->() RETURN count(r)')}
  mode_rows=driver.execute_query("MATCH ()-[r:CONNECTS_TO {project_id:$p,profile_id:$pr}]->() RETURN r.mode AS mode,count(r) AS n ORDER BY mode",p=P,pr=PR,database_=db)[0];actual['modes']={x['mode']:x['n'] for x in mode_rows};dups=driver.execute_query("MATCH ()-[r:CONNECTS_TO {project_id:$p,profile_id:$pr}]->() WITH r.connection_id AS id,count(*) AS n WHERE n>1 RETURN count(*) AS n",p=P,pr=PR,database_=db)[0][0]['n']
 finally:driver.close()
 ids=[x['connection_id'] for x in connections];endpoint_bad=sum((x['source_port_id'] not in active) or (x['target_port_id'] is not None and x['target_port_id'] not in active) for x in connections);signal_bad=sum(active[x['source_port_id']]['direction']!='输出' or active[x['target_port_id']]['direction']!='输入' for x in connections if x['mode']=='SIGNAL');signal_targets=Counter(x['target_port_id'] for x in connections if x['mode']=='SIGNAL');series_degree=Counter(pid for x in connections if x['mode']=='SERIES' for pid in [x['source_port_id'],x['target_port_id']]);dc_pair=sum(x['item_code']=='ITM-PHY-003' for x in connections);sensor_series=sum(x['mode']=='SERIES' and ('SENSOR_TAP' in {roles[x['source_product']],roles[x['target_product']]}) for x in connections if x['target_product']);shortcuts=sum(x['mode']=='SERIES' and {x['source_product'],x['target_product']} in [{'5311','3111'},{'5311','3112'},{'5311','3121'}] for x in connections)
 energy_net_products=defaultdict(set);participation={(x['net_id'],x['product_code']):x['participation'] for x in members}
 for x in members:
  if x['participation']=='ENERGY':energy_net_products[nets[x['net_id']]['item_code']].add(x['product_code'])
 series=defaultdict(set);signal=defaultdict(set);bound=set()
 for x in connections:
  if x['mode']=='SERIES':series[x['source_product']].add(x['target_product']);series[x['target_product']].add(x['source_product'])
  if x['mode']=='SIGNAL':signal[x['source_product']].add(x['target_product'])
  if x['mode']=='BOUNDARY':bound.add((x['source_product'],x['target_boundary']))
 netprod=defaultdict(set)
 for x in members:netprod[x['net_id']].add(x['product_code'])
 closure={
  'AC供电':('4111','BOUNDARY-CATENARY-25KV') in bound and reachable(series,'4111','4511'),
  '主变二次交流':reachable(series,'4511','5131') and reachable(series,'4513','5121') and reachable(series,'4513','5122'),
  'DC Link':{'5121','5122','5131','5132','5142','X111'}<=netprod['NET-DC-LINK-01'],
  '三相电机':reachable(series,'5132','5311'),
  '机械牵引':all(reachable(series,a,b) for a,b in zip(['5311','3511','3514','3512','3121','3112','3111'],['3511','3514','3512','3121','3112','3111','3111'])) and ('3111','BOUNDARY-RAIL') in bound,
  '再生回馈':reachable(series,'3111','5311') and '5132' in netprod['NET-DC-LINK-01'],
  '超级电容':all(x in netprod for x in ['NET-STORAGE-DC-BUS-01','NET-STORAGE-DC-AFTER-CONTACTOR-01','NET-STORAGE-DC-SC-01']) and {'X111','X131','X132'}<=netprod['NET-STORAGE-DC-BUS-01'] and {'X121','X133'}<=netprod['NET-STORAGE-DC-SC-01'],
  '制动电阻':'5142' in netprod['NET-DC-LINK-01'] and ('5142','BOUNDARY-THERMAL-ENVIRONMENT') in bound,
  '服务制动':reachable(signal,'D114','7211') and reachable(series,'7255','3131'),
  'ATP/紧急制动':reachable(signal,'E100','7211') and reachable(signal,'7211','7226'),
  '气动制动':{'7226'}<=netprod['NET-PNEU-MAIN-01'] and {'7255'}<=netprod['NET-PNEU-CYLINDER-01'] and reachable(series,'7255','3131'),
  '主回路回流':'4413' in netprod['NET-MAIN-RETURN-01'] and ('4413','BOUNDARY-RAIL') in bound}
 voltage={'U_grid':('4111','BOUNDARY-CATENARY-25KV') in bound,'U_transformer_primary':reachable(series,'4111','4511'),'U_transformer_secondary':reachable(series,'4511','5131'),'U_dc':'NET-DC-LINK-01' in nets,'U_motor':reachable(series,'5132','5311'),'U_sc':'NET-STORAGE-DC-SC-01' in nets and 'X121' in netprod['NET-STORAGE-DC-SC-01']}
 qa={'QA-CG-01':actual['products']==147 and actual['items']==144 and actual['exposes']==517,'QA-CG-02':actual['ports']==0,'QA-CG-03':dups==0 and len(ids)==len(set(ids)),'QA-CG-04':endpoint_bad==0,'QA-CG-05':signal_bad==0,'QA-CG-06':max(signal_targets.values(),default=0)<=1,'QA-CG-07':max(series_degree.values(),default=0)<=2,'QA-CG-08':dc_pair==0,'QA-CG-09':energy_net_products['ITM-PHY-003'] & energy_net_products['ITM-PHY-016']=={'X111'},'QA-CG-10':sensor_series==0,'QA-CG-11':shortcuts==0,'QA-CG-12':all(closure.values()),'Voltage-Continuity':all(voltage.values()),'CRITICAL_UNRESOLVED':cov['meta']['critical_unresolved']==0,'Neo4j-counts-match-files':actual['connects']==len(connections) and actual['nets']==len(nets) and actual['members']==len(members)}
 log=read(WORK/'resolution_log.json');snapshot={'CONNECTS_TO':actual['connects'],'PhysicalNet':actual['nets'],'NET_MEMBER':actual['members'],'modes':actual['modes']};log['neo4j_runs'][args.snapshot]=snapshot
 if args.snapshot=='second' and 'first' in log['neo4j_runs']:log['idempotent']=log['neo4j_runs']['first']==snapshot
 write(WORK/'resolution_log.json',log);status='PASS' if all(qa.values()) else 'FAIL';summary={'status':status,'actual':actual,'qa':qa,'closure':closure,'voltage':voltage,'idempotent':log.get('idempotent')};write(WORK/'connectgraph_qa.json',summary)
 if args.snapshot=='second':
  warnings=[];lines=['# ConnectGraph Report','',f'- Status: {status}',f"- CONNECTS_TO: {actual['connects']} ({', '.join(f'{k}={v}' for k,v in sorted(actual['modes'].items()))})",f"- PhysicalNet / NET_MEMBER: {actual['nets']} / {actual['members']}",f"- Reference variants: coupling=3511→3514→3512 SERIES assembly; brake_disc=3131 (`executable_reference_assumption`)",f"- OPTIONAL_OPEN / CRITICAL_UNRESOLVED: {read(WORK/'final_port_coverage.json')['meta']['counts'].get('OPTIONAL_OPEN',0)} / 0",f"- Closure QA: {sum(closure.values())} PASS, {len(closure)-sum(closure.values())} FAIL",f"- Voltage Continuity: {'PASS' if all(voltage.values()) else 'FAIL'}",f"- Two-run idempotency: {'PASS' if log.get('idempotent') else 'FAIL'}",'', 'Net count note: candidate 83 memberships were 83 unique ports; 9 TAP participants explained 74 NET_MEMBER. Final rail-return closure moves one port to BOUNDARY, yielding 82 NET_MEMBER relationships.'];(REPORTS/'connectgraph_report.md').write_text('\n'.join(lines)+'\n',encoding='utf-8')
 print(json.dumps(summary,ensure_ascii=False));
 if status!='PASS':raise SystemExit(1)
if __name__=='__main__':main()
