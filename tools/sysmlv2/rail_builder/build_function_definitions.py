from collections import defaultdict
from common import q, sid

def build(model):
    port_by_inst={p["interface_instance_id"]:p for p in model["ports"]}; rel=defaultdict(list)
    for m in model["function_interfaces"]:
        p=port_by_inst.get(m["interface_instance_id"])
        if p: rel[m["function_id"]].append((m,p))
    lines=["package FunctionDefinitions {", "    private import ScalarValues::*;", "    private import ItemDefinitions::*;"]
    for f in model["functions"]:
        lines += [f"    action def {sid('FN',f['function_id'])} {{", f"        attribute functionId : String = {q(f['function_id'])};",
                  f"        attribute chineseName : String = {q(f.get('function_name_cn'))};", f"        attribute englishName : String = {q(f.get('function_name_en'))};",
                  f"        attribute functionLevel : Integer = {int(f['function_level'])};", f"        attribute category : String = {q(f.get('function_category'))};",
                  f"        attribute allocatedProductCode : String = {q(f.get('owner_product_code'))};"]
        seen=set()
        for m,p in rel.get(f["function_id"],[]):
            key=p["item_code"]
            if key in seen: continue
            seen.add(key); direction="inout" if model["item_is_physical"][key] else ("in" if str(p.get("direction"))=="输入" else "out")
            lines.append(f"        {direction} item {sid('used',key)} : {sid('I',key)};")
        lines.append("    }")
    lines.append("}")
    return "\n".join(lines)+"\n"

