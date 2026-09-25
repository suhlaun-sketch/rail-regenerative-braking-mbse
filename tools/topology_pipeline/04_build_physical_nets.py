"""Build explicit physical nets without pairwise cliques."""
from common import *
def main():
 g=graph();products,_,_,by_product,_=indexes(g);roles={x['product_code']:x['derived_role'] for x in read(WORK/'product_role_map.json')['roles']};nets=[]
 def add(net_id,item,selectors,kind,observation=None):
  members=[]
  for code,term,participation in selectors:
   x=port(code,item,term,g=g);members.append({'port_id':x['port_id'],'product_code':code,'product_role':roles[code],'participation':participation})
  nets.append({'net_id':net_id,'connection_mode':'NET','net_kind':kind,'item_code':item,'interface_type_id':members and port(members[0]['product_code'],item,next((t for c,t,p in selectors if c==members[0]['product_code']),None),g=g)['interface_type_id'],'observation':observation,'members':members,'pairwise_clique_generated':False})
 add('NET-DC-LINK-01','ITM-PHY-003',[(c,None,'TAP' if c=='X113' else 'ENERGY') for c in ['5121','5122','5131','5132','5142','X111','X113']],'shared DC Link','U_dc')
 add('NET-STORAGE-DC-BUS-01','ITM-PHY-016',[('X111',None,'ENERGY'),('X113',None,'TAP'),('X131','母线段','ENERGY'),('X132','预充输入段','ENERGY')],'storage DC upstream bus')
 add('NET-STORAGE-DC-AFTER-CONTACTOR-01','ITM-PHY-016',[('X131','负载段','ENERGY'),('X132','预充输出段','ENERGY'),('X133','保护输入段','ENERGY')],'storage DC protected intermediate bus')
 add('NET-STORAGE-DC-SC-01','ITM-PHY-016',[('X133','保护输出段','ENERGY'),('X121',None,'ENERGY'),('X122',None,'TAP'),('X123',None,'TAP')],'supercapacitor terminal net','U_sc')
 add('NET-PNEU-MAIN-01','ITM-PHY-008',[(x['product_code'],x['port_name'],'TAP' if roles[x['product_code']]=='SENSOR_TAP' else 'FLOW') for x in sorted([p for p in active_ports(g) if p['item_code']=='ITM-PHY-008'],key=lambda z:z['port_id'])],'main reservoir shared pneumatic net')
 add('NET-PNEU-BRAKE-SUPPLY-01','ITM-PHY-009',[(x['product_code'],x['port_name'],'TAP' if roles[x['product_code']]=='SENSOR_TAP' else 'FLOW') for x in sorted([p for p in active_ports(g) if p['item_code']=='ITM-PHY-009'],key=lambda z:z['port_id'])],'brake supply pneumatic net')
 add('NET-PNEU-CYLINDER-01','ITM-PHY-010',[(x['product_code'],x['port_name'],'TAP' if roles[x['product_code']]=='SENSOR_TAP' else 'FLOW') for x in sorted([p for p in active_ports(g) if p['item_code']=='ITM-PHY-010'],key=lambda z:z['port_id'])],'cylinder/control pressure candidate net')
 add('NET-LVDC-CONTROL-01','ITM-PHY-015',[(x['product_code'],x['port_name'],'LOAD') for x in sorted([p for p in active_ports(g) if p['item_code']=='ITM-PHY-015'],key=lambda z:z['port_id'])],'low-voltage control supply net')
 add('NET-MAIN-RETURN-01','ITM-PHY-011',[(x['product_code'],x['port_name'],'RETURN') for x in sorted([p for p in active_ports(g) if p['item_code']=='ITM-PHY-011'],key=lambda z:z['port_id'])],'traction return/ground candidate net')
 write(WORK/'candidate_nets.json',{'meta':freeze_snapshot()|{'net_count':len(nets),'member_count':sum(len(x['members']) for x in nets)},'nets':nets});print(json.dumps({'nets':len(nets),'members':sum(len(x['members']) for x in nets)},ensure_ascii=False))
if __name__=='__main__':main()
