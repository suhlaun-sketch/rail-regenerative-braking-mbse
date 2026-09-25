from common import q, sid

def build(model, traces):
    lines=["package Traceability {", "    private import ScalarValues::*;", "    item def TraceRecord { attribute elementId : String; attribute sourceFile : String; attribute sourceSheet : String; attribute sourceRow : Integer; }"]
    for t in traces:
        lines += [f"    item {sid('trace',t['SysML_Element_ID'],True)} : TraceRecord {{", f"        attribute :>> elementId = {q(t['SysML_Element_ID'])};",
                  f"        attribute :>> sourceFile = {q(t.get('Source_File'))};", f"        attribute :>> sourceSheet = {q(t.get('Source_Sheet'))};",
                  f"        attribute :>> sourceRow = {int(t.get('Source_Row') or 0)};", "    }"]
    lines.append("}")
    return "\n".join(lines)+"\n"

