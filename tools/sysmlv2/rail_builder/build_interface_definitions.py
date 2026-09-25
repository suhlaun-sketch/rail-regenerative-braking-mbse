from common import sid

def build(model):
    lines=["package InterfaceDefinitions {", "    private import ItemDefinitions::*;", "    private import PortDefinitions::*;"]
    for r in model["items"]:
        it=sid("IF",r["interface_type_id"]); pt=sid("PT",r["port_type_id"]); item=sid("I",r["item_code"])
        target=pt if model["item_is_physical"][r["item_code"]] else "~"+pt
        lines += [f"    interface def {it} {{", f"        end source : {pt};", f"        end target : {target};",
                  f"        flow of {item} from source.payload to target.payload;", "    }"]
    lines.append("}")
    return "\n".join(lines)+"\n"

