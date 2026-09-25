# FMU Implementation Binding Baseline

## 基线声明

本实施绑定基线不是新的接口标准。唯一权威接口仍然是最终 All16 SSD：`work/sysmlv2/ssi_integration/03_ssd/Rail_MBSE_L2_All16_v1.ssd`。

本文件只建立以下可追溯实施链：

`SSD Connector → Simulink external port → FMU exposed variable`

旧合同 `Rail_MBSE_L2_SysML_Simulink_Interface_Contract_v1.xlsx` 仅用于工程名称、单位、语义及历史命名建议的 enrichment。任何冲突均保留 SSD 值，并标记 `LEGACY_CONTRACT_CONFLICT`。旧合同中的额外端口没有加入本基线。

## 冻结基线与覆盖率

- Component Binding: **16/16**
- Connector Binding Records: **138/138**
- Connection Binding Records: **74/74**
- No orphan SSD connector: **YES**
- No invented connector: **YES**
- No invented connection: **YES**
- No duplicate binding_id: **YES**
- Original SSD Modified: **NO**
- Full SysML Modified: **NO**

## Connector Readiness

状态为互斥主状态；`review_flags` 保留同一 Connector 的全部复核原因。

| Status | Count |
|---|---:|
| READY | 4 |
| UNIT_MISSING | 0 |
| TYPE_MISSING | 0 |
| DIRECTION_REVIEW_REQUIRED | 0 |
| SEMANTIC_REVIEW_REQUIRED | 15 |
| LEGACY_CONTRACT_CONFLICT | 119 |

Review-required connectors: **134**

## Connection Binding Validation

- Valid connection bindings: **73/74**
- Review required: **1/74**

| Connection ID | Source | Target | Review reason |
|---|---|---|---|
| CG_07AF42BFA3927EF22F7BDDE7 | L2_3600.p_3644_rp_af1c1b2c65382775 | L2_5300.p_5311_rp_97eb613c06ae1b2e | direction incompatible: output -> output |

不在本任务中修改 SSD 或修正方向；上述问题留给后续接口评审。

## Component Inventory

| Component | Engineering name | Connectors | Future Simulink | Future FMU | Readiness |
|---|---|---:|---|---|---|
| L2_3100 | 轮轴组成 | 4 | L2_3100.slx | L2_3100.fmu | REVIEW_REQUIRED |
| L2_3500 | 牵引传动耦合组件及其附件 | 2 | L2_3500.slx | L2_3500.fmu | REVIEW_REQUIRED |
| L2_3600 | 转向架相关检测 | 4 | L2_3600.slx | L2_3600.fmu | REVIEW_REQUIRED |
| L2_3800 | 辅助增粘及轮缘润滑 | 1 | L2_3800.slx | L2_3800.fmu | REVIEW_REQUIRED |
| L2_4100 | 高压受流 | 3 | L2_4100.slx | L2_4100.fmu | REVIEW_REQUIRED |
| L2_4200 | 网侧高压分配及控制 | 13 | L2_4200.slx | L2_4200.fmu | REVIEW_REQUIRED |
| L2_4400 | 回流及接地 | 0 | L2_4400.slx | L2_4400.fmu | READY |
| L2_4500 | 主变压器及其冷却 | 5 | L2_4500.slx | L2_4500.fmu | REVIEW_REQUIRED |
| L2_5100 | 牵引变流器主体及其控制 | 16 | L2_5100.slx | L2_5100.fmu | REVIEW_REQUIRED |
| L2_5300 | 牵引电机及其冷却 | 5 | L2_5300.slx | L2_5300.fmu | REVIEW_REQUIRED |
| L2_7100 | 供风 | 1 | L2_7100.slx | L2_7100.fmu | REVIEW_REQUIRED |
| L2_7200 | 制动 | 14 | L2_7200.slx | L2_7200.fmu | REVIEW_REQUIRED |
| L2_8100 | 列车主干网及安全回路 | 52 | L2_8100.slx | L2_8100.fmu | REVIEW_REQUIRED |
| L2_D100 | 操纵设施 | 4 | L2_D100.slx | L2_D100.fmu | REVIEW_REQUIRED |
| L2_E100 | ATP车载 | 2 | L2_E100.slx | L2_E100.fmu | REVIEW_REQUIRED |
| L2_X100 | 车载再生储能 | 12 | L2_X100.slx | L2_X100.fmu | REVIEW_REQUIRED |

每个组件的 Inputs、Outputs、连接对端和 readiness 已写入 `components/L2_<code>_binding.json`，共 16 份。

## Legacy Contract Comparison

- MATCHED: 4
- AMBIGUOUS: 10
- NOT_FOUND: 5
- CONFLICT: 119

| Binding | Conflict fields | Authoritative SSD connector |
|---|---|---|
| BIND::L2_3100::p_3121_rp_fdcd27ee9b0a936f | unit | p_3121_rp_fdcd27ee9b0a936f |
| BIND::L2_3100::p_3131_rp_06d152ddc255f2eb | unit | p_3131_rp_06d152ddc255f2eb |
| BIND::L2_3500::p_3511_rp_aa7691c6f81e4771 | unit | p_3511_rp_aa7691c6f81e4771 |
| BIND::L2_3500::p_3512_rp_c455741f6ca5a597 | unit | p_3512_rp_c455741f6ca5a597 |
| BIND::L2_3600::p_3644_rp_08c271db56ce8427 | unit | p_3644_rp_08c271db56ce8427 |
| BIND::L2_3800::p_3811_rp_81d4e1a7092e0653 | data_type | p_3811_rp_81d4e1a7092e0653 |
| BIND::L2_4100::p_411C_rp_201c13a158f19a88 | data_type | p_411C_rp_201c13a158f19a88 |
| BIND::L2_4100::p_411C_rp_72d2eed2608e1b56 | data_type | p_411C_rp_72d2eed2608e1b56 |
| BIND::L2_4200::p_4235_rp_6fea4b377f978aac | unit | p_4235_rp_6fea4b377f978aac |
| BIND::L2_4200::p_4236_rp_9107465175683792 | unit | p_4236_rp_9107465175683792 |
| BIND::L2_4200::p_4238_rp_0674d2b80a6a72da | data_type | p_4238_rp_0674d2b80a6a72da |
| BIND::L2_4200::p_4238_rp_11b7e7965ec2e386 | data_type | p_4238_rp_11b7e7965ec2e386 |
| BIND::L2_4200::p_4238_rp_5576b5e0dbb912ba | unit | p_4238_rp_5576b5e0dbb912ba |
| BIND::L2_4200::p_4238_rp_65aacc4600de3990 | data_type | p_4238_rp_65aacc4600de3990 |
| BIND::L2_4200::p_4238_rp_9458944450b0dd4c | data_type | p_4238_rp_9458944450b0dd4c |
| BIND::L2_4200::p_4238_rp_9744a4b3a255a6e8 | data_type | p_4238_rp_9744a4b3a255a6e8 |
| BIND::L2_4200::p_4238_rp_c7dcc306b020116f | unit | p_4238_rp_c7dcc306b020116f |
| BIND::L2_4200::p_4238_rp_d9d25dfbac32d1e3 | data_type | p_4238_rp_d9d25dfbac32d1e3 |
| BIND::L2_4200::p_4239_rp_c9c4c887a8c7b2f0 | data_type | p_4239_rp_c9c4c887a8c7b2f0 |
| BIND::L2_4500::p_4517_rp_b93b1716e8b4e844 | data_type | p_4517_rp_b93b1716e8b4e844 |
| BIND::L2_4500::p_4518_rp_67eef246e016ac82 | data_type | p_4518_rp_67eef246e016ac82 |
| BIND::L2_4500::p_4518_rp_a87c9390595138d6 | data_type | p_4518_rp_a87c9390595138d6 |
| BIND::L2_5100::p_5111_rp_5f90d6dd8fba4321 | unit | p_5111_rp_5f90d6dd8fba4321 |
| BIND::L2_5100::p_5111_rp_651700e69b7dccba | unit | p_5111_rp_651700e69b7dccba |
| BIND::L2_5100::p_5111_rp_cd7720cf9a4eae22 | unit | p_5111_rp_cd7720cf9a4eae22 |
| BIND::L2_5100::p_5112_rp_21e86fb073b61523 | unit | p_5112_rp_21e86fb073b61523 |
| BIND::L2_5100::p_5112_rp_4557e9b0656c46f5 | unit | p_5112_rp_4557e9b0656c46f5 |
| BIND::L2_5100::p_5112_rp_6ce5fb5c81d47ab4 | unit | p_5112_rp_6ce5fb5c81d47ab4 |
| BIND::L2_5100::p_5112_rp_780596fabcc73a0f | unit | p_5112_rp_780596fabcc73a0f |
| BIND::L2_5100::p_5113_rp_d93ff3dea2be11bd | data_type | p_5113_rp_d93ff3dea2be11bd |
| BIND::L2_5100::p_5131_rp_95979f7c6bb276e7 | unit | p_5131_rp_95979f7c6bb276e7 |
| BIND::L2_5100::p_5132_rp_75d86c9dc39b94b8 | unit | p_5132_rp_75d86c9dc39b94b8 |
| BIND::L2_5100::p_5142_rp_ff09931c451e831b | unit | p_5142_rp_ff09931c451e831b |
| BIND::L2_5100::p_5145_rp_1680714c67f7d311 | unit | p_5145_rp_1680714c67f7d311 |
| BIND::L2_5100::p_5145_rp_a9cc4822e30a5ede | unit | p_5145_rp_a9cc4822e30a5ede |
| BIND::L2_5300::p_5311_rp_537e9856bafa2a02 | unit | p_5311_rp_537e9856bafa2a02 |
| BIND::L2_5300::p_5311_rp_79c695a1342df24f | unit | p_5311_rp_79c695a1342df24f |
| BIND::L2_5300::p_5311_rp_97eb613c06ae1b2e | unit | p_5311_rp_97eb613c06ae1b2e |
| BIND::L2_7100::p_7142_rp_52f3b82b80918b84 | unit | p_7142_rp_52f3b82b80918b84 |
| BIND::L2_7200::p_7211_rp_0194ebfed505dfb5 | unit | p_7211_rp_0194ebfed505dfb5 |
| BIND::L2_7200::p_7211_rp_04cfaf63bfa3ed70 | unit | p_7211_rp_04cfaf63bfa3ed70 |
| BIND::L2_7200::p_7211_rp_179bcc3fb8dacbbf | unit | p_7211_rp_179bcc3fb8dacbbf |
| BIND::L2_7200::p_7211_rp_77afbfa330bfb95e | unit | p_7211_rp_77afbfa330bfb95e |
| BIND::L2_7200::p_7211_rp_c021f63639408eff | data_type | p_7211_rp_c021f63639408eff |
| BIND::L2_7200::p_7211_rp_d26568a796272d7a | data_type | p_7211_rp_d26568a796272d7a |
| BIND::L2_7200::p_7211_rp_da3049ae66223d22 | data_type | p_7211_rp_da3049ae66223d22 |
| BIND::L2_7200::p_7211_rp_daaf414c1711f2bd | data_type | p_7211_rp_daaf414c1711f2bd |
| BIND::L2_7200::p_7211_rp_e4d6047a07b1416e | unit | p_7211_rp_e4d6047a07b1416e |
| BIND::L2_7200::p_7211_rp_f786158194c89c8a | unit | p_7211_rp_f786158194c89c8a |
| BIND::L2_7200::p_7211_rp_faa6c7c9931b0a58 | data_type | p_7211_rp_faa6c7c9931b0a58 |
| BIND::L2_7200::p_7226_rp_5f6a9d81cebde2d3 | data_type | p_7226_rp_5f6a9d81cebde2d3 |
| BIND::L2_7200::p_722B_rp_8d219d5375ded80b | unit | p_722B_rp_8d219d5375ded80b |
| BIND::L2_7200::p_7254_rp_d9511ef0fa1c17df | unit | p_7254_rp_d9511ef0fa1c17df |
| BIND::L2_8100::p_8121_rp_0b58c63caeaf2f6d | unit | p_8121_rp_0b58c63caeaf2f6d |
| BIND::L2_8100::p_8121_rp_1c14ea3cdc439198 | data_type | p_8121_rp_1c14ea3cdc439198 |
| BIND::L2_8100::p_8121_rp_1e34bb2697325127 | data_type | p_8121_rp_1e34bb2697325127 |
| BIND::L2_8100::p_8121_rp_2ee1cd48c6d41ac7 | data_type | p_8121_rp_2ee1cd48c6d41ac7 |
| BIND::L2_8100::p_8121_rp_a9c7eff84933cd80 | data_type | p_8121_rp_a9c7eff84933cd80 |
| BIND::L2_8100::p_8121_rp_d82e5c8a7afb4b7b | unit | p_8121_rp_d82e5c8a7afb4b7b |
| BIND::L2_8100::p_8122_rp_1967a947dd39d4a5 | data_type | p_8122_rp_1967a947dd39d4a5 |
| BIND::L2_8100::p_8122_rp_35b0ef67b409e840 | unit | p_8122_rp_35b0ef67b409e840 |
| BIND::L2_8100::p_8122_rp_361eac651ec9fd05 | unit | p_8122_rp_361eac651ec9fd05 |
| BIND::L2_8100::p_8122_rp_4683a7cb63e55daf | data_type | p_8122_rp_4683a7cb63e55daf |
| BIND::L2_8100::p_8122_rp_47c78247980cc3a5 | data_type | p_8122_rp_47c78247980cc3a5 |
| BIND::L2_8100::p_8122_rp_77c439392dea95b4 | unit | p_8122_rp_77c439392dea95b4 |
| BIND::L2_8100::p_8122_rp_81e596aab3f0fe4c | data_type | p_8122_rp_81e596aab3f0fe4c |
| BIND::L2_8100::p_8122_rp_8c3ed075d33335e8 | unit | p_8122_rp_8c3ed075d33335e8 |
| BIND::L2_8100::p_8122_rp_9d3500c169fe7103 | data_type | p_8122_rp_9d3500c169fe7103 |
| BIND::L2_8100::p_8122_rp_a095b9b42ab5cc7d | unit | p_8122_rp_a095b9b42ab5cc7d |
| BIND::L2_8100::p_8122_rp_a4aac084c46e1e57 | data_type | p_8122_rp_a4aac084c46e1e57 |
| BIND::L2_8100::p_8122_rp_abc36140248d0eef | unit | p_8122_rp_abc36140248d0eef |
| BIND::L2_8100::p_8122_rp_b1fb8856841fb7cf | data_type | p_8122_rp_b1fb8856841fb7cf |
| BIND::L2_8100::p_8122_rp_bd78e8d84d334672 | unit | p_8122_rp_bd78e8d84d334672 |
| BIND::L2_8100::p_8122_rp_dae173a1561f3f35 | unit | p_8122_rp_dae173a1561f3f35 |
| BIND::L2_8100::p_8122_rp_e1808e35289aaba6 | unit | p_8122_rp_e1808e35289aaba6 |
| BIND::L2_8100::p_8122_rp_eb1cf5594b5796be | unit | p_8122_rp_eb1cf5594b5796be |
| BIND::L2_8100::p_8122_rp_f704c2e7bab06749 | data_type | p_8122_rp_f704c2e7bab06749 |
| BIND::L2_8100::p_8125_rp_1809c94f1581c7f8 | unit | p_8125_rp_1809c94f1581c7f8 |
| BIND::L2_8100::p_8125_rp_1faca3fc4ff0e741 | unit | p_8125_rp_1faca3fc4ff0e741 |
| BIND::L2_8100::p_8125_rp_36a59f5828d4c515 | unit | p_8125_rp_36a59f5828d4c515 |
| BIND::L2_8100::p_8125_rp_4e582bfad9ebbf1d | unit | p_8125_rp_4e582bfad9ebbf1d |
| BIND::L2_8100::p_8125_rp_70a8e2c4b0887b4d | unit | p_8125_rp_70a8e2c4b0887b4d |
| BIND::L2_8100::p_8125_rp_7262595caaf3b8d8 | unit | p_8125_rp_7262595caaf3b8d8 |
| BIND::L2_8100::p_8125_rp_b60dd66dcfd10afa | unit | p_8125_rp_b60dd66dcfd10afa |
| BIND::L2_8100::p_8125_rp_d69905c106b65d8f | unit | p_8125_rp_d69905c106b65d8f |
| BIND::L2_8100::p_8125_rp_dae11d7502a6c37a | data_type | p_8125_rp_dae11d7502a6c37a |
| BIND::L2_8100::p_8127_rp_8f3091a86214dd4e | data_type | p_8127_rp_8f3091a86214dd4e |
| BIND::L2_8100::p_8127_rp_a916a9847aeadebb | data_type | p_8127_rp_a916a9847aeadebb |
| BIND::L2_8100::p_8127_rp_be0fc7194a7f0161 | data_type | p_8127_rp_be0fc7194a7f0161 |
| BIND::L2_8100::p_8128_rp_0e19632016b69ff2 | unit | p_8128_rp_0e19632016b69ff2 |
| BIND::L2_8100::p_8128_rp_5accd69f9c3a8b0c | data_type | p_8128_rp_5accd69f9c3a8b0c |
| BIND::L2_8100::p_8128_rp_8d19f6989a5bebad | unit | p_8128_rp_8d19f6989a5bebad |
| BIND::L2_8100::p_8128_rp_cb74be2d7d4a54c7 | data_type | p_8128_rp_cb74be2d7d4a54c7 |
| BIND::L2_8100::p_8128_rp_cc7a917501039195 | unit | p_8128_rp_cc7a917501039195 |
| BIND::L2_8100::p_8128_rp_ccc90acd04ba0ccc | unit | p_8128_rp_ccc90acd04ba0ccc |
| BIND::L2_8100::p_8128_rp_ce6397cb7b81dd94 | data_type | p_8128_rp_ce6397cb7b81dd94 |
| BIND::L2_8100::p_8151_rp_d7d7f4cb9554ff03 | data_type | p_8151_rp_d7d7f4cb9554ff03 |
| BIND::L2_8100::p_8152_rp_93024c6ed1623fbd | data_type | p_8152_rp_93024c6ed1623fbd |
| BIND::L2_8100::p_8152_rp_ae53feffb1e116e3 | data_type | p_8152_rp_ae53feffb1e116e3 |
| BIND::L2_8100::p_8166_rp_3b0068559b0ca1e4 | unit | p_8166_rp_3b0068559b0ca1e4 |
| BIND::L2_8100::p_8166_rp_54d624d57f57843b | unit | p_8166_rp_54d624d57f57843b |
| BIND::L2_8100::p_8166_rp_573e029523ef9946 | unit | p_8166_rp_573e029523ef9946 |
| BIND::L2_8100::p_8166_rp_d9d89be1583c0e18 | unit | p_8166_rp_d9d89be1583c0e18 |
| BIND::L2_D100::p_D112_rp_8962dea15ad904c6 | data_type | p_D112_rp_8962dea15ad904c6 |
| BIND::L2_D100::p_D114_rp_d3d5739989ecf2dd | unit | p_D114_rp_d3d5739989ecf2dd |
| BIND::L2_D100::p_D121_rp_d32b32814a84a88a | data_type | p_D121_rp_d32b32814a84a88a |
| BIND::L2_E100::p_E100_rp_0307dc18d9537f9d | data_type | p_E100_rp_0307dc18d9537f9d |
| BIND::L2_E100::p_E100_rp_7273a171b473f816 | data_type | p_E100_rp_7273a171b473f816 |
| BIND::L2_X100::p_X111_rp_9828766df3df1904 | unit | p_X111_rp_9828766df3df1904 |
| BIND::L2_X100::p_X112_rp_1164249ec859b807 | data_type | p_X112_rp_1164249ec859b807 |
| BIND::L2_X100::p_X112_rp_388d943a537916a7 | unit | p_X112_rp_388d943a537916a7 |
| BIND::L2_X100::p_X112_rp_3b946767139d884a | data_type | p_X112_rp_3b946767139d884a |
| BIND::L2_X100::p_X112_rp_5ff890136d5d49bf | data_type | p_X112_rp_5ff890136d5d49bf |
| BIND::L2_X100::p_X112_rp_73067cce4e6a7eeb | unit | p_X112_rp_73067cce4e6a7eeb |
| BIND::L2_X100::p_X112_rp_81f1c1da5d6d3173 | data_type | p_X112_rp_81f1c1da5d6d3173 |
| BIND::L2_X100::p_X112_rp_843fa8c83311440e | unit | p_X112_rp_843fa8c83311440e |
| BIND::L2_X100::p_X112_rp_a59821acb0d73604 | unit | p_X112_rp_a59821acb0d73604 |
| BIND::L2_X100::p_X112_rp_b84f02a624b9982f | data_type | p_X112_rp_b84f02a624b9982f |
| BIND::L2_X100::p_X112_rp_e5eadfefaf46ac0a | data_type | p_X112_rp_e5eadfefaf46ac0a |

`AMBIGUOUS` 通常表示旧合同把一个物理接口展开为多个仿真量。该历史展开不会自动变成新的 SSD Connector 或 FMU variable。

## 命名与映射规则

- Simulink external port 默认等于 SSD Connector name。
- FMU variable 默认等于 SSD Connector name。
- 本基线未使用 hash 或 UUID 生成别名。
- 若名称技术上不合法，仅进行可读的字符清洗，并在 `alias_reason` 中记录。
- SSD `input` 映射为 Simulink `Inport` 和 FMU `input`。
- SSD `output` 映射为 Simulink `Outport` 和 FMU `output`。
- SSD 未提供显式 Connector `id` 属性，因此 `ssd_connector_id` 使用 `<component>.<connector>` 的限定身份，并显式记录其来源。

## 未来实施流程

```text
SSD
↓
Binding Baseline
↓
16 Simulink models
↓
FMU export
↓
FMU interface validation
↓
SSD-driven co-simulation
```

本次仅完成 Binding Baseline；未生成 Simulink 模型、Skeleton 或 FMU，也未运行 MATLAB、联合仿真、SSI Simulator、SysON 或 SysIDE。

## 最终状态

```text
FMU_BINDING_COMPONENTS = 16/16
FMU_BINDING_CONNECTORS = 138/138
FMU_BINDING_CONNECTIONS = 74/74
READY_CONNECTORS = 4
REVIEW_REQUIRED_CONNECTORS = 134
LEGACY_CONTRACT_CONFLICTS = 119
ORIGINAL_SSD_MODIFIED = NO
FULL_SYSML_MODIFIED = NO
FMU_IMPLEMENTATION_BINDING_BASELINE = PASS_WITH_REVIEW_ITEMS
```
