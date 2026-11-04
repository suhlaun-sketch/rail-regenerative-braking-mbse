# 天津地铁参数化牵引电机代理模型

本目录的 FMI 2.0 模型使用制造商公开铭牌参数生成恒转矩/恒功率包络。它不包含厂家效率 MAP、热网络或控制器标定，统一标记为 **parameterized surrogate traction motor model based on published nameplate data**。

`traction_motor_fmu_template.py` 保持与正式 `L2_5300` 的 FMI 端口兼容。流水线为每个候选注入已审计的铭牌常数，生成独立 FMU，并替换到正式 SSP 的副本中；正式 FMU、SSD、SSP 与 Simulink 模型不会被改写。
