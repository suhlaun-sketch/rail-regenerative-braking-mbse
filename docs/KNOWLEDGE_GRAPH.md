# Neo4j 数字线程

图数据库数据卷、口令未发布。可共享来源为 `tools/kg_pipeline/work/graph_data.json`、`tools/kg_pipeline/config/graph_schema.yaml` 和 `tools/kg_pipeline/` 的提取、导入、QA 脚本。安装 Neo4j 后在本地环境设置 `NEO4J_URI`、`NEO4J_DATABASE`、`NEO4J_USER`、`NEO4J_PASSWORD`；默认逻辑目标为 `neo4j://127.0.0.1:7687`、数据库 `motor-brake-system`。密码只在本机 `.env.local`/环境变量设置，不能提交。

`tools/kg_pipeline/README.md` 是重建入口。重建会写入**你自己的空 Neo4j 数据库**，不可指向工作机正式库；只读工作台查询使用已有数据库。仓库没有可验证的一致性 Neo4j 数据库快照；因此图数据“可重建”，不能声称 clone 后立即具有同样的在线节点/关系数。
