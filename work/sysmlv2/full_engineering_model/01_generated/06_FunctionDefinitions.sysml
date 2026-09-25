package FunctionDefinitions {
    private import ScalarValues::*;
    private import ItemDefinitions::*;
    action def FN_F_3000_01 {
        attribute functionId : String = "F-3000-01";
        attribute chineseName : String = "转换能量/物理量、控制运行";
        attribute englishName : String = "Convert energy/quantities; Control operation";
        attribute functionLevel : Integer = 1;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "3000";
    }
    action def FN_F_3100_01 {
        attribute functionId : String = "F-3100-01";
        attribute chineseName : String = "转换能量/物理量、传递能量/介质";
        attribute englishName : String = "Convert energy/quantities; Transport energy/media";
        attribute functionLevel : Integer = 2;
        attribute category : String = "PHYSICAL_TRANSFORMATION";
        attribute allocatedProductCode : String = "3100";
    }
    action def FN_F_3110_01 {
        attribute functionId : String = "F-3110-01";
        attribute chineseName : String = "传递能量/介质、耗散能量";
        attribute englishName : String = "Transport energy/media; Dissipate energy";
        attribute functionLevel : Integer = 3;
        attribute category : String = "PHYSICAL_TRANSFORMATION";
        attribute allocatedProductCode : String = "3110";
    }
    action def FN_F_3111_01 {
        attribute functionId : String = "F-3111-01";
        attribute chineseName : String = "通过车轮耗散能量";
        attribute englishName : String = "Dissipate energy through Product 3111";
        attribute functionLevel : Integer = 4;
        attribute category : String = "ENERGY_DISSIPATION";
        attribute allocatedProductCode : String = "3111";
        inout item used_ITM_PHY_005 : I_ITM_PHY_005;
        inout item used_ITM_PHY_006 : I_ITM_PHY_006;
    }
    action def FN_F_3112_01 {
        attribute functionId : String = "F-3112-01";
        attribute chineseName : String = "传递车轴机械能";
        attribute englishName : String = "Transmit mechanical energy through Product 3112";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PHYSICAL_TRANSPORT";
        attribute allocatedProductCode : String = "3112";
        inout item used_ITM_PHY_005 : I_ITM_PHY_005;
    }
    action def FN_F_3120_01 {
        attribute functionId : String = "F-3120-01";
        attribute chineseName : String = "转换能量/物理量";
        attribute englishName : String = "Convert energy/quantities";
        attribute functionLevel : Integer = 3;
        attribute category : String = "PHYSICAL_TRANSFORMATION";
        attribute allocatedProductCode : String = "3120";
    }
    action def FN_F_3121_01 {
        attribute functionId : String = "F-3121-01";
        attribute chineseName : String = "转换齿轮箱主体机械参数";
        attribute englishName : String = "Transform mechanical parameters through Product 3121";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PHYSICAL_TRANSFORMATION";
        attribute allocatedProductCode : String = "3121";
        inout item used_ITM_PHY_005 : I_ITM_PHY_005;
    }
    action def FN_F_3130_01 {
        attribute functionId : String = "F-3130-01";
        attribute chineseName : String = "耗散能量";
        attribute englishName : String = "Dissipate energy";
        attribute functionLevel : Integer = 3;
        attribute category : String = "PHYSICAL_TRANSFORMATION";
        attribute allocatedProductCode : String = "3130";
    }
    action def FN_F_3131_01 {
        attribute functionId : String = "F-3131-01";
        attribute chineseName : String = "通过外轮盘耗散机械制动能量";
        attribute englishName : String = "Dissipate mechanical braking energy through the selected outer wheel disc";
        attribute functionLevel : Integer = 4;
        attribute category : String = "ENERGY_DISSIPATION";
        attribute allocatedProductCode : String = "3131";
        inout item used_ITM_PHY_007 : I_ITM_PHY_007;
        inout item used_ITM_PHY_013 : I_ITM_PHY_013;
    }
    action def FN_F_3132_01 {
        attribute functionId : String = "F-3132-01";
        attribute chineseName : String = "通过内轮盘耗散能量";
        attribute englishName : String = "Dissipate energy through Product 3132";
        attribute functionLevel : Integer = 4;
        attribute category : String = "ENERGY_DISSIPATION";
        attribute allocatedProductCode : String = "3132";
        inout item used_ITM_PHY_007 : I_ITM_PHY_007;
        inout item used_ITM_PHY_013 : I_ITM_PHY_013;
    }
    action def FN_F_3133_01 {
        attribute functionId : String = "F-3133-01";
        attribute chineseName : String = "通过轴盘耗散能量";
        attribute englishName : String = "Dissipate energy through Product 3133";
        attribute functionLevel : Integer = 4;
        attribute category : String = "ENERGY_DISSIPATION";
        attribute allocatedProductCode : String = "3133";
        inout item used_ITM_PHY_013 : I_ITM_PHY_013;
        inout item used_ITM_PHY_007 : I_ITM_PHY_007;
    }
    action def FN_F_3500_01 {
        attribute functionId : String = "F-3500-01";
        attribute chineseName : String = "传递能量/介质";
        attribute englishName : String = "Transport energy/media";
        attribute functionLevel : Integer = 2;
        attribute category : String = "PHYSICAL_TRANSPORT";
        attribute allocatedProductCode : String = "3500";
    }
    action def FN_F_3510_01 {
        attribute functionId : String = "F-3510-01";
        attribute chineseName : String = "传递能量/介质";
        attribute englishName : String = "Transport energy/media";
        attribute functionLevel : Integer = 3;
        attribute category : String = "PHYSICAL_TRANSPORT";
        attribute allocatedProductCode : String = "3510";
    }
    action def FN_F_3511_01 {
        attribute functionId : String = "F-3511-01";
        attribute chineseName : String = "传递联轴节(电机侧)机械能";
        attribute englishName : String = "Transmit mechanical energy through Product 3511";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PHYSICAL_TRANSPORT";
        attribute allocatedProductCode : String = "3511";
        inout item used_ITM_PHY_005 : I_ITM_PHY_005;
    }
    action def FN_F_3512_01 {
        attribute functionId : String = "F-3512-01";
        attribute chineseName : String = "传递联轴节(齿轮箱侧)机械能";
        attribute englishName : String = "Transmit mechanical energy through Product 3512";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PHYSICAL_TRANSPORT";
        attribute allocatedProductCode : String = "3512";
        inout item used_ITM_PHY_005 : I_ITM_PHY_005;
    }
    action def FN_F_3514_01 {
        attribute functionId : String = "F-3514-01";
        attribute chineseName : String = "传递万向轴机械能";
        attribute englishName : String = "Transmit mechanical energy through Product 3514";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PHYSICAL_TRANSPORT";
        attribute allocatedProductCode : String = "3514";
        inout item used_ITM_PHY_005 : I_ITM_PHY_005;
    }
    action def FN_F_3600_01 {
        attribute functionId : String = "F-3600-01";
        attribute chineseName : String = "检测运行参数";
        attribute englishName : String = "Measure parameters";
        attribute functionLevel : Integer = 2;
        attribute category : String = "PHYSICAL_TRANSPORT";
        attribute allocatedProductCode : String = "3600";
    }
    action def FN_F_3640_01 {
        attribute functionId : String = "F-3640-01";
        attribute chineseName : String = "检测运行参数";
        attribute englishName : String = "Measure parameters";
        attribute functionLevel : Integer = 3;
        attribute category : String = "PHYSICAL_TRANSPORT";
        attribute allocatedProductCode : String = "3640";
    }
    action def FN_F_3641_01 {
        attribute functionId : String = "F-3641-01";
        attribute chineseName : String = "检测轴端速度传感器状态";
        attribute englishName : String = "Measure state at Product 3641";
        attribute functionLevel : Integer = 4;
        attribute category : String = "MEASUREMENT";
        attribute allocatedProductCode : String = "3641";
        inout item used_ITM_PHY_005 : I_ITM_PHY_005;
        out item used_ITM_MEA_002 : I_ITM_MEA_002;
    }
    action def FN_F_3643_01 {
        attribute functionId : String = "F-3643-01";
        attribute chineseName : String = "检测齿轮箱速度传感器状态";
        attribute englishName : String = "Measure state at Product 3643";
        attribute functionLevel : Integer = 4;
        attribute category : String = "MEASUREMENT";
        attribute allocatedProductCode : String = "3643";
        out item used_ITM_MEA_003 : I_ITM_MEA_003;
        inout item used_ITM_PHY_005 : I_ITM_PHY_005;
    }
    action def FN_F_3644_01 {
        attribute functionId : String = "F-3644-01";
        attribute chineseName : String = "检测牵引电机速度传感器状态";
        attribute englishName : String = "Measure state at Product 3644";
        attribute functionLevel : Integer = 4;
        attribute category : String = "MEASUREMENT";
        attribute allocatedProductCode : String = "3644";
        out item used_ITM_MEA_004 : I_ITM_MEA_004;
        inout item used_ITM_PHY_005 : I_ITM_PHY_005;
    }
    action def FN_F_3800_01 {
        attribute functionId : String = "F-3800-01";
        attribute chineseName : String = "转换能量/物理量、控制运行";
        attribute englishName : String = "Convert energy/quantities; Control operation";
        attribute functionLevel : Integer = 2;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "3800";
    }
    action def FN_F_3810_01 {
        attribute functionId : String = "F-3810-01";
        attribute chineseName : String = "转换能量/物理量、控制运行";
        attribute englishName : String = "Convert energy/quantities; Control operation";
        attribute functionLevel : Integer = 3;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "3810";
    }
    action def FN_F_3811_01 {
        attribute functionId : String = "F-3811-01";
        attribute chineseName : String = "控制撒砂控制单元运行";
        attribute englishName : String = "Control Product 3811 operation";
        attribute functionLevel : Integer = 4;
        attribute category : String = "CONTROL";
        attribute allocatedProductCode : String = "3811";
        in item used_ITM_CMD_024 : I_ITM_CMD_024;
        out item used_ITM_CMD_032 : I_ITM_CMD_032;
    }
    action def FN_F_3811_02 {
        attribute functionId : String = "F-3811-02";
        attribute chineseName : String = "报告撒砂控制单元运行状态";
        attribute englishName : String = "Report Product 3811 operating state";
        attribute functionLevel : Integer = 4;
        attribute category : String = "STATUS_REPORTING";
        attribute allocatedProductCode : String = "3811";
        out item used_ITM_STA_012 : I_ITM_STA_012;
    }
    action def FN_F_3813_01 {
        attribute functionId : String = "F-3813-01";
        attribute chineseName : String = "执行撒砂阀板组件动作";
        attribute englishName : String = "Execute Product 3813 action";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PHYSICAL_TRANSFORMATION";
        attribute allocatedProductCode : String = "3813";
        out item used_ITM_STA_012 : I_ITM_STA_012;
        in item used_ITM_CMD_032 : I_ITM_CMD_032;
        inout item used_ITM_PHY_012 : I_ITM_PHY_012;
        inout item used_ITM_PHY_008 : I_ITM_PHY_008;
    }
    action def FN_F_3814_01 {
        attribute functionId : String = "F-3814-01";
        attribute chineseName : String = "执行撒砂喷嘴组件动作";
        attribute englishName : String = "Execute Product 3814 action";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PHYSICAL_TRANSFORMATION";
        attribute allocatedProductCode : String = "3814";
        inout item used_ITM_PHY_012 : I_ITM_PHY_012;
    }
    action def FN_F_4000_01 {
        attribute functionId : String = "F-4000-01";
        attribute chineseName : String = "转换能量/物理量、控制运行";
        attribute englishName : String = "Convert energy/quantities; Control operation";
        attribute functionLevel : Integer = 1;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "4000";
    }
    action def FN_F_4100_01 {
        attribute functionId : String = "F-4100-01";
        attribute chineseName : String = "传递能量/介质、控制运行";
        attribute englishName : String = "Transport energy/media; Control operation";
        attribute functionLevel : Integer = 2;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "4100";
    }
    action def FN_F_4110_01 {
        attribute functionId : String = "F-4110-01";
        attribute chineseName : String = "传递能量/介质、控制运行";
        attribute englishName : String = "Transport energy/media; Control operation";
        attribute functionLevel : Integer = 3;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "4110";
    }
    action def FN_F_4111_01 {
        attribute functionId : String = "F-4111-01";
        attribute chineseName : String = "传递碳滑板电能";
        attribute englishName : String = "Transmit electrical energy through Product 4111";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PHYSICAL_TRANSPORT";
        attribute allocatedProductCode : String = "4111";
        inout item used_ITM_PHY_001 : I_ITM_PHY_001;
    }
    action def FN_F_411C_01 {
        attribute functionId : String = "F-411C-01";
        attribute chineseName : String = "控制受电弓电子控制单元运行";
        attribute englishName : String = "Control Product 411C operation";
        attribute functionLevel : Integer = 4;
        attribute category : String = "CONTROL";
        attribute allocatedProductCode : String = "411C";
        in item used_ITM_CMD_018 : I_ITM_CMD_018;
    }
    action def FN_F_411C_02 {
        attribute functionId : String = "F-411C-02";
        attribute chineseName : String = "报告受电弓电子控制单元运行状态";
        attribute englishName : String = "Report Product 411C operating state";
        attribute functionLevel : Integer = 4;
        attribute category : String = "STATUS_REPORTING";
        attribute allocatedProductCode : String = "411C";
        out item used_ITM_STA_016 : I_ITM_STA_016;
        out item used_ITM_STA_015 : I_ITM_STA_015;
    }
    action def FN_F_4200_01 {
        attribute functionId : String = "F-4200-01";
        attribute chineseName : String = "传递能量/介质、控制运行";
        attribute englishName : String = "Transport energy/media; Control operation";
        attribute functionLevel : Integer = 2;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "4200";
    }
    action def FN_F_4210_01 {
        attribute functionId : String = "F-4210-01";
        attribute chineseName : String = "传递能量/介质";
        attribute englishName : String = "Transport energy/media";
        attribute functionLevel : Integer = 3;
        attribute category : String = "PHYSICAL_TRANSPORT";
        attribute allocatedProductCode : String = "4210";
    }
    action def FN_F_4211_01 {
        attribute functionId : String = "F-4211-01";
        attribute chineseName : String = "传递真空断路器电能";
        attribute englishName : String = "Transmit electrical energy through Product 4211";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PHYSICAL_TRANSPORT";
        attribute allocatedProductCode : String = "4211";
        inout item used_ITM_PHY_001 : I_ITM_PHY_001;
    }
    action def FN_F_4212_01 {
        attribute functionId : String = "F-4212-01";
        attribute chineseName : String = "传递非真空隔离开关电能";
        attribute englishName : String = "Transmit electrical energy through Product 4212";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PHYSICAL_TRANSPORT";
        attribute allocatedProductCode : String = "4212";
        inout item used_ITM_PHY_001 : I_ITM_PHY_001;
    }
    action def FN_F_4230_01 {
        attribute functionId : String = "F-4230-01";
        attribute chineseName : String = "控制运行、检测运行参数";
        attribute englishName : String = "Control operation; Measure parameters";
        attribute functionLevel : Integer = 3;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "4230";
    }
    action def FN_F_4235_01 {
        attribute functionId : String = "F-4235-01";
        attribute chineseName : String = "检测高压电压互感器状态";
        attribute englishName : String = "Measure state at Product 4235";
        attribute functionLevel : Integer = 4;
        attribute category : String = "MEASUREMENT";
        attribute allocatedProductCode : String = "4235";
        out item used_ITM_MEA_005 : I_ITM_MEA_005;
        inout item used_ITM_PHY_001 : I_ITM_PHY_001;
    }
    action def FN_F_4236_01 {
        attribute functionId : String = "F-4236-01";
        attribute chineseName : String = "检测并贯通高压电流互感器物理量";
        attribute englishName : String = "Measure while conducting the physical quantity through Product 4236";
        attribute functionLevel : Integer = 4;
        attribute category : String = "MEASUREMENT";
        attribute allocatedProductCode : String = "4236";
        inout item used_ITM_PHY_001 : I_ITM_PHY_001;
        out item used_ITM_MEA_006 : I_ITM_MEA_006;
    }
    action def FN_F_4238_01 {
        attribute functionId : String = "F-4238-01";
        attribute chineseName : String = "路由高压控制输入输出单元输入输出信号";
        attribute englishName : String = "Route input and output signals through Product 4238";
        attribute functionLevel : Integer = 4;
        attribute category : String = "CONTROL";
        attribute allocatedProductCode : String = "4238";
        in item used_ITM_CMD_018 : I_ITM_CMD_018;
        out item used_ITM_CMD_016 : I_ITM_CMD_016;
        out item used_ITM_MEA_005 : I_ITM_MEA_005;
        out item used_ITM_MEA_006 : I_ITM_MEA_006;
        in item used_ITM_CMD_017 : I_ITM_CMD_017;
    }
    action def FN_F_4238_02 {
        attribute functionId : String = "F-4238-02";
        attribute chineseName : String = "协调高压控制输入输出单元接口交互";
        attribute englishName : String = "Coordinate Product 4238 interface interactions";
        attribute functionLevel : Integer = 4;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "4238";
        in item used_ITM_CMD_018 : I_ITM_CMD_018;
    }
    action def FN_F_4238_03 {
        attribute functionId : String = "F-4238-03";
        attribute chineseName : String = "报告高压控制输入输出单元运行状态";
        attribute englishName : String = "Report Product 4238 operating state";
        attribute functionLevel : Integer = 4;
        attribute category : String = "STATUS_REPORTING";
        attribute allocatedProductCode : String = "4238";
        out item used_ITM_STA_016 : I_ITM_STA_016;
        in item used_ITM_STA_015 : I_ITM_STA_015;
        in item used_ITM_STA_014 : I_ITM_STA_014;
        in item used_ITM_STA_013 : I_ITM_STA_013;
    }
    action def FN_F_4239_01 {
        attribute functionId : String = "F-4239-01";
        attribute chineseName : String = "控制高压控制单元运行";
        attribute englishName : String = "Control Product 4239 operation";
        attribute functionLevel : Integer = 4;
        attribute category : String = "CONTROL";
        attribute allocatedProductCode : String = "4239";
        in item used_ITM_MEA_007 : I_ITM_MEA_007;
        out item used_ITM_CMD_017 : I_ITM_CMD_017;
        out item used_ITM_CMD_018 : I_ITM_CMD_018;
        out item used_ITM_CMD_016 : I_ITM_CMD_016;
        in item used_ITM_MEA_006 : I_ITM_MEA_006;
        in item used_ITM_MEA_005 : I_ITM_MEA_005;
    }
    action def FN_F_4239_02 {
        attribute functionId : String = "F-4239-02";
        attribute chineseName : String = "协调高压控制单元接口交互";
        attribute englishName : String = "Coordinate Product 4239 interface interactions";
        attribute functionLevel : Integer = 4;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "4239";
        out item used_ITM_CMD_018 : I_ITM_CMD_018;
    }
    action def FN_F_4239_03 {
        attribute functionId : String = "F-4239-03";
        attribute chineseName : String = "报告高压控制单元运行状态";
        attribute englishName : String = "Report Product 4239 operating state";
        attribute functionLevel : Integer = 4;
        attribute category : String = "STATUS_REPORTING";
        attribute allocatedProductCode : String = "4239";
        in item used_ITM_STA_013 : I_ITM_STA_013;
        in item used_ITM_STA_014 : I_ITM_STA_014;
        in item used_ITM_STA_016 : I_ITM_STA_016;
        in item used_ITM_STA_015 : I_ITM_STA_015;
        in item used_ITM_STA_024 : I_ITM_STA_024;
    }
    action def FN_F_4240_01 {
        attribute functionId : String = "F-4240-01";
        attribute chineseName : String = "控制运行、反馈运行状态";
        attribute englishName : String = "Control operation; Report status";
        attribute functionLevel : Integer = 3;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "4240";
    }
    action def FN_F_4241_01 {
        attribute functionId : String = "F-4241-01";
        attribute chineseName : String = "控制处理单元运行";
        attribute englishName : String = "Control Product 4241 operation";
        attribute functionLevel : Integer = 4;
        attribute category : String = "CONTROL";
        attribute allocatedProductCode : String = "4241";
        in item used_ITM_MEA_005 : I_ITM_MEA_005;
        in item used_ITM_MEA_006 : I_ITM_MEA_006;
    }
    action def FN_F_4241_02 {
        attribute functionId : String = "F-4241-02";
        attribute chineseName : String = "报告处理单元运行状态";
        attribute englishName : String = "Report Product 4241 operating state";
        attribute functionLevel : Integer = 4;
        attribute category : String = "STATUS_REPORTING";
        attribute allocatedProductCode : String = "4241";
        out item used_ITM_STA_035 : I_ITM_STA_035;
    }
    action def FN_F_4241_03 {
        attribute functionId : String = "F-4241-03";
        attribute chineseName : String = "统计处理单元运行数据";
        attribute englishName : String = "Accumulate Product 4241 operating statistics";
        attribute functionLevel : Integer = 4;
        attribute category : String = "STATISTICS";
        attribute allocatedProductCode : String = "4241";
        out item used_ITM_ACC_007 : I_ITM_ACC_007;
        out item used_ITM_ACC_009 : I_ITM_ACC_009;
        out item used_ITM_ACC_001 : I_ITM_ACC_001;
        out item used_ITM_ACC_003 : I_ITM_ACC_003;
    }
    action def FN_F_4400_01 {
        attribute functionId : String = "F-4400-01";
        attribute chineseName : String = "传递能量/介质";
        attribute englishName : String = "Transport energy/media";
        attribute functionLevel : Integer = 2;
        attribute category : String = "PHYSICAL_TRANSPORT";
        attribute allocatedProductCode : String = "4400";
    }
    action def FN_F_4410_01 {
        attribute functionId : String = "F-4410-01";
        attribute chineseName : String = "传递能量/介质";
        attribute englishName : String = "Transport energy/media";
        attribute functionLevel : Integer = 3;
        attribute category : String = "PHYSICAL_TRANSPORT";
        attribute allocatedProductCode : String = "4410";
    }
    action def FN_F_4411_01 {
        attribute functionId : String = "F-4411-01";
        attribute chineseName : String = "传递接地变压器物理能量";
        attribute englishName : String = "Transmit physical energy through Product 4411";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PHYSICAL_TRANSPORT";
        attribute allocatedProductCode : String = "4411";
        inout item used_ITM_PHY_013 : I_ITM_PHY_013;
        inout item used_ITM_PHY_011 : I_ITM_PHY_011;
    }
    action def FN_F_4412_01 {
        attribute functionId : String = "F-4412-01";
        attribute chineseName : String = "传递主回路接地电阻物理能量";
        attribute englishName : String = "Transmit physical energy through Product 4412";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PHYSICAL_TRANSPORT";
        attribute allocatedProductCode : String = "4412";
        inout item used_ITM_PHY_013 : I_ITM_PHY_013;
        inout item used_ITM_PHY_011 : I_ITM_PHY_011;
    }
    action def FN_F_4413_01 {
        attribute functionId : String = "F-4413-01";
        attribute chineseName : String = "传递回流碳刷电能";
        attribute englishName : String = "Transmit electrical energy through Product 4413";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PHYSICAL_TRANSPORT";
        attribute allocatedProductCode : String = "4413";
        inout item used_ITM_PHY_011 : I_ITM_PHY_011;
    }
    action def FN_F_4500_01 {
        attribute functionId : String = "F-4500-01";
        attribute chineseName : String = "转换能量/物理量、控制运行";
        attribute englishName : String = "Convert energy/quantities; Control operation";
        attribute functionLevel : Integer = 2;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "4500";
    }
    action def FN_F_4510_01 {
        attribute functionId : String = "F-4510-01";
        attribute chineseName : String = "转换能量/物理量、控制运行";
        attribute englishName : String = "Convert energy/quantities; Control operation";
        attribute functionLevel : Integer = 3;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "4510";
    }
    action def FN_F_4511_01 {
        attribute functionId : String = "F-4511-01";
        attribute chineseName : String = "实现高压交流电能与牵引变压器次级交流电能转换";
        attribute englishName : String = "Transform high-voltage AC to traction-transformer secondary AC";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PHYSICAL_TRANSFORMATION";
        attribute allocatedProductCode : String = "4511";
        inout item used_ITM_PHY_001 : I_ITM_PHY_001;
        inout item used_ITM_PHY_014 : I_ITM_PHY_014;
    }
    action def FN_F_4513_01 {
        attribute functionId : String = "F-4513-01";
        attribute chineseName : String = "传递电抗器电能";
        attribute englishName : String = "Transmit electrical energy through Product 4513";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PHYSICAL_TRANSPORT";
        attribute allocatedProductCode : String = "4513";
        inout item used_ITM_PHY_014 : I_ITM_PHY_014;
    }
    action def FN_F_4517_01 {
        attribute functionId : String = "F-4517-01";
        attribute chineseName : String = "检测主变压器检测及保护元件状态";
        attribute englishName : String = "Measure state at Product 4517";
        attribute functionLevel : Integer = 4;
        attribute category : String = "MEASUREMENT";
        attribute allocatedProductCode : String = "4517";
        out item used_ITM_MEA_022 : I_ITM_MEA_022;
        out item used_ITM_STA_016 : I_ITM_STA_016;
        inout item used_ITM_PHY_015 : I_ITM_PHY_015;
    }
    action def FN_F_4518_01 {
        attribute functionId : String = "F-4518-01";
        attribute chineseName : String = "控制主变压器控制装置运行";
        attribute englishName : String = "Control Product 4518 operation";
        attribute functionLevel : Integer = 4;
        attribute category : String = "CONTROL";
        attribute allocatedProductCode : String = "4518";
        in item used_ITM_MEA_022 : I_ITM_MEA_022;
        out item used_ITM_CMD_016 : I_ITM_CMD_016;
    }
    action def FN_F_4518_02 {
        attribute functionId : String = "F-4518-02";
        attribute chineseName : String = "报告主变压器控制装置运行状态";
        attribute englishName : String = "Report Product 4518 operating state";
        attribute functionLevel : Integer = 4;
        attribute category : String = "STATUS_REPORTING";
        attribute allocatedProductCode : String = "4518";
        in item used_ITM_STA_016 : I_ITM_STA_016;
        in item used_ITM_STA_013 : I_ITM_STA_013;
    }
    action def FN_F_5000_01 {
        attribute functionId : String = "F-5000-01";
        attribute chineseName : String = "转换能量/物理量、控制运行";
        attribute englishName : String = "Convert energy/quantities; Control operation";
        attribute functionLevel : Integer = 1;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "5000";
    }
    action def FN_F_5100_01 {
        attribute functionId : String = "F-5100-01";
        attribute chineseName : String = "转换能量/物理量、控制运行";
        attribute englishName : String = "Convert energy/quantities; Control operation";
        attribute functionLevel : Integer = 2;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "5100";
    }
    action def FN_F_5110_01 {
        attribute functionId : String = "F-5110-01";
        attribute chineseName : String = "控制运行、检测运行参数";
        attribute englishName : String = "Control operation; Measure parameters";
        attribute functionLevel : Integer = 3;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "5110";
    }
    action def FN_F_5111_01 {
        attribute functionId : String = "F-5111-01";
        attribute chineseName : String = "控制网侧变流器控制模块运行";
        attribute englishName : String = "Control Product 5111 operation";
        attribute functionLevel : Integer = 4;
        attribute category : String = "CONTROL";
        attribute allocatedProductCode : String = "5111";
        in item used_ITM_MEA_008 : I_ITM_MEA_008;
        in item used_ITM_MEA_009 : I_ITM_MEA_009;
        in item used_ITM_MEA_006 : I_ITM_MEA_006;
        out item used_ITM_CMD_010 : I_ITM_CMD_010;
        in item used_ITM_MEA_007 : I_ITM_MEA_007;
        in item used_ITM_MEA_005 : I_ITM_MEA_005;
    }
    action def FN_F_5111_02 {
        attribute functionId : String = "F-5111-02";
        attribute chineseName : String = "协调网侧变流器控制模块接口交互";
        attribute englishName : String = "Coordinate Product 5111 interface interactions";
        attribute functionLevel : Integer = 4;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "5111";
        in item used_ITM_MEA_008 : I_ITM_MEA_008;
    }
    action def FN_F_5111_03 {
        attribute functionId : String = "F-5111-03";
        attribute chineseName : String = "限制并保护网侧变流器控制模块运行";
        attribute englishName : String = "Limit and protect Product 5111 operation";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PROTECTION";
        attribute allocatedProductCode : String = "5111";
        out item used_ITM_LIM_005 : I_ITM_LIM_005;
        out item used_ITM_LIM_004 : I_ITM_LIM_004;
    }
    action def FN_F_5111_04 {
        attribute functionId : String = "F-5111-04";
        attribute chineseName : String = "报告网侧变流器控制模块运行状态";
        attribute englishName : String = "Report Product 5111 operating state";
        attribute functionLevel : Integer = 4;
        attribute category : String = "STATUS_REPORTING";
        attribute allocatedProductCode : String = "5111";
        out item used_ITM_STA_019 : I_ITM_STA_019;
        out item used_ITM_STA_017 : I_ITM_STA_017;
    }
    action def FN_F_5112_01 {
        attribute functionId : String = "F-5112-01";
        attribute chineseName : String = "控制电机侧变流器控制模块运行";
        attribute englishName : String = "Control Product 5112 operation";
        attribute functionLevel : Integer = 4;
        attribute category : String = "CONTROL";
        attribute allocatedProductCode : String = "5112";
        out item used_ITM_CMD_011 : I_ITM_CMD_011;
        in item used_ITM_MEA_008 : I_ITM_MEA_008;
        in item used_ITM_MEA_011 : I_ITM_MEA_011;
        in item used_ITM_MEA_009 : I_ITM_MEA_009;
        in item used_ITM_MEA_012 : I_ITM_MEA_012;
        in item used_ITM_MEA_010 : I_ITM_MEA_010;
        in item used_ITM_CMD_012 : I_ITM_CMD_012;
        in item used_ITM_MEA_004 : I_ITM_MEA_004;
    }
    action def FN_F_5112_02 {
        attribute functionId : String = "F-5112-02";
        attribute chineseName : String = "协调电机侧变流器控制模块接口交互";
        attribute englishName : String = "Coordinate Product 5112 interface interactions";
        attribute functionLevel : Integer = 4;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "5112";
        in item used_ITM_MEA_008 : I_ITM_MEA_008;
    }
    action def FN_F_5112_03 {
        attribute functionId : String = "F-5112-03";
        attribute chineseName : String = "限制并保护电机侧变流器控制模块运行";
        attribute englishName : String = "Limit and protect Product 5112 operation";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PROTECTION";
        attribute allocatedProductCode : String = "5112";
        out item used_ITM_LIM_003 : I_ITM_LIM_003;
        out item used_ITM_LIM_001 : I_ITM_LIM_001;
        out item used_ITM_LIM_004 : I_ITM_LIM_004;
    }
    action def FN_F_5112_04 {
        attribute functionId : String = "F-5112-04";
        attribute chineseName : String = "报告电机侧变流器控制模块运行状态";
        attribute englishName : String = "Report Product 5112 operating state";
        attribute functionLevel : Integer = 4;
        attribute category : String = "STATUS_REPORTING";
        attribute allocatedProductCode : String = "5112";
        out item used_ITM_STA_002 : I_ITM_STA_002;
        out item used_ITM_STA_001 : I_ITM_STA_001;
        out item used_ITM_STA_019 : I_ITM_STA_019;
        out item used_ITM_STA_018 : I_ITM_STA_018;
    }
    action def FN_F_5113_01 {
        attribute functionId : String = "F-5113-01";
        attribute chineseName : String = "检测变流器检测保护组件状态";
        attribute englishName : String = "Measure state at Product 5113";
        attribute functionLevel : Integer = 4;
        attribute category : String = "MEASUREMENT";
        attribute allocatedProductCode : String = "5113";
        inout item used_ITM_PHY_015 : I_ITM_PHY_015;
        out item used_ITM_MEA_023 : I_ITM_MEA_023;
        out item used_ITM_MEA_009 : I_ITM_MEA_009;
        out item used_ITM_STA_019 : I_ITM_STA_019;
        out item used_ITM_STA_020 : I_ITM_STA_020;
        out item used_ITM_LIM_007 : I_ITM_LIM_007;
        out item used_ITM_MEA_010 : I_ITM_MEA_010;
        out item used_ITM_MEA_008 : I_ITM_MEA_008;
    }
    action def FN_F_5120_01 {
        attribute functionId : String = "F-5120-01";
        attribute chineseName : String = "传递能量/介质";
        attribute englishName : String = "Transport energy/media";
        attribute functionLevel : Integer = 3;
        attribute category : String = "PHYSICAL_TRANSPORT";
        attribute allocatedProductCode : String = "5120";
    }
    action def FN_F_5121_01 {
        attribute functionId : String = "F-5121-01";
        attribute chineseName : String = "传递预充电组件电能";
        attribute englishName : String = "Transmit electrical energy through Product 5121";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PHYSICAL_TRANSPORT";
        attribute allocatedProductCode : String = "5121";
        inout item used_ITM_PHY_003 : I_ITM_PHY_003;
        inout item used_ITM_PHY_014 : I_ITM_PHY_014;
    }
    action def FN_F_5122_01 {
        attribute functionId : String = "F-5122-01";
        attribute chineseName : String = "传递输入组件电能";
        attribute englishName : String = "Transmit electrical energy through Product 5122";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PHYSICAL_TRANSPORT";
        attribute allocatedProductCode : String = "5122";
        inout item used_ITM_PHY_014 : I_ITM_PHY_014;
        inout item used_ITM_PHY_003 : I_ITM_PHY_003;
    }
    action def FN_F_5130_01 {
        attribute functionId : String = "F-5130-01";
        attribute chineseName : String = "转换能量/物理量、控制运行";
        attribute englishName : String = "Convert energy/quantities; Control operation";
        attribute functionLevel : Integer = 3;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "5130";
    }
    action def FN_F_5131_01 {
        attribute functionId : String = "F-5131-01";
        attribute chineseName : String = "实现主变次级交流电能与中间直流电能双向转换";
        attribute englishName : String = "Convert transformer secondary AC and DC-link energy bidirectionally";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PHYSICAL_TRANSFORMATION";
        attribute allocatedProductCode : String = "5131";
        inout item used_ITM_PHY_003 : I_ITM_PHY_003;
        inout item used_ITM_PHY_014 : I_ITM_PHY_014;
    }
    action def FN_F_5131_02 {
        attribute functionId : String = "F-5131-02";
        attribute chineseName : String = "执行网侧变流控制并反馈运行状态";
        attribute englishName : String = "Execute line-side conversion control and report operating state";
        attribute functionLevel : Integer = 4;
        attribute category : String = "CONTROL";
        attribute allocatedProductCode : String = "5131";
        out item used_ITM_MEA_006 : I_ITM_MEA_006;
        out item used_ITM_MEA_009 : I_ITM_MEA_009;
        in item used_ITM_CMD_010 : I_ITM_CMD_010;
        out item used_ITM_MEA_008 : I_ITM_MEA_008;
        out item used_ITM_MEA_005 : I_ITM_MEA_005;
    }
    action def FN_F_5132_01 {
        attribute functionId : String = "F-5132-01";
        attribute chineseName : String = "实现中间直流电能与电机侧三相交流电能双向转换";
        attribute englishName : String = "Convert DC-link and motor-side three-phase AC energy bidirectionally";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PHYSICAL_TRANSFORMATION";
        attribute allocatedProductCode : String = "5132";
        inout item used_ITM_PHY_003 : I_ITM_PHY_003;
        inout item used_ITM_PHY_004 : I_ITM_PHY_004;
    }
    action def FN_F_5132_02 {
        attribute functionId : String = "F-5132-02";
        attribute chineseName : String = "响应电机侧变流控制并反馈运行状态";
        attribute englishName : String = "Execute motor-side conversion control and report operating state";
        attribute functionLevel : Integer = 4;
        attribute category : String = "CONTROL";
        attribute allocatedProductCode : String = "5132";
        in item used_ITM_CMD_011 : I_ITM_CMD_011;
        out item used_ITM_MEA_011 : I_ITM_MEA_011;
        out item used_ITM_MEA_009 : I_ITM_MEA_009;
        out item used_ITM_MEA_010 : I_ITM_MEA_010;
        out item used_ITM_MEA_008 : I_ITM_MEA_008;
    }
    action def FN_F_5133_01 {
        attribute functionId : String = "F-5133-01";
        attribute chineseName : String = "控制放电电阻控制模块运行";
        attribute englishName : String = "Control Product 5133 operation";
        attribute functionLevel : Integer = 4;
        attribute category : String = "CONTROL";
        attribute allocatedProductCode : String = "5133";
        in item used_ITM_CMD_015 : I_ITM_CMD_015;
        in item used_ITM_MEA_008 : I_ITM_MEA_008;
    }
    action def FN_F_5133_02 {
        attribute functionId : String = "F-5133-02";
        attribute chineseName : String = "限制并保护放电电阻控制模块运行";
        attribute englishName : String = "Limit and protect Product 5133 operation";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PROTECTION";
        attribute allocatedProductCode : String = "5133";
        out item used_ITM_LIM_006 : I_ITM_LIM_006;
    }
    action def FN_F_5133_03 {
        attribute functionId : String = "F-5133-03";
        attribute chineseName : String = "报告放电电阻控制模块运行状态";
        attribute englishName : String = "Report Product 5133 operating state";
        attribute functionLevel : Integer = 4;
        attribute category : String = "STATUS_REPORTING";
        attribute allocatedProductCode : String = "5133";
        out item used_ITM_STA_023 : I_ITM_STA_023;
    }
    action def FN_F_5140_01 {
        attribute functionId : String = "F-5140-01";
        attribute chineseName : String = "耗散能量、检测运行参数";
        attribute englishName : String = "Dissipate energy; Measure parameters";
        attribute functionLevel : Integer = 3;
        attribute category : String = "PHYSICAL_TRANSFORMATION";
        attribute allocatedProductCode : String = "5140";
    }
    action def FN_F_5142_01 {
        attribute functionId : String = "F-5142-01";
        attribute chineseName : String = "通过放电电阻器耗散能量";
        attribute englishName : String = "Dissipate energy through Product 5142";
        attribute functionLevel : Integer = 4;
        attribute category : String = "ENERGY_DISSIPATION";
        attribute allocatedProductCode : String = "5142";
        inout item used_ITM_PHY_003 : I_ITM_PHY_003;
        inout item used_ITM_PHY_013 : I_ITM_PHY_013;
    }
    action def FN_F_5142_02 {
        attribute functionId : String = "F-5142-02";
        attribute chineseName : String = "统计放电电阻器运行数据";
        attribute englishName : String = "Accumulate Product 5142 operating statistics";
        attribute functionLevel : Integer = 4;
        attribute category : String = "STATISTICS";
        attribute allocatedProductCode : String = "5142";
        out item used_ITM_ACC_012 : I_ITM_ACC_012;
        out item used_ITM_ACC_005 : I_ITM_ACC_005;
    }
    action def FN_F_5145_01 {
        attribute functionId : String = "F-5145-01";
        attribute chineseName : String = "检测中间直流环节检测保护组件状态";
        attribute englishName : String = "Measure state at Product 5145";
        attribute functionLevel : Integer = 4;
        attribute category : String = "MEASUREMENT";
        attribute allocatedProductCode : String = "5145";
        out item used_ITM_MEA_008 : I_ITM_MEA_008;
        inout item used_ITM_PHY_015 : I_ITM_PHY_015;
        out item used_ITM_STA_020 : I_ITM_STA_020;
        out item used_ITM_CMD_015 : I_ITM_CMD_015;
        out item used_ITM_LIM_007 : I_ITM_LIM_007;
        out item used_ITM_MEA_009 : I_ITM_MEA_009;
    }
    action def FN_F_5300_01 {
        attribute functionId : String = "F-5300-01";
        attribute chineseName : String = "转换能量/物理量、检测运行参数";
        attribute englishName : String = "Convert energy/quantities; Measure parameters";
        attribute functionLevel : Integer = 2;
        attribute category : String = "PHYSICAL_TRANSFORMATION";
        attribute allocatedProductCode : String = "5300";
    }
    action def FN_F_5310_01 {
        attribute functionId : String = "F-5310-01";
        attribute chineseName : String = "转换能量/物理量、检测运行参数";
        attribute englishName : String = "Convert energy/quantities; Measure parameters";
        attribute functionLevel : Integer = 3;
        attribute category : String = "PHYSICAL_TRANSFORMATION";
        attribute allocatedProductCode : String = "5310";
    }
    action def FN_F_5311_01 {
        attribute functionId : String = "F-5311-01";
        attribute chineseName : String = "实现三相交流电能与旋转机械能双向转换";
        attribute englishName : String = "Convert three-phase AC and rotational mechanical energy bidirectionally";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PHYSICAL_TRANSFORMATION";
        attribute allocatedProductCode : String = "5311";
        inout item used_ITM_PHY_005 : I_ITM_PHY_005;
        inout item used_ITM_PHY_004 : I_ITM_PHY_004;
    }
    action def FN_F_5311_02 {
        attribute functionId : String = "F-5311-02";
        attribute chineseName : String = "提供牵引电机转速、转矩及电气状态反馈";
        attribute englishName : String = "Provide traction-motor speed, torque and electrical feedback";
        attribute functionLevel : Integer = 4;
        attribute category : String = "MEASUREMENT";
        attribute allocatedProductCode : String = "5311";
        out item used_ITM_MEA_011 : I_ITM_MEA_011;
        out item used_ITM_MEA_004 : I_ITM_MEA_004;
        out item used_ITM_MEA_010 : I_ITM_MEA_010;
        out item used_ITM_MEA_012 : I_ITM_MEA_012;
    }
    action def FN_F_7000_01 {
        attribute functionId : String = "F-7000-01";
        attribute chineseName : String = "转换能量/物理量、控制运行";
        attribute englishName : String = "Convert energy/quantities; Control operation";
        attribute functionLevel : Integer = 1;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "7000";
    }
    action def FN_F_7100_01 {
        attribute functionId : String = "F-7100-01";
        attribute chineseName : String = "传递能量/介质、检测运行参数";
        attribute englishName : String = "Transport energy/media; Measure parameters";
        attribute functionLevel : Integer = 2;
        attribute category : String = "PHYSICAL_TRANSPORT";
        attribute allocatedProductCode : String = "7100";
    }
    action def FN_F_7120_01 {
        attribute functionId : String = "F-7120-01";
        attribute chineseName : String = "传递能量/介质";
        attribute englishName : String = "Transport energy/media";
        attribute functionLevel : Integer = 3;
        attribute category : String = "PHYSICAL_TRANSPORT";
        attribute allocatedProductCode : String = "7120";
    }
    action def FN_F_7124_01 {
        attribute functionId : String = "F-7124-01";
        attribute chineseName : String = "提供制动风缸外部能量";
        attribute englishName : String = "Provide external energy through Product 7124";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PHYSICAL_TRANSPORT";
        attribute allocatedProductCode : String = "7124";
        inout item used_ITM_PHY_008 : I_ITM_PHY_008;
    }
    action def FN_F_7130_01 {
        attribute functionId : String = "F-7130-01";
        attribute chineseName : String = "传递能量/介质";
        attribute englishName : String = "Transport energy/media";
        attribute functionLevel : Integer = 3;
        attribute category : String = "PHYSICAL_TRANSPORT";
        attribute allocatedProductCode : String = "7130";
    }
    action def FN_F_7131_01 {
        attribute functionId : String = "F-7131-01";
        attribute chineseName : String = "传递总风管气动压力";
        attribute englishName : String = "Transmit pneumatic pressure through Product 7131";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PHYSICAL_TRANSPORT";
        attribute allocatedProductCode : String = "7131";
        inout item used_ITM_PHY_008 : I_ITM_PHY_008;
    }
    action def FN_F_7140_01 {
        attribute functionId : String = "F-7140-01";
        attribute chineseName : String = "检测运行参数";
        attribute englishName : String = "Measure parameters";
        attribute functionLevel : Integer = 3;
        attribute category : String = "PHYSICAL_TRANSPORT";
        attribute allocatedProductCode : String = "7140";
    }
    action def FN_F_7142_01 {
        attribute functionId : String = "F-7142-01";
        attribute chineseName : String = "检测总风管压力传感器状态";
        attribute englishName : String = "Measure state at Product 7142";
        attribute functionLevel : Integer = 4;
        attribute category : String = "MEASUREMENT";
        attribute allocatedProductCode : String = "7142";
        inout item used_ITM_PHY_008 : I_ITM_PHY_008;
        out item used_ITM_MEA_014 : I_ITM_MEA_014;
        out item used_ITM_STA_009 : I_ITM_STA_009;
    }
    action def FN_F_7200_01 {
        attribute functionId : String = "F-7200-01";
        attribute chineseName : String = "转换能量/物理量、控制运行";
        attribute englishName : String = "Convert energy/quantities; Control operation";
        attribute functionLevel : Integer = 2;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "7200";
    }
    action def FN_F_7210_01 {
        attribute functionId : String = "F-7210-01";
        attribute chineseName : String = "转换能量/物理量、控制运行";
        attribute englishName : String = "Convert energy/quantities; Control operation";
        attribute functionLevel : Integer = 3;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "7210";
    }
    action def FN_F_7211_01 {
        attribute functionId : String = "F-7211-01";
        attribute chineseName : String = "处理制动请求";
        attribute englishName : String = "Process braking requests";
        attribute functionLevel : Integer = 4;
        attribute category : String = "CONTROL";
        attribute allocatedProductCode : String = "7211";
        out item used_ITM_CMD_020 : I_ITM_CMD_020;
        out item used_ITM_CMD_019 : I_ITM_CMD_019;
        in item used_ITM_CMD_003 : I_ITM_CMD_003;
        out item used_ITM_CMD_008 : I_ITM_CMD_008;
        out item used_ITM_CMD_031 : I_ITM_CMD_031;
    }
    action def FN_F_7211_02 {
        attribute functionId : String = "F-7211-02";
        attribute chineseName : String = "协调再生制动与摩擦制动力";
        attribute englishName : String = "Coordinate regenerative and friction braking effort";
        attribute functionLevel : Integer = 4;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "7211";
        out item used_ITM_CMD_006 : I_ITM_CMD_006;
        in item used_ITM_MEA_013 : I_ITM_MEA_013;
        in item used_ITM_MEA_001 : I_ITM_MEA_001;
        out item used_ITM_CMD_007 : I_ITM_CMD_007;
        in item used_ITM_MEA_018 : I_ITM_MEA_018;
        in item used_ITM_MEA_021 : I_ITM_MEA_021;
        in item used_ITM_MEA_017 : I_ITM_MEA_017;
        out item used_ITM_LIM_002 : I_ITM_LIM_002;
        in item used_ITM_MEA_014 : I_ITM_MEA_014;
        in item used_ITM_MEA_019 : I_ITM_MEA_019;
        in item used_ITM_MEA_020 : I_ITM_MEA_020;
        in item used_ITM_LIM_001 : I_ITM_LIM_001;
        in item used_ITM_LIM_013 : I_ITM_LIM_013;
        in item used_ITM_MEA_016 : I_ITM_MEA_016;
    }
    action def FN_F_7211_03 {
        attribute functionId : String = "F-7211-03";
        attribute chineseName : String = "执行电空制动控制";
        attribute englishName : String = "Execute electro-pneumatic brake control";
        attribute functionLevel : Integer = 4;
        attribute category : String = "CONTROL";
        attribute allocatedProductCode : String = "7211";
        out item used_ITM_CMD_021 : I_ITM_CMD_021;
        out item used_ITM_CMD_022 : I_ITM_CMD_022;
    }
    action def FN_F_7211_04 {
        attribute functionId : String = "F-7211-04";
        attribute chineseName : String = "协调防滑与紧急制动安全请求";
        attribute englishName : String = "Coordinate anti-slip and emergency-brake safety requests";
        attribute functionLevel : Integer = 4;
        attribute category : String = "SAFETY";
        attribute allocatedProductCode : String = "7211";
        out item used_ITM_STA_006 : I_ITM_STA_006;
        out item used_ITM_STA_007 : I_ITM_STA_007;
        out item used_ITM_STA_010 : I_ITM_STA_010;
        in item used_ITM_STA_009 : I_ITM_STA_009;
        in item used_ITM_STA_025 : I_ITM_STA_025;
        in item used_ITM_LIM_008 : I_ITM_LIM_008;
        in item used_ITM_LIM_014 : I_ITM_LIM_014;
        out item used_ITM_STA_005 : I_ITM_STA_005;
        out item used_ITM_STA_008 : I_ITM_STA_008;
        in item used_ITM_STA_002 : I_ITM_STA_002;
        in item used_ITM_CMD_030 : I_ITM_CMD_030;
        in item used_ITM_CMD_004 : I_ITM_CMD_004;
        out item used_ITM_STA_004 : I_ITM_STA_004;
        out item used_ITM_CMD_023 : I_ITM_CMD_023;
        out item used_ITM_STA_003 : I_ITM_STA_003;
        out item used_ITM_STA_011 : I_ITM_STA_011;
    }
    action def FN_F_7213_01 {
        attribute functionId : String = "F-7213-01";
        attribute chineseName : String = "执行制动控制接触器及其他动作";
        attribute englishName : String = "Execute Product 7213 action";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PHYSICAL_TRANSFORMATION";
        attribute allocatedProductCode : String = "7213";
        out item used_ITM_STA_036 : I_ITM_STA_036;
        inout item used_ITM_PHY_015 : I_ITM_PHY_015;
        in item used_ITM_CMD_031 : I_ITM_CMD_031;
    }
    action def FN_F_7220_01 {
        attribute functionId : String = "F-7220-01";
        attribute chineseName : String = "转换能量/物理量、执行安全控制";
        attribute englishName : String = "Convert energy/quantities; Execute safety control";
        attribute functionLevel : Integer = 3;
        attribute category : String = "SAFETY";
        attribute allocatedProductCode : String = "7220";
    }
    action def FN_F_7222_01 {
        attribute functionId : String = "F-7222-01";
        attribute chineseName : String = "传递电空转换阀气动压力";
        attribute englishName : String = "Transmit pneumatic pressure through Product 7222";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PHYSICAL_TRANSPORT";
        attribute allocatedProductCode : String = "7222";
        inout item used_ITM_PHY_008 : I_ITM_PHY_008;
        inout item used_ITM_PHY_009 : I_ITM_PHY_009;
    }
    action def FN_F_7223_01 {
        attribute functionId : String = "F-7223-01";
        attribute chineseName : String = "传递中继阀气动压力";
        attribute englishName : String = "Transmit pneumatic pressure through Product 7223";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PHYSICAL_TRANSPORT";
        attribute allocatedProductCode : String = "7223";
        inout item used_ITM_PHY_008 : I_ITM_PHY_008;
        inout item used_ITM_PHY_010 : I_ITM_PHY_010;
        inout item used_ITM_PHY_009 : I_ITM_PHY_009;
    }
    action def FN_F_7224_01 {
        attribute functionId : String = "F-7224-01";
        attribute chineseName : String = "检测空重车调整阀状态";
        attribute englishName : String = "Measure state at Product 7224";
        attribute functionLevel : Integer = 4;
        attribute category : String = "MEASUREMENT";
        attribute allocatedProductCode : String = "7224";
        inout item used_ITM_PHY_009 : I_ITM_PHY_009;
        inout item used_ITM_PHY_008 : I_ITM_PHY_008;
        in item used_ITM_MEA_019 : I_ITM_MEA_019;
    }
    action def FN_F_7225_01 {
        attribute functionId : String = "F-7225-01";
        attribute chineseName : String = "执行控制电磁阀动作";
        attribute englishName : String = "Execute Product 7225 action";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PHYSICAL_TRANSFORMATION";
        attribute allocatedProductCode : String = "7225";
        inout item used_ITM_PHY_009 : I_ITM_PHY_009;
        in item used_ITM_CMD_022 : I_ITM_CMD_022;
        inout item used_ITM_PHY_008 : I_ITM_PHY_008;
    }
    action def FN_F_7226_01 {
        attribute functionId : String = "F-7226-01";
        attribute chineseName : String = "执行紧急制动气动隔离与施加";
        attribute englishName : String = "Execute pneumatic isolation and application for emergency braking";
        attribute functionLevel : Integer = 4;
        attribute category : String = "SAFETY";
        attribute allocatedProductCode : String = "7226";
        inout item used_ITM_PHY_008 : I_ITM_PHY_008;
        inout item used_ITM_PHY_009 : I_ITM_PHY_009;
        in item used_ITM_CMD_004 : I_ITM_CMD_004;
        inout item used_ITM_PHY_010 : I_ITM_PHY_010;
        in item used_ITM_CMD_030 : I_ITM_CMD_030;
    }
    action def FN_F_7227_01 {
        attribute functionId : String = "F-7227-01";
        attribute chineseName : String = "执行缓解阀动作";
        attribute englishName : String = "Execute Product 7227 action";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PHYSICAL_TRANSFORMATION";
        attribute allocatedProductCode : String = "7227";
        inout item used_ITM_PHY_010 : I_ITM_PHY_010;
        in item used_ITM_CMD_019 : I_ITM_CMD_019;
    }
    action def FN_F_7228_01 {
        attribute functionId : String = "F-7228-01";
        attribute chineseName : String = "传递车厢直接制动截断塞门气动压力";
        attribute englishName : String = "Transmit pneumatic pressure through Product 7228";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PHYSICAL_TRANSPORT";
        attribute allocatedProductCode : String = "7228";
        inout item used_ITM_PHY_010 : I_ITM_PHY_010;
    }
    action def FN_F_7229_01 {
        attribute functionId : String = "F-7229-01";
        attribute chineseName : String = "传递调压阀气动压力";
        attribute englishName : String = "Transmit pneumatic pressure through Product 7229";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PHYSICAL_TRANSPORT";
        attribute allocatedProductCode : String = "7229";
        inout item used_ITM_PHY_008 : I_ITM_PHY_008;
        inout item used_ITM_PHY_009 : I_ITM_PHY_009;
    }
    action def FN_F_722A_01 {
        attribute functionId : String = "F-722A-01";
        attribute chineseName : String = "传递防滑阀组成气动压力";
        attribute englishName : String = "Transmit pneumatic pressure through Product 722A";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PHYSICAL_TRANSPORT";
        attribute allocatedProductCode : String = "722A";
        inout item used_ITM_PHY_010 : I_ITM_PHY_010;
    }
    action def FN_F_722B_01 {
        attribute functionId : String = "F-722B-01";
        attribute chineseName : String = "检测压力传感器状态";
        attribute englishName : String = "Measure state at Product 722B";
        attribute functionLevel : Integer = 4;
        attribute category : String = "MEASUREMENT";
        attribute allocatedProductCode : String = "722B";
        inout item used_ITM_PHY_010 : I_ITM_PHY_010;
        out item used_ITM_MEA_016 : I_ITM_MEA_016;
    }
    action def FN_F_722C_01 {
        attribute functionId : String = "F-722C-01";
        attribute chineseName : String = "检测压力开关状态";
        attribute englishName : String = "Measure state at Product 722C";
        attribute functionLevel : Integer = 4;
        attribute category : String = "MEASUREMENT";
        attribute allocatedProductCode : String = "722C";
        out item used_ITM_STA_009 : I_ITM_STA_009;
        inout item used_ITM_PHY_010 : I_ITM_PHY_010;
    }
    action def FN_F_7250_01 {
        attribute functionId : String = "F-7250-01";
        attribute chineseName : String = "转换能量/物理量、传递能量/介质";
        attribute englishName : String = "Convert energy/quantities; Transport energy/media";
        attribute functionLevel : Integer = 3;
        attribute category : String = "PHYSICAL_TRANSFORMATION";
        attribute allocatedProductCode : String = "7250";
    }
    action def FN_F_7252_01 {
        attribute functionId : String = "F-7252-01";
        attribute chineseName : String = "传递制动夹钳作用力";
        attribute englishName : String = "Transmit brake-caliper force";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PHYSICAL_TRANSPORT";
        attribute allocatedProductCode : String = "7252";
        inout item used_ITM_PHY_007 : I_ITM_PHY_007;
        inout item used_ITM_PHY_010 : I_ITM_PHY_010;
        out item used_ITM_STA_005 : I_ITM_STA_005;
        out item used_ITM_STA_004 : I_ITM_STA_004;
        out item used_ITM_MEA_017 : I_ITM_MEA_017;
    }
    action def FN_F_7254_01 {
        attribute functionId : String = "F-7254-01";
        attribute chineseName : String = "通过闸片耗散机械制动能量";
        attribute englishName : String = "Dissipate mechanical braking energy through brake pads";
        attribute functionLevel : Integer = 4;
        attribute category : String = "ENERGY_DISSIPATION";
        attribute allocatedProductCode : String = "7254";
        inout item used_ITM_PHY_007 : I_ITM_PHY_007;
        out item used_ITM_ACC_006 : I_ITM_ACC_006;
        out item used_ITM_ACC_013 : I_ITM_ACC_013;
        inout item used_ITM_PHY_013 : I_ITM_PHY_013;
    }
    action def FN_F_7255_01 {
        attribute functionId : String = "F-7255-01";
        attribute chineseName : String = "将气动压力转换为制动机械力";
        attribute englishName : String = "Convert pneumatic pressure into mechanical braking force";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PHYSICAL_TRANSFORMATION";
        attribute allocatedProductCode : String = "7255";
        inout item used_ITM_PHY_007 : I_ITM_PHY_007;
        inout item used_ITM_PHY_010 : I_ITM_PHY_010;
    }
    action def FN_F_7280_01 {
        attribute functionId : String = "F-7280-01";
        attribute chineseName : String = "转换能量/物理量、传递能量/介质";
        attribute englishName : String = "Convert energy/quantities; Transport energy/media";
        attribute functionLevel : Integer = 3;
        attribute category : String = "PHYSICAL_TRANSFORMATION";
        attribute allocatedProductCode : String = "7280";
    }
    action def FN_F_7281_01 {
        attribute functionId : String = "F-7281-01";
        attribute chineseName : String = "执行制动指示器动作";
        attribute englishName : String = "Execute Product 7281 action";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PHYSICAL_TRANSFORMATION";
        attribute allocatedProductCode : String = "7281";
        inout item used_ITM_PHY_015 : I_ITM_PHY_015;
        in item used_ITM_STA_004 : I_ITM_STA_004;
        in item used_ITM_STA_006 : I_ITM_STA_006;
        in item used_ITM_STA_005 : I_ITM_STA_005;
    }
    action def FN_F_7284_01 {
        attribute functionId : String = "F-7284-01";
        attribute chineseName : String = "传递转向架制动截断塞门气动压力";
        attribute englishName : String = "Transmit pneumatic pressure through Product 7284";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PHYSICAL_TRANSPORT";
        attribute allocatedProductCode : String = "7284";
        inout item used_ITM_PHY_010 : I_ITM_PHY_010;
    }
    action def FN_F_7285_01 {
        attribute functionId : String = "F-7285-01";
        attribute chineseName : String = "传递单轴制动截断塞门气动压力";
        attribute englishName : String = "Transmit pneumatic pressure through Product 7285";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PHYSICAL_TRANSPORT";
        attribute allocatedProductCode : String = "7285";
        inout item used_ITM_PHY_010 : I_ITM_PHY_010;
    }
    action def FN_F_8000_01 {
        attribute functionId : String = "F-8000-01";
        attribute chineseName : String = "控制运行、实施保护与限制";
        attribute englishName : String = "Control operation; Protect/limit operation";
        attribute functionLevel : Integer = 1;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "8000";
    }
    action def FN_F_8100_01 {
        attribute functionId : String = "F-8100-01";
        attribute chineseName : String = "控制运行、实施保护与限制";
        attribute englishName : String = "Control operation; Protect/limit operation";
        attribute functionLevel : Integer = 2;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "8100";
    }
    action def FN_F_8120_01 {
        attribute functionId : String = "F-8120-01";
        attribute chineseName : String = "控制运行、实施保护与限制";
        attribute englishName : String = "Control operation; Protect/limit operation";
        attribute functionLevel : Integer = 3;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "8120";
    }
    action def FN_F_8121_01 {
        attribute functionId : String = "F-8121-01";
        attribute chineseName : String = "控制主控制单元运行";
        attribute englishName : String = "Control Product 8121 operation";
        attribute functionLevel : Integer = 4;
        attribute category : String = "CONTROL";
        attribute allocatedProductCode : String = "8121";
        in item used_ITM_CMD_001 : I_ITM_CMD_001;
        in item used_ITM_CMD_002 : I_ITM_CMD_002;
        out item used_ITM_CMD_008 : I_ITM_CMD_008;
        in item used_ITM_CMD_003 : I_ITM_CMD_003;
        out item used_ITM_CMD_004 : I_ITM_CMD_004;
        in item used_ITM_CMD_030 : I_ITM_CMD_030;
        in item used_ITM_MEA_001 : I_ITM_MEA_001;
        out item used_ITM_CMD_009 : I_ITM_CMD_009;
    }
    action def FN_F_8121_02 {
        attribute functionId : String = "F-8121-02";
        attribute chineseName : String = "协调主控制单元接口交互";
        attribute englishName : String = "Coordinate Product 8121 interface interactions";
        attribute functionLevel : Integer = 4;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "8121";
        in item used_ITM_STA_027 : I_ITM_STA_027;
    }
    action def FN_F_8121_03 {
        attribute functionId : String = "F-8121-03";
        attribute chineseName : String = "报告主控制单元运行状态";
        attribute englishName : String = "Report Product 8121 operating state";
        attribute functionLevel : Integer = 4;
        attribute category : String = "STATUS_REPORTING";
        attribute allocatedProductCode : String = "8121";
        in item used_ITM_STA_025 : I_ITM_STA_025;
        in item used_ITM_STA_024 : I_ITM_STA_024;
        in item used_ITM_STA_027 : I_ITM_STA_027;
        in item used_ITM_STA_001 : I_ITM_STA_001;
        in item used_ITM_STA_026 : I_ITM_STA_026;
        in item used_ITM_STA_003 : I_ITM_STA_003;
    }
    action def FN_F_8122_01 {
        attribute functionId : String = "F-8122-01";
        attribute chineseName : String = "控制车辆控制单元运行";
        attribute englishName : String = "Control Product 8122 operation";
        attribute functionLevel : Integer = 4;
        attribute category : String = "CONTROL";
        attribute allocatedProductCode : String = "8122";
        out item used_ITM_CMD_024 : I_ITM_CMD_024;
        out item used_ITM_CMD_009 : I_ITM_CMD_009;
        out item used_ITM_CMD_027 : I_ITM_CMD_027;
        in item used_ITM_CMD_001 : I_ITM_CMD_001;
        in item used_ITM_CMD_004 : I_ITM_CMD_004;
        out item used_ITM_CMD_029 : I_ITM_CMD_029;
        in item used_ITM_MEA_013 : I_ITM_MEA_013;
        out item used_ITM_CMD_025 : I_ITM_CMD_025;
        in item used_ITM_MEA_029 : I_ITM_MEA_029;
        in item used_ITM_CMD_030 : I_ITM_CMD_030;
        in item used_ITM_MEA_008 : I_ITM_MEA_008;
        in item used_ITM_CMD_003 : I_ITM_CMD_003;
        out item used_ITM_CMD_028 : I_ITM_CMD_028;
        in item used_ITM_MEA_001 : I_ITM_MEA_001;
        in item used_ITM_CMD_002 : I_ITM_CMD_002;
        in item used_ITM_MEA_028 : I_ITM_MEA_028;
        out item used_ITM_CMD_008 : I_ITM_CMD_008;
        out item used_ITM_CMD_026 : I_ITM_CMD_026;
    }
    action def FN_F_8122_02 {
        attribute functionId : String = "F-8122-02";
        attribute chineseName : String = "协调车辆控制单元接口交互";
        attribute englishName : String = "Coordinate Product 8122 interface interactions";
        attribute functionLevel : Integer = 4;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "8122";
        in item used_ITM_MEA_008 : I_ITM_MEA_008;
    }
    action def FN_F_8122_03 {
        attribute functionId : String = "F-8122-03";
        attribute chineseName : String = "限制并保护车辆控制单元运行";
        attribute englishName : String = "Limit and protect Product 8122 operation";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PROTECTION";
        attribute allocatedProductCode : String = "8122";
        in item used_ITM_LIM_004 : I_ITM_LIM_004;
        in item used_ITM_LIM_010 : I_ITM_LIM_010;
        in item used_ITM_LIM_005 : I_ITM_LIM_005;
        in item used_ITM_LIM_009 : I_ITM_LIM_009;
        in item used_ITM_LIM_001 : I_ITM_LIM_001;
    }
    action def FN_F_8122_04 {
        attribute functionId : String = "F-8122-04";
        attribute chineseName : String = "报告车辆控制单元运行状态";
        attribute englishName : String = "Report Product 8122 operating state";
        attribute functionLevel : Integer = 4;
        attribute category : String = "STATUS_REPORTING";
        attribute allocatedProductCode : String = "8122";
        in item used_ITM_STA_019 : I_ITM_STA_019;
        in item used_ITM_STA_031 : I_ITM_STA_031;
        in item used_ITM_STA_030 : I_ITM_STA_030;
        in item used_ITM_STA_002 : I_ITM_STA_002;
        in item used_ITM_STA_001 : I_ITM_STA_001;
        in item used_ITM_STA_003 : I_ITM_STA_003;
    }
    action def FN_F_8122_05 {
        attribute functionId : String = "F-8122-05";
        attribute chineseName : String = "统计车辆控制单元运行数据";
        attribute englishName : String = "Accumulate Product 8122 operating statistics";
        attribute functionLevel : Integer = 4;
        attribute category : String = "STATISTICS";
        attribute allocatedProductCode : String = "8122";
        in item used_ITM_ACC_005 : I_ITM_ACC_005;
        in item used_ITM_ACC_002 : I_ITM_ACC_002;
        in item used_ITM_ACC_015 : I_ITM_ACC_015;
        in item used_ITM_ACC_004 : I_ITM_ACC_004;
        in item used_ITM_ACC_003 : I_ITM_ACC_003;
    }
    action def FN_F_8125_01 {
        attribute functionId : String = "F-8125-01";
        attribute chineseName : String = "控制列车级牵引控制单元运行";
        attribute englishName : String = "Control Product 8125 operation";
        attribute functionLevel : Integer = 4;
        attribute category : String = "CONTROL";
        attribute allocatedProductCode : String = "8125";
        in item used_ITM_MEA_012 : I_ITM_MEA_012;
        in item used_ITM_CMD_002 : I_ITM_CMD_002;
        in item used_ITM_MEA_008 : I_ITM_MEA_008;
        in item used_ITM_CMD_006 : I_ITM_CMD_006;
        in item used_ITM_MEA_001 : I_ITM_MEA_001;
        out item used_ITM_CMD_012 : I_ITM_CMD_012;
        out item used_ITM_MEA_013 : I_ITM_MEA_013;
        in item used_ITM_CMD_009 : I_ITM_CMD_009;
        in item used_ITM_CMD_008 : I_ITM_CMD_008;
        in item used_ITM_MEA_004 : I_ITM_MEA_004;
    }
    action def FN_F_8125_02 {
        attribute functionId : String = "F-8125-02";
        attribute chineseName : String = "协调列车级牵引控制单元接口交互";
        attribute englishName : String = "Coordinate Product 8125 interface interactions";
        attribute functionLevel : Integer = 4;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "8125";
        in item used_ITM_MEA_008 : I_ITM_MEA_008;
    }
    action def FN_F_8125_03 {
        attribute functionId : String = "F-8125-03";
        attribute chineseName : String = "限制并保护列车级牵引控制单元运行";
        attribute englishName : String = "Limit and protect Product 8125 operation";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PROTECTION";
        attribute allocatedProductCode : String = "8125";
        in item used_ITM_LIM_005 : I_ITM_LIM_005;
        out item used_ITM_LIM_004 : I_ITM_LIM_004;
        out item used_ITM_LIM_003 : I_ITM_LIM_003;
        out item used_ITM_LIM_001 : I_ITM_LIM_001;
    }
    action def FN_F_8125_04 {
        attribute functionId : String = "F-8125-04";
        attribute chineseName : String = "报告列车级牵引控制单元运行状态";
        attribute englishName : String = "Report Product 8125 operating state";
        attribute functionLevel : Integer = 4;
        attribute category : String = "STATUS_REPORTING";
        attribute allocatedProductCode : String = "8125";
        in item used_ITM_STA_026 : I_ITM_STA_026;
        out item used_ITM_STA_019 : I_ITM_STA_019;
        out item used_ITM_STA_002 : I_ITM_STA_002;
        out item used_ITM_STA_001 : I_ITM_STA_001;
        out item used_ITM_STA_018 : I_ITM_STA_018;
        out item used_ITM_STA_017 : I_ITM_STA_017;
    }
    action def FN_F_8127_01 {
        attribute functionId : String = "F-8127-01";
        attribute chineseName : String = "路由ATP接口单元输入输出信号";
        attribute englishName : String = "Route input and output signals through Product 8127";
        attribute functionLevel : Integer = 4;
        attribute category : String = "CONTROL";
        attribute allocatedProductCode : String = "8127";
        out item used_ITM_CMD_030 : I_ITM_CMD_030;
    }
    action def FN_F_8127_02 {
        attribute functionId : String = "F-8127-02";
        attribute chineseName : String = "报告ATP接口单元运行状态";
        attribute englishName : String = "Report Product 8127 operating state";
        attribute functionLevel : Integer = 4;
        attribute category : String = "STATUS_REPORTING";
        attribute allocatedProductCode : String = "8127";
        out item used_ITM_STA_027 : I_ITM_STA_027;
    }
    action def FN_F_8128_01 {
        attribute functionId : String = "F-8128-01";
        attribute chineseName : String = "路由输入输出单元输入输出信号";
        attribute englishName : String = "Route input and output signals through Product 8128";
        attribute functionLevel : Integer = 4;
        attribute category : String = "CONTROL";
        attribute allocatedProductCode : String = "8128";
        out item used_ITM_MEA_016 : I_ITM_MEA_016;
        out item used_ITM_MEA_026 : I_ITM_MEA_026;
        in item used_ITM_MEA_014 : I_ITM_MEA_014;
        in item used_ITM_MEA_027 : I_ITM_MEA_027;
        out item used_ITM_CMD_024 : I_ITM_CMD_024;
        out item used_ITM_MEA_025 : I_ITM_MEA_025;
    }
    action def FN_F_8128_02 {
        attribute functionId : String = "F-8128-02";
        attribute chineseName : String = "协调输入输出单元接口交互";
        attribute englishName : String = "Coordinate Product 8128 interface interactions";
        attribute functionLevel : Integer = 4;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "8128";
        in item used_ITM_STA_027 : I_ITM_STA_027;
    }
    action def FN_F_8128_03 {
        attribute functionId : String = "F-8128-03";
        attribute chineseName : String = "报告输入输出单元运行状态";
        attribute englishName : String = "Report Product 8128 operating state";
        attribute functionLevel : Integer = 4;
        attribute category : String = "STATUS_REPORTING";
        attribute allocatedProductCode : String = "8128";
        in item used_ITM_STA_024 : I_ITM_STA_024;
        in item used_ITM_STA_027 : I_ITM_STA_027;
        in item used_ITM_STA_025 : I_ITM_STA_025;
        in item used_ITM_STA_026 : I_ITM_STA_026;
    }
    action def FN_F_8150_01 {
        attribute functionId : String = "F-8150-01";
        attribute chineseName : String = "执行安全控制、反馈运行状态";
        attribute englishName : String = "Execute safety control; Report status";
        attribute functionLevel : Integer = 3;
        attribute category : String = "SAFETY";
        attribute allocatedProductCode : String = "8150";
    }
    action def FN_F_8151_01 {
        attribute functionId : String = "F-8151-01";
        attribute chineseName : String = "执行高压安全回路安全逻辑";
        attribute englishName : String = "Execute Product 8151 safety logic";
        attribute functionLevel : Integer = 4;
        attribute category : String = "SAFETY";
        attribute allocatedProductCode : String = "8151";
        in item used_ITM_CMD_016 : I_ITM_CMD_016;
    }
    action def FN_F_8151_02 {
        attribute functionId : String = "F-8151-02";
        attribute chineseName : String = "报告高压安全回路运行状态";
        attribute englishName : String = "Report Product 8151 operating state";
        attribute functionLevel : Integer = 4;
        attribute category : String = "STATUS_REPORTING";
        attribute allocatedProductCode : String = "8151";
        out item used_ITM_STA_024 : I_ITM_STA_024;
    }
    action def FN_F_8152_01 {
        attribute functionId : String = "F-8152-01";
        attribute chineseName : String = "执行制动安全回路安全逻辑";
        attribute englishName : String = "Execute Product 8152 safety logic";
        attribute functionLevel : Integer = 4;
        attribute category : String = "SAFETY";
        attribute allocatedProductCode : String = "8152";
        in item used_ITM_CMD_004 : I_ITM_CMD_004;
        in item used_ITM_CMD_030 : I_ITM_CMD_030;
    }
    action def FN_F_8152_02 {
        attribute functionId : String = "F-8152-02";
        attribute chineseName : String = "报告制动安全回路运行状态";
        attribute englishName : String = "Report Product 8152 operating state";
        attribute functionLevel : Integer = 4;
        attribute category : String = "STATUS_REPORTING";
        attribute allocatedProductCode : String = "8152";
        out item used_ITM_STA_025 : I_ITM_STA_025;
    }
    action def FN_F_8154_01 {
        attribute functionId : String = "F-8154-01";
        attribute chineseName : String = "执行牵引安全回路安全逻辑";
        attribute englishName : String = "Execute Product 8154 safety logic";
        attribute functionLevel : Integer = 4;
        attribute category : String = "SAFETY";
        attribute allocatedProductCode : String = "8154";
        in item used_ITM_CMD_009 : I_ITM_CMD_009;
        in item used_ITM_CMD_008 : I_ITM_CMD_008;
    }
    action def FN_F_8154_02 {
        attribute functionId : String = "F-8154-02";
        attribute chineseName : String = "报告牵引安全回路运行状态";
        attribute englishName : String = "Report Product 8154 operating state";
        attribute functionLevel : Integer = 4;
        attribute category : String = "STATUS_REPORTING";
        attribute allocatedProductCode : String = "8154";
        out item used_ITM_STA_026 : I_ITM_STA_026;
    }
    action def FN_F_8160_01 {
        attribute functionId : String = "F-8160-01";
        attribute chineseName : String = "控制运行、反馈运行状态";
        attribute englishName : String = "Control operation; Report status";
        attribute functionLevel : Integer = 3;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "8160";
    }
    action def FN_F_8166_01 {
        attribute functionId : String = "F-8166-01";
        attribute chineseName : String = "控制能量计运行";
        attribute englishName : String = "Control Product 8166 operation";
        attribute functionLevel : Integer = 4;
        attribute category : String = "CONTROL";
        attribute allocatedProductCode : String = "8166";
        in item used_ITM_MEA_006 : I_ITM_MEA_006;
        in item used_ITM_MEA_009 : I_ITM_MEA_009;
        in item used_ITM_MEA_005 : I_ITM_MEA_005;
        in item used_ITM_MEA_008 : I_ITM_MEA_008;
    }
    action def FN_F_8166_02 {
        attribute functionId : String = "F-8166-02";
        attribute chineseName : String = "协调能量计接口交互";
        attribute englishName : String = "Coordinate Product 8166 interface interactions";
        attribute functionLevel : Integer = 4;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "8166";
        in item used_ITM_MEA_008 : I_ITM_MEA_008;
    }
    action def FN_F_8166_03 {
        attribute functionId : String = "F-8166-03";
        attribute chineseName : String = "报告能量计运行状态";
        attribute englishName : String = "Report Product 8166 operating state";
        attribute functionLevel : Integer = 4;
        attribute category : String = "STATUS_REPORTING";
        attribute allocatedProductCode : String = "8166";
        out item used_ITM_STA_035 : I_ITM_STA_035;
    }
    action def FN_F_8166_04 {
        attribute functionId : String = "F-8166-04";
        attribute chineseName : String = "统计能量计运行数据";
        attribute englishName : String = "Accumulate Product 8166 operating statistics";
        attribute functionLevel : Integer = 4;
        attribute category : String = "STATISTICS";
        attribute allocatedProductCode : String = "8166";
        out item used_ITM_ACC_012 : I_ITM_ACC_012;
        out item used_ITM_ACC_014 : I_ITM_ACC_014;
        out item used_ITM_ACC_005 : I_ITM_ACC_005;
        out item used_ITM_ACC_001 : I_ITM_ACC_001;
        out item used_ITM_ACC_011 : I_ITM_ACC_011;
        out item used_ITM_ACC_007 : I_ITM_ACC_007;
        out item used_ITM_ACC_015 : I_ITM_ACC_015;
        out item used_ITM_ACC_010 : I_ITM_ACC_010;
        out item used_ITM_ACC_009 : I_ITM_ACC_009;
        out item used_ITM_ACC_003 : I_ITM_ACC_003;
        out item used_ITM_ACC_008 : I_ITM_ACC_008;
        out item used_ITM_ACC_004 : I_ITM_ACC_004;
        out item used_ITM_ACC_002 : I_ITM_ACC_002;
    }
    action def FN_F_D000_01 {
        attribute functionId : String = "F-D000-01";
        attribute chineseName : String = "控制运行";
        attribute englishName : String = "Control operation";
        attribute functionLevel : Integer = 1;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "D000";
    }
    action def FN_F_D100_01 {
        attribute functionId : String = "F-D100-01";
        attribute chineseName : String = "控制运行";
        attribute englishName : String = "Control operation";
        attribute functionLevel : Integer = 2;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "D100";
    }
    action def FN_F_D110_01 {
        attribute functionId : String = "F-D110-01";
        attribute chineseName : String = "控制运行";
        attribute englishName : String = "Control operation";
        attribute functionLevel : Integer = 3;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "D110";
    }
    action def FN_F_D112_01 {
        attribute functionId : String = "F-D112-01";
        attribute chineseName : String = "提供方向操作元件边界交互";
        attribute englishName : String = "Provide boundary interaction for Product D112";
        attribute functionLevel : Integer = 4;
        attribute category : String = "CONTROL";
        attribute allocatedProductCode : String = "D112";
        out item used_ITM_CMD_001 : I_ITM_CMD_001;
    }
    action def FN_F_D113_01 {
        attribute functionId : String = "F-D113-01";
        attribute chineseName : String = "提供牵引操作元件边界交互";
        attribute englishName : String = "Provide boundary interaction for Product D113";
        attribute functionLevel : Integer = 4;
        attribute category : String = "CONTROL";
        attribute allocatedProductCode : String = "D113";
        out item used_ITM_CMD_002 : I_ITM_CMD_002;
    }
    action def FN_F_D114_01 {
        attribute functionId : String = "F-D114-01";
        attribute chineseName : String = "提供制动操作元件边界交互";
        attribute englishName : String = "Provide boundary interaction for Product D114";
        attribute functionLevel : Integer = 4;
        attribute category : String = "CONTROL";
        attribute allocatedProductCode : String = "D114";
        out item used_ITM_CMD_003 : I_ITM_CMD_003;
    }
    action def FN_F_D120_01 {
        attribute functionId : String = "F-D120-01";
        attribute chineseName : String = "控制运行";
        attribute englishName : String = "Control operation";
        attribute functionLevel : Integer = 3;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "D120";
    }
    action def FN_F_D121_01 {
        attribute functionId : String = "F-D121-01";
        attribute chineseName : String = "提供紧急制动按钮边界交互";
        attribute englishName : String = "Provide boundary interaction for Product D121";
        attribute functionLevel : Integer = 4;
        attribute category : String = "CONTROL";
        attribute allocatedProductCode : String = "D121";
        out item used_ITM_CMD_004 : I_ITM_CMD_004;
    }
    action def FN_F_D130_01 {
        attribute functionId : String = "F-D130-01";
        attribute chineseName : String = "控制运行";
        attribute englishName : String = "Control operation";
        attribute functionLevel : Integer = 3;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "D130";
    }
    action def FN_F_D13B_01 {
        attribute functionId : String = "F-D13B-01";
        attribute chineseName : String = "提供撒砂按钮边界交互";
        attribute englishName : String = "Provide boundary interaction for Product D13B";
        attribute functionLevel : Integer = 4;
        attribute category : String = "CONTROL";
        attribute allocatedProductCode : String = "D13B";
        out item used_ITM_CMD_024 : I_ITM_CMD_024;
    }
    action def FN_F_E000_01 {
        attribute functionId : String = "F-E000-01";
        attribute chineseName : String = "控制运行";
        attribute englishName : String = "Control operation";
        attribute functionLevel : Integer = 1;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "E000";
    }
    action def FN_F_E100_01 {
        attribute functionId : String = "F-E100-01";
        attribute chineseName : String = "提供ATP车载边界交互";
        attribute englishName : String = "Provide boundary interaction for Product E100";
        attribute functionLevel : Integer = 2;
        attribute category : String = "CONTROL";
        attribute allocatedProductCode : String = "E100";
        out item used_ITM_CMD_030 : I_ITM_CMD_030;
        out item used_ITM_STA_027 : I_ITM_STA_027;
    }
    action def FN_F_X000_01 {
        attribute functionId : String = "F-X000-01";
        attribute chineseName : String = "实现车载再生能量回收与利用";
        attribute englishName : String = "Provide onboard regenerative-energy recovery and reuse";
        attribute functionLevel : Integer = 1;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "X000";
    }
    action def FN_F_X100_01 {
        attribute functionId : String = "F-X100-01";
        attribute chineseName : String = "吸收、存储并按需释放再生制动能量";
        attribute englishName : String = "Absorb, store and release regenerative braking energy on demand";
        attribute functionLevel : Integer = 2;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "X100";
    }
    action def FN_F_X110_01 {
        attribute functionId : String = "F-X110-01";
        attribute chineseName : String = "实现再生储能双向能量变换、控制与保护";
        attribute englishName : String = "Provide bidirectional regenerative-storage conversion, control and protection";
        attribute functionLevel : Integer = 3;
        attribute category : String = "COORDINATION";
        attribute allocatedProductCode : String = "X110";
    }
    action def FN_F_X111_01 {
        attribute functionId : String = "F-X111-01";
        attribute chineseName : String = "实现中间直流母线与储能侧直流母线双向能量转换";
        attribute englishName : String = "Convert energy bidirectionally between DC link and storage DC bus";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PHYSICAL_TRANSFORMATION";
        attribute allocatedProductCode : String = "X111";
        inout item used_ITM_PHY_003 : I_ITM_PHY_003;
        inout item used_ITM_PHY_016 : I_ITM_PHY_016;
    }
    action def FN_F_X111_02 {
        attribute functionId : String = "F-X111-02";
        attribute chineseName : String = "执行双向DC/DC功率变换指令并反馈状态";
        attribute englishName : String = "Execute bidirectional DC/DC power commands and report state";
        attribute functionLevel : Integer = 4;
        attribute category : String = "CONTROL";
        attribute allocatedProductCode : String = "X111";
        out item used_ITM_STA_029 : I_ITM_STA_029;
        in item used_ITM_CMD_026 : I_ITM_CMD_026;
        in item used_ITM_CMD_025 : I_ITM_CMD_025;
        out item used_ITM_STA_028 : I_ITM_STA_028;
        out item used_ITM_MEA_030 : I_ITM_MEA_030;
        out item used_ITM_MEA_029 : I_ITM_MEA_029;
    }
    action def FN_F_X112_01 {
        attribute functionId : String = "F-X112-01";
        attribute chineseName : String = "控制双向DC/DC功率变换";
        attribute englishName : String = "Control bidirectional DC/DC power conversion";
        attribute functionLevel : Integer = 4;
        attribute category : String = "CONTROL";
        attribute allocatedProductCode : String = "X112";
        in item used_ITM_CMD_026 : I_ITM_CMD_026;
        out item used_ITM_CMD_028 : I_ITM_CMD_028;
        in item used_ITM_MEA_025 : I_ITM_MEA_025;
        in item used_ITM_MEA_026 : I_ITM_MEA_026;
        in item used_ITM_CMD_029 : I_ITM_CMD_029;
        in item used_ITM_MEA_029 : I_ITM_MEA_029;
        in item used_ITM_CMD_025 : I_ITM_CMD_025;
        out item used_ITM_CMD_027 : I_ITM_CMD_027;
        in item used_ITM_MEA_008 : I_ITM_MEA_008;
        in item used_ITM_MEA_030 : I_ITM_MEA_030;
        in item used_ITM_MEA_028 : I_ITM_MEA_028;
        in item used_ITM_MEA_027 : I_ITM_MEA_027;
    }
    action def FN_F_X112_02 {
        attribute functionId : String = "F-X112-02";
        attribute chineseName : String = "限制储能充放电功率并协调保护";
        attribute englishName : String = "Limit storage charge-discharge power and coordinate protection";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PROTECTION";
        attribute allocatedProductCode : String = "X112";
        out item used_ITM_LIM_011 : I_ITM_LIM_011;
        out item used_ITM_LIM_012 : I_ITM_LIM_012;
        out item used_ITM_LIM_010 : I_ITM_LIM_010;
        in item used_ITM_LIM_007 : I_ITM_LIM_007;
        out item used_ITM_LIM_009 : I_ITM_LIM_009;
    }
    action def FN_F_X112_03 {
        attribute functionId : String = "F-X112-03";
        attribute chineseName : String = "报告储能变换系统状态";
        attribute englishName : String = "Report energy-storage conversion system state";
        attribute functionLevel : Integer = 4;
        attribute category : String = "STATUS_REPORTING";
        attribute allocatedProductCode : String = "X112";
        out item used_ITM_STA_030 : I_ITM_STA_030;
        out item used_ITM_STA_028 : I_ITM_STA_028;
        in item used_ITM_STA_033 : I_ITM_STA_033;
        out item used_ITM_ACC_004 : I_ITM_ACC_004;
        in item used_ITM_STA_034 : I_ITM_STA_034;
        in item used_ITM_STA_032 : I_ITM_STA_032;
        out item used_ITM_STA_031 : I_ITM_STA_031;
        out item used_ITM_STA_029 : I_ITM_STA_029;
    }
    action def FN_F_X113_01 {
        attribute functionId : String = "F-X113-01";
        attribute chineseName : String = "检测双向DC/DC检测保护组件状态";
        attribute englishName : String = "Measure state at Product X113";
        attribute functionLevel : Integer = 4;
        attribute category : String = "MEASUREMENT";
        attribute allocatedProductCode : String = "X113";
        out item used_ITM_MEA_027 : I_ITM_MEA_027;
        out item used_ITM_MEA_025 : I_ITM_MEA_025;
        out item used_ITM_STA_031 : I_ITM_STA_031;
        out item used_ITM_LIM_010 : I_ITM_LIM_010;
        out item used_ITM_MEA_026 : I_ITM_MEA_026;
        out item used_ITM_MEA_008 : I_ITM_MEA_008;
        inout item used_ITM_PHY_016 : I_ITM_PHY_016;
        out item used_ITM_STA_034 : I_ITM_STA_034;
        out item used_ITM_LIM_007 : I_ITM_LIM_007;
        inout item used_ITM_PHY_003 : I_ITM_PHY_003;
        out item used_ITM_MEA_030 : I_ITM_MEA_030;
        out item used_ITM_LIM_009 : I_ITM_LIM_009;
        inout item used_ITM_PHY_015 : I_ITM_PHY_015;
        out item used_ITM_STA_029 : I_ITM_STA_029;
    }
    action def FN_F_X120_01 {
        attribute functionId : String = "F-X120-01";
        attribute chineseName : String = "储存与释放能量、检测运行参数";
        attribute englishName : String = "Store and release energy; Measure parameters";
        attribute functionLevel : Integer = 3;
        attribute category : String = "PHYSICAL_TRANSFORMATION";
        attribute allocatedProductCode : String = "X120";
    }
    action def FN_F_X121_01 {
        attribute functionId : String = "F-X121-01";
        attribute chineseName : String = "储存并按需释放再生制动电能";
        attribute englishName : String = "Store and release regenerative braking energy on demand";
        attribute functionLevel : Integer = 4;
        attribute category : String = "ENERGY_STORAGE";
        attribute allocatedProductCode : String = "X121";
        inout item used_ITM_PHY_016 : I_ITM_PHY_016;
        inout item used_ITM_PHY_013 : I_ITM_PHY_013;
    }
    action def FN_F_X121_02 {
        attribute functionId : String = "F-X121-02";
        attribute chineseName : String = "提供超级电容荷电状态反馈";
        attribute englishName : String = "Provide supercapacitor state-of-charge feedback";
        attribute functionLevel : Integer = 4;
        attribute category : String = "MEASUREMENT";
        attribute allocatedProductCode : String = "X121";
        out item used_ITM_MEA_028 : I_ITM_MEA_028;
    }
    action def FN_F_X122_01 {
        attribute functionId : String = "F-X122-01";
        attribute chineseName : String = "检测超级电容电压传感器状态";
        attribute englishName : String = "Measure state at Product X122";
        attribute functionLevel : Integer = 4;
        attribute category : String = "MEASUREMENT";
        attribute allocatedProductCode : String = "X122";
        out item used_ITM_MEA_025 : I_ITM_MEA_025;
        inout item used_ITM_PHY_016 : I_ITM_PHY_016;
    }
    action def FN_F_X123_01 {
        attribute functionId : String = "F-X123-01";
        attribute chineseName : String = "检测超级电容电流传感器状态";
        attribute englishName : String = "Measure state at Product X123";
        attribute functionLevel : Integer = 4;
        attribute category : String = "MEASUREMENT";
        attribute allocatedProductCode : String = "X123";
        out item used_ITM_MEA_026 : I_ITM_MEA_026;
        inout item used_ITM_PHY_016 : I_ITM_PHY_016;
    }
    action def FN_F_X124_01 {
        attribute functionId : String = "F-X124-01";
        attribute chineseName : String = "检测超级电容温度传感器状态";
        attribute englishName : String = "Measure state at Product X124";
        attribute functionLevel : Integer = 4;
        attribute category : String = "MEASUREMENT";
        attribute allocatedProductCode : String = "X124";
        inout item used_ITM_PHY_013 : I_ITM_PHY_013;
        out item used_ITM_MEA_027 : I_ITM_MEA_027;
    }
    action def FN_F_X130_01 {
        attribute functionId : String = "F-X130-01";
        attribute chineseName : String = "传递能量/介质";
        attribute englishName : String = "Transport energy/media";
        attribute functionLevel : Integer = 3;
        attribute category : String = "PHYSICAL_TRANSPORT";
        attribute allocatedProductCode : String = "X130";
    }
    action def FN_F_X131_01 {
        attribute functionId : String = "F-X131-01";
        attribute chineseName : String = "传递储能主接触器电能";
        attribute englishName : String = "Transmit electrical energy through Product X131";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PHYSICAL_TRANSPORT";
        attribute allocatedProductCode : String = "X131";
        inout item used_ITM_PHY_016 : I_ITM_PHY_016;
    }
    action def FN_F_X132_01 {
        attribute functionId : String = "F-X132-01";
        attribute chineseName : String = "传递储能预充电组件电能";
        attribute englishName : String = "Transmit electrical energy through Product X132";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PHYSICAL_TRANSPORT";
        attribute allocatedProductCode : String = "X132";
        inout item used_ITM_PHY_016 : I_ITM_PHY_016;
    }
    action def FN_F_X133_01 {
        attribute functionId : String = "F-X133-01";
        attribute chineseName : String = "传递储能支路保护组件电能";
        attribute englishName : String = "Transmit electrical energy through Product X133";
        attribute functionLevel : Integer = 4;
        attribute category : String = "PHYSICAL_TRANSPORT";
        attribute allocatedProductCode : String = "X133";
        inout item used_ITM_PHY_016 : I_ITM_PHY_016;
        inout item used_ITM_PHY_015 : I_ITM_PHY_015;
    }
}
