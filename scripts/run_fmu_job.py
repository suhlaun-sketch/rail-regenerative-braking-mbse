"""Run the existing v2.1 FMPy model with all writable paths redirected to a job."""
from __future__ import annotations

import argparse
import contextlib
import io
import sys
import uuid
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
TOOLS = ROOT / "work/simulation/simulink_fmu_v2_1_final/09_tools"
sys.path.insert(0, str(TOOLS))


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--job-id", default=None)
    args = parser.parse_args()
    job_id = args.job_id or uuid.uuid4().hex
    if not job_id.replace("-", "").isalnum() or len(job_id) > 64:
        parser.error("job-id must be alphanumeric or contain hyphens (max 64)")
    job = ROOT / "ui/jobs" / job_id / "fmu"
    job.mkdir(parents=True, exist_ok=False)
    import rail_fmu_cosim_runner_v2_1 as runner
    runner.RES = job / "results"
    runner.REP = job / "reports"
    runner.RES.mkdir()
    runner.REP.mkdir()
    runner.core.RESULT_DIR = runner.RES
    runner.core.LOG_DIR = job / "runtime"
    runner.core.LOG_DIR.mkdir()
    print(f"JOB={job.relative_to(ROOT)}")
    output = io.StringIO()
    with contextlib.redirect_stdout(output):
        code = runner.main()
    status_file = runner.REP / "Final_Status_v2_1.txt"
    if status_file.is_file():
        status = status_file.read_text(encoding="utf-8")
        status = status.replace("MATLAB_STARTUP = PASS", "MATLAB_STARTUP = NOT_RUN")
        status = status.replace("REBUILT_COMPONENTS = L2_7200,L2_8100", "REBUILT_COMPONENTS = NOT_RUN")
        status_file.write_text(status, encoding="utf-8")
    print(f"FMU_COSIM={'PASS' if code == 0 else 'FAIL'}")
    return code


if __name__ == "__main__":
    raise SystemExit(main())
