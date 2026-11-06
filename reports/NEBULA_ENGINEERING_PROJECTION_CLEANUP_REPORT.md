# NEBULA 工程投影清理验收报告

验收页面：`/knowledge-graph/nebula-engineering`

## 结论

NEBULA 已恢复“完整数据检索、轻量画布投影”的边界。语义结果、追溯子图和工程师草案完整保存在数据层；画布只按当前阶段投影真实实体。工程模式不再渲染无数据的 Agent 星团、中央装饰星核、三圈轨道和轨道尘埃。

## 真实查询

查询：`我希望列车在满足制动安全要求的同时，提高再生制动能量回收水平。`

| 指标 | 实测 |
|---|---:|
| 命中 Requirement | 5 |
| 检索 Function（去重） | 1 |
| 可追溯 Function | 1 |
| 工程师确认 Function | 1 |
| Product | 1 |
| 完整路径画布对象 | 7 |
| 完整路径画布关系 | 5 |

该查询的正式映射只有一个 Function。系统按真实结果展示，没有生成补位功能。

## 投影与粒子对比

| 指标 | 修改前工程模式 | 修改后完整路径 | 变化 |
|---|---:|---:|---:|
| 原版预设星团 | 12 | 3 个真实类型星团 | -75.0% |
| 无数据星团 | 多个预设星团 | 0 | 清零 |
| 背景/轨道装饰粒子 | 6,900 | 468 | -93.2% |
| 总渲染 Points | 72,668 | 7,362 | -89.9% |
| Draw Calls | 89 | 16 | -82.0% |
| WebGL | WebGL2 + Composer | WebGL2 + Composer | 保留 |

阶段实测：需求确认显示 1 个星团、2,298 个工程星团粒子；功能审查显示 2 个星团、4,596 个工程星团粒子；完整路径显示 3 个星团、6,894 个工程星团粒子。三个阶段的无数据星团均为 0。

Requirement、Function、Product 的世界坐标在阶段切换前后分别固定为 `(-14,-2)`、`(-6,2)`、`(2,-1)`。新增类型只增量出现，已有类型没有随机重排。相机使用当前有效星团包围盒和上下可见区域适配，底部工作台展开后仍保留主关系链。

## 完整数据与缓存

- `semanticResult` 与 `EngineeringDraft` 保存完整 Requirement、Function 和映射证据。
- `knowledgeGraph` 保存确认后的完整追溯子图；`capGraph()` 只产生画布投影，不改变完整数据。
- `canvasGraph` 按需求、功能、架构、接口、参数阶段筛选类型。
- V2 Function 合并按正式 ID 去重，并合并 `matched_by_requirements` 与 `mapping_evidence`。
- 重复确认测试中，首次请求为 5 次 RequirementTrace、1 次 FunctionTrace、5 次 Requirement detail；再次确认功能、返回需求并重新确认后，请求计数保持不变，缓存命中有效。

页面分别展示检索功能数、可追溯功能数、确认功能数和当前画布对象数。显示上限 36/60/80 只控制画布投影，不截断草案中的功能集合。

补充规模测试覆盖 5 条与 10 条需求，以及 0 个与 1 个正式功能的真实返回。所有场景均按 API 原值展示；功能为 0 时保持空集合，没有添加模拟实体。记录见 `semantic-scale-qa.json`。

## 浏览器验收

- 1600×900：需求、功能和完整路径均在中上部可见；紧凑工作台未遮挡星团。
- 1366×768：紧凑与展开工作台均通过；展开高度未超过可视区 35%，主关系链位于面板上方。
- 完整路径硬件采样：38–43 FPS，平均 40.6 FPS；WebGL2、Intel D3D11、Composer 启用。
- 浏览器控制台错误：0。
- 原生验收路由回归：12 个星团、78,264 Points、CRAWLER 与 Agent HUD 均保持，工程投影清理没有改变原生基线。

截图：

- 修改前：`reports/assets/nebula_layout_operation_fix/03_architecture_compact_1600x900.png`
- 1600×900 完整路径：`reports/assets/nebula_projection_cleanup/05_complete_compact_1600x900.png`
- 1366×768 紧凑：`reports/assets/nebula_projection_cleanup/06_complete_compact_1366x768.png`
- 1366×768 展开：`reports/assets/nebula_projection_cleanup/07_complete_review_1366x768.png`
- 完整诊断：`reports/assets/nebula_projection_cleanup/qa.json`
- 缓存回归：`reports/assets/nebula_projection_cleanup/cache-qa.json`
- 数据规模回归：`reports/assets/nebula_projection_cleanup/semantic-scale-qa.json`

Neo4j、SysML、仿真资产和正式需求库均为只读，未执行写入。
