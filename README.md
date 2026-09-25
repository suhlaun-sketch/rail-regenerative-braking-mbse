# 智轨跃迁：牵引—再生制动—储能 MBSE 数字工程平台

这是同事交接用的完整工程仓库。它串联正式需求、SysML v2、SysON 图形 Project、SSI/SSD、16 个 Simulink 模型、16 个 FMI 2.0 FMU、Executable SSP、FMPy 联合仿真、V&V、Neo4j 数字线程和 React/FastAPI 工作台。**冻结 v2.1 结果可直接查看；重新计算需要相应软件。**

| 能力 | 直接查看 | 需要的软件 |
|---|---|---|
| 工作台、正式模型、SSD/SSP、FMU 接口、冻结结果 | 是 | Windows 10/11、Python 3.10、Node 24 |
| 57 张正式 SysON 表示 | 导入本仓库 Project ZIP 后 | Docker Desktop，SysON 2026.7.0 |
| SSI 图形界面 | 源码和正式 SSD 可查看 | Python 3.11、PyQt5 |
| FMU 联合仿真 | 冻结 CSV 可查看 | FMPy 0.3.26；重算须使用独立 jobs 输出 |
| Simulink 源模型 | 文件和预览（若有）可查看 | MATLAB/Simulink 许可证 |
| Neo4j 数字线程 | 结构与重建脚本可查看 | 可选 Neo4j，本地自设密码 |

仓库采用 Git LFS 保存大文件。获得私有仓库权限后，在 PowerShell 运行：

```powershell
git clone https://github.com/suhlaun-sketch/rail-regenerative-braking-mbse.git
cd rail-regenerative-braking-mbse
git lfs pull
python scripts/check_release.py --hashes
./scripts/start_ui.ps1
```

打开 [http://127.0.0.1:5173](http://127.0.0.1:5173)，后端健康检查为 [http://127.0.0.1:8000/api/health](http://127.0.0.1:8000/api/health)。首次启动会安装 Python/npm 依赖；以后可用 `./scripts/stop_ui.ps1` 关闭。无 MATLAB 许可证仍可浏览只读 UI、FMU 接口和冻结结果。具体操作见 [UI_SETUP](docs/UI_SETUP.md)。

SysON 正式 Project 采用 **2026.7.0** 导出，ZIP 位于 [artifacts/syson/Rail_Regenerative_Braking_MBSE_FULL.zip](artifacts/syson/Rail_Regenerative_Braking_MBSE_FULL.zip)。安装 Docker Desktop 后，复制 `tools/syson-local/.env.example` 为 `tools/syson-local/.env`，设置本机专用密码，运行 `./scripts/start_syson.ps1` 和 `python scripts/import_syson_project.py`。详细版本、导入及 57 图核验见 [SYSON_SETUP](docs/SYSON_SETUP.md)。本机原有的 8090 Docker **2026.9.0** 是独立测试环境，不能当作正式 Project。当前 Interconnection View Description 的自动创建映射仍有问题，见 [已知限制](docs/SYSON_KNOWN_LIMITATIONS.md)。

冻结结果入口：[v2.1 FINAL 状态](work/simulation/simulink_fmu_v2_1_final/08_reports/Final_Status_v2_1.txt)、[主仿真 CSV](work/simulation/simulink_fmu_v2_1_final/07_results/Rail_MBSE_All16_FMU_CoSimulation_Results_v2_1.csv)、[仿真报告](work/simulation/simulink_fmu_v2_1_final/08_reports/Rail_MBSE_Simulink_FMU_CoSimulation_v2_1_Report.md)、[V&V](docs/VERIFICATION_AND_VALIDATION.md)。UI 的回放读取冻结数据；重新计算是另一项操作，不能覆盖它们。

```mermaid
flowchart LR
  Req[正式需求 V2] --> SysML[SysML v2 / SysON]
  SysML --> SSI[SSI 转换]
  SSI --> SSD[16 组件 SSD]
  SSD --> Binding[接口与 FMI 绑定]
  Binding --> Models[16 Simulink / 16 FMU]
  Models --> SSP[Executable SSP]
  SSP --> CoSim[FMPy 联合仿真]
  CoSim --> VV[V&V / 能量审计]
  VV --> UI[工作台 / 数字线程]
```

模型规模来自仓库内 [层级记录](work/reports/FULL_PRODUCT_HIERARCHY.json)：Product 147（L1/L2/L3/L4 为 8/16/34/89）；正式 Project 导出含 57 张 `AUTO_IBD_` 表示。Executable SSP 记录 16 FMU、151 FMI 变量、87 执行连接，v2.1 冻结状态记录联合仿真与物理 V&V PASS。**这些是已归档结果；新机器上的实测以本机校验脚本为准。**

| 资料 | 入口 |
|---|---|
| 资产、SHA-256、来源、下载方式 | [ARTIFACT_MANIFEST](docs/ARTIFACT_MANIFEST.md) / [CSV](docs/ARTIFACT_MANIFEST.csv) |
| 正式需求和模型 | [项目结构](docs/PROJECT_STRUCTURE.md) |
| SSI → SSD → SSP | [SSI_SSD](docs/SSI_SSD.md) |
| 接口合同 | [IMPLEMENTATION_BINDING](docs/IMPLEMENTATION_BINDING.md) |
| FMU、Simulink | [FMU](docs/FMU.md)、[MATLAB_SIMULINK](docs/MATLAB_SIMULINK.md) |
| 联合仿真与核验 | [COSIMULATION](docs/COSIMULATION.md)、[RESULTS_AND_VV](docs/RESULTS_AND_VV.md) |
| Neo4j | [KNOWLEDGE_GRAPH](docs/KNOWLEDGE_GRAPH.md) |
| 常见问题、可复现范围 | [TROUBLESHOOTING](docs/TROUBLESHOOTING.md)、[REPRODUCIBILITY](docs/REPRODUCIBILITY.md) |

此仓库目前未授予项目代码统一的开源许可证；仅向获得私有仓库访问权的同事交接。第三方 SSI 源码保留其原许可证和引用信息；SysON、MATLAB 程序与许可证不在仓库内。见 [外部来源](docs/DATA_AND_STANDARD_SOURCES.md) 和 [排除清单](docs/EXCLUDED_THIRD_PARTY_MATERIALS.md)。
