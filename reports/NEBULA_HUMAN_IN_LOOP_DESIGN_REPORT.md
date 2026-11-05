# NEBULA 工程师参与式设计与多需求匹配验收报告

## 实施结果

目标页面 `/knowledge-graph/nebula-engineering` 已从“首个需求自动展开”升级为工程师参与式流程：自然语言目标 → 多需求候选 → 需求集合确认 → 功能集合审查 → 规则与证据驱动建议 → 功能集合确认 → 真实架构、端口和参数展开。工程设计模式默认启用；比赛演示模式只复用已经确认的草案。

草案保存在浏览器会话并可导出 JSON。增删、排除、接受建议、撤销均不写回 Neo4j、SysML、需求库或仿真资产。

## 真实查询案例

工程目标：`我希望列车在满足制动安全要求的同时，提高再生制动能量回收水平。`

语义接口实际返回 5 个需求：

- `REQ-BRK-007` 再生制动优先需求，排序分 14.5
- `PRJ-ENE-004` 再生充电 SOC 上限需求，排序分 9.5
- `REQ-ENE-001` 电容式储能电源储存功能需求，排序分 9.5
- `REQ-ENE-007` 储能过温保护需求，排序分 9.5
- `REQ-ENE-008` 储能过流保护需求，排序分 9.5

页面明确说明排序分不表示工程满足度。五个 Requirement 均通过正式 ID 精确映射到 Neo4j；没有使用名称猜测。

验收中工程师选择 `REQ-BRK-007` 与 `PRJ-ENE-004`。正式语义映射去重后得到 `FN_F_X100_01`（吸收、存储并按需释放再生制动能量），其正式关联需求为 `PRJ-ENE-004`。`REQ-BRK-007` 当前没有功能承接，因此显示“待核验”，没有补造关系。

工程师移除 `FN_F_X100_01` 后，规则分析产生 2 条覆盖建议；接受正式映射恢复建议后，从正式功能库补充 `FN_F_3111_01`（通过车轮耗散能量）。补充功能保留“正式实体、当前需求未正式关联、待核验”状态。最终确认功能为：

- `FN_F_X100_01`
- `FN_F_3111_01`

确认后仅这两个 Function 进入当前设计路径。未确认的同需求 Function 被裁剪，未混入后续架构。实际展开得到 2 个 Requirement、2 个 Function、3 个 Product、3 个 Port、2 个 Item；知识库没有独立 Logical 实体，页面持续显示 `Logical 0`，Product 只标为现有架构/物理承接。

## 优化机制

优化建议由正式映射与草案差异触发：需求覆盖、移除影响、同一正式需求集合的覆盖重叠、人工补充功能的需求依据。名称相似不会被直接判为冗余。建议包含影响需求、证据、风险、约束和待核验状态；建议不会自动应用。

## 数据一致性与只读保护

- 语义 Requirement/Function 与 Neo4j 只接受 `id`、`requirement_id`、`function_id`、`kg_v2_id`、`code` 的精确相等映射。
- 查询只调用 `/api/semantic/*` 和 GraphQL Query；未调用 GraphQL Mutation。
- Neo4j、SysML、V2 Excel、仿真资产均未修改。
- 草案分离保存候选集合、确认集合、排除项、人工补充项、建议决策、时间与阶段。

## 浏览器验收

1600×900 Edge 实际点击通过：

1. 未确认草案时启动比赛演示会被阻止。
2. 实际返回 5 个候选 Requirement。
3. 选择其中 2 个并确认。
4. 正式关联 Function 去重后为 1 个。
5. 移除功能后显示受影响需求。
6. 从正式功能库增加 `FN_F_3111_01`。
7. 生成当前方案与建议方案差异，2 条建议可逐项接受或拒绝。
8. 最终确认 2 个 Function。
9. 只沿确认后的真实关系展开架构、接口与参数。
10. 比赛演示复用已确认草案并正常启动。
11. 原生 Three.js NEBULA 保持运行，画布与镜头控制存在。
12. 浏览器控制台错误为 0。

截图：

- `reports/assets/nebula_human_in_loop/01_requirement_candidates.png`
- `reports/assets/nebula_human_in_loop/02_function_review.png`
- `reports/assets/nebula_human_in_loop/03_optimization_diff.png`
- `reports/assets/nebula_human_in_loop/04_architecture_expansion.png`

结构化记录：

- `reports/assets/nebula_human_in_loop/qa.json`
- `reports/assets/nebula_human_in_loop/real_query_record.json`

## 验证

- TypeScript `tsc --noEmit -p tsconfig.app.json`: PASS
- 浏览器真实查询与交互：PASS
- Neo4j 精确 ID 映射：PASS（5/5 Requirement；2/2 最终 Function）
- 控制台新增错误：0
- Neo4j 写入：NO
- 正式资产修改：NO
- `/trace` 与 `/knowledge-graph/nebula-native`：保留
