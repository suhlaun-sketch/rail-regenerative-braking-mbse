# 16 个 Simulink 源模型

正式 `.slx` 位于 `work/simulation/simulink_fmu_v2_1_final/01_models/L2_*.slx`，脚本在 `09_tools/`，参数在 `02_parameters/`。对应 FMU 在 `05_fmu/`。`python scripts/check_release.py` 对 16 个模型/16 个 FMU 做只读计数。

打开模型需要本机 MATLAB、Simulink 及项目原建模环境对应的工具箱/许可证。原 `Final_Status_v2_1.txt` 记载 MATLAB 启动 PASS，但这不代表新机器已有许可证；精确 MATLAB release/工具箱以原项目的构建记录或实际 `ver` 为准，仓库不分发 MATLAB。可在 MATLAB 中先 `cd` 到仓库根目录，再执行 `open_system('work/simulation/simulink_fmu_v2_1_final/01_models/L2_3100.slx')`。打开后不要保存覆盖冻结模型。无许可证可继续使用 UI、FMU 接口、SSP 结构与冻结结果。
