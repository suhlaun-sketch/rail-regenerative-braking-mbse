# Executable FMU Interface Resolution v1

## 定位

本文件是 implementation artifact，不是新的 MBSE authority。最终 All16 SSD 继续唯一权威地定义组件、结构 Connector、所有权、74 条跨 L2 拓扑以及源/目标追溯关系。本文件只解析执行层的 scalar quantity、unit、datatype 和 causality，不修改 SSD。

## 解析结果

- Components resolved: **16/16**
- Structural connectors reviewed: **138/138**
- Resolved without expansion: **123**
- Expanded structural connectors: **15**
- Executable FMI variables (unique component-level exposed names): **151**
- Structural-connector-to-variable bindings: **163**
- Engineering inference variables: **48**
- Unresolved variables: **0**
- Structural connections: **74**
- Executable signal connections: **87**
- Output-output structural connections: **1**
- Output-output executable resolution: **PASS**

结构 Connector 共形成 163 条 connector-to-variable 绑定：15 个物理 Connector 合法展开（5 个展开为 2 个变量，10 个展开为 3 个变量），其余 123 个保持单变量。同一组件内有 12 个 fan-in/fan-out 绑定复用相同的 executable variable name，因此最终唯一 FMU exposed variables 为 151，即 `138 + 25 - 12 = 151`。`87 > 74`，因为 8 条物理结构连接展开为多个有向 scalar transfer（3 条展开为 2 个、5 条展开为 3 个）；其余 66 条保持单一有向信号连接。

## SSD 语义损失恢复

SSD 中的 `Real, unit=[-]` 保留不变。当旧合同的 V、A、Hz、N*m、rad/s 等单位与 Full SysML item/interface 语义一致时，本解析将其分类为 `SSD_SEMANTIC_LOSS_RECOVERED` 或 `VALID_EXECUTION_EXPANSION`，而不是丢弃为冲突。

48 个唯一离散/枚举/Boolean 变量在旧合同中没有单位；Full SysML 的 unit/medium 为“无”。执行层把它们明确编码为 FMI dimensionless unit `1`，来源记录为 `ENGINEERING_INFERENCE`、`confidence=inferred`，并逐变量保留 assumption。

## 合法展开的结构 Connector

| Component | SSD connector | Item | Variables | Executable names |
|---|---|---|---:|---|
| L2_3100 | p_3121_rp_fdcd27ee9b0a936f | ITM-PHY-005 | 2 | in_T_shaft, out_omega_shaft |
| L2_3100 | p_3131_rp_06d152ddc255f2eb | ITM-PHY-007 | 2 | in_T_brake, out_omega_wheel |
| L2_3500 | p_3511_rp_aa7691c6f81e4771 | ITM-PHY-005 | 2 | in_T_shaft, out_omega_shaft |
| L2_3500 | p_3512_rp_c455741f6ca5a597 | ITM-PHY-005 | 2 | in_omega_shaft, out_T_shaft |
| L2_4100 | p_4111_rp_ca65ceda639dfc7a | ITM-PHY-001 | 3 | in_I_ac_rms, out_U_ac_rms, out_f_ac |
| L2_4200 | p_4211_rp_bba7ece236be8f3c | ITM-PHY-001 | 3 | in_U_ac_rms, in_f_ac, out_I_ac_rms |
| L2_4200 | p_4236_rp_78e99abb7d77c156 | ITM-PHY-001 | 3 | in_I_ac_rms, out_U_ac_rms, out_f_ac |
| L2_4500 | p_4511_rp_c782fb362436088e | ITM-PHY-001 | 3 | in_U_ac_rms, in_f_ac, out_I_ac_rms |
| L2_4500 | p_4513_rp_f597e9dc63931270 | ITM-PHY-014 | 3 | in_I_sec_rms, out_U_sec_rms, out_f_sec |
| L2_5100 | p_5121_rp_9dedfe88c8a34261 | ITM-PHY-014 | 3 | in_U_sec_rms, in_f_sec, out_I_sec_rms |
| L2_5100 | p_5122_rp_0b57347688ba1240 | ITM-PHY-014 | 3 | in_U_sec_rms, in_f_sec, out_I_sec_rms |
| L2_5100 | p_5132_rp_770f7e1c507cc073 | ITM-PHY-004 | 3 | in_I_motor_rms, out_U_motor_ll_rms, out_f_motor_e |
| L2_5300 | p_5311_rp_57f3c317ac0c860d | ITM-PHY-004 | 3 | in_U_motor_ll_rms, in_f_motor_e, out_I_motor_rms |
| L2_5300 | p_5311_rp_97eb613c06ae1b2e | ITM-PHY-005 | 3 | in_omega_shaft, out_T_shaft, out_omega_motor |
| L2_7200 | p_7254_rp_d9511ef0fa1c17df | ITM-PHY-007 | 2 | in_omega_wheel, out_T_brake |

## 16 个组件执行端口表

| Component | Engineering name | Inputs | Outputs | Total | Readiness |
|---|---|---:|---:|---:|---|
| L2_3100 | 轮轴组成 | 2 | 4 | 6 | READY |
| L2_3500 | 牵引传动耦合组件及其附件 | 2 | 2 | 4 | READY |
| L2_3600 | 转向架相关检测 | 3 | 1 | 4 | READY |
| L2_3800 | 辅助增粘及轮缘润滑 | 1 | 0 | 1 | READY |
| L2_4100 | 高压受流 | 2 | 3 | 5 | READY |
| L2_4200 | 网侧高压分配及控制 | 6 | 9 | 15 | READY |
| L2_4400 | 回流及接地 | 0 | 0 | 0 | READY |
| L2_4500 | 主变压器及其冷却 | 5 | 4 | 9 | READY |
| L2_5100 | 牵引变流器主体及其控制 | 9 | 10 | 19 | READY |
| L2_5300 | 牵引电机及其冷却 | 3 | 6 | 9 | READY |
| L2_7100 | 供风 | 0 | 1 | 1 | READY |
| L2_7200 | 制动 | 10 | 4 | 14 | READY |
| L2_8100 | 列车主干网及安全回路 | 29 | 17 | 46 | READY |
| L2_D100 | 操纵设施 | 0 | 4 | 4 | READY |
| L2_E100 | ATP车载 | 0 | 2 | 2 | READY |
| L2_X100 | 车载再生储能 | 5 | 7 | 12 | READY |

每个组件的 Inputs、Outputs、Parameters、States/monitoring outputs、单位、datatype、源 SSD Connector 和源 SysML 元素已写入 `components/L2_<code>_executable_interface.json`。本版本没有从权威来源识别出独立 FMU parameters 或额外 state/monitoring outputs，因此对应数组为空；没有为凑数量而发明变量。

## Output → Output 解析

唯一异常为 `CG_07AF42BFA3927EF22F7BDDE7`。Full SysML 表明其 item 是双向旋转机械接口，旧合同与原始连接类型进一步表明它是 motor shaft speed sensor 的 `TAP`，不传递机械功率。执行因果化为：

`L2_5300.out_omega_motor → L2_3600.in_omega_motor`

详细证据与 A/B/C/D 判定见 `Output_Output_Resolution.md`。SSD 未修改。

## Readiness

所有 163 个 executable variables 均具有明确 quantity、unit、datatype 与 causality；所有 87 条 executable signal connections 的两端变量均存在；核心牵引、制动、储能接口无 unresolved variable。

```text
COMPONENTS_RESOLVED = 16/16
STRUCTURAL_CONNECTORS_REVIEWED = 138/138
RESOLVED_WITHOUT_EXPANSION = 123
EXPANDED_STRUCTURAL_CONNECTORS = 15
EXECUTABLE_FMI_VARIABLES = 151
EXECUTABLE_VARIABLE_BINDINGS = 163
ENGINEERING_INFERENCE_VARIABLES = 48
UNRESOLVED_VARIABLES = 0
STRUCTURAL_CONNECTIONS = 74
EXECUTABLE_SIGNAL_CONNECTIONS = 87
OUTPUT_OUTPUT_STRUCTURAL_CONNECTIONS = 1
OUTPUT_OUTPUT_EXECUTABLE_RESOLUTION = PASS
ORIGINAL_SSD_MODIFIED = NO
FULL_SYSML_MODIFIED = NO
EXECUTABLE_FMU_INTERFACE_READY = PASS
```

本次未创建 Simulink、Skeleton 或 FMU，未运行 MATLAB 或 SSI Simulator。
