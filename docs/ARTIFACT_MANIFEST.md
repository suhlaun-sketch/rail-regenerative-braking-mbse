# 发布资产清单

共 1492 个发布文件，其中 60 个标记为 FROZEN。
逐文件相对路径、用途、字节数、SHA-256、来源、冻结状态、下载方式见 [CSV](ARTIFACT_MANIFEST.csv)。
所有 LFS 文件须在 clone 后执行 git lfs pull；运行 python scripts/check_release.py --hashes 校验。

| 类别 | 文件数 |
|---|---:|
| Executable SSP | 12 |
| FMI binding | 49 |
| FMU | 107 |
| Formal SysON Project | 1 |
| Knowledge graph | 15 |
| Requirements | 2 |
| SSI/SSD | 42 |
| Simulation result | 107 |
| Simulink | 48 |
| Supporting source/data | 956 |
| SysML | 67 |
| UI backend | 48 |
| UI frontend | 38 |

正式 SysON ZIP 来自 Project export；57 张 IBD 位于 ZIP 的 representations 内。
正式 16 FMU 和 16 SLX 仅计 05_fmu 目录一级与 01_models；validated/ 历史副本不计。
排除目录/文件见 [排除项](EXCLUDED_THIRD_PARTY_MATERIALS.md)。
本次冻结副本 SHA-256 对源文件比较：PASS；不一致 0 项。
