from common import sid

def build(model):
    lines=["package FunctionAllocations {", "    private import FunctionDefinitions::*;", "    private import ProductDefinitions::*;"]
    for f in model["functions"]: lines.append(f"    action {sid('fu',f['function_id'])} : {sid('FN',f['function_id'])};")
    used=sorted({str(a["product_code"]) for a in model["allocations"]})
    for code in used: lines.append(f"    part {sid('ap',code)} : {sid('P',code)};")
    for a in model["allocations"]: lines.append(f"    allocation {sid('alloc',a['allocation_id'])} allocate {sid('fu',a['function_id'])} to {sid('ap',a['product_code'])};")
    lines.append("}")
    return "\n".join(lines)+"\n"

