"""Shared read-only KG input and deterministic topology helpers."""
from __future__ import annotations
import hashlib,json,sys
from collections import defaultdict
from pathlib import Path

ROOT=Path(__file__).resolve().parents[2]
HERE=Path(__file__).resolve().parent
KG_DATA=ROOT/'tools'/'kg_pipeline'/'work'/'graph_data.json'
CONFIG=HERE/'config'
WORK=HERE/'work'
REPORTS=ROOT/'reports'
for _stream in (sys.stdout,sys.stderr):
 _reconfigure=getattr(_stream,'reconfigure',None)
 if _reconfigure:_reconfigure(encoding='utf-8',errors='replace')

def read(path): return json.loads(Path(path).read_text(encoding='utf-8'))
def write(path,data):
 p=Path(path);p.parent.mkdir(parents=True,exist_ok=True);p.write_text(json.dumps(data,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
def sha(path): return hashlib.sha256(Path(path).read_bytes()).hexdigest()
def graph(): return read(KG_DATA)
def rules(): return read(CONFIG/'topology_rules.yaml')
def variants(): return read(CONFIG/'variant_groups.yaml')
def active_ports(g=None): return [x for x in (g or graph())['exposes'] if x['profile_active']]
def indexes(g=None):
 g=g or graph(); products={x['code']:x for x in g['products']}; items={x['item_code']:x for x in g['items']}; ports={x['port_id']:x for x in active_ports(g)}; by_product=defaultdict(list);by_item=defaultdict(list)
 for x in ports.values(): by_product[x['product_code']].append(x);by_item[x['item_code']].append(x)
 return products,items,ports,by_product,by_item

SIDE_TERMS=['输入侧','输出侧','进线侧','出线侧','一次侧','二次侧','高压侧','低压侧','高速轴侧','低速轴侧','高速轴','低速轴','电机侧','齿轮箱侧','母线侧','负载侧','受流侧','导流侧','接触面','导流端','传动段','轮对段','第一连接面','第二连接面','第一轴端','第二轴端','第一测量端','第二测量端','保护输入段','保护输出段','预充输入段','预充输出段']
def local_sides(name): return [x for x in SIDE_TERMS if x in name]
def port(code,item,contains=None,exclude=None,g=None):
 _,_,_,by_product,_=indexes(g); xs=[x for x in by_product.get(code,[]) if x['item_code']==item and (not contains or contains in x['port_name']) and (not exclude or exclude not in x['port_name'])]
 if len(xs)!=1: raise ValueError(f'port selector must be unique: {code}/{item}/{contains!r}/{exclude!r}, got {len(xs)}')
 return xs[0]
def cid(mode,a,b): return f"CAND::{mode}::{a}::{b}"
def top_domain(code): return code[0]
def level2_code(code,products):
 cur=products[code]
 while cur['level']>2:cur=products[cur['parent_code']]
 return cur['code']
def system_pair_allowed(a,b,products,cfg):
 x,y=level2_code(a,products),level2_code(b,products)
 return x==y or '-'.join(sorted((x,y))) in {'-'.join(sorted(z.split('-',1))) for z in cfg['allowed_level2_pairs']}
def is_signal(x): return x['port_category']=='信号'
def is_physical(x): return x['port_category']=='物理'
def freeze_snapshot():
 g=graph();a=active_ports(g)
 return {'kg_sha256':sha(KG_DATA),'Product':len(g['products']),'Item':len(g['items']),'Profile':1,'CONTAINS':len(g['contains']),'EXPOSES':len(g['exposes']),'Active_EXPOSES':len(a),'Inactive_EXPOSES':len(g['exposes'])-len(a),'Port_nodes':0}
