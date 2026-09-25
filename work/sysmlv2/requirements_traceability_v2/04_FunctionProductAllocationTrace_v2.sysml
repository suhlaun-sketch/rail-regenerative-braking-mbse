package FunctionProductAllocationTraceV2 {
    private import ScalarValues::*;

    item def FunctionOwnerAllocationReference {
        attribute functionId : String;
        attribute functionName : String;
        attribute ownerProductId : String;
        attribute ownerProductName : String;
        attribute allocationId : String;
        attribute evidence : String;
        attribute sourceFile : String;
    }

    item ownerTrace_001 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_3000_01";
        attribute :>> functionName = "转换能量/物理量、控制运行";
        attribute :>> ownerProductId = "3000";
        attribute :>> ownerProductName = "转向架及其辅助";
        attribute :>> allocationId = "alloc_ALLOC_F_3000_01_3000";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3000_01_3000 allocate fu_F_3000_01 to ap_N_3000;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_002 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_3100_01";
        attribute :>> functionName = "转换能量/物理量、传递能量/介质";
        attribute :>> ownerProductId = "3100";
        attribute :>> ownerProductName = "轮轴组成";
        attribute :>> allocationId = "alloc_ALLOC_F_3100_01_3100";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3100_01_3100 allocate fu_F_3100_01 to ap_N_3100;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_003 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_3110_01";
        attribute :>> functionName = "传递能量/介质、耗散能量";
        attribute :>> ownerProductId = "3110";
        attribute :>> ownerProductName = "车轮车轴";
        attribute :>> allocationId = "alloc_ALLOC_F_3110_01_3110";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3110_01_3110 allocate fu_F_3110_01 to ap_N_3110;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_004 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_3111_01";
        attribute :>> functionName = "通过车轮耗散能量";
        attribute :>> ownerProductId = "3111";
        attribute :>> ownerProductName = "车轮";
        attribute :>> allocationId = "alloc_ALLOC_F_3111_01_3111";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3111_01_3111 allocate fu_F_3111_01 to ap_N_3111;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_005 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_3112_01";
        attribute :>> functionName = "传递车轴机械能";
        attribute :>> ownerProductId = "3112";
        attribute :>> ownerProductName = "车轴";
        attribute :>> allocationId = "alloc_ALLOC_F_3112_01_3112";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3112_01_3112 allocate fu_F_3112_01 to ap_N_3112;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_006 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_3120_01";
        attribute :>> functionName = "转换能量/物理量";
        attribute :>> ownerProductId = "3120";
        attribute :>> ownerProductName = "齿轮箱及附件";
        attribute :>> allocationId = "alloc_ALLOC_F_3120_01_3120";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3120_01_3120 allocate fu_F_3120_01 to ap_N_3120;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_007 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_3121_01";
        attribute :>> functionName = "转换齿轮箱主体机械参数";
        attribute :>> ownerProductId = "3121";
        attribute :>> ownerProductName = "齿轮箱主体";
        attribute :>> allocationId = "alloc_ALLOC_F_3121_01_3121";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3121_01_3121 allocate fu_F_3121_01 to ap_N_3121;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_008 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_3130_01";
        attribute :>> functionName = "耗散能量";
        attribute :>> ownerProductId = "3130";
        attribute :>> ownerProductName = "制动盘";
        attribute :>> allocationId = "alloc_ALLOC_F_3130_01_3130";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3130_01_3130 allocate fu_F_3130_01 to ap_N_3130;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_009 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_3131_01";
        attribute :>> functionName = "通过外轮盘耗散机械制动能量";
        attribute :>> ownerProductId = "3131";
        attribute :>> ownerProductName = "外轮盘";
        attribute :>> allocationId = "alloc_ALLOC_F_3131_01_3131";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3131_01_3131 allocate fu_F_3131_01 to ap_N_3131;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_010 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_3132_01";
        attribute :>> functionName = "通过内轮盘耗散能量";
        attribute :>> ownerProductId = "3132";
        attribute :>> ownerProductName = "内轮盘";
        attribute :>> allocationId = "alloc_ALLOC_F_3132_01_3132";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3132_01_3132 allocate fu_F_3132_01 to ap_N_3132;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_011 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_3133_01";
        attribute :>> functionName = "通过轴盘耗散能量";
        attribute :>> ownerProductId = "3133";
        attribute :>> ownerProductName = "轴盘";
        attribute :>> allocationId = "alloc_ALLOC_F_3133_01_3133";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3133_01_3133 allocate fu_F_3133_01 to ap_N_3133;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_012 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_3500_01";
        attribute :>> functionName = "传递能量/介质";
        attribute :>> ownerProductId = "3500";
        attribute :>> ownerProductName = "牵引传动耦合组件及其附件";
        attribute :>> allocationId = "alloc_ALLOC_F_3500_01_3500";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3500_01_3500 allocate fu_F_3500_01 to ap_N_3500;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_013 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_3510_01";
        attribute :>> functionName = "传递能量/介质";
        attribute :>> ownerProductId = "3510";
        attribute :>> ownerProductName = "传动耦合机构";
        attribute :>> allocationId = "alloc_ALLOC_F_3510_01_3510";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3510_01_3510 allocate fu_F_3510_01 to ap_N_3510;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_014 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_3511_01";
        attribute :>> functionName = "传递联轴节(电机侧)机械能";
        attribute :>> ownerProductId = "3511";
        attribute :>> ownerProductName = "联轴节(电机侧)";
        attribute :>> allocationId = "alloc_ALLOC_F_3511_01_3511";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3511_01_3511 allocate fu_F_3511_01 to ap_N_3511;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_015 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_3512_01";
        attribute :>> functionName = "传递联轴节(齿轮箱侧)机械能";
        attribute :>> ownerProductId = "3512";
        attribute :>> ownerProductName = "联轴节(齿轮箱侧)";
        attribute :>> allocationId = "alloc_ALLOC_F_3512_01_3512";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3512_01_3512 allocate fu_F_3512_01 to ap_N_3512;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_016 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_3514_01";
        attribute :>> functionName = "传递万向轴机械能";
        attribute :>> ownerProductId = "3514";
        attribute :>> ownerProductName = "万向轴";
        attribute :>> allocationId = "alloc_ALLOC_F_3514_01_3514";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3514_01_3514 allocate fu_F_3514_01 to ap_N_3514;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_017 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_3600_01";
        attribute :>> functionName = "检测运行参数";
        attribute :>> ownerProductId = "3600";
        attribute :>> ownerProductName = "转向架相关检测";
        attribute :>> allocationId = "alloc_ALLOC_F_3600_01_3600";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3600_01_3600 allocate fu_F_3600_01 to ap_N_3600;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_018 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_3640_01";
        attribute :>> functionName = "检测运行参数";
        attribute :>> ownerProductId = "3640";
        attribute :>> ownerProductName = "速度检测组件";
        attribute :>> allocationId = "alloc_ALLOC_F_3640_01_3640";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3640_01_3640 allocate fu_F_3640_01 to ap_N_3640;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_019 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_3641_01";
        attribute :>> functionName = "检测轴端速度传感器状态";
        attribute :>> ownerProductId = "3641";
        attribute :>> ownerProductName = "轴端速度传感器";
        attribute :>> allocationId = "alloc_ALLOC_F_3641_01_3641";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3641_01_3641 allocate fu_F_3641_01 to ap_N_3641;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_020 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_3643_01";
        attribute :>> functionName = "检测齿轮箱速度传感器状态";
        attribute :>> ownerProductId = "3643";
        attribute :>> ownerProductName = "齿轮箱速度传感器";
        attribute :>> allocationId = "alloc_ALLOC_F_3643_01_3643";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3643_01_3643 allocate fu_F_3643_01 to ap_N_3643;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_021 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_3644_01";
        attribute :>> functionName = "检测牵引电机速度传感器状态";
        attribute :>> ownerProductId = "3644";
        attribute :>> ownerProductName = "牵引电机速度传感器";
        attribute :>> allocationId = "alloc_ALLOC_F_3644_01_3644";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3644_01_3644 allocate fu_F_3644_01 to ap_N_3644;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_022 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_3800_01";
        attribute :>> functionName = "转换能量/物理量、控制运行";
        attribute :>> ownerProductId = "3800";
        attribute :>> ownerProductName = "辅助增粘及轮缘润滑";
        attribute :>> allocationId = "alloc_ALLOC_F_3800_01_3800";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3800_01_3800 allocate fu_F_3800_01 to ap_N_3800;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_023 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_3810_01";
        attribute :>> functionName = "转换能量/物理量、控制运行";
        attribute :>> ownerProductId = "3810";
        attribute :>> ownerProductName = "撒砂装置";
        attribute :>> allocationId = "alloc_ALLOC_F_3810_01_3810";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3810_01_3810 allocate fu_F_3810_01 to ap_N_3810;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_024 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_3811_01";
        attribute :>> functionName = "控制撒砂控制单元运行";
        attribute :>> ownerProductId = "3811";
        attribute :>> ownerProductName = "撒砂控制单元";
        attribute :>> allocationId = "alloc_ALLOC_F_3811_01_3811";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3811_01_3811 allocate fu_F_3811_01 to ap_N_3811;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_025 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_3811_02";
        attribute :>> functionName = "报告撒砂控制单元运行状态";
        attribute :>> ownerProductId = "3811";
        attribute :>> ownerProductName = "撒砂控制单元";
        attribute :>> allocationId = "alloc_ALLOC_F_3811_02_3811";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3811_02_3811 allocate fu_F_3811_02 to ap_N_3811;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_026 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_3813_01";
        attribute :>> functionName = "执行撒砂阀板组件动作";
        attribute :>> ownerProductId = "3813";
        attribute :>> ownerProductName = "撒砂阀板组件";
        attribute :>> allocationId = "alloc_ALLOC_F_3813_01_3813";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3813_01_3813 allocate fu_F_3813_01 to ap_N_3813;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_027 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_3814_01";
        attribute :>> functionName = "执行撒砂喷嘴组件动作";
        attribute :>> ownerProductId = "3814";
        attribute :>> ownerProductName = "撒砂喷嘴组件";
        attribute :>> allocationId = "alloc_ALLOC_F_3814_01_3814";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3814_01_3814 allocate fu_F_3814_01 to ap_N_3814;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_028 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_4000_01";
        attribute :>> functionName = "转换能量/物理量、控制运行";
        attribute :>> ownerProductId = "4000";
        attribute :>> ownerProductName = "主供电";
        attribute :>> allocationId = "alloc_ALLOC_F_4000_01_4000";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4000_01_4000 allocate fu_F_4000_01 to ap_N_4000;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_029 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_4100_01";
        attribute :>> functionName = "传递能量/介质、控制运行";
        attribute :>> ownerProductId = "4100";
        attribute :>> ownerProductName = "高压受流";
        attribute :>> allocationId = "alloc_ALLOC_F_4100_01_4100";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4100_01_4100 allocate fu_F_4100_01 to ap_N_4100;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_030 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_4110_01";
        attribute :>> functionName = "传递能量/介质、控制运行";
        attribute :>> ownerProductId = "4110";
        attribute :>> ownerProductName = "受电弓总成";
        attribute :>> allocationId = "alloc_ALLOC_F_4110_01_4110";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4110_01_4110 allocate fu_F_4110_01 to ap_N_4110;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_031 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_4111_01";
        attribute :>> functionName = "传递碳滑板电能";
        attribute :>> ownerProductId = "4111";
        attribute :>> ownerProductName = "碳滑板";
        attribute :>> allocationId = "alloc_ALLOC_F_4111_01_4111";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4111_01_4111 allocate fu_F_4111_01 to ap_N_4111;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_032 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_411C_01";
        attribute :>> functionName = "控制受电弓电子控制单元运行";
        attribute :>> ownerProductId = "411C";
        attribute :>> ownerProductName = "受电弓电子控制单元";
        attribute :>> allocationId = "alloc_ALLOC_F_411C_01_411C";
        attribute :>> evidence = "allocation alloc_ALLOC_F_411C_01_411C allocate fu_F_411C_01 to ap_N_411C;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_033 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_411C_02";
        attribute :>> functionName = "报告受电弓电子控制单元运行状态";
        attribute :>> ownerProductId = "411C";
        attribute :>> ownerProductName = "受电弓电子控制单元";
        attribute :>> allocationId = "alloc_ALLOC_F_411C_02_411C";
        attribute :>> evidence = "allocation alloc_ALLOC_F_411C_02_411C allocate fu_F_411C_02 to ap_N_411C;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_034 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_4200_01";
        attribute :>> functionName = "传递能量/介质、控制运行";
        attribute :>> ownerProductId = "4200";
        attribute :>> ownerProductName = "网侧高压分配及控制";
        attribute :>> allocationId = "alloc_ALLOC_F_4200_01_4200";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4200_01_4200 allocate fu_F_4200_01 to ap_N_4200;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_035 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_4210_01";
        attribute :>> functionName = "传递能量/介质";
        attribute :>> ownerProductId = "4210";
        attribute :>> ownerProductName = "高压开关";
        attribute :>> allocationId = "alloc_ALLOC_F_4210_01_4210";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4210_01_4210 allocate fu_F_4210_01 to ap_N_4210;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_036 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_4211_01";
        attribute :>> functionName = "传递真空断路器电能";
        attribute :>> ownerProductId = "4211";
        attribute :>> ownerProductName = "真空断路器";
        attribute :>> allocationId = "alloc_ALLOC_F_4211_01_4211";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4211_01_4211 allocate fu_F_4211_01 to ap_N_4211;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_037 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_4212_01";
        attribute :>> functionName = "传递非真空隔离开关电能";
        attribute :>> ownerProductId = "4212";
        attribute :>> ownerProductName = "非真空隔离开关";
        attribute :>> allocationId = "alloc_ALLOC_F_4212_01_4212";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4212_01_4212 allocate fu_F_4212_01 to ap_N_4212;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_038 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_4230_01";
        attribute :>> functionName = "控制运行、检测运行参数";
        attribute :>> ownerProductId = "4230";
        attribute :>> ownerProductName = "高压保护及检测部件";
        attribute :>> allocationId = "alloc_ALLOC_F_4230_01_4230";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4230_01_4230 allocate fu_F_4230_01 to ap_N_4230;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_039 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_4235_01";
        attribute :>> functionName = "检测高压电压互感器状态";
        attribute :>> ownerProductId = "4235";
        attribute :>> ownerProductName = "高压电压互感器";
        attribute :>> allocationId = "alloc_ALLOC_F_4235_01_4235";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4235_01_4235 allocate fu_F_4235_01 to ap_N_4235;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_040 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_4236_01";
        attribute :>> functionName = "检测并贯通高压电流互感器物理量";
        attribute :>> ownerProductId = "4236";
        attribute :>> ownerProductName = "高压电流互感器";
        attribute :>> allocationId = "alloc_ALLOC_F_4236_01_4236";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4236_01_4236 allocate fu_F_4236_01 to ap_N_4236;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_041 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_4238_01";
        attribute :>> functionName = "路由高压控制输入输出单元输入输出信号";
        attribute :>> ownerProductId = "4238";
        attribute :>> ownerProductName = "高压控制输入输出单元";
        attribute :>> allocationId = "alloc_ALLOC_F_4238_01_4238";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4238_01_4238 allocate fu_F_4238_01 to ap_N_4238;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_042 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_4238_02";
        attribute :>> functionName = "协调高压控制输入输出单元接口交互";
        attribute :>> ownerProductId = "4238";
        attribute :>> ownerProductName = "高压控制输入输出单元";
        attribute :>> allocationId = "alloc_ALLOC_F_4238_02_4238";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4238_02_4238 allocate fu_F_4238_02 to ap_N_4238;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_043 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_4238_03";
        attribute :>> functionName = "报告高压控制输入输出单元运行状态";
        attribute :>> ownerProductId = "4238";
        attribute :>> ownerProductName = "高压控制输入输出单元";
        attribute :>> allocationId = "alloc_ALLOC_F_4238_03_4238";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4238_03_4238 allocate fu_F_4238_03 to ap_N_4238;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_044 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_4239_01";
        attribute :>> functionName = "控制高压控制单元运行";
        attribute :>> ownerProductId = "4239";
        attribute :>> ownerProductName = "高压控制单元";
        attribute :>> allocationId = "alloc_ALLOC_F_4239_01_4239";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4239_01_4239 allocate fu_F_4239_01 to ap_N_4239;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_045 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_4239_02";
        attribute :>> functionName = "协调高压控制单元接口交互";
        attribute :>> ownerProductId = "4239";
        attribute :>> ownerProductName = "高压控制单元";
        attribute :>> allocationId = "alloc_ALLOC_F_4239_02_4239";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4239_02_4239 allocate fu_F_4239_02 to ap_N_4239;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_046 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_4239_03";
        attribute :>> functionName = "报告高压控制单元运行状态";
        attribute :>> ownerProductId = "4239";
        attribute :>> ownerProductName = "高压控制单元";
        attribute :>> allocationId = "alloc_ALLOC_F_4239_03_4239";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4239_03_4239 allocate fu_F_4239_03 to ap_N_4239;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_047 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_4240_01";
        attribute :>> functionName = "控制运行、反馈运行状态";
        attribute :>> ownerProductId = "4240";
        attribute :>> ownerProductName = "能量测量";
        attribute :>> allocationId = "alloc_ALLOC_F_4240_01_4240";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4240_01_4240 allocate fu_F_4240_01 to ap_N_4240;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_048 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_4241_01";
        attribute :>> functionName = "控制处理单元运行";
        attribute :>> ownerProductId = "4241";
        attribute :>> ownerProductName = "处理单元";
        attribute :>> allocationId = "alloc_ALLOC_F_4241_01_4241";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4241_01_4241 allocate fu_F_4241_01 to ap_N_4241;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_049 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_4241_02";
        attribute :>> functionName = "报告处理单元运行状态";
        attribute :>> ownerProductId = "4241";
        attribute :>> ownerProductName = "处理单元";
        attribute :>> allocationId = "alloc_ALLOC_F_4241_02_4241";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4241_02_4241 allocate fu_F_4241_02 to ap_N_4241;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_050 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_4241_03";
        attribute :>> functionName = "统计处理单元运行数据";
        attribute :>> ownerProductId = "4241";
        attribute :>> ownerProductName = "处理单元";
        attribute :>> allocationId = "alloc_ALLOC_F_4241_03_4241";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4241_03_4241 allocate fu_F_4241_03 to ap_N_4241;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_051 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_4400_01";
        attribute :>> functionName = "传递能量/介质";
        attribute :>> ownerProductId = "4400";
        attribute :>> ownerProductName = "回流及接地";
        attribute :>> allocationId = "alloc_ALLOC_F_4400_01_4400";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4400_01_4400 allocate fu_F_4400_01 to ap_N_4400;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_052 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_4410_01";
        attribute :>> functionName = "传递能量/介质";
        attribute :>> ownerProductId = "4410";
        attribute :>> ownerProductName = "主回路回流设备";
        attribute :>> allocationId = "alloc_ALLOC_F_4410_01_4410";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4410_01_4410 allocate fu_F_4410_01 to ap_N_4410;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_053 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_4411_01";
        attribute :>> functionName = "传递接地变压器物理能量";
        attribute :>> ownerProductId = "4411";
        attribute :>> ownerProductName = "接地变压器";
        attribute :>> allocationId = "alloc_ALLOC_F_4411_01_4411";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4411_01_4411 allocate fu_F_4411_01 to ap_N_4411;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_054 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_4412_01";
        attribute :>> functionName = "传递主回路接地电阻物理能量";
        attribute :>> ownerProductId = "4412";
        attribute :>> ownerProductName = "主回路接地电阻";
        attribute :>> allocationId = "alloc_ALLOC_F_4412_01_4412";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4412_01_4412 allocate fu_F_4412_01 to ap_N_4412;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_055 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_4413_01";
        attribute :>> functionName = "传递回流碳刷电能";
        attribute :>> ownerProductId = "4413";
        attribute :>> ownerProductName = "回流碳刷";
        attribute :>> allocationId = "alloc_ALLOC_F_4413_01_4413";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4413_01_4413 allocate fu_F_4413_01 to ap_N_4413;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_056 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_4500_01";
        attribute :>> functionName = "转换能量/物理量、控制运行";
        attribute :>> ownerProductId = "4500";
        attribute :>> ownerProductName = "主变压器及其冷却";
        attribute :>> allocationId = "alloc_ALLOC_F_4500_01_4500";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4500_01_4500 allocate fu_F_4500_01 to ap_N_4500;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_057 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_4510_01";
        attribute :>> functionName = "转换能量/物理量、控制运行";
        attribute :>> ownerProductId = "4510";
        attribute :>> ownerProductName = "主变压器主体及其控制";
        attribute :>> allocationId = "alloc_ALLOC_F_4510_01_4510";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4510_01_4510 allocate fu_F_4510_01 to ap_N_4510;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_058 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_4511_01";
        attribute :>> functionName = "实现高压交流电能与牵引变压器次级交流电能转换";
        attribute :>> ownerProductId = "4511";
        attribute :>> ownerProductName = "主变压器主体";
        attribute :>> allocationId = "alloc_ALLOC_F_4511_01_4511";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4511_01_4511 allocate fu_F_4511_01 to ap_N_4511;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_059 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_4513_01";
        attribute :>> functionName = "传递电抗器电能";
        attribute :>> ownerProductId = "4513";
        attribute :>> ownerProductName = "电抗器";
        attribute :>> allocationId = "alloc_ALLOC_F_4513_01_4513";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4513_01_4513 allocate fu_F_4513_01 to ap_N_4513;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_060 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_4517_01";
        attribute :>> functionName = "检测主变压器检测及保护元件状态";
        attribute :>> ownerProductId = "4517";
        attribute :>> ownerProductName = "主变压器检测及保护元件";
        attribute :>> allocationId = "alloc_ALLOC_F_4517_01_4517";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4517_01_4517 allocate fu_F_4517_01 to ap_N_4517;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_061 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_4518_01";
        attribute :>> functionName = "控制主变压器控制装置运行";
        attribute :>> ownerProductId = "4518";
        attribute :>> ownerProductName = "主变压器控制装置";
        attribute :>> allocationId = "alloc_ALLOC_F_4518_01_4518";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4518_01_4518 allocate fu_F_4518_01 to ap_N_4518;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_062 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_4518_02";
        attribute :>> functionName = "报告主变压器控制装置运行状态";
        attribute :>> ownerProductId = "4518";
        attribute :>> ownerProductName = "主变压器控制装置";
        attribute :>> allocationId = "alloc_ALLOC_F_4518_02_4518";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4518_02_4518 allocate fu_F_4518_02 to ap_N_4518;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_063 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_5000_01";
        attribute :>> functionName = "转换能量/物理量、控制运行";
        attribute :>> ownerProductId = "5000";
        attribute :>> ownerProductName = "牵引";
        attribute :>> allocationId = "alloc_ALLOC_F_5000_01_5000";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5000_01_5000 allocate fu_F_5000_01 to ap_N_5000;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_064 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_5100_01";
        attribute :>> functionName = "转换能量/物理量、控制运行";
        attribute :>> ownerProductId = "5100";
        attribute :>> ownerProductName = "牵引变流器主体及其控制";
        attribute :>> allocationId = "alloc_ALLOC_F_5100_01_5100";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5100_01_5100 allocate fu_F_5100_01 to ap_N_5100;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_065 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_5110_01";
        attribute :>> functionName = "控制运行、检测运行参数";
        attribute :>> ownerProductId = "5110";
        attribute :>> ownerProductName = "牵引变流器控制";
        attribute :>> allocationId = "alloc_ALLOC_F_5110_01_5110";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5110_01_5110 allocate fu_F_5110_01 to ap_N_5110;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_066 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_5111_01";
        attribute :>> functionName = "控制网侧变流器控制模块运行";
        attribute :>> ownerProductId = "5111";
        attribute :>> ownerProductName = "网侧变流器控制模块";
        attribute :>> allocationId = "alloc_ALLOC_F_5111_01_5111";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5111_01_5111 allocate fu_F_5111_01 to ap_N_5111;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_067 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_5111_02";
        attribute :>> functionName = "协调网侧变流器控制模块接口交互";
        attribute :>> ownerProductId = "5111";
        attribute :>> ownerProductName = "网侧变流器控制模块";
        attribute :>> allocationId = "alloc_ALLOC_F_5111_02_5111";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5111_02_5111 allocate fu_F_5111_02 to ap_N_5111;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_068 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_5111_03";
        attribute :>> functionName = "限制并保护网侧变流器控制模块运行";
        attribute :>> ownerProductId = "5111";
        attribute :>> ownerProductName = "网侧变流器控制模块";
        attribute :>> allocationId = "alloc_ALLOC_F_5111_03_5111";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5111_03_5111 allocate fu_F_5111_03 to ap_N_5111;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_069 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_5111_04";
        attribute :>> functionName = "报告网侧变流器控制模块运行状态";
        attribute :>> ownerProductId = "5111";
        attribute :>> ownerProductName = "网侧变流器控制模块";
        attribute :>> allocationId = "alloc_ALLOC_F_5111_04_5111";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5111_04_5111 allocate fu_F_5111_04 to ap_N_5111;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_070 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_5112_01";
        attribute :>> functionName = "控制电机侧变流器控制模块运行";
        attribute :>> ownerProductId = "5112";
        attribute :>> ownerProductName = "电机侧变流器控制模块";
        attribute :>> allocationId = "alloc_ALLOC_F_5112_01_5112";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5112_01_5112 allocate fu_F_5112_01 to ap_N_5112;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_071 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_5112_02";
        attribute :>> functionName = "协调电机侧变流器控制模块接口交互";
        attribute :>> ownerProductId = "5112";
        attribute :>> ownerProductName = "电机侧变流器控制模块";
        attribute :>> allocationId = "alloc_ALLOC_F_5112_02_5112";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5112_02_5112 allocate fu_F_5112_02 to ap_N_5112;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_072 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_5112_03";
        attribute :>> functionName = "限制并保护电机侧变流器控制模块运行";
        attribute :>> ownerProductId = "5112";
        attribute :>> ownerProductName = "电机侧变流器控制模块";
        attribute :>> allocationId = "alloc_ALLOC_F_5112_03_5112";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5112_03_5112 allocate fu_F_5112_03 to ap_N_5112;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_073 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_5112_04";
        attribute :>> functionName = "报告电机侧变流器控制模块运行状态";
        attribute :>> ownerProductId = "5112";
        attribute :>> ownerProductName = "电机侧变流器控制模块";
        attribute :>> allocationId = "alloc_ALLOC_F_5112_04_5112";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5112_04_5112 allocate fu_F_5112_04 to ap_N_5112;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_074 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_5113_01";
        attribute :>> functionName = "检测变流器检测保护组件状态";
        attribute :>> ownerProductId = "5113";
        attribute :>> ownerProductName = "变流器检测保护组件";
        attribute :>> allocationId = "alloc_ALLOC_F_5113_01_5113";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5113_01_5113 allocate fu_F_5113_01 to ap_N_5113;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_075 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_5120_01";
        attribute :>> functionName = "传递能量/介质";
        attribute :>> ownerProductId = "5120";
        attribute :>> ownerProductName = "输入及预充电单元";
        attribute :>> allocationId = "alloc_ALLOC_F_5120_01_5120";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5120_01_5120 allocate fu_F_5120_01 to ap_N_5120;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_076 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_5121_01";
        attribute :>> functionName = "传递预充电组件电能";
        attribute :>> ownerProductId = "5121";
        attribute :>> ownerProductName = "预充电组件";
        attribute :>> allocationId = "alloc_ALLOC_F_5121_01_5121";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5121_01_5121 allocate fu_F_5121_01 to ap_N_5121;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_077 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_5122_01";
        attribute :>> functionName = "传递输入组件电能";
        attribute :>> ownerProductId = "5122";
        attribute :>> ownerProductName = "输入组件";
        attribute :>> allocationId = "alloc_ALLOC_F_5122_01_5122";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5122_01_5122 allocate fu_F_5122_01 to ap_N_5122;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_078 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_5130_01";
        attribute :>> functionName = "转换能量/物理量、控制运行";
        attribute :>> ownerProductId = "5130";
        attribute :>> ownerProductName = "变流模块";
        attribute :>> allocationId = "alloc_ALLOC_F_5130_01_5130";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5130_01_5130 allocate fu_F_5130_01 to ap_N_5130;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_079 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_5131_01";
        attribute :>> functionName = "实现主变次级交流电能与中间直流电能双向转换";
        attribute :>> ownerProductId = "5131";
        attribute :>> ownerProductName = "网侧变流模块";
        attribute :>> allocationId = "alloc_ALLOC_F_5131_01_5131";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5131_01_5131 allocate fu_F_5131_01 to ap_N_5131;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_080 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_5131_02";
        attribute :>> functionName = "执行网侧变流控制并反馈运行状态";
        attribute :>> ownerProductId = "5131";
        attribute :>> ownerProductName = "网侧变流模块";
        attribute :>> allocationId = "alloc_ALLOC_F_5131_02_5131";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5131_02_5131 allocate fu_F_5131_02 to ap_N_5131;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_081 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_5132_01";
        attribute :>> functionName = "实现中间直流电能与电机侧三相交流电能双向转换";
        attribute :>> ownerProductId = "5132";
        attribute :>> ownerProductName = "电机侧变流模块";
        attribute :>> allocationId = "alloc_ALLOC_F_5132_01_5132";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5132_01_5132 allocate fu_F_5132_01 to ap_N_5132;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_082 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_5132_02";
        attribute :>> functionName = "响应电机侧变流控制并反馈运行状态";
        attribute :>> ownerProductId = "5132";
        attribute :>> ownerProductName = "电机侧变流模块";
        attribute :>> allocationId = "alloc_ALLOC_F_5132_02_5132";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5132_02_5132 allocate fu_F_5132_02 to ap_N_5132;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_083 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_5133_01";
        attribute :>> functionName = "控制放电电阻控制模块运行";
        attribute :>> ownerProductId = "5133";
        attribute :>> ownerProductName = "放电电阻控制模块";
        attribute :>> allocationId = "alloc_ALLOC_F_5133_01_5133";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5133_01_5133 allocate fu_F_5133_01 to ap_N_5133;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_084 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_5133_02";
        attribute :>> functionName = "限制并保护放电电阻控制模块运行";
        attribute :>> ownerProductId = "5133";
        attribute :>> ownerProductName = "放电电阻控制模块";
        attribute :>> allocationId = "alloc_ALLOC_F_5133_02_5133";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5133_02_5133 allocate fu_F_5133_02 to ap_N_5133;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_085 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_5133_03";
        attribute :>> functionName = "报告放电电阻控制模块运行状态";
        attribute :>> ownerProductId = "5133";
        attribute :>> ownerProductName = "放电电阻控制模块";
        attribute :>> allocationId = "alloc_ALLOC_F_5133_03_5133";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5133_03_5133 allocate fu_F_5133_03 to ap_N_5133;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_086 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_5140_01";
        attribute :>> functionName = "耗散能量、检测运行参数";
        attribute :>> ownerProductId = "5140";
        attribute :>> ownerProductName = "中间直流环节组件及其";
        attribute :>> allocationId = "alloc_ALLOC_F_5140_01_5140";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5140_01_5140 allocate fu_F_5140_01 to ap_N_5140;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_087 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_5142_01";
        attribute :>> functionName = "通过放电电阻器耗散能量";
        attribute :>> ownerProductId = "5142";
        attribute :>> ownerProductName = "放电电阻器";
        attribute :>> allocationId = "alloc_ALLOC_F_5142_01_5142";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5142_01_5142 allocate fu_F_5142_01 to ap_N_5142;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_088 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_5142_02";
        attribute :>> functionName = "统计放电电阻器运行数据";
        attribute :>> ownerProductId = "5142";
        attribute :>> ownerProductName = "放电电阻器";
        attribute :>> allocationId = "alloc_ALLOC_F_5142_02_5142";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5142_02_5142 allocate fu_F_5142_02 to ap_N_5142;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_089 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_5145_01";
        attribute :>> functionName = "检测中间直流环节检测保护组件状态";
        attribute :>> ownerProductId = "5145";
        attribute :>> ownerProductName = "中间直流环节检测保护组件";
        attribute :>> allocationId = "alloc_ALLOC_F_5145_01_5145";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5145_01_5145 allocate fu_F_5145_01 to ap_N_5145;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_090 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_5300_01";
        attribute :>> functionName = "转换能量/物理量、检测运行参数";
        attribute :>> ownerProductId = "5300";
        attribute :>> ownerProductName = "牵引电机及其冷却";
        attribute :>> allocationId = "alloc_ALLOC_F_5300_01_5300";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5300_01_5300 allocate fu_F_5300_01 to ap_N_5300;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_091 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_5310_01";
        attribute :>> functionName = "转换能量/物理量、检测运行参数";
        attribute :>> ownerProductId = "5310";
        attribute :>> ownerProductName = "牵引电机组成";
        attribute :>> allocationId = "alloc_ALLOC_F_5310_01_5310";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5310_01_5310 allocate fu_F_5310_01 to ap_N_5310;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_092 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_5311_01";
        attribute :>> functionName = "实现三相交流电能与旋转机械能双向转换";
        attribute :>> ownerProductId = "5311";
        attribute :>> ownerProductName = "牵引电机";
        attribute :>> allocationId = "alloc_ALLOC_F_5311_01_5311";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5311_01_5311 allocate fu_F_5311_01 to ap_N_5311;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_093 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_5311_02";
        attribute :>> functionName = "提供牵引电机转速、转矩及电气状态反馈";
        attribute :>> ownerProductId = "5311";
        attribute :>> ownerProductName = "牵引电机";
        attribute :>> allocationId = "alloc_ALLOC_F_5311_02_5311";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5311_02_5311 allocate fu_F_5311_02 to ap_N_5311;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_094 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_7000_01";
        attribute :>> functionName = "转换能量/物理量、控制运行";
        attribute :>> ownerProductId = "7000";
        attribute :>> ownerProductName = "供风制动";
        attribute :>> allocationId = "alloc_ALLOC_F_7000_01_7000";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7000_01_7000 allocate fu_F_7000_01 to ap_N_7000;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_095 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_7100_01";
        attribute :>> functionName = "传递能量/介质、检测运行参数";
        attribute :>> ownerProductId = "7100";
        attribute :>> ownerProductName = "供风";
        attribute :>> allocationId = "alloc_ALLOC_F_7100_01_7100";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7100_01_7100 allocate fu_F_7100_01 to ap_N_7100;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_096 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_7120_01";
        attribute :>> functionName = "传递能量/介质";
        attribute :>> ownerProductId = "7120";
        attribute :>> ownerProductName = "风缸";
        attribute :>> allocationId = "alloc_ALLOC_F_7120_01_7120";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7120_01_7120 allocate fu_F_7120_01 to ap_N_7120;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_097 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_7124_01";
        attribute :>> functionName = "提供制动风缸外部能量";
        attribute :>> ownerProductId = "7124";
        attribute :>> ownerProductName = "制动风缸";
        attribute :>> allocationId = "alloc_ALLOC_F_7124_01_7124";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7124_01_7124 allocate fu_F_7124_01 to ap_N_7124;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_098 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_7130_01";
        attribute :>> functionName = "传递能量/介质";
        attribute :>> ownerProductId = "7130";
        attribute :>> ownerProductName = "列车级压缩空气分配组件";
        attribute :>> allocationId = "alloc_ALLOC_F_7130_01_7130";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7130_01_7130 allocate fu_F_7130_01 to ap_N_7130;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_099 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_7131_01";
        attribute :>> functionName = "传递总风管气动压力";
        attribute :>> ownerProductId = "7131";
        attribute :>> ownerProductName = "总风管";
        attribute :>> allocationId = "alloc_ALLOC_F_7131_01_7131";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7131_01_7131 allocate fu_F_7131_01 to ap_N_7131;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_100 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_7140_01";
        attribute :>> functionName = "检测运行参数";
        attribute :>> ownerProductId = "7140";
        attribute :>> ownerProductName = "供风压力开关及传感器";
        attribute :>> allocationId = "alloc_ALLOC_F_7140_01_7140";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7140_01_7140 allocate fu_F_7140_01 to ap_N_7140;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_101 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_7142_01";
        attribute :>> functionName = "检测总风管压力传感器状态";
        attribute :>> ownerProductId = "7142";
        attribute :>> ownerProductName = "总风管压力传感器";
        attribute :>> allocationId = "alloc_ALLOC_F_7142_01_7142";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7142_01_7142 allocate fu_F_7142_01 to ap_N_7142;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_102 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_7200_01";
        attribute :>> functionName = "转换能量/物理量、控制运行";
        attribute :>> ownerProductId = "7200";
        attribute :>> ownerProductName = "制动";
        attribute :>> allocationId = "alloc_ALLOC_F_7200_01_7200";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7200_01_7200 allocate fu_F_7200_01 to ap_N_7200;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_103 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_7210_01";
        attribute :>> functionName = "转换能量/物理量、控制运行";
        attribute :>> ownerProductId = "7210";
        attribute :>> ownerProductName = "制动控制组件";
        attribute :>> allocationId = "alloc_ALLOC_F_7210_01_7210";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7210_01_7210 allocate fu_F_7210_01 to ap_N_7210;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_104 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_7211_01";
        attribute :>> functionName = "处理制动请求";
        attribute :>> ownerProductId = "7211";
        attribute :>> ownerProductName = "电子制动控制单元(EBCU)";
        attribute :>> allocationId = "alloc_ALLOC_F_7211_01_7211";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7211_01_7211 allocate fu_F_7211_01 to ap_N_7211;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_105 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_7211_02";
        attribute :>> functionName = "协调再生制动与摩擦制动力";
        attribute :>> ownerProductId = "7211";
        attribute :>> ownerProductName = "电子制动控制单元(EBCU)";
        attribute :>> allocationId = "alloc_ALLOC_F_7211_02_7211";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7211_02_7211 allocate fu_F_7211_02 to ap_N_7211;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_106 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_7211_03";
        attribute :>> functionName = "执行电空制动控制";
        attribute :>> ownerProductId = "7211";
        attribute :>> ownerProductName = "电子制动控制单元(EBCU)";
        attribute :>> allocationId = "alloc_ALLOC_F_7211_03_7211";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7211_03_7211 allocate fu_F_7211_03 to ap_N_7211;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_107 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_7211_04";
        attribute :>> functionName = "协调防滑与紧急制动安全请求";
        attribute :>> ownerProductId = "7211";
        attribute :>> ownerProductName = "电子制动控制单元(EBCU)";
        attribute :>> allocationId = "alloc_ALLOC_F_7211_04_7211";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7211_04_7211 allocate fu_F_7211_04 to ap_N_7211;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_108 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_7213_01";
        attribute :>> functionName = "执行制动控制接触器及其他动作";
        attribute :>> ownerProductId = "7213";
        attribute :>> ownerProductName = "制动控制接触器及其他";
        attribute :>> allocationId = "alloc_ALLOC_F_7213_01_7213";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7213_01_7213 allocate fu_F_7213_01 to ap_N_7213;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_109 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_7220_01";
        attribute :>> functionName = "转换能量/物理量、执行安全控制";
        attribute :>> ownerProductId = "7220";
        attribute :>> ownerProductName = "直接制动控制";
        attribute :>> allocationId = "alloc_ALLOC_F_7220_01_7220";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7220_01_7220 allocate fu_F_7220_01 to ap_N_7220;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_110 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_7222_01";
        attribute :>> functionName = "传递电空转换阀气动压力";
        attribute :>> ownerProductId = "7222";
        attribute :>> ownerProductName = "电空转换阀";
        attribute :>> allocationId = "alloc_ALLOC_F_7222_01_7222";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7222_01_7222 allocate fu_F_7222_01 to ap_N_7222;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_111 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_7223_01";
        attribute :>> functionName = "传递中继阀气动压力";
        attribute :>> ownerProductId = "7223";
        attribute :>> ownerProductName = "中继阀";
        attribute :>> allocationId = "alloc_ALLOC_F_7223_01_7223";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7223_01_7223 allocate fu_F_7223_01 to ap_N_7223;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_112 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_7224_01";
        attribute :>> functionName = "检测空重车调整阀状态";
        attribute :>> ownerProductId = "7224";
        attribute :>> ownerProductName = "空重车调整阀";
        attribute :>> allocationId = "alloc_ALLOC_F_7224_01_7224";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7224_01_7224 allocate fu_F_7224_01 to ap_N_7224;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_113 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_7225_01";
        attribute :>> functionName = "执行控制电磁阀动作";
        attribute :>> ownerProductId = "7225";
        attribute :>> ownerProductName = "控制电磁阀";
        attribute :>> allocationId = "alloc_ALLOC_F_7225_01_7225";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7225_01_7225 allocate fu_F_7225_01 to ap_N_7225;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_114 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_7226_01";
        attribute :>> functionName = "执行紧急制动气动隔离与施加";
        attribute :>> ownerProductId = "7226";
        attribute :>> ownerProductName = "紧急制动阀";
        attribute :>> allocationId = "alloc_ALLOC_F_7226_01_7226";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7226_01_7226 allocate fu_F_7226_01 to ap_N_7226;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_115 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_7227_01";
        attribute :>> functionName = "执行缓解阀动作";
        attribute :>> ownerProductId = "7227";
        attribute :>> ownerProductName = "缓解阀";
        attribute :>> allocationId = "alloc_ALLOC_F_7227_01_7227";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7227_01_7227 allocate fu_F_7227_01 to ap_N_7227;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_116 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_7228_01";
        attribute :>> functionName = "传递车厢直接制动截断塞门气动压力";
        attribute :>> ownerProductId = "7228";
        attribute :>> ownerProductName = "车厢直接制动截断塞门";
        attribute :>> allocationId = "alloc_ALLOC_F_7228_01_7228";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7228_01_7228 allocate fu_F_7228_01 to ap_N_7228;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_117 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_7229_01";
        attribute :>> functionName = "传递调压阀气动压力";
        attribute :>> ownerProductId = "7229";
        attribute :>> ownerProductName = "调压阀";
        attribute :>> allocationId = "alloc_ALLOC_F_7229_01_7229";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7229_01_7229 allocate fu_F_7229_01 to ap_N_7229;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_118 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_722A_01";
        attribute :>> functionName = "传递防滑阀组成气动压力";
        attribute :>> ownerProductId = "722A";
        attribute :>> ownerProductName = "防滑阀组成";
        attribute :>> allocationId = "alloc_ALLOC_F_722A_01_722A";
        attribute :>> evidence = "allocation alloc_ALLOC_F_722A_01_722A allocate fu_F_722A_01 to ap_N_722A;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_119 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_722B_01";
        attribute :>> functionName = "检测压力传感器状态";
        attribute :>> ownerProductId = "722B";
        attribute :>> ownerProductName = "压力传感器";
        attribute :>> allocationId = "alloc_ALLOC_F_722B_01_722B";
        attribute :>> evidence = "allocation alloc_ALLOC_F_722B_01_722B allocate fu_F_722B_01 to ap_N_722B;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_120 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_722C_01";
        attribute :>> functionName = "检测压力开关状态";
        attribute :>> ownerProductId = "722C";
        attribute :>> ownerProductName = "压力开关";
        attribute :>> allocationId = "alloc_ALLOC_F_722C_01_722C";
        attribute :>> evidence = "allocation alloc_ALLOC_F_722C_01_722C allocate fu_F_722C_01 to ap_N_722C;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_121 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_7250_01";
        attribute :>> functionName = "转换能量/物理量、传递能量/介质";
        attribute :>> ownerProductId = "7250";
        attribute :>> ownerProductName = "制动夹钳及其配套组件";
        attribute :>> allocationId = "alloc_ALLOC_F_7250_01_7250";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7250_01_7250 allocate fu_F_7250_01 to ap_N_7250;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_122 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_7252_01";
        attribute :>> functionName = "传递制动夹钳作用力";
        attribute :>> ownerProductId = "7252";
        attribute :>> ownerProductName = "非停放制动夹钳装置";
        attribute :>> allocationId = "alloc_ALLOC_F_7252_01_7252";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7252_01_7252 allocate fu_F_7252_01 to ap_N_7252;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_123 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_7254_01";
        attribute :>> functionName = "通过闸片耗散机械制动能量";
        attribute :>> ownerProductId = "7254";
        attribute :>> ownerProductName = "闸片";
        attribute :>> allocationId = "alloc_ALLOC_F_7254_01_7254";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7254_01_7254 allocate fu_F_7254_01 to ap_N_7254;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_124 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_7255_01";
        attribute :>> functionName = "将气动压力转换为制动机械力";
        attribute :>> ownerProductId = "7255";
        attribute :>> ownerProductName = "增压缸";
        attribute :>> allocationId = "alloc_ALLOC_F_7255_01_7255";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7255_01_7255 allocate fu_F_7255_01 to ap_N_7255;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_125 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_7280_01";
        attribute :>> functionName = "转换能量/物理量、传递能量/介质";
        attribute :>> ownerProductId = "7280";
        attribute :>> ownerProductName = "其它制动元件及附件";
        attribute :>> allocationId = "alloc_ALLOC_F_7280_01_7280";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7280_01_7280 allocate fu_F_7280_01 to ap_N_7280;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_126 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_7281_01";
        attribute :>> functionName = "执行制动指示器动作";
        attribute :>> ownerProductId = "7281";
        attribute :>> ownerProductName = "制动指示器";
        attribute :>> allocationId = "alloc_ALLOC_F_7281_01_7281";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7281_01_7281 allocate fu_F_7281_01 to ap_N_7281;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_127 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_7284_01";
        attribute :>> functionName = "传递转向架制动截断塞门气动压力";
        attribute :>> ownerProductId = "7284";
        attribute :>> ownerProductName = "转向架制动截断塞门";
        attribute :>> allocationId = "alloc_ALLOC_F_7284_01_7284";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7284_01_7284 allocate fu_F_7284_01 to ap_N_7284;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_128 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_7285_01";
        attribute :>> functionName = "传递单轴制动截断塞门气动压力";
        attribute :>> ownerProductId = "7285";
        attribute :>> ownerProductName = "单轴制动截断塞门";
        attribute :>> allocationId = "alloc_ALLOC_F_7285_01_7285";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7285_01_7285 allocate fu_F_7285_01 to ap_N_7285;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_129 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_8000_01";
        attribute :>> functionName = "控制运行、实施保护与限制";
        attribute :>> ownerProductId = "8000";
        attribute :>> ownerProductName = "网络及辅助监控";
        attribute :>> allocationId = "alloc_ALLOC_F_8000_01_8000";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8000_01_8000 allocate fu_F_8000_01 to ap_N_8000;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_130 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_8100_01";
        attribute :>> functionName = "控制运行、实施保护与限制";
        attribute :>> ownerProductId = "8100";
        attribute :>> ownerProductName = "列车主干网及安全回路";
        attribute :>> allocationId = "alloc_ALLOC_F_8100_01_8100";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8100_01_8100 allocate fu_F_8100_01 to ap_N_8100;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_131 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_8120_01";
        attribute :>> functionName = "控制运行、实施保护与限制";
        attribute :>> ownerProductId = "8120";
        attribute :>> ownerProductName = "控制单元及输入输出模块";
        attribute :>> allocationId = "alloc_ALLOC_F_8120_01_8120";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8120_01_8120 allocate fu_F_8120_01 to ap_N_8120;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_132 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_8121_01";
        attribute :>> functionName = "控制主控制单元运行";
        attribute :>> ownerProductId = "8121";
        attribute :>> ownerProductName = "主控制单元";
        attribute :>> allocationId = "alloc_ALLOC_F_8121_01_8121";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8121_01_8121 allocate fu_F_8121_01 to ap_N_8121;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_133 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_8121_02";
        attribute :>> functionName = "协调主控制单元接口交互";
        attribute :>> ownerProductId = "8121";
        attribute :>> ownerProductName = "主控制单元";
        attribute :>> allocationId = "alloc_ALLOC_F_8121_02_8121";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8121_02_8121 allocate fu_F_8121_02 to ap_N_8121;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_134 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_8121_03";
        attribute :>> functionName = "报告主控制单元运行状态";
        attribute :>> ownerProductId = "8121";
        attribute :>> ownerProductName = "主控制单元";
        attribute :>> allocationId = "alloc_ALLOC_F_8121_03_8121";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8121_03_8121 allocate fu_F_8121_03 to ap_N_8121;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_135 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_8122_01";
        attribute :>> functionName = "控制车辆控制单元运行";
        attribute :>> ownerProductId = "8122";
        attribute :>> ownerProductName = "车辆控制单元";
        attribute :>> allocationId = "alloc_ALLOC_F_8122_01_8122";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8122_01_8122 allocate fu_F_8122_01 to ap_N_8122;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_136 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_8122_02";
        attribute :>> functionName = "协调车辆控制单元接口交互";
        attribute :>> ownerProductId = "8122";
        attribute :>> ownerProductName = "车辆控制单元";
        attribute :>> allocationId = "alloc_ALLOC_F_8122_02_8122";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8122_02_8122 allocate fu_F_8122_02 to ap_N_8122;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_137 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_8122_03";
        attribute :>> functionName = "限制并保护车辆控制单元运行";
        attribute :>> ownerProductId = "8122";
        attribute :>> ownerProductName = "车辆控制单元";
        attribute :>> allocationId = "alloc_ALLOC_F_8122_03_8122";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8122_03_8122 allocate fu_F_8122_03 to ap_N_8122;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_138 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_8122_04";
        attribute :>> functionName = "报告车辆控制单元运行状态";
        attribute :>> ownerProductId = "8122";
        attribute :>> ownerProductName = "车辆控制单元";
        attribute :>> allocationId = "alloc_ALLOC_F_8122_04_8122";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8122_04_8122 allocate fu_F_8122_04 to ap_N_8122;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_139 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_8122_05";
        attribute :>> functionName = "统计车辆控制单元运行数据";
        attribute :>> ownerProductId = "8122";
        attribute :>> ownerProductName = "车辆控制单元";
        attribute :>> allocationId = "alloc_ALLOC_F_8122_05_8122";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8122_05_8122 allocate fu_F_8122_05 to ap_N_8122;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_140 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_8125_01";
        attribute :>> functionName = "控制列车级牵引控制单元运行";
        attribute :>> ownerProductId = "8125";
        attribute :>> ownerProductName = "列车级牵引控制单元";
        attribute :>> allocationId = "alloc_ALLOC_F_8125_01_8125";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8125_01_8125 allocate fu_F_8125_01 to ap_N_8125;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_141 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_8125_02";
        attribute :>> functionName = "协调列车级牵引控制单元接口交互";
        attribute :>> ownerProductId = "8125";
        attribute :>> ownerProductName = "列车级牵引控制单元";
        attribute :>> allocationId = "alloc_ALLOC_F_8125_02_8125";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8125_02_8125 allocate fu_F_8125_02 to ap_N_8125;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_142 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_8125_03";
        attribute :>> functionName = "限制并保护列车级牵引控制单元运行";
        attribute :>> ownerProductId = "8125";
        attribute :>> ownerProductName = "列车级牵引控制单元";
        attribute :>> allocationId = "alloc_ALLOC_F_8125_03_8125";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8125_03_8125 allocate fu_F_8125_03 to ap_N_8125;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_143 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_8125_04";
        attribute :>> functionName = "报告列车级牵引控制单元运行状态";
        attribute :>> ownerProductId = "8125";
        attribute :>> ownerProductName = "列车级牵引控制单元";
        attribute :>> allocationId = "alloc_ALLOC_F_8125_04_8125";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8125_04_8125 allocate fu_F_8125_04 to ap_N_8125;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_144 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_8127_01";
        attribute :>> functionName = "路由ATP接口单元输入输出信号";
        attribute :>> ownerProductId = "8127";
        attribute :>> ownerProductName = "ATP接口单元";
        attribute :>> allocationId = "alloc_ALLOC_F_8127_01_8127";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8127_01_8127 allocate fu_F_8127_01 to ap_N_8127;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_145 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_8127_02";
        attribute :>> functionName = "报告ATP接口单元运行状态";
        attribute :>> ownerProductId = "8127";
        attribute :>> ownerProductName = "ATP接口单元";
        attribute :>> allocationId = "alloc_ALLOC_F_8127_02_8127";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8127_02_8127 allocate fu_F_8127_02 to ap_N_8127;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_146 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_8128_01";
        attribute :>> functionName = "路由输入输出单元输入输出信号";
        attribute :>> ownerProductId = "8128";
        attribute :>> ownerProductName = "输入输出单元";
        attribute :>> allocationId = "alloc_ALLOC_F_8128_01_8128";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8128_01_8128 allocate fu_F_8128_01 to ap_N_8128;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_147 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_8128_02";
        attribute :>> functionName = "协调输入输出单元接口交互";
        attribute :>> ownerProductId = "8128";
        attribute :>> ownerProductName = "输入输出单元";
        attribute :>> allocationId = "alloc_ALLOC_F_8128_02_8128";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8128_02_8128 allocate fu_F_8128_02 to ap_N_8128;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_148 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_8128_03";
        attribute :>> functionName = "报告输入输出单元运行状态";
        attribute :>> ownerProductId = "8128";
        attribute :>> ownerProductName = "输入输出单元";
        attribute :>> allocationId = "alloc_ALLOC_F_8128_03_8128";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8128_03_8128 allocate fu_F_8128_03 to ap_N_8128;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_149 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_8150_01";
        attribute :>> functionName = "执行安全控制、反馈运行状态";
        attribute :>> ownerProductId = "8150";
        attribute :>> ownerProductName = "整车级安全回路及其附件";
        attribute :>> allocationId = "alloc_ALLOC_F_8150_01_8150";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8150_01_8150 allocate fu_F_8150_01 to ap_N_8150;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_150 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_8151_01";
        attribute :>> functionName = "执行高压安全回路安全逻辑";
        attribute :>> ownerProductId = "8151";
        attribute :>> ownerProductName = "高压安全回路";
        attribute :>> allocationId = "alloc_ALLOC_F_8151_01_8151";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8151_01_8151 allocate fu_F_8151_01 to ap_N_8151;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_151 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_8151_02";
        attribute :>> functionName = "报告高压安全回路运行状态";
        attribute :>> ownerProductId = "8151";
        attribute :>> ownerProductName = "高压安全回路";
        attribute :>> allocationId = "alloc_ALLOC_F_8151_02_8151";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8151_02_8151 allocate fu_F_8151_02 to ap_N_8151;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_152 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_8152_01";
        attribute :>> functionName = "执行制动安全回路安全逻辑";
        attribute :>> ownerProductId = "8152";
        attribute :>> ownerProductName = "制动安全回路";
        attribute :>> allocationId = "alloc_ALLOC_F_8152_01_8152";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8152_01_8152 allocate fu_F_8152_01 to ap_N_8152;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_153 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_8152_02";
        attribute :>> functionName = "报告制动安全回路运行状态";
        attribute :>> ownerProductId = "8152";
        attribute :>> ownerProductName = "制动安全回路";
        attribute :>> allocationId = "alloc_ALLOC_F_8152_02_8152";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8152_02_8152 allocate fu_F_8152_02 to ap_N_8152;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_154 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_8154_01";
        attribute :>> functionName = "执行牵引安全回路安全逻辑";
        attribute :>> ownerProductId = "8154";
        attribute :>> ownerProductName = "牵引安全回路";
        attribute :>> allocationId = "alloc_ALLOC_F_8154_01_8154";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8154_01_8154 allocate fu_F_8154_01 to ap_N_8154;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_155 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_8154_02";
        attribute :>> functionName = "报告牵引安全回路运行状态";
        attribute :>> ownerProductId = "8154";
        attribute :>> ownerProductName = "牵引安全回路";
        attribute :>> allocationId = "alloc_ALLOC_F_8154_02_8154";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8154_02_8154 allocate fu_F_8154_02 to ap_N_8154;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_156 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_8160_01";
        attribute :>> functionName = "控制运行、反馈运行状态";
        attribute :>> ownerProductId = "8160";
        attribute :>> ownerProductName = "其它附件";
        attribute :>> allocationId = "alloc_ALLOC_F_8160_01_8160";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8160_01_8160 allocate fu_F_8160_01 to ap_N_8160;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_157 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_8166_01";
        attribute :>> functionName = "控制能量计运行";
        attribute :>> ownerProductId = "8166";
        attribute :>> ownerProductName = "能量计";
        attribute :>> allocationId = "alloc_ALLOC_F_8166_01_8166";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8166_01_8166 allocate fu_F_8166_01 to ap_N_8166;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_158 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_8166_02";
        attribute :>> functionName = "协调能量计接口交互";
        attribute :>> ownerProductId = "8166";
        attribute :>> ownerProductName = "能量计";
        attribute :>> allocationId = "alloc_ALLOC_F_8166_02_8166";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8166_02_8166 allocate fu_F_8166_02 to ap_N_8166;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_159 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_8166_03";
        attribute :>> functionName = "报告能量计运行状态";
        attribute :>> ownerProductId = "8166";
        attribute :>> ownerProductName = "能量计";
        attribute :>> allocationId = "alloc_ALLOC_F_8166_03_8166";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8166_03_8166 allocate fu_F_8166_03 to ap_N_8166;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_160 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_8166_04";
        attribute :>> functionName = "统计能量计运行数据";
        attribute :>> ownerProductId = "8166";
        attribute :>> ownerProductName = "能量计";
        attribute :>> allocationId = "alloc_ALLOC_F_8166_04_8166";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8166_04_8166 allocate fu_F_8166_04 to ap_N_8166;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_161 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_D000_01";
        attribute :>> functionName = "控制运行";
        attribute :>> ownerProductId = "D000";
        attribute :>> ownerProductName = "驾驶设施";
        attribute :>> allocationId = "alloc_ALLOC_F_D000_01_D000";
        attribute :>> evidence = "allocation alloc_ALLOC_F_D000_01_D000 allocate fu_F_D000_01 to ap_D000;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_162 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_D100_01";
        attribute :>> functionName = "控制运行";
        attribute :>> ownerProductId = "D100";
        attribute :>> ownerProductName = "操纵设施";
        attribute :>> allocationId = "alloc_ALLOC_F_D100_01_D100";
        attribute :>> evidence = "allocation alloc_ALLOC_F_D100_01_D100 allocate fu_F_D100_01 to ap_D100;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_163 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_D110_01";
        attribute :>> functionName = "控制运行";
        attribute :>> ownerProductId = "D110";
        attribute :>> ownerProductName = "基本操纵组件";
        attribute :>> allocationId = "alloc_ALLOC_F_D110_01_D110";
        attribute :>> evidence = "allocation alloc_ALLOC_F_D110_01_D110 allocate fu_F_D110_01 to ap_D110;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_164 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_D112_01";
        attribute :>> functionName = "提供方向操作元件边界交互";
        attribute :>> ownerProductId = "D112";
        attribute :>> ownerProductName = "方向操作元件";
        attribute :>> allocationId = "alloc_ALLOC_F_D112_01_D112";
        attribute :>> evidence = "allocation alloc_ALLOC_F_D112_01_D112 allocate fu_F_D112_01 to ap_D112;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_165 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_D113_01";
        attribute :>> functionName = "提供牵引操作元件边界交互";
        attribute :>> ownerProductId = "D113";
        attribute :>> ownerProductName = "牵引操作元件";
        attribute :>> allocationId = "alloc_ALLOC_F_D113_01_D113";
        attribute :>> evidence = "allocation alloc_ALLOC_F_D113_01_D113 allocate fu_F_D113_01 to ap_D113;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_166 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_D114_01";
        attribute :>> functionName = "提供制动操作元件边界交互";
        attribute :>> ownerProductId = "D114";
        attribute :>> ownerProductName = "制动操作元件";
        attribute :>> allocationId = "alloc_ALLOC_F_D114_01_D114";
        attribute :>> evidence = "allocation alloc_ALLOC_F_D114_01_D114 allocate fu_F_D114_01 to ap_D114;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_167 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_D120_01";
        attribute :>> functionName = "控制运行";
        attribute :>> ownerProductId = "D120";
        attribute :>> ownerProductName = "紧急响应元件";
        attribute :>> allocationId = "alloc_ALLOC_F_D120_01_D120";
        attribute :>> evidence = "allocation alloc_ALLOC_F_D120_01_D120 allocate fu_F_D120_01 to ap_D120;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_168 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_D121_01";
        attribute :>> functionName = "提供紧急制动按钮边界交互";
        attribute :>> ownerProductId = "D121";
        attribute :>> ownerProductName = "紧急制动按钮";
        attribute :>> allocationId = "alloc_ALLOC_F_D121_01_D121";
        attribute :>> evidence = "allocation alloc_ALLOC_F_D121_01_D121 allocate fu_F_D121_01 to ap_D121;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_169 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_D130_01";
        attribute :>> functionName = "控制运行";
        attribute :>> ownerProductId = "D130";
        attribute :>> ownerProductName = "开关按钮功能组件";
        attribute :>> allocationId = "alloc_ALLOC_F_D130_01_D130";
        attribute :>> evidence = "allocation alloc_ALLOC_F_D130_01_D130 allocate fu_F_D130_01 to ap_D130;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_170 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_D13B_01";
        attribute :>> functionName = "提供撒砂按钮边界交互";
        attribute :>> ownerProductId = "D13B";
        attribute :>> ownerProductName = "撒砂按钮";
        attribute :>> allocationId = "alloc_ALLOC_F_D13B_01_D13B";
        attribute :>> evidence = "allocation alloc_ALLOC_F_D13B_01_D13B allocate fu_F_D13B_01 to ap_D13B;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_171 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_E000_01";
        attribute :>> functionName = "控制运行";
        attribute :>> ownerProductId = "E000";
        attribute :>> ownerProductName = "电务车载";
        attribute :>> allocationId = "alloc_ALLOC_F_E000_01_E000";
        attribute :>> evidence = "allocation alloc_ALLOC_F_E000_01_E000 allocate fu_F_E000_01 to ap_E000;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_172 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_E100_01";
        attribute :>> functionName = "提供ATP车载边界交互";
        attribute :>> ownerProductId = "E100";
        attribute :>> ownerProductName = "ATP车载";
        attribute :>> allocationId = "alloc_ALLOC_F_E100_01_E100";
        attribute :>> evidence = "allocation alloc_ALLOC_F_E100_01_E100 allocate fu_F_E100_01 to ap_E100;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_173 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_X000_01";
        attribute :>> functionName = "实现车载再生能量回收与利用";
        attribute :>> ownerProductId = "X000";
        attribute :>> ownerProductName = "再生储能扩展";
        attribute :>> allocationId = "alloc_ALLOC_F_X000_01_X000";
        attribute :>> evidence = "allocation alloc_ALLOC_F_X000_01_X000 allocate fu_F_X000_01 to ap_X000;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_174 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_X100_01";
        attribute :>> functionName = "吸收、存储并按需释放再生制动能量";
        attribute :>> ownerProductId = "X100";
        attribute :>> ownerProductName = "车载再生储能";
        attribute :>> allocationId = "alloc_ALLOC_F_X100_01_X100";
        attribute :>> evidence = "allocation alloc_ALLOC_F_X100_01_X100 allocate fu_F_X100_01 to ap_X100;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_175 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_X110_01";
        attribute :>> functionName = "实现再生储能双向能量变换、控制与保护";
        attribute :>> ownerProductId = "X110";
        attribute :>> ownerProductName = "双向储能变流及控制";
        attribute :>> allocationId = "alloc_ALLOC_F_X110_01_X110";
        attribute :>> evidence = "allocation alloc_ALLOC_F_X110_01_X110 allocate fu_F_X110_01 to ap_X110;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_176 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_X111_01";
        attribute :>> functionName = "实现中间直流母线与储能侧直流母线双向能量转换";
        attribute :>> ownerProductId = "X111";
        attribute :>> ownerProductName = "双向DC/DC变流模块";
        attribute :>> allocationId = "alloc_ALLOC_F_X111_01_X111";
        attribute :>> evidence = "allocation alloc_ALLOC_F_X111_01_X111 allocate fu_F_X111_01 to ap_X111;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_177 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_X111_02";
        attribute :>> functionName = "执行双向DC/DC功率变换指令并反馈状态";
        attribute :>> ownerProductId = "X111";
        attribute :>> ownerProductName = "双向DC/DC变流模块";
        attribute :>> allocationId = "alloc_ALLOC_F_X111_02_X111";
        attribute :>> evidence = "allocation alloc_ALLOC_F_X111_02_X111 allocate fu_F_X111_02 to ap_X111;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_178 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_X112_01";
        attribute :>> functionName = "控制双向DC/DC功率变换";
        attribute :>> ownerProductId = "X112";
        attribute :>> ownerProductName = "双向DC/DC控制模块";
        attribute :>> allocationId = "alloc_ALLOC_F_X112_01_X112";
        attribute :>> evidence = "allocation alloc_ALLOC_F_X112_01_X112 allocate fu_F_X112_01 to ap_X112;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_179 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_X112_02";
        attribute :>> functionName = "限制储能充放电功率并协调保护";
        attribute :>> ownerProductId = "X112";
        attribute :>> ownerProductName = "双向DC/DC控制模块";
        attribute :>> allocationId = "alloc_ALLOC_F_X112_02_X112";
        attribute :>> evidence = "allocation alloc_ALLOC_F_X112_02_X112 allocate fu_F_X112_02 to ap_X112;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_180 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_X112_03";
        attribute :>> functionName = "报告储能变换系统状态";
        attribute :>> ownerProductId = "X112";
        attribute :>> ownerProductName = "双向DC/DC控制模块";
        attribute :>> allocationId = "alloc_ALLOC_F_X112_03_X112";
        attribute :>> evidence = "allocation alloc_ALLOC_F_X112_03_X112 allocate fu_F_X112_03 to ap_X112;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_181 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_X113_01";
        attribute :>> functionName = "检测双向DC/DC检测保护组件状态";
        attribute :>> ownerProductId = "X113";
        attribute :>> ownerProductName = "双向DC/DC检测保护组件";
        attribute :>> allocationId = "alloc_ALLOC_F_X113_01_X113";
        attribute :>> evidence = "allocation alloc_ALLOC_F_X113_01_X113 allocate fu_F_X113_01 to ap_X113;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_182 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_X120_01";
        attribute :>> functionName = "储存与释放能量、检测运行参数";
        attribute :>> ownerProductId = "X120";
        attribute :>> ownerProductName = "超级电容储能组件";
        attribute :>> allocationId = "alloc_ALLOC_F_X120_01_X120";
        attribute :>> evidence = "allocation alloc_ALLOC_F_X120_01_X120 allocate fu_F_X120_01 to ap_X120;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_183 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_X121_01";
        attribute :>> functionName = "储存并按需释放再生制动电能";
        attribute :>> ownerProductId = "X121";
        attribute :>> ownerProductName = "超级电容模块";
        attribute :>> allocationId = "alloc_ALLOC_F_X121_01_X121";
        attribute :>> evidence = "allocation alloc_ALLOC_F_X121_01_X121 allocate fu_F_X121_01 to ap_X121;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_184 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_X121_02";
        attribute :>> functionName = "提供超级电容荷电状态反馈";
        attribute :>> ownerProductId = "X121";
        attribute :>> ownerProductName = "超级电容模块";
        attribute :>> allocationId = "alloc_ALLOC_F_X121_02_X121";
        attribute :>> evidence = "allocation alloc_ALLOC_F_X121_02_X121 allocate fu_F_X121_02 to ap_X121;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_185 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_X122_01";
        attribute :>> functionName = "检测超级电容电压传感器状态";
        attribute :>> ownerProductId = "X122";
        attribute :>> ownerProductName = "超级电容电压传感器";
        attribute :>> allocationId = "alloc_ALLOC_F_X122_01_X122";
        attribute :>> evidence = "allocation alloc_ALLOC_F_X122_01_X122 allocate fu_F_X122_01 to ap_X122;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_186 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_X123_01";
        attribute :>> functionName = "检测超级电容电流传感器状态";
        attribute :>> ownerProductId = "X123";
        attribute :>> ownerProductName = "超级电容电流传感器";
        attribute :>> allocationId = "alloc_ALLOC_F_X123_01_X123";
        attribute :>> evidence = "allocation alloc_ALLOC_F_X123_01_X123 allocate fu_F_X123_01 to ap_X123;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_187 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_X124_01";
        attribute :>> functionName = "检测超级电容温度传感器状态";
        attribute :>> ownerProductId = "X124";
        attribute :>> ownerProductName = "超级电容温度传感器";
        attribute :>> allocationId = "alloc_ALLOC_F_X124_01_X124";
        attribute :>> evidence = "allocation alloc_ALLOC_F_X124_01_X124 allocate fu_F_X124_01 to ap_X124;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_188 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_X130_01";
        attribute :>> functionName = "传递能量/介质";
        attribute :>> ownerProductId = "X130";
        attribute :>> ownerProductName = "储能接入与保护";
        attribute :>> allocationId = "alloc_ALLOC_F_X130_01_X130";
        attribute :>> evidence = "allocation alloc_ALLOC_F_X130_01_X130 allocate fu_F_X130_01 to ap_X130;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_189 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_X131_01";
        attribute :>> functionName = "传递储能主接触器电能";
        attribute :>> ownerProductId = "X131";
        attribute :>> ownerProductName = "储能主接触器";
        attribute :>> allocationId = "alloc_ALLOC_F_X131_01_X131";
        attribute :>> evidence = "allocation alloc_ALLOC_F_X131_01_X131 allocate fu_F_X131_01 to ap_X131;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_190 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_X132_01";
        attribute :>> functionName = "传递储能预充电组件电能";
        attribute :>> ownerProductId = "X132";
        attribute :>> ownerProductName = "储能预充电组件";
        attribute :>> allocationId = "alloc_ALLOC_F_X132_01_X132";
        attribute :>> evidence = "allocation alloc_ALLOC_F_X132_01_X132 allocate fu_F_X132_01 to ap_X132;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

    item ownerTrace_191 : FunctionOwnerAllocationReference {
        attribute :>> functionId = "FN_F_X133_01";
        attribute :>> functionName = "传递储能支路保护组件电能";
        attribute :>> ownerProductId = "X133";
        attribute :>> ownerProductName = "储能支路保护组件";
        attribute :>> allocationId = "alloc_ALLOC_F_X133_01_X133";
        attribute :>> evidence = "allocation alloc_ALLOC_F_X133_01_X133 allocate fu_F_X133_01 to ap_X133;";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml";
    }

}
