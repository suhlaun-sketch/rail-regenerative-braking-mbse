"""Assign exactly one disposition to every Active EXPOSES port."""
from collections import Counter,defaultdict
from common import *
def main():
 g=graph();active=active_ports(g);cand=read(WORK/'candidate_connections.json');nets=read(WORK/'candidate_nets.json');refs=defaultdict(list);netmap={};netpart={}
 for n in nets['nets']:
  for m in n['members']:netmap[m['port_id']]=n['net_id'];netpart[m['port_id']]=m['participation']
 for c in cand['candidates']:
  refs[c['source_port_id']].append(c['candidate_id'])
  if c['target_port_id']:refs[c['target_port_id']].append(c['candidate_id'])
 unresolved_item={x['item_code'] for x in cand['unresolved_routes']};rows=[]
 for p in sorted(active,key=lambda x:x['port_id']):
  pid=p['port_id'];modes={next(c['connection_mode'] for c in cand['candidates'] if c['candidate_id']==r) for r in refs.get(pid,[])}
  if pid in netmap and netpart[pid]=='TAP':disp='TAP_CONNECTED';reason='non-intrusive member of '+netmap[pid]
  elif pid in netmap:disp='NET_MEMBER';reason='member of '+netmap[pid]
  elif 'BOUNDARY' in modes:disp='EXTERNAL_BOUNDARY';reason='mapped to explicit external boundary'
  elif 'TAP' in modes:disp='TAP_CONNECTED';reason='non-intrusive sensor tap candidate'
  elif refs.get(pid):disp='CONNECTED';reason='covered by hard-rule candidate'
  elif p['item_code'] in unresolved_item:disp='UNRESOLVED';reason='I/O deployment route unresolved; direct bypass suppressed'
  elif p['direction']=='输出':disp='OPTIONAL_OPEN';reason='producer telemetry/status has no unambiguous required consumer in current Profile'
  else:disp='UNRESOLVED';reason='no hard-rule-safe unique topology disposition'
  rows.append({'port_id':pid,'product_code':p['product_code'],'port_name':p['port_name'],'item_code':p['item_code'],'disposition':disp,'reason':reason,'candidate_refs':refs.get(pid,[]),'net_id':netmap.get(pid)})
 counts=Counter(x['disposition'] for x in rows);out={'meta':freeze_snapshot()|{'total_active_ports':len(rows),'coverage_counts':dict(counts)},'coverage':rows,'unresolved':[x for x in rows if x['disposition']=='UNRESOLVED']};write(WORK/'port_coverage.json',out);print(json.dumps({'total':len(rows),'counts':dict(counts),'unresolved':len(out['unresolved'])},ensure_ascii=False))
if __name__=='__main__':main()
