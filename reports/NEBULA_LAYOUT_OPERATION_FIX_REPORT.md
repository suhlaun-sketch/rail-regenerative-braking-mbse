# NEBULA 工程知识设计工作台可视区域与持续操作修复报告

## 结论

目标页面 `/knowledge-graph/nebula-engineering` 已完成可视区域、底部工作台和功能审查流程修复。原生 Three.js NEBULA 粒子、轨道、Bloom、稳定布局及工程关系驱动机制保留。Neo4j、SysML、V2 Excel 和仿真资产未写入。

## 根因与修复

### 1. 星云被底部面板遮挡

原生渲染器的 `fitCamera()` 只根据 Shadow DOM 内部 HUD 计算遮挡，无法感知 React 页面顶部工具区和底部草案面板。阶段镜头按完整窗口宽高计算距离，面板展开或窗口缩小时仍把星团放在被遮挡区域。

新增 `viewport` 场景事件，将顶部和底部安全区传入原生渲染器。`fitCamera()` 现在以真实可见区作为投影边界，自动计算 view offset；`frameEngineering()` 按可见高度重新计算视距。面板展开、收起和窗口 resize 都会触发一次稳定重算，不在动画帧中反复布局。

### 2. 底部面板空间利用异常

旧面板固定 330px，高度超过 1366×768 视口的 40%；内部采用左侧摘要加横向卡片流，产生横向和纵向嵌套滚动，右侧又出现空白。

新面板默认 108px，只显示目标、候选需求、确认需求、关联功能、选择功能、覆盖缺口和“展开审查”。展开后使用“需求集合｜功能集合｜覆盖及变更影响”三列布局；高度为 `min(34vh, 310px)`，每列只在自身足够宽的纵向内容区滚动。

### 3. 只显示一个功能及确认后无法继续

实际语义查询返回 5 个 Requirement，但正式 Requirement→Function 去重结果只有 1 个：`FN_F_X100_01`。这不是 `slice`、60 节点上限或 `capGraph` 截断；草案功能列表与图谱可视节点上限已经分离。

真正的中断原因是进入 `ARCHITECTURE` 后没有返回编辑入口，旧架构也不会在草案变化后失效。现在支持：

- 显示完整草案功能列表，不使用图谱节点上限截断。
- 连续从正式功能库添加多个 Function。
- 移除、恢复、多选、覆盖缺口检查、建议接受/拒绝和撤销。
- 架构阶段返回需求或功能编辑。
- 返回编辑时立即清除旧播放计划，明确提示架构需要重新计算。
- 再次确认后按当前 Requirement/Function 精确 ID 重新查询和裁剪真实关系。
- 没有当前需求正式映射的功能保持“正式实体、需求关系待核验”状态。

## 真实操作记录

工程目标：`我希望列车在满足制动安全要求的同时，提高再生制动能量回收水平。`

- 原始候选 Requirement：5
- 工程师选择 Requirement：2（`REQ-BRK-007`、`PRJ-ENE-004`）
- 正式关联 Function 原始数 / 去重数：1 / 1
- 移除该功能后的覆盖缺口：2
- 恢复正式关联功能：`FN_F_X100_01`
- 第一次从正式功能库补充：`FN_F_3111_01`
- 第二次从正式功能库补充：`FN_F_3112_01`
- 首次确认功能总数：3
- 首次架构展开：5 Product、6 Port、2 Item
- 返回功能阶段后仍显示全部 3 个功能
- 移除 `FN_F_3112_01` 并重新确认：2 个功能
- 重算后架构：3 Product、3 Port、2 Item

架构数量随草案变化，证明没有保留旧展开结果。

## 双分辨率验收

| 视口 | 紧凑面板 | 展开面板 | 展开占比 | 主要标签可见 |
|---|---:|---:|---:|---|
| 1600×900 | 108px | 250px | 27.8% | PASS |
| 1366×768 | 108px | 261px | 34.0% | PASS |

浏览器控制台错误：0。

## 截图与记录

修复前：

- `reports/assets/nebula_human_in_loop/04_architecture_expansion.png`

修复后：

- `reports/assets/nebula_layout_operation_fix/01_compact_1600x900.png`
- `reports/assets/nebula_layout_operation_fix/02_function_review_three_columns.png`
- `reports/assets/nebula_layout_operation_fix/03_architecture_compact_1600x900.png`
- `reports/assets/nebula_layout_operation_fix/04_architecture_compact_1366x768.png`
- `reports/assets/nebula_layout_operation_fix/05_workbench_expanded_1366x768.png`
- `reports/assets/nebula_layout_operation_fix/qa.json`

## 验证状态

- TypeScript：PASS
- 真实浏览器连续功能操作：PASS
- 功能确认后返回编辑：PASS
- 架构按新草案重算：PASS
- 1600×900 可视区：PASS
- 1366×768 可视区：PASS
- Neo4j 写入：NO
- 冻结资产修改：NO
