from __future__ import annotations

import hashlib
import json
import re
from pathlib import Path


PIPELINE_DIR = Path(__file__).resolve().parent
ROOT = PIPELINE_DIR.parents[1]
GOLD = ROOT / "work" / "gold.mdxml"
OUTPUT = ROOT / "work" / "Rail_MBSE_ItemFlow_native_probe_v7.mdxml"
MANIFEST = PIPELINE_DIR / "work" / "magicdraw_native_probe_v7_manifest.json"

GOLD_SHA256 = "3e022d5a9d3bd6192956b76f622f6be197dedc4939f822e8af33ec582fd36712"
OLD_PROJECT_ID = "PROJECT-9d229b7f23ee72e551be257697554fa5"
OLD_RESOURCE_ID = "BINARY-dfb5dbde-6b4e-45ed-b4ce-5625a0843c81"

SOURCE_PRODUCT = "XMI-PRODUCT-4235"
TARGET_PRODUCT = "XMI-PRODUCT-5111"
SOURCE_PORT = "XMI-PORT-17D10E3CF7A87862"
TARGET_PORT = "XMI-PORT-E47D00EE3FA2782A"
SIGNAL = "XMI-ITEM-ITM-MEA-005"
CONNECTION_ID = "CG-002543DBE0F9A7FBC2A3FDD3"
CONNECTOR = "XMI-CONN-CG-002543DBE0F9A7FBC2A3FDD3"
SOURCE_END = "XMI-CONNECTOREND-26F9EBC39C627331DA"
TARGET_END = "XMI-CONNECTOREND-F34A548D31D2751415"
INFORMATION_FLOW = "XMI-INFORMATIONFLOW-15B085CFB9BA80E2C5"
ITEM_FLOW_APP = "XMI-APP-ITEMFLOW-15B085CFB9BA80E2C5"

GOLD_HARNESS = "_2022x_2ee012b_1788955150700_713318_2817"
GOLD_SOURCE_PART = "_2022x_2ee012b_1788955154049_352958_2845"
GOLD_TARGET_PART = "_2022x_2ee012b_1788955155744_749480_2923"
GOLD_CONNECTOR = "_2022x_2ee012b_1788955755732_217889_3122"
GOLD_SOURCE_END = "_2022x_2ee012b_1788955755733_522700_3123"
GOLD_TARGET_END = "_2022x_2ee012b_1788955755733_520899_3124"
GOLD_INFORMATION_FLOW = "_2022x_2ee012b_1788955789111_160689_3129"
GOLD_ITEM_FLOW_APP = "_2022x_2ee012b_1788955789111_160689_3129_application"

NEW_PROJECT_ID = "PROJECT-" + hashlib.sha1(b"RAIL-MBSE-MD2022X-NATIVE-PROBE-V7").hexdigest()[:32]
NEW_RESOURCE_ID = "BINARY-" + hashlib.sha1(b"RAIL-MBSE-MD2022X-NATIVE-PRESENTATION-V7").hexdigest()[:32]
NEW_HARNESS = "XMI-MD-IBD-CONTEXT-ITEMFLOW-V7"
NEW_SOURCE_PART = "XMI-MD-IBD-PART-4235-V7"
NEW_TARGET_PART = "XMI-MD-IBD-PART-5111-V7"


def stable_id(kind: str, ordinal: int, context: str = "") -> str:
    digest = hashlib.sha1(f"RAIL-MBSE|MD2022X|V7|{kind}|{ordinal}|{context}".encode()).hexdigest()[:20].upper()
    return f"_MDV7_{kind}_{digest}"


def remove_once(text: str, pattern: str, label: str) -> str:
    updated, count = re.subn(pattern, "", text, count=1, flags=re.DOTALL)
    if count != 1:
        raise AssertionError(f"Expected one {label}, removed {count}")
    return updated


def replace_once_literal(text: str, old: str, new: str, label: str) -> str:
    count = text.count(old)
    if count < 1:
        raise AssertionError(f"Missing {label}: {old}")
    return text.replace(old, new)


def target_resource_bounds(text: str, resource_id: str) -> tuple[int, int, int, int]:
    marker = f"<filePart name='{resource_id}'"
    file_start = text.index(marker)
    resource_start = text.index("<mdOwnedViews>", file_start)
    file_end_start = text.index("</filePart>", resource_start)
    resource_end = text.rindex("</mdOwnedViews>", resource_start, file_end_start) + len("</mdOwnedViews>")
    file_end = file_end_start + len("</filePart>")
    return file_start, resource_start, resource_end, file_end


def build_bytes() -> tuple[bytes, dict]:
    gold_bytes = GOLD.read_bytes()
    gold_hash = hashlib.sha256(gold_bytes).hexdigest()
    if gold_hash != GOLD_SHA256:
        raise AssertionError(f"Golden Sample changed: {gold_hash}")
    text = gold_bytes.decode("utf-8")

    # The saved Golden Sample contains the imported model-only connector and
    # the hand-created displayed connector. Keep one relationship: transfer
    # the frozen stable identity to the displayed connector.
    text = remove_once(
        text,
        rf"\s*<ownedConnector\b[^>]*xmi:id='{re.escape(CONNECTOR)}'[^>]*>.*?</ownedConnector>",
        "imported duplicate connector",
    )
    for app_id in ("XMI-APP-NESTEDEND-581222087BFFE11823", "XMI-APP-NESTEDEND-D70ADEEA036A1797DE"):
        text = remove_once(text, rf"\s*<sysml:NestedConnectorEnd\b[^>]*xmi:id='{re.escape(app_id)}'[^>]*/>", app_id)

    semantic_map = {
        GOLD_HARNESS: NEW_HARNESS,
        GOLD_SOURCE_PART: NEW_SOURCE_PART,
        GOLD_TARGET_PART: NEW_TARGET_PART,
        GOLD_CONNECTOR: CONNECTOR,
        GOLD_SOURCE_END: SOURCE_END,
        GOLD_TARGET_END: TARGET_END,
        GOLD_INFORMATION_FLOW: INFORMATION_FLOW,
        GOLD_ITEM_FLOW_APP: ITEM_FLOW_APP,
    }
    for old, new in sorted(semantic_map.items(), key=lambda pair: len(pair[0]), reverse=True):
        text = replace_once_literal(text, old, new, f"semantic id {old}")

    text = text.replace(OLD_PROJECT_ID, NEW_PROJECT_ID).replace(OLD_RESOURCE_ID, NEW_RESOURCE_ID)
    text = text.replace("Rail_MBSE_TractionBrake_ItemFlow_Display_Probe_v6", "Rail_MBSE_TractionBrake_ItemFlow_Native_Probe_v7")
    text = text.replace("Rail_MBSE_TractionBrake_Structure_Probe_v4", "Rail_MBSE_TractionBrake_ItemFlow_Native_Probe_v7")
    text = text.replace("Semantic_Structure_Probe_v4", "ItemFlow_Native_Probe_v7")
    text = text.replace("ItemFlow_Display_Probe_v6", "ItemFlow_Native_Probe_v7")

    # Add readable names and frozen connection trace to the hand-authored
    # presentation harness without touching Product or Port definitions.
    text = text.replace(
        f"xmi:id='{NEW_SOURCE_PART}' visibility='public' aggregation='composite'",
        f"xmi:id='{NEW_SOURCE_PART}' name='part_4235' visibility='public' aggregation='composite'",
        1,
    )
    text = text.replace(
        f"xmi:id='{NEW_TARGET_PART}' visibility='public' aggregation='composite'",
        f"xmi:id='{NEW_TARGET_PART}' name='part_5111' visibility='public' aggregation='composite'",
        1,
    )
    connector_open = f"<ownedConnector xmi:type='uml:Connector' xmi:id='{CONNECTOR}' visibility='public'>"
    connector_comment = (
        connector_open
        + f"\n\t\t\t\t<ownedComment xmi:type='uml:Comment' "
        + "xmi:id='XMI-COMMENT-CONNECTOR-CODE-7BAEDF3C6F910E70D5' "
        + f"body='connection_id={CONNECTION_ID}'/>"
    )
    if connector_open not in text:
        raise AssertionError("Displayed connector opening not found")
    text = text.replace(connector_open, connector_comment, 1)

    # Remap every remaining MagicDraw-created current-project/presentation ID.
    # External module/profile resources are excluded from ID discovery.
    first_filepart = text.index("<filePart ")
    _, resource_start, resource_end, _ = target_resource_bounds(text, NEW_RESOURCE_ID)
    active_regions = text[:first_filepart] + text[resource_start:resource_end]
    generated_ids = []
    for value in re.findall(r"\bxmi:id=(?:'([^']+)'|\"([^\"]+)\")", active_regions):
        identifier = value[0] or value[1]
        if identifier.startswith("XMI-") or identifier in semantic_map.values():
            continue
        if identifier not in generated_ids:
            generated_ids.append(identifier)
    generated_map = {old: stable_id("NATIVE", index + 1) for index, old in enumerate(generated_ids)}
    for old, new in generated_map.items():
        text = text.replace(old, new)

    # The profile/module resource IDs stay untouched; the active project ID and
    # every active diagram/presentation ID are newly deterministic.
    if OLD_PROJECT_ID in text or OLD_RESOURCE_ID in text:
        raise AssertionError("Golden project/resource ID was reused")

    # Recalculate the presentation content hash from the exact standalone XML
    # resource form used by MagicDraw's inline filePart.
    _, resource_start, resource_end, _ = target_resource_bounds(text, NEW_RESOURCE_ID)
    resource_xml = text[resource_start:resource_end]
    resource_bytes = b"<?xml version='1.0' encoding='UTF-8'?>\n" + resource_xml.encode("utf-8")
    content_hash = hashlib.sha1(resource_bytes).hexdigest()
    diagram_hash_pattern = r"(<diagramContents\s+contentHash=')[0-9a-f]+(')"
    text, hash_count = re.subn(diagram_hash_pattern, rf"\g<1>{content_hash}\2", text, count=1)
    if hash_count != 1:
        raise AssertionError(f"Expected one diagram contentHash, updated {hash_count}")

    # Stable neutral authoring metadata; no wall-clock values are generated.
    text = re.sub(
        r"Creation_date='[^']*' Modification_date='[^']*' Author='[^']*' Last_modified_by='[^']*'",
        "Creation_date='2026/9/9 下午8:09' Modification_date='2026/9/9 下午8:09' "
        "Author='Rail MBSE deterministic converter' Last_modified_by='Rail MBSE deterministic converter'",
        text,
        count=1,
    )

    output_bytes = text.encode("utf-8")
    manifest = {
        "manifest_id": "RAIL-MBSE-MAGICDRAW-NATIVE-PROBE-V7",
        "generation_mode": "NATIVE_MDXML",
        "source_gold": str(GOLD),
        "source_gold_sha256": gold_hash,
        "output": str(OUTPUT),
        "output_sha256": hashlib.sha256(output_bytes).hexdigest(),
        "project_id": NEW_PROJECT_ID,
        "presentation_resource_id": NEW_RESOURCE_ID,
        "presentation_content_sha1": content_hash,
        "stable_model_mapping": {
            "source_product": SOURCE_PRODUCT,
            "source_part": NEW_SOURCE_PART,
            "source_port": SOURCE_PORT,
            "target_product": TARGET_PRODUCT,
            "target_part": NEW_TARGET_PART,
            "target_port": TARGET_PORT,
            "connector": CONNECTOR,
            "source_connector_end": SOURCE_END,
            "target_connector_end": TARGET_END,
            "information_flow": INFORMATION_FLOW,
            "item_flow_application": ITEM_FLOW_APP,
            "conveyed_signal": SIGNAL,
        },
        "presentation_semantics": {
            "connector": "mdElement elementClass=Connector",
            "arrow": "CONVEYED_INFORMATION_A on Connector presentation",
            "label": "Connector-owned TextBox linked by linkConveyedAID",
            "label_text": "高压线路电压",
            "independent_information_flow_path": False,
        },
        "remapped_active_native_id_count": len(generated_map),
        "gold_specific_semantic_id_count_reused": 0,
        "deterministic": True,
    }
    return output_bytes, manifest


def main() -> None:
    first, manifest = build_bytes()
    second, manifest_second = build_bytes()
    if first != second or manifest != manifest_second:
        raise AssertionError("Native probe generation is not byte deterministic")
    OUTPUT.write_bytes(first)
    MANIFEST.write_text(json.dumps(manifest, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({"output": str(OUTPUT), "bytes": len(first), "sha256": manifest["output_sha256"], "deterministic": True}, ensure_ascii=False))


if __name__ == "__main__":
    main()
