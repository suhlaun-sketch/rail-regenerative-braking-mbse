# SSI / SSD / SSP

真实链路：正式 SysML → `tools/ssi_adapter/` 的 compatibility projection → 第三方 SSI Transformer → 正式结构 SSD → FMI 实施接口合同 → Executable SSP。正式 16 组件 SSD 是 `work/sysmlv2/ssi_integration/03_ssd/Rail_MBSE_L2_All16_v1.ssd`；映射 JSON 在同目录。Executable SSP 位于 `work/simulation/simulink_fmu_v2_1_final/06_ssp/Rail_MBSE_All16_Executable_v2_1.ssp`，对应的 `.ssd` 与验证/traceability JSON 在同目录。SSD 是结构映射结果，SSP 是执行总装包，不可混称。

原生 SSI GUI 入口是真实 `third_party/ssi_transformer/Standard-System-Interface/source/SSI_transformer.py`；源码来自 [Standard-System-Interface](https://github.com/mvd-oulu/Standard-System-Interface)，附原 MIT LICENSE/CITATION。`./scripts/open_ssi_gui.ps1` 在本机安装 Python 3.11/PyQt5 后启动它。旧 `tools/ssi_transformer/run_ssi_transformer.ps1` 内含原工作站的 `C:\SSI_Runtime` 路径，供历史追溯，**干净 clone 请用新脚本**。GUI 手工转换与正式 SSD 不是同一件事；正式文件只读。旧 `tools/ssi_adapter/run_ssi_all16.py` 输出固定在正式 SSD 路径，不应用于交接环境重跑。

模型里的 `Part → Component`、`Port → Connector`、`Connection → Connection` 在 `work/sysmlv2/ssi_integration/05_reports/SSI_All16_Integration_Report.md` 有记录。可直接查看 SSD XML、映射及报告；重新转换需要 SSI 环境并输出到新 `ui/jobs/<job_id>/ssi/`。
