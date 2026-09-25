from common import q, sid

def build(model):
    lines=["package SystemDefinition {", "    private import ScalarValues::*;", "    private import InterfaceDefinitions::*;", "    private import ProductDefinitions::*;",
           "    part railSystem : RailSystemContext {"]
    for c in model["connections"]:
        it=sid("IF",c["interface_type_id"])
        lines += [f"        interface {c['sysml_name']} : {it} connect {c['source_path']} to {c['target_path']} {{",
                  f"            attribute connectionId : String = {q(c['connection_id'])};", f"            attribute connectionType : String = {q(c.get('mode'))};",
                  f"            attribute originalPath : String = {q(c['original_path'])};", "        }"]
    lines += ["    }", "}"]
    return "\n".join(lines)+"\n"

