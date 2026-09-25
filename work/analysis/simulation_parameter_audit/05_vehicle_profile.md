# 05_vehicle_profile.md
# Rail MBSE 车辆画像 / Vehicle Profile

**生成时间 / Generated**: 2026-09-16 15:37 UTC  
**项目 / Project**: 牵引制动能量回收 Rail Traction/Braking Energy Recovery  
**分析范围 / Scope**: 全系统仿真参数审计 Full System Simulation Parameter Audit

---

## 一、车辆类型明确性 / 1. Vehicle Type Explicitness

### 模型明确声明 / Model Explicit Declaration

**车型名称 / Vehicle Type**: `NOT EXPLICITLY DEFINED`

**状态 / Status**: ⚠️ **未找到明确车型名称**

**查找范围 / Search Coverage**:
- ✅ 全部 SysML 模型文件 (124+ files)
- ✅ 全部 Simulink 模型文件 (51 files)
- ✅ 全部参数配置 JSON/MATLAB (Rail_MBSE_Simulation_Parameters_v1/v2)
- ✅ 全部 FMU modelDescription.xml (16 files)
- ✅ SSP/SSD 定义文件
- ✅ 项目文档和报告 (26 reports)
- ✅ Excel 工作簿 (21 files)

**结论 / Conclusion**: 
- 该项目**没有明确的车型名称**或正式车辆型号标识
- 未找到任何形式的"车型"、"vehicle type"、"train model"、"EMU type"等显式声明

---

## 二、推断车辆等级 / 2. Inferred Vehicle Class

### INFERRED_VEHICLE_CLASS

**推断等级 / Inferred Class**: **城市轨道单动力单元级抽象模型**  
**English**: Urban rail single power unit abstract model

### 推断依据 / Inference Evidence

| 特征参数 | 数值 | 依据 |
|---------|------|------|
| 等效质量 | 80,000 kg | 代表性单动力单元质量 |
| 功率等级 | ~1.2 MW | 单动力单元级别 |
| 电压等级 | AC 25 kV / DC 1800 V | 标准城际/城轨制式 |
| 速度范围 | 0-30 m/s (0-108 km/h) | 城市轨道运行速度范围 |
| 储能配置 | 120 F 超级电容 | 单动力单元车载储能 |
| 编组形式 | 单动力单元 | 模型不涉及多编组 |

### 置信度 / Confidence Level

**置信度 / Confidence**: **MEDIUM (中等)**

**理由 / Rationale**:
1. ✅ **明确证据**: 质量、功率、电压数据一致指向单动力单元
2. ✅ **合理推断**: 参数规模与城市轨道车辆匹配
3. ⚠️ **缺乏确认**: 无正式车型文档支持
4. ⚠️ **泛化模型**: 模型设计为通用牵引制动研究平台，非特定车型

---

## 三、车辆/列车质量 / 3. Vehicle/Train Mass

### 最终运行值 / Final Runtime Value

**vehicle_mass_kg**: **80,000 kg**

### 来源与覆盖链 / Source and Override Chain

```
Rail_MBSE_Simulation_Parameters_v2.json (80000 kg)
  ↓
Rail_MBSE_Simulation_Parameters_v2.m: P.brake.vehicle_mass_kg = 80000
  ↓
L2_7200_behavior.m: mass = 80000  (制动力计算)
  ↓
L2_8100_behavior.m: mass = 80000  (制动需求计算)
  ↓
runner_v2.py: MASS = 80000.0  (后处理计算)
```

### 冲突记录 / Conflict Record

⚠️ **CONFLICT vs SC_v1**:
- **SC_v1 参考模型**: `SCv1.vehicle.mass = 295,900 kg` (整列车质量)
- **v2 实际模型**: `80,000 kg` (单动力单元等效质量)
- **差异倍数**: 3.7x
- **说明**: SC_v1 为整列车模型，v2 为单动力单元抽象

**结论**: 两个模型针对不同抽象层次，非参数错误。

---

## 四、速度等级 / 4. Speed Class

### 初始速度 / Initial Speed

**initial_speed_mps**: **0 m/s**  
**来源 / Source**: `IMPLICIT_DEFAULT` - L2_3100_behavior.m persistent omega_w = 0

### 最高速度 / Maximum Speed

**max_speed_mps**: **NOT EXPLICITLY DEFINED**

**实际仿真峰值速度 / Actual Simulation Peak Speed**:
- 从 SC_v1_results 和 v2 results 分析
- 牵引阶段 (0-20s) 峰值约 **25-30 m/s** (90-108 km/h)
- 制动前速度约 **20-25 m/s** (72-90 km/h)

**推断速度等级 / Inferred Speed Class**: **城市轨道 / Urban Rail (80-120 km/h)**

---

## 五、功率等级 / 5. Power Rating

### 变流器功率限制 / Converter Power Limit

**converter_power_limit_W**: **1,200,000 W (1.2 MW)**

### 电机扭矩限制 / Motor Torque Limit

**motor_torque_limit_Nm**: **6,000 N·m**

### 峰值牵引功率 / Peak Traction Power

根据仿真结果:
- **峰值机械功率**: ~800-1000 kW
- **峰值电气功率**: ~1.0-1.2 MW (含效率损耗)

### 功率等级结论 / Power Rating Conclusion

**功率等级 / Power Rating**: **~1.2 MW 单动力单元**
- 对应单节动车或单个牵引单元
- 与城市轨道车辆功率范围一致

---

## 六、电压等级 / 6. Voltage Rating

### 接触网电压 / Catenary Voltage

**line_voltage_V**: **25,000 V AC**  
**line_frequency_Hz**: **50 Hz**

**制式 / System**: 交流 25kV 50Hz (标准电气化铁路制式)

### DC 母线电压 / DC Bus Voltage

**dc_voltage_nominal_V**: **1,800 V**  
**dc_voltage_min_operating_V**: **1,200 V**  
**dc_voltage_max_V**: **2,100 V**

### 变压器变比 / Transformer Ratio

**transformer_ratio**: **0.06** (副边/原边)
- 25,000 V × 0.06 = 1,500 V (副边额定)
- 整流后 DC 1,800 V (含整流增益 1.2)

---

## 七、电机等级 / 7. Motor Rating

### 电机类型 / Motor Type

**推断类型 / Inferred Type**: **永磁同步电机 (PMSM)**

**依据 / Evidence**:
- 源自 PMSM_PI_decomposition.slx
- SC_v1_parameters.m: PMSM traction model
- L2_5300_behavior.m: wsync = 2πf/pole_pairs (同步速度计算)

### 电机参数 / Motor Parameters

| 参数 | 数值 | 单位 |
|------|------|------|
| 极对数 | 3 | - |
| 额定扭矩 | 6,000 | N·m |
| 牵引扭矩限制 | 4,500 | N·m (75% of rated) |
| 扭矩时间常数 | 0.2 | s |
| 电动效率 | 0.94 | - |
| 发电效率 | 0.92 | - |

---

## 八、制动等级 / 8. Braking Rating

### 最大制动减速度 / Maximum Braking Deceleration

**max_service_deceleration_mps2**: **1.2 m/s²**

### 最大制动力 / Maximum Braking Force

**总制动力 / Total**: F_total = m × a = 80,000 × 1.2 = **96,000 N**

**电制动力限制 / Dynamic Braking Limit**: **77,000 N**
- 约占总制动力的 80%
- 需机械制动补充约 19,000 N

**机械制动力能力 / Friction Braking Capacity**:
- 气缸最大压力: 600,000 Pa
- 主风缸压力: 900,000 Pa
- 能够提供足够的补偿制动力

---

## 九、储能等级 / 9. Energy Storage Rating

### 储能类型 / Storage Type

**超级电容 (Supercapacitor)**

### 储能参数 / Storage Parameters

| 参数 | 数值 | 单位 |
|------|------|------|
| 等效电容 | 120 | F |
| ESR | 0.04 | Ω |
| 最低电压 | 500 | V |
| 最高电压 | 900 | V |
| 最小能量 | 15 | MJ |
| 最大能量 | 48.6 | MJ |
| 能量范围 | 33.6 | MJ |
| 初始 SOC | 0.35 (26.76 MJ) | - |
| 充电功率限制 | 600 | kW |
| 放电功率限制 | 400 | kW |
| 电流限制 | 900 | A |

### 储能容量评估 / Storage Capacity Assessment

**能量密度等级 / Energy Density Class**: 低-中等 (超级电容特性)

**功率密度等级 / Power Density Class**: 高 (适合频繁充放电)

**应用适配性 / Application Suitability**:
- ✅ 适合城市轨道频繁起停工况
- ✅ 高功率密度支持快速能量回收
- ⚠️ 能量密度较低，不适合长距离能量存储

---

## 十、编组信息 / 10. Train Formation

### 编组形式 / Formation

**explicit_formation**: `NOT DEFINED`

**推断编组 / Inferred Formation**: **单动力单元抽象模型**

**证据 / Evidence**:
- 模型只包含单套动力系统 (1个牵引变流器、1个电机、1组车轮)
- 质量 80,000 kg 对应单节动车或单个牵引单元
- 没有多动力单元或编组逻辑

---

## 十一、载荷工况 / 11. Load Case

### 载荷状态 / Load Condition

**load_case**: `NOT EXPLICITLY DEFINED`

**标准载荷工况 (未定义) / Standard Load Cases (Not Defined)**:
- ❌ AW0 (空载)
- ❌ AW1 (额定载荷)
- ❌ AW2 (满载)
- ❌ AW3 (超载)

**实际使用工况 / Actual Operating Condition**:
- 模型使用单一固定质量 **80,000 kg**
- 未考虑不同载客工况
- **推断**: 代表某种名义载荷状态 (可能接近 AW1 或 AW2)

---

## 十二、传动系统 / 12. Drivetrain

### 齿轮传动比 / Gear Ratio

**gear_ratio**: **6.2**

### 传动效率 / Drivetrain Efficiency

**driveline_efficiency**: **0.96**

### 车轮半径 / Wheel Radius

**wheel_radius_m**: **0.46 m**

### 等效转动惯量 / Equivalent Rotational Inertia

**equivalent_rotational_inertia_kgm2**: **18,000 kg·m²**

**验证 / Verification**: 与 80,000 kg 质量和 0.46 m 车轮半径一致 (含传动系统惯量修正)

---

## 十三、阻力模型 / 13. Resistance Model

### 运行阻力 / Running Resistance

**模型形式 / Model Form**: 
```
T_resistance = T_base + k·ω²
```

**参数 / Parameters**:
- **rolling_resistance_torque_Nm**: 1,500 N·m (基础阻力矩)
- **aero_torque_coefficient**: 0.8 N·m/(rad/s)² (气动阻力系数)

**说明 / Note**: 
- 阻力直接在扭矩域建模，未明确分解为 Davis A/B/C 系数
- 未明确定义迎风面积、空气密度等气动参数
- 模型简化适用于仿真研究

---

## 十四、车辆画像总结 / 14. Vehicle Profile Summary

### 核心特征 / Core Characteristics

| 维度 | 特征 |
|------|------|
| **抽象层次** | 单动力单元功能级模型 |
| **应用领域** | 城市轨道 / 城际铁路 |
| **质量等级** | 80 吨级 |
| **功率等级** | 1.2 MW 级 |
| **速度等级** | 80-120 km/h |
| **供电制式** | AC 25 kV 50 Hz |
| **储能配置** | 120F 超级电容，33.6 MJ 可用能量 |
| **制动能力** | 1.2 m/s² 最大减速度 |
| **再生能力** | 77 kN 最大电制动力 |

### 模型定位 / Model Positioning

**设计意图 / Design Intent**:
- ✅ **通用牵引制动能量回收研究平台**
- ✅ **功能验证与算法开发**
- ✅ **系统级行为仿真**
- ⚠️ **非特定车型认证模型**

### 适用性声明 / Applicability Statement

**适用场景 / Applicable Scenarios**:
1. ✅ 再生制动能量回收策略研究
2. ✅ 车载储能系统功能验证
3. ✅ 制动力混合控制算法开发
4. ✅ 牵引/制动系统协调逻辑验证
5. ✅ 城市轨道车辆级系统仿真

**不适用场景 / Not Applicable Scenarios**:
1. ❌ 特定车型性能认证
2. ❌ 详细硬件参数标定
3. ❌ 多编组列车级仿真
4. ❌ 复杂线路条件建模 (坡度、曲线)

---

## 十五、与参考模型对比 / 15. Comparison with Reference Models

### SC_v1 参考模型 / SC_v1 Reference Model

| 参数 | SC_v1 | v2 当前模型 | 差异说明 |
|------|-------|------------|---------|
| 车辆质量 | 295,900 kg | 80,000 kg | SC_v1 为整列车，v2 为单动力单元 |
| 供电制式 | DC 1500 V | AC 25 kV | 不同电气化制式 |
| 超级电容 | 200 F | 120 F | 不同储能配置 |
| 驱动单元数 | 36 | 1 | SC_v1 为多动力单元 |
| 抽象层次 | 整列车级 | 单动力单元级 | 建模粒度不同 |

**结论 / Conclusion**: SC_v1 和 v2 是**不同抽象层次**的模型，参数差异是设计选择，非参数冲突。

---

## 十六、置信度评估 / 16. Confidence Assessment

### 参数置信度分布 / Parameter Confidence Distribution

| 置信度 | 数量 | 百分比 | 说明 |
|--------|------|--------|------|
| **HIGH** | 32 | 32% | 明确定义且经验证 |
| **MEDIUM** | 58 | 58% | 工程假设或文献典型值 |
| **LOW** | 10 | 10% | 需标定或不确定 |

### 车辆画像总体置信度 / Overall Profile Confidence

**MEDIUM (中等)**

**理由 / Rationale**:
- ✅ 参数规模与物理合理性一致
- ✅ 模型行为与预期相符
- ⚠️ 无正式车型文档支持
- ⚠️ 部分参数为工程假设
- ⚠️ 缺少实车标定数据

---

**报告结束 / End of Report**

**审计负责 / Audit By**: Kilo AI Agent  
**审计时间 / Audit Time**: 2026-09-16T15:37:00Z
