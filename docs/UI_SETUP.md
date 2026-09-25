# 工作台启动

环境：Windows 10/11、Python 3.10（`python` 或 `py -3.10` 可用）、Node.js 24/npm 11。无需 MATLAB 即可查看冻结数据和 FMU 接口。根目录执行 `./scripts/start_ui.ps1`：脚本创建 `ui/backend/.venv`、安装 `ui/backend/requirements.txt`、在 `ui/frontend` 执行 `npm ci`，然后启动 8000 后端与 5173 Vite。服务进程 ID 与日志写入忽略上传的 `ui/logs/`。`./scripts/stop_ui.ps1` 结束进程。

```powershell
python scripts/check_release.py --hashes
./scripts/start_ui.ps1 -NoBrowser
Invoke-RestMethod http://127.0.0.1:8000/api/health
Invoke-WebRequest http://127.0.0.1:5173 -UseBasicParsing
Push-Location ui/frontend; npm run build; Pop-Location
```

工作台使用 `ui/backend/app/main.py` 和 `ui/frontend/src`。Neo4j 未配置时只读页面仍能启动；连接状态由实际后端决定。回放使用 `work/simulation/simulink_fmu_v2_1_final/07_results` 的冻结 CSV。**不要将旧的仿真/SSI 生成脚本直接指向冻结路径重新运行。**
