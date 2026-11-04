# 天津地铁牵引电机智能选型与闭环验证报告

## 结论

推荐方案：**A / TME 42-18-4**。硬约束先行过滤，随后只在可行集上执行Pareto与透明评分。权重±20%随机扰动1000次，推荐方案保持第一的比例为 **100.0%**。

## 闭环实现

天津B型车需求基线 → 四个TSA真实候选 → 参数化代理FMU → 正式16组件SSP副本中自动替换L2_5300 → FMPy 0.05 s批量执行4×4场景 → 硬约束/Pareto/评分/敏感性 → CSV、图件和审计。正式模型与正式SSP/FMUs未修改。

## 模型边界

采用 published nameplate data 构造恒转矩/恒功率代理模型。精确厂家效率MAP、热模型、天津线路齿轮比和控制器标定未公开，全部作为统一工程假设，不作为厂家事实。

## 硬约束

- A TME 42-18-4: ACC040 PASS; ACC080 PASS; SPEED PASS; BRAKE PASS; overall PASS
- B TME 45-19-4: ACC040 FAIL; ACC080 PASS; SPEED PASS; BRAKE PASS; overall FAIL
- C TME 46-17-4: ACC040 PASS; ACC080 PASS; SPEED PASS; BRAKE PASS; overall PASS
- D TMR 50-20-4: ACC040 PASS; ACC080 PASS; SPEED PASS; BRAKE PASS; overall PASS
