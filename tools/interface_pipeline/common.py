"""Shared constants and helpers for the deterministic interface-layer pipeline."""

from __future__ import annotations

import json
from pathlib import Path
from typing import Any


PIPELINE_DIR = Path(__file__).resolve().parent
PROJECT_DIR = PIPELINE_DIR.parents[1]
VENV_DIR = PIPELINE_DIR / ".venv"

PRIMARY_WORKBOOK = PROJECT_DIR / "筛选牵引制动架构V2_RawPort完成版.xlsx"
ITEM_WORKBOOK = PROJECT_DIR / "完整Item字典.xlsx"
AUXILIARY_WORKBOOKS = (
    PROJECT_DIR / "筛选牵引制动架构V2.xlsx",
    PROJECT_DIR / "筛选牵引制动架构V2_一二三级产品统计.xlsx",
)
OUTPUT_WORKBOOK = PROJECT_DIR / "筛选牵引制动架构V2_InterfaceLayer_v1.xlsx"
REPORT_DIR = PROJECT_DIR / "reports"
AUDIT_REPORT = REPORT_DIR / "interface_layer_audit.md"
CONFIG_DIR = PIPELINE_DIR / "config"
PROFILE_CONFIG = CONFIG_DIR / "architecture_profiles.json"
WORK_DIR = PIPELINE_DIR / "work"

RAW_PORT_SHEET = "Sheet3"
RAW_PORT_COLUMNS = [
    "code",
    "name",
    "parent_name",
    "节点角色",
    "端口名称",
    "方向",
    "端口类别",
    "交换内容",
    "单位/介质",
]

PROFILE_ID = "CRH_AC25KV_SC"
PROFILE_NAME = "动车组25 kV AC再生制动与车载超级电容参考实例"

TARGET_REVIEW_CODES = [
    "4111", "411C", "4121", "4211", "4212", "4235", "4236", "4238",
    "4239", "4241", "4411", "4412", "4413", "4511", "4513", "4517",
    "4518", "5111", "5112", "5113", "5121", "5122", "5131", "5132",
    "5133", "5142", "5145", "5311", "7211", "8122", "8125", "8128",
    "8166", "X111", "X112", "X113", "X121", "X122", "X123", "X124",
    "X131", "X132", "X133",
]

AC_DC_ITEMS = {
    "高压交流电能",
    "直流牵引供电电能",
    "牵引变压器次级交流电能",
    "中间直流电能",
    "三相交流电能",
    "储能侧直流电能",
}


def ensure_required_inputs() -> None:
    missing = [str(path) for path in (PRIMARY_WORKBOOK, ITEM_WORKBOOK) if not path.exists()]
    if missing:
        raise FileNotFoundError("缺少必需输入文件:\n" + "\n".join(missing))


def normalize_text(value: Any) -> str:
    if value is None:
        return ""
    return str(value).strip()


def normalize_code(value: Any) -> str:
    text = normalize_text(value)
    if text.endswith(".0") and text[:-2].isdigit():
        return text[:-2]
    return text


def write_json(path: Path, data: Any) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2), encoding="utf-8")


def read_json(path: Path) -> Any:
    return json.loads(path.read_text(encoding="utf-8"))
