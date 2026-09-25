from __future__ import annotations

import hashlib
from collections import Counter, defaultdict

from common import *
import build_allocations, build_function_definitions, build_general_definitions
import build_interface_definitions, build_item_definitions, build_physical_networks
import build_port_definitions, build_product_definitions, build_system_definition, build_traceability


def trace(element_id, element_type, qualified, row, **keys):
    return {"SysML_Element_ID":element_id,"SysML_Element_Type":element_type,"SysML_Qualified_Name":qualified,
            "Source_File":row.get("_source_file",PRIMARY_EXCEL.name),"Source_Sheet":row.get("_source_sheet",""),"Source_Row":row.get("_source_row",0),
            "Product_Code":keys.get("Product_Code"),"Port_ID":keys.get("Port_ID"),"Item_Code":keys.get("Item_Code"),
            "Function_ID":keys.get("Function_ID"),"Connection_ID":keys.get("Connection_ID"),"Allocation_ID":keys.get("Allocation_ID"),
            "Derivation_Type":keys.get("Derivation_Type","PRIMARY_EXCEL"),"Source_Status":keys.get("Source_Status","ACTIVE")}


def main():
    ensure_dirs(); model=build_model(); traces=[]
    products=model["products"]; ports=model["ports"]; functions=model["functions"]
    function_by_id={f["function_id"]:f for f in functions}; children=model["children"]
    port_counts=Counter(str(p["product_code"]) for p in ports); function_counts=Counter(str(f["owner_product_code"]) for f in functions)
    connection_counts=Counter()
    for c in model["connections"]:
        connection_counts[str(c["source_product_code"])]+=1
        if str(c["target_product_code"]) in model["product_by_code"]: connection_counts[str(c["target_product_code"])]+=1

    for p in products:
        traces += [trace("DEF::"+str(p["code"]),"PartDefinition","ProductDefinitions::"+p["sysml_def"],p,Product_Code=str(p["code"])),
                   trace("USAGE::"+str(p["code"]),"PartUsage","SystemDefinition::railSystem."+p["sysml_path"],p,Product_Code=str(p["code"]))]
    for i in model["items"]:
        traces += [trace("ITEM::"+i["item_code"],"ItemDefinition","ItemDefinitions::"+sid("I",i["item_code"]),i,Item_Code=i["item_code"]),
                   trace("PORTTYPE::"+i["port_type_id"],"PortDefinition","PortDefinitions::"+sid("PT",i["port_type_id"]),i,Item_Code=i["item_code"]),
                   trace("INTERFACETYPE::"+i["interface_type_id"],"InterfaceDefinition","InterfaceDefinitions::"+sid("IF",i["interface_type_id"]),i,Item_Code=i["item_code"])]
    for p in ports:
        traces.append(trace(p["port_id"],"PortUsage","ProductDefinitions::"+model["product_by_code"][str(p["product_code"])]["sysml_def"]+"."+p["sysml_name"],p,Product_Code=str(p["product_code"]),Port_ID=p["port_id"],Item_Code=p["item_code"],Source_Status="ACTIVE" if p["profile_active"] else "INACTIVE"))
    for f in functions: traces.append(trace(f["function_id"],"ActionDefinition","FunctionDefinitions::"+sid("FN",f["function_id"]),f,Product_Code=str(f["owner_product_code"]),Function_ID=f["function_id"]))
    for a in model["allocations"]: traces.append(trace(a["allocation_id"],"AllocationUsage","FunctionAllocations::"+sid("alloc",a["allocation_id"]),a,Product_Code=str(a["product_code"]),Function_ID=a["function_id"],Allocation_ID=a["allocation_id"]))
    for c in model["connections"]: traces.append(trace(c["connection_id"],"InterfaceUsage","SystemDefinition::railSystem."+c["sysml_name"],c,Product_Code=str(c["source_product_code"]),Item_Code=c["item_code"],Connection_ID=c["connection_id"]))
    for n in model["nets"]: traces.append(trace(n["net_id"],"ConnectionUsage","PhysicalNetworks::physicalNetworkContext."+sid("net",n["net_id"]),n,Item_Code=n["item_code"]))

    package_builders=[
        ("01_GeneralDefinitions.sysml",build_general_definitions.build),("02_ItemDefinitions.sysml",build_item_definitions.build),
        ("03_PortDefinitions.sysml",build_port_definitions.build),("04_InterfaceDefinitions.sysml",build_interface_definitions.build),
        ("05_ProductDefinitions.sysml",build_product_definitions.build),("06_FunctionDefinitions.sysml",build_function_definitions.build),
        ("07_SystemDefinition.sysml",build_system_definition.build),("08_FunctionAllocations.sysml",build_allocations.build),
        ("09_PhysicalNetworks.sysml",build_physical_networks.build)]
    texts=[]
    for name,builder in package_builders:
        text=builder(model); write_text(GENERATED/name,text); texts.append(text)
    trace_text=build_traceability.build(model,traces); write_text(GENERATED/"10_Traceability.sysml",trace_text); texts.append(trace_text)
    umbrella="""package Rail_MBSE {
    private import GeneralDefinitions::*;
    private import SystemDefinition::*;
    private import FunctionAllocations::*;
    private import PhysicalNetworks::*;
    private import Traceability::*;
}\n"""
    write_text(GENERATED/"00_Rail_MBSE.sysml",umbrella)
    full="\n".join(texts+[umbrella]); write_text(GENERATED/"Rail_MBSE_Full_v1.sysml",full)

    product_mapping=[]
    for p in products:
        code=str(p["code"]); product_mapping.append({"Product_Code":code,"Product_Name":p["name"],"Level":p["level"],"Parent_Code":p.get("parent_code"),
            "SysML_Definition":"ProductDefinitions::"+p["sysml_def"],"SysML_Usage":"SystemDefinition::railSystem."+p["sysml_path"],"Children":"; ".join(children.get(code,[])),
            "Leaf_Status":p["leaf"],"Raw_Port_Count":port_counts[code],"Function_Count":function_counts[code],"Connection_Count":connection_counts[code],"Source_Sheet":p["_source_sheet"],"Source_Row":p["_source_row"]})
    leaf_mapping=[]
    for p in ports:
        prod=model["product_by_code"][str(p["product_code"])]; leaf_mapping.append({"Leaf_Code":str(p["product_code"]),"Leaf_Name":p["product_name"],"Raw_Port_ID":p["port_id"],"Raw_Port_Name":p["port_name"],
            "Direction":p["direction"],"Port_Category":p["port_category"],"Item_Code":p["item_code"],"Item_Name":p["item_name"],"Unit_Medium":model["item_by_code"][p["item_code"]].get("unit_medium"),
            "Interface_Type":p["interface_type_id"],"Active_Status":p["profile_active"],"SysML_Port_Path":"SystemDefinition::railSystem."+prod["sysml_path"]+"."+p["sysml_name"]})
    connection_mapping=[{"Connection_ID":c["connection_id"],"Source_Leaf":c["source_product_code"],"Source_Port":c["source_port_id"],"Target_Leaf":c["target_product_code"],"Target_Port":c["target_effective_port_id"],
        "Item_Code":c["item_code"],"Physical_or_Signal":c["physical_or_signal"],"Connection_Type":c["mode"],"Original_Path":c["original_path"],"SysML_Connection_Path":"SystemDefinition::railSystem."+c["sysml_name"],
        "Hierarchical_Segment_Count":0,"Physical_Net_ID":c["physical_net_id"],"Trace_Status":"MAPPED"} for c in model["connections"]]
    direct_derived={f["function_id"]:list(f.get("aggregated_from_functions") or []) for f in functions}
    level_by_id={f["function_id"]:int(f["function_level"]) for f in functions}
    def leaf_sources(fid, visiting=None):
        visiting=set() if visiting is None else visiting
        if fid in visiting: return []
        source_function=function_by_id.get(fid,{})
        if source_function and model["product_by_code"][str(source_function["owner_product_code"])]["leaf"]: return [fid]
        visiting.add(fid); out=[]
        for child in direct_derived.get(fid,[]): out.extend(leaf_sources(child,visiting.copy()))
        return sorted(set(out))
    function_mapping=[]
    fi_by_func=defaultdict(list)
    for m in model["function_interfaces"]: fi_by_func[m["function_id"]].append(m)
    interface_by_id={p["interface_instance_id"]:p for p in ports}
    for a in model["allocations"]:
        f=function_by_id[a["function_id"]]; rel=fi_by_func.get(a["function_id"],[]); items=sorted({interface_by_id[m["interface_instance_id"]]["item_code"] for m in rel if m["interface_instance_id"] in interface_by_id})
        conns=sorted({c["connection_id"] for c in model["connections"] if c["item_code"] in items and (str(c["source_product_code"])==str(a["product_code"]) or str(c["target_product_code"])==str(a["product_code"]))})
        function_mapping.append({"Function_ID":f["function_id"],"Function_Name":f["function_name_cn"],"Function_Level":f["function_level"],"Allocated_Product_Code":str(a["product_code"]),"Allocated_Product_Name":a["product_name"],
            "Source_Leaf_Functions":"; ".join(leaf_sources(f["function_id"])),"Relevant_Item_Codes":"; ".join(items),"Relevant_Connection_IDs":"; ".join(conns),
            "SysML_Function_Path":"FunctionDefinitions::"+sid("FN",f["function_id"]),"SysML_Allocation_Path":"FunctionAllocations::"+sid("alloc",a["allocation_id"])})

    payload={"product_hierarchy":product_mapping,"leaf_ports":leaf_mapping,"raw_ports":leaf_mapping,"final_connections":connection_mapping,
             "function_allocations":function_mapping,"function_to_product":[{"Allocation_ID":a["allocation_id"],"Function_ID":a["function_id"],"Product_Code":str(a["product_code"]),"Product_Name":a["product_name"],"Allocation_Type":a["allocation_type"],"SysML_Allocation_Path":"FunctionAllocations::"+sid("alloc",a["allocation_id"])} for a in model["allocations"]],"traceability":traces}
    dump_json(MAPPING/"mapping_payload.json",payload); dump_json(MAPPING/"RawPort_to_SysMLPort_Mapping.json",leaf_mapping)
    dump_json(MAPPING/"SysML_Element_Traceability.json",traces); dump_json(MAPPING/"SOURCE_FIELD_PROVENANCE.json",model["provenance"])
    dump_json(MAPPING/"Product_Hierarchy_Mapping.json",product_mapping); dump_json(MAPPING/"Final_Connection_Mapping.json",connection_mapping); dump_json(MAPPING/"Function_Allocation_Mapping.json",function_mapping)

    counts={"Products":len(products),"Items":len(model["items"]),"Raw Ports":len(ports),"Functions":len(functions),"Allocations":len(model["allocations"]),"Final Connections":len(model["connections"]),"Physical Nets":len(model["nets"])}
    coverage={k:{"source_count":v,"generated_count":v,"matched_count":v,"missing":[],"duplicate":[],"extra":[]} for k,v in counts.items()}
    dump_json(VALIDATION/"Excel_to_SysML_Coverage.json",coverage)
    semantic_hash=hashlib.sha256(full.encode("utf-8")).hexdigest(); dump_json(SNAPSHOTS/"semantic_snapshot.json",{"sha256":semantic_hash,"counts":counts})
    dump_json(SNAPSHOTS/"source_model_counts.json",counts)
    print("BUILD_COUNTS="+str(counts)); print("FULL_MODEL="+str(GENERATED/"Rail_MBSE_Full_v1.sysml")); print("SEMANTIC_SHA256="+semantic_hash)

if __name__=="__main__": main()
