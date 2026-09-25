# Candidate Connection Report

- Interface-compatible raw candidates: 1124
- Hard-rule candidates: 147
- BOUNDARY: 11
- SERIES: 26
- SIGNAL: 96
- TAP: 14
- Candidate nets: 9
- Net members: 83
- Variant conflicts: 2
- UNRESOLVED_ROUTE: 6
- Hard-rule violations: 0
- Final CONNECTS_TO created: no

## UNRESOLVED_ROUTE

- `PORT::8128::超级电容温度输入::ITM-MEA-027::输入` / ITM-MEA-027: multiple I/O deployment routes; direct bypass and automatic router choice suppressed
- `PORT::8128::超级电容电压输入::ITM-MEA-025::输入` / ITM-MEA-025: multiple I/O deployment routes; direct bypass and automatic router choice suppressed
- `PORT::8128::超级电容电流输入::ITM-MEA-026::输入` / ITM-MEA-026: multiple I/O deployment routes; direct bypass and automatic router choice suppressed
- `PORT::X112::超级电容温度输入::ITM-MEA-027::输入` / ITM-MEA-027: multiple I/O deployment routes; direct bypass and automatic router choice suppressed
- `PORT::X112::超级电容电压输入::ITM-MEA-025::输入` / ITM-MEA-025: multiple I/O deployment routes; direct bypass and automatic router choice suppressed
- `PORT::X112::超级电容电流输入::ITM-MEA-026::输入` / ITM-MEA-026: multiple I/O deployment routes; direct bypass and automatic router choice suppressed

## Command cardinality unresolved

- COMMAND_CARDINALITY `PORT::4238::高压断路器指令输入::ITM-CMD-016::输入`: 4239, 4518
- SIGNAL_SOURCE_AMBIGUITY `PORT::4238::高压系统故障状态输入::ITM-STA-016::输入`: 411C, 4211, 4239, 4517
- SIGNAL_SOURCE_AMBIGUITY `PORT::5111::中间直流母线电压输入::ITM-MEA-008::输入`: 
- SIGNAL_SOURCE_AMBIGUITY `PORT::5111::中间直流母线电流输入::ITM-MEA-009::输入`: 5113, 5131, 5132, 5145
- SIGNAL_SOURCE_AMBIGUITY `PORT::5111::高压线路电压输入::ITM-MEA-005::输入`: 
- SIGNAL_SOURCE_AMBIGUITY `PORT::5111::高压线路电流输入::ITM-MEA-006::输入`: 
- SIGNAL_SOURCE_AMBIGUITY `PORT::5112::中间直流母线电压输入::ITM-MEA-008::输入`: 
- SIGNAL_SOURCE_AMBIGUITY `PORT::5112::中间直流母线电流输入::ITM-MEA-009::输入`: 5113, 5131, 5132, 5145
- SIGNAL_SOURCE_AMBIGUITY `PORT::5112::电机侧相电压输入::ITM-MEA-011::输入`: 5132, 5311
- SIGNAL_SOURCE_AMBIGUITY `PORT::5112::电机侧相电流输入::ITM-MEA-010::输入`: 5113, 5132, 5311
- SIGNAL_SOURCE_AMBIGUITY `PORT::5133::中间直流母线电压输入::ITM-MEA-008::输入`: 
- SIGNAL_SOURCE_AMBIGUITY `PORT::7211::低风压状态输入::ITM-STA-009::输入`: 7142, 722C
- SIGNAL_SOURCE_AMBIGUITY `PORT::7211::制动安全回路状态输入::ITM-STA-025::输入`: 
- COMMAND_CARDINALITY `PORT::8121::安全停车_制动请求输入::ITM-CMD-030::输入`: 8127, E100
- SIGNAL_SOURCE_AMBIGUITY `PORT::8121::牵引可用状态输入::ITM-STA-001::输入`: 5112, 8125
- SIGNAL_SOURCE_AMBIGUITY `PORT::8122::中间直流母线电压输入::ITM-MEA-008::输入`: 
- SIGNAL_SOURCE_AMBIGUITY `PORT::8122::再生功率上限输入::ITM-LIM-004::输入`: 5111, 5112, 8125
- COMMAND_CARDINALITY `PORT::8122::列车方向指令输入::ITM-CMD-001::输入`: 8121, D112
- SIGNAL_SOURCE_AMBIGUITY `PORT::8122::制动电阻耗散功率输入::ITM-ACC-005::输入`: 5142, 8166
- SIGNAL_SOURCE_AMBIGUITY `PORT::8122::动态制动可用状态输入::ITM-STA-002::输入`: 5112, 8125
- SIGNAL_SOURCE_AMBIGUITY `PORT::8122::双向DC_DC实际功率输入::ITM-MEA-029::输入`: 
- SIGNAL_SOURCE_AMBIGUITY `PORT::8122::可用动态制动力输入::ITM-LIM-001::输入`: 5112, 8125
- SIGNAL_SOURCE_AMBIGUITY `PORT::8122::回馈电网功率输入::ITM-ACC-003::输入`: 4241, 5131, 8166
- COMMAND_CARDINALITY `PORT::8122::安全停车_制动请求输入::ITM-CMD-030::输入`: 8127, E100
- SIGNAL_SOURCE_AMBIGUITY `PORT::8122::实际再生功率输入::ITM-ACC-002::输入`: 5132, 8166
- COMMAND_CARDINALITY `PORT::8122::服务制动请求输入::ITM-CMD-003::输入`: 8121, D114
- SIGNAL_SOURCE_AMBIGUITY `PORT::8122::牵引变流器故障状态输入::ITM-STA-019::输入`: 5111, 5112, 5113, 8125
- SIGNAL_SOURCE_AMBIGUITY `PORT::8122::牵引可用状态输入::ITM-STA-001::输入`: 5112, 8125
- COMMAND_CARDINALITY `PORT::8122::牵引指令输入::ITM-CMD-002::输入`: 8121, D113
- COMMAND_CARDINALITY `PORT::8122::紧急制动请求输入::ITM-CMD-004::输入`: 8121, D121
- SIGNAL_SOURCE_AMBIGUITY `PORT::8122::超级电容SOC输入::ITM-MEA-028::输入`: 
- SIGNAL_SOURCE_AMBIGUITY `PORT::8125::中间直流母线电压输入::ITM-MEA-008::输入`: 
- SIGNAL_SOURCE_AMBIGUITY `PORT::8127::ATP_外部安全系统状态输入::ITM-STA-027::输入`: 
- COMMAND_CARDINALITY `PORT::8128::撒砂请求输入::ITM-CMD-024::输入`: 8122, D13B
- COMMAND_CARDINALITY `PORT::8154::牵引使能指令输入::ITM-CMD-009::输入`: 8121, 8122
- COMMAND_CARDINALITY `PORT::8154::牵引切除请求输入::ITM-CMD-008::输入`: 7211, 8121, 8122
- SIGNAL_SOURCE_AMBIGUITY `PORT::8166::中间直流母线电压输入::ITM-MEA-008::输入`: 
- SIGNAL_SOURCE_AMBIGUITY `PORT::8166::中间直流母线电流输入::ITM-MEA-009::输入`: 5113, 5131, 5132, 5145
- SIGNAL_SOURCE_AMBIGUITY `PORT::X112::中间直流母线电压输入::ITM-MEA-008::输入`: 5113, 5131, 5132, 5145, X113
- SIGNAL_SOURCE_AMBIGUITY `PORT::X112::储能保护跳闸状态输入::ITM-STA-034::输入`: X113, X133
- SIGNAL_SOURCE_AMBIGUITY `PORT::X112::双向DC_DC电流输入::ITM-MEA-030::输入`: X111, X113
- SIGNAL_SOURCE_AMBIGUITY `PORT::X112::直流母线电压上限输入::ITM-LIM-007::输入`: 5113, 5145, X113
