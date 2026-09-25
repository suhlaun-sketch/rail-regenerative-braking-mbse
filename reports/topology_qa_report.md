# Topology QA Report

- Overall: PASS
- Voltage Continuity: PASS
- Hard-rule violations: 0

## 12 Global Closure Checks

- AC主供电路径: **PASS** — none
- 主变二次交流路径: **WARNING** — 5121/5122输入链的具体部署/支路选择尚无证据；已阻止高压交流跨主变直连5131。
- DC Link网络: **PASS** — 5145无ITM-PHY-003物理口，按实际Port结构作为检测保护信号设备，不伪造Net成员。
- 电机三相交流路径: **PASS** — none
- 机械牵引路径: **WARNING** — 联轴节variant未选择；Motor→候选Coupling→Gearbox高速侧→低速侧→Axle→Wheel候选链均已生成。
- 再生回馈路径: **WARNING** — 依赖未决Coupling variant；物理候选保持双向，未生成跨级捷径。
- 超级电容储能路径: **PASS** — none
- 制动电阻耗散路径: **PASS** — none
- 服务制动控制路径: **WARNING** — 部分Command存在多源或I/O部署歧义，保留UNRESOLVED而未直接驱动气动设备。
- ATP/紧急制动路径: **WARNING** — E100/8127/安全逻辑的I/O部署与命令仲裁存在UNRESOLVED_ROUTE。
- 气动制动执行路径: **WARNING** — 候选气动Net已形成，但单端口卡钳的内部力传递粒度不足，不伪造额外Port。
- 主回路回流路径: **WARNING** — NET-MAIN-RETURN-01已建立，至轮轨/变电所回流边界的明确端口证据不足。

## Voltage observation locations

- U_grid: PASS — BOUNDARY-CATENARY-25KV / 4111接触面
- U_transformer_primary: PASS — 4511 ITM-PHY-001 boundary
- U_transformer_secondary: PASS — 4511 ITM-PHY-014 boundary
- U_dc: PASS — NET-DC-LINK-01
- U_motor: PASS — 5132↔5311 ITM-PHY-004 boundary
- U_sc: PASS — NET-STORAGE-DC-SC-01 / X121

## Structural checks

- kg_v1_frozen: PASS
- coverage_exactly_once: PASS
- candidate_endpoints_active: PASS
- hard_rule_violations_zero: PASS
- net_member_violations_zero: PASS
- unique_net_membership: PASS
- dc_link_not_clique: PASS
- dc_storage_domains_separated: PASS
- no_motor_mechanical_shortcuts: PASS
- sensor_taps_not_series: PASS
- no_final_CONNECTS_TO: PASS
