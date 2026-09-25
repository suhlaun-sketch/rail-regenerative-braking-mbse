from __future__ import annotations

import base64
import copy
import gzip
import hashlib
import json
import re
import xml.etree.ElementTree as ET
from collections import defaultdict
from pathlib import Path


PIPELINE_DIR = Path(__file__).resolve().parent
ROOT = PIPELINE_DIR.parents[1]
WORK = ROOT / "work"
PIPELINE_WORK = PIPELINE_DIR / "work"
GOLD = WORK / "gold.mdxml"
STANDARD_XMI = WORK / "Rail_MBSE_TractionBrake_Full_UpwardIBD_v1.xmi"
OUTPUT = WORK / "Rail_MBSE_TractionBrake_Full_UpwardIBD_v1.mdxml"
SOURCE = WORK / "architecture_xmi_ready_v1.json"
UPWARD = PIPELINE_WORK / "upward_port_inference_v1.json"
PROJECTION = PIPELINE_WORK / "hierarchical_connection_projection_v1.json"
PLAN = PIPELINE_WORK / "ibd_generation_plan_v1.json"
DIRECTIONS = PIPELINE_WORK / "port_direction_resolution.json"
HUMAN_NAMES = PIPELINE_WORK / "interface_human_name_map.json"
MANIFEST = PIPELINE_WORK / "full_native_mdxml_manifest_v1.json"

GOLD_RESOURCE = "BINARY-dfb5dbde-6b4e-45ed-b4ce-5625a0843c81"
GOLD_PROJECT = "PROJECT-9d229b7f23ee72e551be257697554fa5"
GOLD_MODEL = "XMI-MODEL-RAIL-MBSE-ITEMFLOW-DISPLAY-PROBE-V6"
NEW_MODEL = "XMI-MODEL-RAIL-MBSE-FULL-UPWARD-IBD-V1"
NEW_MODEL_NAME = "Rail_MBSE_TractionBrake_Full_UpwardIBD_v1"
NEW_PROJECT = "PROJECT-" + hashlib.sha1(b"RAIL-MBSE-FULL-UPWARD-IBD-V1-MD2022X").hexdigest()[:32]
CONTEXT = "__SYSTEM_CONTEXT__"


def sid(prefix: str, seed: str, length: int = 24) -> str:
    return f"{prefix}-{hashlib.sha1(seed.encode('utf-8')).hexdigest()[:length].upper()}"


def local(element: ET.Element) -> str:
    return element.tag.rsplit("}", 1)[-1]


def attr_local(element: ET.Element, name: str) -> str | None:
    for key, value in element.attrib.items():
        if key.rsplit("}", 1)[-1] == name:
            return value
    return None


def set_attr_local(element: ET.Element, name: str, value: str) -> None:
    for key in list(element.attrib):
        if key.rsplit("}", 1)[-1] == name:
            element.set(key, value)
            return
    element.set(name, value)


def child(element: ET.Element, name: str) -> ET.Element:
    return next(entry for entry in element if local(entry) == name)


def element_model_ref(element: ET.Element) -> str | None:
    target = next((entry for entry in element if local(entry) == "elementID"), None)
    return attr_local(target, "idref") if target is not None else None


def set_model_ref(element: ET.Element, reference: str) -> None:
    set_attr_local(child(element, "elementID"), "idref", reference)


def replace_references(root: ET.Element, mapping: dict[str, str]) -> None:
    for element in root.iter():
        for key, value in list(element.attrib.items()):
            if value in mapping:
                element.set(key, mapping[value])
        if element.text and element.text.strip() in mapping:
            prefix = element.text[: len(element.text) - len(element.text.lstrip())]
            suffix = element.text[len(element.text.rstrip()) :]
            element.text = prefix + mapping[element.text.strip()] + suffix


def clone_reid(element: ET.Element, seed: str) -> tuple[ET.Element, dict[str, str]]:
    clone = copy.deepcopy(element)
    mapping = {}
    index = 1
    for entry in clone.iter():
        identifier = attr_local(entry, "id")
        if identifier:
            mapping[identifier] = "_" + sid("MDVIEW", f"{seed}|{index}")
            index += 1
    replace_references(clone, mapping)
    return clone, mapping


class NativeBuilder:
    def __init__(self):
        self.data = json.loads(SOURCE.read_text(encoding="utf-8"))
        self.upward = json.loads(UPWARD.read_text(encoding="utf-8"))
        self.projection = json.loads(PROJECTION.read_text(encoding="utf-8"))
        self.plan = json.loads(PLAN.read_text(encoding="utf-8"))
        self.directions = json.loads(DIRECTIONS.read_text(encoding="utf-8"))
        self.human_names = json.loads(HUMAN_NAMES.read_text(encoding="utf-8"))
        self.products = {p["id"]: p for p in self.data["products"]}
        self.items = {i["item_code"]: i for i in self.data["items"]}
        self.interfaces = {i["interface_instance_id"]: i for i in self.data["interfaces"]}
        self.promoted = {p["promoted_port_id"]: p for p in self.upward["promoted_ports"]}
        self.segments = {s["segment_id"]: s for s in self.projection["segments"]}
        self.net_projections = {n["projection_id"]: n for n in self.projection["physical_net_projections"]}
        self.ib_names = {r["interface_block_id"]: r["name_cn"] for r in self.human_names["interface_blocks"]}
        self.direction_by_raw_xmi = {
            self.interfaces[r["interface_instance_id"]]["xmi_id"]: r["effective_port_direction"]
            for r in self.directions["records"]
        }
        self.direction_by_port_xmi = dict(self.direction_by_raw_xmi)
        for port in self.promoted.values():
            self.direction_by_port_xmi[port["xmi_id"]] = port["effective_direction"]

        self.standard_root = ET.parse(STANDARD_XMI).getroot()
        self.XMI = self.standard_root.tag.split("}", 1)[0][1:]
        ET.register_namespace("xmi", self.XMI)
        ET.register_namespace("uml", "http://www.omg.org/spec/UML/20131001")
        ET.register_namespace("sysml", "http://www.omg.org/spec/SysML/20181001/SysML")
        ET.register_namespace("xmi2", "http://www.omg.org/XMI")
        ET.register_namespace("diagram", "http://www.nomagic.com/ns/magicdraw/core/diagram/1.0")
        ET.register_namespace("binary", "http://www.nomagic.com/ns/cameo/client/binary/1.0")
        ET.register_namespace("xsi", "http://www.w3.org/2001/XMLSchema-instance")
        self.qx = lambda name: f"{{{self.XMI}}}{name}"
        self.model = next(e for e in self.standard_root if local(e) == "Model")
        self.model_ids = {attr_local(e, "id"): e for e in self.standard_root.iter() if attr_local(e, "id")}

        self.gold_root = ET.parse(GOLD).getroot()
        gold_filepart = next(e for e in self.gold_root.iter() if local(e) == "filePart" and e.get("name") == GOLD_RESOURCE)
        self.gold_presentation = next(e for e in gold_filepart if local(e) == "mdOwnedViews")
        self.gold_frame = next(e for e in self.gold_presentation if e.get("elementClass") == "DiagramFrame")
        self.gold_parts = [e for e in self.gold_presentation if e.get("elementClass") == "Part"]
        self.gold_connector = next(e for e in self.gold_presentation if e.get("elementClass") == "Connector")
        self.gold_styles = next(e for e in self.gold_presentation if local(e) == "symbolStyles")
        self.gold_source_port = next(e for e in self.gold_parts[0].iter() if e.get("elementClass") == "Port")
        self.gold_target_port = next(e for e in self.gold_parts[1].iter() if e.get("elementClass") == "Port")
        gold_harness = next(
            e for e in self.gold_root.iter()
            if e.get("name") == "Rail_MBSE_TractionBrake_ItemFlow_Display_Probe_v6"
            and attr_local(e, "type") == "uml:Class"
        )
        self.gold_diagram_extension = next(e for e in gold_harness if local(e) == "Extension" and any(local(x) == "ownedDiagram" for x in e.iter()))
        self.resources: list[dict] = []
        self.diagram_info_apps: list[str] = []

    def port_name_and_type(self, port_xmi: str) -> tuple[str, str]:
        element = self.model_ids[port_xmi]
        return element.get("name", "接口"), element.get("type", "")

    def port_direction(self, port_xmi: str) -> str:
        if port_xmi in self.direction_by_port_xmi:
            return self.direction_by_port_xmi[port_xmi]
        # Boundary and network junction Ports are all physical projections.
        return "inout"

    def build_port_symbol(self, port_xmi: str, x: int, y: int, side: str, diagram_seed: str) -> tuple[ET.Element, str, tuple[int, int]]:
        template = self.gold_source_port if side == "RIGHT" else self.gold_target_port
        symbol, _ = clone_reid(template, f"{diagram_seed}|PORT|{port_xmi}")
        set_model_ref(symbol, port_xmi)
        symbol_id = attr_local(symbol, "id")
        child(symbol, "geometry").text = f"{x}, {y}, 15, 15"
        edge = next(e for e in symbol if local(e) == "edge")
        set_attr_local(edge, "value", "1" if side == "RIGHT" else "3")
        name, ib_id = self.port_name_and_type(port_xmi)
        ib_name = self.ib_names.get(ib_id, "接口")
        owned = child(symbol, "mdOwnedViews")
        textboxes = [e for e in owned if e.get("elementClass") == "TextBox"]
        if textboxes:
            text = next((e for e in textboxes[0] if local(e) == "text"), None)
            if text is not None:
                text.text = f"{name} : {ib_name} [1]"
            child(textboxes[0], "geometry").text = f"{x + 18 if side == 'RIGHT' else max(5, x - 260)}, {y - 8}, 250, 12"
        stereotypes = [e for e in owned if e.get("elementClass") == "TextBoxWithIcon"]
        if stereotypes:
            child(stereotypes[0], "geometry").text = f"{x + 18 if side == 'RIGHT' else max(5, x - 50)}, {y - 23}, 45, 12"
        return symbol, symbol_id, (x + 7, y + 7)

    def build_part_symbol(self, part_xmi: str, ports: list[str], x: int, y: int, width: int, diagram_seed: str, right_bias: bool) -> tuple[ET.Element, dict[str, tuple[str, tuple[int, int]]], int]:
        symbol, _ = clone_reid(self.gold_parts[0], f"{diagram_seed}|PART|{part_xmi}")
        set_model_ref(symbol, part_xmi)
        owned = child(symbol, "mdOwnedViews")
        for existing in list(owned):
            owned.remove(existing)
        height = max(60, 36 + len(ports) * 22)
        child(symbol, "geometry").text = f"{x}, {y}, {width}, {height}"
        port_map = {}
        left_index = right_index = 0
        for port_xmi in ports:
            direction = self.port_direction(port_xmi)
            side = "RIGHT" if direction == "out" else "LEFT" if direction == "in" else ("RIGHT" if (right_bias or right_index <= left_index) else "LEFT")
            if side == "RIGHT":
                px, py = x + width - 15, y + 22 + right_index * 22
                right_index += 1
            else:
                px, py = x, y + 22 + left_index * 22
                left_index += 1
            port_symbol, port_id, center = self.build_port_symbol(port_xmi, px, py, side, diagram_seed)
            owned.append(port_symbol)
            port_map[port_xmi] = (port_id, center)
        return symbol, port_map, height

    def connector_end_ids(self, connector_xmi: str) -> list[str]:
        connector = self.model_ids[connector_xmi]
        return [attr_local(e, "id") for e in connector if attr_local(e, "type") == "uml:ConnectorEnd"]

    def build_connector_symbol(self, connector_xmi: str, source: tuple[str, tuple[int, int]], target: tuple[str, tuple[int, int]], item_code: str | None, diagram_seed: str) -> ET.Element:
        symbol, _ = clone_reid(self.gold_connector, f"{diagram_seed}|CONNECTOR|{connector_xmi}")
        set_model_ref(symbol, connector_xmi)
        set_attr_local(child(symbol, "linkFirstEndID"), "idref", target[0])
        set_attr_local(child(symbol, "linkSecondEndID"), "idref", source[0])
        sx, sy = source[1]
        tx, ty = target[1]
        mid = (sx + tx) // 2
        child(symbol, "geometry").text = f"{tx}, {ty}; {mid}, {ty}; {mid}, {sy}; {sx}, {sy}; "
        owned = child(symbol, "mdOwnedViews")
        end_symbols = [e for e in owned if e.get("elementClass") == "ConnectorEnd"]
        model_ends = self.connector_end_ids(connector_xmi)
        if len(model_ends) != 2 or len(end_symbols) != 2:
            raise AssertionError(f"Binary presentation requires two ConnectorEnds: {connector_xmi}")
        set_model_ref(end_symbols[0], model_ends[1])
        set_model_ref(end_symbols[1], model_ends[0])
        child(end_symbols[0], "geometry").text = f"{tx - 10}, {ty - 5}, 10, 10"
        child(end_symbols[1], "geometry").text = f"{sx}, {sy - 5}, 10, 10"
        compartments = [e for e in symbol if local(e) == "compartment"]
        label = next((e for e in owned if e.get("elementClass") == "TextBox"), None)
        link_label = next((e for e in symbol if local(e) == "linkConveyedAID"), None)
        if item_code:
            set_attr_local(compartments[0], "value", self.items[item_code]["xmi_id"])
            signal_name = self.items[item_code]["name_cn"]
            text = next(e for e in label if local(e) == "text")
            text.text = signal_name
            child(label, "geometry").text = f"{mid + 5}, {(sy + ty) // 2}, {max(80, len(signal_name) * 15)}, 12"
        else:
            for key in list(compartments[0].attrib):
                if key.rsplit("}", 1)[-1] == "value":
                    del compartments[0].attrib[key]
            if label is not None:
                owned.remove(label)
            if link_label is not None:
                symbol.remove(link_label)
        return symbol

    def create_resource(self, diagram: dict) -> tuple[str, bytes, list[str]]:
        diagram_seed = diagram["diagram_id"]
        resource_id = "BINARY-" + hashlib.sha1(f"RAIL-MBSE|FULL|{diagram_seed}".encode()).hexdigest()[:32]
        root = ET.Element("mdOwnedViews")
        frame, _ = clone_reid(self.gold_frame, f"{diagram_seed}|FRAME")
        set_model_ref(frame, diagram["diagram_xmi_id"])
        root.append(frame)

        segments = [self.segments[s] for s in diagram["connectors"]]
        net_projections = [self.net_projections[n] for n in diagram["physical_nets"]]
        outgoing = defaultdict(int)
        incoming = defaultdict(int)
        for segment in segments:
            outgoing[segment["source_element"]] += 1
            incoming[segment["target_element"]] += 1

        part_specs = []
        for part in diagram["direct_parts"]:
            ports = [p["port_xmi_id"] for p in diagram["part_ports"] if p.get("part_product_id") == part["product_id"]]
            part_specs.append({"key": part["product_id"], "part_xmi": part["part_xmi_id"], "ports": ports, "kind": "PRODUCT"})
        for part in diagram["boundary_reference_parts"]:
            ports = [p["port_xmi_id"] for p in diagram["part_ports"] if p.get("part_boundary_id") == part["boundary_id"]]
            part_specs.append({"key": part["boundary_id"], "part_xmi": part["part_xmi_id"], "ports": ports, "kind": "BOUNDARY"})
        for net in net_projections:
            ref_xmi = f"XMI-{sid('HNETREF', net['projection_id'])}"
            junction_ports = [f"XMI-{sid('HNETPORT', net['projection_id'] + '|' + str(i))}" for i in range(1, len(net["members"]) + 1)]
            part_specs.append({"key": net["projection_id"], "part_xmi": ref_xmi, "ports": junction_ports, "kind": "NET", "projection": net})

        part_port_map: dict[str, tuple[str, tuple[int, int]]] = {}
        part_symbol_ids = {}
        max_y = 100
        columns_y = [100, 100, 100]
        column_x = [100, 560, 1020]
        for index, spec in enumerate(part_specs):
            if spec["kind"] == "NET":
                column = 1
            elif outgoing[spec["key"]] > incoming[spec["key"]]:
                column = 0
            elif incoming[spec["key"]] > outgoing[spec["key"]]:
                column = 2
            else:
                column = index % 2 * 2
            x, y = column_x[column], columns_y[column]
            symbol, ports, height = self.build_part_symbol(spec["part_xmi"], spec["ports"], x, y, 260, diagram_seed, column == 0)
            root.append(symbol)
            part_symbol_ids[spec["key"]] = attr_local(symbol, "id")
            part_port_map.update(ports)
            columns_y[column] += height + 90
            max_y = max(max_y, columns_y[column])

        # Frame Ports are root-level Port symbols on the IBD border.
        frame_port_map = {}
        frame_ports = [self.promoted[pid] for pid in diagram["frame_ports"]]
        left_y = right_y = 70
        canvas_width = 1400
        for port in frame_ports:
            direction = port["effective_direction"]
            side = "RIGHT" if direction == "out" else "LEFT" if direction == "in" else ("RIGHT" if right_y <= left_y else "LEFT")
            x = canvas_width - 20 if side == "RIGHT" else 5
            y = right_y if side == "RIGHT" else left_y
            if side == "RIGHT":
                right_y += 25
            else:
                left_y += 25
            symbol, symbol_id, center = self.build_port_symbol(port["xmi_id"], x, y, side, diagram_seed)
            root.append(symbol)
            frame_port_map[port["xmi_id"]] = (symbol_id, center)

        all_ports = dict(part_port_map)
        all_ports.update(frame_port_map)
        used = {diagram["owner_block_xmi_id"], diagram["diagram_xmi_id"]}
        used.update(spec["part_xmi"] for spec in part_specs)
        used.update(all_ports)

        for segment in segments:
            source = all_ports[segment["source_port_xmi_id"]]
            target = all_ports[segment["target_port_xmi_id"]]
            connector = self.build_connector_symbol(segment["xmi_id"], source, target, segment["item_code"] if segment["mode"] == "SIGNAL" else None, diagram_seed)
            root.append(connector)
            used.add(segment["xmi_id"])
            used.update(self.connector_end_ids(segment["xmi_id"]))

        for net in net_projections:
            for index, endpoint in enumerate(net["members"], 1):
                member = all_ports[endpoint["port_xmi_id"]]
                junction_xmi = f"XMI-{sid('HNETPORT', net['projection_id'] + '|' + str(index))}"
                junction = all_ports[junction_xmi]
                connector_xmi = f"XMI-{sid('HNETCONN', net['projection_id'] + '|' + str(index))}"
                connector = self.build_connector_symbol(connector_xmi, member, junction, None, diagram_seed)
                root.append(connector)
                used.add(connector_xmi)
                used.update(self.connector_end_ids(connector_xmi))

        styles, style_map = clone_reid(self.gold_styles, f"{diagram_seed}|STYLES")
        root.append(styles)
        replace_references(root, style_map)
        canvas_height = max(900, max_y + 100, left_y + 100, right_y + 100)
        child(frame, "geometry").text = f"5, 5, {canvas_width}, {canvas_height}"
        ET.indent(root, space="\t")
        resource_xml = ET.tostring(root, encoding="unicode", short_empty_elements=True)
        # Gold relies on the outer MDXML xmi namespace for this inline resource.
        resource_xml = re.sub(r"\s+xmlns:xmi=['\"]http://www.omg.org/spec/XMI/20131001['\"]", "", resource_xml, count=1)
        resource_bytes = b"<?xml version='1.0' encoding='UTF-8'?>\n" + resource_xml.encode("utf-8")
        return resource_id, resource_bytes, sorted(used)

    def attach_diagram(self, diagram: dict, resource_id: str, resource_bytes: bytes, used: list[str]) -> None:
        owner = self.model_ids[diagram["owner_block_xmi_id"]]
        extension, _ = clone_reid(self.gold_diagram_extension, f"{diagram['diagram_id']}|MODEL")
        owned = next(e for e in extension.iter() if local(e) == "ownedDiagram")
        set_attr_local(owned, "id", diagram["diagram_xmi_id"])
        owned.set("name", diagram["name"])
        owned.set("context", diagram["owner_block_xmi_id"])
        owned.set("ownerOfDiagram", diagram["owner_block_xmi_id"])
        representation = next(e for e in extension.iter() if local(e) == "DiagramRepresentationObject")
        representation.set("ID", sid("MDREP", diagram["diagram_id"]))
        contents = next(e for e in representation if local(e) == "diagramContents")
        contents.set("contentHash", hashlib.sha1(resource_bytes).hexdigest())
        binary = next(e for e in contents if local(e) == "binaryObject")
        binary.set("streamContentID", resource_id)
        for entry in list(contents):
            if local(entry) in {"usedObjects", "usedElements"}:
                contents.remove(entry)
        for reference in used:
            obj = ET.SubElement(contents, "usedObjects")
            obj.set("href", f"#{reference}")
        for reference in used:
            elem = ET.SubElement(contents, "usedElements")
            elem.text = reference
        owner.append(extension)
        self.diagram_info_apps.append(
            f"\t<MagicDraw_Profile:DiagramInfo xmi:id='{sid('XMI-APP-DIAGRAMINFO', diagram['diagram_id'])}' "
            f"base_Diagram='{diagram['diagram_xmi_id']}' Creation_date='2026/9/9 下午8:09' "
            "Modification_date='2026/9/9 下午8:09' Author='Rail MBSE deterministic converter' "
            "Last_modified_by='Rail MBSE deterministic converter'/>"
        )

    def native_tail(self, resource_ids: list[str]) -> str:
        gold = GOLD.read_text(encoding="utf-8")
        gold_model_start = gold.index("\t<uml:Model")
        gold_model_end = gold.index("\n\t</uml:Model>", gold_model_start) + len("\n\t</uml:Model>")
        first_app_candidates = [pos for marker in ("\n\t<sysml:", "\n\t<MD_Customization", "\n\t<MagicDraw_Profile") if (pos := gold.find(marker, gold_model_end)) >= 0]
        first_app = min(first_app_candidates)
        tail_start = gold.index("\n\t<xmi:Extension extender='MagicDraw UML 2022x'>", first_app)
        registry = gold[gold_model_end:first_app]
        tail = gold[tail_start: gold.rindex("</xmi:XMI>")]
        tail = re.sub(
            rf"\s*<xmi:Extension extender='MagicDraw UML 2022x'>\s*<filePart name='{re.escape(GOLD_RESOURCE)}'.*?</filePart>\s*</xmi:Extension>",
            "",
            tail,
            count=1,
            flags=re.DOTALL,
        )
        old_hex = GOLD_PROJECT.removeprefix("PROJECT-")
        new_hex = NEW_PROJECT.removeprefix("PROJECT-")
        tail = tail.replace(GOLD_PROJECT, NEW_PROJECT).replace(old_hex, new_hex)
        tail = tail.replace(GOLD_MODEL, NEW_MODEL).replace("Rail_MBSE_TractionBrake_ItemFlow_Display_Probe_v6", NEW_MODEL_NAME)
        properties = "#\r\n#Deterministic Rail MBSE Full Upward IBD v1\r\ncom.nomagic.magicdraw.uml_model.model=" + ",".join(resource_ids) + "\r\n"
        encoded = base64.b64encode(gzip.compress(properties.encode("iso-8859-1"), mtime=0)).decode("ascii")
        tail, count = re.subn(
            r"(<filePart name='Binaries\.properties' type='BINARY'>).*?(</filePart>)",
            rf"\g<1>{encoded}\2",
            tail,
            count=1,
            flags=re.DOTALL,
        )
        if count != 1:
            raise AssertionError("Could not update Binaries.properties")
        return registry, tail

    def build(self) -> tuple[bytes, dict]:
        for diagram in self.plan["diagrams"]:
            resource_id, resource_bytes, used = self.create_resource(diagram)
            self.attach_diagram(diagram, resource_id, resource_bytes, used)
            self.resources.append({"id": resource_id, "bytes": resource_bytes, "diagram": diagram["name"], "used": used})

        ET.indent(self.model, space="  ")
        model_xml = ET.tostring(self.model, encoding="unicode", short_empty_elements=True)
        standard_apps = [e for e in self.standard_root if local(e) != "Model"]
        apps_xml = []
        for application in standard_apps:
            apps_xml.append("\t" + ET.tostring(application, encoding="unicode", short_empty_elements=True))
        apps_xml.extend(self.diagram_info_apps)

        gold = GOLD.read_text(encoding="utf-8")
        model_start = gold.index("\t<uml:Model")
        prefix = gold[:model_start]
        resource_ids = [r["id"] for r in self.resources]
        registry, tail = self.native_tail(resource_ids)
        resource_sections = []
        for resource in self.resources:
            xml_body = resource["bytes"].decode("utf-8").split("\n", 1)[1]
            resource_sections.append(
                "\t<xmi:Extension extender='MagicDraw UML 2022x'>\n"
                f"\t\t<filePart name='{resource['id']}' type='XML' header='&lt;?xml version=&#39;1.0&#39; encoding=&#39;UTF-8&#39;?&gt;'>\n"
                f"{xml_body}\n"
                "\t\t</filePart>\n"
                "\t</xmi:Extension>"
            )
        result = (
            prefix
            + "\t" + model_xml + "\n"
            + registry
            + "\n".join(apps_xml) + "\n"
            + "\n".join(resource_sections) + "\n"
            + tail.lstrip("\n")
            + "\n</xmi:XMI>\n"
        )
        data = result.encode("utf-8")
        manifest = {
            "manifest_id": "RAIL-MBSE-FULL-NATIVE-MDXML-V1",
            "output": str(OUTPUT),
            "sha256": hashlib.sha256(data).hexdigest(),
            "project_id": NEW_PROJECT,
            "diagram_count": len(self.resources),
            "presentation_resource_count": len(self.resources),
            "independent_information_flow_path_count": 0,
            "byte_deterministic": True,
            "resources": [{"diagram": r["diagram"], "resource_id": r["id"], "sha1": hashlib.sha1(r["bytes"]).hexdigest(), "used_model_elements": len(r["used"])} for r in self.resources],
        }
        return data, manifest


def build_bytes() -> tuple[bytes, dict]:
    return NativeBuilder().build()


def main() -> None:
    first, manifest = build_bytes()
    second, manifest_second = build_bytes()
    if first != second or manifest != manifest_second:
        raise AssertionError("Full native MDXML is not byte deterministic")
    OUTPUT.write_bytes(first)
    MANIFEST.write_text(json.dumps(manifest, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({"output": str(OUTPUT), "bytes": len(first), "sha256": manifest["sha256"], "diagrams": manifest["diagram_count"], "deterministic": True}, ensure_ascii=False))


if __name__ == "__main__":
    main()
