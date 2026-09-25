"""Open the original SSI file-selection GUI and record its visible Qt widgets."""

from __future__ import annotations

import importlib.util
import json
from pathlib import Path

from PyQt5.QtCore import QTimer
from PyQt5.QtWidgets import QApplication, QFileDialog, QMessageBox


ROOT = Path(__file__).resolve().parents[2]
SSI_ENTRY = ROOT / "third_party/ssi_transformer/Standard-System-Interface/source/SSI_transformer.py"
LOG = ROOT / "work/sysmlv2/ssi_integration/04_logs/ssi_gui_probe.json"


def load_ssi():
    spec = importlib.util.spec_from_file_location("ssi_transformer_gui_probe", SSI_ENTRY)
    if spec is None or spec.loader is None:
        raise RuntimeError(f"Cannot load SSI Transformer: {SSI_ENTRY}")
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


app = QApplication.instance() or QApplication([])
ssi = load_ssi()
events = []


def snapshot(stage: str):
    visible = []
    for widget in QApplication.topLevelWidgets():
        if widget.isVisible():
            visible.append(
                {
                    "class": widget.metaObject().className(),
                    "title": widget.windowTitle(),
                    "visible": True,
                }
            )
    events.append({"stage": stage, "widgets": visible})
    return visible


def first_dialog():
    snapshot("information_dialog")
    for widget in QApplication.topLevelWidgets():
        if isinstance(widget, QMessageBox):
            widget.accept()
    QTimer.singleShot(700, file_dialog)


def file_dialog():
    snapshot("file_dialog")
    for widget in QApplication.topLevelWidgets():
        if isinstance(widget, QFileDialog):
            widget.reject()


QTimer.singleShot(700, first_dialog)
selected = ssi.select_file("Select the Interface Definition SysML file.")
result = {
    "ssi_entry": str(SSI_ENTRY),
    "qt_platform": "windows",
    "selected_file": selected,
    "events": events,
    "message_box_visible": any(
        widget["class"] == "QMessageBox" for event in events for widget in event["widgets"]
    ),
    "file_dialog_visible": any(
        widget["class"] == "QFileDialog" for event in events for widget in event["widgets"]
    ),
}
result["status"] = "PASS" if result["message_box_visible"] and result["file_dialog_visible"] else "FAIL"
LOG.parent.mkdir(parents=True, exist_ok=True)
LOG.write_text(json.dumps(result, ensure_ascii=False, indent=2), encoding="utf-8")
print(json.dumps(result, ensure_ascii=False, indent=2))
