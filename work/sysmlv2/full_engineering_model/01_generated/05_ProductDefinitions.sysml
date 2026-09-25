package ProductDefinitions {
    private import ScalarValues::*;
    private import GeneralDefinitions::*;
    private import PortDefinitions::*;
    part def P_N_3111 {
        attribute productCode : String = "3111";
        attribute chineseName : String = "车轮";
        attribute level : Integer = 4;
        attribute parentCode : String = "3110";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_8ee7c79c0fe26b93 : PT_PT_PHY_006 {
            attribute sourcePortId : String = "PORT::3111::轮轨纵向机械作用端口::ITM-PHY-006::双向物理";
            attribute portName : String = "轮轨纵向机械作用端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_f0350fc816a551ff : PT_PT_PHY_005 {
            attribute sourcePortId : String = "PORT::3111::轮轴旋转机械能端口::ITM-PHY-005::双向物理";
            attribute portName : String = "轮轴旋转机械能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_3112 {
        attribute productCode : String = "3112";
        attribute chineseName : String = "车轴";
        attribute level : Integer = 4;
        attribute parentCode : String = "3110";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_6917242b1f7fc50f : PT_PT_PHY_005 {
            attribute sourcePortId : String = "PORT::3112::传动段旋转机械能端口::ITM-PHY-005::双向物理";
            attribute portName : String = "传动段旋转机械能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_c530418a51140052 : PT_PT_PHY_005 {
            attribute sourcePortId : String = "PORT::3112::轮对段旋转机械能端口::ITM-PHY-005::双向物理";
            attribute portName : String = "轮对段旋转机械能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_3121 {
        attribute productCode : String = "3121";
        attribute chineseName : String = "齿轮箱主体";
        attribute level : Integer = 4;
        attribute parentCode : String = "3120";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_6464b6253314b208 : PT_PT_PHY_005 {
            attribute sourcePortId : String = "PORT::3121::低速轴旋转机械能端口::ITM-PHY-005::双向物理";
            attribute portName : String = "低速轴旋转机械能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_fdcd27ee9b0a936f : PT_PT_PHY_005 {
            attribute sourcePortId : String = "PORT::3121::高速轴旋转机械能端口::ITM-PHY-005::双向物理";
            attribute portName : String = "高速轴旋转机械能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_3131 {
        attribute productCode : String = "3131";
        attribute chineseName : String = "外轮盘";
        attribute level : Integer = 4;
        attribute parentCode : String = "3130";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_06d152ddc255f2eb : PT_PT_PHY_007 {
            attribute sourcePortId : String = "PORT::3131::摩擦制动机械作用端口::ITM-PHY-007::双向物理";
            attribute portName : String = "摩擦制动机械作用端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_ec78c2de89f1a17c : PT_PT_PHY_013 {
            attribute sourcePortId : String = "PORT::3131::热能_热流端口::ITM-PHY-013::双向物理";
            attribute portName : String = "热能/热流端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_3132 {
        attribute productCode : String = "3132";
        attribute chineseName : String = "内轮盘";
        attribute level : Integer = 4;
        attribute parentCode : String = "3130";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_6dfc099101cb436c : PT_PT_PHY_007 {
            attribute sourcePortId : String = "PORT::3132::摩擦制动机械作用端口::ITM-PHY-007::双向物理";
            attribute portName : String = "摩擦制动机械作用端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_6069e8d0fbf298c5 : PT_PT_PHY_013 {
            attribute sourcePortId : String = "PORT::3132::热能_热流端口::ITM-PHY-013::双向物理";
            attribute portName : String = "热能/热流端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_3133 {
        attribute productCode : String = "3133";
        attribute chineseName : String = "轴盘";
        attribute level : Integer = 4;
        attribute parentCode : String = "3130";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_7738143ff23b3321 : PT_PT_PHY_007 {
            attribute sourcePortId : String = "PORT::3133::摩擦制动机械作用端口::ITM-PHY-007::双向物理";
            attribute portName : String = "摩擦制动机械作用端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_24fa6cb520a8e2e2 : PT_PT_PHY_013 {
            attribute sourcePortId : String = "PORT::3133::热能_热流端口::ITM-PHY-013::双向物理";
            attribute portName : String = "热能/热流端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_3511 {
        attribute productCode : String = "3511";
        attribute chineseName : String = "联轴节(电机侧)";
        attribute level : Integer = 4;
        attribute parentCode : String = "3510";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_aa7691c6f81e4771 : PT_PT_PHY_005 {
            attribute sourcePortId : String = "PORT::3511::第一连接面旋转机械能端口::ITM-PHY-005::双向物理";
            attribute portName : String = "第一连接面旋转机械能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_813a305545723d57 : PT_PT_PHY_005 {
            attribute sourcePortId : String = "PORT::3511::第二连接面旋转机械能端口::ITM-PHY-005::双向物理";
            attribute portName : String = "第二连接面旋转机械能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_3512 {
        attribute productCode : String = "3512";
        attribute chineseName : String = "联轴节(齿轮箱侧)";
        attribute level : Integer = 4;
        attribute parentCode : String = "3510";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_970ef7da9f850ce1 : PT_PT_PHY_005 {
            attribute sourcePortId : String = "PORT::3512::第一连接面旋转机械能端口::ITM-PHY-005::双向物理";
            attribute portName : String = "第一连接面旋转机械能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_c455741f6ca5a597 : PT_PT_PHY_005 {
            attribute sourcePortId : String = "PORT::3512::第二连接面旋转机械能端口::ITM-PHY-005::双向物理";
            attribute portName : String = "第二连接面旋转机械能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_3514 {
        attribute productCode : String = "3514";
        attribute chineseName : String = "万向轴";
        attribute level : Integer = 4;
        attribute parentCode : String = "3510";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_b12dc4cc17618821 : PT_PT_PHY_005 {
            attribute sourcePortId : String = "PORT::3514::第一轴端旋转机械能端口::ITM-PHY-005::双向物理";
            attribute portName : String = "第一轴端旋转机械能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_4569aa8f56963dc6 : PT_PT_PHY_005 {
            attribute sourcePortId : String = "PORT::3514::第二轴端旋转机械能端口::ITM-PHY-005::双向物理";
            attribute portName : String = "第二轴端旋转机械能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_3641 {
        attribute productCode : String = "3641";
        attribute chineseName : String = "轴端速度传感器";
        attribute level : Integer = 4;
        attribute parentCode : String = "3640";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_4ddc6037e5eea6fc : PT_PT_PHY_005 {
            attribute sourcePortId : String = "PORT::3641::旋转机械能端口::ITM-PHY-005::双向物理";
            attribute portName : String = "旋转机械能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_0875fbdf10c0dc7e : PT_PT_MEA_002 {
            attribute sourcePortId : String = "PORT::3641::轴端角速度输出::ITM-MEA-002::输出";
            attribute portName : String = "轴端角速度输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_3643 {
        attribute productCode : String = "3643";
        attribute chineseName : String = "齿轮箱速度传感器";
        attribute level : Integer = 4;
        attribute parentCode : String = "3640";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_48ddc723a7d58137 : PT_PT_PHY_005 {
            attribute sourcePortId : String = "PORT::3643::旋转机械能端口::ITM-PHY-005::双向物理";
            attribute portName : String = "旋转机械能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_213dbf9f44535a8a : PT_PT_MEA_003 {
            attribute sourcePortId : String = "PORT::3643::齿轮箱转速输出::ITM-MEA-003::输出";
            attribute portName : String = "齿轮箱转速输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_3644 {
        attribute productCode : String = "3644";
        attribute chineseName : String = "牵引电机速度传感器";
        attribute level : Integer = 4;
        attribute parentCode : String = "3640";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_af1c1b2c65382775 : PT_PT_PHY_005 {
            attribute sourcePortId : String = "PORT::3644::旋转机械能端口::ITM-PHY-005::双向物理";
            attribute portName : String = "旋转机械能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_08c271db56ce8427 : PT_PT_MEA_004 {
            attribute sourcePortId : String = "PORT::3644::牵引电机转速输出::ITM-MEA-004::输出";
            attribute portName : String = "牵引电机转速输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_3811 {
        attribute productCode : String = "3811";
        attribute chineseName : String = "撒砂控制单元";
        attribute level : Integer = 4;
        attribute parentCode : String = "3810";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_ad36be2404e763eb : PT_PT_PHY_015 {
            attribute sourcePortId : String = "PORT::3811::低压控制电能端口::ITM-PHY-015::双向物理";
            attribute portName : String = "低压控制电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_3a8ce42fcde5acd8 : PT_PT_CMD_032 {
            attribute sourcePortId : String = "PORT::3811::撒砂执行指令输出::ITM-CMD-032::输出";
            attribute portName : String = "撒砂执行指令输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_aa4dbc7721f19e23 : PT_PT_STA_012 {
            attribute sourcePortId : String = "PORT::3811::撒砂状态输出::ITM-STA-012::输出";
            attribute portName : String = "撒砂状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_81d4e1a7092e0653 : ~PT_PT_CMD_024 {
            attribute sourcePortId : String = "PORT::3811::撒砂请求输入::ITM-CMD-024::输入";
            attribute portName : String = "撒砂请求输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_3813 {
        attribute productCode : String = "3813";
        attribute chineseName : String = "撒砂阀板组件";
        attribute level : Integer = 4;
        attribute parentCode : String = "3810";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_3f7e961856b812d2 : PT_PT_PHY_008 {
            attribute sourcePortId : String = "PORT::3813::主风压缩空气端口::ITM-PHY-008::双向物理";
            attribute portName : String = "主风压缩空气端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_d951497aaa9989f0 : ~PT_PT_CMD_032 {
            attribute sourcePortId : String = "PORT::3813::撒砂执行指令输入::ITM-CMD-032::输入";
            attribute portName : String = "撒砂执行指令输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_3344f097f2d78315 : PT_PT_STA_012 {
            attribute sourcePortId : String = "PORT::3813::撒砂状态输出::ITM-STA-012::输出";
            attribute portName : String = "撒砂状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_c843e562c7ec3ed9 : PT_PT_PHY_012 {
            attribute sourcePortId : String = "PORT::3813::砂流端口::ITM-PHY-012::双向物理";
            attribute portName : String = "砂流端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_3814 {
        attribute productCode : String = "3814";
        attribute chineseName : String = "撒砂喷嘴组件";
        attribute level : Integer = 4;
        attribute parentCode : String = "3810";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_43d42f25a744fe07 : PT_PT_PHY_012 {
            attribute sourcePortId : String = "PORT::3814::砂流端口::ITM-PHY-012::双向物理";
            attribute portName : String = "砂流端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_4111 {
        attribute productCode : String = "4111";
        attribute chineseName : String = "碳滑板";
        attribute level : Integer = 4;
        attribute parentCode : String = "4110";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_ca65ceda639dfc7a : PT_PT_PHY_001 {
            attribute sourcePortId : String = "PORT::4111::导流端高压交流电能端口::ITM-PHY-001::双向物理";
            attribute portName : String = "导流端高压交流电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_695b20573c740008 : PT_PT_PHY_001 {
            attribute sourcePortId : String = "PORT::4111::接触面高压交流电能端口::ITM-PHY-001::双向物理";
            attribute portName : String = "接触面高压交流电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_411C {
        attribute productCode : String = "411C";
        attribute chineseName : String = "受电弓电子控制单元";
        attribute level : Integer = 4;
        attribute parentCode : String = "4110";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_d6a2171160c4b693 : PT_PT_PHY_015 {
            attribute sourcePortId : String = "PORT::411C::低压控制电能端口::ITM-PHY-015::双向物理";
            attribute portName : String = "低压控制电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_201c13a158f19a88 : ~PT_PT_CMD_018 {
            attribute sourcePortId : String = "PORT::411C::受电弓控制指令输入::ITM-CMD-018::输入";
            attribute portName : String = "受电弓控制指令输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_72d2eed2608e1b56 : PT_PT_STA_015 {
            attribute sourcePortId : String = "PORT::411C::受电弓状态输出::ITM-STA-015::输出";
            attribute portName : String = "受电弓状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_7f443c4ab63f77d2 : PT_PT_STA_016 {
            attribute sourcePortId : String = "PORT::411C::高压系统故障状态输出::ITM-STA-016::输出";
            attribute portName : String = "高压系统故障状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_4121 {
        attribute productCode : String = "4121";
        attribute chineseName : String = "受流器";
        attribute level : Integer = 4;
        attribute parentCode : String = "4120";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_d35e3f96846f95a6 : PT_PT_PHY_002 {
            attribute sourcePortId : String = "PORT::4121::受流端直流牵引供电电能端口::ITM-PHY-002::双向物理";
            attribute portName : String = "受流端直流牵引供电电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = false;
        }
        port rp_3a0861f1892e9d5f : PT_PT_PHY_002 {
            attribute sourcePortId : String = "PORT::4121::导流端直流牵引供电电能端口::ITM-PHY-002::双向物理";
            attribute portName : String = "导流端直流牵引供电电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = false;
        }
    }
    part def P_N_4211 {
        attribute productCode : String = "4211";
        attribute chineseName : String = "真空断路器";
        attribute level : Integer = 4;
        attribute parentCode : String = "4210";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_ee92cd728b152a90 : PT_PT_PHY_001 {
            attribute sourcePortId : String = "PORT::4211::出线侧高压交流电能端口::ITM-PHY-001::双向物理";
            attribute portName : String = "出线侧高压交流电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_bba7ece236be8f3c : PT_PT_PHY_001 {
            attribute sourcePortId : String = "PORT::4211::进线侧高压交流电能端口::ITM-PHY-001::双向物理";
            attribute portName : String = "进线侧高压交流电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_17bc6a2a377dffab : ~PT_PT_CMD_016 {
            attribute sourcePortId : String = "PORT::4211::高压断路器指令输入::ITM-CMD-016::输入";
            attribute portName : String = "高压断路器指令输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_5301bf8bda8fba16 : PT_PT_STA_013 {
            attribute sourcePortId : String = "PORT::4211::高压断路器状态输出::ITM-STA-013::输出";
            attribute portName : String = "高压断路器状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_5fec968d70e06b36 : PT_PT_STA_016 {
            attribute sourcePortId : String = "PORT::4211::高压系统故障状态输出::ITM-STA-016::输出";
            attribute portName : String = "高压系统故障状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_4212 {
        attribute productCode : String = "4212";
        attribute chineseName : String = "非真空隔离开关";
        attribute level : Integer = 4;
        attribute parentCode : String = "4210";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_0ce11b1eb6ca7ee8 : PT_PT_PHY_002 {
            attribute sourcePortId : String = "PORT::4212::出线侧直流牵引供电电能端口::ITM-PHY-002::双向物理";
            attribute portName : String = "出线侧直流牵引供电电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = false;
        }
        port rp_e1689d643b97d378 : PT_PT_PHY_001 {
            attribute sourcePortId : String = "PORT::4212::出线侧高压交流电能端口::ITM-PHY-001::双向物理";
            attribute portName : String = "出线侧高压交流电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_e344333f6e011283 : PT_PT_PHY_002 {
            attribute sourcePortId : String = "PORT::4212::进线侧直流牵引供电电能端口::ITM-PHY-002::双向物理";
            attribute portName : String = "进线侧直流牵引供电电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = false;
        }
        port rp_4b65d610848833a3 : PT_PT_PHY_001 {
            attribute sourcePortId : String = "PORT::4212::进线侧高压交流电能端口::ITM-PHY-001::双向物理";
            attribute portName : String = "进线侧高压交流电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_a29d16c43fc8d044 : ~PT_PT_CMD_017 {
            attribute sourcePortId : String = "PORT::4212::高压隔离开关指令输入::ITM-CMD-017::输入";
            attribute portName : String = "高压隔离开关指令输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_62a902ccb2d5edf3 : PT_PT_STA_014 {
            attribute sourcePortId : String = "PORT::4212::高压隔离开关状态输出::ITM-STA-014::输出";
            attribute portName : String = "高压隔离开关状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_4235 {
        attribute productCode : String = "4235";
        attribute chineseName : String = "高压电压互感器";
        attribute level : Integer = 4;
        attribute parentCode : String = "4230";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_3e2b71c6b8d79136 : PT_PT_PHY_001 {
            attribute sourcePortId : String = "PORT::4235::高压交流电能端口::ITM-PHY-001::双向物理";
            attribute portName : String = "高压交流电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_6fea4b377f978aac : PT_PT_MEA_005 {
            attribute sourcePortId : String = "PORT::4235::高压线路电压输出::ITM-MEA-005::输出";
            attribute portName : String = "高压线路电压输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_4236 {
        attribute productCode : String = "4236";
        attribute chineseName : String = "高压电流互感器";
        attribute level : Integer = 4;
        attribute parentCode : String = "4230";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_bb6f3fee449fd865 : PT_PT_PHY_001 {
            attribute sourcePortId : String = "PORT::4236::第一测量端高压交流电能端口::ITM-PHY-001::双向物理";
            attribute portName : String = "第一测量端高压交流电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_78e99abb7d77c156 : PT_PT_PHY_001 {
            attribute sourcePortId : String = "PORT::4236::第二测量端高压交流电能端口::ITM-PHY-001::双向物理";
            attribute portName : String = "第二测量端高压交流电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_9107465175683792 : PT_PT_MEA_006 {
            attribute sourcePortId : String = "PORT::4236::高压线路电流输出::ITM-MEA-006::输出";
            attribute portName : String = "高压线路电流输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_4238 {
        attribute productCode : String = "4238";
        attribute chineseName : String = "高压控制输入输出单元";
        attribute level : Integer = 4;
        attribute parentCode : String = "4230";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_dc173bda6489186d : PT_PT_PHY_015 {
            attribute sourcePortId : String = "PORT::4238::低压控制电能端口::ITM-PHY-015::双向物理";
            attribute portName : String = "低压控制电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_71811e4b68798212 : ~PT_PT_CMD_018 {
            attribute sourcePortId : String = "PORT::4238::受电弓控制指令输入::ITM-CMD-018::输入";
            attribute portName : String = "受电弓控制指令输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_9744a4b3a255a6e8 : PT_PT_CMD_018 {
            attribute sourcePortId : String = "PORT::4238::受电弓控制指令输出::ITM-CMD-018::输出";
            attribute portName : String = "受电弓控制指令输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_d9d25dfbac32d1e3 : ~PT_PT_STA_015 {
            attribute sourcePortId : String = "PORT::4238::受电弓状态输入::ITM-STA-015::输入";
            attribute portName : String = "受电弓状态输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_86fe03530d5b3c05 : PT_PT_STA_015 {
            attribute sourcePortId : String = "PORT::4238::受电弓状态输出::ITM-STA-015::输出";
            attribute portName : String = "受电弓状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_d6b968957e3167c7 : ~PT_PT_CMD_016 {
            attribute sourcePortId : String = "PORT::4238::高压断路器指令输入::ITM-CMD-016::输入";
            attribute portName : String = "高压断路器指令输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_65aacc4600de3990 : PT_PT_CMD_016 {
            attribute sourcePortId : String = "PORT::4238::高压断路器指令输出::ITM-CMD-016::输出";
            attribute portName : String = "高压断路器指令输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_b26de8005dff4962 : ~PT_PT_STA_013 {
            attribute sourcePortId : String = "PORT::4238::高压断路器状态输入::ITM-STA-013::输入";
            attribute portName : String = "高压断路器状态输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_0674d2b80a6a72da : PT_PT_STA_013 {
            attribute sourcePortId : String = "PORT::4238::高压断路器状态输出::ITM-STA-013::输出";
            attribute portName : String = "高压断路器状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_11b7e7965ec2e386 : ~PT_PT_STA_016 {
            attribute sourcePortId : String = "PORT::4238::高压系统故障状态输入::ITM-STA-016::输入";
            attribute portName : String = "高压系统故障状态输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_9458944450b0dd4c : PT_PT_STA_016 {
            attribute sourcePortId : String = "PORT::4238::高压系统故障状态输出::ITM-STA-016::输出";
            attribute portName : String = "高压系统故障状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_c88ddcdfe3b55c9e : ~PT_PT_MEA_005 {
            attribute sourcePortId : String = "PORT::4238::高压线路电压输入::ITM-MEA-005::输入";
            attribute portName : String = "高压线路电压输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_5576b5e0dbb912ba : PT_PT_MEA_005 {
            attribute sourcePortId : String = "PORT::4238::高压线路电压输出::ITM-MEA-005::输出";
            attribute portName : String = "高压线路电压输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_afb7b0997d28e7cb : ~PT_PT_MEA_006 {
            attribute sourcePortId : String = "PORT::4238::高压线路电流输入::ITM-MEA-006::输入";
            attribute portName : String = "高压线路电流输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_c7dcc306b020116f : PT_PT_MEA_006 {
            attribute sourcePortId : String = "PORT::4238::高压线路电流输出::ITM-MEA-006::输出";
            attribute portName : String = "高压线路电流输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_f6362be8ea9a501f : ~PT_PT_CMD_017 {
            attribute sourcePortId : String = "PORT::4238::高压隔离开关指令输入::ITM-CMD-017::输入";
            attribute portName : String = "高压隔离开关指令输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_ed1efa73e618c52f : PT_PT_CMD_017 {
            attribute sourcePortId : String = "PORT::4238::高压隔离开关指令输出::ITM-CMD-017::输出";
            attribute portName : String = "高压隔离开关指令输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_b46091b51fbac2ba : ~PT_PT_STA_014 {
            attribute sourcePortId : String = "PORT::4238::高压隔离开关状态输入::ITM-STA-014::输入";
            attribute portName : String = "高压隔离开关状态输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_7fe2b8fd826583f2 : PT_PT_STA_014 {
            attribute sourcePortId : String = "PORT::4238::高压隔离开关状态输出::ITM-STA-014::输出";
            attribute portName : String = "高压隔离开关状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_4239 {
        attribute productCode : String = "4239";
        attribute chineseName : String = "高压控制单元";
        attribute level : Integer = 4;
        attribute parentCode : String = "4230";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_9c4bbbf0c73d853e : PT_PT_PHY_015 {
            attribute sourcePortId : String = "PORT::4239::低压控制电能端口::ITM-PHY-015::双向物理";
            attribute portName : String = "低压控制电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_327ede77d6565c4b : PT_PT_CMD_018 {
            attribute sourcePortId : String = "PORT::4239::受电弓控制指令输出::ITM-CMD-018::输出";
            attribute portName : String = "受电弓控制指令输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_f3be8ead57323593 : ~PT_PT_STA_015 {
            attribute sourcePortId : String = "PORT::4239::受电弓状态输入::ITM-STA-015::输入";
            attribute portName : String = "受电弓状态输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_a59e6c38c7d9e2cb : ~PT_PT_MEA_007 {
            attribute sourcePortId : String = "PORT::4239::线路频率输入::ITM-MEA-007::输入";
            attribute portName : String = "线路频率输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_c9c4c887a8c7b2f0 : ~PT_PT_STA_024 {
            attribute sourcePortId : String = "PORT::4239::高压安全回路状态输入::ITM-STA-024::输入";
            attribute portName : String = "高压安全回路状态输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_e67f315619e85b76 : PT_PT_CMD_016 {
            attribute sourcePortId : String = "PORT::4239::高压断路器指令输出::ITM-CMD-016::输出";
            attribute portName : String = "高压断路器指令输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_1fd23591362c1d8d : ~PT_PT_STA_013 {
            attribute sourcePortId : String = "PORT::4239::高压断路器状态输入::ITM-STA-013::输入";
            attribute portName : String = "高压断路器状态输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_390a7ebf7324c6d6 : PT_PT_STA_016 {
            attribute sourcePortId : String = "PORT::4239::高压系统故障状态汇总输出::ITM-STA-016::输出";
            attribute portName : String = "高压系统故障状态汇总输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_be1480d12bc9092c : ~PT_PT_STA_016 {
            attribute sourcePortId : String = "PORT::4239::高压系统故障状态采集输入::ITM-STA-016::输入";
            attribute portName : String = "高压系统故障状态采集输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_2802b0f2f54a548a : ~PT_PT_MEA_005 {
            attribute sourcePortId : String = "PORT::4239::高压线路电压输入::ITM-MEA-005::输入";
            attribute portName : String = "高压线路电压输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_1a7ff383166e59f0 : ~PT_PT_MEA_006 {
            attribute sourcePortId : String = "PORT::4239::高压线路电流输入::ITM-MEA-006::输入";
            attribute portName : String = "高压线路电流输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_e30c550b4d4e8d52 : PT_PT_CMD_017 {
            attribute sourcePortId : String = "PORT::4239::高压隔离开关指令输出::ITM-CMD-017::输出";
            attribute portName : String = "高压隔离开关指令输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_30bf7d79603b941d : ~PT_PT_STA_014 {
            attribute sourcePortId : String = "PORT::4239::高压隔离开关状态输入::ITM-STA-014::输入";
            attribute portName : String = "高压隔离开关状态输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_4241 {
        attribute productCode : String = "4241";
        attribute chineseName : String = "处理单元";
        attribute level : Integer = 4;
        attribute parentCode : String = "4240";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_efc0e0ead5465ae4 : PT_PT_PHY_015 {
            attribute sourcePortId : String = "PORT::4241::低压控制电能端口::ITM-PHY-015::双向物理";
            attribute portName : String = "低压控制电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_efaba262d19c325f : PT_PT_ACC_003 {
            attribute sourcePortId : String = "PORT::4241::回馈电网功率输出::ITM-ACC-003::输出";
            attribute portName : String = "回馈电网功率输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_14501c1527ffc885 : PT_PT_ACC_009 {
            attribute sourcePortId : String = "PORT::4241::回馈电网累计能量输出::ITM-ACC-009::输出";
            attribute portName : String = "回馈电网累计能量输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_c0f06cc787fcafcb : PT_PT_ACC_001 {
            attribute sourcePortId : String = "PORT::4241::牵引实际功率输出::ITM-ACC-001::输出";
            attribute portName : String = "牵引实际功率输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_110b5a4be355bd73 : PT_PT_ACC_007 {
            attribute sourcePortId : String = "PORT::4241::牵引累计能量输出::ITM-ACC-007::输出";
            attribute portName : String = "牵引累计能量输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_93eb42e9bb89d9ec : PT_PT_STA_035 {
            attribute sourcePortId : String = "PORT::4241::能量计量有效状态输出::ITM-STA-035::输出";
            attribute portName : String = "能量计量有效状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_2b7dd272027fdc0b : ~PT_PT_MEA_005 {
            attribute sourcePortId : String = "PORT::4241::高压线路电压输入::ITM-MEA-005::输入";
            attribute portName : String = "高压线路电压输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_f81c0f4a108acec4 : ~PT_PT_MEA_006 {
            attribute sourcePortId : String = "PORT::4241::高压线路电流输入::ITM-MEA-006::输入";
            attribute portName : String = "高压线路电流输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_4411 {
        attribute productCode : String = "4411";
        attribute chineseName : String = "接地变压器";
        attribute level : Integer = 4;
        attribute parentCode : String = "4410";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_45b0eaf9bb476ccf : PT_PT_PHY_011 {
            attribute sourcePortId : String = "PORT::4411::主回路侧回流电流端口::ITM-PHY-011::双向物理";
            attribute portName : String = "主回路侧回流电流端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_5e63cd1bffa78a41 : PT_PT_PHY_011 {
            attribute sourcePortId : String = "PORT::4411::回流侧电流端口::ITM-PHY-011::双向物理";
            attribute portName : String = "回流侧电流端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_c61d1b462f69be85 : PT_PT_PHY_013 {
            attribute sourcePortId : String = "PORT::4411::热能_热流端口::ITM-PHY-013::双向物理";
            attribute portName : String = "热能/热流端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_4412 {
        attribute productCode : String = "4412";
        attribute chineseName : String = "主回路接地电阻";
        attribute level : Integer = 4;
        attribute parentCode : String = "4410";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_e2c805a6993ee3dc : PT_PT_PHY_011 {
            attribute sourcePortId : String = "PORT::4412::主回路侧回流电流端口::ITM-PHY-011::双向物理";
            attribute portName : String = "主回路侧回流电流端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_f330d9bb72a522df : PT_PT_PHY_011 {
            attribute sourcePortId : String = "PORT::4412::回流侧电流端口::ITM-PHY-011::双向物理";
            attribute portName : String = "回流侧电流端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_b031f017471c85ee : PT_PT_PHY_013 {
            attribute sourcePortId : String = "PORT::4412::热能_热流端口::ITM-PHY-013::双向物理";
            attribute portName : String = "热能/热流端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_4413 {
        attribute productCode : String = "4413";
        attribute chineseName : String = "回流碳刷";
        attribute level : Integer = 4;
        attribute parentCode : String = "4410";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_cb582bd13ed15889 : PT_PT_PHY_011 {
            attribute sourcePortId : String = "PORT::4413::固定端回流电流端口::ITM-PHY-011::双向物理";
            attribute portName : String = "固定端回流电流端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_c808ea5883784df8 : PT_PT_PHY_011 {
            attribute sourcePortId : String = "PORT::4413::旋转端回流电流端口::ITM-PHY-011::双向物理";
            attribute portName : String = "旋转端回流电流端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_4511 {
        attribute productCode : String = "4511";
        attribute chineseName : String = "主变压器主体";
        attribute level : Integer = 4;
        attribute parentCode : String = "4510";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_a6f93ee77144741e : PT_PT_PHY_014 {
            attribute sourcePortId : String = "PORT::4511::牵引变压器次级交流电能端口::ITM-PHY-014::双向物理";
            attribute portName : String = "牵引变压器次级交流电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_c782fb362436088e : PT_PT_PHY_001 {
            attribute sourcePortId : String = "PORT::4511::高压交流电能端口::ITM-PHY-001::双向物理";
            attribute portName : String = "高压交流电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_4513 {
        attribute productCode : String = "4513";
        attribute chineseName : String = "电抗器";
        attribute level : Integer = 4;
        attribute parentCode : String = "4510";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_88e2bd038f100aa3 : PT_PT_PHY_014 {
            attribute sourcePortId : String = "PORT::4513::第一交流电能端口::ITM-PHY-014::双向物理";
            attribute portName : String = "第一交流电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_f597e9dc63931270 : PT_PT_PHY_014 {
            attribute sourcePortId : String = "PORT::4513::第二交流电能端口::ITM-PHY-014::双向物理";
            attribute portName : String = "第二交流电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_4517 {
        attribute productCode : String = "4517";
        attribute chineseName : String = "主变压器检测及保护元件";
        attribute level : Integer = 4;
        attribute parentCode : String = "4510";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_b094956bc66dfaad : PT_PT_MEA_022 {
            attribute sourcePortId : String = "PORT::4517::主变压器温度输出::ITM-MEA-022::输出";
            attribute portName : String = "主变压器温度输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_fa22ceafa52cda89 : PT_PT_PHY_015 {
            attribute sourcePortId : String = "PORT::4517::低压控制电能端口::ITM-PHY-015::双向物理";
            attribute portName : String = "低压控制电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_b93b1716e8b4e844 : PT_PT_STA_016 {
            attribute sourcePortId : String = "PORT::4517::高压系统故障状态输出::ITM-STA-016::输出";
            attribute portName : String = "高压系统故障状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_4518 {
        attribute productCode : String = "4518";
        attribute chineseName : String = "主变压器控制装置";
        attribute level : Integer = 4;
        attribute parentCode : String = "4510";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_f46b3d97e0fceb9e : ~PT_PT_MEA_022 {
            attribute sourcePortId : String = "PORT::4518::主变压器温度输入::ITM-MEA-022::输入";
            attribute portName : String = "主变压器温度输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_950aee7777f5ea28 : PT_PT_PHY_015 {
            attribute sourcePortId : String = "PORT::4518::低压控制电能端口::ITM-PHY-015::双向物理";
            attribute portName : String = "低压控制电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_c08bc1e5a0818e4a : PT_PT_CMD_016 {
            attribute sourcePortId : String = "PORT::4518::高压断路器指令输出::ITM-CMD-016::输出";
            attribute portName : String = "高压断路器指令输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_67eef246e016ac82 : ~PT_PT_STA_013 {
            attribute sourcePortId : String = "PORT::4518::高压断路器状态输入::ITM-STA-013::输入";
            attribute portName : String = "高压断路器状态输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_a87c9390595138d6 : ~PT_PT_STA_016 {
            attribute sourcePortId : String = "PORT::4518::高压系统故障状态输入::ITM-STA-016::输入";
            attribute portName : String = "高压系统故障状态输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_5111 {
        attribute productCode : String = "5111";
        attribute chineseName : String = "网侧变流器控制模块";
        attribute level : Integer = 4;
        attribute parentCode : String = "5110";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_a9ddcab662f35564 : ~PT_PT_MEA_008 {
            attribute sourcePortId : String = "PORT::5111::中间直流母线电压输入::ITM-MEA-008::输入";
            attribute portName : String = "中间直流母线电压输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_0e00d1e837346b81 : ~PT_PT_MEA_009 {
            attribute sourcePortId : String = "PORT::5111::中间直流母线电流输入::ITM-MEA-009::输入";
            attribute portName : String = "中间直流母线电流输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_9ceb0295e403e673 : PT_PT_PHY_015 {
            attribute sourcePortId : String = "PORT::5111::低压控制电能端口::ITM-PHY-015::双向物理";
            attribute portName : String = "低压控制电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_6076ccac9d0762b3 : PT_PT_LIM_004 {
            attribute sourcePortId : String = "PORT::5111::再生功率上限输出::ITM-LIM-004::输出";
            attribute portName : String = "再生功率上限输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_cd7720cf9a4eae22 : PT_PT_LIM_005 {
            attribute sourcePortId : String = "PORT::5111::接触网可接收功率输出::ITM-LIM-005::输出";
            attribute portName : String = "接触网可接收功率输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_f5af02c6a1f2ad2c : PT_PT_STA_019 {
            attribute sourcePortId : String = "PORT::5111::牵引变流器故障状态输出::ITM-STA-019::输出";
            attribute portName : String = "牵引变流器故障状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_c8b770c2e6dd3117 : ~PT_PT_MEA_007 {
            attribute sourcePortId : String = "PORT::5111::线路频率输入::ITM-MEA-007::输入";
            attribute portName : String = "线路频率输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_4963dcfde3fa1724 : PT_PT_STA_017 {
            attribute sourcePortId : String = "PORT::5111::网侧变流器状态输出::ITM-STA-017::输出";
            attribute portName : String = "网侧变流器状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_3c696476f82c2ae5 : PT_PT_CMD_010 {
            attribute sourcePortId : String = "PORT::5111::网侧变流控制指令输出::ITM-CMD-010::输出";
            attribute portName : String = "网侧变流控制指令输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_5f90d6dd8fba4321 : ~PT_PT_MEA_005 {
            attribute sourcePortId : String = "PORT::5111::高压线路电压输入::ITM-MEA-005::输入";
            attribute portName : String = "高压线路电压输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_651700e69b7dccba : ~PT_PT_MEA_006 {
            attribute sourcePortId : String = "PORT::5111::高压线路电流输入::ITM-MEA-006::输入";
            attribute portName : String = "高压线路电流输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_5112 {
        attribute productCode : String = "5112";
        attribute chineseName : String = "电机侧变流器控制模块";
        attribute level : Integer = 4;
        attribute parentCode : String = "5110";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_69252f780afe77e0 : ~PT_PT_MEA_008 {
            attribute sourcePortId : String = "PORT::5112::中间直流母线电压输入::ITM-MEA-008::输入";
            attribute portName : String = "中间直流母线电压输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_6ad9df7ab3c91425 : ~PT_PT_MEA_009 {
            attribute sourcePortId : String = "PORT::5112::中间直流母线电流输入::ITM-MEA-009::输入";
            attribute portName : String = "中间直流母线电流输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_c60f875ac7e265d0 : PT_PT_PHY_015 {
            attribute sourcePortId : String = "PORT::5112::低压控制电能端口::ITM-PHY-015::双向物理";
            attribute portName : String = "低压控制电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_4bfdb59776ff813f : PT_PT_LIM_004 {
            attribute sourcePortId : String = "PORT::5112::再生功率上限输出::ITM-LIM-004::输出";
            attribute portName : String = "再生功率上限输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_f2ec293da4f6084c : PT_PT_STA_002 {
            attribute sourcePortId : String = "PORT::5112::动态制动可用状态输出::ITM-STA-002::输出";
            attribute portName : String = "动态制动可用状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_b88bbe834e3c6412 : PT_PT_LIM_001 {
            attribute sourcePortId : String = "PORT::5112::可用动态制动力输出::ITM-LIM-001::输出";
            attribute portName : String = "可用动态制动力输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_13733b4e36d92f10 : PT_PT_LIM_003 {
            attribute sourcePortId : String = "PORT::5112::牵引_再生转矩上限输出::ITM-LIM-003::输出";
            attribute portName : String = "牵引/再生转矩上限输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_32a86e4500c85071 : PT_PT_STA_019 {
            attribute sourcePortId : String = "PORT::5112::牵引变流器故障状态输出::ITM-STA-019::输出";
            attribute portName : String = "牵引变流器故障状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_5337e32cd07bb034 : PT_PT_STA_001 {
            attribute sourcePortId : String = "PORT::5112::牵引可用状态输出::ITM-STA-001::输出";
            attribute portName : String = "牵引可用状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_4557e9b0656c46f5 : ~PT_PT_MEA_012 {
            attribute sourcePortId : String = "PORT::5112::牵引电机实际转矩输入::ITM-MEA-012::输入";
            attribute portName : String = "牵引电机实际转矩输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_6ce5fb5c81d47ab4 : ~PT_PT_CMD_012 {
            attribute sourcePortId : String = "PORT::5112::牵引电机转矩请求输入::ITM-CMD-012::输入";
            attribute portName : String = "牵引电机转矩请求输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_780596fabcc73a0f : ~PT_PT_MEA_004 {
            attribute sourcePortId : String = "PORT::5112::牵引电机转速输入::ITM-MEA-004::输入";
            attribute portName : String = "牵引电机转速输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_f6a2c78620450314 : PT_PT_STA_018 {
            attribute sourcePortId : String = "PORT::5112::电机侧变流器状态输出::ITM-STA-018::输出";
            attribute portName : String = "电机侧变流器状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_c98f6aa887541378 : PT_PT_CMD_011 {
            attribute sourcePortId : String = "PORT::5112::电机侧变流控制指令输出::ITM-CMD-011::输出";
            attribute portName : String = "电机侧变流控制指令输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_21e86fb073b61523 : ~PT_PT_MEA_011 {
            attribute sourcePortId : String = "PORT::5112::电机侧相电压输入::ITM-MEA-011::输入";
            attribute portName : String = "电机侧相电压输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_3db204c2f5a83c7f : ~PT_PT_MEA_010 {
            attribute sourcePortId : String = "PORT::5112::电机侧相电流输入::ITM-MEA-010::输入";
            attribute portName : String = "电机侧相电流输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_5113 {
        attribute productCode : String = "5113";
        attribute chineseName : String = "变流器检测保护组件";
        attribute level : Integer = 4;
        attribute parentCode : String = "5110";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_2af3dfa3c81ea109 : PT_PT_MEA_008 {
            attribute sourcePortId : String = "PORT::5113::中间直流母线电压输出::ITM-MEA-008::输出";
            attribute portName : String = "中间直流母线电压输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_4e1f60c0e22c417d : PT_PT_MEA_009 {
            attribute sourcePortId : String = "PORT::5113::中间直流母线电流输出::ITM-MEA-009::输出";
            attribute portName : String = "中间直流母线电流输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_7668c7c1973850f4 : PT_PT_STA_020 {
            attribute sourcePortId : String = "PORT::5113::中间直流环节保护状态输出::ITM-STA-020::输出";
            attribute portName : String = "中间直流环节保护状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_6f5e3f6e1f0f9b1a : PT_PT_PHY_015 {
            attribute sourcePortId : String = "PORT::5113::低压控制电能端口::ITM-PHY-015::双向物理";
            attribute portName : String = "低压控制电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_d93ff3dea2be11bd : PT_PT_STA_019 {
            attribute sourcePortId : String = "PORT::5113::牵引变流器故障状态输出::ITM-STA-019::输出";
            attribute portName : String = "牵引变流器故障状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_a16fb7ddd6338cf7 : PT_PT_MEA_023 {
            attribute sourcePortId : String = "PORT::5113::牵引变流器温度输出::ITM-MEA-023::输出";
            attribute portName : String = "牵引变流器温度输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_4be030fa7e242206 : PT_PT_MEA_010 {
            attribute sourcePortId : String = "PORT::5113::电机侧相电流输出::ITM-MEA-010::输出";
            attribute portName : String = "电机侧相电流输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_d8b59663e8e8813a : PT_PT_LIM_007 {
            attribute sourcePortId : String = "PORT::5113::直流母线电压上限输出::ITM-LIM-007::输出";
            attribute portName : String = "直流母线电压上限输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_5121 {
        attribute productCode : String = "5121";
        attribute chineseName : String = "预充电组件";
        attribute level : Integer = 4;
        attribute parentCode : String = "5120";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_e5b052bb75ba8a31 : PT_PT_PHY_003 {
            attribute sourcePortId : String = "PORT::5121::中间直流电能端口::ITM-PHY-003::双向物理";
            attribute portName : String = "中间直流电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_9dedfe88c8a34261 : PT_PT_PHY_014 {
            attribute sourcePortId : String = "PORT::5121::牵引变压器次级交流电能端口::ITM-PHY-014::双向物理";
            attribute portName : String = "牵引变压器次级交流电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_809fd610416051c1 : PT_PT_PHY_002 {
            attribute sourcePortId : String = "PORT::5121::直流牵引供电电能端口::ITM-PHY-002::双向物理";
            attribute portName : String = "直流牵引供电电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = false;
        }
        port rp_56d2d83f54b98301 : ~PT_PT_CMD_013 {
            attribute sourcePortId : String = "PORT::5121::预充电指令输入::ITM-CMD-013::输入";
            attribute portName : String = "预充电指令输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_923b8f78dd634c21 : PT_PT_STA_021 {
            attribute sourcePortId : String = "PORT::5121::预充电状态输出::ITM-STA-021::输出";
            attribute portName : String = "预充电状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_5122 {
        attribute productCode : String = "5122";
        attribute chineseName : String = "输入组件";
        attribute level : Integer = 4;
        attribute parentCode : String = "5120";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_6e156eb66bd95a75 : PT_PT_PHY_003 {
            attribute sourcePortId : String = "PORT::5122::中间直流电能端口::ITM-PHY-003::双向物理";
            attribute portName : String = "中间直流电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_0b57347688ba1240 : PT_PT_PHY_014 {
            attribute sourcePortId : String = "PORT::5122::牵引变压器次级交流电能端口::ITM-PHY-014::双向物理";
            attribute portName : String = "牵引变压器次级交流电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_32a63d8c830a3ed0 : ~PT_PT_CMD_014 {
            attribute sourcePortId : String = "PORT::5122::牵引输入接通指令输入::ITM-CMD-014::输入";
            attribute portName : String = "牵引输入接通指令输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_a512199cf2d52036 : PT_PT_STA_022 {
            attribute sourcePortId : String = "PORT::5122::牵引输入接通状态输出::ITM-STA-022::输出";
            attribute portName : String = "牵引输入接通状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_08aeac9ca9c693f3 : PT_PT_PHY_002 {
            attribute sourcePortId : String = "PORT::5122::直流牵引供电电能端口::ITM-PHY-002::双向物理";
            attribute portName : String = "直流牵引供电电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = false;
        }
    }
    part def P_N_5131 {
        attribute productCode : String = "5131";
        attribute chineseName : String = "网侧变流模块";
        attribute level : Integer = 4;
        attribute parentCode : String = "5130";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_58be8015ffe61769 : PT_PT_MEA_008 {
            attribute sourcePortId : String = "PORT::5131::中间直流母线电压输出::ITM-MEA-008::输出";
            attribute portName : String = "中间直流母线电压输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_0772d9885daa45bb : PT_PT_MEA_009 {
            attribute sourcePortId : String = "PORT::5131::中间直流母线电流输出::ITM-MEA-009::输出";
            attribute portName : String = "中间直流母线电流输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_f010ea68f7dddd01 : PT_PT_PHY_003 {
            attribute sourcePortId : String = "PORT::5131::中间直流电能端口::ITM-PHY-003::双向物理";
            attribute portName : String = "中间直流电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_95979f7c6bb276e7 : PT_PT_ACC_003 {
            attribute sourcePortId : String = "PORT::5131::回馈电网功率输出::ITM-ACC-003::输出";
            attribute portName : String = "回馈电网功率输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_32d77ca0c1d88b50 : PT_PT_PHY_014 {
            attribute sourcePortId : String = "PORT::5131::牵引变压器次级交流电能端口::ITM-PHY-014::双向物理";
            attribute portName : String = "牵引变压器次级交流电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_c06b535bf90fa905 : ~PT_PT_CMD_010 {
            attribute sourcePortId : String = "PORT::5131::网侧变流控制指令输入::ITM-CMD-010::输入";
            attribute portName : String = "网侧变流控制指令输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_3b17660257f9fac5 : PT_PT_MEA_005 {
            attribute sourcePortId : String = "PORT::5131::高压线路电压输出::ITM-MEA-005::输出";
            attribute portName : String = "高压线路电压输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_5e454de063d535e5 : PT_PT_MEA_006 {
            attribute sourcePortId : String = "PORT::5131::高压线路电流输出::ITM-MEA-006::输出";
            attribute portName : String = "高压线路电流输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_5132 {
        attribute productCode : String = "5132";
        attribute chineseName : String = "电机侧变流模块";
        attribute level : Integer = 4;
        attribute parentCode : String = "5130";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_770f7e1c507cc073 : PT_PT_PHY_004 {
            attribute sourcePortId : String = "PORT::5132::三相交流电能端口::ITM-PHY-004::双向物理";
            attribute portName : String = "三相交流电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_4fd822f2b574e9e6 : PT_PT_MEA_008 {
            attribute sourcePortId : String = "PORT::5132::中间直流母线电压输出::ITM-MEA-008::输出";
            attribute portName : String = "中间直流母线电压输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_097124295bc446b2 : PT_PT_MEA_009 {
            attribute sourcePortId : String = "PORT::5132::中间直流母线电流输出::ITM-MEA-009::输出";
            attribute portName : String = "中间直流母线电流输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_e9be022214796a74 : PT_PT_PHY_003 {
            attribute sourcePortId : String = "PORT::5132::中间直流电能端口::ITM-PHY-003::双向物理";
            attribute portName : String = "中间直流电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_75d86c9dc39b94b8 : PT_PT_ACC_002 {
            attribute sourcePortId : String = "PORT::5132::实际再生功率输出::ITM-ACC-002::输出";
            attribute portName : String = "实际再生功率输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_406d292901368d53 : ~PT_PT_CMD_011 {
            attribute sourcePortId : String = "PORT::5132::电机侧变流控制指令输入::ITM-CMD-011::输入";
            attribute portName : String = "电机侧变流控制指令输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_22f4369ba0161f6e : PT_PT_MEA_011 {
            attribute sourcePortId : String = "PORT::5132::电机侧相电压输出::ITM-MEA-011::输出";
            attribute portName : String = "电机侧相电压输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_7044b6667673db95 : PT_PT_MEA_010 {
            attribute sourcePortId : String = "PORT::5132::电机侧相电流输出::ITM-MEA-010::输出";
            attribute portName : String = "电机侧相电流输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_5133 {
        attribute productCode : String = "5133";
        attribute chineseName : String = "放电电阻控制模块";
        attribute level : Integer = 4;
        attribute parentCode : String = "5130";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_60d9996fadd55bff : ~PT_PT_MEA_008 {
            attribute sourcePortId : String = "PORT::5133::中间直流母线电压输入::ITM-MEA-008::输入";
            attribute portName : String = "中间直流母线电压输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_b97ef71e558464ef : PT_PT_PHY_015 {
            attribute sourcePortId : String = "PORT::5133::低压控制电能端口::ITM-PHY-015::双向物理";
            attribute portName : String = "低压控制电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_77ee52e55ac1ca4e : ~PT_PT_CMD_015 {
            attribute sourcePortId : String = "PORT::5133::制动斩波器指令输入::ITM-CMD-015::输入";
            attribute portName : String = "制动斩波器指令输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_ceecb00c1539e058 : PT_PT_STA_023 {
            attribute sourcePortId : String = "PORT::5133::制动斩波器状态输出::ITM-STA-023::输出";
            attribute portName : String = "制动斩波器状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_cb7199d5a5b150b9 : PT_PT_LIM_006 {
            attribute sourcePortId : String = "PORT::5133::制动电阻可耗散功率输出::ITM-LIM-006::输出";
            attribute portName : String = "制动电阻可耗散功率输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_5142 {
        attribute productCode : String = "5142";
        attribute chineseName : String = "放电电阻器";
        attribute level : Integer = 4;
        attribute parentCode : String = "5140";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_14fbc389883862a8 : PT_PT_PHY_003 {
            attribute sourcePortId : String = "PORT::5142::中间直流电能端口::ITM-PHY-003::双向物理";
            attribute portName : String = "中间直流电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_2057e03c844b131c : PT_PT_MEA_024 {
            attribute sourcePortId : String = "PORT::5142::制动电阻温度输出::ITM-MEA-024::输出";
            attribute portName : String = "制动电阻温度输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_ff09931c451e831b : PT_PT_ACC_005 {
            attribute sourcePortId : String = "PORT::5142::制动电阻耗散功率输出::ITM-ACC-005::输出";
            attribute portName : String = "制动电阻耗散功率输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_876f0faee3baf027 : PT_PT_ACC_012 {
            attribute sourcePortId : String = "PORT::5142::制动电阻耗散累计能量输出::ITM-ACC-012::输出";
            attribute portName : String = "制动电阻耗散累计能量输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_7c7ad9996d24b706 : PT_PT_PHY_013 {
            attribute sourcePortId : String = "PORT::5142::热能_热流端口::ITM-PHY-013::双向物理";
            attribute portName : String = "热能/热流端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_5145 {
        attribute productCode : String = "5145";
        attribute chineseName : String = "中间直流环节检测保护组件";
        attribute level : Integer = 4;
        attribute parentCode : String = "5140";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_1680714c67f7d311 : PT_PT_MEA_008 {
            attribute sourcePortId : String = "PORT::5145::中间直流母线电压输出::ITM-MEA-008::输出";
            attribute portName : String = "中间直流母线电压输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_a9cc4822e30a5ede : PT_PT_MEA_009 {
            attribute sourcePortId : String = "PORT::5145::中间直流母线电流输出::ITM-MEA-009::输出";
            attribute portName : String = "中间直流母线电流输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_0fe575c7a29bac8c : PT_PT_STA_020 {
            attribute sourcePortId : String = "PORT::5145::中间直流环节保护状态输出::ITM-STA-020::输出";
            attribute portName : String = "中间直流环节保护状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_b22756bb5d4e9b69 : PT_PT_PHY_015 {
            attribute sourcePortId : String = "PORT::5145::低压控制电能端口::ITM-PHY-015::双向物理";
            attribute portName : String = "低压控制电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_e58f80e07056f3fb : PT_PT_CMD_015 {
            attribute sourcePortId : String = "PORT::5145::制动斩波器指令输出::ITM-CMD-015::输出";
            attribute portName : String = "制动斩波器指令输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_3c3f036735b04fe0 : PT_PT_LIM_007 {
            attribute sourcePortId : String = "PORT::5145::直流母线电压上限输出::ITM-LIM-007::输出";
            attribute portName : String = "直流母线电压上限输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_5311 {
        attribute productCode : String = "5311";
        attribute chineseName : String = "牵引电机";
        attribute level : Integer = 4;
        attribute parentCode : String = "5310";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_57f3c317ac0c860d : PT_PT_PHY_004 {
            attribute sourcePortId : String = "PORT::5311::三相交流电能端口::ITM-PHY-004::双向物理";
            attribute portName : String = "三相交流电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_97eb613c06ae1b2e : PT_PT_PHY_005 {
            attribute sourcePortId : String = "PORT::5311::旋转机械能端口::ITM-PHY-005::双向物理";
            attribute portName : String = "旋转机械能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_10bb4c4f0063bc18 : PT_PT_MEA_012 {
            attribute sourcePortId : String = "PORT::5311::牵引电机实际转矩输出::ITM-MEA-012::输出";
            attribute portName : String = "牵引电机实际转矩输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_79c695a1342df24f : PT_PT_MEA_004 {
            attribute sourcePortId : String = "PORT::5311::牵引电机转速输出::ITM-MEA-004::输出";
            attribute portName : String = "牵引电机转速输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_537e9856bafa2a02 : PT_PT_MEA_011 {
            attribute sourcePortId : String = "PORT::5311::电机侧相电压输出::ITM-MEA-011::输出";
            attribute portName : String = "电机侧相电压输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_147751bb1b62d40a : PT_PT_MEA_010 {
            attribute sourcePortId : String = "PORT::5311::电机侧相电流输出::ITM-MEA-010::输出";
            attribute portName : String = "电机侧相电流输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_7124 {
        attribute productCode : String = "7124";
        attribute chineseName : String = "制动风缸";
        attribute level : Integer = 4;
        attribute parentCode : String = "7120";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_732b5a3acb4e2be0 : PT_PT_PHY_008 {
            attribute sourcePortId : String = "PORT::7124::主风压缩空气端口::ITM-PHY-008::双向物理";
            attribute portName : String = "主风压缩空气端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_d2f380834008b7d7 : PT_PT_MEA_015 {
            attribute sourcePortId : String = "PORT::7124::制动风缸压力输出::ITM-MEA-015::输出";
            attribute portName : String = "制动风缸压力输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_7131 {
        attribute productCode : String = "7131";
        attribute chineseName : String = "总风管";
        attribute level : Integer = 4;
        attribute parentCode : String = "7130";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_e275cbf47ef42c02 : PT_PT_PHY_008 {
            attribute sourcePortId : String = "PORT::7131::总风管末端压缩空气端口::ITM-PHY-008::双向物理";
            attribute portName : String = "总风管末端压缩空气端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_e73ffca5021e0883 : PT_PT_PHY_008 {
            attribute sourcePortId : String = "PORT::7131::总风管首端压缩空气端口::ITM-PHY-008::双向物理";
            attribute portName : String = "总风管首端压缩空气端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_7142 {
        attribute productCode : String = "7142";
        attribute chineseName : String = "总风管压力传感器";
        attribute level : Integer = 4;
        attribute parentCode : String = "7140";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_b1c762907b90d07b : PT_PT_PHY_008 {
            attribute sourcePortId : String = "PORT::7142::主风压缩空气端口::ITM-PHY-008::双向物理";
            attribute portName : String = "主风压缩空气端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_3909c089bc66e61b : PT_PT_STA_009 {
            attribute sourcePortId : String = "PORT::7142::低风压状态输出::ITM-STA-009::输出";
            attribute portName : String = "低风压状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_52f3b82b80918b84 : PT_PT_MEA_014 {
            attribute sourcePortId : String = "PORT::7142::总风管压力输出::ITM-MEA-014::输出";
            attribute portName : String = "总风管压力输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_7211 {
        attribute productCode : String = "7211";
        attribute chineseName : String = "电子制动控制单元(EBCU)";
        attribute level : Integer = 4;
        attribute parentCode : String = "7210";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_b34d5a11f0a32260 : PT_PT_PHY_015 {
            attribute sourcePortId : String = "PORT::7211::低压控制电能端口::ITM-PHY-015::双向物理";
            attribute portName : String = "低压控制电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_19f11c6ee3cbf055 : ~PT_PT_STA_009 {
            attribute sourcePortId : String = "PORT::7211::低风压状态输入::ITM-STA-009::输入";
            attribute portName : String = "低风压状态输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_dc452be8b7368516 : ~PT_PT_MEA_018 {
            attribute sourcePortId : String = "PORT::7211::列车质量输入::ITM-MEA-018::输入";
            attribute portName : String = "列车质量输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_e64f014311f04d50 : ~PT_PT_MEA_001 {
            attribute sourcePortId : String = "PORT::7211::列车速度输入::ITM-MEA-001::输入";
            attribute portName : String = "列车速度输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_daaf414c1711f2bd : ~PT_PT_STA_025 {
            attribute sourcePortId : String = "PORT::7211::制动安全回路状态输入::ITM-STA-025::输入";
            attribute portName : String = "制动安全回路状态输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_ab6bd1b4df7dcdff : PT_PT_STA_008 {
            attribute sourcePortId : String = "PORT::7211::制动拖滞状态输出::ITM-STA-008::输出";
            attribute portName : String = "制动拖滞状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_0209c7a801f78e7e : PT_PT_CMD_031 {
            attribute sourcePortId : String = "PORT::7211::制动控制接触器指令输出::ITM-CMD-031::输出";
            attribute portName : String = "制动控制接触器指令输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_15b87d372ae097d8 : PT_PT_STA_007 {
            attribute sourcePortId : String = "PORT::7211::制动控制故障状态输出::ITM-STA-007::输出";
            attribute portName : String = "制动控制故障状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_77f0053899ab19da : PT_PT_STA_004 {
            attribute sourcePortId : String = "PORT::7211::制动施加状态输出::ITM-STA-004::输出";
            attribute portName : String = "制动施加状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_c4074d88ed5949ec : PT_PT_CMD_022 {
            attribute sourcePortId : String = "PORT::7211::制动电磁阀指令输出::ITM-CMD-022::输出";
            attribute portName : String = "制动电磁阀指令输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_c021f63639408eff : PT_PT_STA_003 {
            attribute sourcePortId : String = "PORT::7211::制动系统可用状态输出::ITM-STA-003::输出";
            attribute portName : String = "制动系统可用状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_abc190a288d4c9d5 : PT_PT_CMD_019 {
            attribute sourcePortId : String = "PORT::7211::制动缓解指令输出::ITM-CMD-019::输出";
            attribute portName : String = "制动缓解指令输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_ef5148faa6dc1c65 : PT_PT_STA_005 {
            attribute sourcePortId : String = "PORT::7211::制动缓解状态输出::ITM-STA-005::输出";
            attribute portName : String = "制动缓解状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_f786158194c89c8a : ~PT_PT_MEA_016 {
            attribute sourcePortId : String = "PORT::7211::制动缸压力输入::ITM-MEA-016::输入";
            attribute portName : String = "制动缸压力输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_a882b33038ce4623 : PT_PT_CMD_020 {
            attribute sourcePortId : String = "PORT::7211::制动隔离指令输出::ITM-CMD-020::输出";
            attribute portName : String = "制动隔离指令输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_43e35aa64c833efc : PT_PT_STA_006 {
            attribute sourcePortId : String = "PORT::7211::制动隔离状态输出::ITM-STA-006::输出";
            attribute portName : String = "制动隔离状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_0194ebfed505dfb5 : PT_PT_CMD_006 {
            attribute sourcePortId : String = "PORT::7211::动态制动力请求输出::ITM-CMD-006::输出";
            attribute portName : String = "动态制动力请求输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_d26568a796272d7a : ~PT_PT_STA_002 {
            attribute sourcePortId : String = "PORT::7211::动态制动可用状态输入::ITM-STA-002::输入";
            attribute portName : String = "动态制动可用状态输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_e4d6047a07b1416e : ~PT_PT_LIM_001 {
            attribute sourcePortId : String = "PORT::7211::可用动态制动力输入::ITM-LIM-001::输入";
            attribute portName : String = "可用动态制动力输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_3e14ce961c10da8c : PT_PT_LIM_002 {
            attribute sourcePortId : String = "PORT::7211::可用摩擦制动力输出::ITM-LIM-002::输出";
            attribute portName : String = "可用摩擦制动力输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_fbdca500826ff2e8 : ~PT_PT_MEA_021 {
            attribute sourcePortId : String = "PORT::7211::可用黏着系数估计输入::ITM-MEA-021::输入";
            attribute portName : String = "可用黏着系数估计输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_5fc26e41f5b877b0 : ~PT_PT_LIM_008 {
            attribute sourcePortId : String = "PORT::7211::可用黏着限制输入::ITM-LIM-008::输入";
            attribute portName : String = "可用黏着限制输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_da3049ae66223d22 : ~PT_PT_CMD_030 {
            attribute sourcePortId : String = "PORT::7211::安全停车_制动请求输入::ITM-CMD-030::输入";
            attribute portName : String = "安全停车/制动请求输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_179bcc3fb8dacbbf : ~PT_PT_MEA_013 {
            attribute sourcePortId : String = "PORT::7211::实际动态制动力输入::ITM-MEA-013::输入";
            attribute portName : String = "实际动态制动力输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_5b7be52aa5b6e9d0 : ~PT_PT_MEA_017 {
            attribute sourcePortId : String = "PORT::7211::实际摩擦制动力输入::ITM-MEA-017::输入";
            attribute portName : String = "实际摩擦制动力输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_04cfaf63bfa3ed70 : ~PT_PT_MEA_014 {
            attribute sourcePortId : String = "PORT::7211::总风管压力输入::ITM-MEA-014::输入";
            attribute portName : String = "总风管压力输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_45bcc846bb19f806 : PT_PT_CMD_007 {
            attribute sourcePortId : String = "PORT::7211::摩擦制动力请求输出::ITM-CMD-007::输出";
            attribute portName : String = "摩擦制动力请求输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_a477083b284f478e : ~PT_PT_LIM_014 {
            attribute sourcePortId : String = "PORT::7211::最大允许减速度输入::ITM-LIM-014::输入";
            attribute portName : String = "最大允许减速度输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_8f4a8ea2188f4411 : ~PT_PT_LIM_013 {
            attribute sourcePortId : String = "PORT::7211::最大允许制动力输入::ITM-LIM-013::输入";
            attribute portName : String = "最大允许制动力输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_77afbfa330bfb95e : ~PT_PT_CMD_003 {
            attribute sourcePortId : String = "PORT::7211::服务制动请求输入::ITM-CMD-003::输入";
            attribute portName : String = "服务制动请求输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_a53270fc181cff7c : PT_PT_CMD_008 {
            attribute sourcePortId : String = "PORT::7211::牵引切除请求输出::ITM-CMD-008::输出";
            attribute portName : String = "牵引切除请求输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_dff51f26bbd38512 : PT_PT_CMD_021 {
            attribute sourcePortId : String = "PORT::7211::电空转换阀指令输出::ITM-CMD-021::输出";
            attribute portName : String = "电空转换阀指令输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_faa6c7c9931b0a58 : ~PT_PT_CMD_004 {
            attribute sourcePortId : String = "PORT::7211::紧急制动请求输入::ITM-CMD-004::输入";
            attribute portName : String = "紧急制动请求输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_ed944339b1333e10 : ~PT_PT_MEA_019 {
            attribute sourcePortId : String = "PORT::7211::车辆载荷系数输入::ITM-MEA-019::输入";
            attribute portName : String = "车辆载荷系数输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_2885b328b968942b : ~PT_PT_MEA_020 {
            attribute sourcePortId : String = "PORT::7211::轮轨滑移率输入::ITM-MEA-020::输入";
            attribute portName : String = "轮轨滑移率输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_91854864e6254d28 : PT_PT_CMD_023 {
            attribute sourcePortId : String = "PORT::7211::防滑干预指令输出::ITM-CMD-023::输出";
            attribute portName : String = "防滑干预指令输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_574d2a0f495ec049 : PT_PT_STA_011 {
            attribute sourcePortId : String = "PORT::7211::防滑故障状态输出::ITM-STA-011::输出";
            attribute portName : String = "防滑故障状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_e71bf6c6a81443a2 : PT_PT_STA_010 {
            attribute sourcePortId : String = "PORT::7211::防滑激活状态输出::ITM-STA-010::输出";
            attribute portName : String = "防滑激活状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_7213 {
        attribute productCode : String = "7213";
        attribute chineseName : String = "制动控制接触器及其他";
        attribute level : Integer = 4;
        attribute parentCode : String = "7210";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_de41681b082603dc : PT_PT_PHY_015 {
            attribute sourcePortId : String = "PORT::7213::低压控制电能端口::ITM-PHY-015::双向物理";
            attribute portName : String = "低压控制电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_de845d22bfa40612 : ~PT_PT_CMD_031 {
            attribute sourcePortId : String = "PORT::7213::制动控制接触器指令输入::ITM-CMD-031::输入";
            attribute portName : String = "制动控制接触器指令输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_a3e87ce99fd880b3 : PT_PT_STA_036 {
            attribute sourcePortId : String = "PORT::7213::制动控制接触器状态输出::ITM-STA-036::输出";
            attribute portName : String = "制动控制接触器状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_7222 {
        attribute productCode : String = "7222";
        attribute chineseName : String = "电空转换阀";
        attribute level : Integer = 4;
        attribute parentCode : String = "7220";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_d9d50ab5a08a26a5 : PT_PT_PHY_008 {
            attribute sourcePortId : String = "PORT::7222::主风压缩空气端口::ITM-PHY-008::双向物理";
            attribute portName : String = "主风压缩空气端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_43816dbefe351165 : PT_PT_PHY_009 {
            attribute sourcePortId : String = "PORT::7222::制动控制压缩空气端口::ITM-PHY-009::双向物理";
            attribute portName : String = "制动控制压缩空气端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_ddeea781987ee55c : ~PT_PT_CMD_021 {
            attribute sourcePortId : String = "PORT::7222::电空转换阀指令输入::ITM-CMD-021::输入";
            attribute portName : String = "电空转换阀指令输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_7223 {
        attribute productCode : String = "7223";
        attribute chineseName : String = "中继阀";
        attribute level : Integer = 4;
        attribute parentCode : String = "7220";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_4abc41bc202f61af : PT_PT_PHY_008 {
            attribute sourcePortId : String = "PORT::7223::主风压缩空气端口::ITM-PHY-008::双向物理";
            attribute portName : String = "主风压缩空气端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_9441f85d6ac8b0ed : PT_PT_PHY_009 {
            attribute sourcePortId : String = "PORT::7223::制动控制压缩空气端口::ITM-PHY-009::双向物理";
            attribute portName : String = "制动控制压缩空气端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_26b22e117179b62a : PT_PT_PHY_010 {
            attribute sourcePortId : String = "PORT::7223::制动缸压缩空气端口::ITM-PHY-010::双向物理";
            attribute portName : String = "制动缸压缩空气端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_7224 {
        attribute productCode : String = "7224";
        attribute chineseName : String = "空重车调整阀";
        attribute level : Integer = 4;
        attribute parentCode : String = "7220";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_291ee811748691f6 : PT_PT_PHY_008 {
            attribute sourcePortId : String = "PORT::7224::主风压缩空气端口::ITM-PHY-008::双向物理";
            attribute portName : String = "主风压缩空气端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_0714bcd5930c027b : PT_PT_PHY_009 {
            attribute sourcePortId : String = "PORT::7224::制动控制压缩空气端口::ITM-PHY-009::双向物理";
            attribute portName : String = "制动控制压缩空气端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_b9cbc1c18f711974 : ~PT_PT_MEA_019 {
            attribute sourcePortId : String = "PORT::7224::车辆载荷系数输入::ITM-MEA-019::输入";
            attribute portName : String = "车辆载荷系数输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_7225 {
        attribute productCode : String = "7225";
        attribute chineseName : String = "控制电磁阀";
        attribute level : Integer = 4;
        attribute parentCode : String = "7220";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_f6a9fd98bacfc4e3 : PT_PT_PHY_008 {
            attribute sourcePortId : String = "PORT::7225::主风压缩空气端口::ITM-PHY-008::双向物理";
            attribute portName : String = "主风压缩空气端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_99bc109c3b70dfed : PT_PT_PHY_009 {
            attribute sourcePortId : String = "PORT::7225::制动控制压缩空气端口::ITM-PHY-009::双向物理";
            attribute portName : String = "制动控制压缩空气端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_8e705d6c34197ff6 : ~PT_PT_CMD_022 {
            attribute sourcePortId : String = "PORT::7225::制动电磁阀指令输入::ITM-CMD-022::输入";
            attribute portName : String = "制动电磁阀指令输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_7226 {
        attribute productCode : String = "7226";
        attribute chineseName : String = "紧急制动阀";
        attribute level : Integer = 4;
        attribute parentCode : String = "7220";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_5cccca40a5c3ac4f : PT_PT_PHY_008 {
            attribute sourcePortId : String = "PORT::7226::主风压缩空气端口::ITM-PHY-008::双向物理";
            attribute portName : String = "主风压缩空气端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_0f31359846cbf234 : PT_PT_PHY_009 {
            attribute sourcePortId : String = "PORT::7226::制动控制压缩空气端口::ITM-PHY-009::双向物理";
            attribute portName : String = "制动控制压缩空气端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_afce9ce1d2c43605 : PT_PT_PHY_010 {
            attribute sourcePortId : String = "PORT::7226::制动缸压缩空气端口::ITM-PHY-010::双向物理";
            attribute portName : String = "制动缸压缩空气端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_da93691eb6e6fca4 : ~PT_PT_CMD_030 {
            attribute sourcePortId : String = "PORT::7226::安全停车_制动请求输入::ITM-CMD-030::输入";
            attribute portName : String = "安全停车/制动请求输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_5f6a9d81cebde2d3 : ~PT_PT_CMD_004 {
            attribute sourcePortId : String = "PORT::7226::紧急制动请求输入::ITM-CMD-004::输入";
            attribute portName : String = "紧急制动请求输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_7227 {
        attribute productCode : String = "7227";
        attribute chineseName : String = "缓解阀";
        attribute level : Integer = 4;
        attribute parentCode : String = "7220";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_f645a5b55a3683c6 : ~PT_PT_CMD_019 {
            attribute sourcePortId : String = "PORT::7227::制动缓解指令输入::ITM-CMD-019::输入";
            attribute portName : String = "制动缓解指令输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_26311db59efd1104 : PT_PT_PHY_010 {
            attribute sourcePortId : String = "PORT::7227::制动缸压缩空气端口::ITM-PHY-010::双向物理";
            attribute portName : String = "制动缸压缩空气端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_7228 {
        attribute productCode : String = "7228";
        attribute chineseName : String = "车厢直接制动截断塞门";
        attribute level : Integer = 4;
        attribute parentCode : String = "7220";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_8b8dde76f47ec820 : ~PT_PT_CMD_020 {
            attribute sourcePortId : String = "PORT::7228::制动隔离指令输入::ITM-CMD-020::输入";
            attribute portName : String = "制动隔离指令输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_3862b3383cf8bb5b : PT_PT_STA_006 {
            attribute sourcePortId : String = "PORT::7228::制动隔离状态输出::ITM-STA-006::输出";
            attribute portName : String = "制动隔离状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_e8a2cfb94eeae29a : PT_PT_PHY_010 {
            attribute sourcePortId : String = "PORT::7228::第一气路制动缸压缩空气端口::ITM-PHY-010::双向物理";
            attribute portName : String = "第一气路制动缸压缩空气端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_9f256ce20a2eedba : PT_PT_PHY_010 {
            attribute sourcePortId : String = "PORT::7228::第二气路制动缸压缩空气端口::ITM-PHY-010::双向物理";
            attribute portName : String = "第二气路制动缸压缩空气端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_7229 {
        attribute productCode : String = "7229";
        attribute chineseName : String = "调压阀";
        attribute level : Integer = 4;
        attribute parentCode : String = "7220";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_b38d34e10f750709 : PT_PT_PHY_008 {
            attribute sourcePortId : String = "PORT::7229::主风压缩空气端口::ITM-PHY-008::双向物理";
            attribute portName : String = "主风压缩空气端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_a8a0abe4af23248d : PT_PT_PHY_009 {
            attribute sourcePortId : String = "PORT::7229::制动控制压缩空气端口::ITM-PHY-009::双向物理";
            attribute portName : String = "制动控制压缩空气端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_722A {
        attribute productCode : String = "722A";
        attribute chineseName : String = "防滑阀组成";
        attribute level : Integer = 4;
        attribute parentCode : String = "7220";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_1d96067b68d03c9c : PT_PT_PHY_010 {
            attribute sourcePortId : String = "PORT::722A::上游制动缸压缩空气端口::ITM-PHY-010::双向物理";
            attribute portName : String = "上游制动缸压缩空气端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_0093bc65af2a8f0a : PT_PT_PHY_010 {
            attribute sourcePortId : String = "PORT::722A::下游制动缸压缩空气端口::ITM-PHY-010::双向物理";
            attribute portName : String = "下游制动缸压缩空气端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_afe779aaa3b0be62 : ~PT_PT_CMD_023 {
            attribute sourcePortId : String = "PORT::722A::防滑干预指令输入::ITM-CMD-023::输入";
            attribute portName : String = "防滑干预指令输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_7d12c51f1034dc2f : PT_PT_STA_011 {
            attribute sourcePortId : String = "PORT::722A::防滑故障状态输出::ITM-STA-011::输出";
            attribute portName : String = "防滑故障状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_396f6a682ced592d : PT_PT_STA_010 {
            attribute sourcePortId : String = "PORT::722A::防滑激活状态输出::ITM-STA-010::输出";
            attribute portName : String = "防滑激活状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_722B {
        attribute productCode : String = "722B";
        attribute chineseName : String = "压力传感器";
        attribute level : Integer = 4;
        attribute parentCode : String = "7220";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_8d219d5375ded80b : PT_PT_MEA_016 {
            attribute sourcePortId : String = "PORT::722B::制动缸压力输出::ITM-MEA-016::输出";
            attribute portName : String = "制动缸压力输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_4861b172f136b92e : PT_PT_PHY_010 {
            attribute sourcePortId : String = "PORT::722B::制动缸压缩空气端口::ITM-PHY-010::双向物理";
            attribute portName : String = "制动缸压缩空气端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_722C {
        attribute productCode : String = "722C";
        attribute chineseName : String = "压力开关";
        attribute level : Integer = 4;
        attribute parentCode : String = "7220";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_6f3dd380decaae91 : PT_PT_STA_009 {
            attribute sourcePortId : String = "PORT::722C::低风压状态输出::ITM-STA-009::输出";
            attribute portName : String = "低风压状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_041b8e496fc7f6c1 : PT_PT_PHY_010 {
            attribute sourcePortId : String = "PORT::722C::制动缸压缩空气端口::ITM-PHY-010::双向物理";
            attribute portName : String = "制动缸压缩空气端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_7252 {
        attribute productCode : String = "7252";
        attribute chineseName : String = "非停放制动夹钳装置";
        attribute level : Integer = 4;
        attribute parentCode : String = "7250";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_2a185ca8ff0ffb1b : PT_PT_STA_004 {
            attribute sourcePortId : String = "PORT::7252::制动施加状态输出::ITM-STA-004::输出";
            attribute portName : String = "制动施加状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_8c7b8a7b8f55d796 : PT_PT_STA_005 {
            attribute sourcePortId : String = "PORT::7252::制动缓解状态输出::ITM-STA-005::输出";
            attribute portName : String = "制动缓解状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_7e02e65996d4ca82 : PT_PT_PHY_010 {
            attribute sourcePortId : String = "PORT::7252::制动缸压缩空气端口::ITM-PHY-010::双向物理";
            attribute portName : String = "制动缸压缩空气端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_6e046e892954d0de : PT_PT_MEA_017 {
            attribute sourcePortId : String = "PORT::7252::实际摩擦制动力输出::ITM-MEA-017::输出";
            attribute portName : String = "实际摩擦制动力输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_b403e112a25e1c53 : PT_PT_PHY_007 {
            attribute sourcePortId : String = "PORT::7252::摩擦制动机械作用端口::ITM-PHY-007::双向物理";
            attribute portName : String = "摩擦制动机械作用端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_7254 {
        attribute productCode : String = "7254";
        attribute chineseName : String = "闸片";
        attribute level : Integer = 4;
        attribute parentCode : String = "7250";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_d9511ef0fa1c17df : PT_PT_PHY_007 {
            attribute sourcePortId : String = "PORT::7254::摩擦制动机械作用端口::ITM-PHY-007::双向物理";
            attribute portName : String = "摩擦制动机械作用端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_7823b5bc99189b72 : PT_PT_ACC_006 {
            attribute sourcePortId : String = "PORT::7254::摩擦制动耗散功率输出::ITM-ACC-006::输出";
            attribute portName : String = "摩擦制动耗散功率输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_02c0f1010de52783 : PT_PT_ACC_013 {
            attribute sourcePortId : String = "PORT::7254::摩擦制动耗散累计能量输出::ITM-ACC-013::输出";
            attribute portName : String = "摩擦制动耗散累计能量输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_a60f1e83b03ea6d4 : PT_PT_PHY_013 {
            attribute sourcePortId : String = "PORT::7254::热能_热流端口::ITM-PHY-013::双向物理";
            attribute portName : String = "热能/热流端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_7255 {
        attribute productCode : String = "7255";
        attribute chineseName : String = "增压缸";
        attribute level : Integer = 4;
        attribute parentCode : String = "7250";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_734246fb536f2b68 : PT_PT_PHY_010 {
            attribute sourcePortId : String = "PORT::7255::制动缸压缩空气端口::ITM-PHY-010::双向物理";
            attribute portName : String = "制动缸压缩空气端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_4c45e349056154be : PT_PT_PHY_007 {
            attribute sourcePortId : String = "PORT::7255::摩擦制动机械作用端口::ITM-PHY-007::双向物理";
            attribute portName : String = "摩擦制动机械作用端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_7281 {
        attribute productCode : String = "7281";
        attribute chineseName : String = "制动指示器";
        attribute level : Integer = 4;
        attribute parentCode : String = "7280";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_2e35e3bc261ab52a : PT_PT_PHY_015 {
            attribute sourcePortId : String = "PORT::7281::低压控制电能端口::ITM-PHY-015::双向物理";
            attribute portName : String = "低压控制电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_b9ead4720ad37cb5 : ~PT_PT_STA_004 {
            attribute sourcePortId : String = "PORT::7281::制动施加状态输入::ITM-STA-004::输入";
            attribute portName : String = "制动施加状态输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_28b3abdb6d1d1e9e : ~PT_PT_STA_005 {
            attribute sourcePortId : String = "PORT::7281::制动缓解状态输入::ITM-STA-005::输入";
            attribute portName : String = "制动缓解状态输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_5158f71b0a56da87 : ~PT_PT_STA_006 {
            attribute sourcePortId : String = "PORT::7281::制动隔离状态输入::ITM-STA-006::输入";
            attribute portName : String = "制动隔离状态输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_7284 {
        attribute productCode : String = "7284";
        attribute chineseName : String = "转向架制动截断塞门";
        attribute level : Integer = 4;
        attribute parentCode : String = "7280";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_0b1d53051662d3f2 : ~PT_PT_CMD_020 {
            attribute sourcePortId : String = "PORT::7284::制动隔离指令输入::ITM-CMD-020::输入";
            attribute portName : String = "制动隔离指令输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_2e5b4d181eadc747 : PT_PT_STA_006 {
            attribute sourcePortId : String = "PORT::7284::制动隔离状态输出::ITM-STA-006::输出";
            attribute portName : String = "制动隔离状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_c958e15a33eb790f : PT_PT_PHY_010 {
            attribute sourcePortId : String = "PORT::7284::第一气路制动缸压缩空气端口::ITM-PHY-010::双向物理";
            attribute portName : String = "第一气路制动缸压缩空气端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_3e963340985cb7bd : PT_PT_PHY_010 {
            attribute sourcePortId : String = "PORT::7284::第二气路制动缸压缩空气端口::ITM-PHY-010::双向物理";
            attribute portName : String = "第二气路制动缸压缩空气端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_7285 {
        attribute productCode : String = "7285";
        attribute chineseName : String = "单轴制动截断塞门";
        attribute level : Integer = 4;
        attribute parentCode : String = "7280";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_c016d56a46e739fc : ~PT_PT_CMD_020 {
            attribute sourcePortId : String = "PORT::7285::制动隔离指令输入::ITM-CMD-020::输入";
            attribute portName : String = "制动隔离指令输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_47c1a16735a84ed9 : PT_PT_STA_006 {
            attribute sourcePortId : String = "PORT::7285::制动隔离状态输出::ITM-STA-006::输出";
            attribute portName : String = "制动隔离状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_73c5051041203267 : PT_PT_PHY_010 {
            attribute sourcePortId : String = "PORT::7285::第一气路制动缸压缩空气端口::ITM-PHY-010::双向物理";
            attribute portName : String = "第一气路制动缸压缩空气端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_337ee35177e1c114 : PT_PT_PHY_010 {
            attribute sourcePortId : String = "PORT::7285::第二气路制动缸压缩空气端口::ITM-PHY-010::双向物理";
            attribute portName : String = "第二气路制动缸压缩空气端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_8121 {
        attribute productCode : String = "8121";
        attribute chineseName : String = "主控制单元";
        attribute level : Integer = 4;
        attribute parentCode : String = "8120";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_d5423b06aaccb6ac : ~PT_PT_STA_027 {
            attribute sourcePortId : String = "PORT::8121::ATP_外部安全系统状态输入::ITM-STA-027::输入";
            attribute portName : String = "ATP/外部安全系统状态输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_d2dfdd1f41baec7a : PT_PT_PHY_015 {
            attribute sourcePortId : String = "PORT::8121::低压控制电能端口::ITM-PHY-015::双向物理";
            attribute portName : String = "低压控制电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_2ee1cd48c6d41ac7 : ~PT_PT_CMD_001 {
            attribute sourcePortId : String = "PORT::8121::列车方向指令输入::ITM-CMD-001::输入";
            attribute portName : String = "列车方向指令输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_8fbe2a98ba0ac28c : PT_PT_CMD_001 {
            attribute sourcePortId : String = "PORT::8121::列车方向指令输出::ITM-CMD-001::输出";
            attribute portName : String = "列车方向指令输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_ef398de483959e24 : ~PT_PT_MEA_001 {
            attribute sourcePortId : String = "PORT::8121::列车速度输入::ITM-MEA-001::输入";
            attribute portName : String = "列车速度输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_36991cec1f7be17b : ~PT_PT_STA_025 {
            attribute sourcePortId : String = "PORT::8121::制动安全回路状态输入::ITM-STA-025::输入";
            attribute portName : String = "制动安全回路状态输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_1c14ea3cdc439198 : ~PT_PT_STA_003 {
            attribute sourcePortId : String = "PORT::8121::制动系统可用状态输入::ITM-STA-003::输入";
            attribute portName : String = "制动系统可用状态输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_4325db72e2d88769 : ~PT_PT_CMD_030 {
            attribute sourcePortId : String = "PORT::8121::安全停车_制动请求输入::ITM-CMD-030::输入";
            attribute portName : String = "安全停车/制动请求输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_0b58c63caeaf2f6d : ~PT_PT_CMD_003 {
            attribute sourcePortId : String = "PORT::8121::服务制动请求输入::ITM-CMD-003::输入";
            attribute portName : String = "服务制动请求输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_d82e5c8a7afb4b7b : PT_PT_CMD_003 {
            attribute sourcePortId : String = "PORT::8121::服务制动请求输出::ITM-CMD-003::输出";
            attribute portName : String = "服务制动请求输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_f4c8eaaf49d11d3d : PT_PT_CMD_009 {
            attribute sourcePortId : String = "PORT::8121::牵引使能指令输出::ITM-CMD-009::输出";
            attribute portName : String = "牵引使能指令输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_c49f12594ff56025 : PT_PT_CMD_008 {
            attribute sourcePortId : String = "PORT::8121::牵引切除请求输出::ITM-CMD-008::输出";
            attribute portName : String = "牵引切除请求输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_37e2c2d63c55e098 : ~PT_PT_STA_001 {
            attribute sourcePortId : String = "PORT::8121::牵引可用状态输入::ITM-STA-001::输入";
            attribute portName : String = "牵引可用状态输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_de2d35d2bcb08b0b : ~PT_PT_STA_026 {
            attribute sourcePortId : String = "PORT::8121::牵引安全回路状态输入::ITM-STA-026::输入";
            attribute portName : String = "牵引安全回路状态输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_a49a67fafe112278 : ~PT_PT_CMD_002 {
            attribute sourcePortId : String = "PORT::8121::牵引指令输入::ITM-CMD-002::输入";
            attribute portName : String = "牵引指令输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_809f8275c004ab18 : PT_PT_CMD_002 {
            attribute sourcePortId : String = "PORT::8121::牵引指令输出::ITM-CMD-002::输出";
            attribute portName : String = "牵引指令输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_1e34bb2697325127 : ~PT_PT_CMD_004 {
            attribute sourcePortId : String = "PORT::8121::紧急制动请求输入::ITM-CMD-004::输入";
            attribute portName : String = "紧急制动请求输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_a9c7eff84933cd80 : PT_PT_CMD_004 {
            attribute sourcePortId : String = "PORT::8121::紧急制动请求输出::ITM-CMD-004::输出";
            attribute portName : String = "紧急制动请求输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_2455eff74badb007 : ~PT_PT_STA_024 {
            attribute sourcePortId : String = "PORT::8121::高压安全回路状态输入::ITM-STA-024::输入";
            attribute portName : String = "高压安全回路状态输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_8122 {
        attribute productCode : String = "8122";
        attribute chineseName : String = "车辆控制单元";
        attribute level : Integer = 4;
        attribute parentCode : String = "8120";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_361eac651ec9fd05 : ~PT_PT_MEA_008 {
            attribute sourcePortId : String = "PORT::8122::中间直流母线电压输入::ITM-MEA-008::输入";
            attribute portName : String = "中间直流母线电压输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_8b55477454952732 : PT_PT_PHY_015 {
            attribute sourcePortId : String = "PORT::8122::低压控制电能端口::ITM-PHY-015::双向物理";
            attribute portName : String = "低压控制电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_4683a7cb63e55daf : PT_PT_CMD_027 {
            attribute sourcePortId : String = "PORT::8122::储能主接触器指令输出::ITM-CMD-027::输出";
            attribute portName : String = "储能主接触器指令输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_77c439392dea95b4 : PT_PT_CMD_025 {
            attribute sourcePortId : String = "PORT::8122::储能功率请求输出::ITM-CMD-025::输出";
            attribute portName : String = "储能功率请求输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_8c3ed075d33335e8 : ~PT_PT_LIM_009 {
            attribute sourcePortId : String = "PORT::8122::储能可用充电功率输入::ITM-LIM-009::输入";
            attribute portName : String = "储能可用充电功率输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_35b0ef67b409e840 : ~PT_PT_LIM_010 {
            attribute sourcePortId : String = "PORT::8122::储能可用放电功率输入::ITM-LIM-010::输入";
            attribute portName : String = "储能可用放电功率输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_a095b9b42ab5cc7d : ~PT_PT_ACC_004 {
            attribute sourcePortId : String = "PORT::8122::储能吸收功率输入::ITM-ACC-004::输入";
            attribute portName : String = "储能吸收功率输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_47c78247980cc3a5 : PT_PT_CMD_029 {
            attribute sourcePortId : String = "PORT::8122::储能故障复位指令输出::ITM-CMD-029::输出";
            attribute portName : String = "储能故障复位指令输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_1967a947dd39d4a5 : ~PT_PT_STA_030 {
            attribute sourcePortId : String = "PORT::8122::储能系统可用状态输入::ITM-STA-030::输入";
            attribute portName : String = "储能系统可用状态输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_9d3500c169fe7103 : ~PT_PT_STA_031 {
            attribute sourcePortId : String = "PORT::8122::储能系统故障状态输入::ITM-STA-031::输入";
            attribute portName : String = "储能系统故障状态输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_f704c2e7bab06749 : PT_PT_CMD_028 {
            attribute sourcePortId : String = "PORT::8122::储能预充电指令输出::ITM-CMD-028::输出";
            attribute portName : String = "储能预充电指令输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_3aaf955421310ab3 : ~PT_PT_LIM_004 {
            attribute sourcePortId : String = "PORT::8122::再生功率上限输入::ITM-LIM-004::输入";
            attribute portName : String = "再生功率上限输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_ac60006ecd824aae : ~PT_PT_CMD_001 {
            attribute sourcePortId : String = "PORT::8122::列车方向指令输入::ITM-CMD-001::输入";
            attribute portName : String = "列车方向指令输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_03fc81b8fdcfa7b2 : ~PT_PT_MEA_001 {
            attribute sourcePortId : String = "PORT::8122::列车速度输入::ITM-MEA-001::输入";
            attribute portName : String = "列车速度输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_dae173a1561f3f35 : ~PT_PT_ACC_005 {
            attribute sourcePortId : String = "PORT::8122::制动电阻耗散功率输入::ITM-ACC-005::输入";
            attribute portName : String = "制动电阻耗散功率输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_b1fb8856841fb7cf : ~PT_PT_STA_003 {
            attribute sourcePortId : String = "PORT::8122::制动系统可用状态输入::ITM-STA-003::输入";
            attribute portName : String = "制动系统可用状态输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_ca63e6a6492a217f : ~PT_PT_STA_002 {
            attribute sourcePortId : String = "PORT::8122::动态制动可用状态输入::ITM-STA-002::输入";
            attribute portName : String = "动态制动可用状态输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_a4aac084c46e1e57 : PT_PT_CMD_026 {
            attribute sourcePortId : String = "PORT::8122::双向DC_DC使能输出::ITM-CMD-026::输出";
            attribute portName : String = "双向DC/DC使能输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_e1808e35289aaba6 : ~PT_PT_MEA_029 {
            attribute sourcePortId : String = "PORT::8122::双向DC_DC实际功率输入::ITM-MEA-029::输入";
            attribute portName : String = "双向DC/DC实际功率输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_e0814e233fa0db3e : ~PT_PT_LIM_001 {
            attribute sourcePortId : String = "PORT::8122::可用动态制动力输入::ITM-LIM-001::输入";
            attribute portName : String = "可用动态制动力输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_eb1cf5594b5796be : ~PT_PT_ACC_003 {
            attribute sourcePortId : String = "PORT::8122::回馈电网功率输入::ITM-ACC-003::输入";
            attribute portName : String = "回馈电网功率输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_ab848f3c1a74117a : ~PT_PT_CMD_030 {
            attribute sourcePortId : String = "PORT::8122::安全停车_制动请求输入::ITM-CMD-030::输入";
            attribute portName : String = "安全停车/制动请求输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_bd78e8d84d334672 : ~PT_PT_ACC_002 {
            attribute sourcePortId : String = "PORT::8122::实际再生功率输入::ITM-ACC-002::输入";
            attribute portName : String = "实际再生功率输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_f36629c6f163833f : ~PT_PT_MEA_013 {
            attribute sourcePortId : String = "PORT::8122::实际动态制动力输入::ITM-MEA-013::输入";
            attribute portName : String = "实际动态制动力输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_abc36140248d0eef : ~PT_PT_LIM_005 {
            attribute sourcePortId : String = "PORT::8122::接触网可接收功率输入::ITM-LIM-005::输入";
            attribute portName : String = "接触网可接收功率输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_f0886e48bf75472f : PT_PT_CMD_024 {
            attribute sourcePortId : String = "PORT::8122::撒砂请求输出::ITM-CMD-024::输出";
            attribute portName : String = "撒砂请求输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_898e3aba50ea7cb4 : ~PT_PT_CMD_003 {
            attribute sourcePortId : String = "PORT::8122::服务制动请求输入::ITM-CMD-003::输入";
            attribute portName : String = "服务制动请求输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_43a34d07ce05b457 : PT_PT_CMD_009 {
            attribute sourcePortId : String = "PORT::8122::牵引使能指令输出::ITM-CMD-009::输出";
            attribute portName : String = "牵引使能指令输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_7df2943f24bd3f24 : PT_PT_CMD_008 {
            attribute sourcePortId : String = "PORT::8122::牵引切除请求输出::ITM-CMD-008::输出";
            attribute portName : String = "牵引切除请求输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_81e596aab3f0fe4c : ~PT_PT_STA_019 {
            attribute sourcePortId : String = "PORT::8122::牵引变流器故障状态输入::ITM-STA-019::输入";
            attribute portName : String = "牵引变流器故障状态输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_b6a69bd683685d04 : ~PT_PT_STA_001 {
            attribute sourcePortId : String = "PORT::8122::牵引可用状态输入::ITM-STA-001::输入";
            attribute portName : String = "牵引可用状态输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_c39f0a202834bb12 : ~PT_PT_CMD_002 {
            attribute sourcePortId : String = "PORT::8122::牵引指令输入::ITM-CMD-002::输入";
            attribute portName : String = "牵引指令输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_361e7dc74e9287e3 : ~PT_PT_CMD_004 {
            attribute sourcePortId : String = "PORT::8122::紧急制动请求输入::ITM-CMD-004::输入";
            attribute portName : String = "紧急制动请求输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_b11b9e2ada11927e : ~PT_PT_ACC_015 {
            attribute sourcePortId : String = "PORT::8122::能量回收率输入::ITM-ACC-015::输入";
            attribute portName : String = "能量回收率输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_6437aa0577c9ccd7 : ~PT_PT_MEA_028 {
            attribute sourcePortId : String = "PORT::8122::超级电容SOC输入::ITM-MEA-028::输入";
            attribute portName : String = "超级电容SOC输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_8125 {
        attribute productCode : String = "8125";
        attribute chineseName : String = "列车级牵引控制单元";
        attribute level : Integer = 4;
        attribute parentCode : String = "8120";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_7262595caaf3b8d8 : ~PT_PT_MEA_008 {
            attribute sourcePortId : String = "PORT::8125::中间直流母线电压输入::ITM-MEA-008::输入";
            attribute portName : String = "中间直流母线电压输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_5184547f4558dae5 : PT_PT_PHY_015 {
            attribute sourcePortId : String = "PORT::8125::低压控制电能端口::ITM-PHY-015::双向物理";
            attribute portName : String = "低压控制电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_91d8f479934c65da : PT_PT_LIM_004 {
            attribute sourcePortId : String = "PORT::8125::再生功率上限输出::ITM-LIM-004::输出";
            attribute portName : String = "再生功率上限输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_4cfbda9683c8c299 : ~PT_PT_MEA_001 {
            attribute sourcePortId : String = "PORT::8125::列车速度输入::ITM-MEA-001::输入";
            attribute portName : String = "列车速度输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_d69905c106b65d8f : ~PT_PT_CMD_006 {
            attribute sourcePortId : String = "PORT::8125::动态制动力请求输入::ITM-CMD-006::输入";
            attribute portName : String = "动态制动力请求输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_dae11d7502a6c37a : PT_PT_STA_002 {
            attribute sourcePortId : String = "PORT::8125::动态制动可用状态输出::ITM-STA-002::输出";
            attribute portName : String = "动态制动可用状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_b60dd66dcfd10afa : PT_PT_LIM_001 {
            attribute sourcePortId : String = "PORT::8125::可用动态制动力输出::ITM-LIM-001::输出";
            attribute portName : String = "可用动态制动力输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_36a59f5828d4c515 : PT_PT_MEA_013 {
            attribute sourcePortId : String = "PORT::8125::实际动态制动力输出::ITM-MEA-013::输出";
            attribute portName : String = "实际动态制动力输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_1809c94f1581c7f8 : ~PT_PT_LIM_005 {
            attribute sourcePortId : String = "PORT::8125::接触网可接收功率输入::ITM-LIM-005::输入";
            attribute portName : String = "接触网可接收功率输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_19dfe907fce085c5 : PT_PT_LIM_003 {
            attribute sourcePortId : String = "PORT::8125::牵引_再生转矩上限输出::ITM-LIM-003::输出";
            attribute portName : String = "牵引/再生转矩上限输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_0e01f3a589418f6c : ~PT_PT_CMD_009 {
            attribute sourcePortId : String = "PORT::8125::牵引使能指令输入::ITM-CMD-009::输入";
            attribute portName : String = "牵引使能指令输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_d86bd7909c634e71 : ~PT_PT_CMD_008 {
            attribute sourcePortId : String = "PORT::8125::牵引切除请求输入::ITM-CMD-008::输入";
            attribute portName : String = "牵引切除请求输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_03e482bfcbcb37c1 : PT_PT_STA_019 {
            attribute sourcePortId : String = "PORT::8125::牵引变流器故障状态输出::ITM-STA-019::输出";
            attribute portName : String = "牵引变流器故障状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_04f0621818e40445 : PT_PT_STA_001 {
            attribute sourcePortId : String = "PORT::8125::牵引可用状态输出::ITM-STA-001::输出";
            attribute portName : String = "牵引可用状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_90deb6e5a4e470f1 : ~PT_PT_STA_026 {
            attribute sourcePortId : String = "PORT::8125::牵引安全回路状态输入::ITM-STA-026::输入";
            attribute portName : String = "牵引安全回路状态输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_713c697d47d94da9 : ~PT_PT_CMD_002 {
            attribute sourcePortId : String = "PORT::8125::牵引指令输入::ITM-CMD-002::输入";
            attribute portName : String = "牵引指令输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_1faca3fc4ff0e741 : ~PT_PT_MEA_012 {
            attribute sourcePortId : String = "PORT::8125::牵引电机实际转矩输入::ITM-MEA-012::输入";
            attribute portName : String = "牵引电机实际转矩输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_70a8e2c4b0887b4d : PT_PT_CMD_012 {
            attribute sourcePortId : String = "PORT::8125::牵引电机转矩请求输出::ITM-CMD-012::输出";
            attribute portName : String = "牵引电机转矩请求输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_4e582bfad9ebbf1d : ~PT_PT_MEA_004 {
            attribute sourcePortId : String = "PORT::8125::牵引电机转速输入::ITM-MEA-004::输入";
            attribute portName : String = "牵引电机转速输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_0964720b73edce27 : PT_PT_STA_018 {
            attribute sourcePortId : String = "PORT::8125::电机侧变流器状态输出::ITM-STA-018::输出";
            attribute portName : String = "电机侧变流器状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_aa028339300f4dbf : PT_PT_STA_017 {
            attribute sourcePortId : String = "PORT::8125::网侧变流器状态输出::ITM-STA-017::输出";
            attribute portName : String = "网侧变流器状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_8127 {
        attribute productCode : String = "8127";
        attribute chineseName : String = "ATP接口单元";
        attribute level : Integer = 4;
        attribute parentCode : String = "8120";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_a916a9847aeadebb : ~PT_PT_STA_027 {
            attribute sourcePortId : String = "PORT::8127::ATP_外部安全系统状态输入::ITM-STA-027::输入";
            attribute portName : String = "ATP/外部安全系统状态输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_a5398c912a371abd : PT_PT_STA_027 {
            attribute sourcePortId : String = "PORT::8127::ATP_外部安全系统状态输出::ITM-STA-027::输出";
            attribute portName : String = "ATP/外部安全系统状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_903b55a0b6383446 : PT_PT_PHY_015 {
            attribute sourcePortId : String = "PORT::8127::低压控制电能端口::ITM-PHY-015::双向物理";
            attribute portName : String = "低压控制电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_be0fc7194a7f0161 : ~PT_PT_CMD_030 {
            attribute sourcePortId : String = "PORT::8127::安全停车_制动请求输入::ITM-CMD-030::输入";
            attribute portName : String = "安全停车/制动请求输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_8f3091a86214dd4e : PT_PT_CMD_030 {
            attribute sourcePortId : String = "PORT::8127::安全停车_制动请求输出::ITM-CMD-030::输出";
            attribute portName : String = "安全停车/制动请求输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_8128 {
        attribute productCode : String = "8128";
        attribute chineseName : String = "输入输出单元";
        attribute level : Integer = 4;
        attribute parentCode : String = "8120";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_ce6397cb7b81dd94 : ~PT_PT_STA_027 {
            attribute sourcePortId : String = "PORT::8128::ATP_外部安全系统状态输入::ITM-STA-027::输入";
            attribute portName : String = "ATP/外部安全系统状态输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_58e3c9dfabb04a51 : PT_PT_STA_027 {
            attribute sourcePortId : String = "PORT::8128::ATP_外部安全系统状态输出::ITM-STA-027::输出";
            attribute portName : String = "ATP/外部安全系统状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_3b5ccced6e75cf2c : PT_PT_PHY_015 {
            attribute sourcePortId : String = "PORT::8128::低压控制电能端口::ITM-PHY-015::双向物理";
            attribute portName : String = "低压控制电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_eea6ab94a057e9f5 : ~PT_PT_STA_025 {
            attribute sourcePortId : String = "PORT::8128::制动安全回路状态输入::ITM-STA-025::输入";
            attribute portName : String = "制动安全回路状态输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_9f2f985b6764bfa7 : PT_PT_STA_025 {
            attribute sourcePortId : String = "PORT::8128::制动安全回路状态输出::ITM-STA-025::输出";
            attribute portName : String = "制动安全回路状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_cc7a917501039195 : ~PT_PT_MEA_016 {
            attribute sourcePortId : String = "PORT::8128::制动缸压力输入::ITM-MEA-016::输入";
            attribute portName : String = "制动缸压力输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_0e19632016b69ff2 : PT_PT_MEA_016 {
            attribute sourcePortId : String = "PORT::8128::制动缸压力输出::ITM-MEA-016::输出";
            attribute portName : String = "制动缸压力输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_ccc90acd04ba0ccc : ~PT_PT_MEA_014 {
            attribute sourcePortId : String = "PORT::8128::总风管压力输入::ITM-MEA-014::输入";
            attribute portName : String = "总风管压力输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_8d19f6989a5bebad : PT_PT_MEA_014 {
            attribute sourcePortId : String = "PORT::8128::总风管压力输出::ITM-MEA-014::输出";
            attribute portName : String = "总风管压力输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_26589bfc82ed6979 : ~PT_PT_CMD_024 {
            attribute sourcePortId : String = "PORT::8128::撒砂请求输入::ITM-CMD-024::输入";
            attribute portName : String = "撒砂请求输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_5accd69f9c3a8b0c : PT_PT_CMD_024 {
            attribute sourcePortId : String = "PORT::8128::撒砂请求输出::ITM-CMD-024::输出";
            attribute portName : String = "撒砂请求输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_9819959a053f9c06 : ~PT_PT_STA_026 {
            attribute sourcePortId : String = "PORT::8128::牵引安全回路状态输入::ITM-STA-026::输入";
            attribute portName : String = "牵引安全回路状态输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_aad98cbe8fa3b27e : PT_PT_STA_026 {
            attribute sourcePortId : String = "PORT::8128::牵引安全回路状态输出::ITM-STA-026::输出";
            attribute portName : String = "牵引安全回路状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_ff26e108accb1302 : ~PT_PT_MEA_027 {
            attribute sourcePortId : String = "PORT::8128::超级电容温度输入::ITM-MEA-027::输入";
            attribute portName : String = "超级电容温度输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_90dd8ed220cd5019 : PT_PT_MEA_027 {
            attribute sourcePortId : String = "PORT::8128::超级电容温度输出::ITM-MEA-027::输出";
            attribute portName : String = "超级电容温度输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_51db14413b84b1f3 : ~PT_PT_MEA_025 {
            attribute sourcePortId : String = "PORT::8128::超级电容电压输入::ITM-MEA-025::输入";
            attribute portName : String = "超级电容电压输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_69aee385a3c44822 : PT_PT_MEA_025 {
            attribute sourcePortId : String = "PORT::8128::超级电容电压输出::ITM-MEA-025::输出";
            attribute portName : String = "超级电容电压输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_c50cfd567a97f3f6 : ~PT_PT_MEA_026 {
            attribute sourcePortId : String = "PORT::8128::超级电容电流输入::ITM-MEA-026::输入";
            attribute portName : String = "超级电容电流输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_bde087e602ad92c8 : PT_PT_MEA_026 {
            attribute sourcePortId : String = "PORT::8128::超级电容电流输出::ITM-MEA-026::输出";
            attribute portName : String = "超级电容电流输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_2b9604597ff0c9ac : ~PT_PT_STA_024 {
            attribute sourcePortId : String = "PORT::8128::高压安全回路状态输入::ITM-STA-024::输入";
            attribute portName : String = "高压安全回路状态输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_cb74be2d7d4a54c7 : PT_PT_STA_024 {
            attribute sourcePortId : String = "PORT::8128::高压安全回路状态输出::ITM-STA-024::输出";
            attribute portName : String = "高压安全回路状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_8151 {
        attribute productCode : String = "8151";
        attribute chineseName : String = "高压安全回路";
        attribute level : Integer = 4;
        attribute parentCode : String = "8150";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_b128738a40d9fcd8 : PT_PT_PHY_015 {
            attribute sourcePortId : String = "PORT::8151::低压控制电能端口::ITM-PHY-015::双向物理";
            attribute portName : String = "低压控制电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_c6902e30a0122c0e : PT_PT_STA_024 {
            attribute sourcePortId : String = "PORT::8151::高压安全回路状态输出::ITM-STA-024::输出";
            attribute portName : String = "高压安全回路状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_d7d7f4cb9554ff03 : ~PT_PT_CMD_016 {
            attribute sourcePortId : String = "PORT::8151::高压断路器指令输入::ITM-CMD-016::输入";
            attribute portName : String = "高压断路器指令输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_8152 {
        attribute productCode : String = "8152";
        attribute chineseName : String = "制动安全回路";
        attribute level : Integer = 4;
        attribute parentCode : String = "8150";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_1e9ebcfb3cef3e9d : PT_PT_PHY_015 {
            attribute sourcePortId : String = "PORT::8152::低压控制电能端口::ITM-PHY-015::双向物理";
            attribute portName : String = "低压控制电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_ae53feffb1e116e3 : PT_PT_STA_025 {
            attribute sourcePortId : String = "PORT::8152::制动安全回路状态输出::ITM-STA-025::输出";
            attribute portName : String = "制动安全回路状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_1e4f882572b04df5 : ~PT_PT_CMD_030 {
            attribute sourcePortId : String = "PORT::8152::安全停车_制动请求输入::ITM-CMD-030::输入";
            attribute portName : String = "安全停车/制动请求输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_93024c6ed1623fbd : ~PT_PT_CMD_004 {
            attribute sourcePortId : String = "PORT::8152::紧急制动请求输入::ITM-CMD-004::输入";
            attribute portName : String = "紧急制动请求输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_8154 {
        attribute productCode : String = "8154";
        attribute chineseName : String = "牵引安全回路";
        attribute level : Integer = 4;
        attribute parentCode : String = "8150";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_caee94e6ee66a74d : PT_PT_PHY_015 {
            attribute sourcePortId : String = "PORT::8154::低压控制电能端口::ITM-PHY-015::双向物理";
            attribute portName : String = "低压控制电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_c3d327abebd9ecfd : ~PT_PT_CMD_009 {
            attribute sourcePortId : String = "PORT::8154::牵引使能指令输入::ITM-CMD-009::输入";
            attribute portName : String = "牵引使能指令输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_a8fff2340df81262 : ~PT_PT_CMD_008 {
            attribute sourcePortId : String = "PORT::8154::牵引切除请求输入::ITM-CMD-008::输入";
            attribute portName : String = "牵引切除请求输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_492d0ced994652db : PT_PT_STA_026 {
            attribute sourcePortId : String = "PORT::8154::牵引安全回路状态输出::ITM-STA-026::输出";
            attribute portName : String = "牵引安全回路状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_8166 {
        attribute productCode : String = "8166";
        attribute chineseName : String = "能量计";
        attribute level : Integer = 4;
        attribute parentCode : String = "8160";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_54d624d57f57843b : ~PT_PT_MEA_008 {
            attribute sourcePortId : String = "PORT::8166::中间直流母线电压输入::ITM-MEA-008::输入";
            attribute portName : String = "中间直流母线电压输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_3b0068559b0ca1e4 : ~PT_PT_MEA_009 {
            attribute sourcePortId : String = "PORT::8166::中间直流母线电流输入::ITM-MEA-009::输入";
            attribute portName : String = "中间直流母线电流输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_937652db70f809a4 : PT_PT_PHY_015 {
            attribute sourcePortId : String = "PORT::8166::低压控制电能端口::ITM-PHY-015::双向物理";
            attribute portName : String = "低压控制电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_c9c2903288a07ce0 : PT_PT_ACC_004 {
            attribute sourcePortId : String = "PORT::8166::储能吸收功率输出::ITM-ACC-004::输出";
            attribute portName : String = "储能吸收功率输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_99ca9a9fac8f0100 : PT_PT_ACC_010 {
            attribute sourcePortId : String = "PORT::8166::储能吸收累计能量输出::ITM-ACC-010::输出";
            attribute portName : String = "储能吸收累计能量输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_68e6377e6e18805d : PT_PT_ACC_011 {
            attribute sourcePortId : String = "PORT::8166::储能释放累计能量输出::ITM-ACC-011::输出";
            attribute portName : String = "储能释放累计能量输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_936489b6fefaa1dd : PT_PT_ACC_008 {
            attribute sourcePortId : String = "PORT::8166::再生发电累计能量输出::ITM-ACC-008::输出";
            attribute portName : String = "再生发电累计能量输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_7f2cae313a3e901f : PT_PT_ACC_005 {
            attribute sourcePortId : String = "PORT::8166::制动电阻耗散功率输出::ITM-ACC-005::输出";
            attribute portName : String = "制动电阻耗散功率输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_468a13002030f7d1 : PT_PT_ACC_012 {
            attribute sourcePortId : String = "PORT::8166::制动电阻耗散累计能量输出::ITM-ACC-012::输出";
            attribute portName : String = "制动电阻耗散累计能量输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_92ee631b1d7b853f : PT_PT_ACC_014 {
            attribute sourcePortId : String = "PORT::8166::可用制动能量输出::ITM-ACC-014::输出";
            attribute portName : String = "可用制动能量输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_945f0734d7cfa81c : PT_PT_ACC_003 {
            attribute sourcePortId : String = "PORT::8166::回馈电网功率输出::ITM-ACC-003::输出";
            attribute portName : String = "回馈电网功率输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_80b4c9ee273dda42 : PT_PT_ACC_009 {
            attribute sourcePortId : String = "PORT::8166::回馈电网累计能量输出::ITM-ACC-009::输出";
            attribute portName : String = "回馈电网累计能量输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_69cd6c357d586ed9 : PT_PT_ACC_002 {
            attribute sourcePortId : String = "PORT::8166::实际再生功率输出::ITM-ACC-002::输出";
            attribute portName : String = "实际再生功率输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_26114df564348068 : PT_PT_ACC_001 {
            attribute sourcePortId : String = "PORT::8166::牵引实际功率输出::ITM-ACC-001::输出";
            attribute portName : String = "牵引实际功率输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_f60bfecb427b2161 : PT_PT_ACC_007 {
            attribute sourcePortId : String = "PORT::8166::牵引累计能量输出::ITM-ACC-007::输出";
            attribute portName : String = "牵引累计能量输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_0d75944292125dac : PT_PT_ACC_015 {
            attribute sourcePortId : String = "PORT::8166::能量回收率输出::ITM-ACC-015::输出";
            attribute portName : String = "能量回收率输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_99f8b39a6442250d : PT_PT_STA_035 {
            attribute sourcePortId : String = "PORT::8166::能量计量有效状态输出::ITM-STA-035::输出";
            attribute portName : String = "能量计量有效状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_573e029523ef9946 : ~PT_PT_MEA_005 {
            attribute sourcePortId : String = "PORT::8166::高压线路电压输入::ITM-MEA-005::输入";
            attribute portName : String = "高压线路电压输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_d9d89be1583c0e18 : ~PT_PT_MEA_006 {
            attribute sourcePortId : String = "PORT::8166::高压线路电流输入::ITM-MEA-006::输入";
            attribute portName : String = "高压线路电流输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_D112 {
        attribute productCode : String = "D112";
        attribute chineseName : String = "方向操作元件";
        attribute level : Integer = 4;
        attribute parentCode : String = "D110";
        attribute role : String = "project_extension";
        attribute sourceType : String = "project_extension";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_8962dea15ad904c6 : PT_PT_CMD_001 {
            attribute sourcePortId : String = "PORT::D112::列车方向指令输出::ITM-CMD-001::输出";
            attribute portName : String = "列车方向指令输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_D113 {
        attribute productCode : String = "D113";
        attribute chineseName : String = "牵引操作元件";
        attribute level : Integer = 4;
        attribute parentCode : String = "D110";
        attribute role : String = "project_extension";
        attribute sourceType : String = "project_extension";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_9ca0d9d396f8ffd0 : PT_PT_CMD_002 {
            attribute sourcePortId : String = "PORT::D113::牵引指令输出::ITM-CMD-002::输出";
            attribute portName : String = "牵引指令输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_D114 {
        attribute productCode : String = "D114";
        attribute chineseName : String = "制动操作元件";
        attribute level : Integer = 4;
        attribute parentCode : String = "D110";
        attribute role : String = "project_extension";
        attribute sourceType : String = "project_extension";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_d3d5739989ecf2dd : PT_PT_CMD_003 {
            attribute sourcePortId : String = "PORT::D114::服务制动请求输出::ITM-CMD-003::输出";
            attribute portName : String = "服务制动请求输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_D121 {
        attribute productCode : String = "D121";
        attribute chineseName : String = "紧急制动按钮";
        attribute level : Integer = 4;
        attribute parentCode : String = "D120";
        attribute role : String = "project_extension";
        attribute sourceType : String = "project_extension";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_d32b32814a84a88a : PT_PT_CMD_004 {
            attribute sourcePortId : String = "PORT::D121::紧急制动请求输出::ITM-CMD-004::输出";
            attribute portName : String = "紧急制动请求输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_D13B {
        attribute productCode : String = "D13B";
        attribute chineseName : String = "撒砂按钮";
        attribute level : Integer = 4;
        attribute parentCode : String = "D130";
        attribute role : String = "project_extension";
        attribute sourceType : String = "project_extension";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_9e466471f9387ad5 : PT_PT_CMD_024 {
            attribute sourcePortId : String = "PORT::D13B::撒砂请求输出::ITM-CMD-024::输出";
            attribute portName : String = "撒砂请求输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_X111 {
        attribute productCode : String = "X111";
        attribute chineseName : String = "双向DC/DC变流模块";
        attribute level : Integer = 4;
        attribute parentCode : String = "X110";
        attribute role : String = "project_extension";
        attribute sourceType : String = "project_extension";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_565c4036e651287e : PT_PT_PHY_003 {
            attribute sourcePortId : String = "PORT::X111::中间直流电能端口::ITM-PHY-003::双向物理";
            attribute portName : String = "中间直流电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_f6cc38ed3ebf357f : PT_PT_PHY_016 {
            attribute sourcePortId : String = "PORT::X111::储能侧直流电能端口::ITM-PHY-016::双向物理";
            attribute portName : String = "储能侧直流电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_3ad794182f43f4d8 : ~PT_PT_CMD_025 {
            attribute sourcePortId : String = "PORT::X111::储能功率请求输入::ITM-CMD-025::输入";
            attribute portName : String = "储能功率请求输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_6085b3266f1baf9d : ~PT_PT_CMD_026 {
            attribute sourcePortId : String = "PORT::X111::双向DC_DC使能输入::ITM-CMD-026::输入";
            attribute portName : String = "双向DC/DC使能输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_9828766df3df1904 : PT_PT_MEA_029 {
            attribute sourcePortId : String = "PORT::X111::双向DC_DC实际功率输出::ITM-MEA-029::输出";
            attribute portName : String = "双向DC/DC实际功率输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_121334297c7e5c44 : PT_PT_STA_029 {
            attribute sourcePortId : String = "PORT::X111::双向DC_DC故障状态输出::ITM-STA-029::输出";
            attribute portName : String = "双向DC/DC故障状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_fbc8c24ae8a5bcdd : PT_PT_STA_028 {
            attribute sourcePortId : String = "PORT::X111::双向DC_DC状态输出::ITM-STA-028::输出";
            attribute portName : String = "双向DC/DC状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_74c67e7bc95576e6 : PT_PT_MEA_030 {
            attribute sourcePortId : String = "PORT::X111::双向DC_DC电流输出::ITM-MEA-030::输出";
            attribute portName : String = "双向DC/DC电流输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_X112 {
        attribute productCode : String = "X112";
        attribute chineseName : String = "双向DC/DC控制模块";
        attribute level : Integer = 4;
        attribute parentCode : String = "X110";
        attribute role : String = "project_extension";
        attribute sourceType : String = "project_extension";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_89849c49127b2dfb : ~PT_PT_MEA_008 {
            attribute sourcePortId : String = "PORT::X112::中间直流母线电压输入::ITM-MEA-008::输入";
            attribute portName : String = "中间直流母线电压输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_569130817376da24 : PT_PT_PHY_015 {
            attribute sourcePortId : String = "PORT::X112::低压控制电能端口::ITM-PHY-015::双向物理";
            attribute portName : String = "低压控制电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_81f1c1da5d6d3173 : ~PT_PT_CMD_027 {
            attribute sourcePortId : String = "PORT::X112::储能主接触器指令输入::ITM-CMD-027::输入";
            attribute portName : String = "储能主接触器指令输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_2ea4241545e6ca09 : PT_PT_CMD_027 {
            attribute sourcePortId : String = "PORT::X112::储能主接触器指令输出::ITM-CMD-027::输出";
            attribute portName : String = "储能主接触器指令输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_f929a9fa6b633837 : ~PT_PT_STA_032 {
            attribute sourcePortId : String = "PORT::X112::储能主接触器状态输入::ITM-STA-032::输入";
            attribute portName : String = "储能主接触器状态输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_00da2edc928b715d : ~PT_PT_STA_034 {
            attribute sourcePortId : String = "PORT::X112::储能保护跳闸状态输入::ITM-STA-034::输入";
            attribute portName : String = "储能保护跳闸状态输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_843fa8c83311440e : ~PT_PT_CMD_025 {
            attribute sourcePortId : String = "PORT::X112::储能功率请求输入::ITM-CMD-025::输入";
            attribute portName : String = "储能功率请求输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_1ca011606f062f80 : PT_PT_CMD_025 {
            attribute sourcePortId : String = "PORT::X112::储能功率请求输出::ITM-CMD-025::输出";
            attribute portName : String = "储能功率请求输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_388d943a537916a7 : PT_PT_LIM_009 {
            attribute sourcePortId : String = "PORT::X112::储能可用充电功率输出::ITM-LIM-009::输出";
            attribute portName : String = "储能可用充电功率输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_73067cce4e6a7eeb : PT_PT_LIM_010 {
            attribute sourcePortId : String = "PORT::X112::储能可用放电功率输出::ITM-LIM-010::输出";
            attribute portName : String = "储能可用放电功率输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_a59821acb0d73604 : PT_PT_ACC_004 {
            attribute sourcePortId : String = "PORT::X112::储能吸收功率输出::ITM-ACC-004::输出";
            attribute portName : String = "储能吸收功率输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_b84f02a624b9982f : ~PT_PT_CMD_029 {
            attribute sourcePortId : String = "PORT::X112::储能故障复位指令输入::ITM-CMD-029::输入";
            attribute portName : String = "储能故障复位指令输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_3b946767139d884a : PT_PT_STA_030 {
            attribute sourcePortId : String = "PORT::X112::储能系统可用状态输出::ITM-STA-030::输出";
            attribute portName : String = "储能系统可用状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_e5eadfefaf46ac0a : PT_PT_STA_031 {
            attribute sourcePortId : String = "PORT::X112::储能系统故障状态输出::ITM-STA-031::输出";
            attribute portName : String = "储能系统故障状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_5ff890136d5d49bf : ~PT_PT_CMD_028 {
            attribute sourcePortId : String = "PORT::X112::储能预充电指令输入::ITM-CMD-028::输入";
            attribute portName : String = "储能预充电指令输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_adb78cdbb75469df : PT_PT_CMD_028 {
            attribute sourcePortId : String = "PORT::X112::储能预充电指令输出::ITM-CMD-028::输出";
            attribute portName : String = "储能预充电指令输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_3ecd9966c9972a7e : ~PT_PT_STA_033 {
            attribute sourcePortId : String = "PORT::X112::储能预充电状态输入::ITM-STA-033::输入";
            attribute portName : String = "储能预充电状态输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_1164249ec859b807 : ~PT_PT_CMD_026 {
            attribute sourcePortId : String = "PORT::X112::双向DC_DC使能输入::ITM-CMD-026::输入";
            attribute portName : String = "双向DC/DC使能输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_f980a38f780089b6 : PT_PT_CMD_026 {
            attribute sourcePortId : String = "PORT::X112::双向DC_DC使能输出::ITM-CMD-026::输出";
            attribute portName : String = "双向DC/DC使能输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_4659cbe7e3b50b58 : ~PT_PT_MEA_029 {
            attribute sourcePortId : String = "PORT::X112::双向DC_DC实际功率输入::ITM-MEA-029::输入";
            attribute portName : String = "双向DC/DC实际功率输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_d8c491383c9a24dc : PT_PT_STA_029 {
            attribute sourcePortId : String = "PORT::X112::双向DC_DC故障状态输出::ITM-STA-029::输出";
            attribute portName : String = "双向DC/DC故障状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_96349f1cf75b3d94 : PT_PT_STA_028 {
            attribute sourcePortId : String = "PORT::X112::双向DC_DC状态输出::ITM-STA-028::输出";
            attribute portName : String = "双向DC/DC状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_88bb7293920adfa8 : ~PT_PT_MEA_030 {
            attribute sourcePortId : String = "PORT::X112::双向DC_DC电流输入::ITM-MEA-030::输入";
            attribute portName : String = "双向DC/DC电流输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_1f01277587ee6905 : ~PT_PT_LIM_007 {
            attribute sourcePortId : String = "PORT::X112::直流母线电压上限输入::ITM-LIM-007::输入";
            attribute portName : String = "直流母线电压上限输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_ced58e17348ff578 : ~PT_PT_MEA_028 {
            attribute sourcePortId : String = "PORT::X112::超级电容SOC输入::ITM-MEA-028::输入";
            attribute portName : String = "超级电容SOC输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_0dcfac1fe8bbd763 : PT_PT_LIM_011 {
            attribute sourcePortId : String = "PORT::X112::超级电容充电允许状态输出::ITM-LIM-011::输出";
            attribute portName : String = "超级电容充电允许状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_651a62a644935ccb : PT_PT_LIM_012 {
            attribute sourcePortId : String = "PORT::X112::超级电容放电允许状态输出::ITM-LIM-012::输出";
            attribute portName : String = "超级电容放电允许状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_848f140649f8e2ae : ~PT_PT_MEA_027 {
            attribute sourcePortId : String = "PORT::X112::超级电容温度输入::ITM-MEA-027::输入";
            attribute portName : String = "超级电容温度输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_fc5798a77b6a020d : ~PT_PT_MEA_025 {
            attribute sourcePortId : String = "PORT::X112::超级电容电压输入::ITM-MEA-025::输入";
            attribute portName : String = "超级电容电压输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_e8341f592e73af5e : ~PT_PT_MEA_026 {
            attribute sourcePortId : String = "PORT::X112::超级电容电流输入::ITM-MEA-026::输入";
            attribute portName : String = "超级电容电流输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_X113 {
        attribute productCode : String = "X113";
        attribute chineseName : String = "双向DC/DC检测保护组件";
        attribute level : Integer = 4;
        attribute parentCode : String = "X110";
        attribute role : String = "project_extension";
        attribute sourceType : String = "project_extension";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_0e45c7ab357a42e6 : PT_PT_MEA_008 {
            attribute sourcePortId : String = "PORT::X113::中间直流母线电压输出::ITM-MEA-008::输出";
            attribute portName : String = "中间直流母线电压输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_571e6f079e1116ac : PT_PT_PHY_003 {
            attribute sourcePortId : String = "PORT::X113::中间直流电能端口::ITM-PHY-003::双向物理";
            attribute portName : String = "中间直流电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_9f0c62635f9ae105 : PT_PT_PHY_015 {
            attribute sourcePortId : String = "PORT::X113::低压控制电能端口::ITM-PHY-015::双向物理";
            attribute portName : String = "低压控制电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_5e8b7419342ecb12 : PT_PT_PHY_016 {
            attribute sourcePortId : String = "PORT::X113::储能侧直流电能端口::ITM-PHY-016::双向物理";
            attribute portName : String = "储能侧直流电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_fdb7d950b1296be2 : PT_PT_STA_034 {
            attribute sourcePortId : String = "PORT::X113::储能保护跳闸状态输出::ITM-STA-034::输出";
            attribute portName : String = "储能保护跳闸状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_bbb42fe7ea40668f : PT_PT_LIM_009 {
            attribute sourcePortId : String = "PORT::X113::储能可用充电功率输出::ITM-LIM-009::输出";
            attribute portName : String = "储能可用充电功率输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_1a2f8620b785c434 : PT_PT_LIM_010 {
            attribute sourcePortId : String = "PORT::X113::储能可用放电功率输出::ITM-LIM-010::输出";
            attribute portName : String = "储能可用放电功率输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_b96276443bd011b6 : PT_PT_STA_031 {
            attribute sourcePortId : String = "PORT::X113::储能系统故障状态输出::ITM-STA-031::输出";
            attribute portName : String = "储能系统故障状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_97ac296a7909b915 : PT_PT_STA_029 {
            attribute sourcePortId : String = "PORT::X113::双向DC_DC故障状态输出::ITM-STA-029::输出";
            attribute portName : String = "双向DC/DC故障状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_30a4f2a71d158c56 : PT_PT_MEA_030 {
            attribute sourcePortId : String = "PORT::X113::双向DC_DC电流输出::ITM-MEA-030::输出";
            attribute portName : String = "双向DC/DC电流输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_d9c32040ebe6917e : PT_PT_LIM_007 {
            attribute sourcePortId : String = "PORT::X113::直流母线电压上限输出::ITM-LIM-007::输出";
            attribute portName : String = "直流母线电压上限输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_180c13c086da3d55 : PT_PT_MEA_027 {
            attribute sourcePortId : String = "PORT::X113::超级电容温度输出::ITM-MEA-027::输出";
            attribute portName : String = "超级电容温度输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_5926a6f58d47dc95 : PT_PT_MEA_025 {
            attribute sourcePortId : String = "PORT::X113::超级电容电压输出::ITM-MEA-025::输出";
            attribute portName : String = "超级电容电压输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_2f7c47b1b3242c83 : PT_PT_MEA_026 {
            attribute sourcePortId : String = "PORT::X113::超级电容电流输出::ITM-MEA-026::输出";
            attribute portName : String = "超级电容电流输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_X121 {
        attribute productCode : String = "X121";
        attribute chineseName : String = "超级电容模块";
        attribute level : Integer = 4;
        attribute parentCode : String = "X120";
        attribute role : String = "project_extension";
        attribute sourceType : String = "project_extension";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_e7b0b50420861015 : PT_PT_PHY_016 {
            attribute sourcePortId : String = "PORT::X121::储能侧直流电能端口::ITM-PHY-016::双向物理";
            attribute portName : String = "储能侧直流电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_387cdae1b4483182 : PT_PT_PHY_013 {
            attribute sourcePortId : String = "PORT::X121::热能_热流端口::ITM-PHY-013::双向物理";
            attribute portName : String = "热能/热流端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_b6cf5a49ced52abf : PT_PT_MEA_028 {
            attribute sourcePortId : String = "PORT::X121::超级电容SOC输出::ITM-MEA-028::输出";
            attribute portName : String = "超级电容SOC输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_X122 {
        attribute productCode : String = "X122";
        attribute chineseName : String = "超级电容电压传感器";
        attribute level : Integer = 4;
        attribute parentCode : String = "X120";
        attribute role : String = "project_extension";
        attribute sourceType : String = "project_extension";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_0b3c69b37f8b252c : PT_PT_PHY_016 {
            attribute sourcePortId : String = "PORT::X122::储能侧直流电能端口::ITM-PHY-016::双向物理";
            attribute portName : String = "储能侧直流电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_370359531bcbeddd : PT_PT_MEA_025 {
            attribute sourcePortId : String = "PORT::X122::超级电容电压输出::ITM-MEA-025::输出";
            attribute portName : String = "超级电容电压输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_X123 {
        attribute productCode : String = "X123";
        attribute chineseName : String = "超级电容电流传感器";
        attribute level : Integer = 4;
        attribute parentCode : String = "X120";
        attribute role : String = "project_extension";
        attribute sourceType : String = "project_extension";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_b6c8109cae13eea5 : PT_PT_PHY_016 {
            attribute sourcePortId : String = "PORT::X123::储能侧直流电能端口::ITM-PHY-016::双向物理";
            attribute portName : String = "储能侧直流电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_9b6812b4ca482c66 : PT_PT_MEA_026 {
            attribute sourcePortId : String = "PORT::X123::超级电容电流输出::ITM-MEA-026::输出";
            attribute portName : String = "超级电容电流输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_X124 {
        attribute productCode : String = "X124";
        attribute chineseName : String = "超级电容温度传感器";
        attribute level : Integer = 4;
        attribute parentCode : String = "X120";
        attribute role : String = "project_extension";
        attribute sourceType : String = "project_extension";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_5083db510ca305a5 : PT_PT_MEA_027 {
            attribute sourcePortId : String = "PORT::X124::超级电容温度输出::ITM-MEA-027::输出";
            attribute portName : String = "超级电容温度输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_4d5eafc70549d9c0 : PT_PT_PHY_013 {
            attribute sourcePortId : String = "PORT::X124::超级电容热能感知端口::ITM-PHY-013::双向物理";
            attribute portName : String = "超级电容热能感知端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_X131 {
        attribute productCode : String = "X131";
        attribute chineseName : String = "储能主接触器";
        attribute level : Integer = 4;
        attribute parentCode : String = "X130";
        attribute role : String = "project_extension";
        attribute sourceType : String = "project_extension";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_b06975e1baff62be : ~PT_PT_CMD_027 {
            attribute sourcePortId : String = "PORT::X131::储能主接触器指令输入::ITM-CMD-027::输入";
            attribute portName : String = "储能主接触器指令输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_c029b3b1472e957d : PT_PT_STA_032 {
            attribute sourcePortId : String = "PORT::X131::储能主接触器状态输出::ITM-STA-032::输出";
            attribute portName : String = "储能主接触器状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_ef3e7082da0c5648 : PT_PT_PHY_016 {
            attribute sourcePortId : String = "PORT::X131::母线段储能侧直流电能端口::ITM-PHY-016::双向物理";
            attribute portName : String = "母线段储能侧直流电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_6bdc28fa4761142d : PT_PT_PHY_016 {
            attribute sourcePortId : String = "PORT::X131::负载段储能侧直流电能端口::ITM-PHY-016::双向物理";
            attribute portName : String = "负载段储能侧直流电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_X132 {
        attribute productCode : String = "X132";
        attribute chineseName : String = "储能预充电组件";
        attribute level : Integer = 4;
        attribute parentCode : String = "X130";
        attribute role : String = "project_extension";
        attribute sourceType : String = "project_extension";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_4d68d3f9ee4e0009 : ~PT_PT_CMD_028 {
            attribute sourcePortId : String = "PORT::X132::储能预充电指令输入::ITM-CMD-028::输入";
            attribute portName : String = "储能预充电指令输入";
            attribute direction : String = "输入";
            attribute activeStatus : Boolean = true;
        }
        port rp_53191daa39f85d49 : PT_PT_STA_033 {
            attribute sourcePortId : String = "PORT::X132::储能预充电状态输出::ITM-STA-033::输出";
            attribute portName : String = "储能预充电状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_0fa709507856ec0b : PT_PT_PHY_016 {
            attribute sourcePortId : String = "PORT::X132::预充输入段储能侧直流电能端口::ITM-PHY-016::双向物理";
            attribute portName : String = "预充输入段储能侧直流电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_1d9e411fc4e0ebf9 : PT_PT_PHY_016 {
            attribute sourcePortId : String = "PORT::X132::预充输出段储能侧直流电能端口::ITM-PHY-016::双向物理";
            attribute portName : String = "预充输出段储能侧直流电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_X133 {
        attribute productCode : String = "X133";
        attribute chineseName : String = "储能支路保护组件";
        attribute level : Integer = 4;
        attribute parentCode : String = "X130";
        attribute role : String = "project_extension";
        attribute sourceType : String = "project_extension";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_da93423081013940 : PT_PT_PHY_015 {
            attribute sourcePortId : String = "PORT::X133::低压控制电能端口::ITM-PHY-015::双向物理";
            attribute portName : String = "低压控制电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_06282bbd1af76861 : PT_PT_PHY_016 {
            attribute sourcePortId : String = "PORT::X133::保护输入段储能侧直流电能端口::ITM-PHY-016::双向物理";
            attribute portName : String = "保护输入段储能侧直流电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_49a2b1a2497ebf63 : PT_PT_PHY_016 {
            attribute sourcePortId : String = "PORT::X133::保护输出段储能侧直流电能端口::ITM-PHY-016::双向物理";
            attribute portName : String = "保护输出段储能侧直流电能端口";
            attribute direction : String = "双向物理";
            attribute activeStatus : Boolean = true;
        }
        port rp_ffcdb33099ab8a28 : PT_PT_STA_034 {
            attribute sourcePortId : String = "PORT::X133::储能保护跳闸状态输出::ITM-STA-034::输出";
            attribute portName : String = "储能保护跳闸状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_0ac161b92c0e41a0 : PT_PT_STA_031 {
            attribute sourcePortId : String = "PORT::X133::储能系统故障状态输出::ITM-STA-031::输出";
            attribute portName : String = "储能系统故障状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_N_3110 {
        attribute productCode : String = "3110";
        attribute chineseName : String = "车轮车轴";
        attribute level : Integer = 3;
        attribute parentCode : String = "3100";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_3111 : P_N_3111;
        part p_N_3112 : P_N_3112;
    }
    part def P_N_3120 {
        attribute productCode : String = "3120";
        attribute chineseName : String = "齿轮箱及附件";
        attribute level : Integer = 3;
        attribute parentCode : String = "3100";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_3121 : P_N_3121;
    }
    part def P_N_3130 {
        attribute productCode : String = "3130";
        attribute chineseName : String = "制动盘";
        attribute level : Integer = 3;
        attribute parentCode : String = "3100";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_3131 : P_N_3131;
        part p_N_3132 : P_N_3132;
        part p_N_3133 : P_N_3133;
    }
    part def P_N_3510 {
        attribute productCode : String = "3510";
        attribute chineseName : String = "传动耦合机构";
        attribute level : Integer = 3;
        attribute parentCode : String = "3500";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_3511 : P_N_3511;
        part p_N_3512 : P_N_3512;
        part p_N_3514 : P_N_3514;
    }
    part def P_N_3640 {
        attribute productCode : String = "3640";
        attribute chineseName : String = "速度检测组件";
        attribute level : Integer = 3;
        attribute parentCode : String = "3600";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_3641 : P_N_3641;
        part p_N_3643 : P_N_3643;
        part p_N_3644 : P_N_3644;
    }
    part def P_N_3810 {
        attribute productCode : String = "3810";
        attribute chineseName : String = "撒砂装置";
        attribute level : Integer = 3;
        attribute parentCode : String = "3800";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_3811 : P_N_3811;
        part p_N_3813 : P_N_3813;
        part p_N_3814 : P_N_3814;
    }
    part def P_N_4110 {
        attribute productCode : String = "4110";
        attribute chineseName : String = "受电弓总成";
        attribute level : Integer = 3;
        attribute parentCode : String = "4100";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_4111 : P_N_4111;
        part p_N_411C : P_N_411C;
    }
    part def P_N_4120 {
        attribute productCode : String = "4120";
        attribute chineseName : String = "其它类型受流组成";
        attribute level : Integer = 3;
        attribute parentCode : String = "4100";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_4121 : P_N_4121;
    }
    part def P_N_4210 {
        attribute productCode : String = "4210";
        attribute chineseName : String = "高压开关";
        attribute level : Integer = 3;
        attribute parentCode : String = "4200";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_4211 : P_N_4211;
        part p_N_4212 : P_N_4212;
    }
    part def P_N_4230 {
        attribute productCode : String = "4230";
        attribute chineseName : String = "高压保护及检测部件";
        attribute level : Integer = 3;
        attribute parentCode : String = "4200";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_4235 : P_N_4235;
        part p_N_4236 : P_N_4236;
        part p_N_4238 : P_N_4238;
        part p_N_4239 : P_N_4239;
    }
    part def P_N_4240 {
        attribute productCode : String = "4240";
        attribute chineseName : String = "能量测量";
        attribute level : Integer = 3;
        attribute parentCode : String = "4200";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_4241 : P_N_4241;
    }
    part def P_N_4410 {
        attribute productCode : String = "4410";
        attribute chineseName : String = "主回路回流设备";
        attribute level : Integer = 3;
        attribute parentCode : String = "4400";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_4411 : P_N_4411;
        part p_N_4412 : P_N_4412;
        part p_N_4413 : P_N_4413;
    }
    part def P_N_4510 {
        attribute productCode : String = "4510";
        attribute chineseName : String = "主变压器主体及其控制";
        attribute level : Integer = 3;
        attribute parentCode : String = "4500";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_4511 : P_N_4511;
        part p_N_4513 : P_N_4513;
        part p_N_4517 : P_N_4517;
        part p_N_4518 : P_N_4518;
    }
    part def P_N_5110 {
        attribute productCode : String = "5110";
        attribute chineseName : String = "牵引变流器控制";
        attribute level : Integer = 3;
        attribute parentCode : String = "5100";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_5111 : P_N_5111;
        part p_N_5112 : P_N_5112;
        part p_N_5113 : P_N_5113;
    }
    part def P_N_5120 {
        attribute productCode : String = "5120";
        attribute chineseName : String = "输入及预充电单元";
        attribute level : Integer = 3;
        attribute parentCode : String = "5100";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_5121 : P_N_5121;
        part p_N_5122 : P_N_5122;
    }
    part def P_N_5130 {
        attribute productCode : String = "5130";
        attribute chineseName : String = "变流模块";
        attribute level : Integer = 3;
        attribute parentCode : String = "5100";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_5131 : P_N_5131;
        part p_N_5132 : P_N_5132;
        part p_N_5133 : P_N_5133;
    }
    part def P_N_5140 {
        attribute productCode : String = "5140";
        attribute chineseName : String = "中间直流环节组件及其";
        attribute level : Integer = 3;
        attribute parentCode : String = "5100";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_5142 : P_N_5142;
        part p_N_5145 : P_N_5145;
    }
    part def P_N_5310 {
        attribute productCode : String = "5310";
        attribute chineseName : String = "牵引电机组成";
        attribute level : Integer = 3;
        attribute parentCode : String = "5300";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_5311 : P_N_5311;
    }
    part def P_N_7120 {
        attribute productCode : String = "7120";
        attribute chineseName : String = "风缸";
        attribute level : Integer = 3;
        attribute parentCode : String = "7100";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_7124 : P_N_7124;
    }
    part def P_N_7130 {
        attribute productCode : String = "7130";
        attribute chineseName : String = "列车级压缩空气分配组件";
        attribute level : Integer = 3;
        attribute parentCode : String = "7100";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_7131 : P_N_7131;
    }
    part def P_N_7140 {
        attribute productCode : String = "7140";
        attribute chineseName : String = "供风压力开关及传感器";
        attribute level : Integer = 3;
        attribute parentCode : String = "7100";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_7142 : P_N_7142;
    }
    part def P_N_7210 {
        attribute productCode : String = "7210";
        attribute chineseName : String = "制动控制组件";
        attribute level : Integer = 3;
        attribute parentCode : String = "7200";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_7211 : P_N_7211;
        part p_N_7213 : P_N_7213;
    }
    part def P_N_7220 {
        attribute productCode : String = "7220";
        attribute chineseName : String = "直接制动控制";
        attribute level : Integer = 3;
        attribute parentCode : String = "7200";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_7222 : P_N_7222;
        part p_N_7223 : P_N_7223;
        part p_N_7224 : P_N_7224;
        part p_N_7225 : P_N_7225;
        part p_N_7226 : P_N_7226;
        part p_N_7227 : P_N_7227;
        part p_N_7228 : P_N_7228;
        part p_N_7229 : P_N_7229;
        part p_N_722A : P_N_722A;
        part p_N_722B : P_N_722B;
        part p_N_722C : P_N_722C;
    }
    part def P_N_7250 {
        attribute productCode : String = "7250";
        attribute chineseName : String = "制动夹钳及其配套组件";
        attribute level : Integer = 3;
        attribute parentCode : String = "7200";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_7252 : P_N_7252;
        part p_N_7254 : P_N_7254;
        part p_N_7255 : P_N_7255;
    }
    part def P_N_7280 {
        attribute productCode : String = "7280";
        attribute chineseName : String = "其它制动元件及附件";
        attribute level : Integer = 3;
        attribute parentCode : String = "7200";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_7281 : P_N_7281;
        part p_N_7284 : P_N_7284;
        part p_N_7285 : P_N_7285;
    }
    part def P_N_8120 {
        attribute productCode : String = "8120";
        attribute chineseName : String = "控制单元及输入输出模块";
        attribute level : Integer = 3;
        attribute parentCode : String = "8100";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_8121 : P_N_8121;
        part p_N_8122 : P_N_8122;
        part p_N_8125 : P_N_8125;
        part p_N_8127 : P_N_8127;
        part p_N_8128 : P_N_8128;
    }
    part def P_N_8150 {
        attribute productCode : String = "8150";
        attribute chineseName : String = "整车级安全回路及其附件";
        attribute level : Integer = 3;
        attribute parentCode : String = "8100";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_8151 : P_N_8151;
        part p_N_8152 : P_N_8152;
        part p_N_8154 : P_N_8154;
    }
    part def P_N_8160 {
        attribute productCode : String = "8160";
        attribute chineseName : String = "其它附件";
        attribute level : Integer = 3;
        attribute parentCode : String = "8100";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_8166 : P_N_8166;
    }
    part def P_D110 {
        attribute productCode : String = "D110";
        attribute chineseName : String = "基本操纵组件";
        attribute level : Integer = 3;
        attribute parentCode : String = "D100";
        attribute role : String = "project_extension";
        attribute sourceType : String = "project_extension";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_D112 : P_D112;
        part p_D113 : P_D113;
        part p_D114 : P_D114;
    }
    part def P_D120 {
        attribute productCode : String = "D120";
        attribute chineseName : String = "紧急响应元件";
        attribute level : Integer = 3;
        attribute parentCode : String = "D100";
        attribute role : String = "project_extension";
        attribute sourceType : String = "project_extension";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_D121 : P_D121;
    }
    part def P_D130 {
        attribute productCode : String = "D130";
        attribute chineseName : String = "开关按钮功能组件";
        attribute level : Integer = 3;
        attribute parentCode : String = "D100";
        attribute role : String = "project_extension";
        attribute sourceType : String = "project_extension";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_D13B : P_D13B;
    }
    part def P_X110 {
        attribute productCode : String = "X110";
        attribute chineseName : String = "双向储能变流及控制";
        attribute level : Integer = 3;
        attribute parentCode : String = "X100";
        attribute role : String = "project_extension";
        attribute sourceType : String = "project_extension";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_X111 : P_X111;
        part p_X112 : P_X112;
        part p_X113 : P_X113;
    }
    part def P_X120 {
        attribute productCode : String = "X120";
        attribute chineseName : String = "超级电容储能组件";
        attribute level : Integer = 3;
        attribute parentCode : String = "X100";
        attribute role : String = "project_extension";
        attribute sourceType : String = "project_extension";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_X121 : P_X121;
        part p_X122 : P_X122;
        part p_X123 : P_X123;
        part p_X124 : P_X124;
    }
    part def P_X130 {
        attribute productCode : String = "X130";
        attribute chineseName : String = "储能接入与保护";
        attribute level : Integer = 3;
        attribute parentCode : String = "X100";
        attribute role : String = "project_extension";
        attribute sourceType : String = "project_extension";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_X131 : P_X131;
        part p_X132 : P_X132;
        part p_X133 : P_X133;
    }
    part def P_N_3100 {
        attribute productCode : String = "3100";
        attribute chineseName : String = "轮轴组成";
        attribute level : Integer = 2;
        attribute parentCode : String = "3000";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_3110 : P_N_3110;
        part p_N_3120 : P_N_3120;
        part p_N_3130 : P_N_3130;
    }
    part def P_N_3500 {
        attribute productCode : String = "3500";
        attribute chineseName : String = "牵引传动耦合组件及其附件";
        attribute level : Integer = 2;
        attribute parentCode : String = "3000";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_3510 : P_N_3510;
    }
    part def P_N_3600 {
        attribute productCode : String = "3600";
        attribute chineseName : String = "转向架相关检测";
        attribute level : Integer = 2;
        attribute parentCode : String = "3000";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_3640 : P_N_3640;
    }
    part def P_N_3800 {
        attribute productCode : String = "3800";
        attribute chineseName : String = "辅助增粘及轮缘润滑";
        attribute level : Integer = 2;
        attribute parentCode : String = "3000";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_3810 : P_N_3810;
    }
    part def P_N_4100 {
        attribute productCode : String = "4100";
        attribute chineseName : String = "高压受流";
        attribute level : Integer = 2;
        attribute parentCode : String = "4000";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_4110 : P_N_4110;
        part p_N_4120 : P_N_4120;
    }
    part def P_N_4200 {
        attribute productCode : String = "4200";
        attribute chineseName : String = "网侧高压分配及控制";
        attribute level : Integer = 2;
        attribute parentCode : String = "4000";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_4210 : P_N_4210;
        part p_N_4230 : P_N_4230;
        part p_N_4240 : P_N_4240;
    }
    part def P_N_4400 {
        attribute productCode : String = "4400";
        attribute chineseName : String = "回流及接地";
        attribute level : Integer = 2;
        attribute parentCode : String = "4000";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_4410 : P_N_4410;
    }
    part def P_N_4500 {
        attribute productCode : String = "4500";
        attribute chineseName : String = "主变压器及其冷却";
        attribute level : Integer = 2;
        attribute parentCode : String = "4000";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_4510 : P_N_4510;
    }
    part def P_N_5100 {
        attribute productCode : String = "5100";
        attribute chineseName : String = "牵引变流器主体及其控制";
        attribute level : Integer = 2;
        attribute parentCode : String = "5000";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_5110 : P_N_5110;
        part p_N_5120 : P_N_5120;
        part p_N_5130 : P_N_5130;
        part p_N_5140 : P_N_5140;
    }
    part def P_N_5300 {
        attribute productCode : String = "5300";
        attribute chineseName : String = "牵引电机及其冷却";
        attribute level : Integer = 2;
        attribute parentCode : String = "5000";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_5310 : P_N_5310;
    }
    part def P_N_7100 {
        attribute productCode : String = "7100";
        attribute chineseName : String = "供风";
        attribute level : Integer = 2;
        attribute parentCode : String = "7000";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_7120 : P_N_7120;
        part p_N_7130 : P_N_7130;
        part p_N_7140 : P_N_7140;
    }
    part def P_N_7200 {
        attribute productCode : String = "7200";
        attribute chineseName : String = "制动";
        attribute level : Integer = 2;
        attribute parentCode : String = "7000";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_7210 : P_N_7210;
        part p_N_7220 : P_N_7220;
        part p_N_7250 : P_N_7250;
        part p_N_7280 : P_N_7280;
    }
    part def P_N_8100 {
        attribute productCode : String = "8100";
        attribute chineseName : String = "列车主干网及安全回路";
        attribute level : Integer = 2;
        attribute parentCode : String = "8000";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_8120 : P_N_8120;
        part p_N_8150 : P_N_8150;
        part p_N_8160 : P_N_8160;
    }
    part def P_D100 {
        attribute productCode : String = "D100";
        attribute chineseName : String = "操纵设施";
        attribute level : Integer = 2;
        attribute parentCode : String = "D000";
        attribute role : String = "project_extension";
        attribute sourceType : String = "project_extension";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_D110 : P_D110;
        part p_D120 : P_D120;
        part p_D130 : P_D130;
    }
    part def P_E100 {
        attribute productCode : String = "E100";
        attribute chineseName : String = "ATP车载";
        attribute level : Integer = 2;
        attribute parentCode : String = "E000";
        attribute role : String = "external_system";
        attribute sourceType : String = "external_system";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = true;
        port rp_0307dc18d9537f9d : PT_PT_STA_027 {
            attribute sourcePortId : String = "PORT::E100::ATP_外部安全系统状态输出::ITM-STA-027::输出";
            attribute portName : String = "ATP/外部安全系统状态输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
        port rp_7273a171b473f816 : PT_PT_CMD_030 {
            attribute sourcePortId : String = "PORT::E100::安全停车_制动请求输出::ITM-CMD-030::输出";
            attribute portName : String = "安全停车/制动请求输出";
            attribute direction : String = "输出";
            attribute activeStatus : Boolean = true;
        }
    }
    part def P_X100 {
        attribute productCode : String = "X100";
        attribute chineseName : String = "车载再生储能";
        attribute level : Integer = 2;
        attribute parentCode : String = "X000";
        attribute role : String = "project_extension";
        attribute sourceType : String = "project_extension";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_X110 : P_X110;
        part p_X120 : P_X120;
        part p_X130 : P_X130;
    }
    part def P_N_3000 {
        attribute productCode : String = "3000";
        attribute chineseName : String = "转向架及其辅助";
        attribute level : Integer = 1;
        attribute parentCode : String = "";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_3100 : P_N_3100;
        part p_N_3500 : P_N_3500;
        part p_N_3600 : P_N_3600;
        part p_N_3800 : P_N_3800;
    }
    part def P_N_4000 {
        attribute productCode : String = "4000";
        attribute chineseName : String = "主供电";
        attribute level : Integer = 1;
        attribute parentCode : String = "";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_4100 : P_N_4100;
        part p_N_4200 : P_N_4200;
        part p_N_4400 : P_N_4400;
        part p_N_4500 : P_N_4500;
    }
    part def P_N_5000 {
        attribute productCode : String = "5000";
        attribute chineseName : String = "牵引";
        attribute level : Integer = 1;
        attribute parentCode : String = "";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_5100 : P_N_5100;
        part p_N_5300 : P_N_5300;
    }
    part def P_N_7000 {
        attribute productCode : String = "7000";
        attribute chineseName : String = "供风制动";
        attribute level : Integer = 1;
        attribute parentCode : String = "";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_7100 : P_N_7100;
        part p_N_7200 : P_N_7200;
    }
    part def P_N_8000 {
        attribute productCode : String = "8000";
        attribute chineseName : String = "网络及辅助监控";
        attribute level : Integer = 1;
        attribute parentCode : String = "";
        attribute role : String = "standard_299";
        attribute sourceType : String = "standard_299";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_N_8100 : P_N_8100;
    }
    part def P_D000 {
        attribute productCode : String = "D000";
        attribute chineseName : String = "驾驶设施";
        attribute level : Integer = 1;
        attribute parentCode : String = "";
        attribute role : String = "project_extension";
        attribute sourceType : String = "project_extension";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_D100 : P_D100;
    }
    part def P_E000 {
        attribute productCode : String = "E000";
        attribute chineseName : String = "电务车载";
        attribute level : Integer = 1;
        attribute parentCode : String = "";
        attribute role : String = "external_system";
        attribute sourceType : String = "external_system";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_E100 : P_E100;
    }
    part def P_X000 {
        attribute productCode : String = "X000";
        attribute chineseName : String = "再生储能扩展";
        attribute level : Integer = 1;
        attribute parentCode : String = "";
        attribute role : String = "project_extension";
        attribute sourceType : String = "project_extension";
        attribute selected : Boolean = true;
        attribute leaf : Boolean = false;
        part p_X100 : P_X100;
    }
    part def B_BOUNDARY_CATENARY_25KV :> ExternalBoundaryBase {
        attribute boundaryId : String = "BOUNDARY-CATENARY-25KV";
        attribute boundaryName : String = "External 25 kV AC catenary";
        attribute domain : String = "electrical";
        port bp_6fe914f662252c4d : PT_PT_PHY_001;
    }
    part def B_BOUNDARY_RAIL :> ExternalBoundaryBase {
        attribute boundaryId : String = "BOUNDARY-RAIL";
        attribute boundaryName : String = "Rail mechanical and traction-return boundary";
        attribute domain : String = "mechanical/electrical";
        port bp_cf72f055f5b12b85 : PT_PT_PHY_006;
        port bp_3a29560c03050dbe : PT_PT_PHY_011;
    }
    part def B_BOUNDARY_THERMAL_ENVIRONMENT :> ExternalBoundaryBase {
        attribute boundaryId : String = "BOUNDARY-THERMAL-ENVIRONMENT";
        attribute boundaryName : String = "Ambient thermal sink";
        attribute domain : String = "thermal";
        port bp_2ac3a221090b246a : PT_PT_PHY_013;
    }
    part def RailSystemContext {
        part p_N_3000 : P_N_3000;
        part p_N_4000 : P_N_4000;
        part p_N_5000 : P_N_5000;
        part p_N_7000 : P_N_7000;
        part p_N_8000 : P_N_8000;
        part p_D000 : P_D000;
        part p_E000 : P_E000;
        part p_X000 : P_X000;
        part boundary_BOUNDARY_CATENARY_25KV : B_BOUNDARY_CATENARY_25KV;
        part boundary_BOUNDARY_RAIL : B_BOUNDARY_RAIL;
        part boundary_BOUNDARY_THERMAL_ENVIRONMENT : B_BOUNDARY_THERMAL_ENVIRONMENT;
    }
}
