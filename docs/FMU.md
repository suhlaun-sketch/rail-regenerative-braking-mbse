# 16 个正式 FMU

`work/simulation/simulink_fmu_v2_1_final/05_fmu/L2_*.fmu` 是 16 个正式 FMU；`validated/` 存历史校验副本，不计入正式数量。每个 FMU 都是 ZIP 容器，内含 `modelDescription.xml`，其中的 FMI version、变量名、causality、unit 可用 `python scripts/check_release.py` 批量验证。冻结接口验证见 `FMU_Interface_Validation_v2_1.json`，组件注册表见 `Rail_MBSE_FMU_Model_Registry_v2_1.json`。

无 MATLAB 许可证也能查看 XML 接口和运行 FMPy。Windows PowerShell 安装独立环境：

```powershell
python -m venv .venv-fmu
./.venv-fmu/Scripts/python.exe -m pip install -r requirements-fmu.txt
./.venv-fmu/Scripts/python.exe scripts/check_release.py --hashes
```

重新联合仿真请使用 [COSIMULATION](COSIMULATION.md) 的安全 jobs 包装脚本；直接运行旧 `09_tools/rail_fmu_cosim_runner_v2_1.py` 会写入冻结 `07_results/` 和 `08_reports/`，不应执行。
