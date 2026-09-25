# SysON 安装与正式 Project 恢复

正式环境使用 SysON **2026.7.0**（原工作机为本机 JAR + PostgreSQL，8080）。本仓库提供同版本 Docker Compose，使用独立命名卷。2026.9.0 Compose 仅用于 8090 测试，不能替代正式 Project 的验收。SysON 程序由 [SysON 官方安装页](https://doc.mbse-syson.org/syson/v2026.7.0/installation-guide/how-tos/install.html) 下载；仓库不分发其镜像/JAR。

先安装 Docker Desktop，启动 Docker 引擎。从仓库根目录：

```powershell
Copy-Item tools/syson-local/.env.example tools/syson-local/.env
# 编辑 .env，将 SYSON_DB_PASSWORD 改为仅本机使用的密码
./scripts/start_syson.ps1
docker compose -f tools/syson-local/compose.yaml ps
python scripts/import_syson_project.py --url http://127.0.0.1:8080
```

在浏览器打开 `http://127.0.0.1:8080`。正式导出包 [Rail_Regenerative_Braking_MBSE_FULL.zip](../artifacts/syson/Rail_Regenerative_Braking_MBSE_FULL.zip) 由原 2026.7.0 Project 的 `GET /api/projects/{projectId}` 下载。来源 Project 名 `Rail_Regenerative_Braking_MBSE_FULL`，原 ID `e44ac856-b4b0-4fb8-a94a-0ce1a6d722b8`，EditingContext ID `67dd7e52-bdf8-42dd-b5eb-8325e5c13a68`。导入后以 **返回的新 ID** 为准。ZIP 已离线核验：68 个 representation 文件，其中 57 个 `AUTO_IBD_`；同时包含 3 个模型文档。`python scripts/check_release.py --hashes` 校验 ZIP 与全部列入清单的资产。

打开导入的 Project 后，左侧 Representations 找 `AUTO_PRODUCT_ARCHITECTURE_ROOT`、`AUTO_IBD_3000`、`AUTO_IBD_3100`、`AUTO_IBD_3110`。也可在对应 Product 的 Representations 中打开；不能假定双击节点就是下钻。57 图详细名称/ID/统计见 `work/reports/FULL_SYSON_VIEW_REGISTRY.json`、`FULL_IBD_COMPLETENESS.json` 和 `FULL_SYSON_FINAL_QA.json`。图形端口归属及 View Description 问题见 [已知限制](SYSON_KNOWN_LIMITATIONS.md)。Project ZIP 是带 representation 的可恢复导出；单独导入 SysML 文本不能恢复这 57 张图。

停止与 Project 备份（将导入后得到的新 ID 代入）：

```powershell
./scripts/backup_syson_project.ps1 -ProjectId <导入后的Project-ID>
./scripts/stop_syson.ps1
# 数据在 Docker 命名卷；跨机器优先使用 Project ZIP 恢复
```

测试环境：`./scripts/start_syson.ps1 -Test2026_9` 将启动 2026.9.0 到 8090，使用另一数据库卷。请先检查 8090 是否已由本机旧测试服务占用。不要把测试图写回正式 Project。若 8080 已占用，修改本地 `.env` 的 `SYSON_FORMAL_PORT`，导入命令中的 URL 同步改端口。导入依赖 SysON GraphQL multipart upload，操作后检查返回的 `UploadProjectSuccessPayload`；若失败，不要声称恢复完成。

官方资料：[安装](https://doc.mbse-syson.org/syson/v2026.7.0/installation-guide/how-tos/install.html)、[API cookbook](https://doc.mbse-syson.org/syson/v2026.9.0/developer-guide/api/api-cookbook.html)、[升级说明](https://doc.mbse-syson.org/syson/main/installation-guide/migration-process.html)。
