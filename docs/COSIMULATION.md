# FMI 联合仿真

冻结 v2.1 由 16 个 FMI 2.0 FMU、FMPy 0.3.26、显式 Jacobi、0.05 s 通信步长、50 s 工况组成。正式执行装配 `work/simulation/simulink_fmu_v2_1_final/06_ssp/Rail_MBSE_All16_Executable_v2_1.ssp`；冻结主 CSV 在 `07_results/`，审计/V&V 在 `07_results/` 和 `08_reports/`。运行程序原件位于 `09_tools/rail_fmu_cosim_runner_v2_1.py`，其默认输出指向冻结目录。

请从仓库根目录运行安全包装脚本，输出将进入新的 `ui/jobs/<job_id>/fmu/`：

```powershell
python -m venv .venv-fmu
./.venv-fmu/Scripts/python.exe -m pip install -r requirements-fmu.txt
./.venv-fmu/Scripts/python.exe scripts/run_fmu_job.py
```

脚本只改运行时输出目录，不修改模型/FMUs/SSD/SSP/FINAL。若要核对冻结数据，直接打开 CSV/报告，称为“回放”；上述命令才是“重新计算”。计算时间、结果会随运行机变化；新结果不自动替代冻结 PASS。
