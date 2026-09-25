# 可复现性边界

`python scripts/check_release.py --hashes` 检查发布资产的本地哈希、16 FMU 的 XML、16 Simulink 模型和 Project ZIP 的 57 个 `AUTO_IBD_` 文件。`./scripts/start_ui.ps1` 可启动只读工作台；`./scripts/start_syson.ps1` + `python scripts/import_syson_project.py` 可向独立数据库恢复带 representation 的正式 Project。FMPy 运行需安装 `requirements-fmu.txt` 并使用 `scripts/run_fmu_job.py`，产生独立 jobs 结果。MATLAB/Simulink 重新计算需要商业软件和许可证。

资产移动仅发生在发布副本；原 `SOURCE` 内的冻结模型/数据未改写。Git LFS 下载后脚本重新 SHA-256 校验。`docs/publishing/GITHUB_PUBLISH_REPORT.md` 记录上传和新克隆实测，未运行的项目明确标注。
