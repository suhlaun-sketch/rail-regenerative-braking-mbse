# Rail_RegenerativeBraking_SC_v1 最终冻结报告

冻结日期：2026-09-02  
冻结对象：`Rail_RegenerativeBraking_SC_v1`  
冻结范围：V1（PMSM 牵引、再生制动、DC Bus、双向 DC/DC、SuperCap、MechanicalBrake）

## 1. 冻结结论

- 模型 `models/Rail_RegenerativeBraking_SC_v1.slx` 存在，大小 145,975 B。
- 最终只读核验中，`load_system` 成功，model update 成功；核验前、加载后及 update 后的仿真状态均为 `stopped`。
- 本次冻结核验未启动新的 63 s 完整仿真，也未重复 9 s mini-cycle。
- 已验证的物理参数、控制逻辑、FOC/SVPWM 和三组正式 Case 结果均未修改。
- 冻结版本不含 Battery、Battery DC/DC、HESS、MPC、PSO，也未开始 V2。
- 原始模型 `PMSM_PI_decomposition.slx` 和 baseline `PMSM_PI_decomposition_baseline.slx` 未覆盖。

## 2. 模型与顶层模块

最终 update 时确认以下九个顶层模块均为真实 `SubSystem`：

| 顶层模块 | 核验结果 |
|---|---|
| TestScenario | 存在 |
| TractionBrakeSupervisor | 存在 |
| TractionDrive | 存在 |
| VehicleDynamics | 存在 |
| DCBus | 存在 |
| SuperCapBranch | 存在 |
| MechanicalBrake | 存在 |
| EnergyAccounting | 存在 |
| Measurements | 存在 |

### TractionDrive

TractionDrive 复用了 baseline 的 PMSM、Universal Bridge、Clarke（原块名 `Clark`）、Park（原块名 `Plark`）、Anti-Park、Id PI、Iq PI、Speed PI、SVPWM 及电流/速度/转矩测量链。PMSM 采用机械转矩输入 `Torque Tm`；车辆质量按 36 个相同驱动单元折算为单电机轴端等效惯量，`J_equivalent = 45.2641 kg·m²`，未引入第二个机械速度积分器。

### VehicleDynamics 与 MechanicalBrake

车辆参数为：质量 295,900 kg、轮径 0.46 m、传动比 6.2、传动效率 0.97、36 个驱动单元；Davis 阻力系数为 A = 5,000 N、B = 50 N/(m/s)、C = 1.0 N/(m/s)²。目标制动减速度为 0.9 m/s²。MechanicalBrake 使用饱和与 0.15 s 一阶滞后；10 km/h 以上允许正常再生，5–10 km/h 逐步降低再生比例，5 km/h 以下由机械制动接管。

### DCBus

原理想 1,500 V 直流源不再直接无限吸收再生能量。冻结模型采用 1,500 V 牵引源、阻断反向回馈的二极管、线路 R/L 和 DC-link 电容构成独立 DC Bus，并配置母线电压/电流测量。

| 参数 | 冻结值 |
|---|---:|
| Cdc | 0.05 F |
| 线路 R | 0.02 Ω |
| 线路 L | 2 mH |
| Udc 初值 | 1,500 V |
| SC 充电启动阈值 | 1,510 V |
| Udc 控制目标 | 1,505 V |
| 再生降额阈值 | 1,580 V |
| Udc 上限参数 | 1,650 V |

### SuperCapBranch

SuperCapBranch 中确认存在 `BidirectionalDCDC_SC` 与 `Supercapacitor`。Supercapacitor 内部为 Specialized Power Systems 实际电气网络，包含：

- `ESR`：Series RLC Branch；
- `Csc`：Series RLC Branch；
- `Leakage`：Series RLC Branch；
- `SC_Current`：Current Measurement；
- `Terminal_Voltage` 和 `Capacitor_Voltage`：Voltage Measurement。

| 参数 | 冻结值 |
|---|---:|
| Csc | 200 F |
| ESR | 0.015 Ω |
| Leakage | 5,000 Ω |
| Umin | 400 V |
| Umax | 500 V |
| Case B 初始电压 | 420 V |
| Case C 初始电压 | 495 V |
| Isc 限流 | 1,200 A |
| SOC 上限 | 0.98 |

`BidirectionalDCDC_SC` 为能量守恒的平均值双向 DC/DC 模型，电气侧使用 SPS Controlled Current Source。V1 默认启用制动充电/Buck 路径：Udc 外环生成限幅电流指令，经 2 ms 平均电流动态驱动 DC/SC 两侧；充电效率为 0.96。Mode 定义为 0 = Idle、1 = Charge/Buck、2 = Discharge/Boost；Boost 逻辑已参数化，但 V1 默认关闭。

### 制动协调

TractionBrakeSupervisor 优先分配 PMSM 再生制动力，并受电机转矩、轮轨黏着、DC Bus 电压和 SuperCap SOC/电压能力约束；剩余制动需求由 MechanicalBrake 补足。无 SC 时，网侧阻断回馈且 DC-link 吸收能力有限，因此 BrakeBlending 将大量制动需求分配给 MechanicalBrake。有 SC 时，母线具备车载吸收通道，BrakeBlending 允许更多制动力由 PMSM 再生承担。

## 3. 三组正式 Case 指标

下表直接读取自已保存的 `SC_v1_metrics.csv`，本次核验未重新仿真。Case A 为无 SC，Case B 为启用 SC 且初始 420 V，Case C 为启用 SC 且接近满电（初始 495 V）。

| Case | Udc_peak (V) | Pregen_peak (MW) | Eregen_actual (kJ) | Esc_absorbed (kJ) | SOC_initial | SOC_final | Fmechanical_peak (kN) | Emechanical (kJ) | StoppingTime (s) | StoppingDistance (m) |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| A | 1702.4 | 0.48605 | 544.83 | 0 | 0.18222 | 0.18198 | 266.31 | 68,165 | 23.29 | 259.39 |
| B | 1642.6 | 1.4959 | 7,632.2 | 7,346.5 | 0.18222 | 0.97347 | 266.31 | 60,691 | 23.29 | 259.09 |
| C | 1646.0 | 0.47737 | 732.06 | 321.34 | 0.94472 | 0.97999 | 266.31 | 67,818 | 23.29 | 259.38 |

补充保存指标：Case A/B/C 的最大速度分别为 79.397、79.397、79.396 km/h；RecoveryRatio 分别为 0、0.96256、0.43896。

### 科研口径

- `Eregen_actual`：PMSM/逆变器实际执行并送入 DC Bus 的电气再生能量，对应结果 CSV 中的 `Eregen_kJ`。
- `Ebrake_available`：列车制动过程中理论可用于制动的机械能。它由车辆状态与制动过程决定，不等同于实际执行的电气再生能量；当前 metrics CSV 未将其作为独立数值列导出。
- Case A/B 的 `Eregen_actual` 差异不能表述为“产生的制动能量增加”。正确解释是：相同制动工况下，有 SC 时 BrakeBlending 允许 PMSM 执行更多再生制动，更多原本由 MechanicalBrake 消耗的制动份额转移到电气再生通道。
- 这一解释与能量分配结果一致：Case B 的机械制动耗散能量为 60,691 kJ，低于 Case A 的 68,165 kJ；同时 SC 吸收 7,346.5 kJ，SOC 从 0.18222 升至 0.97347。
- Case C 因初始 SOC 已高，SC 仅吸收 321.34 kJ，PMSM 实际再生和机械制动分配接近 Case A，体现了 SOC 上限约束。
- 三个 Case 的 `Fmechanical_peak` 均为 266.31 kN，主要由低速再生退出后的机械接管决定；比较制动分配时应同时观察 `Emechanical`，不能只比较峰值力。

## 4. 自动生成脚本核验

`scripts/build_Rail_RegenerativeBraking_SC_v1.m` 已从 baseline 完整执行过全部建模 Stage，并在 Stage 10 成功完成 model update 和最终保存。各阶段均调用 `save_system`，覆盖：baseline 克隆、TractionDrive、VehicleDynamics、MechanicalBrake、DCBus、Supercapacitor、BidirectionalDCDC_SC、控制器、整车连接、EnergyAccounting、Measurements、logging 和最终 update。

本次冻结仅再次运行 MATLAB Code Analyzer，未执行 builder，也未启动长仿真。Code Analyzer 结果：

- error：0；
- warning：0；
- info：1，位于第 150 行，建议用 `isscalar` 替代长度比较；该项不影响脚本执行与模型 update。

## 5. 结果文件核验

以下正式结果文件均存在且非空：

| 文件 | 大小（B） | 附加核验 |
|---|---:|---|
| SC_v1_results.mat | 118,060,552 | 含 SCv1、caseA_logs、caseB_logs、caseC_logs、metrics |
| SC_v1_metrics.csv | 750 | 三组 Case 完整指标 |
| SC_v1_signals.csv | 52,061,599 | 三组 Case 信号导出 |
| 01_train_speed.png | 98,683 | 1616×1022 |
| 02_motor_torque.png | 78,408 | 1639×1022 |
| 03_dc_bus_voltage.png | 104,553 | 1631×1022 |
| 04_regenerative_power.png | 83,012 | 1611×1021 |
| 05_supercap_voltage_current.png | 98,440 | 1650×1175 |
| 06_supercap_soc.png | 65,118 | 1623×1021 |
| 07_energy_recovery.png | 96,214 | 1608×1175 |
| 08_brake_blending.png | 71,287 | 1618×1022 |

## 6. 剩余警告与遗留诊断事项

只读核验未修改任何警告配置，也未为清除警告改动 FOC/SVPWM。

1. **Disabled library links**：模型内实际检测到 2 个 `LinkStatus=inactive` 的块：
   - `TractionBrakeSupervisor/Speed_PI_Reused`；
   - `powergui`。
2. **继承的 SVPWM Multiport Switch 诊断事项**：baseline 的 SVPWM 扇区逻辑存在控制值可能为 7、而 Multiport Switch 数据端口为 1–6 的遗留条件。冻结模型中 SVPWM 下 5 个 Multiport Switch 均为 `Inputs=6`、`DataPortForDefault=Last data port`、`DiagnosticForDefault=None`，因此本次 update 未重新输出该诊断；未改动其 FOC/SVPWM 逻辑。
3. **MATLAB 环境兼容性警告**：`lastwarn` 记录 `MATLAB:class:DynPropDuplicatesMethod`——名称 `display` 已用作方法名称，未来版本中将变为错误。该警告不是当前模型 update 失败；本次 model update 已成功，捕获的 update 输出中没有模型编译错误。

## 7. 冻结文件清单

V1 新建/冻结文件如下：

- `models/Rail_RegenerativeBraking_SC_v1.slx`
- `scripts/build_Rail_RegenerativeBraking_SC_v1.m`
- `config/SC_v1_parameters.m`
- `02_SC_v1_results/SC_v1_results.mat`
- `02_SC_v1_results/SC_v1_metrics.csv`
- `02_SC_v1_results/SC_v1_signals.csv`
- `02_SC_v1_results/01_train_speed.png`
- `02_SC_v1_results/02_motor_torque.png`
- `02_SC_v1_results/03_dc_bus_voltage.png`
- `02_SC_v1_results/04_regenerative_power.png`
- `02_SC_v1_results/05_supercap_voltage_current.png`
- `02_SC_v1_results/06_supercap_soc.png`
- `02_SC_v1_results/07_energy_recovery.png`
- `02_SC_v1_results/08_brake_blending.png`
- `02_SC_v1_results/SC_v1_final_report.md`（本报告）

## 8. 未解决问题

- 两个 baseline 继承块保持 inactive library link，后续若要恢复库链接，应单独评估其对已验证模型的影响。
- SVPWM Multiport Switch 的扇区 7 遗留诊断条件仍按 baseline 逻辑保留；V1 冻结时不改动。
- MATLAB 的 `display` 动态属性/方法重名兼容性警告仍存在，可能需要在未来 MATLAB 版本升级时复核。
- Case C 接近满电时，SC 可吸收能量明显受 SOC 上限限制；这是 V1 控制边界的预期行为，不在冻结阶段扩展控制策略。

至此，`Rail_RegenerativeBraking_SC_v1` 按已验证状态冻结。不加入 Battery，不启动 V2。
