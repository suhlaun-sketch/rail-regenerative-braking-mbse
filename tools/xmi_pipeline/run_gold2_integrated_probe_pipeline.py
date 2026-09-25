from __future__ import annotations

import json
import subprocess
import sys
from pathlib import Path


PIPELINE_DIR = Path(__file__).resolve().parent
STEPS = [
    "26_parse_gold2_full.py",
    "27_build_gold2_integrated_contracts.py",
    "28_build_gold2_integrated_probe.py",
    "29_validate_gold2_integrated_probe.py",
]


def main() -> None:
    for step in STEPS:
        subprocess.run([sys.executable, "-X", "utf8", str(PIPELINE_DIR / step)], check=True, capture_output=True, text=True, encoding="utf-8")
    validation = json.loads((PIPELINE_DIR / "work" / "integrated_probe_validation_v2.json").read_text(encoding="utf-8"))
    print(
        json.dumps(
            {
                "status": validation["summary"]["status"],
                "qa": f"{validation['summary']['pass']}/30",
                "probe": validation["probe"],
                "ready": validation["READY_FOR_MAGICDRAW_TEST"],
            },
            ensure_ascii=False,
        )
    )


if __name__ == "__main__":
    main()
