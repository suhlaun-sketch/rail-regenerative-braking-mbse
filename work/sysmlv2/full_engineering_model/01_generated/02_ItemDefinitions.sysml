package ItemDefinitions {
    private import ScalarValues::*;
    item def I_ITM_ACC_001 {
        attribute itemCode : String = "ITM-ACC-001";
        attribute chineseName : String = "牵引实际功率";
        attribute englishName : String = "TractionPowerActual";
        attribute family : String = "能量统计";
        attribute domain : String = "能量统计";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "W";
        attribute semanticDefinition : String = "车辆牵引工况实际消耗的牵引功率。";
        attribute aliases : String = "P_trac";
        attribute priority : String = "监测";
        attribute validityRule : String = "积分窗口/符号约定/初值必须固定";
        attribute faultStrategy : String = "DiagnosticOnly";
    }
    item def I_ITM_ACC_002 {
        attribute itemCode : String = "ITM-ACC-002";
        attribute chineseName : String = "实际再生功率";
        attribute englishName : String = "RegenerativePowerActual";
        attribute family : String = "能量统计";
        attribute domain : String = "能量统计";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "W";
        attribute semanticDefinition : String = "制动过程中牵引电机/变流器实际产生的再生电功率。";
        attribute aliases : String = "P_reg_actual;再生功率";
        attribute priority : String = "核心";
        attribute validityRule : String = "积分窗口/符号约定/初值必须固定";
        attribute faultStrategy : String = "DiagnosticOnly";
    }
    item def I_ITM_ACC_003 {
        attribute itemCode : String = "ITM-ACC-003";
        attribute chineseName : String = "回馈电网功率";
        attribute englishName : String = "GridReturnedPower";
        attribute family : String = "能量统计";
        attribute domain : String = "能量统计";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "W";
        attribute semanticDefinition : String = "实际回馈至外部供电网络的电功率。";
        attribute aliases : String = "P_grid_return;回馈功率";
        attribute priority : String = "核心";
        attribute validityRule : String = "积分窗口/符号约定/初值必须固定";
        attribute faultStrategy : String = "DiagnosticOnly";
    }
    item def I_ITM_ACC_004 {
        attribute itemCode : String = "ITM-ACC-004";
        attribute chineseName : String = "储能吸收功率";
        attribute englishName : String = "ESSAbsorbedPower";
        attribute family : String = "能量统计";
        attribute domain : String = "能量统计";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "W";
        attribute semanticDefinition : String = "超级电容储能支路实际吸收的再生功率。";
        attribute aliases : String = "P_ESS_absorb";
        attribute priority : String = "核心";
        attribute validityRule : String = "积分窗口/符号约定/初值必须固定";
        attribute faultStrategy : String = "DiagnosticOnly";
    }
    item def I_ITM_ACC_005 {
        attribute itemCode : String = "ITM-ACC-005";
        attribute chineseName : String = "制动电阻耗散功率";
        attribute englishName : String = "BrakeResistorDissipatedPower";
        attribute family : String = "能量统计";
        attribute domain : String = "能量统计";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "W";
        attribute semanticDefinition : String = "制动电阻实际耗散功率。";
        attribute aliases : String = "P_rheo;电阻耗散功率";
        attribute priority : String = "核心";
        attribute validityRule : String = "积分窗口/符号约定/初值必须固定";
        attribute faultStrategy : String = "DiagnosticOnly";
    }
    item def I_ITM_ACC_006 {
        attribute itemCode : String = "ITM-ACC-006";
        attribute chineseName : String = "摩擦制动耗散功率";
        attribute englishName : String = "FrictionBrakeDissipatedPower";
        attribute family : String = "能量统计";
        attribute domain : String = "能量统计";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "W";
        attribute semanticDefinition : String = "摩擦制动通道实际耗散的机械功率。";
        attribute aliases : String = "P_friction";
        attribute priority : String = "条件";
        attribute validityRule : String = "积分窗口/符号约定/初值必须固定";
        attribute faultStrategy : String = "DiagnosticOnly";
    }
    item def I_ITM_ACC_007 {
        attribute itemCode : String = "ITM-ACC-007";
        attribute chineseName : String = "牵引累计能量";
        attribute englishName : String = "TractionEnergyConsumed";
        attribute family : String = "能量统计";
        attribute domain : String = "能量统计";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "J";
        attribute semanticDefinition : String = "牵引阶段累计消耗的电能。";
        attribute aliases : String = "E_trac";
        attribute priority : String = "监测";
        attribute validityRule : String = "积分窗口/符号约定/初值必须固定";
        attribute faultStrategy : String = "DiagnosticOnly";
    }
    item def I_ITM_ACC_008 {
        attribute itemCode : String = "ITM-ACC-008";
        attribute chineseName : String = "再生发电累计能量";
        attribute englishName : String = "RegenerativeEnergyGenerated";
        attribute family : String = "能量统计";
        attribute domain : String = "能量统计";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "J";
        attribute semanticDefinition : String = "电制动实际转换得到的累计再生电能。";
        attribute aliases : String = "E_regen;再生能量";
        attribute priority : String = "核心";
        attribute validityRule : String = "积分窗口/符号约定/初值必须固定";
        attribute faultStrategy : String = "DiagnosticOnly";
    }
    item def I_ITM_ACC_009 {
        attribute itemCode : String = "ITM-ACC-009";
        attribute chineseName : String = "回馈电网累计能量";
        attribute englishName : String = "GridReturnedEnergy";
        attribute family : String = "能量统计";
        attribute domain : String = "能量统计";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "J";
        attribute semanticDefinition : String = "实际回馈到供电网络的累计能量。";
        attribute aliases : String = "E_grid_return";
        attribute priority : String = "核心";
        attribute validityRule : String = "积分窗口/符号约定/初值必须固定";
        attribute faultStrategy : String = "DiagnosticOnly";
    }
    item def I_ITM_ACC_010 {
        attribute itemCode : String = "ITM-ACC-010";
        attribute chineseName : String = "储能吸收累计能量";
        attribute englishName : String = "ESSAbsorbedEnergy";
        attribute family : String = "能量统计";
        attribute domain : String = "能量统计";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "J";
        attribute semanticDefinition : String = "超级电容储能支路累计吸收的再生能量。";
        attribute aliases : String = "E_ESS_absorb;SC absorbed energy";
        attribute priority : String = "核心";
        attribute validityRule : String = "积分窗口/符号约定/初值必须固定";
        attribute faultStrategy : String = "DiagnosticOnly";
    }
    item def I_ITM_ACC_011 {
        attribute itemCode : String = "ITM-ACC-011";
        attribute chineseName : String = "储能释放累计能量";
        attribute englishName : String = "ESSDischargedEnergy";
        attribute family : String = "能量统计";
        attribute domain : String = "能量统计";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "J";
        attribute semanticDefinition : String = "超级电容向直流母线累计释放的能量。";
        attribute aliases : String = "E_ESS_discharge";
        attribute priority : String = "监测";
        attribute validityRule : String = "积分窗口/符号约定/初值必须固定";
        attribute faultStrategy : String = "DiagnosticOnly";
    }
    item def I_ITM_ACC_012 {
        attribute itemCode : String = "ITM-ACC-012";
        attribute chineseName : String = "制动电阻耗散累计能量";
        attribute englishName : String = "BrakeResistorDissipatedEnergy";
        attribute family : String = "能量统计";
        attribute domain : String = "能量统计";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "J";
        attribute semanticDefinition : String = "制动电阻累计耗散的电能。";
        attribute aliases : String = "E_rheo";
        attribute priority : String = "核心";
        attribute validityRule : String = "积分窗口/符号约定/初值必须固定";
        attribute faultStrategy : String = "DiagnosticOnly";
    }
    item def I_ITM_ACC_013 {
        attribute itemCode : String = "ITM-ACC-013";
        attribute chineseName : String = "摩擦制动耗散累计能量";
        attribute englishName : String = "FrictionBrakeDissipatedEnergy";
        attribute family : String = "能量统计";
        attribute domain : String = "能量统计";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "J";
        attribute semanticDefinition : String = "摩擦制动累计耗散的机械能。";
        attribute aliases : String = "E_friction";
        attribute priority : String = "条件";
        attribute validityRule : String = "积分窗口/符号约定/初值必须固定";
        attribute faultStrategy : String = "DiagnosticOnly";
    }
    item def I_ITM_ACC_014 {
        attribute itemCode : String = "ITM-ACC-014";
        attribute chineseName : String = "可用制动能量";
        attribute englishName : String = "AvailableBrakingEnergy";
        attribute family : String = "能量统计";
        attribute domain : String = "能量统计";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "J";
        attribute semanticDefinition : String = "用于能量回收率评价的理论/基准可用制动能量,定义必须在验证方案中固定。";
        attribute aliases : String = "E_brake_available;理论制动能量";
        attribute priority : String = "核心";
        attribute validityRule : String = "积分窗口/符号约定/初值必须固定";
        attribute faultStrategy : String = "DiagnosticOnly";
    }
    item def I_ITM_ACC_015 {
        attribute itemCode : String = "ITM-ACC-015";
        attribute chineseName : String = "能量回收率";
        attribute englishName : String = "EnergyRecoveryRatio";
        attribute family : String = "能量统计";
        attribute domain : String = "能量统计";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "1";
        attribute semanticDefinition : String = "按项目统一分母定义计算的有效再生能量回收比例。";
        attribute aliases : String = "回收效率;回收率";
        attribute priority : String = "监测";
        attribute validityRule : String = "积分窗口/符号约定/初值必须固定";
        attribute faultStrategy : String = "DiagnosticOnly";
    }
    item def I_ITM_CMD_001 {
        attribute itemCode : String = "ITM-CMD-001";
        attribute chineseName : String = "列车方向指令";
        attribute englishName : String = "TrainDirectionCommand";
        attribute family : String = "命令/请求";
        attribute domain : String = "驾驶/控制";
        attribute datatype : String = "Enum";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "司机或控制系统给出的列车运行方向选择。";
        attribute aliases : String = "方向指令;前进后退";
        attribute priority : String = "核心";
        attribute validityRule : String = "应包含有效位/时效性/范围检查";
        attribute faultStrategy : String = "RejectStale+SafeFallback";
    }
    item def I_ITM_CMD_002 {
        attribute itemCode : String = "ITM-CMD-002";
        attribute chineseName : String = "牵引指令";
        attribute englishName : String = "TractionCommand";
        attribute family : String = "命令/请求";
        attribute domain : String = "驾驶/牵引";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "1";
        attribute semanticDefinition : String = "司机/ATO等给出的归一化牵引需求。";
        attribute aliases : String = "牵引级位;牵引需求";
        attribute priority : String = "核心";
        attribute validityRule : String = "应包含有效位/时效性/范围检查";
        attribute faultStrategy : String = "RejectStale+SafeFallback";
    }
    item def I_ITM_CMD_003 {
        attribute itemCode : String = "ITM-CMD-003";
        attribute chineseName : String = "服务制动请求";
        attribute englishName : String = "ServiceBrakeRequest";
        attribute family : String = "命令/请求";
        attribute domain : String = "制动";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "1 或 m/s2";
        attribute semanticDefinition : String = "服务制动需求;可采用归一化请求或减速度请求,工程中必须在接口处固定一种语义。";
        attribute aliases : String = "常用制动请求;制动级位;服务制动减速度请求";
        attribute priority : String = "核心";
        attribute validityRule : String = "应包含有效位/时效性/范围检查";
        attribute faultStrategy : String = "RejectStale+SafeFallback";
    }
    item def I_ITM_CMD_004 {
        attribute itemCode : String = "ITM-CMD-004";
        attribute chineseName : String = "紧急制动请求";
        attribute englishName : String = "EmergencyBrakeRequest";
        attribute family : String = "命令/请求";
        attribute domain : String = "制动";
        attribute datatype : String = "Boolean";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "触发紧急制动的有效请求。";
        attribute aliases : String = "EB请求;紧急制动命令";
        attribute priority : String = "核心";
        attribute validityRule : String = "应包含有效位/时效性/范围检查";
        attribute faultStrategy : String = "RejectStale+SafeFallback";
    }
    item def I_ITM_CMD_005 {
        attribute itemCode : String = "ITM-CMD-005";
        attribute chineseName : String = "总制动力请求";
        attribute englishName : String = "TotalBrakeForceRequest";
        attribute family : String = "命令/请求";
        attribute domain : String = "制动";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "N";
        attribute semanticDefinition : String = "由制动控制根据服务/紧急请求、质量和运行状态形成的列车总制动力需求。";
        attribute aliases : String = "总制动力指令;列车制动力需求";
        attribute priority : String = "核心";
        attribute validityRule : String = "应包含有效位/时效性/范围检查";
        attribute faultStrategy : String = "RejectStale+SafeFallback";
    }
    item def I_ITM_CMD_006 {
        attribute itemCode : String = "ITM-CMD-006";
        attribute chineseName : String = "动态制动力请求";
        attribute englishName : String = "DynamicBrakeForceRequest";
        attribute family : String = "命令/请求";
        attribute domain : String = "牵引/制动";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "N";
        attribute semanticDefinition : String = "分配给牵引电制动通道的动态制动力请求。";
        attribute aliases : String = "电制动力请求;再生制动力请求";
        attribute priority : String = "核心";
        attribute validityRule : String = "应包含有效位/时效性/范围检查";
        attribute faultStrategy : String = "RejectStale+SafeFallback";
    }
    item def I_ITM_CMD_007 {
        attribute itemCode : String = "ITM-CMD-007";
        attribute chineseName : String = "摩擦制动力请求";
        attribute englishName : String = "FrictionBrakeForceRequest";
        attribute family : String = "命令/请求";
        attribute domain : String = "制动";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "N";
        attribute semanticDefinition : String = "分配给摩擦制动通道的制动力请求。";
        attribute aliases : String = "机械制动力请求;空气制动力请求";
        attribute priority : String = "核心";
        attribute validityRule : String = "应包含有效位/时效性/范围检查";
        attribute faultStrategy : String = "RejectStale+SafeFallback";
    }
    item def I_ITM_CMD_008 {
        attribute itemCode : String = "ITM-CMD-008";
        attribute chineseName : String = "牵引切除请求";
        attribute englishName : String = "TractionCutOffRequest";
        attribute family : String = "命令/请求";
        attribute domain : String = "牵引/制动";
        attribute datatype : String = "Boolean";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "制动或安全功能要求牵引系统禁止输出牵引力的请求。";
        attribute aliases : String = "牵引封锁;牵引切断命令";
        attribute priority : String = "核心";
        attribute validityRule : String = "应包含有效位/时效性/范围检查";
        attribute faultStrategy : String = "RejectStale+SafeFallback";
    }
    item def I_ITM_CMD_009 {
        attribute itemCode : String = "ITM-CMD-009";
        attribute chineseName : String = "牵引使能指令";
        attribute englishName : String = "TractionEnableCommand";
        attribute family : String = "命令/请求";
        attribute domain : String = "牵引";
        attribute datatype : String = "Boolean";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "允许牵引控制进入可输出牵引转矩状态的指令。";
        attribute aliases : String = "牵引允许;牵引使能";
        attribute priority : String = "核心";
        attribute validityRule : String = "应包含有效位/时效性/范围检查";
        attribute faultStrategy : String = "RejectStale+SafeFallback";
    }
    item def I_ITM_CMD_010 {
        attribute itemCode : String = "ITM-CMD-010";
        attribute chineseName : String = "网侧变流控制指令";
        attribute englishName : String = "GridSideConverterCommand";
        attribute family : String = "命令/请求";
        attribute domain : String = "牵引";
        attribute datatype : String = "ControlVector";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "网侧变流器控制模块向网侧功率模块发出的规范化控制指令;实现可映射为PWM、dq电流或功率控制量。";
        attribute aliases : String = "网侧PWM;网侧电流指令;网侧功率指令";
        attribute priority : String = "核心";
        attribute validityRule : String = "应包含有效位/时效性/范围检查";
        attribute faultStrategy : String = "RejectStale+SafeFallback";
    }
    item def I_ITM_CMD_011 {
        attribute itemCode : String = "ITM-CMD-011";
        attribute chineseName : String = "电机侧变流控制指令";
        attribute englishName : String = "MotorSideConverterCommand";
        attribute family : String = "命令/请求";
        attribute domain : String = "牵引";
        attribute datatype : String = "ControlVector";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "电机侧控制模块向电机侧功率模块发出的规范化控制指令。";
        attribute aliases : String = "逆变器控制指令;电机侧PWM;dq控制指令";
        attribute priority : String = "核心";
        attribute validityRule : String = "应包含有效位/时效性/范围检查";
        attribute faultStrategy : String = "RejectStale+SafeFallback";
    }
    item def I_ITM_CMD_012 {
        attribute itemCode : String = "ITM-CMD-012";
        attribute chineseName : String = "牵引电机转矩请求";
        attribute englishName : String = "MotorTorqueRequest";
        attribute family : String = "命令/请求";
        attribute domain : String = "牵引";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "N·m";
        attribute semanticDefinition : String = "牵引控制向电机控制通道给出的目标电磁转矩;再生制动时符号表示制动方向。";
        attribute aliases : String = "电机转矩指令;转矩给定";
        attribute priority : String = "核心";
        attribute validityRule : String = "应包含有效位/时效性/范围检查";
        attribute faultStrategy : String = "RejectStale+SafeFallback";
    }
    item def I_ITM_CMD_013 {
        attribute itemCode : String = "ITM-CMD-013";
        attribute chineseName : String = "预充电指令";
        attribute englishName : String = "TractionPrechargeCommand";
        attribute family : String = "命令/请求";
        attribute domain : String = "牵引";
        attribute datatype : String = "Boolean";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "牵引主回路预充电组件的投入/退出控制请求。";
        attribute aliases : String = "预充电命令";
        attribute priority : String = "核心";
        attribute validityRule : String = "应包含有效位/时效性/范围检查";
        attribute faultStrategy : String = "RejectStale+SafeFallback";
    }
    item def I_ITM_CMD_014 {
        attribute itemCode : String = "ITM-CMD-014";
        attribute chineseName : String = "牵引输入接通指令";
        attribute englishName : String = "TractionInputConnectCommand";
        attribute family : String = "命令/请求";
        attribute domain : String = "牵引";
        attribute datatype : String = "Boolean";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "牵引变流器输入主回路接通/断开的控制请求。";
        attribute aliases : String = "输入接触器命令;主回路接通命令";
        attribute priority : String = "核心";
        attribute validityRule : String = "应包含有效位/时效性/范围检查";
        attribute faultStrategy : String = "RejectStale+SafeFallback";
    }
    item def I_ITM_CMD_015 {
        attribute itemCode : String = "ITM-CMD-015";
        attribute chineseName : String = "制动斩波器指令";
        attribute englishName : String = "BrakeChopperCommand";
        attribute family : String = "命令/请求";
        attribute domain : String = "牵引/能量";
        attribute datatype : String = "Real 或 Boolean";
        attribute unitOrMedium : String = "1/无";
        attribute semanticDefinition : String = "根据直流母线电压与剩余再生功率控制制动电阻支路投入的指令。";
        attribute aliases : String = "放电电阻控制;斩波器占空比";
        attribute priority : String = "核心";
        attribute validityRule : String = "应包含有效位/时效性/范围检查";
        attribute faultStrategy : String = "RejectStale+SafeFallback";
    }
    item def I_ITM_CMD_016 {
        attribute itemCode : String = "ITM-CMD-016";
        attribute chineseName : String = "高压断路器指令";
        attribute englishName : String = "HVBreakerCommand";
        attribute family : String = "命令/请求";
        attribute domain : String = "主供电";
        attribute datatype : String = "Enum";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "高压断路器分/合控制请求。";
        attribute aliases : String = "VCB命令;主断命令";
        attribute priority : String = "条件";
        attribute validityRule : String = "应包含有效位/时效性/范围检查";
        attribute faultStrategy : String = "RejectStale+SafeFallback";
    }
    item def I_ITM_CMD_017 {
        attribute itemCode : String = "ITM-CMD-017";
        attribute chineseName : String = "高压隔离开关指令";
        attribute englishName : String = "HVIsolationSwitchCommand";
        attribute family : String = "命令/请求";
        attribute domain : String = "主供电";
        attribute datatype : String = "Enum";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "高压隔离开关分/合控制请求。";
        attribute aliases : String = "隔离开关命令";
        attribute priority : String = "条件";
        attribute validityRule : String = "应包含有效位/时效性/范围检查";
        attribute faultStrategy : String = "RejectStale+SafeFallback";
    }
    item def I_ITM_CMD_018 {
        attribute itemCode : String = "ITM-CMD-018";
        attribute chineseName : String = "受电弓控制指令";
        attribute englishName : String = "PantographCommand";
        attribute family : String = "命令/请求";
        attribute domain : String = "主供电";
        attribute datatype : String = "Enum";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "受电弓升弓/降弓控制请求。";
        attribute aliases : String = "升弓命令;降弓命令";
        attribute priority : String = "条件";
        attribute validityRule : String = "应包含有效位/时效性/范围检查";
        attribute faultStrategy : String = "RejectStale+SafeFallback";
    }
    item def I_ITM_CMD_019 {
        attribute itemCode : String = "ITM-CMD-019";
        attribute chineseName : String = "制动缓解指令";
        attribute englishName : String = "BrakeReleaseCommand";
        attribute family : String = "命令/请求";
        attribute domain : String = "制动";
        attribute datatype : String = "Boolean";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "命令制动执行通道释放已施加制动力。";
        attribute aliases : String = "缓解命令;制动释放";
        attribute priority : String = "核心";
        attribute validityRule : String = "应包含有效位/时效性/范围检查";
        attribute faultStrategy : String = "RejectStale+SafeFallback";
    }
    item def I_ITM_CMD_020 {
        attribute itemCode : String = "ITM-CMD-020";
        attribute chineseName : String = "制动隔离指令";
        attribute englishName : String = "BrakeIsolationCommand";
        attribute family : String = "命令/请求";
        attribute domain : String = "制动";
        attribute datatype : String = "Boolean";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "对指定制动通道执行隔离/恢复的控制请求。";
        attribute aliases : String = "截断命令;制动隔离";
        attribute priority : String = "条件";
        attribute validityRule : String = "应包含有效位/时效性/范围检查";
        attribute faultStrategy : String = "RejectStale+SafeFallback";
    }
    item def I_ITM_CMD_021 {
        attribute itemCode : String = "ITM-CMD-021";
        attribute chineseName : String = "电空转换阀指令";
        attribute englishName : String = "EPValveCommand";
        attribute family : String = "命令/请求";
        attribute domain : String = "制动";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "1 或 Pa";
        attribute semanticDefinition : String = "EBCU向电空转换阀给出的制动压力/开度控制请求。";
        attribute aliases : String = "EP阀命令;制动压力指令";
        attribute priority : String = "核心";
        attribute validityRule : String = "应包含有效位/时效性/范围检查";
        attribute faultStrategy : String = "RejectStale+SafeFallback";
    }
    item def I_ITM_CMD_022 {
        attribute itemCode : String = "ITM-CMD-022";
        attribute chineseName : String = "制动电磁阀指令";
        attribute englishName : String = "BrakeSolenoidValveCommand";
        attribute family : String = "命令/请求";
        attribute domain : String = "制动";
        attribute datatype : String = "Boolean/Enum";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "控制制动电磁阀通断或充排气状态的指令。";
        attribute aliases : String = "电磁阀命令";
        attribute priority : String = "核心";
        attribute validityRule : String = "应包含有效位/时效性/范围检查";
        attribute faultStrategy : String = "RejectStale+SafeFallback";
    }
    item def I_ITM_CMD_023 {
        attribute itemCode : String = "ITM-CMD-023";
        attribute chineseName : String = "防滑干预指令";
        attribute englishName : String = "WSPInterventionCommand";
        attribute family : String = "命令/请求";
        attribute domain : String = "低黏着";
        attribute datatype : String = "Enum";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "防滑控制对制动压力保持、降低或恢复的干预指令。";
        attribute aliases : String = "WSP命令;防滑阀命令";
        attribute priority : String = "核心";
        attribute validityRule : String = "应包含有效位/时效性/范围检查";
        attribute faultStrategy : String = "RejectStale+SafeFallback";
    }
    item def I_ITM_CMD_024 {
        attribute itemCode : String = "ITM-CMD-024";
        attribute chineseName : String = "撒砂请求";
        attribute englishName : String = "SandingRequest";
        attribute family : String = "命令/请求";
        attribute domain : String = "低黏着";
        attribute datatype : String = "Boolean";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "人工或自动发出的撒砂/增粘请求。";
        attribute aliases : String = "撒砂命令;增粘请求";
        attribute priority : String = "条件";
        attribute validityRule : String = "应包含有效位/时效性/范围检查";
        attribute faultStrategy : String = "RejectStale+SafeFallback";
    }
    item def I_ITM_CMD_025 {
        attribute itemCode : String = "ITM-CMD-025";
        attribute chineseName : String = "储能功率请求";
        attribute englishName : String = "ESSPowerRequest";
        attribute family : String = "命令/请求";
        attribute domain : String = "储能";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "W";
        attribute semanticDefinition : String = "上层能量管理向双向DC/DC提出的储能支路功率请求;正负号方向必须项目内固定。";
        attribute aliases : String = "P_ESS_cmd;储能充放电功率指令";
        attribute priority : String = "核心";
        attribute validityRule : String = "应包含有效位/时效性/范围检查";
        attribute faultStrategy : String = "RejectStale+SafeFallback";
    }
    item def I_ITM_CMD_026 {
        attribute itemCode : String = "ITM-CMD-026";
        attribute chineseName : String = "双向DC/DC使能";
        attribute englishName : String = "DCDCEnableCommand";
        attribute family : String = "命令/请求";
        attribute domain : String = "储能";
        attribute datatype : String = "Boolean";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "允许双向DC/DC进入功率调节状态的控制请求。";
        attribute aliases : String = "DC/DC使能";
        attribute priority : String = "核心";
        attribute validityRule : String = "应包含有效位/时效性/范围检查";
        attribute faultStrategy : String = "RejectStale+SafeFallback";
    }
    item def I_ITM_CMD_027 {
        attribute itemCode : String = "ITM-CMD-027";
        attribute chineseName : String = "储能主接触器指令";
        attribute englishName : String = "ESSContactorCommand";
        attribute family : String = "命令/请求";
        attribute domain : String = "储能";
        attribute datatype : String = "Boolean";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "控制储能支路主接触器接通/断开的请求。";
        attribute aliases : String = "储能接触器命令";
        attribute priority : String = "核心";
        attribute validityRule : String = "应包含有效位/时效性/范围检查";
        attribute faultStrategy : String = "RejectStale+SafeFallback";
    }
    item def I_ITM_CMD_028 {
        attribute itemCode : String = "ITM-CMD-028";
        attribute chineseName : String = "储能预充电指令";
        attribute englishName : String = "ESSPrechargeCommand";
        attribute family : String = "命令/请求";
        attribute domain : String = "储能";
        attribute datatype : String = "Boolean";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "控制储能支路预充电过程开始/停止的请求。";
        attribute aliases : String = "ESS预充电命令";
        attribute priority : String = "核心";
        attribute validityRule : String = "应包含有效位/时效性/范围检查";
        attribute faultStrategy : String = "RejectStale+SafeFallback";
    }
    item def I_ITM_CMD_029 {
        attribute itemCode : String = "ITM-CMD-029";
        attribute chineseName : String = "储能故障复位指令";
        attribute englishName : String = "ESSFaultResetCommand";
        attribute family : String = "命令/请求";
        attribute domain : String = "储能";
        attribute datatype : String = "Boolean";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "在满足复位条件后请求清除储能保护锁存状态。";
        attribute aliases : String = "ESS复位;DC/DC复位";
        attribute priority : String = "条件";
        attribute validityRule : String = "应包含有效位/时效性/范围检查";
        attribute faultStrategy : String = "RejectStale+SafeFallback";
    }
    item def I_ITM_CMD_030 {
        attribute itemCode : String = "ITM-CMD-030";
        attribute chineseName : String = "安全停车/制动请求";
        attribute englishName : String = "SafetyBrakeRequest";
        attribute family : String = "命令/请求";
        attribute domain : String = "安全";
        attribute datatype : String = "Enum";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "来自ATP/安全回路等外部安全功能的制动请求,进入EBCU后映射为服务或紧急制动。";
        attribute aliases : String = "ATP制动请求;安全制动命令";
        attribute priority : String = "条件";
        attribute validityRule : String = "应包含有效位/时效性/范围检查";
        attribute faultStrategy : String = "RejectStale+SafeFallback";
    }
    item def I_ITM_CMD_031 {
        attribute itemCode : String = "ITM-CMD-031";
        attribute chineseName : String = "制动控制接触器指令";
        attribute englishName : String = "BrakeControlContactorCommand";
        attribute family : String = "命令/请求";
        attribute domain : String = "制动";
        attribute datatype : String = "Boolean";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "控制制动控制接触器接通/断开的请求。";
        attribute aliases : String = "EBCU接触器命令;制动控制供电接通命令";
        attribute priority : String = "条件";
        attribute validityRule : String = "应包含有效位/时效性检查";
        attribute faultStrategy : String = "RejectStale+SafeFallback";
    }
    item def I_ITM_CMD_032 {
        attribute itemCode : String = "ITM-CMD-032";
        attribute chineseName : String = "撒砂执行指令";
        attribute englishName : String = "SandingActuationCommand";
        attribute family : String = "命令/请求";
        attribute domain : String = "低黏着";
        attribute datatype : String = "Boolean/Enum";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "撒砂控制单元向撒砂阀板/执行机构发出的执行指令。";
        attribute aliases : String = "撒砂阀命令;增粘执行命令";
        attribute priority : String = "条件";
        attribute validityRule : String = "应包含有效位/时效性检查";
        attribute faultStrategy : String = "RejectStale+SafeFallback";
    }
    item def I_ITM_LIM_001 {
        attribute itemCode : String = "ITM-LIM-001";
        attribute chineseName : String = "可用动态制动力";
        attribute englishName : String = "AvailableDynamicBrakeForce";
        attribute family : String = "能力/限制";
        attribute domain : String = "牵引/制动";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "N";
        attribute semanticDefinition : String = "当前速度、电压、黏着、温度和故障条件下动态制动可提供的最大列车等效制动力。";
        attribute aliases : String = "动态制动能力;电制动上限";
        attribute priority : String = "核心";
        attribute validityRule : String = "必须非负且在工程允许范围内;来源失效时能力应保守降级";
        attribute faultStrategy : String = "DegradeAvailability";
    }
    item def I_ITM_LIM_002 {
        attribute itemCode : String = "ITM-LIM-002";
        attribute chineseName : String = "可用摩擦制动力";
        attribute englishName : String = "AvailableFrictionBrakeForce";
        attribute family : String = "能力/限制";
        attribute domain : String = "制动";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "N";
        attribute semanticDefinition : String = "当前压力、隔离和故障条件下摩擦制动可提供的最大制动力。";
        attribute aliases : String = "机械制动能力";
        attribute priority : String = "核心";
        attribute validityRule : String = "必须非负且在工程允许范围内;来源失效时能力应保守降级";
        attribute faultStrategy : String = "DegradeAvailability";
    }
    item def I_ITM_LIM_003 {
        attribute itemCode : String = "ITM-LIM-003";
        attribute chineseName : String = "牵引/再生转矩上限";
        attribute englishName : String = "TractionRegenerationTorqueLimit";
        attribute family : String = "能力/限制";
        attribute domain : String = "牵引";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "N·m";
        attribute semanticDefinition : String = "牵引电机当前允许的牵引或再生转矩上限。";
        attribute aliases : String = "T_reg_max;电机转矩上限";
        attribute priority : String = "核心";
        attribute validityRule : String = "必须非负且在工程允许范围内;来源失效时能力应保守降级";
        attribute faultStrategy : String = "DegradeAvailability";
    }
    item def I_ITM_LIM_004 {
        attribute itemCode : String = "ITM-LIM-004";
        attribute chineseName : String = "再生功率上限";
        attribute englishName : String = "RegenerativePowerLimit";
        attribute family : String = "能力/限制";
        attribute domain : String = "牵引/能量";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "W";
        attribute semanticDefinition : String = "当前牵引电机、变流器、直流母线和能量接收端共同允许的再生功率上限。";
        attribute aliases : String = "P_reg_max;再生功率能力";
        attribute priority : String = "核心";
        attribute validityRule : String = "必须非负且在工程允许范围内;来源失效时能力应保守降级";
        attribute faultStrategy : String = "DegradeAvailability";
    }
    item def I_ITM_LIM_005 {
        attribute itemCode : String = "ITM-LIM-005";
        attribute chineseName : String = "接触网可接收功率";
        attribute englishName : String = "GridAcceptableRegenerativePower";
        attribute family : String = "能力/限制";
        attribute domain : String = "主供电";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "W";
        attribute semanticDefinition : String = "外部供电网络在当前状态下允许车辆回馈的最大再生功率。";
        attribute aliases : String = "P_grid_max;网侧受电能力;网侧回馈容量";
        attribute priority : String = "核心";
        attribute validityRule : String = "必须非负且在工程允许范围内;来源失效时能力应保守降级";
        attribute faultStrategy : String = "DegradeAvailability";
    }
    item def I_ITM_LIM_006 {
        attribute itemCode : String = "ITM-LIM-006";
        attribute chineseName : String = "制动电阻可耗散功率";
        attribute englishName : String = "BrakeResistorAvailablePower";
        attribute family : String = "能力/限制";
        attribute domain : String = "牵引/能量";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "W";
        attribute semanticDefinition : String = "制动电阻支路在当前温度/保护状态下可安全耗散的功率。";
        attribute aliases : String = "电阻耗散能力";
        attribute priority : String = "条件";
        attribute validityRule : String = "必须非负且在工程允许范围内;来源失效时能力应保守降级";
        attribute faultStrategy : String = "DegradeAvailability";
    }
    item def I_ITM_LIM_007 {
        attribute itemCode : String = "ITM-LIM-007";
        attribute chineseName : String = "直流母线电压上限";
        attribute englishName : String = "DCLinkVoltageUpperLimit";
        attribute family : String = "能力/限制";
        attribute domain : String = "牵引/储能";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "V";
        attribute semanticDefinition : String = "控制/保护功能使用的直流母线最高允许电压限制。";
        attribute aliases : String = "Udc_max;母线过压限值";
        attribute priority : String = "核心";
        attribute validityRule : String = "必须非负且在工程允许范围内;来源失效时能力应保守降级";
        attribute faultStrategy : String = "DegradeAvailability";
    }
    item def I_ITM_LIM_008 {
        attribute itemCode : String = "ITM-LIM-008";
        attribute chineseName : String = "可用黏着限制";
        attribute englishName : String = "AvailableAdhesionLimit";
        attribute family : String = "能力/限制";
        attribute domain : String = "低黏着";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "1";
        attribute semanticDefinition : String = "可用于限制轮轨牵引/制动力的黏着边界。";
        attribute aliases : String = "黏着上限;mu_limit";
        attribute priority : String = "条件";
        attribute validityRule : String = "必须非负且在工程允许范围内;来源失效时能力应保守降级";
        attribute faultStrategy : String = "DegradeAvailability";
    }
    item def I_ITM_LIM_009 {
        attribute itemCode : String = "ITM-LIM-009";
        attribute chineseName : String = "储能可用充电功率";
        attribute englishName : String = "ESSAvailableChargePower";
        attribute family : String = "能力/限制";
        attribute domain : String = "储能";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "W";
        attribute semanticDefinition : String = "由超级电容SOC、电压、温度、DC/DC能力和保护状态计算的最大允许吸收功率。";
        attribute aliases : String = "ESS充电功率上限;P_charge_avail";
        attribute priority : String = "核心";
        attribute validityRule : String = "必须非负且在工程允许范围内;来源失效时能力应保守降级";
        attribute faultStrategy : String = "DegradeAvailability";
    }
    item def I_ITM_LIM_010 {
        attribute itemCode : String = "ITM-LIM-010";
        attribute chineseName : String = "储能可用放电功率";
        attribute englishName : String = "ESSAvailableDischargePower";
        attribute family : String = "能力/限制";
        attribute domain : String = "储能";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "W";
        attribute semanticDefinition : String = "储能支路当前最大允许释放功率。";
        attribute aliases : String = "ESS放电功率上限;P_discharge_avail";
        attribute priority : String = "条件";
        attribute validityRule : String = "必须非负且在工程允许范围内;来源失效时能力应保守降级";
        attribute faultStrategy : String = "DegradeAvailability";
    }
    item def I_ITM_LIM_011 {
        attribute itemCode : String = "ITM-LIM-011";
        attribute chineseName : String = "超级电容充电允许状态";
        attribute englishName : String = "SuperCapChargeAllowed";
        attribute family : String = "能力/限制";
        attribute domain : String = "储能";
        attribute datatype : String = "Boolean";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "SOC、电压、温度和故障条件综合判定后的充电许可。";
        attribute aliases : String = "SC charge enable";
        attribute priority : String = "核心";
        attribute validityRule : String = "必须非负且在工程允许范围内;来源失效时能力应保守降级";
        attribute faultStrategy : String = "DegradeAvailability";
    }
    item def I_ITM_LIM_012 {
        attribute itemCode : String = "ITM-LIM-012";
        attribute chineseName : String = "超级电容放电允许状态";
        attribute englishName : String = "SuperCapDischargeAllowed";
        attribute family : String = "能力/限制";
        attribute domain : String = "储能";
        attribute datatype : String = "Boolean";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "储能状态和故障条件综合判定后的放电许可。";
        attribute aliases : String = "SC discharge enable";
        attribute priority : String = "条件";
        attribute validityRule : String = "必须非负且在工程允许范围内;来源失效时能力应保守降级";
        attribute faultStrategy : String = "DegradeAvailability";
    }
    item def I_ITM_LIM_013 {
        attribute itemCode : String = "ITM-LIM-013";
        attribute chineseName : String = "最大允许制动力";
        attribute englishName : String = "MaximumAllowedBrakeForce";
        attribute family : String = "能力/限制";
        attribute domain : String = "制动";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "N";
        attribute semanticDefinition : String = "由车辆、轨道、舒适性和设备能力共同限定的总制动力上限。";
        attribute aliases : String = "最大制动力";
        attribute priority : String = "条件";
        attribute validityRule : String = "必须非负且在工程允许范围内;来源失效时能力应保守降级";
        attribute faultStrategy : String = "DegradeAvailability";
    }
    item def I_ITM_LIM_014 {
        attribute itemCode : String = "ITM-LIM-014";
        attribute chineseName : String = "最大允许减速度";
        attribute englishName : String = "MaximumAllowedDeceleration";
        attribute family : String = "能力/限制";
        attribute domain : String = "制动";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "m/s2";
        attribute semanticDefinition : String = "当前运行条件下允许的列车减速度上限。";
        attribute aliases : String = "最大减速度";
        attribute priority : String = "条件";
        attribute validityRule : String = "必须非负且在工程允许范围内;来源失效时能力应保守降级";
        attribute faultStrategy : String = "DegradeAvailability";
    }
    item def I_ITM_MEA_001 {
        attribute itemCode : String = "ITM-MEA-001";
        attribute chineseName : String = "列车速度";
        attribute englishName : String = "TrainSpeed";
        attribute family : String = "测量/反馈";
        attribute domain : String = "车辆运动";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "m/s";
        attribute semanticDefinition : String = "用于制动力计算、混合控制、低速衰减和安全监控的列车纵向速度。";
        attribute aliases : String = "车速;运行速度";
        attribute priority : String = "核心";
        attribute validityRule : String = "范围+质量位+时间戳检查;单位必须固定";
        attribute faultStrategy : String = "RejectStale+QualityFlag";
    }
    item def I_ITM_MEA_002 {
        attribute itemCode : String = "ITM-MEA-002";
        attribute chineseName : String = "轴端角速度";
        attribute englishName : String = "AxleAngularSpeed";
        attribute family : String = "测量/反馈";
        attribute domain : String = "机械传动";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "rad/s";
        attribute semanticDefinition : String = "轴端速度传感器测得的车轴角速度。";
        attribute aliases : String = "轮轴转速;轴速";
        attribute priority : String = "核心";
        attribute validityRule : String = "范围+质量位+时间戳检查;单位必须固定";
        attribute faultStrategy : String = "RejectStale+QualityFlag";
    }
    item def I_ITM_MEA_003 {
        attribute itemCode : String = "ITM-MEA-003";
        attribute chineseName : String = "齿轮箱转速";
        attribute englishName : String = "GearboxSpeed";
        attribute family : String = "测量/反馈";
        attribute domain : String = "机械传动";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "rad/s";
        attribute semanticDefinition : String = "齿轮箱速度传感器测得的转速。";
        attribute aliases : String = "齿轮箱速度";
        attribute priority : String = "条件";
        attribute validityRule : String = "范围+质量位+时间戳检查;单位必须固定";
        attribute faultStrategy : String = "RejectStale+QualityFlag";
    }
    item def I_ITM_MEA_004 {
        attribute itemCode : String = "ITM-MEA-004";
        attribute chineseName : String = "牵引电机转速";
        attribute englishName : String = "MotorSpeed";
        attribute family : String = "测量/反馈";
        attribute domain : String = "牵引";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "rad/s";
        attribute semanticDefinition : String = "牵引电机速度传感器或电机控制估算的电机机械角速度。";
        attribute aliases : String = "电机速度;omega_motor";
        attribute priority : String = "核心";
        attribute validityRule : String = "范围+质量位+时间戳检查;单位必须固定";
        attribute faultStrategy : String = "RejectStale+QualityFlag";
    }
    item def I_ITM_MEA_005 {
        attribute itemCode : String = "ITM-MEA-005";
        attribute chineseName : String = "高压线路电压";
        attribute englishName : String = "LineVoltage";
        attribute family : String = "测量/反馈";
        attribute domain : String = "主供电";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "V";
        attribute semanticDefinition : String = "受流/高压测量通道得到的线路电压。";
        attribute aliases : String = "网压;接触网电压;线电压";
        attribute priority : String = "核心";
        attribute validityRule : String = "范围+质量位+时间戳检查;单位必须固定";
        attribute faultStrategy : String = "RejectStale+QualityFlag";
    }
    item def I_ITM_MEA_006 {
        attribute itemCode : String = "ITM-MEA-006";
        attribute chineseName : String = "高压线路电流";
        attribute englishName : String = "LineCurrent";
        attribute family : String = "测量/反馈";
        attribute domain : String = "主供电";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "A";
        attribute semanticDefinition : String = "受流/高压测量通道得到的线路电流;符号用于区分取能与回馈。";
        attribute aliases : String = "网流;接触网电流";
        attribute priority : String = "核心";
        attribute validityRule : String = "范围+质量位+时间戳检查;单位必须固定";
        attribute faultStrategy : String = "RejectStale+QualityFlag";
    }
    item def I_ITM_MEA_007 {
        attribute itemCode : String = "ITM-MEA-007";
        attribute chineseName : String = "线路频率";
        attribute englishName : String = "LineFrequency";
        attribute family : String = "测量/反馈";
        attribute domain : String = "主供电";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "Hz";
        attribute semanticDefinition : String = "交流供电方案的线路频率。";
        attribute aliases : String = "网频";
        attribute priority : String = "条件";
        attribute validityRule : String = "范围+质量位+时间戳检查;单位必须固定";
        attribute faultStrategy : String = "RejectStale+QualityFlag";
    }
    item def I_ITM_MEA_008 {
        attribute itemCode : String = "ITM-MEA-008";
        attribute chineseName : String = "中间直流母线电压";
        attribute englishName : String = "DCLinkVoltage";
        attribute family : String = "测量/反馈";
        attribute domain : String = "牵引/储能";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "V";
        attribute semanticDefinition : String = "牵引变流器中间直流环节的电压。";
        attribute aliases : String = "Udc;DC-link voltage;母线电压";
        attribute priority : String = "核心";
        attribute validityRule : String = "范围+质量位+时间戳检查;单位必须固定";
        attribute faultStrategy : String = "RejectStale+QualityFlag";
    }
    item def I_ITM_MEA_009 {
        attribute itemCode : String = "ITM-MEA-009";
        attribute chineseName : String = "中间直流母线电流";
        attribute englishName : String = "DCLinkCurrent";
        attribute family : String = "测量/反馈";
        attribute domain : String = "牵引/储能";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "A";
        attribute semanticDefinition : String = "中间直流环节电流或等效净电流。";
        attribute aliases : String = "Idc;母线电流";
        attribute priority : String = "核心";
        attribute validityRule : String = "范围+质量位+时间戳检查;单位必须固定";
        attribute faultStrategy : String = "RejectStale+QualityFlag";
    }
    item def I_ITM_MEA_010 {
        attribute itemCode : String = "ITM-MEA-010";
        attribute chineseName : String = "电机侧相电流";
        attribute englishName : String = "MotorPhaseCurrent";
        attribute family : String = "测量/反馈";
        attribute domain : String = "牵引";
        attribute datatype : String = "Real/Vector";
        attribute unitOrMedium : String = "A";
        attribute semanticDefinition : String = "电机侧变流器/牵引电机的三相电流测量。";
        attribute aliases : String = "Iabc;电机电流";
        attribute priority : String = "核心";
        attribute validityRule : String = "范围+质量位+时间戳检查;单位必须固定";
        attribute faultStrategy : String = "RejectStale+QualityFlag";
    }
    item def I_ITM_MEA_011 {
        attribute itemCode : String = "ITM-MEA-011";
        attribute chineseName : String = "电机侧相电压";
        attribute englishName : String = "MotorPhaseVoltage";
        attribute family : String = "测量/反馈";
        attribute domain : String = "牵引";
        attribute datatype : String = "Real/Vector";
        attribute unitOrMedium : String = "V";
        attribute semanticDefinition : String = "电机侧变流器/牵引电机的三相电压测量。";
        attribute aliases : String = "Vabc;电机电压";
        attribute priority : String = "条件";
        attribute validityRule : String = "范围+质量位+时间戳检查;单位必须固定";
        attribute faultStrategy : String = "RejectStale+QualityFlag";
    }
    item def I_ITM_MEA_012 {
        attribute itemCode : String = "ITM-MEA-012";
        attribute chineseName : String = "牵引电机实际转矩";
        attribute englishName : String = "MotorTorqueActual";
        attribute family : String = "测量/反馈";
        attribute domain : String = "牵引";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "N·m";
        attribute semanticDefinition : String = "电机控制估算或测量的实际电磁转矩。";
        attribute aliases : String = "Te;实际电机转矩";
        attribute priority : String = "核心";
        attribute validityRule : String = "范围+质量位+时间戳检查;单位必须固定";
        attribute faultStrategy : String = "RejectStale+QualityFlag";
    }
    item def I_ITM_MEA_013 {
        attribute itemCode : String = "ITM-MEA-013";
        attribute chineseName : String = "实际动态制动力";
        attribute englishName : String = "AchievedDynamicBrakeForce";
        attribute family : String = "测量/反馈";
        attribute domain : String = "牵引/制动";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "N";
        attribute semanticDefinition : String = "牵引电制动通道实际实现的列车等效动态制动力。";
        attribute aliases : String = "实际电制动力;动态制动力反馈";
        attribute priority : String = "核心";
        attribute validityRule : String = "范围+质量位+时间戳检查;单位必须固定";
        attribute faultStrategy : String = "RejectStale+QualityFlag";
    }
    item def I_ITM_MEA_014 {
        attribute itemCode : String = "ITM-MEA-014";
        attribute chineseName : String = "总风管压力";
        attribute englishName : String = "MainReservoirPressure";
        attribute family : String = "测量/反馈";
        attribute domain : String = "气动制动";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "Pa";
        attribute semanticDefinition : String = "总风管压力传感器输出。";
        attribute aliases : String = "总风压力;MR pressure";
        attribute priority : String = "核心";
        attribute validityRule : String = "范围+质量位+时间戳检查;单位必须固定";
        attribute faultStrategy : String = "RejectStale+QualityFlag";
    }
    item def I_ITM_MEA_015 {
        attribute itemCode : String = "ITM-MEA-015";
        attribute chineseName : String = "制动风缸压力";
        attribute englishName : String = "BrakeReservoirPressure";
        attribute family : String = "测量/反馈";
        attribute domain : String = "气动制动";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "Pa";
        attribute semanticDefinition : String = "制动风缸或局部储风容器压力。";
        attribute aliases : String = "储风缸压力;制动储气压力";
        attribute priority : String = "条件";
        attribute validityRule : String = "范围+质量位+时间戳检查;单位必须固定";
        attribute faultStrategy : String = "RejectStale+QualityFlag";
    }
    item def I_ITM_MEA_016 {
        attribute itemCode : String = "ITM-MEA-016";
        attribute chineseName : String = "制动缸压力";
        attribute englishName : String = "BrakeCylinderPressure";
        attribute family : String = "测量/反馈";
        attribute domain : String = "气动制动";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "Pa";
        attribute semanticDefinition : String = "摩擦制动执行通道的制动缸/夹钳驱动压力。";
        attribute aliases : String = "BC pressure;制动压力";
        attribute priority : String = "核心";
        attribute validityRule : String = "范围+质量位+时间戳检查;单位必须固定";
        attribute faultStrategy : String = "RejectStale+QualityFlag";
    }
    item def I_ITM_MEA_017 {
        attribute itemCode : String = "ITM-MEA-017";
        attribute chineseName : String = "实际摩擦制动力";
        attribute englishName : String = "FrictionBrakeForceActual";
        attribute family : String = "测量/反馈";
        attribute domain : String = "制动";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "N";
        attribute semanticDefinition : String = "由制动缸压力、执行机构特性或估算得到的实际摩擦制动力。";
        attribute aliases : String = "机械制动力反馈;空气制动力";
        attribute priority : String = "核心";
        attribute validityRule : String = "范围+质量位+时间戳检查;单位必须固定";
        attribute faultStrategy : String = "RejectStale+QualityFlag";
    }
    item def I_ITM_MEA_018 {
        attribute itemCode : String = "ITM-MEA-018";
        attribute chineseName : String = "列车质量";
        attribute englishName : String = "TrainMass";
        attribute family : String = "测量/反馈";
        attribute domain : String = "车辆状态";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "kg";
        attribute semanticDefinition : String = "制动力计算使用的列车质量/等效质量信息。";
        attribute aliases : String = "列车载荷;质量";
        attribute priority : String = "条件";
        attribute validityRule : String = "范围+质量位+时间戳检查;单位必须固定";
        attribute faultStrategy : String = "RejectStale+QualityFlag";
    }
    item def I_ITM_MEA_019 {
        attribute itemCode : String = "ITM-MEA-019";
        attribute chineseName : String = "车辆载荷系数";
        attribute englishName : String = "VehicleLoadFactor";
        attribute family : String = "测量/反馈";
        attribute domain : String = "制动";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "1";
        attribute semanticDefinition : String = "空重车调整或上层控制使用的车辆载荷归一化信息。";
        attribute aliases : String = "空重车系数;载荷率";
        attribute priority : String = "条件";
        attribute validityRule : String = "范围+质量位+时间戳检查;单位必须固定";
        attribute faultStrategy : String = "RejectStale+QualityFlag";
    }
    item def I_ITM_MEA_020 {
        attribute itemCode : String = "ITM-MEA-020";
        attribute chineseName : String = "轮轨滑移率";
        attribute englishName : String = "WheelSlipRatio";
        attribute family : String = "测量/反馈";
        attribute domain : String = "低黏着";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "1";
        attribute semanticDefinition : String = "由轮速/车速估算的轮轨纵向滑移率。";
        attribute aliases : String = "滑行率;滑移率";
        attribute priority : String = "核心";
        attribute validityRule : String = "范围+质量位+时间戳检查;单位必须固定";
        attribute faultStrategy : String = "RejectStale+QualityFlag";
    }
    item def I_ITM_MEA_021 {
        attribute itemCode : String = "ITM-MEA-021";
        attribute chineseName : String = "可用黏着系数估计";
        attribute englishName : String = "AvailableAdhesionEstimate";
        attribute family : String = "测量/反馈";
        attribute domain : String = "低黏着";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "1";
        attribute semanticDefinition : String = "控制器用于限制轮轨可传递纵向力的黏着能力估计。";
        attribute aliases : String = "mu;黏着系数";
        attribute priority : String = "条件";
        attribute validityRule : String = "范围+质量位+时间戳检查;单位必须固定";
        attribute faultStrategy : String = "RejectStale+QualityFlag";
    }
    item def I_ITM_MEA_022 {
        attribute itemCode : String = "ITM-MEA-022";
        attribute chineseName : String = "主变压器温度";
        attribute englishName : String = "MainTransformerTemperature";
        attribute family : String = "测量/反馈";
        attribute domain : String = "主供电";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "°C";
        attribute semanticDefinition : String = "主变压器检测保护通道输出的代表性温度。";
        attribute aliases : String = "变压器温度";
        attribute priority : String = "条件";
        attribute validityRule : String = "范围+质量位+时间戳检查;单位必须固定";
        attribute faultStrategy : String = "RejectStale+QualityFlag";
    }
    item def I_ITM_MEA_023 {
        attribute itemCode : String = "ITM-MEA-023";
        attribute chineseName : String = "牵引变流器温度";
        attribute englishName : String = "TractionConverterTemperature";
        attribute family : String = "测量/反馈";
        attribute domain : String = "牵引";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "°C";
        attribute semanticDefinition : String = "牵引变流器检测保护组件提供的代表性温度/热状态测量。";
        attribute aliases : String = "变流器温度;功率模块温度";
        attribute priority : String = "条件";
        attribute validityRule : String = "范围+质量位+时间戳检查;单位必须固定";
        attribute faultStrategy : String = "RejectStale+QualityFlag";
    }
    item def I_ITM_MEA_024 {
        attribute itemCode : String = "ITM-MEA-024";
        attribute chineseName : String = "制动电阻温度";
        attribute englishName : String = "BrakeResistorTemperature";
        attribute family : String = "测量/反馈";
        attribute domain : String = "牵引/能量";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "°C";
        attribute semanticDefinition : String = "制动电阻/斩波耗散支路的代表性温度。";
        attribute aliases : String = "电阻温度;斩波电阻温度";
        attribute priority : String = "条件";
        attribute validityRule : String = "范围+质量位+时间戳检查;单位必须固定";
        attribute faultStrategy : String = "RejectStale+QualityFlag";
    }
    item def I_ITM_MEA_025 {
        attribute itemCode : String = "ITM-MEA-025";
        attribute chineseName : String = "超级电容电压";
        attribute englishName : String = "SuperCapVoltage";
        attribute family : String = "测量/反馈";
        attribute domain : String = "储能";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "V";
        attribute semanticDefinition : String = "超级电容模块端电压。";
        attribute aliases : String = "Usc;SC voltage";
        attribute priority : String = "核心";
        attribute validityRule : String = "范围+质量位+时间戳检查;单位必须固定";
        attribute faultStrategy : String = "RejectStale+QualityFlag";
    }
    item def I_ITM_MEA_026 {
        attribute itemCode : String = "ITM-MEA-026";
        attribute chineseName : String = "超级电容电流";
        attribute englishName : String = "SuperCapCurrent";
        attribute family : String = "测量/反馈";
        attribute domain : String = "储能";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "A";
        attribute semanticDefinition : String = "超级电容支路电流;正负号方向必须项目内固定。";
        attribute aliases : String = "Isc;SC current";
        attribute priority : String = "核心";
        attribute validityRule : String = "范围+质量位+时间戳检查;单位必须固定";
        attribute faultStrategy : String = "RejectStale+QualityFlag";
    }
    item def I_ITM_MEA_027 {
        attribute itemCode : String = "ITM-MEA-027";
        attribute chineseName : String = "超级电容温度";
        attribute englishName : String = "SuperCapTemperature";
        attribute family : String = "测量/反馈";
        attribute domain : String = "储能";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "°C";
        attribute semanticDefinition : String = "超级电容模块代表性温度。";
        attribute aliases : String = "Tsc;SC temperature";
        attribute priority : String = "核心";
        attribute validityRule : String = "范围+质量位+时间戳检查;单位必须固定";
        attribute faultStrategy : String = "RejectStale+QualityFlag";
    }
    item def I_ITM_MEA_028 {
        attribute itemCode : String = "ITM-MEA-028";
        attribute chineseName : String = "超级电容SOC";
        attribute englishName : String = "SuperCapSOC";
        attribute family : String = "测量/反馈";
        attribute domain : String = "储能";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "1";
        attribute semanticDefinition : String = "由超级电容电压/能量模型估算的归一化储能状态。";
        attribute aliases : String = "SOC;SC SOC";
        attribute priority : String = "核心";
        attribute validityRule : String = "范围+质量位+时间戳检查;单位必须固定";
        attribute faultStrategy : String = "RejectStale+QualityFlag";
    }
    item def I_ITM_MEA_029 {
        attribute itemCode : String = "ITM-MEA-029";
        attribute chineseName : String = "双向DC/DC实际功率";
        attribute englishName : String = "DCDCActualPower";
        attribute family : String = "测量/反馈";
        attribute domain : String = "储能";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "W";
        attribute semanticDefinition : String = "双向DC/DC实际向储能侧或母线侧传递的功率。";
        attribute aliases : String = "P_ESS_actual;DC/DC功率";
        attribute priority : String = "核心";
        attribute validityRule : String = "范围+质量位+时间戳检查;单位必须固定";
        attribute faultStrategy : String = "RejectStale+QualityFlag";
    }
    item def I_ITM_MEA_030 {
        attribute itemCode : String = "ITM-MEA-030";
        attribute chineseName : String = "双向DC/DC电流";
        attribute englishName : String = "DCDCCurrent";
        attribute family : String = "测量/反馈";
        attribute domain : String = "储能";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "A";
        attribute semanticDefinition : String = "双向DC/DC关键支路电流测量。";
        attribute aliases : String = "DC/DC电流";
        attribute priority : String = "条件";
        attribute validityRule : String = "范围+质量位+时间戳检查;单位必须固定";
        attribute faultStrategy : String = "RejectStale+QualityFlag";
    }
    item def I_ITM_MEA_031 {
        attribute itemCode : String = "ITM-MEA-031";
        attribute chineseName : String = "列车加速度/减速度";
        attribute englishName : String = "TrainAcceleration";
        attribute family : String = "测量/反馈";
        attribute domain : String = "车辆运动";
        attribute datatype : String = "Real";
        attribute unitOrMedium : String = "m/s2";
        attribute semanticDefinition : String = "用于性能验证和制动闭环监测的纵向加速度,制动时通常为负或按项目约定采用正减速度。";
        attribute aliases : String = "列车减速度;纵向加速度";
        attribute priority : String = "条件";
        attribute validityRule : String = "范围+质量位+时间戳检查;单位必须固定";
        attribute faultStrategy : String = "RejectStale+QualityFlag";
    }
    item def I_ITM_PHY_001 {
        attribute itemCode : String = "ITM-PHY-001";
        attribute chineseName : String = "高压交流电能";
        attribute englishName : String = "HighVoltageACElectricalEnergy";
        attribute family : String = "物理交换";
        attribute domain : String = "主供电";
        attribute datatype : String = "PhysicalConnector";
        attribute unitOrMedium : String = "高压交流电气";
        attribute semanticDefinition : String = "受电弓/高压回路/主变压器/网侧变流器之间传递的高压交流电能;电压、电流、频率为该物理域的伴随变量。";
        attribute aliases : String = "接触网电能;25kV交流电能;网侧交流电能";
        attribute priority : String = "条件";
        attribute validityRule : String = "物理网络守恒;供电制式必须一致";
        attribute faultStrategy : String = "PhysicalConservation";
    }
    item def I_ITM_PHY_002 {
        attribute itemCode : String = "ITM-PHY-002";
        attribute chineseName : String = "直流牵引供电电能";
        attribute englishName : String = "TractionDCElectricalEnergy";
        attribute family : String = "物理交换";
        attribute domain : String = "主供电";
        attribute datatype : String = "PhysicalConnector";
        attribute unitOrMedium : String = "直流电气";
        attribute semanticDefinition : String = "直流受流方案中受流器与牵引主回路之间传递的直流电能。";
        attribute aliases : String = "接触轨电能;直流网电能;1500V直流电能";
        attribute priority : String = "条件";
        attribute validityRule : String = "物理网络守恒;极性/电压等级一致";
        attribute faultStrategy : String = "PhysicalConservation";
    }
    item def I_ITM_PHY_003 {
        attribute itemCode : String = "ITM-PHY-003";
        attribute chineseName : String = "中间直流电能";
        attribute englishName : String = "DCLinkElectricalEnergy";
        attribute family : String = "物理交换";
        attribute domain : String = "牵引/储能";
        attribute datatype : String = "PhysicalConnector";
        attribute unitOrMedium : String = "直流电气";
        attribute semanticDefinition : String = "牵引变流器中间直流环节、制动电阻支路和储能支路之间传递的直流电能。";
        attribute aliases : String = "DC-link电能;直流母线电能;中间电路电能";
        attribute priority : String = "核心";
        attribute validityRule : String = "物理网络守恒;电压等级兼容";
        attribute faultStrategy : String = "PhysicalConservation";
    }
    item def I_ITM_PHY_004 {
        attribute itemCode : String = "ITM-PHY-004";
        attribute chineseName : String = "三相交流电能";
        attribute englishName : String = "ThreePhaseACElectricalEnergy";
        attribute family : String = "物理交换";
        attribute domain : String = "牵引";
        attribute datatype : String = "PhysicalConnector";
        attribute unitOrMedium : String = "三相交流电气";
        attribute semanticDefinition : String = "电机侧变流模块与牵引电机之间双向传递的三相交流电能。";
        attribute aliases : String = "电机三相电能;逆变器输出电能";
        attribute priority : String = "核心";
        attribute validityRule : String = "物理网络守恒;相制/频率/电压兼容";
        attribute faultStrategy : String = "PhysicalConservation";
    }
    item def I_ITM_PHY_005 {
        attribute itemCode : String = "ITM-PHY-005";
        attribute chineseName : String = "旋转机械能";
        attribute englishName : String = "RotationalMechanicalEnergy";
        attribute family : String = "物理交换";
        attribute domain : String = "机械传动";
        attribute datatype : String = "PhysicalConnector";
        attribute unitOrMedium : String = "旋转机械";
        attribute semanticDefinition : String = "牵引电机、联轴节、万向轴、齿轮箱、车轴和车轮之间双向传递的旋转机械能;伴随变量为转矩与角速度。";
        attribute aliases : String = "轴系机械能;旋转功率;机械轴功率";
        attribute priority : String = "核心";
        attribute validityRule : String = "机械网络守恒;轴系方向/转速基准一致";
        attribute faultStrategy : String = "PhysicalConservation";
    }
    item def I_ITM_PHY_006 {
        attribute itemCode : String = "ITM-PHY-006";
        attribute chineseName : String = "轮轨纵向机械作用";
        attribute englishName : String = "WheelRailLongitudinalInteraction";
        attribute family : String = "物理交换";
        attribute domain : String = "轮轨";
        attribute datatype : String = "PhysicalConnector";
        attribute unitOrMedium : String = "纵向机械";
        attribute semanticDefinition : String = "车轮与轨道之间的纵向牵引/制动力机械作用,用于把轮轴转矩映射为车辆纵向力。";
        attribute aliases : String = "轮轨牵引力;轮轨制动力;黏着力";
        attribute priority : String = "核心";
        attribute validityRule : String = "力方向与车辆坐标系一致";
        attribute faultStrategy : String = "PhysicalConservation";
    }
    item def I_ITM_PHY_007 {
        attribute itemCode : String = "ITM-PHY-007";
        attribute chineseName : String = "摩擦制动机械作用";
        attribute englishName : String = "FrictionBrakeMechanicalInteraction";
        attribute family : String = "物理交换";
        attribute domain : String = "摩擦制动";
        attribute datatype : String = "PhysicalConnector";
        attribute unitOrMedium : String = "摩擦机械";
        attribute semanticDefinition : String = "制动夹钳、闸片和制动盘之间的机械夹紧与摩擦作用,形成制动力矩并耗散机械能。";
        attribute aliases : String = "夹紧力;摩擦力;制动力矩作用";
        attribute priority : String = "核心";
        attribute validityRule : String = "机械作用方向一致;仅在接触有效时成立";
        attribute faultStrategy : String = "PhysicalConservation";
    }
    item def I_ITM_PHY_008 {
        attribute itemCode : String = "ITM-PHY-008";
        attribute chineseName : String = "主风压缩空气";
        attribute englishName : String = "MainReservoirCompressedAir";
        attribute family : String = "物理交换";
        attribute domain : String = "气动制动";
        attribute datatype : String = "PhysicalConnector";
        attribute unitOrMedium : String = "压缩空气";
        attribute semanticDefinition : String = "总风管/风缸向制动气路提供的压缩空气介质。";
        attribute aliases : String = "总风;主风;供风";
        attribute priority : String = "核心";
        attribute validityRule : String = "压力/流量方向符合气动网络";
        attribute faultStrategy : String = "PhysicalConservation";
    }
    item def I_ITM_PHY_009 {
        attribute itemCode : String = "ITM-PHY-009";
        attribute chineseName : String = "制动控制压缩空气";
        attribute englishName : String = "BrakeControlCompressedAir";
        attribute family : String = "物理交换";
        attribute domain : String = "气动制动";
        attribute datatype : String = "PhysicalConnector";
        attribute unitOrMedium : String = "压缩空气";
        attribute semanticDefinition : String = "电空转换阀、调压阀、中继阀、防滑阀等制动控制元件之间传递的受控压缩空气。";
        attribute aliases : String = "先导气;控制风;制动控制气路";
        attribute priority : String = "核心";
        attribute validityRule : String = "压力范围有效;气路连通";
        attribute faultStrategy : String = "PhysicalConservation";
    }
    item def I_ITM_PHY_010 {
        attribute itemCode : String = "ITM-PHY-010";
        attribute chineseName : String = "制动缸压缩空气";
        attribute englishName : String = "BrakeCylinderCompressedAir";
        attribute family : String = "物理交换";
        attribute domain : String = "气动制动";
        attribute datatype : String = "PhysicalConnector";
        attribute unitOrMedium : String = "压缩空气";
        attribute semanticDefinition : String = "中继阀/增压缸/制动夹钳执行机构之间用于产生摩擦制动力的压缩空气。";
        attribute aliases : String = "制动缸空气;制动缸气路";
        attribute priority : String = "核心";
        attribute validityRule : String = "压力范围有效;泄漏/隔离状态可判定";
        attribute faultStrategy : String = "PhysicalConservation";
    }
    item def I_ITM_PHY_011 {
        attribute itemCode : String = "ITM-PHY-011";
        attribute chineseName : String = "主回路回流电流";
        attribute englishName : String = "TractionReturnCurrent";
        attribute family : String = "物理交换";
        attribute domain : String = "主供电";
        attribute datatype : String = "PhysicalConnector";
        attribute unitOrMedium : String = "电气回流";
        attribute semanticDefinition : String = "牵引/再生主回路经车体接地、回流碳刷等返回供电系统的电流路径。";
        attribute aliases : String = "回流电流;牵引回流;接地回流";
        attribute priority : String = "核心";
        attribute validityRule : String = "回流路径连续;绝缘/接地边界一致";
        attribute faultStrategy : String = "PhysicalConservation";
    }
    item def I_ITM_PHY_012 {
        attribute itemCode : String = "ITM-PHY-012";
        attribute chineseName : String = "砂流";
        attribute englishName : String = "SandFlow";
        attribute family : String = "物理交换";
        attribute domain : String = "低黏着管理";
        attribute datatype : String = "PhysicalConnector";
        attribute unitOrMedium : String = "散粒介质";
        attribute semanticDefinition : String = "撒砂阀板至撒砂喷嘴并最终作用于轮轨界面的砂粒介质流。";
        attribute aliases : String = "撒砂介质;砂粒流";
        attribute priority : String = "条件";
        attribute validityRule : String = "仅在撒砂命令有效且设备可用时传递";
        attribute faultStrategy : String = "PhysicalConservation";
    }
    item def I_ITM_PHY_013 {
        attribute itemCode : String = "ITM-PHY-013";
        attribute chineseName : String = "热能/热流";
        attribute englishName : String = "ThermalEnergyFlow";
        attribute family : String = "物理交换";
        attribute domain : String = "热耗散";
        attribute datatype : String = "PhysicalConnector";
        attribute unitOrMedium : String = "热";
        attribute semanticDefinition : String = "制动电阻、摩擦制动和储能组件向环境或热管理系统释放的热能。";
        attribute aliases : String = "热流;耗散热能";
        attribute priority : String = "条件";
        attribute validityRule : String = "热功率非负;热边界定义一致";
        attribute faultStrategy : String = "PhysicalConservation";
    }
    item def I_ITM_PHY_014 {
        attribute itemCode : String = "ITM-PHY-014";
        attribute chineseName : String = "牵引变压器次级交流电能";
        attribute englishName : String = "TractionTransformerSecondaryACEnergy";
        attribute family : String = "物理交换";
        attribute domain : String = "主供电/牵引";
        attribute datatype : String = "PhysicalConnector";
        attribute unitOrMedium : String = "交流电气";
        attribute semanticDefinition : String = "主变压器次级绕组、电抗器、输入单元与网侧变流模块之间传递的牵引交流电能。";
        attribute aliases : String = "变压器次级电能;牵引次级交流;网侧变流器输入交流";
        attribute priority : String = "条件";
        attribute validityRule : String = "物理网络守恒;绕组/电压等级兼容";
        attribute faultStrategy : String = "PhysicalConservation";
    }
    item def I_ITM_PHY_015 {
        attribute itemCode : String = "ITM-PHY-015";
        attribute chineseName : String = "低压控制电能";
        attribute englishName : String = "LowVoltageControlPower";
        attribute family : String = "物理交换";
        attribute domain : String = "控制供电";
        attribute datatype : String = "PhysicalConnector";
        attribute unitOrMedium : String = "低压直流电气";
        attribute semanticDefinition : String = "EBCU、VCU、控制单元、I/O、安全回路、接触器线圈及保护电子设备使用的低压控制电源。";
        attribute aliases : String = "控制电源;110VDC;24VDC;低压直流电源";
        attribute priority : String = "条件";
        attribute validityRule : String = "电压等级/极性兼容;供电可用性可监测";
        attribute faultStrategy : String = "PhysicalConservation";
    }
    item def I_ITM_PHY_016 {
        attribute itemCode : String = "ITM-PHY-016";
        attribute chineseName : String = "储能侧直流电能";
        attribute englishName : String = "ESSSideDCElectricalEnergy";
        attribute family : String = "物理交换";
        attribute domain : String = "储能";
        attribute datatype : String = "PhysicalConnector";
        attribute unitOrMedium : String = "直流电气";
        attribute semanticDefinition : String = "双向DC/DC储能侧与超级电容模块之间传递的直流电能。";
        attribute aliases : String = "超级电容侧直流电能;SC侧电能;低压储能直流";
        attribute priority : String = "核心";
        attribute validityRule : String = "物理网络守恒;电压等级兼容";
        attribute faultStrategy : String = "PhysicalConservation";
    }
    item def I_ITM_STA_001 {
        attribute itemCode : String = "ITM-STA-001";
        attribute chineseName : String = "牵引可用状态";
        attribute englishName : String = "TractionAvailability";
        attribute family : String = "状态/故障";
        attribute domain : String = "牵引";
        attribute datatype : String = "Boolean";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "牵引系统是否具备正常输出牵引/动态制动能力。";
        attribute aliases : String = "牵引可用;traction available";
        attribute priority : String = "核心";
        attribute validityRule : String = "枚举/位集值域固定;需有效位和时间戳";
        attribute faultStrategy : String = "DegradeAvailability";
    }
    item def I_ITM_STA_002 {
        attribute itemCode : String = "ITM-STA-002";
        attribute chineseName : String = "动态制动可用状态";
        attribute englishName : String = "DynamicBrakeAvailability";
        attribute family : String = "状态/故障";
        attribute domain : String = "牵引/制动";
        attribute datatype : String = "Boolean";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "动态制动通道是否可用于当前制动力分配。";
        attribute aliases : String = "电制动可用;再生制动可用";
        attribute priority : String = "核心";
        attribute validityRule : String = "枚举/位集值域固定;需有效位和时间戳";
        attribute faultStrategy : String = "DegradeAvailability";
    }
    item def I_ITM_STA_003 {
        attribute itemCode : String = "ITM-STA-003";
        attribute chineseName : String = "制动系统可用状态";
        attribute englishName : String = "BrakeAvailability";
        attribute family : String = "状态/故障";
        attribute domain : String = "制动";
        attribute datatype : String = "Boolean";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "制动控制/执行系统是否具备请求的制动能力。";
        attribute aliases : String = "制动可用";
        attribute priority : String = "核心";
        attribute validityRule : String = "枚举/位集值域固定;需有效位和时间戳";
        attribute faultStrategy : String = "DegradeAvailability";
    }
    item def I_ITM_STA_004 {
        attribute itemCode : String = "ITM-STA-004";
        attribute chineseName : String = "制动施加状态";
        attribute englishName : String = "BrakeAppliedState";
        attribute family : String = "状态/故障";
        attribute domain : String = "制动";
        attribute datatype : String = "Boolean";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "相关制动通道当前是否处于施加状态。";
        attribute aliases : String = "制动已施加";
        attribute priority : String = "核心";
        attribute validityRule : String = "枚举/位集值域固定;需有效位和时间戳";
        attribute faultStrategy : String = "QualityFlag";
    }
    item def I_ITM_STA_005 {
        attribute itemCode : String = "ITM-STA-005";
        attribute chineseName : String = "制动缓解状态";
        attribute englishName : String = "BrakeReleasedState";
        attribute family : String = "状态/故障";
        attribute domain : String = "制动";
        attribute datatype : String = "Boolean";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "相关制动通道当前是否处于缓解状态。";
        attribute aliases : String = "制动释放状态";
        attribute priority : String = "核心";
        attribute validityRule : String = "枚举/位集值域固定;需有效位和时间戳";
        attribute faultStrategy : String = "QualityFlag";
    }
    item def I_ITM_STA_006 {
        attribute itemCode : String = "ITM-STA-006";
        attribute chineseName : String = "制动隔离状态";
        attribute englishName : String = "BrakeIsolationState";
        attribute family : String = "状态/故障";
        attribute domain : String = "制动";
        attribute datatype : String = "Boolean";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "相关制动通道是否被永久/局部隔离。";
        attribute aliases : String = "制动截断状态;隔离状态";
        attribute priority : String = "核心";
        attribute validityRule : String = "枚举/位集值域固定;需有效位和时间戳";
        attribute faultStrategy : String = "DegradeAvailability";
    }
    item def I_ITM_STA_007 {
        attribute itemCode : String = "ITM-STA-007";
        attribute chineseName : String = "制动控制故障状态";
        attribute englishName : String = "BrakeControlFault";
        attribute family : String = "状态/故障";
        attribute domain : String = "制动";
        attribute datatype : String = "Enum/Bitset";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "EBCU或制动控制链故障状态。";
        attribute aliases : String = "EBCU故障;制动故障";
        attribute priority : String = "核心";
        attribute validityRule : String = "枚举/位集值域固定;需有效位和时间戳";
        attribute faultStrategy : String = "SafeFallback";
    }
    item def I_ITM_STA_008 {
        attribute itemCode : String = "ITM-STA-008";
        attribute chineseName : String = "制动拖滞状态";
        attribute englishName : String = "DraggingBrakeState";
        attribute family : String = "状态/故障";
        attribute domain : String = "制动";
        attribute datatype : String = "Boolean";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "无有效制动请求但检测到非零制动力的拖滞状态。";
        attribute aliases : String = "拖闸;制动拖滞";
        attribute priority : String = "条件";
        attribute validityRule : String = "枚举/位集值域固定;需有效位和时间戳";
        attribute faultStrategy : String = "SafeFallback";
    }
    item def I_ITM_STA_009 {
        attribute itemCode : String = "ITM-STA-009";
        attribute chineseName : String = "低风压状态";
        attribute englishName : String = "LowPneumaticPressureState";
        attribute family : String = "状态/故障";
        attribute domain : String = "气动制动";
        attribute datatype : String = "Boolean";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "气动能源低于可用阈值的状态。";
        attribute aliases : String = "低气压;制动气源不足";
        attribute priority : String = "核心";
        attribute validityRule : String = "枚举/位集值域固定;需有效位和时间戳";
        attribute faultStrategy : String = "DegradeAvailability";
    }
    item def I_ITM_STA_010 {
        attribute itemCode : String = "ITM-STA-010";
        attribute chineseName : String = "防滑激活状态";
        attribute englishName : String = "WSPActiveState";
        attribute family : String = "状态/故障";
        attribute domain : String = "低黏着";
        attribute datatype : String = "Boolean";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "WSP当前是否正在干预制动力。";
        attribute aliases : String = "防滑动作;WSP active";
        attribute priority : String = "核心";
        attribute validityRule : String = "枚举/位集值域固定;需有效位和时间戳";
        attribute faultStrategy : String = "QualityFlag";
    }
    item def I_ITM_STA_011 {
        attribute itemCode : String = "ITM-STA-011";
        attribute chineseName : String = "防滑故障状态";
        attribute englishName : String = "WSPFaultState";
        attribute family : String = "状态/故障";
        attribute domain : String = "低黏着";
        attribute datatype : String = "Boolean";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "防滑控制/阀组故障状态。";
        attribute aliases : String = "WSP fault";
        attribute priority : String = "条件";
        attribute validityRule : String = "枚举/位集值域固定;需有效位和时间戳";
        attribute faultStrategy : String = "SafeFallback";
    }
    item def I_ITM_STA_012 {
        attribute itemCode : String = "ITM-STA-012";
        attribute chineseName : String = "撒砂状态";
        attribute englishName : String = "SandingState";
        attribute family : String = "状态/故障";
        attribute domain : String = "低黏着";
        attribute datatype : String = "Enum";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "撒砂系统空闲/执行/故障等状态。";
        attribute aliases : String = "撒砂执行状态";
        attribute priority : String = "条件";
        attribute validityRule : String = "枚举/位集值域固定;需有效位和时间戳";
        attribute faultStrategy : String = "QualityFlag";
    }
    item def I_ITM_STA_013 {
        attribute itemCode : String = "ITM-STA-013";
        attribute chineseName : String = "高压断路器状态";
        attribute englishName : String = "HVBreakerState";
        attribute family : String = "状态/故障";
        attribute domain : String = "主供电";
        attribute datatype : String = "Enum";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "高压断路器分/合/跳闸状态。";
        attribute aliases : String = "VCB状态;主断状态";
        attribute priority : String = "条件";
        attribute validityRule : String = "枚举/位集值域固定;需有效位和时间戳";
        attribute faultStrategy : String = "SafeFallback";
    }
    item def I_ITM_STA_014 {
        attribute itemCode : String = "ITM-STA-014";
        attribute chineseName : String = "高压隔离开关状态";
        attribute englishName : String = "HVIsolationSwitchState";
        attribute family : String = "状态/故障";
        attribute domain : String = "主供电";
        attribute datatype : String = "Enum";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "高压隔离开关状态。";
        attribute aliases : String = "隔离开关状态";
        attribute priority : String = "条件";
        attribute validityRule : String = "枚举/位集值域固定;需有效位和时间戳";
        attribute faultStrategy : String = "SafeFallback";
    }
    item def I_ITM_STA_015 {
        attribute itemCode : String = "ITM-STA-015";
        attribute chineseName : String = "受电弓状态";
        attribute englishName : String = "PantographState";
        attribute family : String = "状态/故障";
        attribute domain : String = "主供电";
        attribute datatype : String = "Enum";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "受电弓升/降/接触异常等状态。";
        attribute aliases : String = "升弓状态;受流状态";
        attribute priority : String = "条件";
        attribute validityRule : String = "枚举/位集值域固定;需有效位和时间戳";
        attribute faultStrategy : String = "SafeFallback";
    }
    item def I_ITM_STA_016 {
        attribute itemCode : String = "ITM-STA-016";
        attribute chineseName : String = "高压系统故障状态";
        attribute englishName : String = "HVSystemFault";
        attribute family : String = "状态/故障";
        attribute domain : String = "主供电";
        attribute datatype : String = "Enum/Bitset";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "高压测量、断路器、绝缘或主变压器等高压系统故障集合。";
        attribute aliases : String = "高压故障";
        attribute priority : String = "核心";
        attribute validityRule : String = "枚举/位集值域固定;需有效位和时间戳";
        attribute faultStrategy : String = "SafeFallback";
    }
    item def I_ITM_STA_017 {
        attribute itemCode : String = "ITM-STA-017";
        attribute chineseName : String = "网侧变流器状态";
        attribute englishName : String = "GridSideConverterState";
        attribute family : String = "状态/故障";
        attribute domain : String = "牵引";
        attribute datatype : String = "Enum";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "网侧变流器控制/功率模块运行状态。";
        attribute aliases : String = "网侧变流状态";
        attribute priority : String = "核心";
        attribute validityRule : String = "枚举/位集值域固定;需有效位和时间戳";
        attribute faultStrategy : String = "DegradeAvailability";
    }
    item def I_ITM_STA_018 {
        attribute itemCode : String = "ITM-STA-018";
        attribute chineseName : String = "电机侧变流器状态";
        attribute englishName : String = "MotorSideConverterState";
        attribute family : String = "状态/故障";
        attribute domain : String = "牵引";
        attribute datatype : String = "Enum";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "电机侧变流器运行状态。";
        attribute aliases : String = "逆变器状态;电机侧状态";
        attribute priority : String = "核心";
        attribute validityRule : String = "枚举/位集值域固定;需有效位和时间戳";
        attribute faultStrategy : String = "DegradeAvailability";
    }
    item def I_ITM_STA_019 {
        attribute itemCode : String = "ITM-STA-019";
        attribute chineseName : String = "牵引变流器故障状态";
        attribute englishName : String = "TractionConverterFault";
        attribute family : String = "状态/故障";
        attribute domain : String = "牵引";
        attribute datatype : String = "Enum/Bitset";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "牵引变流器保护/故障集合。";
        attribute aliases : String = "变流器故障";
        attribute priority : String = "核心";
        attribute validityRule : String = "枚举/位集值域固定;需有效位和时间戳";
        attribute faultStrategy : String = "SafeFallback";
    }
    item def I_ITM_STA_020 {
        attribute itemCode : String = "ITM-STA-020";
        attribute chineseName : String = "中间直流环节保护状态";
        attribute englishName : String = "DCLinkProtectionState";
        attribute family : String = "状态/故障";
        attribute domain : String = "牵引";
        attribute datatype : String = "Enum/Bitset";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "直流母线过压/欠压/过流等保护状态。";
        attribute aliases : String = "DC-link保护;母线保护";
        attribute priority : String = "核心";
        attribute validityRule : String = "枚举/位集值域固定;需有效位和时间戳";
        attribute faultStrategy : String = "SafeFallback";
    }
    item def I_ITM_STA_021 {
        attribute itemCode : String = "ITM-STA-021";
        attribute chineseName : String = "预充电状态";
        attribute englishName : String = "TractionPrechargeState";
        attribute family : String = "状态/故障";
        attribute domain : String = "牵引";
        attribute datatype : String = "Enum";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "牵引输入预充电过程状态。";
        attribute aliases : String = "预充完成;预充故障";
        attribute priority : String = "核心";
        attribute validityRule : String = "枚举/位集值域固定;需有效位和时间戳";
        attribute faultStrategy : String = "SafeFallback";
    }
    item def I_ITM_STA_022 {
        attribute itemCode : String = "ITM-STA-022";
        attribute chineseName : String = "牵引输入接通状态";
        attribute englishName : String = "TractionInputConnectionState";
        attribute family : String = "状态/故障";
        attribute domain : String = "牵引";
        attribute datatype : String = "Enum";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "牵引输入主回路接通/断开状态。";
        attribute aliases : String = "输入接触状态";
        attribute priority : String = "核心";
        attribute validityRule : String = "枚举/位集值域固定;需有效位和时间戳";
        attribute faultStrategy : String = "SafeFallback";
    }
    item def I_ITM_STA_023 {
        attribute itemCode : String = "ITM-STA-023";
        attribute chineseName : String = "制动斩波器状态";
        attribute englishName : String = "BrakeChopperState";
        attribute family : String = "状态/故障";
        attribute domain : String = "牵引/能量";
        attribute datatype : String = "Enum";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "制动斩波器可用/投入/故障状态。";
        attribute aliases : String = "放电电阻支路状态";
        attribute priority : String = "核心";
        attribute validityRule : String = "枚举/位集值域固定;需有效位和时间戳";
        attribute faultStrategy : String = "DegradeAvailability";
    }
    item def I_ITM_STA_024 {
        attribute itemCode : String = "ITM-STA-024";
        attribute chineseName : String = "高压安全回路状态";
        attribute englishName : String = "HVSafetyLoopState";
        attribute family : String = "状态/故障";
        attribute domain : String = "安全";
        attribute datatype : String = "Boolean/Enum";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "高压相关安全回路闭合/断开/故障状态。";
        attribute aliases : String = "高压安全链";
        attribute priority : String = "核心";
        attribute validityRule : String = "枚举/位集值域固定;需有效位和时间戳";
        attribute faultStrategy : String = "SafeFallback";
    }
    item def I_ITM_STA_025 {
        attribute itemCode : String = "ITM-STA-025";
        attribute chineseName : String = "制动安全回路状态";
        attribute englishName : String = "BrakeSafetyLoopState";
        attribute family : String = "状态/故障";
        attribute domain : String = "安全";
        attribute datatype : String = "Boolean/Enum";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "制动安全回路状态。";
        attribute aliases : String = "制动安全链";
        attribute priority : String = "核心";
        attribute validityRule : String = "枚举/位集值域固定;需有效位和时间戳";
        attribute faultStrategy : String = "SafeFallback";
    }
    item def I_ITM_STA_026 {
        attribute itemCode : String = "ITM-STA-026";
        attribute chineseName : String = "牵引安全回路状态";
        attribute englishName : String = "TractionSafetyLoopState";
        attribute family : String = "状态/故障";
        attribute domain : String = "安全";
        attribute datatype : String = "Boolean/Enum";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "牵引安全回路状态。";
        attribute aliases : String = "牵引安全链";
        attribute priority : String = "核心";
        attribute validityRule : String = "枚举/位集值域固定;需有效位和时间戳";
        attribute faultStrategy : String = "SafeFallback";
    }
    item def I_ITM_STA_027 {
        attribute itemCode : String = "ITM-STA-027";
        attribute chineseName : String = "ATP/外部安全系统状态";
        attribute englishName : String = "ExternalSafetySystemState";
        attribute family : String = "状态/故障";
        attribute domain : String = "安全";
        attribute datatype : String = "Enum/Bitset";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "ATP等外部安全系统提供的运行/制动相关状态。";
        attribute aliases : String = "ATP状态;列控状态";
        attribute priority : String = "条件";
        attribute validityRule : String = "枚举/位集值域固定;需有效位和时间戳";
        attribute faultStrategy : String = "SafeFallback";
    }
    item def I_ITM_STA_028 {
        attribute itemCode : String = "ITM-STA-028";
        attribute chineseName : String = "双向DC/DC状态";
        attribute englishName : String = "DCDCState";
        attribute family : String = "状态/故障";
        attribute domain : String = "储能";
        attribute datatype : String = "Enum";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "双向DC/DC待机/充电/放电/故障等状态。";
        attribute aliases : String = "DC/DC模式;ESS变流状态";
        attribute priority : String = "核心";
        attribute validityRule : String = "枚举/位集值域固定;需有效位和时间戳";
        attribute faultStrategy : String = "DegradeAvailability";
    }
    item def I_ITM_STA_029 {
        attribute itemCode : String = "ITM-STA-029";
        attribute chineseName : String = "双向DC/DC故障状态";
        attribute englishName : String = "DCDCFault";
        attribute family : String = "状态/故障";
        attribute domain : String = "储能";
        attribute datatype : String = "Enum/Bitset";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "双向DC/DC保护/故障集合。";
        attribute aliases : String = "DC/DC故障";
        attribute priority : String = "核心";
        attribute validityRule : String = "枚举/位集值域固定;需有效位和时间戳";
        attribute faultStrategy : String = "SafeFallback";
    }
    item def I_ITM_STA_030 {
        attribute itemCode : String = "ITM-STA-030";
        attribute chineseName : String = "储能系统可用状态";
        attribute englishName : String = "ESSAvailability";
        attribute family : String = "状态/故障";
        attribute domain : String = "储能";
        attribute datatype : String = "Boolean";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "储能支路是否可以接受或释放功率。";
        attribute aliases : String = "ESS可用;储能可用";
        attribute priority : String = "核心";
        attribute validityRule : String = "枚举/位集值域固定;需有效位和时间戳";
        attribute faultStrategy : String = "DegradeAvailability";
    }
    item def I_ITM_STA_031 {
        attribute itemCode : String = "ITM-STA-031";
        attribute chineseName : String = "储能系统故障状态";
        attribute englishName : String = "ESSFault";
        attribute family : String = "状态/故障";
        attribute domain : String = "储能";
        attribute datatype : String = "Enum/Bitset";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "储能支路故障集合。";
        attribute aliases : String = "ESS故障;超级电容系统故障";
        attribute priority : String = "核心";
        attribute validityRule : String = "枚举/位集值域固定;需有效位和时间戳";
        attribute faultStrategy : String = "SafeFallback";
    }
    item def I_ITM_STA_032 {
        attribute itemCode : String = "ITM-STA-032";
        attribute chineseName : String = "储能主接触器状态";
        attribute englishName : String = "ESSContactorState";
        attribute family : String = "状态/故障";
        attribute domain : String = "储能";
        attribute datatype : String = "Enum";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "储能主接触器分/合/故障状态。";
        attribute aliases : String = "ESS接触器状态";
        attribute priority : String = "核心";
        attribute validityRule : String = "枚举/位集值域固定;需有效位和时间戳";
        attribute faultStrategy : String = "SafeFallback";
    }
    item def I_ITM_STA_033 {
        attribute itemCode : String = "ITM-STA-033";
        attribute chineseName : String = "储能预充电状态";
        attribute englishName : String = "ESSPrechargeState";
        attribute family : String = "状态/故障";
        attribute domain : String = "储能";
        attribute datatype : String = "Enum";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "储能预充电未开始/进行中/完成/故障状态。";
        attribute aliases : String = "ESS预充状态";
        attribute priority : String = "核心";
        attribute validityRule : String = "枚举/位集值域固定;需有效位和时间戳";
        attribute faultStrategy : String = "SafeFallback";
    }
    item def I_ITM_STA_034 {
        attribute itemCode : String = "ITM-STA-034";
        attribute chineseName : String = "储能保护跳闸状态";
        attribute englishName : String = "ESSProtectionTripState";
        attribute family : String = "状态/故障";
        attribute domain : String = "储能";
        attribute datatype : String = "Boolean/Enum";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "储能支路检测保护组件的跳闸/闭锁状态。";
        attribute aliases : String = "ESS保护;储能跳闸";
        attribute priority : String = "核心";
        attribute validityRule : String = "枚举/位集值域固定;需有效位和时间戳";
        attribute faultStrategy : String = "SafeFallback";
    }
    item def I_ITM_STA_035 {
        attribute itemCode : String = "ITM-STA-035";
        attribute chineseName : String = "能量计量有效状态";
        attribute englishName : String = "EnergyMeasurementValidity";
        attribute family : String = "状态/故障";
        attribute domain : String = "能量统计";
        attribute datatype : String = "Boolean";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "能量计量数据是否有效、完整且未超时。";
        attribute aliases : String = "能量计有效位";
        attribute priority : String = "条件";
        attribute validityRule : String = "枚举/位集值域固定;需有效位和时间戳";
        attribute faultStrategy : String = "QualityFlag";
    }
    item def I_ITM_STA_036 {
        attribute itemCode : String = "ITM-STA-036";
        attribute chineseName : String = "制动控制接触器状态";
        attribute englishName : String = "BrakeControlContactorState";
        attribute family : String = "状态/故障";
        attribute domain : String = "制动";
        attribute datatype : String = "Enum";
        attribute unitOrMedium : String = "无";
        attribute semanticDefinition : String = "制动控制接触器断开/闭合/故障状态。";
        attribute aliases : String = "EBCU接触器状态";
        attribute priority : String = "条件";
        attribute validityRule : String = "状态枚举值域固定;需有效位";
        attribute faultStrategy : String = "SafeFallback";
    }
}
