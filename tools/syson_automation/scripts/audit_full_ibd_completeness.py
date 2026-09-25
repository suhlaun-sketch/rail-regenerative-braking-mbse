"""Compare formal container IBD query-back against frozen leaf-interface ancestry."""
from __future__ import annotations
import json,re
from collections import Counter
from pathlib import Path

ROOT=Path(__file__).resolve().parents[3]
HIER=ROOT/'work/reports/FULL_PRODUCT_HIERARCHY.json'
FROZEN=ROOT/'work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml'
VIEWS=ROOT/'work/reports/FULL_SYSON_VIEW_REGISTRY.json'
OUT=ROOT/'work/reports/FULL_IBD_COMPLETENESS.json'

def main():
    hierarchy=json.loads(HIER.read_text(encoding='utf-8'))
    views=json.loads(VIEWS.read_text(encoding='utf-8')) if VIEWS.exists() else {}
    products={x['product_code']:x for x in hierarchy['products']}
    usage_to_code={x['usage_id']:x['product_code'] for x in hierarchy['products']}
    evidence=[]
    pattern=r'(?m)^\s*interface\s+(c_CG_[A-Za-z0-9_]+)\s*:\s*([A-Za-z0-9_]+)\s+connect\s+([A-Za-z0-9_.]+)\s+to\s+([A-Za-z0-9_.]+)'
    for match in re.finditer(pattern,FROZEN.read_text(encoding='utf-8')):
        name,itype,source,target=match.groups()
        def codes(path): return [usage_to_code[x] for x in path.split('.')[:-1] if x in usage_to_code]
        sc,tc=codes(source),codes(target)
        evidence.append((name,itype,sc,tc))
    rows=[]
    for code in hierarchy['container_codes']:
        parent=products[code]
        internal=[]; external=[]
        for name,itype,sc,tc in evidence:
            if code in sc and code in tc:
                s=sc[sc.index(code)+1:]; t=tc[tc.index(code)+1:]
                if s and t and s[0]!=t[0]: internal.append(name)
            elif code in sc or code in tc:
                external.append(name)
        view=views.get('AUTO_IBD_'+code)
        rows.append({'product_code':code,'level':parent['level'],'direct_child_count':len(parent['direct_children']),
                     'expected_internal_evidence_count':len(internal),'internal_interface_refs':internal,
                     'external_leaf_evidence_count':len(external),'representation_id':view.get('representation_id') if view else None,
                     'node_count':view.get('node_count') if view else None,'edge_count':view.get('edge_count') if view else None,
                     'status':view.get('status') if view else 'MISSING'})
    unresolved=[x['product_code'] for x in rows if x['expected_internal_evidence_count']>0 and (x['edge_count'] or 0)==0]
    missing=[x['product_code'] for x in rows if x['status']!='PASS']
    result={'expected_container_count':len(rows),'view_count':len(rows)-len(missing),
            'missing_view_codes':missing,'real_internal_but_zero_graphical_edge':unresolved,
            'total_graphical_edges':sum(x['edge_count'] or 0 for x in rows),
            'views_by_level':dict(Counter(x['level'] for x in rows if x['status']=='PASS')),
            'rows':rows}
    OUT.write_text(json.dumps(result,ensure_ascii=False,indent=2),encoding='utf-8')
    print('IBD_AUDIT',len(rows)-len(missing),'/',len(rows),'MISSING',len(missing),'REAL_INTERNAL_ZERO',len(unresolved),unresolved[:12])

if __name__=='__main__': main()
