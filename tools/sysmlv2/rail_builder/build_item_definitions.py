from common import q, sid

def build(model):
    lines=["package ItemDefinitions {", "    private import ScalarValues::*;"]
    for r in model["items"]:
        name=sid("I",r["item_code"])
        lines += [f"    item def {name} {{", f"        attribute itemCode : String = {q(r['item_code'])};",
                  f"        attribute chineseName : String = {q(r.get('name_cn'))};", f"        attribute englishName : String = {q(r.get('name_en'))};",
                  f"        attribute family : String = {q(r.get('family'))};", f"        attribute domain : String = {q(r.get('domain'))};",
                  f"        attribute datatype : String = {q(r.get('datatype'))};", f"        attribute unitOrMedium : String = {q(r.get('unit_medium'))};",
                  f"        attribute semanticDefinition : String = {q(r.get('semantic_definition'))};", f"        attribute aliases : String = {q(r.get('aliases'))};",
                  f"        attribute priority : String = {q(r.get('priority'))};", f"        attribute validityRule : String = {q(r.get('validity_rule'))};",
                  f"        attribute faultStrategy : String = {q(r.get('fault_strategy'))};", "    }"]
    lines.append("}")
    return "\n".join(lines)+"\n"
