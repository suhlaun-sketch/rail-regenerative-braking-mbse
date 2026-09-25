from common import bool_lit, q, sid

def _port_type(model, port):
    pt=sid("PT",port["port_type_id"])
    if model["item_is_physical"][port["item_code"]]: return pt
    return "~"+pt if str(port.get("direction"))=="输入" else pt

def build(model):
    lines=["package ProductDefinitions {", "    private import ScalarValues::*;", "    private import GeneralDefinitions::*;", "    private import PortDefinitions::*;"]
    for p in sorted(model["products"], key=lambda x:(-int(x["level"]),str(x["code"]))):
        code=str(p["code"]); lines += [f"    part def {p['sysml_def']} {{", f"        attribute productCode : String = {q(code)};",
            f"        attribute chineseName : String = {q(p.get('name'))};", f"        attribute level : Integer = {int(p['level'])};",
            f"        attribute parentCode : String = {q(p.get('parent_code'))};", f"        attribute role : String = {q(p.get('source_type'))};",
            f"        attribute sourceType : String = {q(p.get('source_type'))};", f"        attribute selected : Boolean = {bool_lit(p.get('selected'))};",
            f"        attribute leaf : Boolean = {bool_lit(p.get('leaf'))};"]
        for child in model["children"].get(code,[]): lines.append(f"        part {sid('p',child)} : {sid('P',child)};")
        for port in sorted(model["ports_by_product"].get(code,[]),key=lambda x:x["port_id"]):
            lines += [f"        port {port['sysml_name']} : {_port_type(model,port)} {{",
                      f"            attribute sourcePortId : String = {q(port['port_id'])};",
                      f"            attribute portName : String = {q(port.get('port_name'))};",
                      f"            attribute direction : String = {q(port.get('direction'))};",
                      f"            attribute activeStatus : Boolean = {bool_lit(port.get('profile_active'))};", "        }"]
        lines.append("    }")
    for b in model["boundaries"]:
        lines += [f"    part def {b['sysml_def']} :> ExternalBoundaryBase {{", f"        attribute boundaryId : String = {q(b['boundary_id'])};",
                  f"        attribute boundaryName : String = {q(b.get('name'))};", f"        attribute domain : String = {q(b.get('domain'))};"]
        for bp in sorted((x for x in model["boundary_ports"] if x["boundary_id"]==b["boundary_id"]),key=lambda x:x["item_code"]):
            item=model["item_by_code"][bp["item_code"]]; lines.append(f"        port {bp['sysml_name']} : {sid('PT',item['port_type_id'])};")
        lines.append("    }")
    lines += ["    part def RailSystemContext {"]
    for p in sorted((x for x in model["products"] if not x.get("parent_code")),key=lambda x:str(x["code"])): lines.append(f"        part {p['sysml_usage']} : {p['sysml_def']};")
    for b in model["boundaries"]: lines.append(f"        part {b['sysml_usage']} : {b['sysml_def']};")
    lines += ["    }", "}"]
    return "\n".join(lines)+"\n"

