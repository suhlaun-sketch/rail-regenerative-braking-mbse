# 常见问题

**`git lfs pull` 后文件仍很小**：执行 `git lfs ls-files` 与 `python scripts/check_release.py --hashes`；若哈希失败，检查是否具有私有仓库访问权和 LFS 配额。

**UI 无法启动**：确认 `py -3.10 --version`、`node --version`、`npm --version`；查看本地 `ui/logs/`。8000/5173 端口占用时先停止旧服务。Neo4j 不可用时检查本地环境配置，不把口令写入日志。

**SysON 无法导入或看不到 57 图**：确认 Docker Desktop 已运行、镜像版本 2026.7.0、Project ZIP 完整；导入必须看到 `UploadProjectSuccessPayload`。导入后的 Project ID 可能变化。单独导入 SysML 文本不会有 57 张 representation。8080 占用时改 `tools/syson-local/.env` 的端口。

**Simulink 打不开**：需要本机 MATLAB/Simulink 和许可证；仓库仅提供 `.slx`，没有 MATLAB 程序。无许可证时查看 FMU XML、冻结 CSV 和报告。

**已有脚本输出可能写回冻结资产**：不要直接运行 `run_ssi_all16.py` 或 `rail_fmu_cosim_runner_v2_1.py`。FMU 重算使用 `scripts/run_fmu_job.py`。
