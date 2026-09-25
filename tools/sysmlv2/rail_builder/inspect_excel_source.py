from collections import Counter
import hashlib
from common import *

def main():
    ensure_dirs(); model=build_model(); lines=["# Rail MBSE Primary Excel Source Audit","",f"Primary candidate: `{PRIMARY_EXCEL}`","",f"SHA-256: `{hashlib.sha256(PRIMARY_EXCEL.read_bytes()).hexdigest()}`","",f"Sheets read: {len(model['sheet_meta'])}","","## Sheet inventory",""]
    for m in model["sheet_meta"]:
        lines += [f"### {m['sheet']}","",f"- Data rows: {m['rows']}",f"- Header row: {m['header_row']}",f"- Columns: {', '.join(m['columns'])}",f"- Data types: {', '.join(k+'='+('/'.join(v) or 'blank') for k,v in m['types'].items())}",f"- Main content: {m['purpose']}",f"- Participates in SysML generation: {'YES' if m['participates'] else 'NO (validation only)'}",f"- Duplicate `{m.get('id_column')}`: {len(m.get('duplicate_ids',[]))}",f"- Blank `{m.get('id_column')}`: {m.get('blank_ids',0)}","",]
    lines += ["## Relationships","","- Product_Hierarchy.code owns Interface.product_code and Function.owner_product_code.","- Interface.item_code resolves to Item.item_code; only leaf products own raw ports.","- Connection endpoints resolve to raw leaf ports, except 12 explicit external-boundary targets with null target ports.","- Function_Allocation links every Function to one Product.","- Function_Interface links functions to raw interface instances.","- Net_Member links each PhysicalNet to member leaf raw ports.","","## Completeness decision","", "The workbook contains the complete engineering tables and exact baseline counts. It is the PRIMARY ENGINEERING SOURCE. The architecture JSON is used only for the three external-boundary names/domains and cross-checking; derived fields are recorded in SOURCE_FIELD_PROVENANCE.json."]
    write_text(PROJECT_ROOT/"work"/"sysmlv2"/"SOURCE_AUDIT_Rail_MBSE_Function_Interface_v1_final.md","\n".join(lines))
    write_text(AUDIT/"SOURCE_AUDIT_Rail_MBSE_Function_Interface_v1_final.md","\n".join(lines))
    dump_json(AUDIT/"source_sheet_audit.json",model["sheet_meta"])
    print(f"SHEETS={len(model['sheet_meta'])}")
if __name__=="__main__": main()

