# Neo4j Interface Layer KG pipeline

本目录使用项目内 `.venv`（基于 `D:\Computer\Anaconda\envs\mineru\python.exe` 创建），不修改全局 Python。安装：

```powershell
D:\Computer\Anaconda\envs\mineru\python.exe -m venv tools\kg_pipeline\.venv
tools\kg_pipeline\.venv\Scripts\python.exe -m pip install -r tools\kg_pipeline\requirements.txt
Copy-Item tools\kg_pipeline\.env.example tools\kg_pipeline\.env
```

在 `.env` 填写本机 `NEO4J_PASSWORD` 后执行 `tools\kg_pipeline\.venv\Scripts\python.exe tools\kg_pipeline\run_kg_pipeline.py`。程序先探查源表，再抽取变深度层级；Product/Item/Profile 使用 `project_id=RAIL_MBSE_TRACTION_BRAKE` 幂等 UPSERT。D/X 来自显式 `custom_products` 项目扩展，E100 是 level-2 external_system 叶节点。端口只作为 `Product-[:EXPOSES]->Item` 关系属性保存，不创建 Port 节点或任何 Connection。

目标数据库必须已存在且名称严格为 `motor-brake-system`；程序不会创建、清空或删除数据库。
