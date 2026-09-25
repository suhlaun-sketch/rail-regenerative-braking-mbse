"""Run the complete deterministic Raw Port -> Interface compatibility pipeline."""

from __future__ import annotations

import hashlib
import json
import os
import subprocess
import sys
from pathlib import Path


PIPELINE_DIR = Path(__file__).resolve().parent
PROJECT_DIR = PIPELINE_DIR.parents[1]
VENV_PYTHON = PIPELINE_DIR / ".venv" / "Scripts" / "python.exe"
SUMMARY_PATH = PIPELINE_DIR / "work" / "pipeline_summary.json"
PRIMARY_INPUT = PROJECT_DIR / "筛选牵引制动架构V2_RawPort完成版.xlsx"


def configure_console() -> None:
    for stream in (sys.stdout, sys.stderr):
        reconfigure = getattr(stream, "reconfigure", None)
        if reconfigure:
            reconfigure(encoding="utf-8", errors="replace")


def ensure_local_venv() -> None:
    current = Path(sys.executable).resolve()
    expected = VENV_PYTHON.resolve() if VENV_PYTHON.exists() else VENV_PYTHON
    if current != expected:
        if not VENV_PYTHON.exists():
            raise RuntimeError(
                "缺少项目虚拟环境。先执行:\n"
                r"D:\Computer\Anaconda\envs\mineru\python.exe -m venv tools\interface_pipeline\.venv"
                "\n然后执行:\n"
                r"tools\interface_pipeline\.venv\Scripts\python.exe -m pip install -r tools\interface_pipeline\requirements.txt"
            )
        os.execv(str(VENV_PYTHON), [str(VENV_PYTHON), str(Path(__file__).resolve()), *sys.argv[1:]])


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for block in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def run_stage(script_name: str) -> None:
    print(f"\n=== {script_name} ===", flush=True)
    env = os.environ.copy()
    env["PYTHONIOENCODING"] = "utf-8"
    env["PYTHONUTF8"] = "1"
    subprocess.run(
        [sys.executable, str(PIPELINE_DIR / script_name)],
        cwd=PROJECT_DIR,
        env=env,
        check=True,
    )


def main() -> int:
    configure_console()
    ensure_local_venv()
    if not PRIMARY_INPUT.exists():
        raise FileNotFoundError(PRIMARY_INPUT)
    input_hash_before = sha256(PRIMARY_INPUT)
    for script in (
        "01_audit_raw_ports.py",
        "02_clean_raw_ports.py",
        "03_build_profile.py",
        "04_build_porttypes.py",
        "05_build_interfacetypes.py",
        "06_validate_interface_layer.py",
    ):
        run_stage(script)
    run_stage(str(Path("tests") / "test_interface_pipeline.py"))
    input_hash_after = sha256(PRIMARY_INPUT)
    if input_hash_before != input_hash_after:
        raise RuntimeError("主输入工作簿哈希发生变化；pipeline已停止。")

    summary = json.loads(SUMMARY_PATH.read_text(encoding="utf-8"))
    print("\n=== PIPELINE FINAL REPORT ===")
    print(f"1. 输入节点数: {summary['input_node_count']}")
    print(f"2. 清洗前Port数: {summary['before_port_count']}")
    print(f"3. 清洗后Port数: {summary['after_port_count']}")
    print(
        "4. 删除/修改/新增Port数量: "
        f"{summary['deleted_port_count']}/{summary['modified_port_count']}/{summary['added_port_count']}"
    )
    print(f"5. Active Port数: {summary['active_port_count']}")
    print(f"6. Inactive Variant Port数: {summary['inactive_variant_port_count']}")
    print(f"7. PortType数量: {summary['port_type_count']}")
    print(f"8. InterfaceType数量: {summary['interface_type_count']}")
    print(f"9. Compatibility Rule数量: {summary['compatibility_rule_count']}")
    print(
        f"10. QA: {summary['qa_overall']} "
        f"(PASS={summary['qa_pass_count']}, FAIL={summary['qa_fail_count']}, WARNING={len(summary['warnings'])})"
    )
    print("11. 所有WARNING:")
    for index, warning in enumerate(summary["warnings"], start=1):
        print(f"    {index}. {warning}")
    print(f"12. 输出Excel完整路径: {summary['output_workbook']}")
    print(f"13. 本地代码目录完整路径: {summary['code_directory']}")
    print(f"14. 审计报告完整路径: {summary['audit_report']}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
