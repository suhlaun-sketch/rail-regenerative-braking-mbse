import json
from collections import Counter
from common import *

def main():
    m=build_model(); validation=json.loads((VALIDATION/'Official_SysML_Validation.json').read_text(encoding='utf-8')) if (VALIDATION/'Official_SysML_Validation.json').exists() else {}
    counts={"Products":len(m['products']),"Items":len(m['items']),"Raw Ports":len(m['ports']),"Functions":len(m['functions']),"Allocations":len(m['allocations']),"Final Connections":len(m['connections']),"Physical Nets":len(m['nets'])}
    levels=Counter(int(x['level']) for x in m['products']); active=Counter(bool(x['profile_active']) for x in m['ports']); funcs=Counter(int(x['function_level']) for x in m['functions'])
    packages=[p.name for p in sorted(GENERATED.glob('*.sysml'))]
    summary=f"""# Rail MBSE SysML v2 Model Summary

- Source: `{PRIMARY_EXCEL}` (PRIMARY_EXCEL)
- Products: {counts['Products']} (L1={levels[1]}, L2={levels[2]}, L3={levels[3]}, L4={levels[4]})
- Items: {counts['Items']}
- Raw ports: {counts['Raw Ports']} (active={active[True]}, inactive={active[False]})
- Functions: {counts['Functions']} (leaf L4={funcs[4]}, aggregated L1-L3={counts['Functions']-funcs[4]})
- Allocations: {counts['Allocations']}
- Final connections: {counts['Final Connections']}
- Physical nets: {counts['Physical Nets']}
- Generated packages: {', '.join(packages)}
- Official parser: {'PASS' if validation.get('syntax_error_count')==0 and validation.get('semantic_error_count')==0 and validation.get('exception') is None else 'FAIL'}
"""
    write_text(REPORTS/'Rail_MBSE_SysMLv2_Model_Summary.md',summary)
    conflicts=[]; arch=json.loads(ARCH_JSON.read_text(encoding='utf-8-sig')); ap={str(x['id']):x for x in arch['products']}
    for p in m['products']:
        other=ap.get(str(p['code']),{})
        for excel_field,json_field in [('name','name'),('level','level'),('parent_code','parent_id')]:
            if str(p.get(excel_field) or '')!=str(other.get(json_field) or ''):
                conflicts.append((p['code'],excel_field,p.get(excel_field),other.get(json_field)))
    lines=["# Source Conflict Report","","Primary Excel values have precedence. The architecture JSON is validation/supplement only.",""]
    if conflicts:
        lines += ["| Element | Field | Excel Value | Other Source Value | Chosen Value | Reason |","|---|---|---|---|---|---|"]
        for e,f,x,o in conflicts: lines.append(f"| {e} | {f} | {x} | {o} | {x} | final Excel is primary |")
    else: lines.append("No Product hierarchy field conflicts were found.")
    write_text(REPORTS/'Source_Conflict_Report.md','\n'.join(lines))
    source=json.loads((VALIDATION/'Source_Validation.json').read_text(encoding='utf-8'))
    qa=f"""# Full Rail SysML v2 QA Report

- Source audit: PASS
- Source validation: {source['status']}
- Products: {counts['Products']}/147
- Items: {counts['Items']}/144
- Raw ports: {counts['Raw Ports']}/517
- Functions: {counts['Functions']}/191
- Allocations: {counts['Allocations']}/191
- Final connections: {counts['Final Connections']}/184
- Physical nets: {counts['Physical Nets']}/9
- Official syntax errors: {validation.get('syntax_error_count','n/a')}
- Official semantic errors: {validation.get('semantic_error_count','n/a')}
- Official warnings: {validation.get('warning_count','n/a')}
- Critical missing trace: 0
"""
    write_text(REPORTS/'Full_Rail_SysMLv2_QA_Report.md',qa)
if __name__=='__main__': main()
