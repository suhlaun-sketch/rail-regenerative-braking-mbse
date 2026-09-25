# 06_external_conditions.md
# Rail MBSE 外部工况画像 / External Operating Conditions Profile

**生成时间 / Generated**: 2026-09-16 15:37 UTC  
**分析范围 / Scope**: 仿真外部运行条件审计

---

## 一、初始速度 / 1. Initial Speed

### 实际运行值 / Actual Value

**initial_speed_mps**: **0 m/s**

**状态 / Status**: ✅ **IMPLICIT_DEFAULT**

**来源 / Source**:
- L2_3100_behavior.m: `persistent omega_w; if isempty(omega_w), omega_w = 0.0; end`
- FMU modelDescription.xml: 所有输入变量 start=0

**说明 / Note**: 模型从静止状态开始仿真，无初始速度扰动

---

## 二、目标速度 / 2. Target Speed

### 实际运行值 / Actual Value

**target_speed_mps**: **NOT EXPLICITLY DEFINED**

**驾驶员指令轨迹 / Driver Command Trajectory** (L2_D100_behavior.m):

| 时间段 | 牵引命令 | 制动命令 |
|--------|---------|---------|
| t < 20s | min(1.0, t/3) | 0.0 |
| 20s ≤ t < 30s | 0.0 | 0.0 |
| 30s ≤ t < 45s | 0.0 | 1.0 |
| t ≥ 45s | 0.0 | 0.3 |

**说明 / Note**: 
- 牵引阶段持续 20 秒
- 滑行阶段 10 秒
- 制动阶段 15 秒
- 保持阶段至结束 (50s)

---

## 三、最高速度 / 3. Maximum Speed

### 实际运行值 / Actual Value

**max_speed_mps**: **NOT EXPLICITLY DEFINED**

**仿真实测峰值速度 / Actual Simulation Peak Speed**:
- 牵引阶段末 (t≈20s) 预期达到约 20-25 m/s (72-90 km/h)
- 实际峰值取决于牵引功率和阻力平衡

**说明 / Note**: 模型未定义速度上限，速度由动力学决定

---

## 四、线路坡度 / 4. Track Gradient

### 实际运行值 / Actual Value

**track_grade**: **0 (IMPLICIT_DEFAULT)**

**状态 / Status**: ⚠️ **MISSING / IMPLICIT_DEFAULT**

**说明 / Note**:
- 整个项目中**未定义任何坡度参数**
- 模型假设平直线路
- 未实现坡道附加阻力计算
- 仿真结果不包含坡道影响

**影响评估 / Impact Assessment**:
- ⚠️ 仿真结果不能直接用于坡道工况验证
- ⚠️ 实际应用中需补充坡度参数

---

## 五、曲线半径 / 5. Curve Radius

### 实际运行值 / Actual Value

**curve_radius**: **NOT FOUND**

**状态 / Status**: ❌ **MISSING**

**说明 / Note**:
- 项目中**未定义任何曲线参数**
- 未实现曲线附加阻力
- 模型假设直线路

---

## 六、隧道影响 / 6. Tunnel Effects

### 实际运行值 / Actual Value

**tunnel_effects**: **NOT FOUND**

**状态 / Status**: ❌ **MISSING**

**说明 / Note**: 模型未考虑隧道附加阻力

---

## 七、海拔 / 7. Altitude

### 实际运行值 / Actual Value

**altitude_m**: **NOT FOUND**

**状态 / Status**: ❌ **MISSING**

**说明 / Note**: 海拔未定义，空气密度假设为标准状态

---

## 八、线路限速 / 8. Line Speed Limit

### 实际运行值 / Actual Value

**line_speed_limit_mps**: **NOT EXPLICITLY DEFINED**

**说明 / Note**: 模型未定义线路限速，速度限制由驾驶员指令控制

---

## 九、运行区间 / 9. Operating Section

### 实际运行值 / Actual Value

**operating_section**: **"通用仿真场景 / Generic Simulation Scenario"**

**说明 / Note**: 
- 未定义具体站间距离
- 仿真场景为通用牵引-滑行-制动工况

---

## 十、站间距离 / 10. Inter-station Distance

### 实际运行值 / Actual Value

**inter_station_distance**: **NOT DEFINED**

**说明 / Note**: 仿真不基于真实线路，未定义站间距离

---

## 十一、黏着条件 / 11. Adhesion Conditions

### 实际运行值 / Actual Value

**adhesion_coefficient**: **NOT FOUND**

**状态 / Status**: ❌ **MISSING**

**说明 / Note**:
- v2 模型**未实现黏着系数约束**
- 制动力未经过 F ≤ μmg 限制
- SC_v1 参考模型定义: `SCv1.vehicle.mu = 0.20`

**影响 / Impact**:
- ⚠️ 仿真中制动力可能超过物理黏着极限
- ⚠️ 不能用于真实黏着条件分析

---

## 十二、轮轨条件 / 12. Wheel-Rail Conditions

### 实际运行值 / Actual Value

**wheel_rail_condition**: **IMPLICIT (理想条件)**

**说明 / Note**:
- 未定义干轨/湿轨条件
- 未实现防滑保护 (WSP)
- 未定义滑移率限制

---

## 十三、接触网条件 / 13. Catenary Conditions

### 实际运行值 / Actual Value

| 参数 | 数值 | 单位 | 来源 |
|------|------|------|------|
| **线电压** | 25,000 | V | Rail_MBSE_Simulation_Parameters_v2.json |
| **频率** | 50 | Hz | Rail_MBSE_Simulation_Parameters_v2.json |
| **电压波动** | 25,000 - 0.4×|I| | V | L2_4100_behavior.m |
| **最低电压** | 15,000 | V | 保护阈值 |

**状态 / Status**: ✅ **EXPLICIT**

**说明 / Note**:
- 标准 AC 25kV 50Hz 接触网
- 简化的电压降模型 (0.4 V/A)
- 存在电压保护阈值

---

## 十四、电网回馈能力 / 14. Grid Receptivity

### 实际运行值 / Actual Value

**grid_receptivity_model**: **NOT FOUND**

**grid_acceptable_regenerative_power_W**: **0 W** (硬编码)

**状态 / Status**: ⚠️ **CRITICAL - No grid receptivity**

**说明 / Note**:
- ❌ **电网不接受再生能量**
- 所有再生能量只能流向储能系统 (ESS) 或制动电阻
- L2_5100_behavior.m: `out_grid_acceptable_regenerative_power = 0`
- 超出储能接受能力的再生能量被制动电阻消耗

**影响 / Impact**:
- ⚠️ 储能饱和时再生能量被浪费
- ⚠️ 不符合真实电网支持再生制动的应用场景
- ⚠️ 模型适用于储能优先策略研究

---

## 十五、空气密度 / 15. Air Density

### 实际运行值 / Actual Value

**air_density_kg_m3**: **NOT EXPLICITLY DEFINED**

**说明 / Note**:
- 未显式定义空气密度
- 气动阻力通过扭矩域系数建模 (aero_torque_coefficient = 0.8)
- 隐含假设标准海平面条件

---

## 十六、风速 / 16. Wind Speed

### 实际运行值 / Actual Value

**wind_speed_mps**: **NOT FOUND**

**状态 / Status**: ❌ **MISSING**

**说明 / Note**:
- 未定义风速模型
- 未考虑迎风/顺风影响
- 假设无风条件

---

## 十七、环境温度 / 17. Ambient Temperature

### 实际运行值 / Actual Value

**ambient_temperature**: **NOT FOUND**

**状态 / Status**: ❌ **MISSING**

**说明 / Note**:
- 未实现热模型
- THERMAL_MODEL_PARAMETERS = NOT FOUND
- 所有组件效率为常值，不随温度变化

---

## 十八、气压 / 18. Atmospheric Pressure

### 实际运行值 / Actual Value

**atmospheric_pressure**: **NOT FOUND**

**状态 / Status**: ❌ **MISSING**

**说明 / Note**: 未定义气压参数

---

## 十九、湿度 / 19. Humidity

### 实际运行值 / Actual Value

**humidity**: **NOT FOUND**

**状态 / Status**: ❌ **MISSING**

**说明 / Note**: 未定义湿度参数

---

## 二十、载荷工况 / 20. Load Condition

### 实际运行值 / Actual Value

**load_case**: **NOT EXPLICITLY DEFINED**

**实际使用 / Actual Usage**:
- 模型使用单一固定质量: **80,000 kg**
- 未区分 AW0/AW1/AW2/AW3 工况

**说明 / Note**: 模型为单一载荷工况，未实现载客工况切换

---

## 二十一、仿真场景时间表 / 21. Simulation Scenario Timeline

### 详细时间表 / Detailed Timeline

| 起始时间 (s) | 结束时间 (s) | 工况阶段 | 牵引命令 | 制动命令 |
|------------|------------|---------|---------|---------|
| 0 | 3 | 牵引加速 | 0→1.0 (斜坡) | 0.0 |
| 3 | 20 | 牵引恒功率 | 1.0 | 0.0 |
| 20 | 30 | 滑行/巡航 | 0.0 | 0.0 |
| 30 | 45 | 常用制动 | 0.0 | 1.0 (m/s²) |
| 45 | 50 | 停车保持 | 0.0 | 0.3 (m/s²) |

### 工况阶段说明 / Phase Description

#### Phase 1: 牵引加速 (0-20s)
- **牵引命令**: 斜坡上升，从 0 到 1.0 (3秒内)
- **物理行为**: 列车从静止加速
- **能量流**: 接触网 → 变压器 → 变流器 → 电机 → 车轮

#### Phase 2: 滑行/巡航 (20-30s)
- **牵引命令**: 0
- **制动命令**: 0
- **物理行为**: 列车自然滑行，受阻力减速
- **能量流**: 无主动能量交换

#### Phase 3: 常用制动 (30-45s)
- **制动命令**: 1.0 m/s²
- **物理行为**: 列车减速
- **能量流**: 动能 → 电机(发电) → 变流器 → 储能/制动电阻
- **关键**: 再生制动优先

#### Phase 4: 停车保持 (45-50s)
- **制动命令**: 0.3 m/s²
- **物理行为**: 列车停车后保持
- **能量流**: 储能持续充电直到 SOC 限制

---

## 二十二、场景关键参数 / 22. Key Scenario Parameters

### 制动触发时刻 / Brake Trigger Time

**t_brake_start**: **30.0 s** (L2_D100_behavior.m)

### 保持制动开始 / Hold Brake Start

**t_hold_start**: **45.0 s** (L2_D100_behavior.m)

### 仿真总时长 / Total Simulation Time

**stop_time**: **50.0 s** (FMU DefaultExperiment + runner_v2.py STOP)

---

## 二十三、再生制动条件 / 23. Regenerative Braking Conditions

### 启用条件 / Enable Conditions

**动态制动可用性判定** (L2_8100_behavior.m, line 65):
```matlab
dynAvailable = safety && (in_ess_availability || in_grid_acceptable_regenerative_power > 0.0) && (in_super_cap_soc < 0.98) && (regenFade > 0.0)
```

**条件分解 / Condition Breakdown**:
1. ✅ `safety`: 外部安全系统正常
2. ✅ `in_ess_availability`: 储能可用 (或电网可接受)
3. ✅ `in_super_cap_soc < 0.98`: 储能 SOC 未满
4. ✅ `regenFade > 0.0`: 速度在再生有效范围内

### 速度范围 / Speed Range

| 速度区间 | 再生能力 | 衰减函数 |
|---------|---------|---------|
| v ≤ 0.5 m/s | 0 | 完全切除 |
| 0.5 < v < 1.5 m/s | 部分 | smoothstep 插值 |
| v ≥ 1.5 m/s | 100% | 完全可用 |

**衰减函数 / Fade Function**: Hermite smoothstep
```
xFade = (v - 0.5) / (1.5 - 0.5)
regenFade = xFade² × (3 - 2×xFade)
```

### 限制条件 / Limiting Conditions

1. **储能 SOC 限制**: SOC < 0.98 才能再生
2. **电网回馈限制**: 电网不接受再生能量 (grid_regen_acceptance_W = 0)
3. **储能功率限制**: 充电功率 ≤ 600 kW
4. **储能容量限制**: E ≤ Emax

---

## 二十四、储能初始状态 / 24. Initial Energy Storage State

### 实际运行值 / Actual Value

| 参数 | 数值 | 单位 |
|------|------|------|
| **初始 SOC** | 0.35 | - |
| **初始能量** | 26.76 | MJ |
| **初始电压** | 808.7 | V (计算) |

**来源 / Source**:
- L2_X100_behavior.m: `E = 26760000` (初始能量)
- 计算: SOC = (E - Emin) / (Emax - Emin) = (26.76 - 15) / (48.6 - 15) = 0.35

**说明 / Note**: 储能初始为部分充电状态，允许制动时立即吸收能量

---

## 二十五、外部工况完整性评估 / 25. External Conditions Completeness Assessment

### 已定义参数 / Defined Parameters (✅)

1. ✅ 接触网电压 (25 kV)
2. ✅ 接触网频率 (50 Hz)
3. ✅ 牵引/制动场景时间表
4. ✅ 制动触发时刻
5. ✅ 储能初始状态

### 缺失参数 / Missing Parameters (❌)

1. ❌ 线路坡度
2. ❌ 曲线半径
3. ❌ 隧道影响
4. ❌ 海拔
5. ❌ 黏着系数
6. ❌ 空气密度
7. ❌ 风速
8. ❌ 环境温度
9. ❌ 气压
10. ❌ 湿度
11. ❌ 载荷工况 (AW0/AW1/AW2/AW3)
12. ❌ 电网回馈能力模型
13. ❌ 线路限速

### 默认假设 / Default Assumptions

| 假设项 | 假设值 | 影响范围 |
|--------|--------|---------|
| 线路条件 | 平直 | 阻力计算 |
| 气候条件 | 标准海平面 | 空气阻力 |
| 黏着条件 | 理想 (无限) | 制动力限制 |
| 载荷工况 | 80吨 (固定) | 加速/制动性能 |

---

## 二十六、仿真场景适用性 / 26. Scenario Applicability

### 适用场景 / Applicable Scenarios

✅ **适合 / Suitable**:
1. 城市轨道车辆牵引制动功能验证
2. 再生制动能量回收策略研究
3. 车载储能系统功能测试
4. 制动力混合控制算法开发
5. 平直线路工况仿真

### 不适用场景 / Not Applicable Scenarios

❌ **不适合 / Not Suitable**:
1. 复杂线路条件仿真 (需要坡度/曲线参数)
2. 极端气候条件分析 (需要环境参数)
3. 多载荷工况对比 (需要 AW0-AW3 定义)
4. 电网回馈工况验证 (grid_regen=0)
5. 黏着极限分析 (无黏着约束)

---

## 二十七、外部工况总结 / 27. External Conditions Summary

### 核心结论 / Core Conclusions

1. **场景简化度 / Scenario Simplicity**: ⚠️ **HIGH (高度简化)**
   - 仅包含时间相关的工况阶段
   - 无空间相关的线路条件
   
2. **参数缺失度 / Parameter Missing Rate**: ⚠️ **~60%**
   - 关键线路参数全部缺失
   - 环境参数全部缺失
   
3. **模型适用范围 / Model Scope**: **通用功能验证**
   - 适用于算法和功能开发
   - 不适用于特定场景认证

### 推荐改进 / Recommended Improvements

**优先级 HIGH / HIGH Priority**:
1. 添加线路坡度参数
2. 添加黏着系数约束
3. 实现载荷工况切换

**优先级 MEDIUM / MEDIUM Priority**:
4. 添加空气密度和环境参数
5. 实现电网回馈能力模型
6. 添加曲线阻力模型

**优先级 LOW / LOW Priority**:
7. 添加风速影响
8. 实现热模型
9. 添加隧道附加阻力

---

**报告结束 / End of Report**

**审计负责 / Audit By**: Kilo AI Agent  
**审计时间 / Audit Time**: 2026-09-16T15:37:00Z
