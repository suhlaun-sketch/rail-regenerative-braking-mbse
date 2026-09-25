from common import sid

def build(model):
    lines=["package PortDefinitions {", "    private import ItemDefinitions::*;"]
    for r in model["items"]:
        pt=sid("PT",r["port_type_id"]); item=sid("I",r["item_code"])
        direction="inout" if model["item_is_physical"][r["item_code"]] else "out"
        lines += [f"    port def {pt} {{", f"        {direction} item payload : {item};", "    }"]
    lines.append("}")
    return "\n".join(lines)+"\n"

