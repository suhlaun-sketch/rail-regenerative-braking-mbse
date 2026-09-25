# GitHub 私有交接发布记录

目标仓库：`https://github.com/suhlaun-sketch/rail-regenerative-braking-mbse`（private）；发布副本由独立目录构造，源工程只读。60 个标记 FROZEN 的文件中，59 个源文件副本逐一对源文件 SHA-256 比对，差异 0；其余一个是从正式 SysON 服务导出的 Project ZIP。清单为 `docs/ARTIFACT_MANIFEST.csv`，记录 1,492 个可发布源文件；其中 16 个正式 FMU、16 个正式 SLX、正式 SysML/Req/SSD/SSP、v2.1 FINAL 结果、Project ZIP 均存在。Git LFS 暂存 129 个对象、约 203.7 MB；不需要额外 GitHub Release 大文件。

本机发布副本实测：`python scripts/check_release.py --hashes` PASS；`npm run build` PASS；前端 5173、后端 `/api/health`/`/api/project/status`/`/api/sysml/summary` 均 HTTP 200。`scripts/run_fmu_job.py` 在 `ui/jobs/` 执行了 16-FMU FMPy 联合仿真，返回 `SYSTEM_PHYSICAL_VV=PASS`，没有写回冻结结果。原生 SSI GUI 入口 `scripts/open_ssi_gui.ps1` 启动了存活的 PyQt 进程。

正式 SysON 2026.7.0 Project ZIP 离线校验：ZIP CRC 正常，68 个 representation 文件，其中 57 个 `AUTO_IBD_`。独立 Docker 8091 环境的重新导入仍在核验，结果必须以后续回导 57 图为准。原 8080/8090 数据库未修改。Neo4j 数据卷和密码未上传；图数据与重建脚本已收录。没有名称为 SSL 的独立正式资产。

敏感文件检查：`.env`/`.env.local`、凭据、Docker 卷、MATLAB 许可证、venv、node_modules、日志和下载包未进入 Git 暂存；历史初始发布无旧提交。源代码内未发现 GitHub token、私钥或明文 Neo4j 凭据。第三方 SysON/MATLAB 程序不重新分发。

全新 clone / LFS 拉取、SysON Project 导入与远端 README 链接检查将在推送后更新本节，未执行前不标 PASS。
