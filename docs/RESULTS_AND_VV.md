# 冻结结果与 V&V

v2.1 FINAL 证据入口：

- `work/simulation/simulink_fmu_v2_1_final/08_reports/Final_Status_v2_1.txt`：冻结总状态。
- `work/simulation/simulink_fmu_v2_1_final/07_results/Rail_MBSE_All16_FMU_CoSimulation_Results_v2_1.csv`：主时间序列。
- 同目录的 `Brake_Transition_VV_v2_1.json`、`Regenerative_Energy_Flow_Audit_v2_1.json`、`plots/`：刹车及能量核验。
- `08_reports/Rail_MBSE_Simulink_FMU_CoSimulation_v2_1_Report.md`、`Physical_Consistency_Audit_v2_1.md`：解释与审核。
- `08_reports/V2_1_FINAL_FREEZE_MANIFEST.json`：冻结清单。

归档状态记录 16/16 FMU、151/151 接口变量、87/87 连接、SSP PASS、联合仿真 PASS、物理 V&V PASS；回收能量 3.723557 MJ、最终 SOC 46.082016%、能量残差 0.000000%。这些数字来自冻结文件，未暗示在同事机器上重算 PASS。`python scripts/check_release.py --hashes` 能查丢失/篡改；`scripts/run_fmu_job.py` 可在独立 jobs 中重新计算。
