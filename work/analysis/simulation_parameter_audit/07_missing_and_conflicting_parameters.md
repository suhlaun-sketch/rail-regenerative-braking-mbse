# 07_missing_and_conflicting_parameters.md
# Rail MBSE 参数缺失与冲突审计 / Missing and Conflicting Parameters Audit

**生成时间 / Generated**: 2026-09-16 15:37 UTC  
**审计范围 / Audit Scope**: 全系统仿真参数完整性与一致性

---

## 摘要 / Summary

| 类型 | 数量 | 严重性 |
|------|------|--------|
| **MISSING (缺失)** | 13 | HIGH |
| **CONFLICT (冲突)** | 4 | MEDIUM |
| **IMPLICIT_DEFAULT (隐式默认)** | 8 | MEDIUM |
| **SUSPICIOUS (可疑)** | 3 | LOW |
| **UNTRACEABLE (无法追溯)** | 0 | - |
| **UNUSED (未使用)** | 3 | LOW |

---

## 一、缺失关键参数 / 1. MISSING Critical Parameters

### MIS-001: 车型名称 / Vehicle Type Name

**参数 / Parameter**: `MODEL_VEHICLE_TYPE`  
**状态 / Status**: ❌ **NOT EXPLICITLY DEFINED**  
**严重性 / Severity**: **HIGH**

**影响 / Impact**:
- 无法确定模型针对哪种具体车型
- 参数选择缺乏车型认证依据
- 仿真结果不能对应真实车辆

**建议 / Recommendation**:
```
明确声明: MODEL_VEHICLE_TYPE = "Generic Urban Rail Power Unit Abstract Model"
或添加车型元数据到 Rail_MBSE_Simulation_Parameters_v2.json
```

---

### MIS-002: 载荷工况 / Load Case

**参数 / Parameter**: `LOAD_CASE` (AW0/AW1/AW2/AW3)  
**状态 / Status**: ❌ **NOT EXPLICITLY DEFINED**  
**严重性 / Severity**: **HIGH**

**影响 / Impact**:
- 单一固定质量 80,000 kg，未考虑载客变化
- 不能对比不同载荷下的加速/制动性能
- 制动力不随载荷变化 (Ftotal = mass × a)

**建议 / Recommendation**:
```
添加 4 个载荷工况到参数文件:
- AW0: 60,000 kg (empty)
- AW1: 80,000 kg (nominal) [current]
- AW2: 100,000 kg (full)
- AW3: 120,000 kg (crush)
```

---

### MIS-003: 线路坡度 / Track Grade

**参数 / Parameter**: `track_grade`  
**状态 / Status**: ❌ **NOT FOUND**  
**IMPLICIT_DEFAULT**: 0  
**严重性 / Severity**: **HIGH**

**影响 / Impact**:
- 阻力模型不含坡道附加阻力: `F_grade = m × g × sin(θ)`
- 无法仿真上下坡工况
- 再生制动能量分析不完整 (下坡回收未验证)

**证据 / Evidence**:
- L2_3100_behavior.m: 阻力仅含 `T_res = 1500 + 0.8*ω²`
- 无 `g*sin(θ)` 项
- SC_v1 参考: `SCv1.vehicle.grade = 0` (显式设为 0)

**建议 / Recommendation**:
```matlab
% 添加到参数文件
P.track.grade_permille = 0;  % 缺省平直
% 或使用坡度轮廓 (基于位置)
P.track.grade_profile = [(0,0), (500,10), (1000,-5), ...]  % (position, grade‰)
```

---

### MIS-004: 曲线半径 / Curve Radius

**参数 / Parameter**: `curve_radius`  
**状态 / Status**: ❌ **NOT FOUND**  
**严重性 / Severity**: **MEDIUM**

**影响 / Impact**:
- 无曲线附加阻力: `F_curve = C_curve / R`
- 仅适用于直线路

---

### MIS-005: 黏着系数 / Adhesion Coefficient

**参数 / Parameter**: `adhesion_coefficient (μ)`  
**状态 / Status**: ❌ **NOT FOUND** (in v2 formal model)  
**参考值 / Reference**: SC_v1 = 0.20  
**严重性 / Severity**: **HIGH**

**影响 / Impact**:
- 制动力可能超过物理极限
- 未实现: `F_brake ≤ μ × m × g = 0.20 × 80000 × 9.81 = 156,960 N`
- v2 模型最大电制动力 77,000 N < 黏着极限，因此当前配置下**不冲突**
- 但代码没有约束，改用大参数时可能超限

**建议 / Recommendation**:
```matlab
% 添加黏着约束
P.adhesion.mu_dry = 0.20;
P.adhesion.mu_wet = 0.15;
P.adhesion.max_brake_force = P.adhesion.mu_dry * mass * g;
```

---

### MIS-006: 空气密度 / Air Density

**参数 / Parameter**: `air_density_kg_m3`  
**状态 / Status**: ❌ **NOT EXPLICITLY DEFINED**  
**严重性 / Severity**: **MEDIUM**

**影响 / Impact**:
- 气动阻力使用扭矩域系数 (0.8 N·m/(rad/s)²)
- 未显式定义 ρ、Cd、A
- 无法调整以适应海拔或气候变化

---

### MIS-007: 风速 / Wind Speed

**参数 / Parameter**: `wind_speed_mps`  
**状态 / Status**: ❌ **NOT FOUND**  
**严重性 / Severity**: **LOW**

---

### MIS-008: 环境温度 / Ambient Temperature

**参数 / Parameter**: `ambient_temperature`  
**状态 / Status**: ❌ **NOT FOUND**  
**严重性 / Severity**: **HIGH**

**影响 / Impact**:
- **THERMAL_MODEL_PARAMETERS = NOT FOUND**
- 所有效率为常值，不随温度变化
- 无过温保护
- 电机、变流器、储能温度模型全部缺失

**建议 / Recommendation**: 若考虑高精度分析，需实现完整热模型

---

### MIS-009: 电网回馈能力 / Grid Receptivity

**参数 / Parameter**: `GRID_RECEPTIVITY_MODEL`  
**状态 / Status**: ❌ **NOT FOUND** (硬编码为 0)  
**严重性 / Severity**: **HIGH**

**影响 / Impact**:
- L2_5100_behavior.m 硬编码 `out_grid_acceptable_regenerative_power = 0`
- 所有再生能量必须由储能吸收或制动电阻消耗
- 无法仿真电网支持再生的实际工况
- **储能饱和时能量浪费在制动电阻**

**关键 / Critical**: 此参数直接影响能量回收效率

**建议 / Recommendation**:
```matlab
% 电网回馈能力模型
P.grid.receptivity_enable = true;
P.grid.receptivity_power_limit_W = 500000;  % 500 kW
P.grid.receptivity_voltage_dependency = true;
```

---

### MIS-010: 传感器参数 / Sensor Parameters

**参数 / Parameter**: All sensor characteristics  
**状态 / Status**: ❌ **NOT FOUND**  
**严重性 / Severity**: **MEDIUM**

**影响 / Impact**:
- 所有信号为理想值
- 无延迟、噪声、量化误差
- 不能验证控制器对传感器误差的鲁棒性

---

### MIS-011: 控制通信延迟 / Control Communication Delay

**参数 / Parameter**: `control_communication_delay`  
**状态 / Status**: ❌ **NOT EXPLICITLY DEFINED**  
**IMPLICIT / Actual**: **1 通信步 (0.05 s) Jacobi 延迟**  
**严重性 / Severity**: **MEDIUM**

**影响 / Impact**:
- Jacobi 联合仿真隐含 1 步延迟
- 未显式定义传感器/执行器/网络延迟
- 实际系统延迟可能更大

---

### MIS-012: 故障保护阈值 / Fault Protection Thresholds

**参数 / Parameter**: 大部分保护阈值  
**状态 / Status**: ❌ **MINIMAL** (仅有基本安全联锁)  
**严重性 / Severity**: **HIGH**

**未实现的保护 / Not Implemented Protections**:
- ❌ 过压保护 (over-voltage)
- ❌ 欠压保护 (under-voltage) — 部分实现 (DC>=1200V)
- ❌ 过流保护 (over-current)
- ❌ 过温保护 (over-temperature)
- ❌ SOC 保护 — 部分实现 (SOC<0.98 for regen)
- ❌ 速度保护 (over-speed)
- ❌ 制动故障保护
- ❌ 变流器故障恢复逻辑

**已实现 / Implemented**:
- ✅ Safety loop state check
- ✅ External safety system state
- ✅ Traction converter fault flag
- ✅ Emergency brake request

---

### MIS-013: 站间距离 / Inter-station Distance

**参数 / Parameter**: `inter_station_distance`  
**状态 / Status**: ❌ **NOT DEFINED**  
**严重性 / Severity**: **LOW**

**影响 / Impact**: 仿真不基于真实线路，未定义站间距离

---

## 二、冲突参数 / 2. CONFLICT Parameters

### CFL-001: 车辆质量冲突 / Vehicle Mass Conflict

**参数 / Parameter**: `vehicle_mass_kg`

| 来源 | 数值 | 单位 |
|------|------|------|
| **SC_v1_parameters.m** (legacy) | 295,900 | kg |
| **Rail_MBSE_Simulation_Parameters_v2** | 80,000 | kg |
| **L2_7200_behavior.m** | 80,000 | kg |
| **L2_8100_behavior.m** | 80,000 | kg |
| **runner_v2.py MASS** | 80,000.0 | kg |

**最终运行值 / Final Runtime Value**: **80,000 kg**

**冲突性质 / Conflict Nature**: 
- 抽象层次差异 (整列车 vs 单动力单元)
- 非参数错误

**建议 / Recommendation**: 
- SC_v1 应标记为 `REFERENCE_ONLY / LEGACY`
- v2 参数文档应明确说明这是单动力单元质量

---

### CFL-002: 通信步长冲突 / Communication Step Conflict

**参数 / Parameter**: `communication_step_s`

| 来源 | 数值 | 单位 |
|------|------|------|
| **v1 Rail_MBSE_Simulation_Parameters_v1.m** | 0.1 | s |
| **v1 rail_fmu_cosim_runner.py (DT)** | 0.1 | s |
| **v2 Rail_MBSE_Simulation_Parameters_v2.json** | 0.05 | s |
| **v2 rail_fmu_cosim_runner_v2.py (main dt)** | 0.05 | s |
| **v2 敏感性分析** | 0.02, 0.05, 0.10 | s |

**最终运行值 / Final Runtime Value**: **0.05 s** (v2/v2.1 main case)

**冲突性质 / Conflict Nature**:
- 版本演进 (v1 → v2)
- v2 减小步长以改进制动瞬态精度
- 不同版本对应不同结果集

**建议 / Recommendation**: 
- v2.1 为最终版本，通信步长 0.05s
- v1 结果为参考基线

---

### CFL-003: 电机发电效率冲突 / Motor Regen Efficiency Conflict

**参数 / Parameter**: `motor_efficiency_generating`

| 来源 | 数值 |
|------|------|
| **Rail_MBSE_Simulation_Parameters_v2.json** | 0.92 |
| **L2_5300_behavior.m** | 0.92 |
| **runner_v2.py MOTOR_ETA_REG** | 0.93 |

**冲突性质 / Conflict Nature**:
- 参数文件与后处理 runner 不一致
- 差异 1% (0.92 vs 0.93)

**影响 / Impact**:
- FMU 内部使用 0.92 (真实仿真行为)
- Runner 后处理能量审计使用 0.93 (可能导致能量残差)

**建议 / Recommendation**:
```python
# 修改 runner_v2.py 第 21 行
MOTOR_ETA_MOT, MOTOR_ETA_REG = 0.94, 0.92  # 与 FMU 内部一致
```

---

### CFL-004: 传动效率冲突 / Driveline Efficiency Conflict

**参数 / Parameter**: `driveline_efficiency`

| 来源 | 数值 |
|------|------|
| **Rail_MBSE_Simulation_Parameters_v2.json** | 0.96 |
| **L2_8100_behavior.m (eta)** | 0.96 |
| **runner_v2.py DRIVE_ETA** | 0.97 |
| **SC_v1 gear_efficiency** | 0.97 |

**冲突性质 / Conflict Nature**:
- v2 使用 0.96
- Runner 使用 0.97 (与 SC_v1 一致)

**建议 / Recommendation**: 
```python
# 修改 runner_v2.py 第 20 行
GEAR, DRIVE_ETA = 6.2, 0.96  # 与 FMU 内部一致
```

---

## 三、隐式默认值 / 3. IMPLICIT_DEFAULT Parameters

### IMP-001: 初始速度 / Initial Speed

**参数 / Parameter**: `initial_speed_mps`  
**隐式默认 / Implicit Default**: **0 m/s**  
**来源 / Source**: L2_3100_behavior.m `persistent omega_w; if isempty(omega_w), omega_w = 0.0; end`

---

### IMP-002: 线路坡度 / Track Grade

**参数 / Parameter**: `track_grade`  
**隐式默认 / Implicit Default**: **0** (缺省平直)  
**来源 / Source**: 阻力模型未含坡道项

---

### IMP-003: 风速 / Wind Speed

**参数 / Parameter**: `wind_speed`  
**隐式默认 / Implicit Default**: **0 m/s** (无风)  
**来源 / Source**: 气动阻力无风速项

---

### IMP-004: 初始 DC 母线电压 / Initial DC-Link Voltage

**参数 / Parameter**: `Udc_initial`  
**隐式默认 / Implicit Default**: **1800 V**  
**来源 / Source**: L2_5100_behavior.m `persistent Udc; if isempty(Udc), Udc = 1800; end`

---

### IMP-005: 初始扭矩 / Initial Torque

**参数 / Parameter**: `motor_torque_initial`  
**隐式默认 / Implicit Default**: **0 N·m**  
**来源 / Source**: L2_5300_behavior.m `persistent torque; if isempty(torque), torque = 0.0; end`

---

### IMP-006: 初始受电弓状态 / Initial Pantograph State

**参数 / Parameter**: `pantograph_initial_state`  
**隐式默认 / Implicit Default**: **0 (down)**  
**来源 / Source**: L2_4100_behavior.m `persistent panto; if isempty(panto), panto = int32(0); end`

---

### IMP-007: 初始机械制动状态 / Initial Mechanical Brake State

**参数 / Parameter**: `mechanical_brake_initial`  
**隐式默认 / Implicit Default**: **0 N (释放)**  
**来源 / Source**: L2_7200_behavior.m `persistent pcyl FmechState prevFtotal; ... = 0.0`

---

### IMP-008: FMU 输入初始值 / FMU Input Initial Values

**参数 / Parameter**: All FMU inputs  
**隐式默认 / Implicit Default**: **0 (类型对应)**  
**来源 / Source**: modelDescription.xml 所有输入 `start=0`

---

## 四、可疑参数 / 4. SUSPICIOUS Parameters

### SUS-001: DC 母线电压饱和值

**参数 / Parameter**: `dc_voltage_saturation`

**问题 / Issue**:
- 参数文件 `dc_voltage_max_V = 2100`
- L2_5100_behavior.m 硬编码饱和 `targetU = min(2200, ...)`
- **不一致**: 2100 vs 2200 (100 V 差异)

**建议 / Recommendation**: 统一为 2100 V

---

### SUS-002: 阶段4制动请求

**参数 / Parameter**: 保持制动请求  
**参数文件值**: `hold_deceleration_mps2 = 0.3` m/s²  
**L2_D100 输出**: `out_service_brake_request = 0.3` (单位: m/s² 或 1)  

**问题 / Issue**: 
- 单位定义不明: SSD 中显示 `unit="1 或 m/s2"` (混合中文单位)
- L2_D100 传入 0.3, L2_7200 解释为减速度 (m/s²)

**建议 / Recommendation**: 明确单位定义，去除歧义

---

### SUS-003: 中文单位混入 / Chinese Units Mixed In

**参数 / Parameter**: `in_service_brake_request` unit  
**SSD 值**: `"1 或 m/s2"`

**问题 / Issue**: 中文字符混入 SSD/FMU 单位定义

**建议 / Recommendation**: 使用标准 SI 单位或纯英文描述

---

## 五、未使用参数 / 5. UNUSED Parameters

### UNU-001: 电容 ESR 在 FMU 内部未使用

**参数 / Parameter**: `supercap_esr_Ohm = 0.04`

**使用位置 / Usage**:
- ✅ runner_v2.py: 用于计算 `Uterminal = Ucap - Icap * SC_ESR`
- ❌ L2_X100_behavior.m: **未使用 ESR**，直接从能量计算 Usc = sqrt(2E/C)

**影响 / Impact**: FMU 内部储能模型忽略 ESR 损耗

---

### UNU-002: 电机极对数 pole_pairs = 3 部分使用

**参数 / Parameter**: `motor.pole_pairs = 3`

**使用位置 / Usage**:
- ✅ L2_5300_behavior.m: `wsync = 2*pi*f/3` (硬编码 3，非参数)
- ✅ L2_5100_behavior.m: `f_motor_e = 3*(speed+slip)/(2*pi)` (硬编码 3)

**问题 / Issue**: 极对数硬编码为 3，未使用参数文件中的定义

**建议 / Recommendation**: 使用参数化 pole_pairs

---

### UNU-003: transformer.frequency_min/max_Hz

**参数 / Parameter**: `transformer.frequency_min_Hz = 45, frequency_max_Hz = 55`

**使用位置 / Usage**:
- 定义在 Rail_MBSE_Simulation_Parameters_v2.json
- 未在任何 behavior.m 中使用

**说明 / Note**: 定义了但没有代码实际检查

---

## 六、SysML 定义 vs Simulink 实现差异 / 6. SysML vs Simulink Differences

### SysML 全工程模型 / SysML Full Engineering Model

**位置 / Location**: `work/sysmlv2/full_engineering_model/01_generated/`

**内容 / Content**:
- ✅ 定义 138 结构连接器 (Structural Connectors)
- ✅ 定义 151 可执行变量 (Executable Variables)
- ✅ 87 连接记录 (77 唯一路径)
- ❌ **不包含参数定义** (无 `parameter` 元素或值)

**结论 / Conclusion**: 
- SysML 模型定义**结构和接口**
- **物理参数值**存储在 Simulink 和参数 JSON 中
- 参数与结构分离，符合 MBSE 分层建模原则

---

## 七、FMU modelDescription 中的参数 / 7. Parameters in FMU modelDescription

### 关键发现 / Key Finding

**所有 16 个 FMU 的 modelDescription.xml 中:**

```
causality="parameter" 变量数量: 0
variability="fixed" 变量数量: 0
variability="tunable" 变量数量: 0
```

**结论 / Conclusion**:
- ❌ **FMU 不暴露任何参数接口**
- ✅ 所有参数在 Simulink 导出时被"烘焙"进 FMU 二进制
- ⚠️ 无法通过 FMPy setReal() 修改参数
- ⚠️ 无法通过 SSP/SSV/SSM 覆盖参数

**影响 / Impact**:
- 参数覆盖链**在 FMU 层终止**
- Python runner **不覆盖任何 FMU 参数**
- 修改参数必须**重新导出 FMU**

---

## 八、SSP/SSV/SSM 参数覆盖 / 8. SSP/SSV/SSM Parameter Overrides

### SSP 文件分析 / SSP File Analysis

**文件 / Files**:
- `simulink_fmu_v1/06_ssp/Rail_MBSE_All16_Executable_v1.ssp`
- `simulink_fmu_v2_reviewed/06_ssp/Rail_MBSE_All16_Executable_v2.ssp`
- `simulink_fmu_v2_1_final/06_ssp/Rail_MBSE_All16_Executable_v2_1.ssp`

**SSD (System Structure Description)**:
- ✅ 定义组件列表 (16 FMUs)
- ✅ 定义连接器 (Connectors)
- ✅ 定义连接 (Connections)
- ❌ **不包含参数值**

**SSV (System Structure Parameter Values)**:
- ❌ **未找到 SSV 文件**

**SSM (System Structure Parameter Mapping)**:
- ❌ **未找到 SSM 文件**

**结论 / Conclusion**: 
- SSP 只定义结构，不覆盖参数
- 参数覆盖链: `Simulink → FMU (baked) → runner (no override)`

---

## 九、参数覆盖链完整分析 / 9. Complete Override Chain Analysis

### 参数流向 / Parameter Flow

```
┌──────────────────────────────────────────────────────┐
│  Rail_MBSE_Simulation_Parameters_v2.json/.m         │
│  (参数源头，SOURCE_OF_TRUTH)                          │
└─────────────┬────────────────────────────────────────┘
              │
              ↓ (人工同步)
┌──────────────────────────────────────────────────────┐
│  L2_*.slx (Simulink 模型)                            │
│  L2_*_behavior.m (硬编码参数)                          │
└─────────────┬────────────────────────────────────────┘
              │
              ↓ (Simulink 导出)
┌──────────────────────────────────────────────────────┐
│  L2_*.fmu (参数烘焙进二进制)                          │
│  modelDescription.xml (无参数接口)                    │
└─────────────┬────────────────────────────────────────┘
              │
              ↓ (无覆盖)
┌──────────────────────────────────────────────────────┐
│  Rail_MBSE_All16_Executable_*.ssp/.ssd              │
│  (只定义结构，不覆盖参数)                              │
└─────────────┬────────────────────────────────────────┘
              │
              ↓ (无覆盖)
┌──────────────────────────────────────────────────────┐
│  rail_fmu_cosim_runner_v2.py                        │
│  (硬编码后处理常数 MASS/WHEEL_RADIUS/...)              │
└─────────────┬────────────────────────────────────────┘
              │
              ↓ (最终运行)
┌──────────────────────────────────────────────────────┐
│  仿真结果 CSV / JSON / MAT                            │
└──────────────────────────────────────────────────────┘
```

### 关键结论 / Key Conclusions

1. **参数源头单一 / Single Source of Truth**: `Rail_MBSE_Simulation_Parameters_v2.json/.m`
2. **同步风险 / Sync Risk**: 参数需要**人工同步**到 Simulink 和 runner
3. **FMU 不透明 / FMU Opaque**: 参数一旦烘焙无法从外部修改
4. **Runner 硬编码 / Runner Hardcoded**: 后处理常数与 FMU 内部可能不一致 (见 CFL-003, CFL-004)

---

## 十、参数完整性评分 / 10. Parameter Completeness Score

### 分类评分 / Category Scores

| 类别 | 完整度 | 备注 |
|------|--------|------|
| **车辆基础参数** | 60% | 缺车型、载荷工况 |
| **轮轨机械** | 80% | 主要参数完整 |
| **纵向动力学** | 70% | 缺坡度、曲线 |
| **线路外部条件** | 20% | 大部分缺失 |
| **黏着条件** | 0% | 完全缺失 |
| **牵引电机** | 90% | 参数完整 |
| **牵引变流器** | 85% | 主要参数完整 |
| **主变压器** | 90% | 参数完整 |
| **再生制动** | 90% | 逻辑清晰 |
| **机械制动** | 85% | 主要参数完整 |
| **混合制动** | 95% | 详细定义 |
| **储能系统** | 95% | 详细定义 |
| **热模型** | 0% | 完全缺失 |
| **控制器** | 60% | 部分硬编码 |
| **传感器** | 0% | 完全缺失 |
| **通信延迟** | 10% | 只有 Jacobi 隐含 |
| **仿真场景** | 90% | 时间表明确 |
| **故障保护** | 30% | 仅基本安全联锁 |

### 总体评分 / Overall Score

**参数完整度 / Parameter Completeness**: **~62%**

---

## 十一、CRITICAL 问题优先级 / 11. CRITICAL Issues Priority

### 优先级 1 - 立即处理 / Priority 1 - Immediate

1. ⚠️ **CFL-003**: Motor regen efficiency 冲突 (0.92 vs 0.93)
   - 影响能量审计准确性
   - 修复: 统一 runner 和 FMU 内部
   
2. ⚠️ **CFL-004**: Driveline efficiency 冲突 (0.96 vs 0.97)
   - 影响机械/电气功率转换
   - 修复: 统一 runner 和 FMU 内部

3. ⚠️ **SUS-001**: DC voltage saturation 不一致 (2100 vs 2200)
   - 影响过压保护判断

### 优先级 2 - 短期处理 / Priority 2 - Short Term

4. **MIS-003**: 添加线路坡度参数
5. **MIS-002**: 定义载荷工况
6. **MIS-005**: 实现黏着系数约束
7. **MIS-009**: 实现电网回馈能力模型

### 优先级 3 - 长期改进 / Priority 3 - Long Term

8. **MIS-008**: 实现热模型
9. **MIS-010**: 添加传感器模型
10. **MIS-012**: 完善故障保护体系

---

## 十二、审计结论 / 12. Audit Conclusion

### 综合评价 / Overall Assessment

**项目参数管理状态 / Parameter Management Status**: **MEDIUM**

**优势 / Strengths**:
- ✅ 参数集中定义 (Rail_MBSE_Simulation_Parameters_v2)
- ✅ 结构化元数据 (source, confidence, assumption)
- ✅ 版本控制清晰 (v1 → v2 → v2_1_final)
- ✅ 核心物理参数完整

**弱点 / Weaknesses**:
- ⚠️ 参数需人工同步 (JSON → Simulink → runner)
- ⚠️ FMU 无参数接口 (不可外部覆盖)
- ⚠️ 外部条件参数严重缺失
- ⚠️ 保护逻辑不完整

### 建议改进方向 / Recommended Improvements

1. **自动化参数同步**: 使用脚本从 JSON 生成 Simulink 参数
2. **FMU 参数化**: 导出 FMU 时暴露关键参数为 `parameter/tunable`
3. **SSP 参数覆盖**: 使用 SSV/SSM 实现参数覆盖链
4. **参数版本控制**: 明确不同版本的适用范围

---

**报告结束 / End of Report**

**审计负责 / Audit By**: Kilo AI Agent  
**审计时间 / Audit Time**: 2026-09-16T15:37:00Z
