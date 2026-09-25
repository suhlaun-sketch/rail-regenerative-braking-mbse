from collections import defaultdict
from common import q, sid

def build(model):
    members=defaultdict(list)
    for m in model["net_members"]:
        port=model["port_by_id"][m["port_id"]]
        members[m["net_id"]].append(model["product_by_code"][str(m["product_code"])]["sysml_path"]+"."+port["sysml_name"])
    lines=["package PhysicalNetworks {", "    private import ScalarValues::*;", "    private import ProductDefinitions::*;", "    part physicalNetworkContext : RailSystemContext {"]
    for n in model["nets"]:
        endpoints=", ".join(sorted(members[n["net_id"]]))
        lines += [f"        connection {sid('net',n['net_id'])} connect ({endpoints}) {{",
                  f"            attribute netId : String = {q(n['net_id'])};", f"            attribute itemCode : String = {q(n['item_code'])};", "        }"]
    lines += ["    }", "}"]
    return "\n".join(lines)+"\n"

