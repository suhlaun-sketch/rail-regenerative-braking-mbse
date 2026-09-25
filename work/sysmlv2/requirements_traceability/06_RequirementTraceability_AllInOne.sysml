package RailRequirementTraceability {
    private import ScalarValues::*;
    private import FunctionDefinitions::*;

    requirement def RailRequirement {
        attribute requirementId : String;
        attribute domain : String;
        attribute requirementName : String;
        attribute requirementText : String;
        attribute standardNo : String;
        attribute standardClause : String;
        attribute criteria : String;
        attribute applicableConditions : String;
        attribute requirementType : String;
        attribute verificationStatus : String;
        attribute sourceFile : String;
    }

    requirement req_REQ_TRAC_001 : RailRequirement {
        attribute :>> requirementId = "REQ-TRAC-001";
        attribute :>> domain = "牵引";
        attribute :>> requirementName = "牵引力-速度特性需求";
        attribute :>> requirementText = "列车的牵引力-速度特性和制动力-速度特性应符合设计要求。";
        attribute :>> standardNo = "GB/T 7928-2025";
        attribute :>> standardClause = "6.9";
        attribute :>> criteria = "符合经批准的牵引力-速度、制动力-速度设计特性。";
        attribute :>> applicableConditions = "车辆设计工况；具体特性曲线由项目设计给定。";
        attribute :>> requirementType = "性能";
        attribute :>> verificationStatus = "PARTIALLY_VERIFIED";
        attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
    }

    requirement req_REQ_TRAC_002 : RailRequirement {
        attribute :>> requirementId = "REQ-TRAC-002";
        attribute :>> domain = "牵引";
        attribute :>> requirementName = "起动与加速性能需求";
        attribute :>> requirementText = "列车在规定载荷、轨道、车轮和供电条件下应满足对应速度等级的平均加速度要求。";
        attribute :>> standardNo = "GB/T 7928-2025";
        attribute :>> standardClause = "6.11";
        attribute :>> criteria = "80 km/h等级：0→40 km/h≥1.0 m/s²（动拖比1:1时≥0.83），0→80 km/h≥0.6 m/s²（动拖比1:1时≥0.5）；100 km/h等级：0→45 km/h≥1.0，0→100 km/h≥0.6；120 km/h等级：0→50 km/h≥1.0，0→120 km/h≥0.5。";
        attribute :>> applicableConditions = "定员；平直干燥轨道；车轮半磨耗；额定供电电压。";
        attribute :>> requirementType = "性能";
        attribute :>> verificationStatus = "PARTIALLY_VERIFIED";
        attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
    }

    requirement req_REQ_TRAC_003 : RailRequirement {
        attribute :>> requirementId = "REQ-TRAC-003";
        attribute :>> domain = "牵引";
        attribute :>> requirementName = "黏着利用与防空转/防滑行需求";
        attribute :>> requirementText = "牵引系统应充分利用轮轨黏着条件，按车辆载荷自动调整牵引力或电制动力，并具有防空转、防滑行和防冲动控制。";
        attribute :>> standardNo = "GB/T 7928-2025";
        attribute :>> standardClause = "11.7";
        attribute :>> criteria = "具备载荷自适应牵引/电制动力调节，以及防空转、防滑行、防冲动控制。";
        attribute :>> applicableConditions = "轮轨黏着条件；车辆载荷变化。";
        attribute :>> requirementType = "功能/安全";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
    }

    requirement req_REQ_TRAC_004 : RailRequirement {
        attribute :>> requirementId = "REQ-TRAC-004";
        attribute :>> domain = "牵引";
        attribute :>> requirementName = "交流电传动架构需求";
        attribute :>> requirementText = "电力牵引应采用变频调压的交流电传动系统，并应符合GB/T 37863.1的规定。";
        attribute :>> standardNo = "GB/T 7928-2025";
        attribute :>> standardClause = "11.1";
        attribute :>> criteria = "采用变频调压交流电传动；牵引电传动系统应符合GB/T 37863.1。";
        attribute :>> applicableConditions = "适用于GB/T 7928-2025范围内的地铁车辆；本项目仅验证架构覆盖，不宣称完整标准符合性。";
        attribute :>> requirementType = "架构/约束";
        attribute :>> verificationStatus = "PARTIALLY_VERIFIED";
        attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
    }

    requirement req_REQ_BRK_001 : RailRequirement {
        attribute :>> requirementId = "REQ-BRK-001";
        attribute :>> domain = "制动";
        attribute :>> requirementName = "常用制动平均减速度需求";
        attribute :>> requirementText = "列车从最高运行速度实施常用制动至停车时，平均减速度不应低于1.0 m/s²。";
        attribute :>> standardNo = "GB/T 7928-2025";
        attribute :>> standardClause = "6.12 a)";
        attribute :>> criteria = "平均常用制动减速度 ≥ 1.0 m/s²。";
        attribute :>> applicableConditions = "超员；平直干燥轨道；车轮半磨耗；从最高运行速度制动至停车。";
        attribute :>> requirementType = "性能";
        attribute :>> verificationStatus = "PARTIALLY_VERIFIED";
        attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
    }

    requirement req_REQ_BRK_002 : RailRequirement {
        attribute :>> requirementId = "REQ-BRK-002";
        attribute :>> domain = "制动";
        attribute :>> requirementName = "紧急制动平均减速度需求";
        attribute :>> requirementText = "列车从最高运行速度实施紧急制动至停车时，平均减速度不应低于1.2 m/s²。";
        attribute :>> standardNo = "GB/T 7928-2025";
        attribute :>> standardClause = "6.12 b)";
        attribute :>> criteria = "平均紧急制动减速度 ≥ 1.2 m/s²。";
        attribute :>> applicableConditions = "超员；平直干燥轨道；车轮半磨耗；从最高运行速度制动至停车。";
        attribute :>> requirementType = "性能/安全";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
    }

    requirement req_REQ_BRK_003 : RailRequirement {
        attribute :>> requirementId = "REQ-BRK-003";
        attribute :>> domain = "制动";
        attribute :>> requirementName = "纵向冲击率需求";
        attribute :>> requirementText = "除紧急制动外，列车在牵引或制动过程中纵向冲击率不应大于0.75 m/s³。";
        attribute :>> standardNo = "GB/T 7928-2025";
        attribute :>> standardClause = "6.13";
        attribute :>> criteria = "纵向冲击率 ≤ 0.75 m/s³。";
        attribute :>> applicableConditions = "牵引或非紧急制动过程。";
        attribute :>> requirementType = "舒适性/性能";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
    }

    requirement req_REQ_BRK_004 : RailRequirement {
        attribute :>> requirementId = "REQ-BRK-004";
        attribute :>> domain = "制动";
        attribute :>> requirementName = "电制动与空气制动双制动方式需求";
        attribute :>> requirementText = "列车应具备电制动和空气制动两种制动方式；牵引供电中断或电制动故障时，空气制动仍应使列车安全停车。";
        attribute :>> standardNo = "GB/T 7928-2025";
        attribute :>> standardClause = "10.1";
        attribute :>> criteria = "双制动方式；空气制动具备相对独立的安全停车能力。";
        attribute :>> applicableConditions = "牵引供电中断或电制动故障等意外工况。";
        attribute :>> requirementType = "功能/安全";
        attribute :>> verificationStatus = "PARTIALLY_VERIFIED";
        attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
    }

    requirement req_REQ_BRK_005 : RailRequirement {
        attribute :>> requirementId = "REQ-BRK-005";
        attribute :>> domain = "制动";
        attribute :>> requirementName = "载荷自适应制动力需求";
        attribute :>> requirementText = "制动系统应具有常用制动、紧急制动功能，并能根据载荷变化自动调整制动力大小。";
        attribute :>> standardNo = "GB/T 7928-2025";
        attribute :>> standardClause = "10.2";
        attribute :>> criteria = "制动力随车辆载荷变化自动调整。";
        attribute :>> applicableConditions = "车辆载荷变化。";
        attribute :>> requirementType = "功能";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
    }

    requirement req_REQ_BRK_006 : RailRequirement {
        attribute :>> requirementId = "REQ-BRK-006";
        attribute :>> domain = "制动";
        attribute :>> requirementName = "常用制动电制动优先需求";
        attribute :>> requirementText = "常用制动应优先利用电制动，并具有冲动限制。";
        attribute :>> standardNo = "GB/T 7928-2025";
        attribute :>> standardClause = "10.3";
        attribute :>> criteria = "常用制动优先调用电制动；同时限制制动冲动。";
        attribute :>> applicableConditions = "常用制动。";
        attribute :>> requirementType = "功能/控制";
        attribute :>> verificationStatus = "PARTIALLY_VERIFIED";
        attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
    }

    requirement req_REQ_BRK_007 : RailRequirement {
        attribute :>> requirementId = "REQ-BRK-007";
        attribute :>> domain = "制动";
        attribute :>> requirementName = "再生制动优先需求";
        attribute :>> requirementText = "电制动时宜优先采用再生制动。";
        attribute :>> standardNo = "GB/T 7928-2025";
        attribute :>> standardClause = "10.3";
        attribute :>> criteria = "电制动时优先采用再生制动。";
        attribute :>> applicableConditions = "电制动可用、储能/电网具备可接纳条件时。";
        attribute :>> requirementType = "功能/能量";
        attribute :>> verificationStatus = "VERIFIED";
        attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
    }

    requirement req_REQ_BRK_008 : RailRequirement {
        attribute :>> requirementId = "REQ-BRK-008";
        attribute :>> domain = "制动";
        attribute :>> requirementName = "电空制动平滑转换需求";
        attribute :>> requirementText = "电制动与空气制动应能实现平滑转换。";
        attribute :>> standardNo = "GB/T 7928-2025";
        attribute :>> standardClause = "10.3";
        attribute :>> criteria = "电制动与空气制动之间平滑过渡，不应出现不可接受的制动力突变。";
        attribute :>> applicableConditions = "混合制动切换、低速退出电制动等过程。";
        attribute :>> requirementType = "功能/控制";
        attribute :>> verificationStatus = "PARTIALLY_VERIFIED";
        attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
    }

    requirement req_REQ_BRK_009 : RailRequirement {
        attribute :>> requirementId = "REQ-BRK-009";
        attribute :>> domain = "制动";
        attribute :>> requirementName = "电制动力不足补偿需求";
        attribute :>> requirementText = "电制动力不足时，空气制动应按总制动力要求补充不足的制动力。";
        attribute :>> standardNo = "GB/T 7928-2025";
        attribute :>> standardClause = "10.3";
        attribute :>> criteria = "F_total需求由电制动与空气/机械制动共同满足；电制动不足量由空气/机械制动补足。";
        attribute :>> applicableConditions = "电制动能力受速度、功率、储能等限制时。";
        attribute :>> requirementType = "功能/控制";
        attribute :>> verificationStatus = "VERIFIED";
        attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
    }

    requirement req_REQ_BRK_010 : RailRequirement {
        attribute :>> requirementId = "REQ-BRK-010";
        attribute :>> domain = "制动";
        attribute :>> requirementName = "防滑功能需求";
        attribute :>> requirementText = "制动系统应具有防滑功能。";
        attribute :>> standardNo = "GB/T 7928-2025";
        attribute :>> standardClause = "10.5";
        attribute :>> criteria = "具备防滑控制能力。";
        attribute :>> applicableConditions = "低黏着或车轮滑移风险工况。";
        attribute :>> requirementType = "安全/功能";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
    }

    requirement req_REQ_BRK_011 : RailRequirement {
        attribute :>> requirementId = "REQ-BRK-011";
        attribute :>> domain = "制动";
        attribute :>> requirementName = "停放制动防溜逸需求";
        attribute :>> requirementText = "在线路最大坡度、最大载荷条件下施加停放制动后，列车不应溜逸，停放制动力应仅通过机械方式产生并传递。";
        attribute :>> standardNo = "GB/T 7928-2025";
        attribute :>> standardClause = "10.6";
        attribute :>> criteria = "最大坡度+最大载荷下不溜逸；停放制动力为机械方式。";
        attribute :>> applicableConditions = "线路最大坡度；车辆最大载荷。";
        attribute :>> requirementType = "安全/功能";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
    }

    requirement req_REQ_BRK_012 : RailRequirement {
        attribute :>> requirementId = "REQ-BRK-012";
        attribute :>> domain = "制动";
        attribute :>> requirementName = "空气系统气密性需求";
        attribute :>> requirementText = "空气系统应满足规定的气密性要求。";
        attribute :>> standardNo = "GB/T 7928-2025";
        attribute :>> standardClause = "10.9";
        attribute :>> criteria = "关闭气路5 min后总风压力下降≤20 kPa；制动缸及制动储风缸3 min压力下降≤10 kPa。";
        attribute :>> applicableConditions = "按GB/T 14894规定的气密性试验方法。";
        attribute :>> requirementType = "性能/安全";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
    }

    requirement req_REQ_BRK_013 : RailRequirement {
        attribute :>> requirementId = "REQ-BRK-013";
        attribute :>> domain = "制动";
        attribute :>> requirementName = "制动缸压力控制精度需求";
        attribute :>> requirementText = "基础制动装置的制动缸压力实际值与设计值应满足允许误差要求。";
        attribute :>> standardNo = "GB/T 7928-2025";
        attribute :>> standardClause = "10.10";
        attribute :>> criteria = "制动缸压力实际值与设计值允许误差 ±20 kPa。";
        attribute :>> applicableConditions = "基础制动装置压力控制。";
        attribute :>> requirementType = "性能";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
    }

    requirement req_REQ_BRK_014 : RailRequirement {
        attribute :>> requirementId = "REQ-BRK-014";
        attribute :>> domain = "制动";
        attribute :>> requirementName = "制动辅助诊断与记录需求";
        attribute :>> requirementText = "制动系统应具有轮径校正、负载检测、故障诊断和记录功能。";
        attribute :>> standardNo = "GB/T 7928-2025";
        attribute :>> standardClause = "10.13";
        attribute :>> criteria = "具备轮径校正、负载检测、故障诊断、故障记录。";
        attribute :>> applicableConditions = "制动系统运行与维护。";
        attribute :>> requirementType = "功能/诊断";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
    }

    requirement req_REQ_BRK_015 : RailRequirement {
        attribute :>> requirementId = "REQ-BRK-015";
        attribute :>> domain = "制动";
        attribute :>> requirementName = "电制动完全失效降级需求";
        attribute :>> requirementText = "所有电制动停止工作时，空气制动系统及空气驱动部件应维持规定的安全运行和制动能力。";
        attribute :>> standardNo = "GB/T 7928-2025";
        attribute :>> standardClause = "10.14";
        attribute :>> criteria = "超员工况下可在基础制动热容量允许速度下运行一个往返；制动系统保持设计的常用制动减速度及紧急制动减速度。";
        attribute :>> applicableConditions = "所有电制动停止工作；超员工况。";
        attribute :>> requirementType = "安全/故障";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
    }

    requirement req_REQ_ENE_001 : RailRequirement {
        attribute :>> requirementId = "REQ-ENE-001";
        attribute :>> domain = "能量回收";
        attribute :>> requirementName = "电容式储能电源储存功能需求";
        attribute :>> requirementText = "电容式储能电源应具有能量储存功能，并满足规定的储存能量和储存电压范围。";
        attribute :>> standardNo = "GB/T 42005.1-2022";
        attribute :>> standardClause = "5.2.1";
        attribute :>> criteria = "储存能量为标称能量的100%～120%；储存电压范围宜采用500～900 V。";
        attribute :>> applicableConditions = "适用于采用双电层电容器或混合型电容器的储能式电车动力储能电源；本项目作为X100子系统参考。";
        attribute :>> requirementType = "功能/性能";
        attribute :>> verificationStatus = "PARTIALLY_VERIFIED";
        attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
    }

    requirement req_REQ_ENE_002 : RailRequirement {
        attribute :>> requirementId = "REQ-ENE-002";
        attribute :>> domain = "能量回收";
        attribute :>> requirementName = "储能故障检测、记录与输出需求";
        attribute :>> requirementText = "储能电源应具有故障检测功能，故障应能实时传送给车辆，并应具有故障记录储存和读取功能。";
        attribute :>> standardNo = "GB/T 42005.1-2022";
        attribute :>> standardClause = "5.2.2";
        attribute :>> criteria = "故障检测；实时上传车辆；故障记录可储存并由上位机读取。";
        attribute :>> applicableConditions = "X100储能子系统。";
        attribute :>> requirementType = "功能/诊断";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
    }

    requirement req_REQ_ENE_003 : RailRequirement {
        attribute :>> requirementId = "REQ-ENE-003";
        attribute :>> domain = "能量回收";
        attribute :>> requirementName = "储能通信需求";
        attribute :>> requirementText = "储能电源应具备内部和外部通信能力，状态参数及故障信息应能够传递至电源管理系统和车辆。";
        attribute :>> standardNo = "GB/T 42005.1-2022";
        attribute :>> standardClause = "5.2.3";
        attribute :>> criteria = "模组电压、温度等信息可内部通信；储能状态参数及故障信息可通过外部通信网络发送给车辆。";
        attribute :>> applicableConditions = "X100储能子系统。";
        attribute :>> requirementType = "接口/功能";
        attribute :>> verificationStatus = "PARTIALLY_VERIFIED";
        attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
    }

    requirement req_REQ_ENE_004 : RailRequirement {
        attribute :>> requirementId = "REQ-ENE-004";
        attribute :>> domain = "能量回收";
        attribute :>> requirementName = "储能电压均衡需求";
        attribute :>> requirementText = "储能电源应具有单体及模组间电压均衡功能，并满足规定的电压一致性要求。";
        attribute :>> standardNo = "GB/T 42005.1-2022";
        attribute :>> standardClause = "5.2.4";
        attribute :>> criteria = "额定电压时：双电层电容器单体电压与平均电压之差绝对值≤0.15 V；混合型电容器≤0.1 V。";
        attribute :>> applicableConditions = "额定电压；按储能单元类型选择判据。";
        attribute :>> requirementType = "功能/性能";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
    }

    requirement req_REQ_ENE_005 : RailRequirement {
        attribute :>> requirementId = "REQ-ENE-005";
        attribute :>> domain = "能量回收";
        attribute :>> requirementName = "储能能量效率需求";
        attribute :>> requirementText = "电容式储能电源的充放电能量效率应达到规定要求。";
        attribute :>> standardNo = "GB/T 42005.1-2022";
        attribute :>> standardClause = "5.3.4";
        attribute :>> criteria = "双电层电容器能量效率≥93%；混合型电容器能量效率≥90%。";
        attribute :>> applicableConditions = "按标准规定的充放电试验条件与储能单元类型。";
        attribute :>> requirementType = "性能";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
    }

    requirement req_REQ_ENE_006 : RailRequirement {
        attribute :>> requirementId = "REQ-ENE-006";
        attribute :>> domain = "能量回收";
        attribute :>> requirementName = "储能温度一致性需求";
        attribute :>> requirementText = "储能电源工作过程中最高工作温度及单体温差应满足规定要求。";
        attribute :>> standardNo = "GB/T 42005.1-2022";
        attribute :>> standardClause = "5.3.8";
        attribute :>> criteria = "最高工作温度≤55 ℃；同一时刻最高单体温度与最低单体温度差≤15 ℃。";
        attribute :>> applicableConditions = "储能电源工作过程。";
        attribute :>> requirementType = "性能/安全";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
    }

    requirement req_REQ_ENE_007 : RailRequirement {
        attribute :>> requirementId = "REQ-ENE-007";
        attribute :>> domain = "能量回收";
        attribute :>> requirementName = "储能过温保护需求";
        attribute :>> requirementText = "储能电源应具有过温保护功能，过温时不应爆炸、起火。";
        attribute :>> standardNo = "GB/T 42005.1-2022";
        attribute :>> standardClause = "5.4.2";
        attribute :>> criteria = "具备过温保护；过温时不爆炸、不起火。";
        attribute :>> applicableConditions = "储能电源过温异常工况。";
        attribute :>> requirementType = "安全";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
    }

    requirement req_REQ_ENE_008 : RailRequirement {
        attribute :>> requirementId = "REQ-ENE-008";
        attribute :>> domain = "能量回收";
        attribute :>> requirementName = "储能过流保护需求";
        attribute :>> requirementText = "储能电源正负极两端应具有过流保护功能，过流时不应爆炸、起火。";
        attribute :>> standardNo = "GB/T 42005.1-2022";
        attribute :>> standardClause = "5.4.3";
        attribute :>> criteria = "具备过流保护；过流时不爆炸、不起火。";
        attribute :>> applicableConditions = "储能电源过流异常工况。";
        attribute :>> requirementType = "安全";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
    }

    requirement req_REQ_ENE_009 : RailRequirement {
        attribute :>> requirementId = "REQ-ENE-009";
        attribute :>> domain = "能量回收";
        attribute :>> requirementName = "储能短路保护需求";
        attribute :>> requirementText = "储能电源应具有短路保护功能，短路时不应爆炸、起火。";
        attribute :>> standardNo = "GB/T 42005.1-2022";
        attribute :>> standardClause = "5.4.4";
        attribute :>> criteria = "具备短路保护；短路时不爆炸、不起火。";
        attribute :>> applicableConditions = "储能电源短路异常工况。";
        attribute :>> requirementType = "安全";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
    }

    requirement req_PRJ_BRK_001 : RailRequirement {
        attribute :>> requirementId = "PRJ-BRK-001";
        attribute :>> domain = "制动";
        attribute :>> requirementName = "项目服务制动目标需求";
        attribute :>> requirementText = "本项目服务制动目标减速度设为1.2 m/s²，用于高于GB/T 7928-2025常用制动基线的设计验证与需求变更示例。";
        attribute :>> standardNo = "";
        attribute :>> standardClause = "";
        attribute :>> criteria = "项目目标 a_service = 1.2 m/s²；标准基线为常用制动平均减速度≥1.0 m/s²。";
        attribute :>> applicableConditions = "当前80 t等效动力单元；项目基准工况。";
        attribute :>> requirementType = "项目性能";
        attribute :>> verificationStatus = "VERIFIED";
        attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
    }

    requirement req_PRJ_ENE_001 : RailRequirement {
        attribute :>> requirementId = "PRJ-ENE-001";
        attribute :>> domain = "能量回收";
        attribute :>> requirementName = "无电网再生接纳时车载储能吸收需求";
        attribute :>> requirementText = "在当前仿真设定的电网不接纳再生功率工况下，可利用的再生制动能量应优先进入车载储能系统，并受储能可用能力约束。";
        attribute :>> standardNo = "";
        attribute :>> standardClause = "";
        attribute :>> criteria = "当前场景 grid_regen_acceptance = 0 W；能量优先路由至X100，在功率/SOC/电流限制内吸收。";
        attribute :>> applicableConditions = "当前项目的储能优先仿真场景。";
        attribute :>> requirementType = "项目功能";
        attribute :>> verificationStatus = "VERIFIED";
        attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
    }

    requirement req_PRJ_ENE_002 : RailRequirement {
        attribute :>> requirementId = "PRJ-ENE-002";
        attribute :>> domain = "能量回收";
        attribute :>> requirementName = "储能最大充电功率约束";
        attribute :>> requirementText = "车载储能系统吸收再生功率时，充电功率不得超过项目设定的最大允许充电功率。";
        attribute :>> standardNo = "";
        attribute :>> standardClause = "";
        attribute :>> criteria = "P_charge,max = 600 kW。";
        attribute :>> applicableConditions = "当前X100等效模型。";
        attribute :>> requirementType = "项目约束";
        attribute :>> verificationStatus = "VERIFIED";
        attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
    }

    requirement req_PRJ_ENE_003 : RailRequirement {
        attribute :>> requirementId = "PRJ-ENE-003";
        attribute :>> domain = "能量回收";
        attribute :>> requirementName = "储能电流约束";
        attribute :>> requirementText = "车载储能系统充放电电流不得超过项目设定的电流限制。";
        attribute :>> standardNo = "";
        attribute :>> standardClause = "";
        attribute :>> criteria = "I_max = 900 A。";
        attribute :>> applicableConditions = "当前X100等效模型。";
        attribute :>> requirementType = "项目约束";
        attribute :>> verificationStatus = "PARTIALLY_VERIFIED";
        attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
    }

    requirement req_PRJ_ENE_004 : RailRequirement {
        attribute :>> requirementId = "PRJ-ENE-004";
        attribute :>> domain = "能量回收";
        attribute :>> requirementName = "再生充电SOC上限需求";
        attribute :>> requirementText = "当储能SOC达到项目设定的再生充电上限时，应限制或停止继续吸收再生能量。";
        attribute :>> standardNo = "";
        attribute :>> standardClause = "";
        attribute :>> criteria = "SOC_max_regen = 0.98。";
        attribute :>> applicableConditions = "当前X100等效模型。";
        attribute :>> requirementType = "项目约束";
        attribute :>> verificationStatus = "PARTIALLY_VERIFIED";
        attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
    }

    requirement req_PRJ_PWR_001 : RailRequirement {
        attribute :>> requirementId = "PRJ-PWR-001";
        attribute :>> domain = "供电";
        attribute :>> requirementName = "项目牵引供电制式需求";
        attribute :>> requirementText = "本项目牵引供电采用AC 25 kV、50 Hz作为联合仿真名义工况。";
        attribute :>> standardNo = "GB/T 1402-2025";
        attribute :>> standardClause = "标准背景";
        attribute :>> criteria = "名义供电：AC 25 kV / 50 Hz。";
        attribute :>> applicableConditions = "项目交流电气化轨道车辆单动力单元抽象模型。";
        attribute :>> requirementType = "项目约束";
        attribute :>> verificationStatus = "VERIFIED";
        attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
    }

    item def RequirementFunctionTraceRecord {
        attribute requirementId : String;
        attribute functionId : String;
        attribute relationType : String;
        attribute mappingSource : String;
        attribute coverageStatus : String;
        attribute confidence : String;
        attribute evidence : String;
        attribute semanticEvidence : String;
        attribute structuralEvidence : String;
        attribute evidencePath : String;
        attribute sourceFiles : String;
        attribute sourceFile : String;
        attribute notes : String;
    }

    item RequirementFunctionTraceRecord_001 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-ENE-001";
        attribute :>> functionId = "FN_F_X100_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "EXPLICIT";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "1.0";
        attribute :>> evidence = "正式需求库 known_function_id=FN_F_X100_01";
        attribute :>> semanticEvidence = "需求库中显式填写 known_function_id。";
        attribute :>> structuralEvidence = "\"Excel 显式 Function_ID 与现有 SysML action def 精确匹配。\"";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-ENE-001\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_X100_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9685\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"]";
        attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
        attribute :>> notes = "工程映射；confidence 不是V&V结论";
    }

    item RequirementFunctionTraceRecord_002 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "PRJ-ENE-001";
        attribute :>> functionId = "FN_F_X100_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "EXPLICIT";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "1.0";
        attribute :>> evidence = "正式需求库 known_function_id=FN_F_X100_01";
        attribute :>> semanticEvidence = "需求库中显式填写 known_function_id。";
        attribute :>> structuralEvidence = "\"Excel 显式 Function_ID 与现有 SysML action def 精确匹配。\"";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"PRJ-ENE-001\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_X100_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9685\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"]";
        attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
        attribute :>> notes = "工程映射；confidence 不是V&V结论";
    }

    item RequirementFunctionTraceRecord_003 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "PRJ-ENE-004";
        attribute :>> functionId = "FN_F_X100_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "EXPLICIT";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "1.0";
        attribute :>> evidence = "正式需求库 known_function_id=FN_F_X100_01";
        attribute :>> semanticEvidence = "需求库中显式填写 known_function_id。";
        attribute :>> structuralEvidence = "\"Excel 显式 Function_ID 与现有 SysML action def 精确匹配。\"";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"PRJ-ENE-004\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_X100_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9685\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"]";
        attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
        attribute :>> notes = "工程映射；confidence 不是V&V结论";
    }

    item RequirementFunctionTraceRecord_004 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-TRAC-001";
        attribute :>> functionId = "FN_F_5132_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "牵引电能变换、牵引电机机电转换及反馈；只选取对应变流器/电机控制功能。";
        attribute :>> semanticEvidence = "牵引电能变换、牵引电机机电转换及反馈；只选取对应变流器/电机控制功能。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"5132\",\"owner_product_name\":\"电机侧变流模块\",\"owner_l2_product_id\":\"5100\",\"allocation\":\"allocation alloc_ALLOC_F_5132_01_5132 allocate F_5132_01 to 5132\",\"allocation_id\":\"alloc_ALLOC_F_5132_01_5132\",\"scope_product_ids\":[\"5100\",\"5300\"],\"product_scope_match\":true,\"function_semantic_filter\":\"牵引电能变换、牵引电机机电转换及反馈；只选取对应变流器/电机控制功能。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-TRAC-001\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"INTERFACE\",\"id\":\"IF_IF_MEA_004\",\"source_file\":null},{\"type\":\"FLOW\",\"id\":\"flow::CG_37ECA5B04E215AC3E6A4B472\",\"name\":\"电机侧相电压\",\"kind\":\"energy\",\"connector_refs\":[\"CG_37ECA5B04E215AC3E6A4B472\",\"CG_46A1EE350324445D016EAF45\",\"CG_D4DF5719633CB5B375F35094\"],\"source_product_id\":\"5300\",\"target_product_id\":\"5100\",\"source_file\":null},{\"type\":\"PRODUCT\",\"id\":\"5100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7695\",\"endpoint_role\":\"target\"},{\"type\":\"PRODUCT\",\"id\":\"5132\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4593\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_5132_01_5132\",\"product_id\":\"5132\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11238\",\"evidence\":\"allocation alloc_ALLOC_F_5132_01_5132 allocate F_5132_01 to 5132\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_5132_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8708\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/00_baseline/generated_behaviors/L2_8100_behavior.m\",\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11238\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4593\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11238";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_005 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-TRAC-001";
        attribute :>> functionId = "FN_F_5311_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "牵引电能变换、牵引电机机电转换及反馈；只选取对应变流器/电机控制功能。";
        attribute :>> semanticEvidence = "牵引电能变换、牵引电机机电转换及反馈；只选取对应变流器/电机控制功能。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"5311\",\"owner_product_name\":\"牵引电机\",\"owner_l2_product_id\":\"5300\",\"allocation\":\"allocation alloc_ALLOC_F_5311_01_5311 allocate F_5311_01 to 5311\",\"allocation_id\":\"alloc_ALLOC_F_5311_01_5311\",\"scope_product_ids\":[\"5100\",\"5300\"],\"product_scope_match\":true,\"function_semantic_filter\":\"牵引电能变换、牵引电机机电转换及反馈；只选取对应变流器/电机控制功能。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-TRAC-001\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"INTERFACE\",\"id\":\"IF_IF_MEA_004\",\"source_file\":null},{\"type\":\"FLOW\",\"id\":\"flow::CG_37ECA5B04E215AC3E6A4B472\",\"name\":\"电机侧相电压\",\"kind\":\"energy\",\"connector_refs\":[\"CG_37ECA5B04E215AC3E6A4B472\",\"CG_46A1EE350324445D016EAF45\",\"CG_D4DF5719633CB5B375F35094\"],\"source_product_id\":\"5300\",\"target_product_id\":\"5100\",\"source_file\":null},{\"type\":\"PRODUCT\",\"id\":\"5300\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7709\",\"endpoint_role\":\"source\"},{\"type\":\"PRODUCT\",\"id\":\"5311\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4777\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_5311_01_5311\",\"product_id\":\"5311\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11249\",\"evidence\":\"allocation alloc_ALLOC_F_5311_01_5311 allocate F_5311_01 to 5311\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_5311_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8817\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/00_baseline/generated_behaviors/L2_8100_behavior.m\",\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11249\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4777\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11249";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_006 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-TRAC-001";
        attribute :>> functionId = "FN_F_5311_02";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "牵引电能变换、牵引电机机电转换及反馈；只选取对应变流器/电机控制功能。";
        attribute :>> semanticEvidence = "牵引电能变换、牵引电机机电转换及反馈；只选取对应变流器/电机控制功能。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"5311\",\"owner_product_name\":\"牵引电机\",\"owner_l2_product_id\":\"5300\",\"allocation\":\"allocation alloc_ALLOC_F_5311_02_5311 allocate F_5311_02 to 5311\",\"allocation_id\":\"alloc_ALLOC_F_5311_02_5311\",\"scope_product_ids\":[\"5100\",\"5300\"],\"product_scope_match\":true,\"function_semantic_filter\":\"牵引电能变换、牵引电机机电转换及反馈；只选取对应变流器/电机控制功能。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-TRAC-001\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"INTERFACE\",\"id\":\"IF_IF_MEA_004\",\"source_file\":null},{\"type\":\"FLOW\",\"id\":\"flow::CG_37ECA5B04E215AC3E6A4B472\",\"name\":\"电机侧相电压\",\"kind\":\"energy\",\"connector_refs\":[\"CG_37ECA5B04E215AC3E6A4B472\",\"CG_46A1EE350324445D016EAF45\",\"CG_D4DF5719633CB5B375F35094\"],\"source_product_id\":\"5300\",\"target_product_id\":\"5100\",\"source_file\":null},{\"type\":\"PRODUCT\",\"id\":\"5300\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7709\",\"endpoint_role\":\"source\"},{\"type\":\"PRODUCT\",\"id\":\"5311\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4777\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_5311_02_5311\",\"product_id\":\"5311\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11250\",\"evidence\":\"allocation alloc_ALLOC_F_5311_02_5311 allocate F_5311_02 to 5311\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_5311_02\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8827\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/00_baseline/generated_behaviors/L2_8100_behavior.m\",\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11250\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4777\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11250";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_007 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-TRAC-001";
        attribute :>> functionId = "FN_F_5112_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "牵引电能变换、牵引电机机电转换及反馈；只选取对应变流器/电机控制功能。";
        attribute :>> semanticEvidence = "牵引电能变换、牵引电机机电转换及反馈；只选取对应变流器/电机控制功能。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"5112\",\"owner_product_name\":\"电机侧变流器控制模块\",\"owner_l2_product_id\":\"5100\",\"allocation\":\"allocation alloc_ALLOC_F_5112_01_5112 allocate F_5112_01 to 5112\",\"allocation_id\":\"alloc_ALLOC_F_5112_01_5112\",\"scope_product_ids\":[\"5100\",\"5300\"],\"product_scope_match\":true,\"function_semantic_filter\":\"牵引电能变换、牵引电机机电转换及反馈；只选取对应变流器/电机控制功能。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-TRAC-001\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"INTERFACE\",\"id\":\"IF_IF_MEA_004\",\"source_file\":null},{\"type\":\"FLOW\",\"id\":\"flow::CG_37ECA5B04E215AC3E6A4B472\",\"name\":\"电机侧相电压\",\"kind\":\"energy\",\"connector_refs\":[\"CG_37ECA5B04E215AC3E6A4B472\",\"CG_46A1EE350324445D016EAF45\",\"CG_D4DF5719633CB5B375F35094\"],\"source_product_id\":\"5300\",\"target_product_id\":\"5100\",\"source_file\":null},{\"type\":\"PRODUCT\",\"id\":\"5100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7695\",\"endpoint_role\":\"target\"},{\"type\":\"PRODUCT\",\"id\":\"5112\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4291\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_5112_01_5112\",\"product_id\":\"5112\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11227\",\"evidence\":\"allocation alloc_ALLOC_F_5112_01_5112 allocate F_5112_01 to 5112\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_5112_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8585\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/00_baseline/generated_behaviors/L2_8100_behavior.m\",\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11227\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4291\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11227";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_008 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-TRAC-002";
        attribute :>> functionId = "FN_F_5132_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "速度/转矩控制与牵引电机状态反馈对应既有牵引控制功能。";
        attribute :>> semanticEvidence = "速度/转矩控制与牵引电机状态反馈对应既有牵引控制功能。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"5132\",\"owner_product_name\":\"电机侧变流模块\",\"owner_l2_product_id\":\"5100\",\"allocation\":\"allocation alloc_ALLOC_F_5132_01_5132 allocate F_5132_01 to 5132\",\"allocation_id\":\"alloc_ALLOC_F_5132_01_5132\",\"scope_product_ids\":[\"5100\",\"5300\",\"8100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"速度/转矩控制与牵引电机状态反馈对应既有牵引控制功能。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-TRAC-002\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"INTERFACE\",\"id\":\"IF_IF_MEA_004\",\"source_file\":null},{\"type\":\"FLOW\",\"id\":\"flow::CG_37ECA5B04E215AC3E6A4B472\",\"name\":\"电机侧相电压\",\"kind\":\"energy\",\"connector_refs\":[\"CG_37ECA5B04E215AC3E6A4B472\",\"CG_46A1EE350324445D016EAF45\",\"CG_D4DF5719633CB5B375F35094\"],\"source_product_id\":\"5300\",\"target_product_id\":\"5100\",\"source_file\":null},{\"type\":\"PRODUCT\",\"id\":\"5100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7695\",\"endpoint_role\":\"target\"},{\"type\":\"PRODUCT\",\"id\":\"5132\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4593\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_5132_01_5132\",\"product_id\":\"5132\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11238\",\"evidence\":\"allocation alloc_ALLOC_F_5132_01_5132 allocate F_5132_01 to 5132\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_5132_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8708\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/00_baseline/generated_behaviors/L2_8100_behavior.m\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11238\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4593\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11238";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_009 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-TRAC-002";
        attribute :>> functionId = "FN_F_5311_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "速度/转矩控制与牵引电机状态反馈对应既有牵引控制功能。";
        attribute :>> semanticEvidence = "速度/转矩控制与牵引电机状态反馈对应既有牵引控制功能。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"5311\",\"owner_product_name\":\"牵引电机\",\"owner_l2_product_id\":\"5300\",\"allocation\":\"allocation alloc_ALLOC_F_5311_01_5311 allocate F_5311_01 to 5311\",\"allocation_id\":\"alloc_ALLOC_F_5311_01_5311\",\"scope_product_ids\":[\"5100\",\"5300\",\"8100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"速度/转矩控制与牵引电机状态反馈对应既有牵引控制功能。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-TRAC-002\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"INTERFACE\",\"id\":\"IF_IF_MEA_004\",\"source_file\":null},{\"type\":\"FLOW\",\"id\":\"flow::CG_37ECA5B04E215AC3E6A4B472\",\"name\":\"电机侧相电压\",\"kind\":\"energy\",\"connector_refs\":[\"CG_37ECA5B04E215AC3E6A4B472\",\"CG_46A1EE350324445D016EAF45\",\"CG_D4DF5719633CB5B375F35094\"],\"source_product_id\":\"5300\",\"target_product_id\":\"5100\",\"source_file\":null},{\"type\":\"PRODUCT\",\"id\":\"5300\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7709\",\"endpoint_role\":\"source\"},{\"type\":\"PRODUCT\",\"id\":\"5311\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4777\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_5311_01_5311\",\"product_id\":\"5311\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11249\",\"evidence\":\"allocation alloc_ALLOC_F_5311_01_5311 allocate F_5311_01 to 5311\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_5311_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8817\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/00_baseline/generated_behaviors/L2_8100_behavior.m\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11249\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4777\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11249";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_010 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-TRAC-002";
        attribute :>> functionId = "FN_F_5311_02";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "速度/转矩控制与牵引电机状态反馈对应既有牵引控制功能。";
        attribute :>> semanticEvidence = "速度/转矩控制与牵引电机状态反馈对应既有牵引控制功能。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"5311\",\"owner_product_name\":\"牵引电机\",\"owner_l2_product_id\":\"5300\",\"allocation\":\"allocation alloc_ALLOC_F_5311_02_5311 allocate F_5311_02 to 5311\",\"allocation_id\":\"alloc_ALLOC_F_5311_02_5311\",\"scope_product_ids\":[\"5100\",\"5300\",\"8100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"速度/转矩控制与牵引电机状态反馈对应既有牵引控制功能。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-TRAC-002\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"INTERFACE\",\"id\":\"IF_IF_MEA_004\",\"source_file\":null},{\"type\":\"FLOW\",\"id\":\"flow::CG_37ECA5B04E215AC3E6A4B472\",\"name\":\"电机侧相电压\",\"kind\":\"energy\",\"connector_refs\":[\"CG_37ECA5B04E215AC3E6A4B472\",\"CG_46A1EE350324445D016EAF45\",\"CG_D4DF5719633CB5B375F35094\"],\"source_product_id\":\"5300\",\"target_product_id\":\"5100\",\"source_file\":null},{\"type\":\"PRODUCT\",\"id\":\"5300\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7709\",\"endpoint_role\":\"source\"},{\"type\":\"PRODUCT\",\"id\":\"5311\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4777\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_5311_02_5311\",\"product_id\":\"5311\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11250\",\"evidence\":\"allocation alloc_ALLOC_F_5311_02_5311 allocate F_5311_02 to 5311\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_5311_02\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8827\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/00_baseline/generated_behaviors/L2_8100_behavior.m\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11250\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4777\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11250";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_011 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-TRAC-002";
        attribute :>> functionId = "FN_F_5112_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "速度/转矩控制与牵引电机状态反馈对应既有牵引控制功能。";
        attribute :>> semanticEvidence = "速度/转矩控制与牵引电机状态反馈对应既有牵引控制功能。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"5112\",\"owner_product_name\":\"电机侧变流器控制模块\",\"owner_l2_product_id\":\"5100\",\"allocation\":\"allocation alloc_ALLOC_F_5112_01_5112 allocate F_5112_01 to 5112\",\"allocation_id\":\"alloc_ALLOC_F_5112_01_5112\",\"scope_product_ids\":[\"5100\",\"5300\",\"8100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"速度/转矩控制与牵引电机状态反馈对应既有牵引控制功能。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-TRAC-002\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"INTERFACE\",\"id\":\"IF_IF_MEA_004\",\"source_file\":null},{\"type\":\"FLOW\",\"id\":\"flow::CG_37ECA5B04E215AC3E6A4B472\",\"name\":\"电机侧相电压\",\"kind\":\"energy\",\"connector_refs\":[\"CG_37ECA5B04E215AC3E6A4B472\",\"CG_46A1EE350324445D016EAF45\",\"CG_D4DF5719633CB5B375F35094\"],\"source_product_id\":\"5300\",\"target_product_id\":\"5100\",\"source_file\":null},{\"type\":\"PRODUCT\",\"id\":\"5100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7695\",\"endpoint_role\":\"target\"},{\"type\":\"PRODUCT\",\"id\":\"5112\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4291\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_5112_01_5112\",\"product_id\":\"5112\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11227\",\"evidence\":\"allocation alloc_ALLOC_F_5112_01_5112 allocate F_5112_01 to 5112\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_5112_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8585\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/00_baseline/generated_behaviors/L2_8100_behavior.m\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11227\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4291\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11227";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_012 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-TRAC-003";
        attribute :>> functionId = "FN_F_7211_04";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "PARTIALLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "防滑安全功能、阀压力传递及电机转速反馈对应黏着/空转相关功能；未声称存在独立黏着估算功能。";
        attribute :>> semanticEvidence = "防滑安全功能、阀压力传递及电机转速反馈对应黏着/空转相关功能；未声称存在独立黏着估算功能。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"7211\",\"owner_product_name\":\"电子制动控制单元(EBCU)\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_7211_04_7211 allocate F_7211_04 to 7211\",\"allocation_id\":\"alloc_ALLOC_F_7211_04_7211\",\"scope_product_ids\":[\"5300\",\"7200\",\"8100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"防滑安全功能、阀压力传递及电机转速反馈对应黏着/空转相关功能；未声称存在独立黏着估算功能。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-TRAC-003\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_7211_04_7211\",\"product_id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11264\",\"evidence\":\"allocation alloc_ALLOC_F_7211_04_7211 allocate F_7211_04 to 7211\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_7211_04\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8969\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11264\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11264";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_013 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-TRAC-003";
        attribute :>> functionId = "FN_F_722A_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "PARTIALLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "防滑安全功能、阀压力传递及电机转速反馈对应黏着/空转相关功能；未声称存在独立黏着估算功能。";
        attribute :>> semanticEvidence = "防滑安全功能、阀压力传递及电机转速反馈对应黏着/空转相关功能；未声称存在独立黏着估算功能。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"722A\",\"owner_product_name\":\"防滑阀组成\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_722A_01_722A allocate F_722A_01 to 722A\",\"allocation_id\":\"alloc_ALLOC_F_722A_01_722A\",\"scope_product_ids\":[\"5300\",\"7200\",\"8100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"防滑安全功能、阀压力传递及电机转速反馈对应黏着/空转相关功能；未声称存在独立黏着估算功能。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-TRAC-003\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"722A\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5391\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_722A_01_722A\",\"product_id\":\"722A\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11275\",\"evidence\":\"allocation alloc_ALLOC_F_722A_01_722A allocate F_722A_01 to 722A\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_722A_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9097\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11275\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5391\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11275";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_014 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-TRAC-003";
        attribute :>> functionId = "FN_F_5311_02";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "PARTIALLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "防滑安全功能、阀压力传递及电机转速反馈对应黏着/空转相关功能；未声称存在独立黏着估算功能。";
        attribute :>> semanticEvidence = "防滑安全功能、阀压力传递及电机转速反馈对应黏着/空转相关功能；未声称存在独立黏着估算功能。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"5311\",\"owner_product_name\":\"牵引电机\",\"owner_l2_product_id\":\"5300\",\"allocation\":\"allocation alloc_ALLOC_F_5311_02_5311 allocate F_5311_02 to 5311\",\"allocation_id\":\"alloc_ALLOC_F_5311_02_5311\",\"scope_product_ids\":[\"5300\",\"7200\",\"8100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"防滑安全功能、阀压力传递及电机转速反馈对应黏着/空转相关功能；未声称存在独立黏着估算功能。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-TRAC-003\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"5300\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7709\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"5311\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4777\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_5311_02_5311\",\"product_id\":\"5311\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11250\",\"evidence\":\"allocation alloc_ALLOC_F_5311_02_5311 allocate F_5311_02 to 5311\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_5311_02\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8827\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11250\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4777\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11250";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_015 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-TRAC-004";
        attribute :>> functionId = "FN_F_4511_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "主变压器次级、牵引变流器直流链和电机侧交流变换构成牵引能量转换链。";
        attribute :>> semanticEvidence = "主变压器次级、牵引变流器直流链和电机侧交流变换构成牵引能量转换链。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"4511\",\"owner_product_name\":\"主变压器主体\",\"owner_l2_product_id\":\"4500\",\"allocation\":\"allocation alloc_ALLOC_F_4511_01_4511 allocate F_4511_01 to 4511\",\"allocation_id\":\"alloc_ALLOC_F_4511_01_4511\",\"scope_product_ids\":[\"4500\",\"5100\",\"5300\"],\"product_scope_match\":true,\"function_semantic_filter\":\"主变压器次级、牵引变流器直流链和电机侧交流变换构成牵引能量转换链。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-TRAC-004\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"INTERFACE\",\"id\":\"IF_IF_PHY_014\",\"source_file\":null},{\"type\":\"FLOW\",\"id\":\"flow::CG_117A3F0E6C8FF8FF0013A46B\",\"name\":\"牵引变压器次级交流电能\",\"kind\":\"energy\",\"connector_refs\":[\"CG_117A3F0E6C8FF8FF0013A46B\",\"CG_118F2C2B84D1D301C7BE63F8\"],\"source_product_id\":\"4500\",\"target_product_id\":\"5100\",\"source_file\":null},{\"type\":\"PRODUCT\",\"id\":\"4500\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7684\",\"endpoint_role\":\"source\"},{\"type\":\"PRODUCT\",\"id\":\"4511\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4103\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_4511_01_4511\",\"product_id\":\"4511\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11215\",\"evidence\":\"allocation alloc_ALLOC_F_4511_01_4511 allocate F_4511_01 to 4511\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_4511_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8468\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11215\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4103\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11215";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_016 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-TRAC-004";
        attribute :>> functionId = "FN_F_5131_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "主变压器次级、牵引变流器直流链和电机侧交流变换构成牵引能量转换链。";
        attribute :>> semanticEvidence = "主变压器次级、牵引变流器直流链和电机侧交流变换构成牵引能量转换链。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"5131\",\"owner_product_name\":\"网侧变流模块\",\"owner_l2_product_id\":\"5100\",\"allocation\":\"allocation alloc_ALLOC_F_5131_01_5131 allocate F_5131_01 to 5131\",\"allocation_id\":\"alloc_ALLOC_F_5131_01_5131\",\"scope_product_ids\":[\"4500\",\"5100\",\"5300\"],\"product_scope_match\":true,\"function_semantic_filter\":\"主变压器次级、牵引变流器直流链和电机侧交流变换构成牵引能量转换链。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-TRAC-004\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"INTERFACE\",\"id\":\"IF_IF_MEA_005\",\"source_file\":null},{\"type\":\"FLOW\",\"id\":\"flow::CG_002543DBE0F9A7FBC2A3FDD3\",\"name\":\"高压线路电压\",\"kind\":\"energy\",\"connector_refs\":[\"CG_002543DBE0F9A7FBC2A3FDD3\",\"CG_20C0A22ECCF07864FDBA3F5A\"],\"source_product_id\":\"4200\",\"target_product_id\":\"5100\",\"source_file\":null},{\"type\":\"PRODUCT\",\"id\":\"5100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7695\",\"endpoint_role\":\"target\"},{\"type\":\"PRODUCT\",\"id\":\"5131\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4535\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_5131_01_5131\",\"product_id\":\"5131\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11236\",\"evidence\":\"allocation alloc_ALLOC_F_5131_01_5131 allocate F_5131_01 to 5131\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_5131_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8685\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11236\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4535\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11236";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_017 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-TRAC-004";
        attribute :>> functionId = "FN_F_5132_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "主变压器次级、牵引变流器直流链和电机侧交流变换构成牵引能量转换链。";
        attribute :>> semanticEvidence = "主变压器次级、牵引变流器直流链和电机侧交流变换构成牵引能量转换链。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"5132\",\"owner_product_name\":\"电机侧变流模块\",\"owner_l2_product_id\":\"5100\",\"allocation\":\"allocation alloc_ALLOC_F_5132_01_5132 allocate F_5132_01 to 5132\",\"allocation_id\":\"alloc_ALLOC_F_5132_01_5132\",\"scope_product_ids\":[\"4500\",\"5100\",\"5300\"],\"product_scope_match\":true,\"function_semantic_filter\":\"主变压器次级、牵引变流器直流链和电机侧交流变换构成牵引能量转换链。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-TRAC-004\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"INTERFACE\",\"id\":\"IF_IF_MEA_005\",\"source_file\":null},{\"type\":\"FLOW\",\"id\":\"flow::CG_002543DBE0F9A7FBC2A3FDD3\",\"name\":\"高压线路电压\",\"kind\":\"energy\",\"connector_refs\":[\"CG_002543DBE0F9A7FBC2A3FDD3\",\"CG_20C0A22ECCF07864FDBA3F5A\"],\"source_product_id\":\"4200\",\"target_product_id\":\"5100\",\"source_file\":null},{\"type\":\"PRODUCT\",\"id\":\"5100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7695\",\"endpoint_role\":\"target\"},{\"type\":\"PRODUCT\",\"id\":\"5132\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4593\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_5132_01_5132\",\"product_id\":\"5132\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11238\",\"evidence\":\"allocation alloc_ALLOC_F_5132_01_5132 allocate F_5132_01 to 5132\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_5132_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8708\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11238\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4593\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11238";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_018 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-TRAC-004";
        attribute :>> functionId = "FN_F_5311_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "主变压器次级、牵引变流器直流链和电机侧交流变换构成牵引能量转换链。";
        attribute :>> semanticEvidence = "主变压器次级、牵引变流器直流链和电机侧交流变换构成牵引能量转换链。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"5311\",\"owner_product_name\":\"牵引电机\",\"owner_l2_product_id\":\"5300\",\"allocation\":\"allocation alloc_ALLOC_F_5311_01_5311 allocate F_5311_01 to 5311\",\"allocation_id\":\"alloc_ALLOC_F_5311_01_5311\",\"scope_product_ids\":[\"4500\",\"5100\",\"5300\"],\"product_scope_match\":true,\"function_semantic_filter\":\"主变压器次级、牵引变流器直流链和电机侧交流变换构成牵引能量转换链。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-TRAC-004\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"INTERFACE\",\"id\":\"IF_IF_PHY_004\",\"source_file\":null},{\"type\":\"FLOW\",\"id\":\"flow::CG_3BD24EBE88F37EEFFE563597\",\"name\":\"三相交流电能\",\"kind\":\"energy\",\"connector_refs\":[\"CG_3BD24EBE88F37EEFFE563597\"],\"source_product_id\":\"5100\",\"target_product_id\":\"5300\",\"source_file\":null},{\"type\":\"PRODUCT\",\"id\":\"5300\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7709\",\"endpoint_role\":\"target\"},{\"type\":\"PRODUCT\",\"id\":\"5311\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4777\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_5311_01_5311\",\"product_id\":\"5311\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11249\",\"evidence\":\"allocation alloc_ALLOC_F_5311_01_5311 allocate F_5311_01 to 5311\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_5311_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8817\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11249\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4777\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11249";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_019 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-001";
        attribute :>> functionId = "FN_F_7211_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "制动请求、再生/摩擦协调、气压到机械力转换及牵引电机制动力相关功能。";
        attribute :>> semanticEvidence = "制动请求、再生/摩擦协调、气压到机械力转换及牵引电机制动力相关功能。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"7211\",\"owner_product_name\":\"电子制动控制单元(EBCU)\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_7211_01_7211 allocate F_7211_01 to 7211\",\"allocation_id\":\"alloc_ALLOC_F_7211_01_7211\",\"scope_product_ids\":[\"5300\",\"7200\",\"8100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"制动请求、再生/摩擦协调、气压到机械力转换及牵引电机制动力相关功能。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-001\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PARAMETER\",\"id\":\"BRK-001\",\"name\":\"max_service_deceleration_mps2\",\"component_code\":\"L2_7200/L2_8100\",\"unit\":\"m/s^2\",\"source_file\":\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"inventory_file\":\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"source_location\":\"parameters.brake.max_service_deceleration_mps2\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"parameter owner component\"},{\"type\":\"PRODUCT\",\"id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_7211_01_7211\",\"product_id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11261\",\"evidence\":\"allocation alloc_ALLOC_F_7211_01_7211 allocate F_7211_01 to 7211\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_7211_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8924\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"work/simulation/simulink_fmu_v2_reviewed/07_results/Physical_VV_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11261\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11261";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_020 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-001";
        attribute :>> functionId = "FN_F_7211_02";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "制动请求、再生/摩擦协调、气压到机械力转换及牵引电机制动力相关功能。";
        attribute :>> semanticEvidence = "制动请求、再生/摩擦协调、气压到机械力转换及牵引电机制动力相关功能。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"7211\",\"owner_product_name\":\"电子制动控制单元(EBCU)\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_7211_02_7211 allocate F_7211_02 to 7211\",\"allocation_id\":\"alloc_ALLOC_F_7211_02_7211\",\"scope_product_ids\":[\"5300\",\"7200\",\"8100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"制动请求、再生/摩擦协调、气压到机械力转换及牵引电机制动力相关功能。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-001\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PARAMETER\",\"id\":\"BRK-001\",\"name\":\"max_service_deceleration_mps2\",\"component_code\":\"L2_7200/L2_8100\",\"unit\":\"m/s^2\",\"source_file\":\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"inventory_file\":\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"source_location\":\"parameters.brake.max_service_deceleration_mps2\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"parameter owner component\"},{\"type\":\"PRODUCT\",\"id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_7211_02_7211\",\"product_id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11262\",\"evidence\":\"allocation alloc_ALLOC_F_7211_02_7211 allocate F_7211_02 to 7211\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_7211_02\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8937\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"work/simulation/simulink_fmu_v2_reviewed/07_results/Physical_VV_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11262\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11262";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_021 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-001";
        attribute :>> functionId = "FN_F_7211_03";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "制动请求、再生/摩擦协调、气压到机械力转换及牵引电机制动力相关功能。";
        attribute :>> semanticEvidence = "制动请求、再生/摩擦协调、气压到机械力转换及牵引电机制动力相关功能。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"7211\",\"owner_product_name\":\"电子制动控制单元(EBCU)\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_7211_03_7211 allocate F_7211_03 to 7211\",\"allocation_id\":\"alloc_ALLOC_F_7211_03_7211\",\"scope_product_ids\":[\"5300\",\"7200\",\"8100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"制动请求、再生/摩擦协调、气压到机械力转换及牵引电机制动力相关功能。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-001\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PARAMETER\",\"id\":\"BRK-001\",\"name\":\"max_service_deceleration_mps2\",\"component_code\":\"L2_7200/L2_8100\",\"unit\":\"m/s^2\",\"source_file\":\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"inventory_file\":\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"source_location\":\"parameters.brake.max_service_deceleration_mps2\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"parameter owner component\"},{\"type\":\"PRODUCT\",\"id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_7211_03_7211\",\"product_id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11263\",\"evidence\":\"allocation alloc_ALLOC_F_7211_03_7211 allocate F_7211_03 to 7211\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_7211_03\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8959\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"work/simulation/simulink_fmu_v2_reviewed/07_results/Physical_VV_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11263\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11263";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_022 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-001";
        attribute :>> functionId = "FN_F_7255_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "制动请求、再生/摩擦协调、气压到机械力转换及牵引电机制动力相关功能。";
        attribute :>> semanticEvidence = "制动请求、再生/摩擦协调、气压到机械力转换及牵引电机制动力相关功能。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"7255\",\"owner_product_name\":\"增压缸\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_7255_01_7255 allocate F_7255_01 to 7255\",\"allocation_id\":\"alloc_ALLOC_F_7255_01_7255\",\"scope_product_ids\":[\"5300\",\"7200\",\"8100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"制动请求、再生/摩擦协调、气压到机械力转换及牵引电机制动力相关功能。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-001\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PARAMETER\",\"id\":\"BRK-001\",\"name\":\"max_service_deceleration_mps2\",\"component_code\":\"L2_7200/L2_8100\",\"unit\":\"m/s^2\",\"source_file\":\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"inventory_file\":\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"source_location\":\"parameters.brake.max_service_deceleration_mps2\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"parameter owner component\"},{\"type\":\"PRODUCT\",\"id\":\"7255\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5549\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_7255_01_7255\",\"product_id\":\"7255\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11281\",\"evidence\":\"allocation alloc_ALLOC_F_7255_01_7255 allocate F_7255_01 to 7255\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_7255_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9159\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"work/simulation/simulink_fmu_v2_reviewed/07_results/Physical_VV_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11281\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5549\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11281";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_023 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-001";
        attribute :>> functionId = "FN_F_5311_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "制动请求、再生/摩擦协调、气压到机械力转换及牵引电机制动力相关功能。";
        attribute :>> semanticEvidence = "制动请求、再生/摩擦协调、气压到机械力转换及牵引电机制动力相关功能。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"5311\",\"owner_product_name\":\"牵引电机\",\"owner_l2_product_id\":\"5300\",\"allocation\":\"allocation alloc_ALLOC_F_5311_01_5311 allocate F_5311_01 to 5311\",\"allocation_id\":\"alloc_ALLOC_F_5311_01_5311\",\"scope_product_ids\":[\"5300\",\"7200\",\"8100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"制动请求、再生/摩擦协调、气压到机械力转换及牵引电机制动力相关功能。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-001\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"5300\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7709\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"5311\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4777\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_5311_01_5311\",\"product_id\":\"5311\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11249\",\"evidence\":\"allocation alloc_ALLOC_F_5311_01_5311 allocate F_5311_01 to 5311\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_5311_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8817\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"work/simulation/simulink_fmu_v2_reviewed/07_results/Physical_VV_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11249\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4777\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11249";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_024 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-002";
        attribute :>> functionId = "FN_F_7211_04";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "PARTIALLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "紧急制动安全协调、气动隔离施加和制动力转换；缺少专门紧急停车性能证据。";
        attribute :>> semanticEvidence = "紧急制动安全协调、气动隔离施加和制动力转换；缺少专门紧急停车性能证据。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"7211\",\"owner_product_name\":\"电子制动控制单元(EBCU)\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_7211_04_7211 allocate F_7211_04 to 7211\",\"allocation_id\":\"alloc_ALLOC_F_7211_04_7211\",\"scope_product_ids\":[\"7200\",\"8100\",\"D100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"紧急制动安全协调、气动隔离施加和制动力转换；缺少专门紧急停车性能证据。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-002\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_7211_04_7211\",\"product_id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11264\",\"evidence\":\"allocation alloc_ALLOC_F_7211_04_7211 allocate F_7211_04 to 7211\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_7211_04\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8969\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11264\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11264";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_025 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-002";
        attribute :>> functionId = "FN_F_7226_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "PARTIALLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "紧急制动安全协调、气动隔离施加和制动力转换；缺少专门紧急停车性能证据。";
        attribute :>> semanticEvidence = "紧急制动安全协调、气动隔离施加和制动力转换；缺少专门紧急停车性能证据。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"7226\",\"owner_product_name\":\"紧急制动阀\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_7226_01_7226 allocate F_7226_01 to 7226\",\"allocation_id\":\"alloc_ALLOC_F_7226_01_7226\",\"scope_product_ids\":[\"7200\",\"8100\",\"D100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"紧急制动安全协调、气动隔离施加和制动力转换；缺少专门紧急停车性能证据。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-002\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"7226\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5273\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_7226_01_7226\",\"product_id\":\"7226\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11271\",\"evidence\":\"allocation alloc_ALLOC_F_7226_01_7226 allocate F_7226_01 to 7226\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_7226_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9055\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11271\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5273\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11271";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_026 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-002";
        attribute :>> functionId = "FN_F_7255_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "PARTIALLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "紧急制动安全协调、气动隔离施加和制动力转换；缺少专门紧急停车性能证据。";
        attribute :>> semanticEvidence = "紧急制动安全协调、气动隔离施加和制动力转换；缺少专门紧急停车性能证据。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"7255\",\"owner_product_name\":\"增压缸\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_7255_01_7255 allocate F_7255_01 to 7255\",\"allocation_id\":\"alloc_ALLOC_F_7255_01_7255\",\"scope_product_ids\":[\"7200\",\"8100\",\"D100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"紧急制动安全协调、气动隔离施加和制动力转换；缺少专门紧急停车性能证据。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-002\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"7255\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5549\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_7255_01_7255\",\"product_id\":\"7255\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11281\",\"evidence\":\"allocation alloc_ALLOC_F_7255_01_7255 allocate F_7255_01 to 7255\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_7255_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9159\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11281\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5549\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11281";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_027 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-002";
        attribute :>> functionId = "FN_F_D121_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "PARTIALLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "紧急制动安全协调、气动隔离施加和制动力转换；缺少专门紧急停车性能证据。";
        attribute :>> semanticEvidence = "紧急制动安全协调、气动隔离施加和制动力转换；缺少专门紧急停车性能证据。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"D121\",\"owner_product_name\":\"紧急制动按钮\",\"owner_l2_product_id\":\"D100\",\"allocation\":\"allocation alloc_ALLOC_F_D121_01_D121 allocate F_D121_01 to D121\",\"allocation_id\":\"alloc_ALLOC_F_D121_01_D121\",\"scope_product_ids\":[\"7200\",\"8100\",\"D100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"紧急制动安全协调、气动隔离施加和制动力转换；缺少专门紧急停车性能证据。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-002\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"D100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7760\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"D121\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6597\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_D121_01_D121\",\"product_id\":\"D121\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11325\",\"evidence\":\"allocation alloc_ALLOC_F_D121_01_D121 allocate F_D121_01 to D121\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_D121_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9633\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11325\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6597\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11325";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_028 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-003";
        attribute :>> functionId = "FN_F_7211_02";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "PARTIALLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "制动协调/执行和机械力形成与制动斜率控制相关；模型未提供 jerk 指标。";
        attribute :>> semanticEvidence = "制动协调/执行和机械力形成与制动斜率控制相关；模型未提供 jerk 指标。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"7211\",\"owner_product_name\":\"电子制动控制单元(EBCU)\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_7211_02_7211 allocate F_7211_02 to 7211\",\"allocation_id\":\"alloc_ALLOC_F_7211_02_7211\",\"scope_product_ids\":[\"7200\",\"8100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"制动协调/执行和机械力形成与制动斜率控制相关；模型未提供 jerk 指标。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-003\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PARAMETER\",\"id\":\"BRK-004\",\"name\":\"cylinder_time_constant_s\",\"component_code\":\"L2_7200\",\"unit\":\"s\",\"source_file\":\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"inventory_file\":\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"source_location\":\"parameters.brake.cylinder_time_constant_s\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"parameter owner component\"},{\"type\":\"PRODUCT\",\"id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_7211_02_7211\",\"product_id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11262\",\"evidence\":\"allocation alloc_ALLOC_F_7211_02_7211 allocate F_7211_02 to 7211\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_7211_02\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8937\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11262\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11262";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_029 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-003";
        attribute :>> functionId = "FN_F_7211_03";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "PARTIALLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "制动协调/执行和机械力形成与制动斜率控制相关；模型未提供 jerk 指标。";
        attribute :>> semanticEvidence = "制动协调/执行和机械力形成与制动斜率控制相关；模型未提供 jerk 指标。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"7211\",\"owner_product_name\":\"电子制动控制单元(EBCU)\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_7211_03_7211 allocate F_7211_03 to 7211\",\"allocation_id\":\"alloc_ALLOC_F_7211_03_7211\",\"scope_product_ids\":[\"7200\",\"8100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"制动协调/执行和机械力形成与制动斜率控制相关；模型未提供 jerk 指标。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-003\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PARAMETER\",\"id\":\"BRK-004\",\"name\":\"cylinder_time_constant_s\",\"component_code\":\"L2_7200\",\"unit\":\"s\",\"source_file\":\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"inventory_file\":\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"source_location\":\"parameters.brake.cylinder_time_constant_s\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"parameter owner component\"},{\"type\":\"PRODUCT\",\"id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_7211_03_7211\",\"product_id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11263\",\"evidence\":\"allocation alloc_ALLOC_F_7211_03_7211 allocate F_7211_03 to 7211\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_7211_03\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8959\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11263\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11263";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_030 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-003";
        attribute :>> functionId = "FN_F_7255_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "PARTIALLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "制动协调/执行和机械力形成与制动斜率控制相关；模型未提供 jerk 指标。";
        attribute :>> semanticEvidence = "制动协调/执行和机械力形成与制动斜率控制相关；模型未提供 jerk 指标。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"7255\",\"owner_product_name\":\"增压缸\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_7255_01_7255 allocate F_7255_01 to 7255\",\"allocation_id\":\"alloc_ALLOC_F_7255_01_7255\",\"scope_product_ids\":[\"7200\",\"8100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"制动协调/执行和机械力形成与制动斜率控制相关；模型未提供 jerk 指标。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-003\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PARAMETER\",\"id\":\"BRK-004\",\"name\":\"cylinder_time_constant_s\",\"component_code\":\"L2_7200\",\"unit\":\"s\",\"source_file\":\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"inventory_file\":\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"source_location\":\"parameters.brake.cylinder_time_constant_s\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"parameter owner component\"},{\"type\":\"PRODUCT\",\"id\":\"7255\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5549\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_7255_01_7255\",\"product_id\":\"7255\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11281\",\"evidence\":\"allocation alloc_ALLOC_F_7255_01_7255 allocate F_7255_01 to 7255\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_7255_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9159\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11281\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5549\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11281";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_031 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-004";
        attribute :>> functionId = "FN_F_7211_02";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "再生与摩擦制动协调、制动执行、牵引电机再生制动和气动机械力形成。";
        attribute :>> semanticEvidence = "再生与摩擦制动协调、制动执行、牵引电机再生制动和气动机械力形成。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"7211\",\"owner_product_name\":\"电子制动控制单元(EBCU)\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_7211_02_7211 allocate F_7211_02 to 7211\",\"allocation_id\":\"alloc_ALLOC_F_7211_02_7211\",\"scope_product_ids\":[\"5300\",\"7200\"],\"product_scope_match\":true,\"function_semantic_filter\":\"再生与摩擦制动协调、制动执行、牵引电机再生制动和气动机械力形成。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-004\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_7211_02_7211\",\"product_id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11262\",\"evidence\":\"allocation alloc_ALLOC_F_7211_02_7211 allocate F_7211_02 to 7211\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_7211_02\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8937\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11262\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11262";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_032 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-004";
        attribute :>> functionId = "FN_F_7211_03";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "再生与摩擦制动协调、制动执行、牵引电机再生制动和气动机械力形成。";
        attribute :>> semanticEvidence = "再生与摩擦制动协调、制动执行、牵引电机再生制动和气动机械力形成。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"7211\",\"owner_product_name\":\"电子制动控制单元(EBCU)\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_7211_03_7211 allocate F_7211_03 to 7211\",\"allocation_id\":\"alloc_ALLOC_F_7211_03_7211\",\"scope_product_ids\":[\"5300\",\"7200\"],\"product_scope_match\":true,\"function_semantic_filter\":\"再生与摩擦制动协调、制动执行、牵引电机再生制动和气动机械力形成。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-004\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_7211_03_7211\",\"product_id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11263\",\"evidence\":\"allocation alloc_ALLOC_F_7211_03_7211 allocate F_7211_03 to 7211\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_7211_03\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8959\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11263\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11263";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_033 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-004";
        attribute :>> functionId = "FN_F_5311_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "再生与摩擦制动协调、制动执行、牵引电机再生制动和气动机械力形成。";
        attribute :>> semanticEvidence = "再生与摩擦制动协调、制动执行、牵引电机再生制动和气动机械力形成。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"5311\",\"owner_product_name\":\"牵引电机\",\"owner_l2_product_id\":\"5300\",\"allocation\":\"allocation alloc_ALLOC_F_5311_01_5311 allocate F_5311_01 to 5311\",\"allocation_id\":\"alloc_ALLOC_F_5311_01_5311\",\"scope_product_ids\":[\"5300\",\"7200\"],\"product_scope_match\":true,\"function_semantic_filter\":\"再生与摩擦制动协调、制动执行、牵引电机再生制动和气动机械力形成。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-004\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"5300\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7709\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"5311\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4777\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_5311_01_5311\",\"product_id\":\"5311\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11249\",\"evidence\":\"allocation alloc_ALLOC_F_5311_01_5311 allocate F_5311_01 to 5311\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_5311_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8817\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11249\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4777\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11249";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_034 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-004";
        attribute :>> functionId = "FN_F_7255_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "再生与摩擦制动协调、制动执行、牵引电机再生制动和气动机械力形成。";
        attribute :>> semanticEvidence = "再生与摩擦制动协调、制动执行、牵引电机再生制动和气动机械力形成。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"7255\",\"owner_product_name\":\"增压缸\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_7255_01_7255 allocate F_7255_01 to 7255\",\"allocation_id\":\"alloc_ALLOC_F_7255_01_7255\",\"scope_product_ids\":[\"5300\",\"7200\"],\"product_scope_match\":true,\"function_semantic_filter\":\"再生与摩擦制动协调、制动执行、牵引电机再生制动和气动机械力形成。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-004\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"7255\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5549\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_7255_01_7255\",\"product_id\":\"7255\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11281\",\"evidence\":\"allocation alloc_ALLOC_F_7255_01_7255 allocate F_7255_01 to 7255\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_7255_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9159\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11281\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5549\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11281";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_035 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-005";
        attribute :>> functionId = "FN_F_7224_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "PARTIALLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "空重车调整阀状态检测及制动请求处理；没有 AW0/AW1/AW2/AW3 工况证据。";
        attribute :>> semanticEvidence = "空重车调整阀状态检测及制动请求处理；没有 AW0/AW1/AW2/AW3 工况证据。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"7224\",\"owner_product_name\":\"空重车调整阀\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_7224_01_7224 allocate F_7224_01 to 7224\",\"allocation_id\":\"alloc_ALLOC_F_7224_01_7224\",\"scope_product_ids\":[\"7200\",\"8100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"空重车调整阀状态检测及制动请求处理；没有 AW0/AW1/AW2/AW3 工况证据。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-005\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PARAMETER\",\"id\":\"VEH-001\",\"name\":\"vehicle_mass_kg\",\"component_code\":\"L2_7200\",\"unit\":\"kg\",\"source_file\":\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"inventory_file\":\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"source_location\":\"parameters.brake.vehicle_mass_kg\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"parameter owner component\"},{\"type\":\"PRODUCT\",\"id\":\"7224\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5217\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_7224_01_7224\",\"product_id\":\"7224\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11269\",\"evidence\":\"allocation alloc_ALLOC_F_7224_01_7224 allocate F_7224_01 to 7224\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_7224_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9033\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11269\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5217\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11269";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_036 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-005";
        attribute :>> functionId = "FN_F_7211_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "PARTIALLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "空重车调整阀状态检测及制动请求处理；没有 AW0/AW1/AW2/AW3 工况证据。";
        attribute :>> semanticEvidence = "空重车调整阀状态检测及制动请求处理；没有 AW0/AW1/AW2/AW3 工况证据。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"7211\",\"owner_product_name\":\"电子制动控制单元(EBCU)\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_7211_01_7211 allocate F_7211_01 to 7211\",\"allocation_id\":\"alloc_ALLOC_F_7211_01_7211\",\"scope_product_ids\":[\"7200\",\"8100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"空重车调整阀状态检测及制动请求处理；没有 AW0/AW1/AW2/AW3 工况证据。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-005\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PARAMETER\",\"id\":\"VEH-001\",\"name\":\"vehicle_mass_kg\",\"component_code\":\"L2_7200\",\"unit\":\"kg\",\"source_file\":\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"inventory_file\":\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"source_location\":\"parameters.brake.vehicle_mass_kg\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"parameter owner component\"},{\"type\":\"PRODUCT\",\"id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_7211_01_7211\",\"product_id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11261\",\"evidence\":\"allocation alloc_ALLOC_F_7211_01_7211 allocate F_7211_01 to 7211\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_7211_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8924\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11261\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11261";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_037 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-006";
        attribute :>> functionId = "FN_F_7211_02";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "电制动力协调优先与机械制动力补足功能。";
        attribute :>> semanticEvidence = "电制动力协调优先与机械制动力补足功能。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"7211\",\"owner_product_name\":\"电子制动控制单元(EBCU)\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_7211_02_7211 allocate F_7211_02 to 7211\",\"allocation_id\":\"alloc_ALLOC_F_7211_02_7211\",\"scope_product_ids\":[\"5300\",\"7200\"],\"product_scope_match\":true,\"function_semantic_filter\":\"电制动力协调优先与机械制动力补足功能。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-006\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_7211_02_7211\",\"product_id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11262\",\"evidence\":\"allocation alloc_ALLOC_F_7211_02_7211 allocate F_7211_02 to 7211\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_7211_02\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8937\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11262\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11262";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_038 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-006";
        attribute :>> functionId = "FN_F_5311_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "电制动力协调优先与机械制动力补足功能。";
        attribute :>> semanticEvidence = "电制动力协调优先与机械制动力补足功能。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"5311\",\"owner_product_name\":\"牵引电机\",\"owner_l2_product_id\":\"5300\",\"allocation\":\"allocation alloc_ALLOC_F_5311_01_5311 allocate F_5311_01 to 5311\",\"allocation_id\":\"alloc_ALLOC_F_5311_01_5311\",\"scope_product_ids\":[\"5300\",\"7200\"],\"product_scope_match\":true,\"function_semantic_filter\":\"电制动力协调优先与机械制动力补足功能。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-006\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"5300\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7709\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"5311\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4777\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_5311_01_5311\",\"product_id\":\"5311\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11249\",\"evidence\":\"allocation alloc_ALLOC_F_5311_01_5311 allocate F_5311_01 to 5311\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_5311_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8817\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11249\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4777\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11249";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_039 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-006";
        attribute :>> functionId = "FN_F_7255_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "电制动力协调优先与机械制动力补足功能。";
        attribute :>> semanticEvidence = "电制动力协调优先与机械制动力补足功能。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"7255\",\"owner_product_name\":\"增压缸\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_7255_01_7255 allocate F_7255_01 to 7255\",\"allocation_id\":\"alloc_ALLOC_F_7255_01_7255\",\"scope_product_ids\":[\"5300\",\"7200\"],\"product_scope_match\":true,\"function_semantic_filter\":\"电制动力协调优先与机械制动力补足功能。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-006\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"7255\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5549\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_7255_01_7255\",\"product_id\":\"7255\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11281\",\"evidence\":\"allocation alloc_ALLOC_F_7255_01_7255 allocate F_7255_01 to 7255\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_7255_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9159\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11281\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5549\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11281";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_040 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-007";
        attribute :>> functionId = "FN_F_7211_02";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "再生制动协调、储能吸收释放和储能功率保护功能；不推断 5100 与 X100 直接接口。";
        attribute :>> semanticEvidence = "再生制动协调、储能吸收释放和储能功率保护功能；不推断 5100 与 X100 直接接口。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"7211\",\"owner_product_name\":\"电子制动控制单元(EBCU)\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_7211_02_7211 allocate F_7211_02 to 7211\",\"allocation_id\":\"alloc_ALLOC_F_7211_02_7211\",\"scope_product_ids\":[\"5300\",\"7200\",\"X100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"再生制动协调、储能吸收释放和储能功率保护功能；不推断 5100 与 X100 直接接口。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-007\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_7211_02_7211\",\"product_id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11262\",\"evidence\":\"allocation alloc_ALLOC_F_7211_02_7211 allocate F_7211_02 to 7211\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_7211_02\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8937\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11262\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11262";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_041 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-007";
        attribute :>> functionId = "FN_F_5311_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "再生制动协调、储能吸收释放和储能功率保护功能；不推断 5100 与 X100 直接接口。";
        attribute :>> semanticEvidence = "再生制动协调、储能吸收释放和储能功率保护功能；不推断 5100 与 X100 直接接口。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"5311\",\"owner_product_name\":\"牵引电机\",\"owner_l2_product_id\":\"5300\",\"allocation\":\"allocation alloc_ALLOC_F_5311_01_5311 allocate F_5311_01 to 5311\",\"allocation_id\":\"alloc_ALLOC_F_5311_01_5311\",\"scope_product_ids\":[\"5300\",\"7200\",\"X100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"再生制动协调、储能吸收释放和储能功率保护功能；不推断 5100 与 X100 直接接口。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-007\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"5300\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7709\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"5311\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4777\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_5311_01_5311\",\"product_id\":\"5311\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11249\",\"evidence\":\"allocation alloc_ALLOC_F_5311_01_5311 allocate F_5311_01 to 5311\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_5311_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8817\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11249\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4777\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11249";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_042 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-007";
        attribute :>> functionId = "FN_F_X121_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "再生制动协调、储能吸收释放和储能功率保护功能；不推断 5100 与 X100 直接接口。";
        attribute :>> semanticEvidence = "再生制动协调、储能吸收释放和储能功率保护功能；不推断 5100 与 X100 直接接口。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"X121\",\"owner_product_name\":\"超级电容模块\",\"owner_l2_product_id\":\"X100\",\"allocation\":\"allocation alloc_ALLOC_F_X121_01_X121 allocate F_X121_01 to X121\",\"allocation_id\":\"alloc_ALLOC_F_X121_01_X121\",\"scope_product_ids\":[\"5300\",\"7200\",\"X100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"再生制动协调、储能吸收释放和储能功率保护功能；不推断 5100 与 X100 直接接口。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-007\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"X100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7795\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"X121\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6971\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_X121_01_X121\",\"product_id\":\"X121\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11340\",\"evidence\":\"allocation alloc_ALLOC_F_X121_01_X121 allocate F_X121_01 to X121\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_X121_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9804\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11340\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6971\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11340";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_043 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-007";
        attribute :>> functionId = "FN_F_X112_02";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "再生制动协调、储能吸收释放和储能功率保护功能；不推断 5100 与 X100 直接接口。";
        attribute :>> semanticEvidence = "再生制动协调、储能吸收释放和储能功率保护功能；不推断 5100 与 X100 直接接口。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"X112\",\"owner_product_name\":\"双向DC/DC控制模块\",\"owner_l2_product_id\":\"X100\",\"allocation\":\"allocation alloc_ALLOC_F_X112_02_X112 allocate F_X112_02 to X112\",\"allocation_id\":\"alloc_ALLOC_F_X112_02_X112\",\"scope_product_ids\":[\"5300\",\"7200\",\"X100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"再生制动协调、储能吸收释放和储能功率保护功能；不推断 5100 与 X100 直接接口。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-007\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"X100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7795\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"X112\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6687\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_X112_02_X112\",\"product_id\":\"X112\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11336\",\"evidence\":\"allocation alloc_ALLOC_F_X112_02_X112 allocate F_X112_02 to X112\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_X112_02\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9745\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11336\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6687\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11336";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_044 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-008";
        attribute :>> functionId = "FN_F_7211_02";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "PARTIALLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "制动切换协调、制动执行和机械力形成；未发现专门连续性/平顺性度量。";
        attribute :>> semanticEvidence = "制动切换协调、制动执行和机械力形成；未发现专门连续性/平顺性度量。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"7211\",\"owner_product_name\":\"电子制动控制单元(EBCU)\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_7211_02_7211 allocate F_7211_02 to 7211\",\"allocation_id\":\"alloc_ALLOC_F_7211_02_7211\",\"scope_product_ids\":[\"5300\",\"7200\"],\"product_scope_match\":true,\"function_semantic_filter\":\"制动切换协调、制动执行和机械力形成；未发现专门连续性/平顺性度量。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-008\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PARAMETER\",\"id\":\"BRK-007\",\"name\":\"low_speed_takeover_time_s\",\"component_code\":\"L2_7200\",\"unit\":\"s\",\"source_file\":\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"inventory_file\":\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"source_location\":\"parameters.brake.low_speed_takeover_time_s\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"parameter owner component\"},{\"type\":\"PRODUCT\",\"id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_7211_02_7211\",\"product_id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11262\",\"evidence\":\"allocation alloc_ALLOC_F_7211_02_7211 allocate F_7211_02 to 7211\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_7211_02\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8937\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11262\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11262";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_045 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-008";
        attribute :>> functionId = "FN_F_7211_03";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "PARTIALLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "制动切换协调、制动执行和机械力形成；未发现专门连续性/平顺性度量。";
        attribute :>> semanticEvidence = "制动切换协调、制动执行和机械力形成；未发现专门连续性/平顺性度量。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"7211\",\"owner_product_name\":\"电子制动控制单元(EBCU)\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_7211_03_7211 allocate F_7211_03 to 7211\",\"allocation_id\":\"alloc_ALLOC_F_7211_03_7211\",\"scope_product_ids\":[\"5300\",\"7200\"],\"product_scope_match\":true,\"function_semantic_filter\":\"制动切换协调、制动执行和机械力形成；未发现专门连续性/平顺性度量。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-008\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PARAMETER\",\"id\":\"BRK-007\",\"name\":\"low_speed_takeover_time_s\",\"component_code\":\"L2_7200\",\"unit\":\"s\",\"source_file\":\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"inventory_file\":\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"source_location\":\"parameters.brake.low_speed_takeover_time_s\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"parameter owner component\"},{\"type\":\"PRODUCT\",\"id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_7211_03_7211\",\"product_id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11263\",\"evidence\":\"allocation alloc_ALLOC_F_7211_03_7211 allocate F_7211_03 to 7211\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_7211_03\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8959\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11263\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11263";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_046 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-008";
        attribute :>> functionId = "FN_F_7255_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "PARTIALLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "制动切换协调、制动执行和机械力形成；未发现专门连续性/平顺性度量。";
        attribute :>> semanticEvidence = "制动切换协调、制动执行和机械力形成；未发现专门连续性/平顺性度量。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"7255\",\"owner_product_name\":\"增压缸\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_7255_01_7255 allocate F_7255_01 to 7255\",\"allocation_id\":\"alloc_ALLOC_F_7255_01_7255\",\"scope_product_ids\":[\"5300\",\"7200\"],\"product_scope_match\":true,\"function_semantic_filter\":\"制动切换协调、制动执行和机械力形成；未发现专门连续性/平顺性度量。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-008\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PARAMETER\",\"id\":\"BRK-007\",\"name\":\"low_speed_takeover_time_s\",\"component_code\":\"L2_7200\",\"unit\":\"s\",\"source_file\":\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"inventory_file\":\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"source_location\":\"parameters.brake.low_speed_takeover_time_s\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"parameter owner component\"},{\"type\":\"PRODUCT\",\"id\":\"7255\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5549\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_7255_01_7255\",\"product_id\":\"7255\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11281\",\"evidence\":\"allocation alloc_ALLOC_F_7255_01_7255 allocate F_7255_01 to 7255\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_7255_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9159\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11281\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5549\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11281";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_047 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-009";
        attribute :>> functionId = "FN_F_7211_02";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "制动力协调、再生电制动和机械制动力形成支持剩余制动力补足语义。";
        attribute :>> semanticEvidence = "制动力协调、再生电制动和机械制动力形成支持剩余制动力补足语义。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"7211\",\"owner_product_name\":\"电子制动控制单元(EBCU)\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_7211_02_7211 allocate F_7211_02 to 7211\",\"allocation_id\":\"alloc_ALLOC_F_7211_02_7211\",\"scope_product_ids\":[\"5300\",\"7200\"],\"product_scope_match\":true,\"function_semantic_filter\":\"制动力协调、再生电制动和机械制动力形成支持剩余制动力补足语义。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-009\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_7211_02_7211\",\"product_id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11262\",\"evidence\":\"allocation alloc_ALLOC_F_7211_02_7211 allocate F_7211_02 to 7211\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_7211_02\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8937\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11262\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11262";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_048 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-009";
        attribute :>> functionId = "FN_F_7211_03";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "制动力协调、再生电制动和机械制动力形成支持剩余制动力补足语义。";
        attribute :>> semanticEvidence = "制动力协调、再生电制动和机械制动力形成支持剩余制动力补足语义。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"7211\",\"owner_product_name\":\"电子制动控制单元(EBCU)\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_7211_03_7211 allocate F_7211_03 to 7211\",\"allocation_id\":\"alloc_ALLOC_F_7211_03_7211\",\"scope_product_ids\":[\"5300\",\"7200\"],\"product_scope_match\":true,\"function_semantic_filter\":\"制动力协调、再生电制动和机械制动力形成支持剩余制动力补足语义。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-009\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_7211_03_7211\",\"product_id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11263\",\"evidence\":\"allocation alloc_ALLOC_F_7211_03_7211 allocate F_7211_03 to 7211\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_7211_03\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8959\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11263\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11263";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_049 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-009";
        attribute :>> functionId = "FN_F_5311_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "制动力协调、再生电制动和机械制动力形成支持剩余制动力补足语义。";
        attribute :>> semanticEvidence = "制动力协调、再生电制动和机械制动力形成支持剩余制动力补足语义。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"5311\",\"owner_product_name\":\"牵引电机\",\"owner_l2_product_id\":\"5300\",\"allocation\":\"allocation alloc_ALLOC_F_5311_01_5311 allocate F_5311_01 to 5311\",\"allocation_id\":\"alloc_ALLOC_F_5311_01_5311\",\"scope_product_ids\":[\"5300\",\"7200\"],\"product_scope_match\":true,\"function_semantic_filter\":\"制动力协调、再生电制动和机械制动力形成支持剩余制动力补足语义。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-009\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"5300\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7709\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"5311\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4777\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_5311_01_5311\",\"product_id\":\"5311\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11249\",\"evidence\":\"allocation alloc_ALLOC_F_5311_01_5311 allocate F_5311_01 to 5311\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_5311_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8817\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11249\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4777\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11249";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_050 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-009";
        attribute :>> functionId = "FN_F_7255_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "制动力协调、再生电制动和机械制动力形成支持剩余制动力补足语义。";
        attribute :>> semanticEvidence = "制动力协调、再生电制动和机械制动力形成支持剩余制动力补足语义。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"7255\",\"owner_product_name\":\"增压缸\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_7255_01_7255 allocate F_7255_01 to 7255\",\"allocation_id\":\"alloc_ALLOC_F_7255_01_7255\",\"scope_product_ids\":[\"5300\",\"7200\"],\"product_scope_match\":true,\"function_semantic_filter\":\"制动力协调、再生电制动和机械制动力形成支持剩余制动力补足语义。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-009\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"7255\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5549\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_7255_01_7255\",\"product_id\":\"7255\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11281\",\"evidence\":\"allocation alloc_ALLOC_F_7255_01_7255 allocate F_7255_01 to 7255\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_7255_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9159\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11281\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5549\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11281";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_051 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-010";
        attribute :>> functionId = "FN_F_7211_04";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "PARTIALLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "防滑安全逻辑、气动防滑阀压力传递和压力状态检测；未发现滑移率验证量。";
        attribute :>> semanticEvidence = "防滑安全逻辑、气动防滑阀压力传递和压力状态检测；未发现滑移率验证量。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"7211\",\"owner_product_name\":\"电子制动控制单元(EBCU)\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_7211_04_7211 allocate F_7211_04 to 7211\",\"allocation_id\":\"alloc_ALLOC_F_7211_04_7211\",\"scope_product_ids\":[\"7200\",\"8100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"防滑安全逻辑、气动防滑阀压力传递和压力状态检测；未发现滑移率验证量。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-010\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_7211_04_7211\",\"product_id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11264\",\"evidence\":\"allocation alloc_ALLOC_F_7211_04_7211 allocate F_7211_04 to 7211\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_7211_04\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8969\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11264\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11264";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_052 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-010";
        attribute :>> functionId = "FN_F_722A_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "PARTIALLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "防滑安全逻辑、气动防滑阀压力传递和压力状态检测；未发现滑移率验证量。";
        attribute :>> semanticEvidence = "防滑安全逻辑、气动防滑阀压力传递和压力状态检测；未发现滑移率验证量。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"722A\",\"owner_product_name\":\"防滑阀组成\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_722A_01_722A allocate F_722A_01 to 722A\",\"allocation_id\":\"alloc_ALLOC_F_722A_01_722A\",\"scope_product_ids\":[\"7200\",\"8100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"防滑安全逻辑、气动防滑阀压力传递和压力状态检测；未发现滑移率验证量。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-010\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"722A\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5391\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_722A_01_722A\",\"product_id\":\"722A\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11275\",\"evidence\":\"allocation alloc_ALLOC_F_722A_01_722A allocate F_722A_01 to 722A\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_722A_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9097\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11275\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5391\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11275";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_053 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-010";
        attribute :>> functionId = "FN_F_722B_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "PARTIALLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "防滑安全逻辑、气动防滑阀压力传递和压力状态检测；未发现滑移率验证量。";
        attribute :>> semanticEvidence = "防滑安全逻辑、气动防滑阀压力传递和压力状态检测；未发现滑移率验证量。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"722B\",\"owner_product_name\":\"压力传感器\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_722B_01_722B allocate F_722B_01 to 722B\",\"allocation_id\":\"alloc_ALLOC_F_722B_01_722B\",\"scope_product_ids\":[\"7200\",\"8100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"防滑安全逻辑、气动防滑阀压力传递和压力状态检测；未发现滑移率验证量。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-010\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"722B\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5431\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_722B_01_722B\",\"product_id\":\"722B\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11276\",\"evidence\":\"allocation alloc_ALLOC_F_722B_01_722B allocate F_722B_01 to 722B\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_722B_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9106\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11276\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5431\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11276";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_054 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-011";
        attribute :>> functionId = "FN_F_7211_04";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "制动安全协调与机械制动力形成，且有既有保持制动参数/门控。";
        attribute :>> semanticEvidence = "制动安全协调与机械制动力形成，且有既有保持制动参数/门控。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"7211\",\"owner_product_name\":\"电子制动控制单元(EBCU)\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_7211_04_7211 allocate F_7211_04 to 7211\",\"allocation_id\":\"alloc_ALLOC_F_7211_04_7211\",\"scope_product_ids\":[\"7200\",\"8100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"制动安全协调与机械制动力形成，且有既有保持制动参数/门控。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-011\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PARAMETER\",\"id\":\"BRK-011\",\"name\":\"hold_deceleration_mps2\",\"component_code\":\"L2_8100/L2_7200\",\"unit\":\"m/s^2\",\"source_file\":\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"inventory_file\":\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"source_location\":\"parameters.brake.hold_deceleration_mps2\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"parameter owner component\"},{\"type\":\"PRODUCT\",\"id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_7211_04_7211\",\"product_id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11264\",\"evidence\":\"allocation alloc_ALLOC_F_7211_04_7211 allocate F_7211_04 to 7211\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_7211_04\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8969\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11264\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11264";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_055 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-011";
        attribute :>> functionId = "FN_F_7255_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "制动安全协调与机械制动力形成，且有既有保持制动参数/门控。";
        attribute :>> semanticEvidence = "制动安全协调与机械制动力形成，且有既有保持制动参数/门控。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"7255\",\"owner_product_name\":\"增压缸\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_7255_01_7255 allocate F_7255_01 to 7255\",\"allocation_id\":\"alloc_ALLOC_F_7255_01_7255\",\"scope_product_ids\":[\"7200\",\"8100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"制动安全协调与机械制动力形成，且有既有保持制动参数/门控。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-011\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PARAMETER\",\"id\":\"BRK-011\",\"name\":\"hold_deceleration_mps2\",\"component_code\":\"L2_8100/L2_7200\",\"unit\":\"m/s^2\",\"source_file\":\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"inventory_file\":\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"source_location\":\"parameters.brake.hold_deceleration_mps2\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"parameter owner component\"},{\"type\":\"PRODUCT\",\"id\":\"7255\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5549\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_7255_01_7255\",\"product_id\":\"7255\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11281\",\"evidence\":\"allocation alloc_ALLOC_F_7255_01_7255 allocate F_7255_01 to 7255\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_7255_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9159\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11281\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5549\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11281";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_056 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-012";
        attribute :>> functionId = "FN_F_7142_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "PARTIALLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "供风压力传递及总风管压力检测；不存在明确泄漏模型，故为部分覆盖。";
        attribute :>> semanticEvidence = "供风压力传递及总风管压力检测；不存在明确泄漏模型，故为部分覆盖。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"7142\",\"owner_product_name\":\"总风管压力传感器\",\"owner_l2_product_id\":\"7100\",\"allocation\":\"allocation alloc_ALLOC_F_7142_01_7142 allocate F_7142_01 to 7142\",\"allocation_id\":\"alloc_ALLOC_F_7142_01_7142\",\"scope_product_ids\":[\"7100\",\"7200\"],\"product_scope_match\":true,\"function_semantic_filter\":\"供风压力传递及总风管压力检测；不存在明确泄漏模型，故为部分覆盖。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-012\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"7100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7720\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"7142\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4867\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_7142_01_7142\",\"product_id\":\"7142\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11258\",\"evidence\":\"allocation alloc_ALLOC_F_7142_01_7142 allocate F_7142_01 to 7142\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_7142_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8897\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11258\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4867\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11258";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_057 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-012";
        attribute :>> functionId = "FN_F_7131_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "PARTIALLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "供风压力传递及总风管压力检测；不存在明确泄漏模型，故为部分覆盖。";
        attribute :>> semanticEvidence = "供风压力传递及总风管压力检测；不存在明确泄漏模型，故为部分覆盖。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"7131\",\"owner_product_name\":\"总风管\",\"owner_l2_product_id\":\"7100\",\"allocation\":\"allocation alloc_ALLOC_F_7131_01_7131 allocate F_7131_01 to 7131\",\"allocation_id\":\"alloc_ALLOC_F_7131_01_7131\",\"scope_product_ids\":[\"7100\",\"7200\"],\"product_scope_match\":true,\"function_semantic_filter\":\"供风压力传递及总风管压力检测；不存在明确泄漏模型，故为部分覆盖。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-012\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"7100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7720\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"7131\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4845\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_7131_01_7131\",\"product_id\":\"7131\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11256\",\"evidence\":\"allocation alloc_ALLOC_F_7131_01_7131 allocate F_7131_01 to 7131\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_7131_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8880\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11256\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4845\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11256";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_058 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-012";
        attribute :>> functionId = "FN_F_7100_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "PARTIALLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "供风压力传递及总风管压力检测；不存在明确泄漏模型，故为部分覆盖。";
        attribute :>> semanticEvidence = "供风压力传递及总风管压力检测；不存在明确泄漏模型，故为部分覆盖。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"7100\",\"owner_product_name\":\"供风\",\"owner_l2_product_id\":\"7100\",\"allocation\":\"allocation alloc_ALLOC_F_7100_01_7100 allocate F_7100_01 to 7100\",\"allocation_id\":\"alloc_ALLOC_F_7100_01_7100\",\"scope_product_ids\":[\"7100\",\"7200\"],\"product_scope_match\":true,\"function_semantic_filter\":\"供风压力传递及总风管压力检测；不存在明确泄漏模型，故为部分覆盖。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-012\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"7100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7720\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_7100_01_7100\",\"product_id\":\"7100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11252\",\"evidence\":\"allocation alloc_ALLOC_F_7100_01_7100 allocate F_7100_01 to 7100\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_7100_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8847\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11252\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7720\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11252";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_059 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-013";
        attribute :>> functionId = "FN_F_722B_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "制动压力状态检测与制动力形成，结合制动压力/总力容差参数。";
        attribute :>> semanticEvidence = "制动压力状态检测与制动力形成，结合制动压力/总力容差参数。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"722B\",\"owner_product_name\":\"压力传感器\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_722B_01_722B allocate F_722B_01 to 722B\",\"allocation_id\":\"alloc_ALLOC_F_722B_01_722B\",\"scope_product_ids\":[\"7200\",\"8100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"制动压力状态检测与制动力形成，结合制动压力/总力容差参数。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-013\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PARAMETER\",\"id\":\"BRK-003\",\"name\":\"cylinder_pressure_max_Pa\",\"component_code\":\"L2_7200\",\"unit\":\"Pa\",\"source_file\":\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"inventory_file\":\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"source_location\":\"parameters.brake.cylinder_pressure_max_Pa\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"parameter owner component\"},{\"type\":\"PRODUCT\",\"id\":\"722B\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5431\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_722B_01_722B\",\"product_id\":\"722B\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11276\",\"evidence\":\"allocation alloc_ALLOC_F_722B_01_722B allocate F_722B_01 to 722B\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_722B_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9106\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11276\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5431\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11276";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_060 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-013";
        attribute :>> functionId = "FN_F_722C_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "制动压力状态检测与制动力形成，结合制动压力/总力容差参数。";
        attribute :>> semanticEvidence = "制动压力状态检测与制动力形成，结合制动压力/总力容差参数。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"722C\",\"owner_product_name\":\"压力开关\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_722C_01_722C allocate F_722C_01 to 722C\",\"allocation_id\":\"alloc_ALLOC_F_722C_01_722C\",\"scope_product_ids\":[\"7200\",\"8100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"制动压力状态检测与制动力形成，结合制动压力/总力容差参数。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-013\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PARAMETER\",\"id\":\"BRK-003\",\"name\":\"cylinder_pressure_max_Pa\",\"component_code\":\"L2_7200\",\"unit\":\"Pa\",\"source_file\":\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"inventory_file\":\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"source_location\":\"parameters.brake.cylinder_pressure_max_Pa\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"parameter owner component\"},{\"type\":\"PRODUCT\",\"id\":\"722C\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5453\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_722C_01_722C\",\"product_id\":\"722C\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11277\",\"evidence\":\"allocation alloc_ALLOC_F_722C_01_722C allocate F_722C_01 to 722C\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_722C_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9116\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11277\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5453\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11277";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_061 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-013";
        attribute :>> functionId = "FN_F_7255_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "制动压力状态检测与制动力形成，结合制动压力/总力容差参数。";
        attribute :>> semanticEvidence = "制动压力状态检测与制动力形成，结合制动压力/总力容差参数。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"7255\",\"owner_product_name\":\"增压缸\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_7255_01_7255 allocate F_7255_01 to 7255\",\"allocation_id\":\"alloc_ALLOC_F_7255_01_7255\",\"scope_product_ids\":[\"7200\",\"8100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"制动压力状态检测与制动力形成，结合制动压力/总力容差参数。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-013\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PARAMETER\",\"id\":\"BRK-003\",\"name\":\"cylinder_pressure_max_Pa\",\"component_code\":\"L2_7200\",\"unit\":\"Pa\",\"source_file\":\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"inventory_file\":\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"source_location\":\"parameters.brake.cylinder_pressure_max_Pa\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"parameter owner component\"},{\"type\":\"PRODUCT\",\"id\":\"7255\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5549\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_7255_01_7255\",\"product_id\":\"7255\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11281\",\"evidence\":\"allocation alloc_ALLOC_F_7255_01_7255 allocate F_7255_01 to 7255\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_7255_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9159\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11281\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5549\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11281";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_062 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-014";
        attribute :>> functionId = "FN_F_8152_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "PARTIALLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "制动安全回路状态、路由IO及压力诊断信号；模型没有独立事件日志功能。";
        attribute :>> semanticEvidence = "制动安全回路状态、路由IO及压力诊断信号；模型没有独立事件日志功能。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"8152\",\"owner_product_name\":\"制动安全回路\",\"owner_l2_product_id\":\"8100\",\"allocation\":\"allocation alloc_ALLOC_F_8152_01_8152 allocate F_8152_01 to 8152\",\"allocation_id\":\"alloc_ALLOC_F_8152_01_8152\",\"scope_product_ids\":[\"7200\",\"8100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"制动安全回路状态、路由IO及压力诊断信号；模型没有独立事件日志功能。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-014\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"8100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7747\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"8152\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6357\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_8152_01_8152\",\"product_id\":\"8152\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11309\",\"evidence\":\"allocation alloc_ALLOC_F_8152_01_8152 allocate F_8152_01 to 8152\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_8152_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9477\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11309\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6357\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11309";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_063 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-014";
        attribute :>> functionId = "FN_F_8152_02";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "PARTIALLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "制动安全回路状态、路由IO及压力诊断信号；模型没有独立事件日志功能。";
        attribute :>> semanticEvidence = "制动安全回路状态、路由IO及压力诊断信号；模型没有独立事件日志功能。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"8152\",\"owner_product_name\":\"制动安全回路\",\"owner_l2_product_id\":\"8100\",\"allocation\":\"allocation alloc_ALLOC_F_8152_02_8152 allocate F_8152_02 to 8152\",\"allocation_id\":\"alloc_ALLOC_F_8152_02_8152\",\"scope_product_ids\":[\"7200\",\"8100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"制动安全回路状态、路由IO及压力诊断信号；模型没有独立事件日志功能。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-014\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"8100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7747\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"8152\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6357\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_8152_02_8152\",\"product_id\":\"8152\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11310\",\"evidence\":\"allocation alloc_ALLOC_F_8152_02_8152 allocate F_8152_02 to 8152\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_8152_02\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9487\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11310\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6357\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11310";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_064 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-014";
        attribute :>> functionId = "FN_F_8128_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "PARTIALLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "制动安全回路状态、路由IO及压力诊断信号；模型没有独立事件日志功能。";
        attribute :>> semanticEvidence = "制动安全回路状态、路由IO及压力诊断信号；模型没有独立事件日志功能。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"8128\",\"owner_product_name\":\"输入输出单元\",\"owner_l2_product_id\":\"8100\",\"allocation\":\"allocation alloc_ALLOC_F_8128_01_8128 allocate F_8128_01 to 8128\",\"allocation_id\":\"alloc_ALLOC_F_8128_01_8128\",\"scope_product_ids\":[\"7200\",\"8100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"制动安全回路状态、路由IO及压力诊断信号；模型没有独立事件日志功能。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-014\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"8100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7747\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"8128\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6193\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_8128_01_8128\",\"product_id\":\"8128\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11303\",\"evidence\":\"allocation alloc_ALLOC_F_8128_01_8128 allocate F_8128_01 to 8128\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_8128_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9416\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11303\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6193\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11303";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_065 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-014";
        attribute :>> functionId = "FN_F_722B_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "PARTIALLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "制动安全回路状态、路由IO及压力诊断信号；模型没有独立事件日志功能。";
        attribute :>> semanticEvidence = "制动安全回路状态、路由IO及压力诊断信号；模型没有独立事件日志功能。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"722B\",\"owner_product_name\":\"压力传感器\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_722B_01_722B allocate F_722B_01 to 722B\",\"allocation_id\":\"alloc_ALLOC_F_722B_01_722B\",\"scope_product_ids\":[\"7200\",\"8100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"制动安全回路状态、路由IO及压力诊断信号；模型没有独立事件日志功能。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-014\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"722B\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5431\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_722B_01_722B\",\"product_id\":\"722B\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11276\",\"evidence\":\"allocation alloc_ALLOC_F_722B_01_722B allocate F_722B_01 to 722B\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_722B_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9106\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11276\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5431\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11276";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_066 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-014";
        attribute :>> functionId = "FN_F_722C_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "PARTIALLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "制动安全回路状态、路由IO及压力诊断信号；模型没有独立事件日志功能。";
        attribute :>> semanticEvidence = "制动安全回路状态、路由IO及压力诊断信号；模型没有独立事件日志功能。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"722C\",\"owner_product_name\":\"压力开关\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_722C_01_722C allocate F_722C_01 to 722C\",\"allocation_id\":\"alloc_ALLOC_F_722C_01_722C\",\"scope_product_ids\":[\"7200\",\"8100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"制动安全回路状态、路由IO及压力诊断信号；模型没有独立事件日志功能。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-014\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"722C\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5453\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_722C_01_722C\",\"product_id\":\"722C\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11277\",\"evidence\":\"allocation alloc_ALLOC_F_722C_01_722C allocate F_722C_01 to 722C\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_722C_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9116\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11277\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5453\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11277";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_067 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-015";
        attribute :>> functionId = "FN_F_7211_04";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "PARTIALLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "制动安全协调、紧急气动施加和安全回路；未见明确逆变器故障降级场景。";
        attribute :>> semanticEvidence = "制动安全协调、紧急气动施加和安全回路；未见明确逆变器故障降级场景。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"7211\",\"owner_product_name\":\"电子制动控制单元(EBCU)\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_7211_04_7211 allocate F_7211_04 to 7211\",\"allocation_id\":\"alloc_ALLOC_F_7211_04_7211\",\"scope_product_ids\":[\"7200\",\"8100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"制动安全协调、紧急气动施加和安全回路；未见明确逆变器故障降级场景。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-015\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_7211_04_7211\",\"product_id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11264\",\"evidence\":\"allocation alloc_ALLOC_F_7211_04_7211 allocate F_7211_04 to 7211\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_7211_04\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8969\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11264\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11264";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_068 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-015";
        attribute :>> functionId = "FN_F_7226_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "PARTIALLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "制动安全协调、紧急气动施加和安全回路；未见明确逆变器故障降级场景。";
        attribute :>> semanticEvidence = "制动安全协调、紧急气动施加和安全回路；未见明确逆变器故障降级场景。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"7226\",\"owner_product_name\":\"紧急制动阀\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_7226_01_7226 allocate F_7226_01 to 7226\",\"allocation_id\":\"alloc_ALLOC_F_7226_01_7226\",\"scope_product_ids\":[\"7200\",\"8100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"制动安全协调、紧急气动施加和安全回路；未见明确逆变器故障降级场景。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-015\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"7226\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5273\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_7226_01_7226\",\"product_id\":\"7226\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11271\",\"evidence\":\"allocation alloc_ALLOC_F_7226_01_7226 allocate F_7226_01 to 7226\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_7226_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9055\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11271\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5273\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11271";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_069 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-015";
        attribute :>> functionId = "FN_F_7255_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "PARTIALLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "制动安全协调、紧急气动施加和安全回路；未见明确逆变器故障降级场景。";
        attribute :>> semanticEvidence = "制动安全协调、紧急气动施加和安全回路；未见明确逆变器故障降级场景。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"7255\",\"owner_product_name\":\"增压缸\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_7255_01_7255 allocate F_7255_01 to 7255\",\"allocation_id\":\"alloc_ALLOC_F_7255_01_7255\",\"scope_product_ids\":[\"7200\",\"8100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"制动安全协调、紧急气动施加和安全回路；未见明确逆变器故障降级场景。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-015\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"7255\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5549\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_7255_01_7255\",\"product_id\":\"7255\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11281\",\"evidence\":\"allocation alloc_ALLOC_F_7255_01_7255 allocate F_7255_01 to 7255\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_7255_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9159\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11281\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5549\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11281";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_070 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-BRK-015";
        attribute :>> functionId = "FN_F_8152_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "PARTIALLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "制动安全协调、紧急气动施加和安全回路；未见明确逆变器故障降级场景。";
        attribute :>> semanticEvidence = "制动安全协调、紧急气动施加和安全回路；未见明确逆变器故障降级场景。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"8152\",\"owner_product_name\":\"制动安全回路\",\"owner_l2_product_id\":\"8100\",\"allocation\":\"allocation alloc_ALLOC_F_8152_01_8152 allocate F_8152_01 to 8152\",\"allocation_id\":\"alloc_ALLOC_F_8152_01_8152\",\"scope_product_ids\":[\"7200\",\"8100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"制动安全协调、紧急气动施加和安全回路；未见明确逆变器故障降级场景。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-BRK-015\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"8100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7747\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"8152\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6357\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_8152_01_8152\",\"product_id\":\"8152\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11309\",\"evidence\":\"allocation alloc_ALLOC_F_8152_01_8152 allocate F_8152_01 to 8152\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_8152_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9477\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11309\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6357\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11309";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_071 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-ENE-002";
        attribute :>> functionId = "FN_F_X113_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "PARTIALLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "储能故障检测与状态报告，并以真实 X100→8100 故障状态接口作边界证据；无事件日志功能。";
        attribute :>> semanticEvidence = "储能故障检测与状态报告，并以真实 X100→8100 故障状态接口作边界证据；无事件日志功能。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"X113\",\"owner_product_name\":\"双向DC/DC检测保护组件\",\"owner_l2_product_id\":\"X100\",\"allocation\":\"allocation alloc_ALLOC_F_X113_01_X113 allocate F_X113_01 to X113\",\"allocation_id\":\"alloc_ALLOC_F_X113_01_X113\",\"scope_product_ids\":[\"8100\",\"X100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"储能故障检测与状态报告，并以真实 X100→8100 故障状态接口作边界证据；无事件日志功能。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-ENE-002\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"INTERFACE\",\"id\":\"IF_IF_STA_030\",\"source_file\":null},{\"type\":\"FLOW\",\"id\":\"flow::CG_C113ED5B462ACDD4ACE56E91\",\"name\":\"储能系统故障状态\",\"kind\":\"state\",\"connector_refs\":[\"CG_C03EBDD9B3CFF4E6611E41A1\",\"CG_C113ED5B462ACDD4ACE56E91\"],\"source_product_id\":\"X100\",\"target_product_id\":\"8100\",\"source_file\":null},{\"type\":\"PRODUCT\",\"id\":\"X100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7795\",\"endpoint_role\":\"source\"},{\"type\":\"PRODUCT\",\"id\":\"X113\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6877\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_X113_01_X113\",\"product_id\":\"X113\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11338\",\"evidence\":\"allocation alloc_ALLOC_F_X113_01_X113 allocate F_X113_01 to X113\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_X113_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9774\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11338\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6877\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11338";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_072 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-ENE-002";
        attribute :>> functionId = "FN_F_X112_03";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "PARTIALLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "储能故障检测与状态报告，并以真实 X100→8100 故障状态接口作边界证据；无事件日志功能。";
        attribute :>> semanticEvidence = "储能故障检测与状态报告，并以真实 X100→8100 故障状态接口作边界证据；无事件日志功能。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"X112\",\"owner_product_name\":\"双向DC/DC控制模块\",\"owner_l2_product_id\":\"X100\",\"allocation\":\"allocation alloc_ALLOC_F_X112_03_X112 allocate F_X112_03 to X112\",\"allocation_id\":\"alloc_ALLOC_F_X112_03_X112\",\"scope_product_ids\":[\"8100\",\"X100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"储能故障检测与状态报告，并以真实 X100→8100 故障状态接口作边界证据；无事件日志功能。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-ENE-002\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"INTERFACE\",\"id\":\"IF_IF_STA_030\",\"source_file\":null},{\"type\":\"FLOW\",\"id\":\"flow::CG_C113ED5B462ACDD4ACE56E91\",\"name\":\"储能系统故障状态\",\"kind\":\"state\",\"connector_refs\":[\"CG_C03EBDD9B3CFF4E6611E41A1\",\"CG_C113ED5B462ACDD4ACE56E91\"],\"source_product_id\":\"X100\",\"target_product_id\":\"8100\",\"source_file\":null},{\"type\":\"PRODUCT\",\"id\":\"X100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7795\",\"endpoint_role\":\"source\"},{\"type\":\"PRODUCT\",\"id\":\"X112\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6687\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_X112_03_X112\",\"product_id\":\"X112\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11337\",\"evidence\":\"allocation alloc_ALLOC_F_X112_03_X112 allocate F_X112_03 to X112\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_X112_03\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9758\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11337\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6687\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11337";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_073 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-ENE-002";
        attribute :>> functionId = "FN_F_8122_03";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "PARTIALLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "储能故障检测与状态报告，并以真实 X100→8100 故障状态接口作边界证据；无事件日志功能。";
        attribute :>> semanticEvidence = "储能故障检测与状态报告，并以真实 X100→8100 故障状态接口作边界证据；无事件日志功能。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"8122\",\"owner_product_name\":\"车辆控制单元\",\"owner_l2_product_id\":\"8100\",\"allocation\":\"allocation alloc_ALLOC_F_8122_03_8122 allocate F_8122_03 to 8122\",\"allocation_id\":\"alloc_ALLOC_F_8122_03_8122\",\"scope_product_ids\":[\"8100\",\"X100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"储能故障检测与状态报告，并以真实 X100→8100 故障状态接口作边界证据；无事件日志功能。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-ENE-002\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"INTERFACE\",\"id\":\"IF_IF_STA_030\",\"source_file\":null},{\"type\":\"FLOW\",\"id\":\"flow::CG_C113ED5B462ACDD4ACE56E91\",\"name\":\"储能系统故障状态\",\"kind\":\"state\",\"connector_refs\":[\"CG_C03EBDD9B3CFF4E6611E41A1\",\"CG_C113ED5B462ACDD4ACE56E91\"],\"source_product_id\":\"X100\",\"target_product_id\":\"8100\",\"source_file\":null},{\"type\":\"PRODUCT\",\"id\":\"8100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7747\",\"endpoint_role\":\"target\"},{\"type\":\"PRODUCT\",\"id\":\"8122\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5797\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_8122_03_8122\",\"product_id\":\"8122\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11294\",\"evidence\":\"allocation alloc_ALLOC_F_8122_03_8122 allocate F_8122_03 to 8122\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_8122_03\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9305\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11294\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5797\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11294";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_074 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-ENE-003";
        attribute :>> functionId = "FN_F_X121_02";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "超级电容 SOC 测量、储能系统状态报告，并由真实 X100→8100 SOC/可用功率接口支撑。";
        attribute :>> semanticEvidence = "超级电容 SOC 测量、储能系统状态报告，并由真实 X100→8100 SOC/可用功率接口支撑。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"X121\",\"owner_product_name\":\"超级电容模块\",\"owner_l2_product_id\":\"X100\",\"allocation\":\"allocation alloc_ALLOC_F_X121_02_X121 allocate F_X121_02 to X121\",\"allocation_id\":\"alloc_ALLOC_F_X121_02_X121\",\"scope_product_ids\":[\"8100\",\"X100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"超级电容 SOC 测量、储能系统状态报告，并由真实 X100→8100 SOC/可用功率接口支撑。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-ENE-003\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"INTERFACE\",\"id\":\"IF_IF_ACC_004\",\"source_file\":null},{\"type\":\"FLOW\",\"id\":\"flow::CG_CB302083C9F33A1345D9C406\",\"name\":\"储能可用充电功率\",\"kind\":\"energy\",\"connector_refs\":[\"CG_093EFCE58F3AB220CFEC48AC\",\"CG_A6D783BBFCF6C6DA11FFCF2D\",\"CG_CB302083C9F33A1345D9C406\",\"CG_DAF7D43DDD825831F29A70F8\"],\"source_product_id\":\"X100\",\"target_product_id\":\"8100\",\"source_file\":null},{\"type\":\"PRODUCT\",\"id\":\"X100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7795\",\"endpoint_role\":\"source\"},{\"type\":\"PRODUCT\",\"id\":\"X121\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6971\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_X121_02_X121\",\"product_id\":\"X121\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11341\",\"evidence\":\"allocation alloc_ALLOC_F_X121_02_X121 allocate F_X121_02 to X121\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_X121_02\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9814\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11341\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6971\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11341";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_075 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-ENE-003";
        attribute :>> functionId = "FN_F_X112_03";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "超级电容 SOC 测量、储能系统状态报告，并由真实 X100→8100 SOC/可用功率接口支撑。";
        attribute :>> semanticEvidence = "超级电容 SOC 测量、储能系统状态报告，并由真实 X100→8100 SOC/可用功率接口支撑。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"X112\",\"owner_product_name\":\"双向DC/DC控制模块\",\"owner_l2_product_id\":\"X100\",\"allocation\":\"allocation alloc_ALLOC_F_X112_03_X112 allocate F_X112_03 to X112\",\"allocation_id\":\"alloc_ALLOC_F_X112_03_X112\",\"scope_product_ids\":[\"8100\",\"X100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"超级电容 SOC 测量、储能系统状态报告，并由真实 X100→8100 SOC/可用功率接口支撑。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-ENE-003\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"INTERFACE\",\"id\":\"IF_IF_ACC_004\",\"source_file\":null},{\"type\":\"FLOW\",\"id\":\"flow::CG_CB302083C9F33A1345D9C406\",\"name\":\"储能可用充电功率\",\"kind\":\"energy\",\"connector_refs\":[\"CG_093EFCE58F3AB220CFEC48AC\",\"CG_A6D783BBFCF6C6DA11FFCF2D\",\"CG_CB302083C9F33A1345D9C406\",\"CG_DAF7D43DDD825831F29A70F8\"],\"source_product_id\":\"X100\",\"target_product_id\":\"8100\",\"source_file\":null},{\"type\":\"PRODUCT\",\"id\":\"X100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7795\",\"endpoint_role\":\"source\"},{\"type\":\"PRODUCT\",\"id\":\"X112\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6687\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_X112_03_X112\",\"product_id\":\"X112\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11337\",\"evidence\":\"allocation alloc_ALLOC_F_X112_03_X112 allocate F_X112_03 to X112\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_X112_03\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9758\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11337\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6687\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11337";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_076 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-ENE-003";
        attribute :>> functionId = "FN_F_8122_03";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "超级电容 SOC 测量、储能系统状态报告，并由真实 X100→8100 SOC/可用功率接口支撑。";
        attribute :>> semanticEvidence = "超级电容 SOC 测量、储能系统状态报告，并由真实 X100→8100 SOC/可用功率接口支撑。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"8122\",\"owner_product_name\":\"车辆控制单元\",\"owner_l2_product_id\":\"8100\",\"allocation\":\"allocation alloc_ALLOC_F_8122_03_8122 allocate F_8122_03 to 8122\",\"allocation_id\":\"alloc_ALLOC_F_8122_03_8122\",\"scope_product_ids\":[\"8100\",\"X100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"超级电容 SOC 测量、储能系统状态报告，并由真实 X100→8100 SOC/可用功率接口支撑。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-ENE-003\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"INTERFACE\",\"id\":\"IF_IF_ACC_004\",\"source_file\":null},{\"type\":\"FLOW\",\"id\":\"flow::CG_CB302083C9F33A1345D9C406\",\"name\":\"储能可用充电功率\",\"kind\":\"energy\",\"connector_refs\":[\"CG_093EFCE58F3AB220CFEC48AC\",\"CG_A6D783BBFCF6C6DA11FFCF2D\",\"CG_CB302083C9F33A1345D9C406\",\"CG_DAF7D43DDD825831F29A70F8\"],\"source_product_id\":\"X100\",\"target_product_id\":\"8100\",\"source_file\":null},{\"type\":\"PRODUCT\",\"id\":\"8100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7747\",\"endpoint_role\":\"target\"},{\"type\":\"PRODUCT\",\"id\":\"8122\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5797\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_8122_03_8122\",\"product_id\":\"8122\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11294\",\"evidence\":\"allocation alloc_ALLOC_F_8122_03_8122 allocate F_8122_03 to 8122\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_8122_03\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9305\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11294\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5797\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11294";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_077 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-ENE-003";
        attribute :>> functionId = "FN_F_8128_03";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "超级电容 SOC 测量、储能系统状态报告，并由真实 X100→8100 SOC/可用功率接口支撑。";
        attribute :>> semanticEvidence = "超级电容 SOC 测量、储能系统状态报告，并由真实 X100→8100 SOC/可用功率接口支撑。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"8128\",\"owner_product_name\":\"输入输出单元\",\"owner_l2_product_id\":\"8100\",\"allocation\":\"allocation alloc_ALLOC_F_8128_03_8128 allocate F_8128_03 to 8128\",\"allocation_id\":\"alloc_ALLOC_F_8128_03_8128\",\"scope_product_ids\":[\"8100\",\"X100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"超级电容 SOC 测量、储能系统状态报告，并由真实 X100→8100 SOC/可用功率接口支撑。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-ENE-003\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"INTERFACE\",\"id\":\"IF_IF_ACC_004\",\"source_file\":null},{\"type\":\"FLOW\",\"id\":\"flow::CG_CB302083C9F33A1345D9C406\",\"name\":\"储能可用充电功率\",\"kind\":\"energy\",\"connector_refs\":[\"CG_093EFCE58F3AB220CFEC48AC\",\"CG_A6D783BBFCF6C6DA11FFCF2D\",\"CG_CB302083C9F33A1345D9C406\",\"CG_DAF7D43DDD825831F29A70F8\"],\"source_product_id\":\"X100\",\"target_product_id\":\"8100\",\"source_file\":null},{\"type\":\"PRODUCT\",\"id\":\"8100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7747\",\"endpoint_role\":\"target\"},{\"type\":\"PRODUCT\",\"id\":\"8128\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6193\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_8128_03_8128\",\"product_id\":\"8128\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11305\",\"evidence\":\"allocation alloc_ALLOC_F_8128_03_8128 allocate F_8128_03 to 8128\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_8128_03\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9439\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11305\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6193\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11305";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_078 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-ENE-004";
        attribute :>> functionId = "FN_F_X122_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "PARTIALLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "超级电容电压传感器检测与双向 DC/DC 控制；有电压参数，但没有单体均衡功能。";
        attribute :>> semanticEvidence = "超级电容电压传感器检测与双向 DC/DC 控制；有电压参数，但没有单体均衡功能。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"X122\",\"owner_product_name\":\"超级电容电压传感器\",\"owner_l2_product_id\":\"X100\",\"allocation\":\"allocation alloc_ALLOC_F_X122_01_X122 allocate F_X122_01 to X122\",\"allocation_id\":\"alloc_ALLOC_F_X122_01_X122\",\"scope_product_ids\":[\"X100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"超级电容电压传感器检测与双向 DC/DC 控制；有电压参数，但没有单体均衡功能。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-ENE-004\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PARAMETER\",\"id\":\"SC-003\",\"name\":\"supercap_voltage_min_V\",\"component_code\":\"L2_X100\",\"unit\":\"V\",\"source_file\":\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"inventory_file\":\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"source_location\":\"parameters.supercap.voltage_min_V\"},{\"type\":\"PRODUCT\",\"id\":\"X100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7795\",\"selection_basis\":\"parameter owner component\"},{\"type\":\"PRODUCT\",\"id\":\"X122\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6999\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_X122_01_X122\",\"product_id\":\"X122\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11342\",\"evidence\":\"allocation alloc_ALLOC_F_X122_01_X122 allocate F_X122_01 to X122\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_X122_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9823\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11342\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6999\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11342";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_079 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-ENE-004";
        attribute :>> functionId = "FN_F_X112_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "PARTIALLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "超级电容电压传感器检测与双向 DC/DC 控制；有电压参数，但没有单体均衡功能。";
        attribute :>> semanticEvidence = "超级电容电压传感器检测与双向 DC/DC 控制；有电压参数，但没有单体均衡功能。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"X112\",\"owner_product_name\":\"双向DC/DC控制模块\",\"owner_l2_product_id\":\"X100\",\"allocation\":\"allocation alloc_ALLOC_F_X112_01_X112 allocate F_X112_01 to X112\",\"allocation_id\":\"alloc_ALLOC_F_X112_01_X112\",\"scope_product_ids\":[\"X100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"超级电容电压传感器检测与双向 DC/DC 控制；有电压参数，但没有单体均衡功能。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-ENE-004\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PARAMETER\",\"id\":\"SC-003\",\"name\":\"supercap_voltage_min_V\",\"component_code\":\"L2_X100\",\"unit\":\"V\",\"source_file\":\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"inventory_file\":\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"source_location\":\"parameters.supercap.voltage_min_V\"},{\"type\":\"PRODUCT\",\"id\":\"X100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7795\",\"selection_basis\":\"parameter owner component\"},{\"type\":\"PRODUCT\",\"id\":\"X112\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6687\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_X112_01_X112\",\"product_id\":\"X112\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11335\",\"evidence\":\"allocation alloc_ALLOC_F_X112_01_X112 allocate F_X112_01 to X112\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_X112_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9725\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11335\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6687\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11335";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_080 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-ENE-005";
        attribute :>> functionId = "FN_F_X121_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "储能吸收/释放与双向功率变换，并由系统能量收支/效率 V&V 支撑。";
        attribute :>> semanticEvidence = "储能吸收/释放与双向功率变换，并由系统能量收支/效率 V&V 支撑。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"X121\",\"owner_product_name\":\"超级电容模块\",\"owner_l2_product_id\":\"X100\",\"allocation\":\"allocation alloc_ALLOC_F_X121_01_X121 allocate F_X121_01 to X121\",\"allocation_id\":\"alloc_ALLOC_F_X121_01_X121\",\"scope_product_ids\":[\"X100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"储能吸收/释放与双向功率变换，并由系统能量收支/效率 V&V 支撑。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-ENE-005\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"X100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7795\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"X121\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6971\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_X121_01_X121\",\"product_id\":\"X121\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11340\",\"evidence\":\"allocation alloc_ALLOC_F_X121_01_X121 allocate F_X121_01 to X121\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_X121_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9804\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/simulation/simulink_fmu_v2_reviewed/07_results/Physical_VV_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11340\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6971\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11340";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_081 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-ENE-005";
        attribute :>> functionId = "FN_F_X112_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "储能吸收/释放与双向功率变换，并由系统能量收支/效率 V&V 支撑。";
        attribute :>> semanticEvidence = "储能吸收/释放与双向功率变换，并由系统能量收支/效率 V&V 支撑。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"X112\",\"owner_product_name\":\"双向DC/DC控制模块\",\"owner_l2_product_id\":\"X100\",\"allocation\":\"allocation alloc_ALLOC_F_X112_01_X112 allocate F_X112_01 to X112\",\"allocation_id\":\"alloc_ALLOC_F_X112_01_X112\",\"scope_product_ids\":[\"X100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"储能吸收/释放与双向功率变换，并由系统能量收支/效率 V&V 支撑。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-ENE-005\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"X100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7795\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"X112\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6687\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_X112_01_X112\",\"product_id\":\"X112\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11335\",\"evidence\":\"allocation alloc_ALLOC_F_X112_01_X112 allocate F_X112_01 to X112\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_X112_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9725\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/simulation/simulink_fmu_v2_reviewed/07_results/Physical_VV_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11335\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6687\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11335";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_082 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-ENE-006";
        attribute :>> functionId = "FN_F_X124_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "PARTIALLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "温度传感器状态检测存在；没有热模型，不能证明温度一致性。";
        attribute :>> semanticEvidence = "温度传感器状态检测存在；没有热模型，不能证明温度一致性。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"X124\",\"owner_product_name\":\"超级电容温度传感器\",\"owner_l2_product_id\":\"X100\",\"allocation\":\"allocation alloc_ALLOC_F_X124_01_X124 allocate F_X124_01 to X124\",\"allocation_id\":\"alloc_ALLOC_F_X124_01_X124\",\"scope_product_ids\":[\"X100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"温度传感器状态检测存在；没有热模型，不能证明温度一致性。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-ENE-006\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"X100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7795\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"X124\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7043\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_X124_01_X124\",\"product_id\":\"X124\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11344\",\"evidence\":\"allocation alloc_ALLOC_F_X124_01_X124 allocate F_X124_01 to X124\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_X124_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9843\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11344\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7043\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11344";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_083 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-ENE-007";
        attribute :>> functionId = "FN_F_X124_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "PARTIALLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "温度检测和储能功率保护功能存在；缺少热模型/过温阈值验证。";
        attribute :>> semanticEvidence = "温度检测和储能功率保护功能存在；缺少热模型/过温阈值验证。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"X124\",\"owner_product_name\":\"超级电容温度传感器\",\"owner_l2_product_id\":\"X100\",\"allocation\":\"allocation alloc_ALLOC_F_X124_01_X124 allocate F_X124_01 to X124\",\"allocation_id\":\"alloc_ALLOC_F_X124_01_X124\",\"scope_product_ids\":[\"X100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"温度检测和储能功率保护功能存在；缺少热模型/过温阈值验证。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-ENE-007\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PARAMETER\",\"id\":\"SC-005\",\"name\":\"supercap_initial_soc\",\"component_code\":\"L2_X100\",\"unit\":\"1\",\"source_file\":\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"inventory_file\":\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"source_location\":\"parameters.supercap.initial_soc\"},{\"type\":\"PRODUCT\",\"id\":\"X100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7795\",\"selection_basis\":\"parameter owner component\"},{\"type\":\"PRODUCT\",\"id\":\"X124\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7043\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_X124_01_X124\",\"product_id\":\"X124\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11344\",\"evidence\":\"allocation alloc_ALLOC_F_X124_01_X124 allocate F_X124_01 to X124\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_X124_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9843\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11344\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7043\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11344";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_084 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-ENE-007";
        attribute :>> functionId = "FN_F_X112_02";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "PARTIALLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "温度检测和储能功率保护功能存在；缺少热模型/过温阈值验证。";
        attribute :>> semanticEvidence = "温度检测和储能功率保护功能存在；缺少热模型/过温阈值验证。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"X112\",\"owner_product_name\":\"双向DC/DC控制模块\",\"owner_l2_product_id\":\"X100\",\"allocation\":\"allocation alloc_ALLOC_F_X112_02_X112 allocate F_X112_02 to X112\",\"allocation_id\":\"alloc_ALLOC_F_X112_02_X112\",\"scope_product_ids\":[\"X100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"温度检测和储能功率保护功能存在；缺少热模型/过温阈值验证。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-ENE-007\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PARAMETER\",\"id\":\"SC-005\",\"name\":\"supercap_initial_soc\",\"component_code\":\"L2_X100\",\"unit\":\"1\",\"source_file\":\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"inventory_file\":\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"source_location\":\"parameters.supercap.initial_soc\"},{\"type\":\"PRODUCT\",\"id\":\"X100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7795\",\"selection_basis\":\"parameter owner component\"},{\"type\":\"PRODUCT\",\"id\":\"X112\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6687\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_X112_02_X112\",\"product_id\":\"X112\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11336\",\"evidence\":\"allocation alloc_ALLOC_F_X112_02_X112 allocate F_X112_02 to X112\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_X112_02\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9745\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11336\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6687\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11336";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_085 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-ENE-008";
        attribute :>> functionId = "FN_F_X123_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "电流检测及储能功率保护，SC-008 为真实电流限制参数。";
        attribute :>> semanticEvidence = "电流检测及储能功率保护，SC-008 为真实电流限制参数。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"X123\",\"owner_product_name\":\"超级电容电流传感器\",\"owner_l2_product_id\":\"X100\",\"allocation\":\"allocation alloc_ALLOC_F_X123_01_X123 allocate F_X123_01 to X123\",\"allocation_id\":\"alloc_ALLOC_F_X123_01_X123\",\"scope_product_ids\":[\"X100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"电流检测及储能功率保护，SC-008 为真实电流限制参数。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-ENE-008\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PARAMETER\",\"id\":\"SC-008\",\"name\":\"supercap_current_limit_A\",\"component_code\":\"L2_X100\",\"unit\":\"A\",\"source_file\":\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"inventory_file\":\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"source_location\":\"parameters.supercap.current_limit_A\"},{\"type\":\"PRODUCT\",\"id\":\"X100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7795\",\"selection_basis\":\"parameter owner component\"},{\"type\":\"PRODUCT\",\"id\":\"X123\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7021\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_X123_01_X123\",\"product_id\":\"X123\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11343\",\"evidence\":\"allocation alloc_ALLOC_F_X123_01_X123 allocate F_X123_01 to X123\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_X123_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9833\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11343\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7021\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11343";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_086 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-ENE-008";
        attribute :>> functionId = "FN_F_X112_02";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "电流检测及储能功率保护，SC-008 为真实电流限制参数。";
        attribute :>> semanticEvidence = "电流检测及储能功率保护，SC-008 为真实电流限制参数。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"X112\",\"owner_product_name\":\"双向DC/DC控制模块\",\"owner_l2_product_id\":\"X100\",\"allocation\":\"allocation alloc_ALLOC_F_X112_02_X112 allocate F_X112_02 to X112\",\"allocation_id\":\"alloc_ALLOC_F_X112_02_X112\",\"scope_product_ids\":[\"X100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"电流检测及储能功率保护，SC-008 为真实电流限制参数。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-ENE-008\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PARAMETER\",\"id\":\"SC-008\",\"name\":\"supercap_current_limit_A\",\"component_code\":\"L2_X100\",\"unit\":\"A\",\"source_file\":\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"inventory_file\":\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"source_location\":\"parameters.supercap.current_limit_A\"},{\"type\":\"PRODUCT\",\"id\":\"X100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7795\",\"selection_basis\":\"parameter owner component\"},{\"type\":\"PRODUCT\",\"id\":\"X112\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6687\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_X112_02_X112\",\"product_id\":\"X112\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11336\",\"evidence\":\"allocation alloc_ALLOC_F_X112_02_X112 allocate F_X112_02 to X112\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_X112_02\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9745\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11336\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6687\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11336";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_087 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-ENE-009";
        attribute :>> functionId = "FN_F_X112_02";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "PARTIALLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "储能功率保护及检测功能存在；没有专门短路故障注入证据。";
        attribute :>> semanticEvidence = "储能功率保护及检测功能存在；没有专门短路故障注入证据。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"X112\",\"owner_product_name\":\"双向DC/DC控制模块\",\"owner_l2_product_id\":\"X100\",\"allocation\":\"allocation alloc_ALLOC_F_X112_02_X112 allocate F_X112_02 to X112\",\"allocation_id\":\"alloc_ALLOC_F_X112_02_X112\",\"scope_product_ids\":[\"X100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"储能功率保护及检测功能存在；没有专门短路故障注入证据。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-ENE-009\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"X100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7795\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"X112\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6687\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_X112_02_X112\",\"product_id\":\"X112\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11336\",\"evidence\":\"allocation alloc_ALLOC_F_X112_02_X112 allocate F_X112_02 to X112\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_X112_02\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9745\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11336\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6687\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11336";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_088 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "REQ-ENE-009";
        attribute :>> functionId = "FN_F_X113_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "PARTIALLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "储能功率保护及检测功能存在；没有专门短路故障注入证据。";
        attribute :>> semanticEvidence = "储能功率保护及检测功能存在；没有专门短路故障注入证据。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"X113\",\"owner_product_name\":\"双向DC/DC检测保护组件\",\"owner_l2_product_id\":\"X100\",\"allocation\":\"allocation alloc_ALLOC_F_X113_01_X113 allocate F_X113_01 to X113\",\"allocation_id\":\"alloc_ALLOC_F_X113_01_X113\",\"scope_product_ids\":[\"X100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"储能功率保护及检测功能存在；没有专门短路故障注入证据。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"REQ-ENE-009\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"X100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7795\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"X113\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6877\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_X113_01_X113\",\"product_id\":\"X113\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11338\",\"evidence\":\"allocation alloc_ALLOC_F_X113_01_X113 allocate F_X113_01 to X113\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_X113_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9774\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11338\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6877\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11338";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_089 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "PRJ-BRK-001";
        attribute :>> functionId = "FN_F_7211_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "制动请求协调、再生/摩擦分配和机械力形成覆盖项目制动目标。";
        attribute :>> semanticEvidence = "制动请求协调、再生/摩擦分配和机械力形成覆盖项目制动目标。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"7211\",\"owner_product_name\":\"电子制动控制单元(EBCU)\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_7211_01_7211 allocate F_7211_01 to 7211\",\"allocation_id\":\"alloc_ALLOC_F_7211_01_7211\",\"scope_product_ids\":[\"5300\",\"7200\"],\"product_scope_match\":true,\"function_semantic_filter\":\"制动请求协调、再生/摩擦分配和机械力形成覆盖项目制动目标。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"PRJ-BRK-001\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_7211_01_7211\",\"product_id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11261\",\"evidence\":\"allocation alloc_ALLOC_F_7211_01_7211 allocate F_7211_01 to 7211\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_7211_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8924\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/simulation/simulink_fmu_v2_reviewed/07_results/Physical_VV_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11261\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11261";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_090 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "PRJ-BRK-001";
        attribute :>> functionId = "FN_F_7211_02";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "制动请求协调、再生/摩擦分配和机械力形成覆盖项目制动目标。";
        attribute :>> semanticEvidence = "制动请求协调、再生/摩擦分配和机械力形成覆盖项目制动目标。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"7211\",\"owner_product_name\":\"电子制动控制单元(EBCU)\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_7211_02_7211 allocate F_7211_02 to 7211\",\"allocation_id\":\"alloc_ALLOC_F_7211_02_7211\",\"scope_product_ids\":[\"5300\",\"7200\"],\"product_scope_match\":true,\"function_semantic_filter\":\"制动请求协调、再生/摩擦分配和机械力形成覆盖项目制动目标。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"PRJ-BRK-001\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_7211_02_7211\",\"product_id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11262\",\"evidence\":\"allocation alloc_ALLOC_F_7211_02_7211 allocate F_7211_02 to 7211\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_7211_02\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8937\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/simulation/simulink_fmu_v2_reviewed/07_results/Physical_VV_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11262\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11262";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_091 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "PRJ-BRK-001";
        attribute :>> functionId = "FN_F_7211_03";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "制动请求协调、再生/摩擦分配和机械力形成覆盖项目制动目标。";
        attribute :>> semanticEvidence = "制动请求协调、再生/摩擦分配和机械力形成覆盖项目制动目标。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"7211\",\"owner_product_name\":\"电子制动控制单元(EBCU)\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_7211_03_7211 allocate F_7211_03 to 7211\",\"allocation_id\":\"alloc_ALLOC_F_7211_03_7211\",\"scope_product_ids\":[\"5300\",\"7200\"],\"product_scope_match\":true,\"function_semantic_filter\":\"制动请求协调、再生/摩擦分配和机械力形成覆盖项目制动目标。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"PRJ-BRK-001\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_7211_03_7211\",\"product_id\":\"7211\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11263\",\"evidence\":\"allocation alloc_ALLOC_F_7211_03_7211 allocate F_7211_03 to 7211\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_7211_03\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8959\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/simulation/simulink_fmu_v2_reviewed/07_results/Physical_VV_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11263\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4895\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11263";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_092 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "PRJ-BRK-001";
        attribute :>> functionId = "FN_F_7255_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "制动请求协调、再生/摩擦分配和机械力形成覆盖项目制动目标。";
        attribute :>> semanticEvidence = "制动请求协调、再生/摩擦分配和机械力形成覆盖项目制动目标。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"7255\",\"owner_product_name\":\"增压缸\",\"owner_l2_product_id\":\"7200\",\"allocation\":\"allocation alloc_ALLOC_F_7255_01_7255 allocate F_7255_01 to 7255\",\"allocation_id\":\"alloc_ALLOC_F_7255_01_7255\",\"scope_product_ids\":[\"5300\",\"7200\"],\"product_scope_match\":true,\"function_semantic_filter\":\"制动请求协调、再生/摩擦分配和机械力形成覆盖项目制动目标。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"PRJ-BRK-001\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"7200\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7733\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"7255\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5549\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_7255_01_7255\",\"product_id\":\"7255\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11281\",\"evidence\":\"allocation alloc_ALLOC_F_7255_01_7255 allocate F_7255_01 to 7255\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_7255_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9159\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/simulation/simulink_fmu_v2_reviewed/07_results/Physical_VV_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11281\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:5549\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11281";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_093 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "PRJ-BRK-001";
        attribute :>> functionId = "FN_F_5311_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "制动请求协调、再生/摩擦分配和机械力形成覆盖项目制动目标。";
        attribute :>> semanticEvidence = "制动请求协调、再生/摩擦分配和机械力形成覆盖项目制动目标。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"5311\",\"owner_product_name\":\"牵引电机\",\"owner_l2_product_id\":\"5300\",\"allocation\":\"allocation alloc_ALLOC_F_5311_01_5311 allocate F_5311_01 to 5311\",\"allocation_id\":\"alloc_ALLOC_F_5311_01_5311\",\"scope_product_ids\":[\"5300\",\"7200\"],\"product_scope_match\":true,\"function_semantic_filter\":\"制动请求协调、再生/摩擦分配和机械力形成覆盖项目制动目标。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"PRJ-BRK-001\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PRODUCT\",\"id\":\"5300\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7709\",\"selection_basis\":\"curated semantic filter within formal requirement product scope\"},{\"type\":\"PRODUCT\",\"id\":\"5311\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4777\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_5311_01_5311\",\"product_id\":\"5311\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11249\",\"evidence\":\"allocation alloc_ALLOC_F_5311_01_5311 allocate F_5311_01 to 5311\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_5311_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8817\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/simulation/simulink_fmu_v2_reviewed/07_results/Physical_VV_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11249\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4777\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11249";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_094 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "PRJ-ENE-002";
        attribute :>> functionId = "FN_F_X112_02";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "双向 DC/DC 控制、功率保护及储能功能，SC-006 为充电功率约束参数。";
        attribute :>> semanticEvidence = "双向 DC/DC 控制、功率保护及储能功能，SC-006 为充电功率约束参数。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"X112\",\"owner_product_name\":\"双向DC/DC控制模块\",\"owner_l2_product_id\":\"X100\",\"allocation\":\"allocation alloc_ALLOC_F_X112_02_X112 allocate F_X112_02 to X112\",\"allocation_id\":\"alloc_ALLOC_F_X112_02_X112\",\"scope_product_ids\":[\"X100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"双向 DC/DC 控制、功率保护及储能功能，SC-006 为充电功率约束参数。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"PRJ-ENE-002\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PARAMETER\",\"id\":\"SC-006\",\"name\":\"supercap_charge_power_limit_W\",\"component_code\":\"L2_X100\",\"unit\":\"W\",\"source_file\":\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"inventory_file\":\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"source_location\":\"parameters.supercap.charge_power_limit_W\"},{\"type\":\"PRODUCT\",\"id\":\"X100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7795\",\"selection_basis\":\"parameter owner component\"},{\"type\":\"PRODUCT\",\"id\":\"X112\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6687\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_X112_02_X112\",\"product_id\":\"X112\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11336\",\"evidence\":\"allocation alloc_ALLOC_F_X112_02_X112 allocate F_X112_02 to X112\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_X112_02\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9745\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11336\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6687\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11336";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_095 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "PRJ-ENE-002";
        attribute :>> functionId = "FN_F_X112_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "双向 DC/DC 控制、功率保护及储能功能，SC-006 为充电功率约束参数。";
        attribute :>> semanticEvidence = "双向 DC/DC 控制、功率保护及储能功能，SC-006 为充电功率约束参数。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"X112\",\"owner_product_name\":\"双向DC/DC控制模块\",\"owner_l2_product_id\":\"X100\",\"allocation\":\"allocation alloc_ALLOC_F_X112_01_X112 allocate F_X112_01 to X112\",\"allocation_id\":\"alloc_ALLOC_F_X112_01_X112\",\"scope_product_ids\":[\"X100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"双向 DC/DC 控制、功率保护及储能功能，SC-006 为充电功率约束参数。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"PRJ-ENE-002\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PARAMETER\",\"id\":\"SC-006\",\"name\":\"supercap_charge_power_limit_W\",\"component_code\":\"L2_X100\",\"unit\":\"W\",\"source_file\":\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"inventory_file\":\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"source_location\":\"parameters.supercap.charge_power_limit_W\"},{\"type\":\"PRODUCT\",\"id\":\"X100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7795\",\"selection_basis\":\"parameter owner component\"},{\"type\":\"PRODUCT\",\"id\":\"X112\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6687\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_X112_01_X112\",\"product_id\":\"X112\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11335\",\"evidence\":\"allocation alloc_ALLOC_F_X112_01_X112 allocate F_X112_01 to X112\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_X112_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9725\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11335\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6687\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11335";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_096 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "PRJ-ENE-002";
        attribute :>> functionId = "FN_F_X121_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "双向 DC/DC 控制、功率保护及储能功能，SC-006 为充电功率约束参数。";
        attribute :>> semanticEvidence = "双向 DC/DC 控制、功率保护及储能功能，SC-006 为充电功率约束参数。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"X121\",\"owner_product_name\":\"超级电容模块\",\"owner_l2_product_id\":\"X100\",\"allocation\":\"allocation alloc_ALLOC_F_X121_01_X121 allocate F_X121_01 to X121\",\"allocation_id\":\"alloc_ALLOC_F_X121_01_X121\",\"scope_product_ids\":[\"X100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"双向 DC/DC 控制、功率保护及储能功能，SC-006 为充电功率约束参数。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"PRJ-ENE-002\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PARAMETER\",\"id\":\"SC-006\",\"name\":\"supercap_charge_power_limit_W\",\"component_code\":\"L2_X100\",\"unit\":\"W\",\"source_file\":\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"inventory_file\":\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"source_location\":\"parameters.supercap.charge_power_limit_W\"},{\"type\":\"PRODUCT\",\"id\":\"X100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7795\",\"selection_basis\":\"parameter owner component\"},{\"type\":\"PRODUCT\",\"id\":\"X121\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6971\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_X121_01_X121\",\"product_id\":\"X121\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11340\",\"evidence\":\"allocation alloc_ALLOC_F_X121_01_X121 allocate F_X121_01 to X121\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_X121_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9804\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11340\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6971\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11340";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_097 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "PRJ-ENE-003";
        attribute :>> functionId = "FN_F_X123_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "电流检测及储能功率保护，SC-008 为电流限制参数。";
        attribute :>> semanticEvidence = "电流检测及储能功率保护，SC-008 为电流限制参数。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"X123\",\"owner_product_name\":\"超级电容电流传感器\",\"owner_l2_product_id\":\"X100\",\"allocation\":\"allocation alloc_ALLOC_F_X123_01_X123 allocate F_X123_01 to X123\",\"allocation_id\":\"alloc_ALLOC_F_X123_01_X123\",\"scope_product_ids\":[\"X100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"电流检测及储能功率保护，SC-008 为电流限制参数。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"PRJ-ENE-003\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PARAMETER\",\"id\":\"SC-008\",\"name\":\"supercap_current_limit_A\",\"component_code\":\"L2_X100\",\"unit\":\"A\",\"source_file\":\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"inventory_file\":\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"source_location\":\"parameters.supercap.current_limit_A\"},{\"type\":\"PRODUCT\",\"id\":\"X100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7795\",\"selection_basis\":\"parameter owner component\"},{\"type\":\"PRODUCT\",\"id\":\"X123\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7021\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_X123_01_X123\",\"product_id\":\"X123\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11343\",\"evidence\":\"allocation alloc_ALLOC_F_X123_01_X123 allocate F_X123_01 to X123\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_X123_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9833\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11343\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7021\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11343";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_098 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "PRJ-ENE-003";
        attribute :>> functionId = "FN_F_X112_02";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "电流检测及储能功率保护，SC-008 为电流限制参数。";
        attribute :>> semanticEvidence = "电流检测及储能功率保护，SC-008 为电流限制参数。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"X112\",\"owner_product_name\":\"双向DC/DC控制模块\",\"owner_l2_product_id\":\"X100\",\"allocation\":\"allocation alloc_ALLOC_F_X112_02_X112 allocate F_X112_02 to X112\",\"allocation_id\":\"alloc_ALLOC_F_X112_02_X112\",\"scope_product_ids\":[\"X100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"电流检测及储能功率保护，SC-008 为电流限制参数。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"PRJ-ENE-003\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"PARAMETER\",\"id\":\"SC-008\",\"name\":\"supercap_current_limit_A\",\"component_code\":\"L2_X100\",\"unit\":\"A\",\"source_file\":\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"inventory_file\":\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"source_location\":\"parameters.supercap.current_limit_A\"},{\"type\":\"PRODUCT\",\"id\":\"X100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7795\",\"selection_basis\":\"parameter owner component\"},{\"type\":\"PRODUCT\",\"id\":\"X112\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6687\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_X112_02_X112\",\"product_id\":\"X112\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11336\",\"evidence\":\"allocation alloc_ALLOC_F_X112_02_X112 allocate F_X112_02 to X112\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_X112_02\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:9745\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11336\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:6687\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11336";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_099 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "PRJ-PWR-001";
        attribute :>> functionId = "FN_F_4111_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "接触网受流、主变压器变换和变流器直流链功能构成有证据的供电转换链。";
        attribute :>> semanticEvidence = "接触网受流、主变压器变换和变流器直流链功能构成有证据的供电转换链。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"4111\",\"owner_product_name\":\"碳滑板\",\"owner_l2_product_id\":\"4100\",\"allocation\":\"allocation alloc_ALLOC_F_4111_01_4111 allocate F_4111_01 to 4111\",\"allocation_id\":\"alloc_ALLOC_F_4111_01_4111\",\"scope_product_ids\":[\"4100\",\"4500\",\"5100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"接触网受流、主变压器变换和变流器直流链功能构成有证据的供电转换链。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"PRJ-PWR-001\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"INTERFACE\",\"id\":\"IF_IF_STA_015\",\"source_file\":null},{\"type\":\"FLOW\",\"id\":\"flow::CG_8F81398231970DBDB0A7F854\",\"name\":\"受电弓状态\",\"kind\":\"state\",\"connector_refs\":[\"CG_8F81398231970DBDB0A7F854\"],\"source_product_id\":\"4100\",\"target_product_id\":\"4200\",\"source_file\":null},{\"type\":\"PRODUCT\",\"id\":\"4100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7648\",\"endpoint_role\":\"source\"},{\"type\":\"PRODUCT\",\"id\":\"4111\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:3541\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_4111_01_4111\",\"product_id\":\"4111\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11188\",\"evidence\":\"allocation alloc_ALLOC_F_4111_01_4111 allocate F_4111_01 to 4111\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_4111_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8208\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11188\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:3541\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11188";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_100 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "PRJ-PWR-001";
        attribute :>> functionId = "FN_F_4511_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "接触网受流、主变压器变换和变流器直流链功能构成有证据的供电转换链。";
        attribute :>> semanticEvidence = "接触网受流、主变压器变换和变流器直流链功能构成有证据的供电转换链。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"4511\",\"owner_product_name\":\"主变压器主体\",\"owner_l2_product_id\":\"4500\",\"allocation\":\"allocation alloc_ALLOC_F_4511_01_4511 allocate F_4511_01 to 4511\",\"allocation_id\":\"alloc_ALLOC_F_4511_01_4511\",\"scope_product_ids\":[\"4100\",\"4500\",\"5100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"接触网受流、主变压器变换和变流器直流链功能构成有证据的供电转换链。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"PRJ-PWR-001\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"INTERFACE\",\"id\":\"IF_IF_PHY_014\",\"source_file\":null},{\"type\":\"FLOW\",\"id\":\"flow::CG_117A3F0E6C8FF8FF0013A46B\",\"name\":\"牵引变压器次级交流电能\",\"kind\":\"energy\",\"connector_refs\":[\"CG_117A3F0E6C8FF8FF0013A46B\",\"CG_118F2C2B84D1D301C7BE63F8\"],\"source_product_id\":\"4500\",\"target_product_id\":\"5100\",\"source_file\":null},{\"type\":\"PRODUCT\",\"id\":\"4500\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7684\",\"endpoint_role\":\"source\"},{\"type\":\"PRODUCT\",\"id\":\"4511\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4103\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_4511_01_4511\",\"product_id\":\"4511\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11215\",\"evidence\":\"allocation alloc_ALLOC_F_4511_01_4511 allocate F_4511_01 to 4511\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_4511_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8468\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11215\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4103\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11215";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_101 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "PRJ-PWR-001";
        attribute :>> functionId = "FN_F_5131_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "接触网受流、主变压器变换和变流器直流链功能构成有证据的供电转换链。";
        attribute :>> semanticEvidence = "接触网受流、主变压器变换和变流器直流链功能构成有证据的供电转换链。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"5131\",\"owner_product_name\":\"网侧变流模块\",\"owner_l2_product_id\":\"5100\",\"allocation\":\"allocation alloc_ALLOC_F_5131_01_5131 allocate F_5131_01 to 5131\",\"allocation_id\":\"alloc_ALLOC_F_5131_01_5131\",\"scope_product_ids\":[\"4100\",\"4500\",\"5100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"接触网受流、主变压器变换和变流器直流链功能构成有证据的供电转换链。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"PRJ-PWR-001\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"INTERFACE\",\"id\":\"IF_IF_MEA_005\",\"source_file\":null},{\"type\":\"FLOW\",\"id\":\"flow::CG_002543DBE0F9A7FBC2A3FDD3\",\"name\":\"高压线路电压\",\"kind\":\"energy\",\"connector_refs\":[\"CG_002543DBE0F9A7FBC2A3FDD3\",\"CG_20C0A22ECCF07864FDBA3F5A\"],\"source_product_id\":\"4200\",\"target_product_id\":\"5100\",\"source_file\":null},{\"type\":\"PRODUCT\",\"id\":\"5100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7695\",\"endpoint_role\":\"target\"},{\"type\":\"PRODUCT\",\"id\":\"5131\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4535\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_5131_01_5131\",\"product_id\":\"5131\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11236\",\"evidence\":\"allocation alloc_ALLOC_F_5131_01_5131 allocate F_5131_01 to 5131\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_5131_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8685\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11236\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4535\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11236";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item RequirementFunctionTraceRecord_102 : RequirementFunctionTraceRecord {
        attribute :>> requirementId = "PRJ-PWR-001";
        attribute :>> functionId = "FN_F_5132_01";
        attribute :>> relationType = "SATISFIED_BY";
        attribute :>> mappingSource = "MODEL_DERIVED";
        attribute :>> coverageStatus = "FULLY_RESOLVED";
        attribute :>> confidence = "0.8";
        attribute :>> evidence = "接触网受流、主变压器变换和变流器直流链功能构成有证据的供电转换链。";
        attribute :>> semanticEvidence = "接触网受流、主变压器变换和变流器直流链功能构成有证据的供电转换链。";
        attribute :>> structuralEvidence = "{\"owner_product_id\":\"5132\",\"owner_product_name\":\"电机侧变流模块\",\"owner_l2_product_id\":\"5100\",\"allocation\":\"allocation alloc_ALLOC_F_5132_01_5132 allocate F_5132_01 to 5132\",\"allocation_id\":\"alloc_ALLOC_F_5132_01_5132\",\"scope_product_ids\":[\"4100\",\"4500\",\"5100\"],\"product_scope_match\":true,\"function_semantic_filter\":\"接触网受流、主变压器变换和变流器直流链功能构成有证据的供电转换链。\"}";
        attribute :>> evidencePath = "[{\"type\":\"REQUIREMENT\",\"id\":\"PRJ-PWR-001\",\"source_file\":\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\"},{\"type\":\"INTERFACE\",\"id\":\"IF_IF_MEA_005\",\"source_file\":null},{\"type\":\"FLOW\",\"id\":\"flow::CG_002543DBE0F9A7FBC2A3FDD3\",\"name\":\"高压线路电压\",\"kind\":\"energy\",\"connector_refs\":[\"CG_002543DBE0F9A7FBC2A3FDD3\",\"CG_20C0A22ECCF07864FDBA3F5A\"],\"source_product_id\":\"4200\",\"target_product_id\":\"5100\",\"source_file\":null},{\"type\":\"PRODUCT\",\"id\":\"5100\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:7695\",\"endpoint_role\":\"target\"},{\"type\":\"PRODUCT\",\"id\":\"5132\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4593\",\"relationship\":\"CONTAINED_IN_SCOPE_PRODUCT\"},{\"type\":\"ALLOCATION\",\"id\":\"alloc_ALLOC_F_5132_01_5132\",\"product_id\":\"5132\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11238\",\"evidence\":\"allocation alloc_ALLOC_F_5132_01_5132 allocate F_5132_01 to 5132\"},{\"type\":\"FUNCTION\",\"id\":\"FN_F_5132_01\",\"source_file\":\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:8708\"}]";
        attribute :>> sourceFiles = "[\"Req/牵引制动能量回收系统_正式需求库_v1.xlsx\",\"work/analysis/simulation_parameter_audit/01_parameter_inventory.csv\",\"work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11238\",\"work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:4593\"]";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11238";
        attribute :>> notes = "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。";
    }

    item def FunctionOwnerTraceRecord {
        attribute functionId : String;
        attribute productId : String;
        attribute role : String;
        attribute mappingSource : String;
        attribute evidence : String;
        attribute sourceFile : String;
    }

    item FunctionOwnerTraceRecord_001 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_3000_01";
        attribute :>> productId = "3000";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3000_01_3000 allocate F_3000_01 to 3000";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11158";
    }

    item FunctionOwnerTraceRecord_002 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_3100_01";
        attribute :>> productId = "3100";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3100_01_3100 allocate F_3100_01 to 3100";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11159";
    }

    item FunctionOwnerTraceRecord_003 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_3110_01";
        attribute :>> productId = "3110";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3110_01_3110 allocate F_3110_01 to 3110";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11160";
    }

    item FunctionOwnerTraceRecord_004 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_3111_01";
        attribute :>> productId = "3111";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3111_01_3111 allocate F_3111_01 to 3111";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11161";
    }

    item FunctionOwnerTraceRecord_005 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_3112_01";
        attribute :>> productId = "3112";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3112_01_3112 allocate F_3112_01 to 3112";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11162";
    }

    item FunctionOwnerTraceRecord_006 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_3120_01";
        attribute :>> productId = "3120";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3120_01_3120 allocate F_3120_01 to 3120";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11163";
    }

    item FunctionOwnerTraceRecord_007 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_3121_01";
        attribute :>> productId = "3121";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3121_01_3121 allocate F_3121_01 to 3121";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11164";
    }

    item FunctionOwnerTraceRecord_008 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_3130_01";
        attribute :>> productId = "3130";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3130_01_3130 allocate F_3130_01 to 3130";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11165";
    }

    item FunctionOwnerTraceRecord_009 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_3131_01";
        attribute :>> productId = "3131";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3131_01_3131 allocate F_3131_01 to 3131";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11166";
    }

    item FunctionOwnerTraceRecord_010 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_3132_01";
        attribute :>> productId = "3132";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3132_01_3132 allocate F_3132_01 to 3132";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11167";
    }

    item FunctionOwnerTraceRecord_011 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_3133_01";
        attribute :>> productId = "3133";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3133_01_3133 allocate F_3133_01 to 3133";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11168";
    }

    item FunctionOwnerTraceRecord_012 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_3500_01";
        attribute :>> productId = "3500";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3500_01_3500 allocate F_3500_01 to 3500";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11169";
    }

    item FunctionOwnerTraceRecord_013 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_3510_01";
        attribute :>> productId = "3510";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3510_01_3510 allocate F_3510_01 to 3510";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11170";
    }

    item FunctionOwnerTraceRecord_014 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_3511_01";
        attribute :>> productId = "3511";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3511_01_3511 allocate F_3511_01 to 3511";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11171";
    }

    item FunctionOwnerTraceRecord_015 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_3512_01";
        attribute :>> productId = "3512";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3512_01_3512 allocate F_3512_01 to 3512";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11172";
    }

    item FunctionOwnerTraceRecord_016 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_3514_01";
        attribute :>> productId = "3514";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3514_01_3514 allocate F_3514_01 to 3514";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11173";
    }

    item FunctionOwnerTraceRecord_017 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_3600_01";
        attribute :>> productId = "3600";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3600_01_3600 allocate F_3600_01 to 3600";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11174";
    }

    item FunctionOwnerTraceRecord_018 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_3640_01";
        attribute :>> productId = "3640";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3640_01_3640 allocate F_3640_01 to 3640";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11175";
    }

    item FunctionOwnerTraceRecord_019 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_3641_01";
        attribute :>> productId = "3641";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3641_01_3641 allocate F_3641_01 to 3641";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11176";
    }

    item FunctionOwnerTraceRecord_020 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_3643_01";
        attribute :>> productId = "3643";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3643_01_3643 allocate F_3643_01 to 3643";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11177";
    }

    item FunctionOwnerTraceRecord_021 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_3644_01";
        attribute :>> productId = "3644";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3644_01_3644 allocate F_3644_01 to 3644";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11178";
    }

    item FunctionOwnerTraceRecord_022 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_3800_01";
        attribute :>> productId = "3800";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3800_01_3800 allocate F_3800_01 to 3800";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11179";
    }

    item FunctionOwnerTraceRecord_023 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_3810_01";
        attribute :>> productId = "3810";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3810_01_3810 allocate F_3810_01 to 3810";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11180";
    }

    item FunctionOwnerTraceRecord_024 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_3811_01";
        attribute :>> productId = "3811";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3811_01_3811 allocate F_3811_01 to 3811";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11181";
    }

    item FunctionOwnerTraceRecord_025 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_3811_02";
        attribute :>> productId = "3811";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3811_02_3811 allocate F_3811_02 to 3811";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11182";
    }

    item FunctionOwnerTraceRecord_026 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_3813_01";
        attribute :>> productId = "3813";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3813_01_3813 allocate F_3813_01 to 3813";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11183";
    }

    item FunctionOwnerTraceRecord_027 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_3814_01";
        attribute :>> productId = "3814";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_3814_01_3814 allocate F_3814_01 to 3814";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11184";
    }

    item FunctionOwnerTraceRecord_028 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_4000_01";
        attribute :>> productId = "4000";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4000_01_4000 allocate F_4000_01 to 4000";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11185";
    }

    item FunctionOwnerTraceRecord_029 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_4100_01";
        attribute :>> productId = "4100";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4100_01_4100 allocate F_4100_01 to 4100";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11186";
    }

    item FunctionOwnerTraceRecord_030 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_4110_01";
        attribute :>> productId = "4110";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4110_01_4110 allocate F_4110_01 to 4110";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11187";
    }

    item FunctionOwnerTraceRecord_031 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_4111_01";
        attribute :>> productId = "4111";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4111_01_4111 allocate F_4111_01 to 4111";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11188";
    }

    item FunctionOwnerTraceRecord_032 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_411C_01";
        attribute :>> productId = "411C";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_411C_01_411C allocate F_411C_01 to 411C";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11189";
    }

    item FunctionOwnerTraceRecord_033 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_411C_02";
        attribute :>> productId = "411C";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_411C_02_411C allocate F_411C_02 to 411C";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11190";
    }

    item FunctionOwnerTraceRecord_034 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_4200_01";
        attribute :>> productId = "4200";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4200_01_4200 allocate F_4200_01 to 4200";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11191";
    }

    item FunctionOwnerTraceRecord_035 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_4210_01";
        attribute :>> productId = "4210";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4210_01_4210 allocate F_4210_01 to 4210";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11192";
    }

    item FunctionOwnerTraceRecord_036 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_4211_01";
        attribute :>> productId = "4211";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4211_01_4211 allocate F_4211_01 to 4211";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11193";
    }

    item FunctionOwnerTraceRecord_037 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_4212_01";
        attribute :>> productId = "4212";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4212_01_4212 allocate F_4212_01 to 4212";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11194";
    }

    item FunctionOwnerTraceRecord_038 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_4230_01";
        attribute :>> productId = "4230";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4230_01_4230 allocate F_4230_01 to 4230";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11195";
    }

    item FunctionOwnerTraceRecord_039 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_4235_01";
        attribute :>> productId = "4235";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4235_01_4235 allocate F_4235_01 to 4235";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11196";
    }

    item FunctionOwnerTraceRecord_040 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_4236_01";
        attribute :>> productId = "4236";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4236_01_4236 allocate F_4236_01 to 4236";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11197";
    }

    item FunctionOwnerTraceRecord_041 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_4238_01";
        attribute :>> productId = "4238";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4238_01_4238 allocate F_4238_01 to 4238";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11198";
    }

    item FunctionOwnerTraceRecord_042 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_4238_02";
        attribute :>> productId = "4238";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4238_02_4238 allocate F_4238_02 to 4238";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11199";
    }

    item FunctionOwnerTraceRecord_043 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_4238_03";
        attribute :>> productId = "4238";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4238_03_4238 allocate F_4238_03 to 4238";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11200";
    }

    item FunctionOwnerTraceRecord_044 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_4239_01";
        attribute :>> productId = "4239";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4239_01_4239 allocate F_4239_01 to 4239";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11201";
    }

    item FunctionOwnerTraceRecord_045 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_4239_02";
        attribute :>> productId = "4239";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4239_02_4239 allocate F_4239_02 to 4239";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11202";
    }

    item FunctionOwnerTraceRecord_046 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_4239_03";
        attribute :>> productId = "4239";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4239_03_4239 allocate F_4239_03 to 4239";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11203";
    }

    item FunctionOwnerTraceRecord_047 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_4240_01";
        attribute :>> productId = "4240";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4240_01_4240 allocate F_4240_01 to 4240";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11204";
    }

    item FunctionOwnerTraceRecord_048 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_4241_01";
        attribute :>> productId = "4241";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4241_01_4241 allocate F_4241_01 to 4241";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11205";
    }

    item FunctionOwnerTraceRecord_049 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_4241_02";
        attribute :>> productId = "4241";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4241_02_4241 allocate F_4241_02 to 4241";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11206";
    }

    item FunctionOwnerTraceRecord_050 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_4241_03";
        attribute :>> productId = "4241";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4241_03_4241 allocate F_4241_03 to 4241";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11207";
    }

    item FunctionOwnerTraceRecord_051 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_4400_01";
        attribute :>> productId = "4400";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4400_01_4400 allocate F_4400_01 to 4400";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11208";
    }

    item FunctionOwnerTraceRecord_052 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_4410_01";
        attribute :>> productId = "4410";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4410_01_4410 allocate F_4410_01 to 4410";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11209";
    }

    item FunctionOwnerTraceRecord_053 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_4411_01";
        attribute :>> productId = "4411";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4411_01_4411 allocate F_4411_01 to 4411";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11210";
    }

    item FunctionOwnerTraceRecord_054 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_4412_01";
        attribute :>> productId = "4412";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4412_01_4412 allocate F_4412_01 to 4412";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11211";
    }

    item FunctionOwnerTraceRecord_055 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_4413_01";
        attribute :>> productId = "4413";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4413_01_4413 allocate F_4413_01 to 4413";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11212";
    }

    item FunctionOwnerTraceRecord_056 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_4500_01";
        attribute :>> productId = "4500";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4500_01_4500 allocate F_4500_01 to 4500";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11213";
    }

    item FunctionOwnerTraceRecord_057 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_4510_01";
        attribute :>> productId = "4510";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4510_01_4510 allocate F_4510_01 to 4510";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11214";
    }

    item FunctionOwnerTraceRecord_058 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_4511_01";
        attribute :>> productId = "4511";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4511_01_4511 allocate F_4511_01 to 4511";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11215";
    }

    item FunctionOwnerTraceRecord_059 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_4513_01";
        attribute :>> productId = "4513";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4513_01_4513 allocate F_4513_01 to 4513";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11216";
    }

    item FunctionOwnerTraceRecord_060 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_4517_01";
        attribute :>> productId = "4517";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4517_01_4517 allocate F_4517_01 to 4517";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11217";
    }

    item FunctionOwnerTraceRecord_061 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_4518_01";
        attribute :>> productId = "4518";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4518_01_4518 allocate F_4518_01 to 4518";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11218";
    }

    item FunctionOwnerTraceRecord_062 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_4518_02";
        attribute :>> productId = "4518";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_4518_02_4518 allocate F_4518_02 to 4518";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11219";
    }

    item FunctionOwnerTraceRecord_063 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_5000_01";
        attribute :>> productId = "5000";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5000_01_5000 allocate F_5000_01 to 5000";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11220";
    }

    item FunctionOwnerTraceRecord_064 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_5100_01";
        attribute :>> productId = "5100";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5100_01_5100 allocate F_5100_01 to 5100";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11221";
    }

    item FunctionOwnerTraceRecord_065 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_5110_01";
        attribute :>> productId = "5110";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5110_01_5110 allocate F_5110_01 to 5110";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11222";
    }

    item FunctionOwnerTraceRecord_066 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_5111_01";
        attribute :>> productId = "5111";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5111_01_5111 allocate F_5111_01 to 5111";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11223";
    }

    item FunctionOwnerTraceRecord_067 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_5111_02";
        attribute :>> productId = "5111";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5111_02_5111 allocate F_5111_02 to 5111";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11224";
    }

    item FunctionOwnerTraceRecord_068 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_5111_03";
        attribute :>> productId = "5111";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5111_03_5111 allocate F_5111_03 to 5111";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11225";
    }

    item FunctionOwnerTraceRecord_069 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_5111_04";
        attribute :>> productId = "5111";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5111_04_5111 allocate F_5111_04 to 5111";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11226";
    }

    item FunctionOwnerTraceRecord_070 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_5112_01";
        attribute :>> productId = "5112";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5112_01_5112 allocate F_5112_01 to 5112";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11227";
    }

    item FunctionOwnerTraceRecord_071 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_5112_02";
        attribute :>> productId = "5112";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5112_02_5112 allocate F_5112_02 to 5112";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11228";
    }

    item FunctionOwnerTraceRecord_072 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_5112_03";
        attribute :>> productId = "5112";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5112_03_5112 allocate F_5112_03 to 5112";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11229";
    }

    item FunctionOwnerTraceRecord_073 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_5112_04";
        attribute :>> productId = "5112";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5112_04_5112 allocate F_5112_04 to 5112";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11230";
    }

    item FunctionOwnerTraceRecord_074 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_5113_01";
        attribute :>> productId = "5113";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5113_01_5113 allocate F_5113_01 to 5113";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11231";
    }

    item FunctionOwnerTraceRecord_075 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_5120_01";
        attribute :>> productId = "5120";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5120_01_5120 allocate F_5120_01 to 5120";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11232";
    }

    item FunctionOwnerTraceRecord_076 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_5121_01";
        attribute :>> productId = "5121";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5121_01_5121 allocate F_5121_01 to 5121";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11233";
    }

    item FunctionOwnerTraceRecord_077 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_5122_01";
        attribute :>> productId = "5122";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5122_01_5122 allocate F_5122_01 to 5122";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11234";
    }

    item FunctionOwnerTraceRecord_078 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_5130_01";
        attribute :>> productId = "5130";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5130_01_5130 allocate F_5130_01 to 5130";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11235";
    }

    item FunctionOwnerTraceRecord_079 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_5131_01";
        attribute :>> productId = "5131";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5131_01_5131 allocate F_5131_01 to 5131";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11236";
    }

    item FunctionOwnerTraceRecord_080 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_5131_02";
        attribute :>> productId = "5131";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5131_02_5131 allocate F_5131_02 to 5131";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11237";
    }

    item FunctionOwnerTraceRecord_081 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_5132_01";
        attribute :>> productId = "5132";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5132_01_5132 allocate F_5132_01 to 5132";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11238";
    }

    item FunctionOwnerTraceRecord_082 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_5132_02";
        attribute :>> productId = "5132";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5132_02_5132 allocate F_5132_02 to 5132";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11239";
    }

    item FunctionOwnerTraceRecord_083 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_5133_01";
        attribute :>> productId = "5133";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5133_01_5133 allocate F_5133_01 to 5133";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11240";
    }

    item FunctionOwnerTraceRecord_084 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_5133_02";
        attribute :>> productId = "5133";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5133_02_5133 allocate F_5133_02 to 5133";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11241";
    }

    item FunctionOwnerTraceRecord_085 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_5133_03";
        attribute :>> productId = "5133";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5133_03_5133 allocate F_5133_03 to 5133";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11242";
    }

    item FunctionOwnerTraceRecord_086 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_5140_01";
        attribute :>> productId = "5140";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5140_01_5140 allocate F_5140_01 to 5140";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11243";
    }

    item FunctionOwnerTraceRecord_087 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_5142_01";
        attribute :>> productId = "5142";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5142_01_5142 allocate F_5142_01 to 5142";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11244";
    }

    item FunctionOwnerTraceRecord_088 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_5142_02";
        attribute :>> productId = "5142";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5142_02_5142 allocate F_5142_02 to 5142";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11245";
    }

    item FunctionOwnerTraceRecord_089 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_5145_01";
        attribute :>> productId = "5145";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5145_01_5145 allocate F_5145_01 to 5145";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11246";
    }

    item FunctionOwnerTraceRecord_090 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_5300_01";
        attribute :>> productId = "5300";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5300_01_5300 allocate F_5300_01 to 5300";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11247";
    }

    item FunctionOwnerTraceRecord_091 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_5310_01";
        attribute :>> productId = "5310";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5310_01_5310 allocate F_5310_01 to 5310";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11248";
    }

    item FunctionOwnerTraceRecord_092 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_5311_01";
        attribute :>> productId = "5311";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5311_01_5311 allocate F_5311_01 to 5311";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11249";
    }

    item FunctionOwnerTraceRecord_093 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_5311_02";
        attribute :>> productId = "5311";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_5311_02_5311 allocate F_5311_02 to 5311";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11250";
    }

    item FunctionOwnerTraceRecord_094 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_7000_01";
        attribute :>> productId = "7000";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7000_01_7000 allocate F_7000_01 to 7000";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11251";
    }

    item FunctionOwnerTraceRecord_095 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_7100_01";
        attribute :>> productId = "7100";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7100_01_7100 allocate F_7100_01 to 7100";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11252";
    }

    item FunctionOwnerTraceRecord_096 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_7120_01";
        attribute :>> productId = "7120";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7120_01_7120 allocate F_7120_01 to 7120";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11253";
    }

    item FunctionOwnerTraceRecord_097 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_7124_01";
        attribute :>> productId = "7124";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7124_01_7124 allocate F_7124_01 to 7124";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11254";
    }

    item FunctionOwnerTraceRecord_098 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_7130_01";
        attribute :>> productId = "7130";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7130_01_7130 allocate F_7130_01 to 7130";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11255";
    }

    item FunctionOwnerTraceRecord_099 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_7131_01";
        attribute :>> productId = "7131";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7131_01_7131 allocate F_7131_01 to 7131";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11256";
    }

    item FunctionOwnerTraceRecord_100 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_7140_01";
        attribute :>> productId = "7140";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7140_01_7140 allocate F_7140_01 to 7140";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11257";
    }

    item FunctionOwnerTraceRecord_101 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_7142_01";
        attribute :>> productId = "7142";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7142_01_7142 allocate F_7142_01 to 7142";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11258";
    }

    item FunctionOwnerTraceRecord_102 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_7200_01";
        attribute :>> productId = "7200";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7200_01_7200 allocate F_7200_01 to 7200";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11259";
    }

    item FunctionOwnerTraceRecord_103 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_7210_01";
        attribute :>> productId = "7210";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7210_01_7210 allocate F_7210_01 to 7210";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11260";
    }

    item FunctionOwnerTraceRecord_104 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_7211_01";
        attribute :>> productId = "7211";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7211_01_7211 allocate F_7211_01 to 7211";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11261";
    }

    item FunctionOwnerTraceRecord_105 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_7211_02";
        attribute :>> productId = "7211";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7211_02_7211 allocate F_7211_02 to 7211";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11262";
    }

    item FunctionOwnerTraceRecord_106 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_7211_03";
        attribute :>> productId = "7211";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7211_03_7211 allocate F_7211_03 to 7211";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11263";
    }

    item FunctionOwnerTraceRecord_107 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_7211_04";
        attribute :>> productId = "7211";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7211_04_7211 allocate F_7211_04 to 7211";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11264";
    }

    item FunctionOwnerTraceRecord_108 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_7213_01";
        attribute :>> productId = "7213";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7213_01_7213 allocate F_7213_01 to 7213";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11265";
    }

    item FunctionOwnerTraceRecord_109 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_7220_01";
        attribute :>> productId = "7220";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7220_01_7220 allocate F_7220_01 to 7220";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11266";
    }

    item FunctionOwnerTraceRecord_110 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_7222_01";
        attribute :>> productId = "7222";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7222_01_7222 allocate F_7222_01 to 7222";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11267";
    }

    item FunctionOwnerTraceRecord_111 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_7223_01";
        attribute :>> productId = "7223";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7223_01_7223 allocate F_7223_01 to 7223";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11268";
    }

    item FunctionOwnerTraceRecord_112 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_7224_01";
        attribute :>> productId = "7224";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7224_01_7224 allocate F_7224_01 to 7224";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11269";
    }

    item FunctionOwnerTraceRecord_113 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_7225_01";
        attribute :>> productId = "7225";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7225_01_7225 allocate F_7225_01 to 7225";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11270";
    }

    item FunctionOwnerTraceRecord_114 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_7226_01";
        attribute :>> productId = "7226";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7226_01_7226 allocate F_7226_01 to 7226";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11271";
    }

    item FunctionOwnerTraceRecord_115 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_7227_01";
        attribute :>> productId = "7227";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7227_01_7227 allocate F_7227_01 to 7227";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11272";
    }

    item FunctionOwnerTraceRecord_116 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_7228_01";
        attribute :>> productId = "7228";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7228_01_7228 allocate F_7228_01 to 7228";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11273";
    }

    item FunctionOwnerTraceRecord_117 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_7229_01";
        attribute :>> productId = "7229";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7229_01_7229 allocate F_7229_01 to 7229";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11274";
    }

    item FunctionOwnerTraceRecord_118 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_722A_01";
        attribute :>> productId = "722A";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_722A_01_722A allocate F_722A_01 to 722A";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11275";
    }

    item FunctionOwnerTraceRecord_119 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_722B_01";
        attribute :>> productId = "722B";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_722B_01_722B allocate F_722B_01 to 722B";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11276";
    }

    item FunctionOwnerTraceRecord_120 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_722C_01";
        attribute :>> productId = "722C";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_722C_01_722C allocate F_722C_01 to 722C";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11277";
    }

    item FunctionOwnerTraceRecord_121 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_7250_01";
        attribute :>> productId = "7250";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7250_01_7250 allocate F_7250_01 to 7250";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11278";
    }

    item FunctionOwnerTraceRecord_122 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_7252_01";
        attribute :>> productId = "7252";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7252_01_7252 allocate F_7252_01 to 7252";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11279";
    }

    item FunctionOwnerTraceRecord_123 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_7254_01";
        attribute :>> productId = "7254";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7254_01_7254 allocate F_7254_01 to 7254";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11280";
    }

    item FunctionOwnerTraceRecord_124 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_7255_01";
        attribute :>> productId = "7255";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7255_01_7255 allocate F_7255_01 to 7255";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11281";
    }

    item FunctionOwnerTraceRecord_125 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_7280_01";
        attribute :>> productId = "7280";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7280_01_7280 allocate F_7280_01 to 7280";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11282";
    }

    item FunctionOwnerTraceRecord_126 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_7281_01";
        attribute :>> productId = "7281";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7281_01_7281 allocate F_7281_01 to 7281";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11283";
    }

    item FunctionOwnerTraceRecord_127 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_7284_01";
        attribute :>> productId = "7284";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7284_01_7284 allocate F_7284_01 to 7284";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11284";
    }

    item FunctionOwnerTraceRecord_128 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_7285_01";
        attribute :>> productId = "7285";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_7285_01_7285 allocate F_7285_01 to 7285";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11285";
    }

    item FunctionOwnerTraceRecord_129 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_8000_01";
        attribute :>> productId = "8000";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8000_01_8000 allocate F_8000_01 to 8000";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11286";
    }

    item FunctionOwnerTraceRecord_130 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_8100_01";
        attribute :>> productId = "8100";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8100_01_8100 allocate F_8100_01 to 8100";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11287";
    }

    item FunctionOwnerTraceRecord_131 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_8120_01";
        attribute :>> productId = "8120";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8120_01_8120 allocate F_8120_01 to 8120";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11288";
    }

    item FunctionOwnerTraceRecord_132 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_8121_01";
        attribute :>> productId = "8121";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8121_01_8121 allocate F_8121_01 to 8121";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11289";
    }

    item FunctionOwnerTraceRecord_133 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_8121_02";
        attribute :>> productId = "8121";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8121_02_8121 allocate F_8121_02 to 8121";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11290";
    }

    item FunctionOwnerTraceRecord_134 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_8121_03";
        attribute :>> productId = "8121";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8121_03_8121 allocate F_8121_03 to 8121";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11291";
    }

    item FunctionOwnerTraceRecord_135 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_8122_01";
        attribute :>> productId = "8122";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8122_01_8122 allocate F_8122_01 to 8122";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11292";
    }

    item FunctionOwnerTraceRecord_136 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_8122_02";
        attribute :>> productId = "8122";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8122_02_8122 allocate F_8122_02 to 8122";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11293";
    }

    item FunctionOwnerTraceRecord_137 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_8122_03";
        attribute :>> productId = "8122";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8122_03_8122 allocate F_8122_03 to 8122";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11294";
    }

    item FunctionOwnerTraceRecord_138 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_8122_04";
        attribute :>> productId = "8122";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8122_04_8122 allocate F_8122_04 to 8122";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11295";
    }

    item FunctionOwnerTraceRecord_139 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_8122_05";
        attribute :>> productId = "8122";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8122_05_8122 allocate F_8122_05 to 8122";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11296";
    }

    item FunctionOwnerTraceRecord_140 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_8125_01";
        attribute :>> productId = "8125";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8125_01_8125 allocate F_8125_01 to 8125";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11297";
    }

    item FunctionOwnerTraceRecord_141 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_8125_02";
        attribute :>> productId = "8125";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8125_02_8125 allocate F_8125_02 to 8125";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11298";
    }

    item FunctionOwnerTraceRecord_142 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_8125_03";
        attribute :>> productId = "8125";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8125_03_8125 allocate F_8125_03 to 8125";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11299";
    }

    item FunctionOwnerTraceRecord_143 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_8125_04";
        attribute :>> productId = "8125";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8125_04_8125 allocate F_8125_04 to 8125";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11300";
    }

    item FunctionOwnerTraceRecord_144 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_8127_01";
        attribute :>> productId = "8127";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8127_01_8127 allocate F_8127_01 to 8127";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11301";
    }

    item FunctionOwnerTraceRecord_145 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_8127_02";
        attribute :>> productId = "8127";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8127_02_8127 allocate F_8127_02 to 8127";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11302";
    }

    item FunctionOwnerTraceRecord_146 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_8128_01";
        attribute :>> productId = "8128";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8128_01_8128 allocate F_8128_01 to 8128";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11303";
    }

    item FunctionOwnerTraceRecord_147 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_8128_02";
        attribute :>> productId = "8128";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8128_02_8128 allocate F_8128_02 to 8128";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11304";
    }

    item FunctionOwnerTraceRecord_148 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_8128_03";
        attribute :>> productId = "8128";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8128_03_8128 allocate F_8128_03 to 8128";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11305";
    }

    item FunctionOwnerTraceRecord_149 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_8150_01";
        attribute :>> productId = "8150";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8150_01_8150 allocate F_8150_01 to 8150";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11306";
    }

    item FunctionOwnerTraceRecord_150 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_8151_01";
        attribute :>> productId = "8151";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8151_01_8151 allocate F_8151_01 to 8151";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11307";
    }

    item FunctionOwnerTraceRecord_151 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_8151_02";
        attribute :>> productId = "8151";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8151_02_8151 allocate F_8151_02 to 8151";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11308";
    }

    item FunctionOwnerTraceRecord_152 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_8152_01";
        attribute :>> productId = "8152";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8152_01_8152 allocate F_8152_01 to 8152";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11309";
    }

    item FunctionOwnerTraceRecord_153 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_8152_02";
        attribute :>> productId = "8152";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8152_02_8152 allocate F_8152_02 to 8152";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11310";
    }

    item FunctionOwnerTraceRecord_154 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_8154_01";
        attribute :>> productId = "8154";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8154_01_8154 allocate F_8154_01 to 8154";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11311";
    }

    item FunctionOwnerTraceRecord_155 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_8154_02";
        attribute :>> productId = "8154";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8154_02_8154 allocate F_8154_02 to 8154";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11312";
    }

    item FunctionOwnerTraceRecord_156 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_8160_01";
        attribute :>> productId = "8160";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8160_01_8160 allocate F_8160_01 to 8160";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11313";
    }

    item FunctionOwnerTraceRecord_157 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_8166_01";
        attribute :>> productId = "8166";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8166_01_8166 allocate F_8166_01 to 8166";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11314";
    }

    item FunctionOwnerTraceRecord_158 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_8166_02";
        attribute :>> productId = "8166";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8166_02_8166 allocate F_8166_02 to 8166";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11315";
    }

    item FunctionOwnerTraceRecord_159 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_8166_03";
        attribute :>> productId = "8166";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8166_03_8166 allocate F_8166_03 to 8166";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11316";
    }

    item FunctionOwnerTraceRecord_160 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_8166_04";
        attribute :>> productId = "8166";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_8166_04_8166 allocate F_8166_04 to 8166";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11317";
    }

    item FunctionOwnerTraceRecord_161 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_D000_01";
        attribute :>> productId = "D000";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_D000_01_D000 allocate F_D000_01 to D000";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11318";
    }

    item FunctionOwnerTraceRecord_162 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_D100_01";
        attribute :>> productId = "D100";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_D100_01_D100 allocate F_D100_01 to D100";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11319";
    }

    item FunctionOwnerTraceRecord_163 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_D110_01";
        attribute :>> productId = "D110";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_D110_01_D110 allocate F_D110_01 to D110";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11320";
    }

    item FunctionOwnerTraceRecord_164 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_D112_01";
        attribute :>> productId = "D112";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_D112_01_D112 allocate F_D112_01 to D112";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11321";
    }

    item FunctionOwnerTraceRecord_165 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_D113_01";
        attribute :>> productId = "D113";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_D113_01_D113 allocate F_D113_01 to D113";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11322";
    }

    item FunctionOwnerTraceRecord_166 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_D114_01";
        attribute :>> productId = "D114";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_D114_01_D114 allocate F_D114_01 to D114";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11323";
    }

    item FunctionOwnerTraceRecord_167 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_D120_01";
        attribute :>> productId = "D120";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_D120_01_D120 allocate F_D120_01 to D120";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11324";
    }

    item FunctionOwnerTraceRecord_168 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_D121_01";
        attribute :>> productId = "D121";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_D121_01_D121 allocate F_D121_01 to D121";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11325";
    }

    item FunctionOwnerTraceRecord_169 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_D130_01";
        attribute :>> productId = "D130";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_D130_01_D130 allocate F_D130_01 to D130";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11326";
    }

    item FunctionOwnerTraceRecord_170 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_D13B_01";
        attribute :>> productId = "D13B";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_D13B_01_D13B allocate F_D13B_01 to D13B";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11327";
    }

    item FunctionOwnerTraceRecord_171 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_E000_01";
        attribute :>> productId = "E000";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_E000_01_E000 allocate F_E000_01 to E000";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11328";
    }

    item FunctionOwnerTraceRecord_172 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_E100_01";
        attribute :>> productId = "E100";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_E100_01_E100 allocate F_E100_01 to E100";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11329";
    }

    item FunctionOwnerTraceRecord_173 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_X000_01";
        attribute :>> productId = "X000";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_X000_01_X000 allocate F_X000_01 to X000";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11330";
    }

    item FunctionOwnerTraceRecord_174 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_X100_01";
        attribute :>> productId = "X100";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_X100_01_X100 allocate F_X100_01 to X100";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11331";
    }

    item FunctionOwnerTraceRecord_175 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_X110_01";
        attribute :>> productId = "X110";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_X110_01_X110 allocate F_X110_01 to X110";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11332";
    }

    item FunctionOwnerTraceRecord_176 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_X111_01";
        attribute :>> productId = "X111";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_X111_01_X111 allocate F_X111_01 to X111";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11333";
    }

    item FunctionOwnerTraceRecord_177 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_X111_02";
        attribute :>> productId = "X111";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_X111_02_X111 allocate F_X111_02 to X111";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11334";
    }

    item FunctionOwnerTraceRecord_178 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_X112_01";
        attribute :>> productId = "X112";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_X112_01_X112 allocate F_X112_01 to X112";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11335";
    }

    item FunctionOwnerTraceRecord_179 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_X112_02";
        attribute :>> productId = "X112";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_X112_02_X112 allocate F_X112_02 to X112";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11336";
    }

    item FunctionOwnerTraceRecord_180 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_X112_03";
        attribute :>> productId = "X112";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_X112_03_X112 allocate F_X112_03 to X112";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11337";
    }

    item FunctionOwnerTraceRecord_181 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_X113_01";
        attribute :>> productId = "X113";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_X113_01_X113 allocate F_X113_01 to X113";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11338";
    }

    item FunctionOwnerTraceRecord_182 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_X120_01";
        attribute :>> productId = "X120";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_X120_01_X120 allocate F_X120_01 to X120";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11339";
    }

    item FunctionOwnerTraceRecord_183 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_X121_01";
        attribute :>> productId = "X121";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_X121_01_X121 allocate F_X121_01 to X121";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11340";
    }

    item FunctionOwnerTraceRecord_184 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_X121_02";
        attribute :>> productId = "X121";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_X121_02_X121 allocate F_X121_02 to X121";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11341";
    }

    item FunctionOwnerTraceRecord_185 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_X122_01";
        attribute :>> productId = "X122";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_X122_01_X122 allocate F_X122_01 to X122";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11342";
    }

    item FunctionOwnerTraceRecord_186 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_X123_01";
        attribute :>> productId = "X123";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_X123_01_X123 allocate F_X123_01 to X123";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11343";
    }

    item FunctionOwnerTraceRecord_187 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_X124_01";
        attribute :>> productId = "X124";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_X124_01_X124 allocate F_X124_01 to X124";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11344";
    }

    item FunctionOwnerTraceRecord_188 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_X130_01";
        attribute :>> productId = "X130";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_X130_01_X130 allocate F_X130_01 to X130";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11345";
    }

    item FunctionOwnerTraceRecord_189 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_X131_01";
        attribute :>> productId = "X131";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_X131_01_X131 allocate F_X131_01 to X131";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11346";
    }

    item FunctionOwnerTraceRecord_190 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_X132_01";
        attribute :>> productId = "X132";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_X132_01_X132 allocate F_X132_01 to X132";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11347";
    }

    item FunctionOwnerTraceRecord_191 : FunctionOwnerTraceRecord {
        attribute :>> functionId = "FN_F_X133_01";
        attribute :>> productId = "X133";
        attribute :>> role = "OWNER";
        attribute :>> mappingSource = "SYSML_ALLOCATION";
        attribute :>> evidence = "allocation alloc_ALLOC_F_X133_01_X133 allocate F_X133_01 to X133";
        attribute :>> sourceFile = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml:11348";
    }

    item def ProductInteractionTraceRecord {
        attribute sourceProductId : String;
        attribute targetProductId : String;
        attribute flowName : String;
        attribute flowKind : String;
        attribute flowRef : String;
        attribute interfaceRefs : String;
        attribute connectorRefs : String;
        attribute source : String;
        attribute evidence : String;
    }

    item ProductInteractionTraceRecord_001 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "4200";
        attribute :>> targetProductId = "5100";
        attribute :>> flowName = "高压线路电压";
        attribute :>> flowKind = "energy";
        attribute :>> flowRef = "flow::CG_002543DBE0F9A7FBC2A3FDD3";
        attribute :>> interfaceRefs = "IF_IF_MEA_005,IF_IF_MEA_006";
        attribute :>> connectorRefs = "CG_002543DBE0F9A7FBC2A3FDD3,CG_20C0A22ECCF07864FDBA3F5A";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::4200::5100::physical；SysML叶级连接 CG_002543DBE0F9A7FBC2A3FDD3, CG_20C0A22ECCF07864FDBA3F5A";
    }

    item ProductInteractionTraceRecord_002 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "4200";
        attribute :>> targetProductId = "5100";
        attribute :>> flowName = "高压线路电流";
        attribute :>> flowKind = "energy";
        attribute :>> flowRef = "flow::CG_20C0A22ECCF07864FDBA3F5A";
        attribute :>> interfaceRefs = "IF_IF_MEA_005,IF_IF_MEA_006";
        attribute :>> connectorRefs = "CG_002543DBE0F9A7FBC2A3FDD3,CG_20C0A22ECCF07864FDBA3F5A";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::4200::5100::physical；SysML叶级连接 CG_002543DBE0F9A7FBC2A3FDD3, CG_20C0A22ECCF07864FDBA3F5A";
    }

    item ProductInteractionTraceRecord_003 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "8100";
        attribute :>> targetProductId = "7200";
        attribute :>> flowName = "紧急制动请求";
        attribute :>> flowKind = "signal";
        attribute :>> flowRef = "flow::CG_071B7693DAFA8B87ADA0A61E";
        attribute :>> interfaceRefs = "IF_IF_CMD_003,IF_IF_CMD_004,IF_IF_CMD_030";
        attribute :>> connectorRefs = "CG_071B7693DAFA8B87ADA0A61E,CG_4163C3EB1F2D16B7AFCB21C9,CG_979C19823B520B68E370ECB6,CG_ED49C68C1459BB1005D412BB";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::8100::7200::control；SysML叶级连接 CG_071B7693DAFA8B87ADA0A61E, CG_4163C3EB1F2D16B7AFCB21C9, CG_979C19823B520B68E370ECB6, CG_ED49C68C1459BB1005D412BB";
    }

    item ProductInteractionTraceRecord_004 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "8100";
        attribute :>> targetProductId = "7200";
        attribute :>> flowName = "紧急制动请求";
        attribute :>> flowKind = "signal";
        attribute :>> flowRef = "flow::CG_4163C3EB1F2D16B7AFCB21C9";
        attribute :>> interfaceRefs = "IF_IF_CMD_003,IF_IF_CMD_004,IF_IF_CMD_030";
        attribute :>> connectorRefs = "CG_071B7693DAFA8B87ADA0A61E,CG_4163C3EB1F2D16B7AFCB21C9,CG_979C19823B520B68E370ECB6,CG_ED49C68C1459BB1005D412BB";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::8100::7200::control；SysML叶级连接 CG_071B7693DAFA8B87ADA0A61E, CG_4163C3EB1F2D16B7AFCB21C9, CG_979C19823B520B68E370ECB6, CG_ED49C68C1459BB1005D412BB";
    }

    item ProductInteractionTraceRecord_005 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "8100";
        attribute :>> targetProductId = "7200";
        attribute :>> flowName = "服务制动请求";
        attribute :>> flowKind = "signal";
        attribute :>> flowRef = "flow::CG_979C19823B520B68E370ECB6";
        attribute :>> interfaceRefs = "IF_IF_CMD_003,IF_IF_CMD_004,IF_IF_CMD_030";
        attribute :>> connectorRefs = "CG_071B7693DAFA8B87ADA0A61E,CG_4163C3EB1F2D16B7AFCB21C9,CG_979C19823B520B68E370ECB6,CG_ED49C68C1459BB1005D412BB";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::8100::7200::control；SysML叶级连接 CG_071B7693DAFA8B87ADA0A61E, CG_4163C3EB1F2D16B7AFCB21C9, CG_979C19823B520B68E370ECB6, CG_ED49C68C1459BB1005D412BB";
    }

    item ProductInteractionTraceRecord_006 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "8100";
        attribute :>> targetProductId = "7200";
        attribute :>> flowName = "安全停车/制动请求";
        attribute :>> flowKind = "signal";
        attribute :>> flowRef = "flow::CG_ED49C68C1459BB1005D412BB";
        attribute :>> interfaceRefs = "IF_IF_CMD_003,IF_IF_CMD_004,IF_IF_CMD_030";
        attribute :>> connectorRefs = "CG_071B7693DAFA8B87ADA0A61E,CG_4163C3EB1F2D16B7AFCB21C9,CG_979C19823B520B68E370ECB6,CG_ED49C68C1459BB1005D412BB";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::8100::7200::control；SysML叶级连接 CG_071B7693DAFA8B87ADA0A61E, CG_4163C3EB1F2D16B7AFCB21C9, CG_979C19823B520B68E370ECB6, CG_ED49C68C1459BB1005D412BB";
    }

    item ProductInteractionTraceRecord_007 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "3600";
        attribute :>> targetProductId = "5300";
        attribute :>> flowName = "旋转机械能";
        attribute :>> flowKind = "energy";
        attribute :>> flowRef = "flow::CG_07AF42BFA3927EF22F7BDDE7";
        attribute :>> interfaceRefs = "IF_IF_PHY_005";
        attribute :>> connectorRefs = "CG_07AF42BFA3927EF22F7BDDE7";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::3600::5300::physical；SysML叶级连接 CG_07AF42BFA3927EF22F7BDDE7";
    }

    item ProductInteractionTraceRecord_008 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "5100";
        attribute :>> targetProductId = "8100";
        attribute :>> flowName = "接触网可接收功率";
        attribute :>> flowKind = "energy";
        attribute :>> flowRef = "flow::CG_08375F15DCE75E45D4C45CE8";
        attribute :>> interfaceRefs = "IF_IF_ACC_002,IF_IF_ACC_003,IF_IF_ACC_005,IF_IF_LIM_005,IF_IF_MEA_008,IF_IF_MEA_009";
        attribute :>> connectorRefs = "CG_08375F15DCE75E45D4C45CE8,CG_40ADD911FF2840BEEAA67F8D,CG_4E4C49F08CEE642A5C3C67EB,CG_732BB9F5922B7AC9420BB2D0,CG_A35E2178763C6233BE73AA36,CG_A424455519797490E4F865AA,CG_B399D92EE15558C08A95FA03,CG_BDD8747118488C9BE895D95F,CG_C8FE042475056BF85CFA2B40";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::5100::8100::physical；SysML叶级连接 CG_08375F15DCE75E45D4C45CE8, CG_40ADD911FF2840BEEAA67F8D, CG_4E4C49F08CEE642A5C3C67EB, CG_732BB9F5922B7AC9420BB2D0, CG_A35E2178763C6233BE73AA36, CG_A424455519797490E4F865AA, CG_B399D92EE15558C08A95FA03, CG_BDD8747118488C9BE895D95F, CG_C8FE042475056BF85CFA2B40";
    }

    item ProductInteractionTraceRecord_009 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "5100";
        attribute :>> targetProductId = "8100";
        attribute :>> flowName = "实际再生功率";
        attribute :>> flowKind = "energy";
        attribute :>> flowRef = "flow::CG_40ADD911FF2840BEEAA67F8D";
        attribute :>> interfaceRefs = "IF_IF_ACC_002,IF_IF_ACC_003,IF_IF_ACC_005,IF_IF_LIM_005,IF_IF_MEA_008,IF_IF_MEA_009";
        attribute :>> connectorRefs = "CG_08375F15DCE75E45D4C45CE8,CG_40ADD911FF2840BEEAA67F8D,CG_4E4C49F08CEE642A5C3C67EB,CG_732BB9F5922B7AC9420BB2D0,CG_A35E2178763C6233BE73AA36,CG_A424455519797490E4F865AA,CG_B399D92EE15558C08A95FA03,CG_BDD8747118488C9BE895D95F,CG_C8FE042475056BF85CFA2B40";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::5100::8100::physical；SysML叶级连接 CG_08375F15DCE75E45D4C45CE8, CG_40ADD911FF2840BEEAA67F8D, CG_4E4C49F08CEE642A5C3C67EB, CG_732BB9F5922B7AC9420BB2D0, CG_A35E2178763C6233BE73AA36, CG_A424455519797490E4F865AA, CG_B399D92EE15558C08A95FA03, CG_BDD8747118488C9BE895D95F, CG_C8FE042475056BF85CFA2B40";
    }

    item ProductInteractionTraceRecord_010 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "5100";
        attribute :>> targetProductId = "8100";
        attribute :>> flowName = "中间直流母线电流";
        attribute :>> flowKind = "energy";
        attribute :>> flowRef = "flow::CG_4E4C49F08CEE642A5C3C67EB";
        attribute :>> interfaceRefs = "IF_IF_ACC_002,IF_IF_ACC_003,IF_IF_ACC_005,IF_IF_LIM_005,IF_IF_MEA_008,IF_IF_MEA_009";
        attribute :>> connectorRefs = "CG_08375F15DCE75E45D4C45CE8,CG_40ADD911FF2840BEEAA67F8D,CG_4E4C49F08CEE642A5C3C67EB,CG_732BB9F5922B7AC9420BB2D0,CG_A35E2178763C6233BE73AA36,CG_A424455519797490E4F865AA,CG_B399D92EE15558C08A95FA03,CG_BDD8747118488C9BE895D95F,CG_C8FE042475056BF85CFA2B40";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::5100::8100::physical；SysML叶级连接 CG_08375F15DCE75E45D4C45CE8, CG_40ADD911FF2840BEEAA67F8D, CG_4E4C49F08CEE642A5C3C67EB, CG_732BB9F5922B7AC9420BB2D0, CG_A35E2178763C6233BE73AA36, CG_A424455519797490E4F865AA, CG_B399D92EE15558C08A95FA03, CG_BDD8747118488C9BE895D95F, CG_C8FE042475056BF85CFA2B40";
    }

    item ProductInteractionTraceRecord_011 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "5100";
        attribute :>> targetProductId = "8100";
        attribute :>> flowName = "中间直流母线电压";
        attribute :>> flowKind = "energy";
        attribute :>> flowRef = "flow::CG_732BB9F5922B7AC9420BB2D0";
        attribute :>> interfaceRefs = "IF_IF_ACC_002,IF_IF_ACC_003,IF_IF_ACC_005,IF_IF_LIM_005,IF_IF_MEA_008,IF_IF_MEA_009";
        attribute :>> connectorRefs = "CG_08375F15DCE75E45D4C45CE8,CG_40ADD911FF2840BEEAA67F8D,CG_4E4C49F08CEE642A5C3C67EB,CG_732BB9F5922B7AC9420BB2D0,CG_A35E2178763C6233BE73AA36,CG_A424455519797490E4F865AA,CG_B399D92EE15558C08A95FA03,CG_BDD8747118488C9BE895D95F,CG_C8FE042475056BF85CFA2B40";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::5100::8100::physical；SysML叶级连接 CG_08375F15DCE75E45D4C45CE8, CG_40ADD911FF2840BEEAA67F8D, CG_4E4C49F08CEE642A5C3C67EB, CG_732BB9F5922B7AC9420BB2D0, CG_A35E2178763C6233BE73AA36, CG_A424455519797490E4F865AA, CG_B399D92EE15558C08A95FA03, CG_BDD8747118488C9BE895D95F, CG_C8FE042475056BF85CFA2B40";
    }

    item ProductInteractionTraceRecord_012 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "5100";
        attribute :>> targetProductId = "8100";
        attribute :>> flowName = "制动电阻耗散功率";
        attribute :>> flowKind = "energy";
        attribute :>> flowRef = "flow::CG_A35E2178763C6233BE73AA36";
        attribute :>> interfaceRefs = "IF_IF_ACC_002,IF_IF_ACC_003,IF_IF_ACC_005,IF_IF_LIM_005,IF_IF_MEA_008,IF_IF_MEA_009";
        attribute :>> connectorRefs = "CG_08375F15DCE75E45D4C45CE8,CG_40ADD911FF2840BEEAA67F8D,CG_4E4C49F08CEE642A5C3C67EB,CG_732BB9F5922B7AC9420BB2D0,CG_A35E2178763C6233BE73AA36,CG_A424455519797490E4F865AA,CG_B399D92EE15558C08A95FA03,CG_BDD8747118488C9BE895D95F,CG_C8FE042475056BF85CFA2B40";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::5100::8100::physical；SysML叶级连接 CG_08375F15DCE75E45D4C45CE8, CG_40ADD911FF2840BEEAA67F8D, CG_4E4C49F08CEE642A5C3C67EB, CG_732BB9F5922B7AC9420BB2D0, CG_A35E2178763C6233BE73AA36, CG_A424455519797490E4F865AA, CG_B399D92EE15558C08A95FA03, CG_BDD8747118488C9BE895D95F, CG_C8FE042475056BF85CFA2B40";
    }

    item ProductInteractionTraceRecord_013 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "5100";
        attribute :>> targetProductId = "8100";
        attribute :>> flowName = "中间直流母线电压";
        attribute :>> flowKind = "energy";
        attribute :>> flowRef = "flow::CG_A424455519797490E4F865AA";
        attribute :>> interfaceRefs = "IF_IF_ACC_002,IF_IF_ACC_003,IF_IF_ACC_005,IF_IF_LIM_005,IF_IF_MEA_008,IF_IF_MEA_009";
        attribute :>> connectorRefs = "CG_08375F15DCE75E45D4C45CE8,CG_40ADD911FF2840BEEAA67F8D,CG_4E4C49F08CEE642A5C3C67EB,CG_732BB9F5922B7AC9420BB2D0,CG_A35E2178763C6233BE73AA36,CG_A424455519797490E4F865AA,CG_B399D92EE15558C08A95FA03,CG_BDD8747118488C9BE895D95F,CG_C8FE042475056BF85CFA2B40";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::5100::8100::physical；SysML叶级连接 CG_08375F15DCE75E45D4C45CE8, CG_40ADD911FF2840BEEAA67F8D, CG_4E4C49F08CEE642A5C3C67EB, CG_732BB9F5922B7AC9420BB2D0, CG_A35E2178763C6233BE73AA36, CG_A424455519797490E4F865AA, CG_B399D92EE15558C08A95FA03, CG_BDD8747118488C9BE895D95F, CG_C8FE042475056BF85CFA2B40";
    }

    item ProductInteractionTraceRecord_014 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "5100";
        attribute :>> targetProductId = "8100";
        attribute :>> flowName = "回馈电网功率";
        attribute :>> flowKind = "energy";
        attribute :>> flowRef = "flow::CG_B399D92EE15558C08A95FA03";
        attribute :>> interfaceRefs = "IF_IF_ACC_002,IF_IF_ACC_003,IF_IF_ACC_005,IF_IF_LIM_005,IF_IF_MEA_008,IF_IF_MEA_009";
        attribute :>> connectorRefs = "CG_08375F15DCE75E45D4C45CE8,CG_40ADD911FF2840BEEAA67F8D,CG_4E4C49F08CEE642A5C3C67EB,CG_732BB9F5922B7AC9420BB2D0,CG_A35E2178763C6233BE73AA36,CG_A424455519797490E4F865AA,CG_B399D92EE15558C08A95FA03,CG_BDD8747118488C9BE895D95F,CG_C8FE042475056BF85CFA2B40";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::5100::8100::physical；SysML叶级连接 CG_08375F15DCE75E45D4C45CE8, CG_40ADD911FF2840BEEAA67F8D, CG_4E4C49F08CEE642A5C3C67EB, CG_732BB9F5922B7AC9420BB2D0, CG_A35E2178763C6233BE73AA36, CG_A424455519797490E4F865AA, CG_B399D92EE15558C08A95FA03, CG_BDD8747118488C9BE895D95F, CG_C8FE042475056BF85CFA2B40";
    }

    item ProductInteractionTraceRecord_015 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "5100";
        attribute :>> targetProductId = "8100";
        attribute :>> flowName = "接触网可接收功率";
        attribute :>> flowKind = "energy";
        attribute :>> flowRef = "flow::CG_BDD8747118488C9BE895D95F";
        attribute :>> interfaceRefs = "IF_IF_ACC_002,IF_IF_ACC_003,IF_IF_ACC_005,IF_IF_LIM_005,IF_IF_MEA_008,IF_IF_MEA_009";
        attribute :>> connectorRefs = "CG_08375F15DCE75E45D4C45CE8,CG_40ADD911FF2840BEEAA67F8D,CG_4E4C49F08CEE642A5C3C67EB,CG_732BB9F5922B7AC9420BB2D0,CG_A35E2178763C6233BE73AA36,CG_A424455519797490E4F865AA,CG_B399D92EE15558C08A95FA03,CG_BDD8747118488C9BE895D95F,CG_C8FE042475056BF85CFA2B40";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::5100::8100::physical；SysML叶级连接 CG_08375F15DCE75E45D4C45CE8, CG_40ADD911FF2840BEEAA67F8D, CG_4E4C49F08CEE642A5C3C67EB, CG_732BB9F5922B7AC9420BB2D0, CG_A35E2178763C6233BE73AA36, CG_A424455519797490E4F865AA, CG_B399D92EE15558C08A95FA03, CG_BDD8747118488C9BE895D95F, CG_C8FE042475056BF85CFA2B40";
    }

    item ProductInteractionTraceRecord_016 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "5100";
        attribute :>> targetProductId = "8100";
        attribute :>> flowName = "中间直流母线电压";
        attribute :>> flowKind = "energy";
        attribute :>> flowRef = "flow::CG_C8FE042475056BF85CFA2B40";
        attribute :>> interfaceRefs = "IF_IF_ACC_002,IF_IF_ACC_003,IF_IF_ACC_005,IF_IF_LIM_005,IF_IF_MEA_008,IF_IF_MEA_009";
        attribute :>> connectorRefs = "CG_08375F15DCE75E45D4C45CE8,CG_40ADD911FF2840BEEAA67F8D,CG_4E4C49F08CEE642A5C3C67EB,CG_732BB9F5922B7AC9420BB2D0,CG_A35E2178763C6233BE73AA36,CG_A424455519797490E4F865AA,CG_B399D92EE15558C08A95FA03,CG_BDD8747118488C9BE895D95F,CG_C8FE042475056BF85CFA2B40";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::5100::8100::physical；SysML叶级连接 CG_08375F15DCE75E45D4C45CE8, CG_40ADD911FF2840BEEAA67F8D, CG_4E4C49F08CEE642A5C3C67EB, CG_732BB9F5922B7AC9420BB2D0, CG_A35E2178763C6233BE73AA36, CG_A424455519797490E4F865AA, CG_B399D92EE15558C08A95FA03, CG_BDD8747118488C9BE895D95F, CG_C8FE042475056BF85CFA2B40";
    }

    item ProductInteractionTraceRecord_017 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "X100";
        attribute :>> targetProductId = "8100";
        attribute :>> flowName = "储能吸收功率";
        attribute :>> flowKind = "energy";
        attribute :>> flowRef = "flow::CG_093EFCE58F3AB220CFEC48AC";
        attribute :>> interfaceRefs = "IF_IF_ACC_004,IF_IF_LIM_009,IF_IF_LIM_010,IF_IF_MEA_029";
        attribute :>> connectorRefs = "CG_093EFCE58F3AB220CFEC48AC,CG_A6D783BBFCF6C6DA11FFCF2D,CG_CB302083C9F33A1345D9C406,CG_DAF7D43DDD825831F29A70F8";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::X100::8100::physical；SysML叶级连接 CG_093EFCE58F3AB220CFEC48AC, CG_A6D783BBFCF6C6DA11FFCF2D, CG_CB302083C9F33A1345D9C406, CG_DAF7D43DDD825831F29A70F8";
    }

    item ProductInteractionTraceRecord_018 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "X100";
        attribute :>> targetProductId = "8100";
        attribute :>> flowName = "双向DC/DC实际功率";
        attribute :>> flowKind = "energy";
        attribute :>> flowRef = "flow::CG_A6D783BBFCF6C6DA11FFCF2D";
        attribute :>> interfaceRefs = "IF_IF_ACC_004,IF_IF_LIM_009,IF_IF_LIM_010,IF_IF_MEA_029";
        attribute :>> connectorRefs = "CG_093EFCE58F3AB220CFEC48AC,CG_A6D783BBFCF6C6DA11FFCF2D,CG_CB302083C9F33A1345D9C406,CG_DAF7D43DDD825831F29A70F8";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::X100::8100::physical；SysML叶级连接 CG_093EFCE58F3AB220CFEC48AC, CG_A6D783BBFCF6C6DA11FFCF2D, CG_CB302083C9F33A1345D9C406, CG_DAF7D43DDD825831F29A70F8";
    }

    item ProductInteractionTraceRecord_019 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "X100";
        attribute :>> targetProductId = "8100";
        attribute :>> flowName = "储能可用充电功率";
        attribute :>> flowKind = "energy";
        attribute :>> flowRef = "flow::CG_CB302083C9F33A1345D9C406";
        attribute :>> interfaceRefs = "IF_IF_ACC_004,IF_IF_LIM_009,IF_IF_LIM_010,IF_IF_MEA_029";
        attribute :>> connectorRefs = "CG_093EFCE58F3AB220CFEC48AC,CG_A6D783BBFCF6C6DA11FFCF2D,CG_CB302083C9F33A1345D9C406,CG_DAF7D43DDD825831F29A70F8";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::X100::8100::physical；SysML叶级连接 CG_093EFCE58F3AB220CFEC48AC, CG_A6D783BBFCF6C6DA11FFCF2D, CG_CB302083C9F33A1345D9C406, CG_DAF7D43DDD825831F29A70F8";
    }

    item ProductInteractionTraceRecord_020 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "X100";
        attribute :>> targetProductId = "8100";
        attribute :>> flowName = "储能可用放电功率";
        attribute :>> flowKind = "energy";
        attribute :>> flowRef = "flow::CG_DAF7D43DDD825831F29A70F8";
        attribute :>> interfaceRefs = "IF_IF_ACC_004,IF_IF_LIM_009,IF_IF_LIM_010,IF_IF_MEA_029";
        attribute :>> connectorRefs = "CG_093EFCE58F3AB220CFEC48AC,CG_A6D783BBFCF6C6DA11FFCF2D,CG_CB302083C9F33A1345D9C406,CG_DAF7D43DDD825831F29A70F8";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::X100::8100::physical；SysML叶级连接 CG_093EFCE58F3AB220CFEC48AC, CG_A6D783BBFCF6C6DA11FFCF2D, CG_CB302083C9F33A1345D9C406, CG_DAF7D43DDD825831F29A70F8";
    }

    item ProductInteractionTraceRecord_021 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "E100";
        attribute :>> targetProductId = "8100";
        attribute :>> flowName = "ATP/外部安全系统状态";
        attribute :>> flowKind = "state";
        attribute :>> flowRef = "flow::CG_0D68248E62957CCB92C5A2A5";
        attribute :>> interfaceRefs = "IF_IF_STA_027";
        attribute :>> connectorRefs = "CG_0D68248E62957CCB92C5A2A5,CG_89318B491DF9CED18997C36D";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::E100::8100::state；SysML叶级连接 CG_0D68248E62957CCB92C5A2A5, CG_89318B491DF9CED18997C36D";
    }

    item ProductInteractionTraceRecord_022 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "E100";
        attribute :>> targetProductId = "8100";
        attribute :>> flowName = "ATP/外部安全系统状态";
        attribute :>> flowKind = "state";
        attribute :>> flowRef = "flow::CG_89318B491DF9CED18997C36D";
        attribute :>> interfaceRefs = "IF_IF_STA_027";
        attribute :>> connectorRefs = "CG_0D68248E62957CCB92C5A2A5,CG_89318B491DF9CED18997C36D";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::E100::8100::state；SysML叶级连接 CG_0D68248E62957CCB92C5A2A5, CG_89318B491DF9CED18997C36D";
    }

    item ProductInteractionTraceRecord_023 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "7200";
        attribute :>> targetProductId = "8100";
        attribute :>> flowName = "制动系统可用状态";
        attribute :>> flowKind = "state";
        attribute :>> flowRef = "flow::CG_1102EBD35D52A38B96D5D2E7";
        attribute :>> interfaceRefs = "IF_IF_STA_003";
        attribute :>> connectorRefs = "CG_1102EBD35D52A38B96D5D2E7,CG_944069F2CBBFA2A01274A9DB";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::7200::8100::state；SysML叶级连接 CG_1102EBD35D52A38B96D5D2E7, CG_944069F2CBBFA2A01274A9DB";
    }

    item ProductInteractionTraceRecord_024 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "7200";
        attribute :>> targetProductId = "8100";
        attribute :>> flowName = "制动系统可用状态";
        attribute :>> flowKind = "state";
        attribute :>> flowRef = "flow::CG_944069F2CBBFA2A01274A9DB";
        attribute :>> interfaceRefs = "IF_IF_STA_003";
        attribute :>> connectorRefs = "CG_1102EBD35D52A38B96D5D2E7,CG_944069F2CBBFA2A01274A9DB";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::7200::8100::state；SysML叶级连接 CG_1102EBD35D52A38B96D5D2E7, CG_944069F2CBBFA2A01274A9DB";
    }

    item ProductInteractionTraceRecord_025 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "4500";
        attribute :>> targetProductId = "5100";
        attribute :>> flowName = "牵引变压器次级交流电能";
        attribute :>> flowKind = "energy";
        attribute :>> flowRef = "flow::CG_117A3F0E6C8FF8FF0013A46B";
        attribute :>> interfaceRefs = "IF_IF_PHY_014";
        attribute :>> connectorRefs = "CG_117A3F0E6C8FF8FF0013A46B,CG_118F2C2B84D1D301C7BE63F8";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::4500::5100::physical；SysML叶级连接 CG_117A3F0E6C8FF8FF0013A46B, CG_118F2C2B84D1D301C7BE63F8";
    }

    item ProductInteractionTraceRecord_026 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "4500";
        attribute :>> targetProductId = "5100";
        attribute :>> flowName = "牵引变压器次级交流电能";
        attribute :>> flowKind = "energy";
        attribute :>> flowRef = "flow::CG_118F2C2B84D1D301C7BE63F8";
        attribute :>> interfaceRefs = "IF_IF_PHY_014";
        attribute :>> connectorRefs = "CG_117A3F0E6C8FF8FF0013A46B,CG_118F2C2B84D1D301C7BE63F8";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::4500::5100::physical；SysML叶级连接 CG_117A3F0E6C8FF8FF0013A46B, CG_118F2C2B84D1D301C7BE63F8";
    }

    item ProductInteractionTraceRecord_027 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "8100";
        attribute :>> targetProductId = "7200";
        attribute :>> flowName = "动态制动可用状态";
        attribute :>> flowKind = "state";
        attribute :>> flowRef = "flow::CG_1ACF37CC65D3FF235E8BD75C";
        attribute :>> interfaceRefs = "IF_IF_STA_002,IF_IF_STA_025";
        attribute :>> connectorRefs = "CG_1ACF37CC65D3FF235E8BD75C,CG_CE151D40A2BF816F41762F4C";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::8100::7200::state；SysML叶级连接 CG_1ACF37CC65D3FF235E8BD75C, CG_CE151D40A2BF816F41762F4C";
    }

    item ProductInteractionTraceRecord_028 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "8100";
        attribute :>> targetProductId = "7200";
        attribute :>> flowName = "制动安全回路状态";
        attribute :>> flowKind = "state";
        attribute :>> flowRef = "flow::CG_CE151D40A2BF816F41762F4C";
        attribute :>> interfaceRefs = "IF_IF_STA_002,IF_IF_STA_025";
        attribute :>> connectorRefs = "CG_1ACF37CC65D3FF235E8BD75C,CG_CE151D40A2BF816F41762F4C";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::8100::7200::state；SysML叶级连接 CG_1ACF37CC65D3FF235E8BD75C, CG_CE151D40A2BF816F41762F4C";
    }

    item ProductInteractionTraceRecord_029 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "8100";
        attribute :>> targetProductId = "X100";
        attribute :>> flowName = "储能主接触器指令";
        attribute :>> flowKind = "signal";
        attribute :>> flowRef = "flow::CG_1AE13610E33C0DC7055CFCED";
        attribute :>> interfaceRefs = "IF_IF_CMD_025,IF_IF_CMD_026,IF_IF_CMD_027,IF_IF_CMD_028,IF_IF_CMD_029";
        attribute :>> connectorRefs = "CG_1AE13610E33C0DC7055CFCED,CG_25DC22E45A984D1CB28D188B,CG_7A2381DC8C36A40B747035A5,CG_D8FCE908D4FD9343C6353985,CG_D9CD1E8933F596F319A67625";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::8100::X100::control；SysML叶级连接 CG_1AE13610E33C0DC7055CFCED, CG_25DC22E45A984D1CB28D188B, CG_7A2381DC8C36A40B747035A5, CG_D8FCE908D4FD9343C6353985, CG_D9CD1E8933F596F319A67625";
    }

    item ProductInteractionTraceRecord_030 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "8100";
        attribute :>> targetProductId = "X100";
        attribute :>> flowName = "双向DC/DC使能";
        attribute :>> flowKind = "signal";
        attribute :>> flowRef = "flow::CG_25DC22E45A984D1CB28D188B";
        attribute :>> interfaceRefs = "IF_IF_CMD_025,IF_IF_CMD_026,IF_IF_CMD_027,IF_IF_CMD_028,IF_IF_CMD_029";
        attribute :>> connectorRefs = "CG_1AE13610E33C0DC7055CFCED,CG_25DC22E45A984D1CB28D188B,CG_7A2381DC8C36A40B747035A5,CG_D8FCE908D4FD9343C6353985,CG_D9CD1E8933F596F319A67625";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::8100::X100::control；SysML叶级连接 CG_1AE13610E33C0DC7055CFCED, CG_25DC22E45A984D1CB28D188B, CG_7A2381DC8C36A40B747035A5, CG_D8FCE908D4FD9343C6353985, CG_D9CD1E8933F596F319A67625";
    }

    item ProductInteractionTraceRecord_031 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "8100";
        attribute :>> targetProductId = "X100";
        attribute :>> flowName = "储能功率请求";
        attribute :>> flowKind = "signal";
        attribute :>> flowRef = "flow::CG_7A2381DC8C36A40B747035A5";
        attribute :>> interfaceRefs = "IF_IF_CMD_025,IF_IF_CMD_026,IF_IF_CMD_027,IF_IF_CMD_028,IF_IF_CMD_029";
        attribute :>> connectorRefs = "CG_1AE13610E33C0DC7055CFCED,CG_25DC22E45A984D1CB28D188B,CG_7A2381DC8C36A40B747035A5,CG_D8FCE908D4FD9343C6353985,CG_D9CD1E8933F596F319A67625";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::8100::X100::control；SysML叶级连接 CG_1AE13610E33C0DC7055CFCED, CG_25DC22E45A984D1CB28D188B, CG_7A2381DC8C36A40B747035A5, CG_D8FCE908D4FD9343C6353985, CG_D9CD1E8933F596F319A67625";
    }

    item ProductInteractionTraceRecord_032 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "8100";
        attribute :>> targetProductId = "X100";
        attribute :>> flowName = "储能故障复位指令";
        attribute :>> flowKind = "signal";
        attribute :>> flowRef = "flow::CG_D8FCE908D4FD9343C6353985";
        attribute :>> interfaceRefs = "IF_IF_CMD_025,IF_IF_CMD_026,IF_IF_CMD_027,IF_IF_CMD_028,IF_IF_CMD_029";
        attribute :>> connectorRefs = "CG_1AE13610E33C0DC7055CFCED,CG_25DC22E45A984D1CB28D188B,CG_7A2381DC8C36A40B747035A5,CG_D8FCE908D4FD9343C6353985,CG_D9CD1E8933F596F319A67625";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::8100::X100::control；SysML叶级连接 CG_1AE13610E33C0DC7055CFCED, CG_25DC22E45A984D1CB28D188B, CG_7A2381DC8C36A40B747035A5, CG_D8FCE908D4FD9343C6353985, CG_D9CD1E8933F596F319A67625";
    }

    item ProductInteractionTraceRecord_033 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "8100";
        attribute :>> targetProductId = "X100";
        attribute :>> flowName = "储能预充电指令";
        attribute :>> flowKind = "signal";
        attribute :>> flowRef = "flow::CG_D9CD1E8933F596F319A67625";
        attribute :>> interfaceRefs = "IF_IF_CMD_025,IF_IF_CMD_026,IF_IF_CMD_027,IF_IF_CMD_028,IF_IF_CMD_029";
        attribute :>> connectorRefs = "CG_1AE13610E33C0DC7055CFCED,CG_25DC22E45A984D1CB28D188B,CG_7A2381DC8C36A40B747035A5,CG_D8FCE908D4FD9343C6353985,CG_D9CD1E8933F596F319A67625";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::8100::X100::control；SysML叶级连接 CG_1AE13610E33C0DC7055CFCED, CG_25DC22E45A984D1CB28D188B, CG_7A2381DC8C36A40B747035A5, CG_D8FCE908D4FD9343C6353985, CG_D9CD1E8933F596F319A67625";
    }

    item ProductInteractionTraceRecord_034 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "8100";
        attribute :>> targetProductId = "7200";
        attribute :>> flowName = "制动缸压力";
        attribute :>> flowKind = "unknown";
        attribute :>> flowRef = "flow::CG_1AEA8B915E14A5D0FFEE30D9";
        attribute :>> interfaceRefs = "IF_IF_LIM_001,IF_IF_MEA_013,IF_IF_MEA_014,IF_IF_MEA_016";
        attribute :>> connectorRefs = "CG_1AEA8B915E14A5D0FFEE30D9,CG_A0B82CF482DDFB4553F8CFCA,CG_BEDE0932E86628B2EFCA8CCD,CG_E8DAA56D71F2BE4B5E1C9BBF";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::8100::7200::physical；SysML叶级连接 CG_1AEA8B915E14A5D0FFEE30D9, CG_A0B82CF482DDFB4553F8CFCA, CG_BEDE0932E86628B2EFCA8CCD, CG_E8DAA56D71F2BE4B5E1C9BBF";
    }

    item ProductInteractionTraceRecord_035 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "8100";
        attribute :>> targetProductId = "7200";
        attribute :>> flowName = "总风管压力";
        attribute :>> flowKind = "unknown";
        attribute :>> flowRef = "flow::CG_A0B82CF482DDFB4553F8CFCA";
        attribute :>> interfaceRefs = "IF_IF_LIM_001,IF_IF_MEA_013,IF_IF_MEA_014,IF_IF_MEA_016";
        attribute :>> connectorRefs = "CG_1AEA8B915E14A5D0FFEE30D9,CG_A0B82CF482DDFB4553F8CFCA,CG_BEDE0932E86628B2EFCA8CCD,CG_E8DAA56D71F2BE4B5E1C9BBF";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::8100::7200::physical；SysML叶级连接 CG_1AEA8B915E14A5D0FFEE30D9, CG_A0B82CF482DDFB4553F8CFCA, CG_BEDE0932E86628B2EFCA8CCD, CG_E8DAA56D71F2BE4B5E1C9BBF";
    }

    item ProductInteractionTraceRecord_036 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "8100";
        attribute :>> targetProductId = "7200";
        attribute :>> flowName = "可用动态制动力";
        attribute :>> flowKind = "force";
        attribute :>> flowRef = "flow::CG_BEDE0932E86628B2EFCA8CCD";
        attribute :>> interfaceRefs = "IF_IF_LIM_001,IF_IF_MEA_013,IF_IF_MEA_014,IF_IF_MEA_016";
        attribute :>> connectorRefs = "CG_1AEA8B915E14A5D0FFEE30D9,CG_A0B82CF482DDFB4553F8CFCA,CG_BEDE0932E86628B2EFCA8CCD,CG_E8DAA56D71F2BE4B5E1C9BBF";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::8100::7200::physical；SysML叶级连接 CG_1AEA8B915E14A5D0FFEE30D9, CG_A0B82CF482DDFB4553F8CFCA, CG_BEDE0932E86628B2EFCA8CCD, CG_E8DAA56D71F2BE4B5E1C9BBF";
    }

    item ProductInteractionTraceRecord_037 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "8100";
        attribute :>> targetProductId = "7200";
        attribute :>> flowName = "实际动态制动力";
        attribute :>> flowKind = "force";
        attribute :>> flowRef = "flow::CG_E8DAA56D71F2BE4B5E1C9BBF";
        attribute :>> interfaceRefs = "IF_IF_LIM_001,IF_IF_MEA_013,IF_IF_MEA_014,IF_IF_MEA_016";
        attribute :>> connectorRefs = "CG_1AEA8B915E14A5D0FFEE30D9,CG_A0B82CF482DDFB4553F8CFCA,CG_BEDE0932E86628B2EFCA8CCD,CG_E8DAA56D71F2BE4B5E1C9BBF";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::8100::7200::physical；SysML叶级连接 CG_1AEA8B915E14A5D0FFEE30D9, CG_A0B82CF482DDFB4553F8CFCA, CG_BEDE0932E86628B2EFCA8CCD, CG_E8DAA56D71F2BE4B5E1C9BBF";
    }

    item ProductInteractionTraceRecord_038 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "4200";
        attribute :>> targetProductId = "8100";
        attribute :>> flowName = "高压线路电压";
        attribute :>> flowKind = "energy";
        attribute :>> flowRef = "flow::CG_1C5FC46A1E7682144A3BDDDF";
        attribute :>> interfaceRefs = "IF_IF_MEA_005,IF_IF_MEA_006";
        attribute :>> connectorRefs = "CG_1C5FC46A1E7682144A3BDDDF,CG_FE573ED935CFF37491A053E8";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::4200::8100::physical；SysML叶级连接 CG_1C5FC46A1E7682144A3BDDDF, CG_FE573ED935CFF37491A053E8";
    }

    item ProductInteractionTraceRecord_039 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "4200";
        attribute :>> targetProductId = "8100";
        attribute :>> flowName = "高压线路电流";
        attribute :>> flowKind = "energy";
        attribute :>> flowRef = "flow::CG_FE573ED935CFF37491A053E8";
        attribute :>> interfaceRefs = "IF_IF_MEA_005,IF_IF_MEA_006";
        attribute :>> connectorRefs = "CG_1C5FC46A1E7682144A3BDDDF,CG_FE573ED935CFF37491A053E8";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::4200::8100::physical；SysML叶级连接 CG_1C5FC46A1E7682144A3BDDDF, CG_FE573ED935CFF37491A053E8";
    }

    item ProductInteractionTraceRecord_040 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "4500";
        attribute :>> targetProductId = "4200";
        attribute :>> flowName = "高压系统故障状态";
        attribute :>> flowKind = "state";
        attribute :>> flowRef = "flow::CG_2274BA128E639FDE4D4F56EC";
        attribute :>> interfaceRefs = "IF_IF_STA_016";
        attribute :>> connectorRefs = "CG_2274BA128E639FDE4D4F56EC";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::4500::4200::state；SysML叶级连接 CG_2274BA128E639FDE4D4F56EC";
    }

    item ProductInteractionTraceRecord_041 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "D100";
        attribute :>> targetProductId = "8100";
        attribute :>> flowName = "牵引指令";
        attribute :>> flowKind = "signal";
        attribute :>> flowRef = "flow::CG_2E8F3CC8A8EBCDE6B7CF4D27";
        attribute :>> interfaceRefs = "IF_IF_CMD_001,IF_IF_CMD_002,IF_IF_CMD_003,IF_IF_CMD_004";
        attribute :>> connectorRefs = "CG_2E8F3CC8A8EBCDE6B7CF4D27,CG_41AD09EEB4EAB9DC956C08F8,CG_663CDC611495882DCD3E5B8F,CG_8EED0159D22D9EDC70A9EA67,CG_A3B31951ADAE62C498E76260";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::D100::8100::control；SysML叶级连接 CG_2E8F3CC8A8EBCDE6B7CF4D27, CG_41AD09EEB4EAB9DC956C08F8, CG_663CDC611495882DCD3E5B8F, CG_8EED0159D22D9EDC70A9EA67, CG_A3B31951ADAE62C498E76260";
    }

    item ProductInteractionTraceRecord_042 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "D100";
        attribute :>> targetProductId = "8100";
        attribute :>> flowName = "服务制动请求";
        attribute :>> flowKind = "signal";
        attribute :>> flowRef = "flow::CG_41AD09EEB4EAB9DC956C08F8";
        attribute :>> interfaceRefs = "IF_IF_CMD_001,IF_IF_CMD_002,IF_IF_CMD_003,IF_IF_CMD_004";
        attribute :>> connectorRefs = "CG_2E8F3CC8A8EBCDE6B7CF4D27,CG_41AD09EEB4EAB9DC956C08F8,CG_663CDC611495882DCD3E5B8F,CG_8EED0159D22D9EDC70A9EA67,CG_A3B31951ADAE62C498E76260";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::D100::8100::control；SysML叶级连接 CG_2E8F3CC8A8EBCDE6B7CF4D27, CG_41AD09EEB4EAB9DC956C08F8, CG_663CDC611495882DCD3E5B8F, CG_8EED0159D22D9EDC70A9EA67, CG_A3B31951ADAE62C498E76260";
    }

    item ProductInteractionTraceRecord_043 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "D100";
        attribute :>> targetProductId = "8100";
        attribute :>> flowName = "紧急制动请求";
        attribute :>> flowKind = "signal";
        attribute :>> flowRef = "flow::CG_663CDC611495882DCD3E5B8F";
        attribute :>> interfaceRefs = "IF_IF_CMD_001,IF_IF_CMD_002,IF_IF_CMD_003,IF_IF_CMD_004";
        attribute :>> connectorRefs = "CG_2E8F3CC8A8EBCDE6B7CF4D27,CG_41AD09EEB4EAB9DC956C08F8,CG_663CDC611495882DCD3E5B8F,CG_8EED0159D22D9EDC70A9EA67,CG_A3B31951ADAE62C498E76260";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::D100::8100::control；SysML叶级连接 CG_2E8F3CC8A8EBCDE6B7CF4D27, CG_41AD09EEB4EAB9DC956C08F8, CG_663CDC611495882DCD3E5B8F, CG_8EED0159D22D9EDC70A9EA67, CG_A3B31951ADAE62C498E76260";
    }

    item ProductInteractionTraceRecord_044 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "D100";
        attribute :>> targetProductId = "8100";
        attribute :>> flowName = "紧急制动请求";
        attribute :>> flowKind = "signal";
        attribute :>> flowRef = "flow::CG_8EED0159D22D9EDC70A9EA67";
        attribute :>> interfaceRefs = "IF_IF_CMD_001,IF_IF_CMD_002,IF_IF_CMD_003,IF_IF_CMD_004";
        attribute :>> connectorRefs = "CG_2E8F3CC8A8EBCDE6B7CF4D27,CG_41AD09EEB4EAB9DC956C08F8,CG_663CDC611495882DCD3E5B8F,CG_8EED0159D22D9EDC70A9EA67,CG_A3B31951ADAE62C498E76260";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::D100::8100::control；SysML叶级连接 CG_2E8F3CC8A8EBCDE6B7CF4D27, CG_41AD09EEB4EAB9DC956C08F8, CG_663CDC611495882DCD3E5B8F, CG_8EED0159D22D9EDC70A9EA67, CG_A3B31951ADAE62C498E76260";
    }

    item ProductInteractionTraceRecord_045 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "D100";
        attribute :>> targetProductId = "8100";
        attribute :>> flowName = "列车方向指令";
        attribute :>> flowKind = "signal";
        attribute :>> flowRef = "flow::CG_A3B31951ADAE62C498E76260";
        attribute :>> interfaceRefs = "IF_IF_CMD_001,IF_IF_CMD_002,IF_IF_CMD_003,IF_IF_CMD_004";
        attribute :>> connectorRefs = "CG_2E8F3CC8A8EBCDE6B7CF4D27,CG_41AD09EEB4EAB9DC956C08F8,CG_663CDC611495882DCD3E5B8F,CG_8EED0159D22D9EDC70A9EA67,CG_A3B31951ADAE62C498E76260";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::D100::8100::control；SysML叶级连接 CG_2E8F3CC8A8EBCDE6B7CF4D27, CG_41AD09EEB4EAB9DC956C08F8, CG_663CDC611495882DCD3E5B8F, CG_8EED0159D22D9EDC70A9EA67, CG_A3B31951ADAE62C498E76260";
    }

    item ProductInteractionTraceRecord_046 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "4200";
        attribute :>> targetProductId = "4100";
        attribute :>> flowName = "受电弓控制指令";
        attribute :>> flowKind = "signal";
        attribute :>> flowRef = "flow::CG_2EE117B4B0633E38D394B904";
        attribute :>> interfaceRefs = "IF_IF_CMD_018";
        attribute :>> connectorRefs = "CG_2EE117B4B0633E38D394B904";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::4200::4100::control；SysML叶级连接 CG_2EE117B4B0633E38D394B904";
    }

    item ProductInteractionTraceRecord_047 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "5300";
        attribute :>> targetProductId = "3500";
        attribute :>> flowName = "旋转机械能";
        attribute :>> flowKind = "energy";
        attribute :>> flowRef = "flow::CG_338D68ABEF709ACD5E0DDCC6";
        attribute :>> interfaceRefs = "IF_IF_PHY_005";
        attribute :>> connectorRefs = "CG_338D68ABEF709ACD5E0DDCC6";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::5300::3500::physical；SysML叶级连接 CG_338D68ABEF709ACD5E0DDCC6";
    }

    item ProductInteractionTraceRecord_048 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "4200";
        attribute :>> targetProductId = "4500";
        attribute :>> flowName = "高压断路器状态";
        attribute :>> flowKind = "state";
        attribute :>> flowRef = "flow::CG_37792F42F4274C7C51C63270";
        attribute :>> interfaceRefs = "IF_IF_STA_013,IF_IF_STA_016";
        attribute :>> connectorRefs = "CG_37792F42F4274C7C51C63270,CG_CE2820923CC0CB141833E11D";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::4200::4500::state；SysML叶级连接 CG_37792F42F4274C7C51C63270, CG_CE2820923CC0CB141833E11D";
    }

    item ProductInteractionTraceRecord_049 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "4200";
        attribute :>> targetProductId = "4500";
        attribute :>> flowName = "高压系统故障状态";
        attribute :>> flowKind = "state";
        attribute :>> flowRef = "flow::CG_CE2820923CC0CB141833E11D";
        attribute :>> interfaceRefs = "IF_IF_STA_013,IF_IF_STA_016";
        attribute :>> connectorRefs = "CG_37792F42F4274C7C51C63270,CG_CE2820923CC0CB141833E11D";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::4200::4500::state；SysML叶级连接 CG_37792F42F4274C7C51C63270, CG_CE2820923CC0CB141833E11D";
    }

    item ProductInteractionTraceRecord_050 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "5300";
        attribute :>> targetProductId = "5100";
        attribute :>> flowName = "电机侧相电压";
        attribute :>> flowKind = "energy";
        attribute :>> flowRef = "flow::CG_37ECA5B04E215AC3E6A4B472";
        attribute :>> interfaceRefs = "IF_IF_MEA_004,IF_IF_MEA_011,IF_IF_MEA_012";
        attribute :>> connectorRefs = "CG_37ECA5B04E215AC3E6A4B472,CG_46A1EE350324445D016EAF45,CG_D4DF5719633CB5B375F35094";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::5300::5100::physical；SysML叶级连接 CG_37ECA5B04E215AC3E6A4B472, CG_46A1EE350324445D016EAF45, CG_D4DF5719633CB5B375F35094";
    }

    item ProductInteractionTraceRecord_051 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "5300";
        attribute :>> targetProductId = "5100";
        attribute :>> flowName = "牵引电机转速";
        attribute :>> flowKind = "energy";
        attribute :>> flowRef = "flow::CG_46A1EE350324445D016EAF45";
        attribute :>> interfaceRefs = "IF_IF_MEA_004,IF_IF_MEA_011,IF_IF_MEA_012";
        attribute :>> connectorRefs = "CG_37ECA5B04E215AC3E6A4B472,CG_46A1EE350324445D016EAF45,CG_D4DF5719633CB5B375F35094";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::5300::5100::physical；SysML叶级连接 CG_37ECA5B04E215AC3E6A4B472, CG_46A1EE350324445D016EAF45, CG_D4DF5719633CB5B375F35094";
    }

    item ProductInteractionTraceRecord_052 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "5300";
        attribute :>> targetProductId = "5100";
        attribute :>> flowName = "牵引电机实际转矩";
        attribute :>> flowKind = "energy";
        attribute :>> flowRef = "flow::CG_D4DF5719633CB5B375F35094";
        attribute :>> interfaceRefs = "IF_IF_MEA_004,IF_IF_MEA_011,IF_IF_MEA_012";
        attribute :>> connectorRefs = "CG_37ECA5B04E215AC3E6A4B472,CG_46A1EE350324445D016EAF45,CG_D4DF5719633CB5B375F35094";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::5300::5100::physical；SysML叶级连接 CG_37ECA5B04E215AC3E6A4B472, CG_46A1EE350324445D016EAF45, CG_D4DF5719633CB5B375F35094";
    }

    item ProductInteractionTraceRecord_053 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "5100";
        attribute :>> targetProductId = "5300";
        attribute :>> flowName = "三相交流电能";
        attribute :>> flowKind = "energy";
        attribute :>> flowRef = "flow::CG_3BD24EBE88F37EEFFE563597";
        attribute :>> interfaceRefs = "IF_IF_PHY_004";
        attribute :>> connectorRefs = "CG_3BD24EBE88F37EEFFE563597";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::5100::5300::physical；SysML叶级连接 CG_3BD24EBE88F37EEFFE563597";
    }

    item ProductInteractionTraceRecord_054 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "3500";
        attribute :>> targetProductId = "3100";
        attribute :>> flowName = "旋转机械能";
        attribute :>> flowKind = "energy";
        attribute :>> flowRef = "flow::CG_3CA6C3BF7D7B4F80CF0990D0";
        attribute :>> interfaceRefs = "IF_IF_PHY_005";
        attribute :>> connectorRefs = "CG_3CA6C3BF7D7B4F80CF0990D0";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::3500::3100::physical；SysML叶级连接 CG_3CA6C3BF7D7B4F80CF0990D0";
    }

    item ProductInteractionTraceRecord_055 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "3600";
        attribute :>> targetProductId = "3100";
        attribute :>> flowName = "旋转机械能";
        attribute :>> flowKind = "energy";
        attribute :>> flowRef = "flow::CG_4CB0735167799FD438F90DD2";
        attribute :>> interfaceRefs = "IF_IF_PHY_005";
        attribute :>> connectorRefs = "CG_4CB0735167799FD438F90DD2,CG_FA31DFA220FEF0D6FAC8EB67";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::3600::3100::physical；SysML叶级连接 CG_4CB0735167799FD438F90DD2, CG_FA31DFA220FEF0D6FAC8EB67";
    }

    item ProductInteractionTraceRecord_056 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "3600";
        attribute :>> targetProductId = "3100";
        attribute :>> flowName = "旋转机械能";
        attribute :>> flowKind = "energy";
        attribute :>> flowRef = "flow::CG_FA31DFA220FEF0D6FAC8EB67";
        attribute :>> interfaceRefs = "IF_IF_PHY_005";
        attribute :>> connectorRefs = "CG_4CB0735167799FD438F90DD2,CG_FA31DFA220FEF0D6FAC8EB67";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::3600::3100::physical；SysML叶级连接 CG_4CB0735167799FD438F90DD2, CG_FA31DFA220FEF0D6FAC8EB67";
    }

    item ProductInteractionTraceRecord_057 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "5100";
        attribute :>> targetProductId = "8100";
        attribute :>> flowName = "牵引变流器故障状态";
        attribute :>> flowKind = "state";
        attribute :>> flowRef = "flow::CG_55513667B46680F5B87A0939";
        attribute :>> interfaceRefs = "IF_IF_STA_019";
        attribute :>> connectorRefs = "CG_55513667B46680F5B87A0939";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::5100::8100::state；SysML叶级连接 CG_55513667B46680F5B87A0939";
    }

    item ProductInteractionTraceRecord_058 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "8100";
        attribute :>> targetProductId = "3800";
        attribute :>> flowName = "撒砂请求";
        attribute :>> flowKind = "signal";
        attribute :>> flowRef = "flow::CG_565AF053FC6E3FF333FD7433";
        attribute :>> interfaceRefs = "IF_IF_CMD_024";
        attribute :>> connectorRefs = "CG_565AF053FC6E3FF333FD7433";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::8100::3800::control；SysML叶级连接 CG_565AF053FC6E3FF333FD7433";
    }

    item ProductInteractionTraceRecord_059 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "5300";
        attribute :>> targetProductId = "8100";
        attribute :>> flowName = "牵引电机实际转矩";
        attribute :>> flowKind = "energy";
        attribute :>> flowRef = "flow::CG_65E377DBF988541FA5778D1E";
        attribute :>> interfaceRefs = "IF_IF_MEA_012";
        attribute :>> connectorRefs = "CG_65E377DBF988541FA5778D1E";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::5300::8100::physical；SysML叶级连接 CG_65E377DBF988541FA5778D1E";
    }

    item ProductInteractionTraceRecord_060 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "8100";
        attribute :>> targetProductId = "5100";
        attribute :>> flowName = "牵引电机转矩请求";
        attribute :>> flowKind = "signal";
        attribute :>> flowRef = "flow::CG_7365C853DD9391D9914E0C8A";
        attribute :>> interfaceRefs = "IF_IF_CMD_012";
        attribute :>> connectorRefs = "CG_7365C853DD9391D9914E0C8A";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::8100::5100::control；SysML叶级连接 CG_7365C853DD9391D9914E0C8A";
    }

    item ProductInteractionTraceRecord_061 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "7100";
        attribute :>> targetProductId = "8100";
        attribute :>> flowName = "总风管压力";
        attribute :>> flowKind = "unknown";
        attribute :>> flowRef = "flow::CG_739E53DD845C8CD2646C8E39";
        attribute :>> interfaceRefs = "IF_IF_MEA_014";
        attribute :>> connectorRefs = "CG_739E53DD845C8CD2646C8E39";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::7100::8100::physical；SysML叶级连接 CG_739E53DD845C8CD2646C8E39";
    }

    item ProductInteractionTraceRecord_062 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "E100";
        attribute :>> targetProductId = "8100";
        attribute :>> flowName = "安全停车/制动请求";
        attribute :>> flowKind = "signal";
        attribute :>> flowRef = "flow::CG_86987C60BCB826208FEFEF31";
        attribute :>> interfaceRefs = "IF_IF_CMD_030";
        attribute :>> connectorRefs = "CG_86987C60BCB826208FEFEF31";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::E100::8100::control；SysML叶级连接 CG_86987C60BCB826208FEFEF31";
    }

    item ProductInteractionTraceRecord_063 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "3600";
        attribute :>> targetProductId = "8100";
        attribute :>> flowName = "牵引电机转速";
        attribute :>> flowKind = "energy";
        attribute :>> flowRef = "flow::CG_89DF67BFD358C3EEF4DB05F2";
        attribute :>> interfaceRefs = "IF_IF_MEA_004";
        attribute :>> connectorRefs = "CG_89DF67BFD358C3EEF4DB05F2";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::3600::8100::physical；SysML叶级连接 CG_89DF67BFD358C3EEF4DB05F2";
    }

    item ProductInteractionTraceRecord_064 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "4100";
        attribute :>> targetProductId = "4200";
        attribute :>> flowName = "受电弓状态";
        attribute :>> flowKind = "state";
        attribute :>> flowRef = "flow::CG_8F81398231970DBDB0A7F854";
        attribute :>> interfaceRefs = "IF_IF_STA_015";
        attribute :>> connectorRefs = "CG_8F81398231970DBDB0A7F854";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::4100::4200::state；SysML叶级连接 CG_8F81398231970DBDB0A7F854";
    }

    item ProductInteractionTraceRecord_065 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "X100";
        attribute :>> targetProductId = "8100";
        attribute :>> flowName = "超级电容SOC";
        attribute :>> flowKind = "signal";
        attribute :>> flowRef = "flow::CG_9465AAC3F0B0B115DC3EF9FD";
        attribute :>> interfaceRefs = "IF_IF_MEA_028";
        attribute :>> connectorRefs = "CG_9465AAC3F0B0B115DC3EF9FD";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::X100::8100::data；SysML叶级连接 CG_9465AAC3F0B0B115DC3EF9FD";
    }

    item ProductInteractionTraceRecord_066 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "4200";
        attribute :>> targetProductId = "8100";
        attribute :>> flowName = "高压断路器指令";
        attribute :>> flowKind = "signal";
        attribute :>> flowRef = "flow::CG_9ACDE46A41EE650430438B91";
        attribute :>> interfaceRefs = "IF_IF_CMD_016";
        attribute :>> connectorRefs = "CG_9ACDE46A41EE650430438B91";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::4200::8100::control；SysML叶级连接 CG_9ACDE46A41EE650430438B91";
    }

    item ProductInteractionTraceRecord_067 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "4100";
        attribute :>> targetProductId = "4200";
        attribute :>> flowName = "高压交流电能";
        attribute :>> flowKind = "energy";
        attribute :>> flowRef = "flow::CG_9EB19436ED0A54ECCF52C717";
        attribute :>> interfaceRefs = "IF_IF_PHY_001";
        attribute :>> connectorRefs = "CG_9EB19436ED0A54ECCF52C717";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::4100::4200::physical；SysML叶级连接 CG_9EB19436ED0A54ECCF52C717";
    }

    item ProductInteractionTraceRecord_068 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "7200";
        attribute :>> targetProductId = "8100";
        attribute :>> flowName = "动态制动力请求";
        attribute :>> flowKind = "signal";
        attribute :>> flowRef = "flow::CG_B251741505CB19FE47559F29";
        attribute :>> interfaceRefs = "IF_IF_CMD_006";
        attribute :>> connectorRefs = "CG_B251741505CB19FE47559F29";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::7200::8100::control；SysML叶级连接 CG_B251741505CB19FE47559F29";
    }

    item ProductInteractionTraceRecord_069 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "4200";
        attribute :>> targetProductId = "4500";
        attribute :>> flowName = "高压交流电能";
        attribute :>> flowKind = "energy";
        attribute :>> flowRef = "flow::CG_B483D5C4E4EC5F805E3B0F19";
        attribute :>> interfaceRefs = "IF_IF_PHY_001";
        attribute :>> connectorRefs = "CG_B483D5C4E4EC5F805E3B0F19";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::4200::4500::physical；SysML叶级连接 CG_B483D5C4E4EC5F805E3B0F19";
    }

    item ProductInteractionTraceRecord_070 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "X100";
        attribute :>> targetProductId = "8100";
        attribute :>> flowName = "储能系统可用状态";
        attribute :>> flowKind = "state";
        attribute :>> flowRef = "flow::CG_C03EBDD9B3CFF4E6611E41A1";
        attribute :>> interfaceRefs = "IF_IF_STA_030,IF_IF_STA_031";
        attribute :>> connectorRefs = "CG_C03EBDD9B3CFF4E6611E41A1,CG_C113ED5B462ACDD4ACE56E91";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::X100::8100::state；SysML叶级连接 CG_C03EBDD9B3CFF4E6611E41A1, CG_C113ED5B462ACDD4ACE56E91";
    }

    item ProductInteractionTraceRecord_071 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "X100";
        attribute :>> targetProductId = "8100";
        attribute :>> flowName = "储能系统故障状态";
        attribute :>> flowKind = "state";
        attribute :>> flowRef = "flow::CG_C113ED5B462ACDD4ACE56E91";
        attribute :>> interfaceRefs = "IF_IF_STA_030,IF_IF_STA_031";
        attribute :>> connectorRefs = "CG_C03EBDD9B3CFF4E6611E41A1,CG_C113ED5B462ACDD4ACE56E91";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::X100::8100::state；SysML叶级连接 CG_C03EBDD9B3CFF4E6611E41A1, CG_C113ED5B462ACDD4ACE56E91";
    }

    item ProductInteractionTraceRecord_072 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "7200";
        attribute :>> targetProductId = "3100";
        attribute :>> flowName = "摩擦制动机械作用";
        attribute :>> flowKind = "unknown";
        attribute :>> flowRef = "flow::CG_DA869E241F8A36DBAAC07E48";
        attribute :>> interfaceRefs = "IF_IF_PHY_007";
        attribute :>> connectorRefs = "CG_DA869E241F8A36DBAAC07E48";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::7200::3100::physical；SysML叶级连接 CG_DA869E241F8A36DBAAC07E48";
    }

    item ProductInteractionTraceRecord_073 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "7200";
        attribute :>> targetProductId = "8100";
        attribute :>> flowName = "制动缸压力";
        attribute :>> flowKind = "unknown";
        attribute :>> flowRef = "flow::CG_E9224B53F74EDFCCFDA0FC70";
        attribute :>> interfaceRefs = "IF_IF_MEA_016";
        attribute :>> connectorRefs = "CG_E9224B53F74EDFCCFDA0FC70";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::7200::8100::physical；SysML叶级连接 CG_E9224B53F74EDFCCFDA0FC70";
    }

    item ProductInteractionTraceRecord_074 : ProductInteractionTraceRecord {
        attribute :>> sourceProductId = "8100";
        attribute :>> targetProductId = "4200";
        attribute :>> flowName = "高压安全回路状态";
        attribute :>> flowKind = "state";
        attribute :>> flowRef = "flow::CG_F55B5E17D8CBFAC80E0961C2";
        attribute :>> interfaceRefs = "IF_IF_STA_024";
        attribute :>> connectorRefs = "CG_F55B5E17D8CBFAC80E0961C2";
        attribute :>> source = "TASK_SLICE_STAGE4";
        attribute :>> evidence = "真实L2聚合接口 aggregate::L2::8100::4200::state；SysML叶级连接 CG_F55B5E17D8CBFAC80E0961C2";
    }

    item def FunctionInteractionAssessment {
        attribute functionId : String;
        attribute interactionStatus : String;
        attribute unresolvedReason : String;
    }

    item FunctionInteractionAssessment_001 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_3000_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_002 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_3100_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_003 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_3110_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_004 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_3111_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_005 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_3112_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_006 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_3120_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_007 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_3121_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_008 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_3130_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_009 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_3131_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_010 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_3132_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_011 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_3133_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_012 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_3500_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_013 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_3510_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_014 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_3511_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_015 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_3512_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_016 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_3514_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_017 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_3600_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_018 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_3640_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_019 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_3641_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_020 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_3643_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_021 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_3644_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_022 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_3800_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_023 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_3810_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_024 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_3811_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_025 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_3811_02";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_026 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_3813_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_027 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_3814_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_028 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_4000_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_029 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_4100_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_030 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_4110_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_031 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_4111_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_032 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_411C_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_033 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_411C_02";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_034 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_4200_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_035 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_4210_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_036 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_4211_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_037 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_4212_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_038 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_4230_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_039 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_4235_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_040 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_4236_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_041 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_4238_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_042 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_4238_02";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_043 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_4238_03";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_044 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_4239_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_045 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_4239_02";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_046 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_4239_03";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_047 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_4240_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_048 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_4241_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_049 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_4241_02";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_050 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_4241_03";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_051 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_4400_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_052 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_4410_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_053 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_4411_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_054 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_4412_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_055 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_4413_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_056 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_4500_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_057 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_4510_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_058 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_4511_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_059 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_4513_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_060 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_4517_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_061 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_4518_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_062 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_4518_02";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_063 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_5000_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_064 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_5100_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_065 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_5110_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_066 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_5111_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_067 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_5111_02";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_068 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_5111_03";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_069 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_5111_04";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_070 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_5112_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_071 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_5112_02";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_072 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_5112_03";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_073 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_5112_04";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_074 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_5113_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_075 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_5120_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_076 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_5121_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_077 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_5122_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_078 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_5130_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_079 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_5131_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_080 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_5131_02";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_081 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_5132_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_082 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_5132_02";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_083 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_5133_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_084 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_5133_02";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_085 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_5133_03";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_086 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_5140_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_087 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_5142_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_088 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_5142_02";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_089 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_5145_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_090 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_5300_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_091 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_5310_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_092 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_5311_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_093 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_5311_02";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_094 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_7000_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_095 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_7100_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_096 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_7120_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_097 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_7124_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_098 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_7130_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_099 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_7131_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_100 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_7140_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_101 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_7142_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_102 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_7200_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_103 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_7210_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_104 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_7211_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_105 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_7211_02";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_106 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_7211_03";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_107 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_7211_04";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_108 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_7213_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_109 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_7220_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_110 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_7222_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_111 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_7223_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_112 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_7224_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_113 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_7225_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_114 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_7226_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_115 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_7227_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_116 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_7228_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_117 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_7229_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_118 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_722A_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_119 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_722B_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_120 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_722C_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_121 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_7250_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_122 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_7252_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_123 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_7254_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_124 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_7255_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_125 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_7280_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_126 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_7281_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_127 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_7284_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_128 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_7285_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_129 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_8000_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_130 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_8100_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_131 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_8120_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_132 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_8121_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_133 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_8121_02";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_134 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_8121_03";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_135 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_8122_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_136 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_8122_02";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_137 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_8122_03";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_138 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_8122_04";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_139 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_8122_05";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_140 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_8125_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_141 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_8125_02";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_142 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_8125_03";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_143 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_8125_04";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_144 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_8127_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_145 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_8127_02";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_146 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_8128_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_147 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_8128_02";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_148 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_8128_03";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_149 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_8150_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_150 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_8151_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_151 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_8151_02";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_152 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_8152_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_153 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_8152_02";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_154 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_8154_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_155 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_8154_02";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_156 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_8160_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_157 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_8166_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_158 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_8166_02";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_159 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_8166_03";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_160 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_8166_04";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_161 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_D000_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_162 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_D100_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_163 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_D110_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_164 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_D112_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_165 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_D113_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_166 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_D114_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_167 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_D120_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_168 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_D121_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_169 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_D130_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_170 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_D13B_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_171 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_E000_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_172 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_E100_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_173 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_X000_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_174 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_X100_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_175 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_X110_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_176 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_X111_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_177 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_X111_02";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_178 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_X112_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_179 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_X112_02";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_180 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_X112_03";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_181 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_X113_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_182 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_X120_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_183 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_X121_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_184 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_X121_02";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_185 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_X122_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_186 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_X123_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_187 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_X124_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_188 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_X130_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_189 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_X131_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_190 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_X132_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    item FunctionInteractionAssessment_191 : FunctionInteractionAssessment {
        attribute :>> functionId = "FN_F_X133_01";
        attribute :>> interactionStatus = "UNRESOLVED";
        attribute :>> unresolvedReason = "现有action def/allocation未将此Function引用到具体port、interface或connector；未按owner邻接关系推断参与。";
    }

    part satisfactionContext {

        action fn_FN_F_4111_01 : FunctionDefinitions::FN_F_4111_01;

        action fn_FN_F_4511_01 : FunctionDefinitions::FN_F_4511_01;

        action fn_FN_F_5112_01 : FunctionDefinitions::FN_F_5112_01;

        action fn_FN_F_5131_01 : FunctionDefinitions::FN_F_5131_01;

        action fn_FN_F_5132_01 : FunctionDefinitions::FN_F_5132_01;

        action fn_FN_F_5311_01 : FunctionDefinitions::FN_F_5311_01;

        action fn_FN_F_5311_02 : FunctionDefinitions::FN_F_5311_02;

        action fn_FN_F_7100_01 : FunctionDefinitions::FN_F_7100_01;

        action fn_FN_F_7131_01 : FunctionDefinitions::FN_F_7131_01;

        action fn_FN_F_7142_01 : FunctionDefinitions::FN_F_7142_01;

        action fn_FN_F_7211_01 : FunctionDefinitions::FN_F_7211_01;

        action fn_FN_F_7211_02 : FunctionDefinitions::FN_F_7211_02;

        action fn_FN_F_7211_03 : FunctionDefinitions::FN_F_7211_03;

        action fn_FN_F_7211_04 : FunctionDefinitions::FN_F_7211_04;

        action fn_FN_F_7224_01 : FunctionDefinitions::FN_F_7224_01;

        action fn_FN_F_7226_01 : FunctionDefinitions::FN_F_7226_01;

        action fn_FN_F_722A_01 : FunctionDefinitions::FN_F_722A_01;

        action fn_FN_F_722B_01 : FunctionDefinitions::FN_F_722B_01;

        action fn_FN_F_722C_01 : FunctionDefinitions::FN_F_722C_01;

        action fn_FN_F_7255_01 : FunctionDefinitions::FN_F_7255_01;

        action fn_FN_F_8122_03 : FunctionDefinitions::FN_F_8122_03;

        action fn_FN_F_8128_01 : FunctionDefinitions::FN_F_8128_01;

        action fn_FN_F_8128_03 : FunctionDefinitions::FN_F_8128_03;

        action fn_FN_F_8152_01 : FunctionDefinitions::FN_F_8152_01;

        action fn_FN_F_8152_02 : FunctionDefinitions::FN_F_8152_02;

        action fn_FN_F_D121_01 : FunctionDefinitions::FN_F_D121_01;

        action fn_FN_F_X100_01 : FunctionDefinitions::FN_F_X100_01;

        action fn_FN_F_X112_01 : FunctionDefinitions::FN_F_X112_01;

        action fn_FN_F_X112_02 : FunctionDefinitions::FN_F_X112_02;

        action fn_FN_F_X112_03 : FunctionDefinitions::FN_F_X112_03;

        action fn_FN_F_X113_01 : FunctionDefinitions::FN_F_X113_01;

        action fn_FN_F_X121_01 : FunctionDefinitions::FN_F_X121_01;

        action fn_FN_F_X121_02 : FunctionDefinitions::FN_F_X121_02;

        action fn_FN_F_X122_01 : FunctionDefinitions::FN_F_X122_01;

        action fn_FN_F_X123_01 : FunctionDefinitions::FN_F_X123_01;

        action fn_FN_F_X124_01 : FunctionDefinitions::FN_F_X124_01;

        satisfy requirement req_REQ_ENE_001 : RailRequirement by fn_FN_F_X100_01 {

            attribute :>> requirementId = "REQ-ENE-001";

            attribute :>> domain = "能量回收";

            attribute :>> requirementName = "电容式储能电源储存功能需求";

            attribute :>> requirementText = "电容式储能电源应具有能量储存功能，并满足规定的储存能量和储存电压范围。";

            attribute :>> standardNo = "GB/T 42005.1-2022";

            attribute :>> standardClause = "5.2.1";

            attribute :>> criteria = "储存能量为标称能量的100%～120%；储存电压范围宜采用500～900 V。";

            attribute :>> applicableConditions = "适用于采用双电层电容器或混合型电容器的储能式电车动力储能电源；本项目作为X100子系统参考。";

            attribute :>> requirementType = "功能/性能";

            attribute :>> verificationStatus = "PARTIALLY_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_PRJ_ENE_001 : RailRequirement by fn_FN_F_X100_01 {

            attribute :>> requirementId = "PRJ-ENE-001";

            attribute :>> domain = "能量回收";

            attribute :>> requirementName = "无电网再生接纳时车载储能吸收需求";

            attribute :>> requirementText = "在当前仿真设定的电网不接纳再生功率工况下，可利用的再生制动能量应优先进入车载储能系统，并受储能可用能力约束。";

            attribute :>> standardNo = "";

            attribute :>> standardClause = "";

            attribute :>> criteria = "当前场景 grid_regen_acceptance = 0 W；能量优先路由至X100，在功率/SOC/电流限制内吸收。";

            attribute :>> applicableConditions = "当前项目的储能优先仿真场景。";

            attribute :>> requirementType = "项目功能";

            attribute :>> verificationStatus = "VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_PRJ_ENE_004 : RailRequirement by fn_FN_F_X100_01 {

            attribute :>> requirementId = "PRJ-ENE-004";

            attribute :>> domain = "能量回收";

            attribute :>> requirementName = "再生充电SOC上限需求";

            attribute :>> requirementText = "当储能SOC达到项目设定的再生充电上限时，应限制或停止继续吸收再生能量。";

            attribute :>> standardNo = "";

            attribute :>> standardClause = "";

            attribute :>> criteria = "SOC_max_regen = 0.98。";

            attribute :>> applicableConditions = "当前X100等效模型。";

            attribute :>> requirementType = "项目约束";

            attribute :>> verificationStatus = "PARTIALLY_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_TRAC_001 : RailRequirement by fn_FN_F_5132_01 {

            attribute :>> requirementId = "REQ-TRAC-001";

            attribute :>> domain = "牵引";

            attribute :>> requirementName = "牵引力-速度特性需求";

            attribute :>> requirementText = "列车的牵引力-速度特性和制动力-速度特性应符合设计要求。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "6.9";

            attribute :>> criteria = "符合经批准的牵引力-速度、制动力-速度设计特性。";

            attribute :>> applicableConditions = "车辆设计工况；具体特性曲线由项目设计给定。";

            attribute :>> requirementType = "性能";

            attribute :>> verificationStatus = "PARTIALLY_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_TRAC_001 : RailRequirement by fn_FN_F_5311_01 {

            attribute :>> requirementId = "REQ-TRAC-001";

            attribute :>> domain = "牵引";

            attribute :>> requirementName = "牵引力-速度特性需求";

            attribute :>> requirementText = "列车的牵引力-速度特性和制动力-速度特性应符合设计要求。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "6.9";

            attribute :>> criteria = "符合经批准的牵引力-速度、制动力-速度设计特性。";

            attribute :>> applicableConditions = "车辆设计工况；具体特性曲线由项目设计给定。";

            attribute :>> requirementType = "性能";

            attribute :>> verificationStatus = "PARTIALLY_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_TRAC_001 : RailRequirement by fn_FN_F_5311_02 {

            attribute :>> requirementId = "REQ-TRAC-001";

            attribute :>> domain = "牵引";

            attribute :>> requirementName = "牵引力-速度特性需求";

            attribute :>> requirementText = "列车的牵引力-速度特性和制动力-速度特性应符合设计要求。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "6.9";

            attribute :>> criteria = "符合经批准的牵引力-速度、制动力-速度设计特性。";

            attribute :>> applicableConditions = "车辆设计工况；具体特性曲线由项目设计给定。";

            attribute :>> requirementType = "性能";

            attribute :>> verificationStatus = "PARTIALLY_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_TRAC_001 : RailRequirement by fn_FN_F_5112_01 {

            attribute :>> requirementId = "REQ-TRAC-001";

            attribute :>> domain = "牵引";

            attribute :>> requirementName = "牵引力-速度特性需求";

            attribute :>> requirementText = "列车的牵引力-速度特性和制动力-速度特性应符合设计要求。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "6.9";

            attribute :>> criteria = "符合经批准的牵引力-速度、制动力-速度设计特性。";

            attribute :>> applicableConditions = "车辆设计工况；具体特性曲线由项目设计给定。";

            attribute :>> requirementType = "性能";

            attribute :>> verificationStatus = "PARTIALLY_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_TRAC_002 : RailRequirement by fn_FN_F_5132_01 {

            attribute :>> requirementId = "REQ-TRAC-002";

            attribute :>> domain = "牵引";

            attribute :>> requirementName = "起动与加速性能需求";

            attribute :>> requirementText = "列车在规定载荷、轨道、车轮和供电条件下应满足对应速度等级的平均加速度要求。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "6.11";

            attribute :>> criteria = "80 km/h等级：0→40 km/h≥1.0 m/s²（动拖比1:1时≥0.83），0→80 km/h≥0.6 m/s²（动拖比1:1时≥0.5）；100 km/h等级：0→45 km/h≥1.0，0→100 km/h≥0.6；120 km/h等级：0→50 km/h≥1.0，0→120 km/h≥0.5。";

            attribute :>> applicableConditions = "定员；平直干燥轨道；车轮半磨耗；额定供电电压。";

            attribute :>> requirementType = "性能";

            attribute :>> verificationStatus = "PARTIALLY_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_TRAC_002 : RailRequirement by fn_FN_F_5311_01 {

            attribute :>> requirementId = "REQ-TRAC-002";

            attribute :>> domain = "牵引";

            attribute :>> requirementName = "起动与加速性能需求";

            attribute :>> requirementText = "列车在规定载荷、轨道、车轮和供电条件下应满足对应速度等级的平均加速度要求。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "6.11";

            attribute :>> criteria = "80 km/h等级：0→40 km/h≥1.0 m/s²（动拖比1:1时≥0.83），0→80 km/h≥0.6 m/s²（动拖比1:1时≥0.5）；100 km/h等级：0→45 km/h≥1.0，0→100 km/h≥0.6；120 km/h等级：0→50 km/h≥1.0，0→120 km/h≥0.5。";

            attribute :>> applicableConditions = "定员；平直干燥轨道；车轮半磨耗；额定供电电压。";

            attribute :>> requirementType = "性能";

            attribute :>> verificationStatus = "PARTIALLY_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_TRAC_002 : RailRequirement by fn_FN_F_5311_02 {

            attribute :>> requirementId = "REQ-TRAC-002";

            attribute :>> domain = "牵引";

            attribute :>> requirementName = "起动与加速性能需求";

            attribute :>> requirementText = "列车在规定载荷、轨道、车轮和供电条件下应满足对应速度等级的平均加速度要求。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "6.11";

            attribute :>> criteria = "80 km/h等级：0→40 km/h≥1.0 m/s²（动拖比1:1时≥0.83），0→80 km/h≥0.6 m/s²（动拖比1:1时≥0.5）；100 km/h等级：0→45 km/h≥1.0，0→100 km/h≥0.6；120 km/h等级：0→50 km/h≥1.0，0→120 km/h≥0.5。";

            attribute :>> applicableConditions = "定员；平直干燥轨道；车轮半磨耗；额定供电电压。";

            attribute :>> requirementType = "性能";

            attribute :>> verificationStatus = "PARTIALLY_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_TRAC_002 : RailRequirement by fn_FN_F_5112_01 {

            attribute :>> requirementId = "REQ-TRAC-002";

            attribute :>> domain = "牵引";

            attribute :>> requirementName = "起动与加速性能需求";

            attribute :>> requirementText = "列车在规定载荷、轨道、车轮和供电条件下应满足对应速度等级的平均加速度要求。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "6.11";

            attribute :>> criteria = "80 km/h等级：0→40 km/h≥1.0 m/s²（动拖比1:1时≥0.83），0→80 km/h≥0.6 m/s²（动拖比1:1时≥0.5）；100 km/h等级：0→45 km/h≥1.0，0→100 km/h≥0.6；120 km/h等级：0→50 km/h≥1.0，0→120 km/h≥0.5。";

            attribute :>> applicableConditions = "定员；平直干燥轨道；车轮半磨耗；额定供电电压。";

            attribute :>> requirementType = "性能";

            attribute :>> verificationStatus = "PARTIALLY_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_TRAC_003 : RailRequirement by fn_FN_F_7211_04 {

            attribute :>> requirementId = "REQ-TRAC-003";

            attribute :>> domain = "牵引";

            attribute :>> requirementName = "黏着利用与防空转/防滑行需求";

            attribute :>> requirementText = "牵引系统应充分利用轮轨黏着条件，按车辆载荷自动调整牵引力或电制动力，并具有防空转、防滑行和防冲动控制。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "11.7";

            attribute :>> criteria = "具备载荷自适应牵引/电制动力调节，以及防空转、防滑行、防冲动控制。";

            attribute :>> applicableConditions = "轮轨黏着条件；车辆载荷变化。";

            attribute :>> requirementType = "功能/安全";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_TRAC_003 : RailRequirement by fn_FN_F_722A_01 {

            attribute :>> requirementId = "REQ-TRAC-003";

            attribute :>> domain = "牵引";

            attribute :>> requirementName = "黏着利用与防空转/防滑行需求";

            attribute :>> requirementText = "牵引系统应充分利用轮轨黏着条件，按车辆载荷自动调整牵引力或电制动力，并具有防空转、防滑行和防冲动控制。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "11.7";

            attribute :>> criteria = "具备载荷自适应牵引/电制动力调节，以及防空转、防滑行、防冲动控制。";

            attribute :>> applicableConditions = "轮轨黏着条件；车辆载荷变化。";

            attribute :>> requirementType = "功能/安全";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_TRAC_003 : RailRequirement by fn_FN_F_5311_02 {

            attribute :>> requirementId = "REQ-TRAC-003";

            attribute :>> domain = "牵引";

            attribute :>> requirementName = "黏着利用与防空转/防滑行需求";

            attribute :>> requirementText = "牵引系统应充分利用轮轨黏着条件，按车辆载荷自动调整牵引力或电制动力，并具有防空转、防滑行和防冲动控制。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "11.7";

            attribute :>> criteria = "具备载荷自适应牵引/电制动力调节，以及防空转、防滑行、防冲动控制。";

            attribute :>> applicableConditions = "轮轨黏着条件；车辆载荷变化。";

            attribute :>> requirementType = "功能/安全";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_TRAC_004 : RailRequirement by fn_FN_F_4511_01 {

            attribute :>> requirementId = "REQ-TRAC-004";

            attribute :>> domain = "牵引";

            attribute :>> requirementName = "交流电传动架构需求";

            attribute :>> requirementText = "电力牵引应采用变频调压的交流电传动系统，并应符合GB/T 37863.1的规定。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "11.1";

            attribute :>> criteria = "采用变频调压交流电传动；牵引电传动系统应符合GB/T 37863.1。";

            attribute :>> applicableConditions = "适用于GB/T 7928-2025范围内的地铁车辆；本项目仅验证架构覆盖，不宣称完整标准符合性。";

            attribute :>> requirementType = "架构/约束";

            attribute :>> verificationStatus = "PARTIALLY_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_TRAC_004 : RailRequirement by fn_FN_F_5131_01 {

            attribute :>> requirementId = "REQ-TRAC-004";

            attribute :>> domain = "牵引";

            attribute :>> requirementName = "交流电传动架构需求";

            attribute :>> requirementText = "电力牵引应采用变频调压的交流电传动系统，并应符合GB/T 37863.1的规定。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "11.1";

            attribute :>> criteria = "采用变频调压交流电传动；牵引电传动系统应符合GB/T 37863.1。";

            attribute :>> applicableConditions = "适用于GB/T 7928-2025范围内的地铁车辆；本项目仅验证架构覆盖，不宣称完整标准符合性。";

            attribute :>> requirementType = "架构/约束";

            attribute :>> verificationStatus = "PARTIALLY_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_TRAC_004 : RailRequirement by fn_FN_F_5132_01 {

            attribute :>> requirementId = "REQ-TRAC-004";

            attribute :>> domain = "牵引";

            attribute :>> requirementName = "交流电传动架构需求";

            attribute :>> requirementText = "电力牵引应采用变频调压的交流电传动系统，并应符合GB/T 37863.1的规定。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "11.1";

            attribute :>> criteria = "采用变频调压交流电传动；牵引电传动系统应符合GB/T 37863.1。";

            attribute :>> applicableConditions = "适用于GB/T 7928-2025范围内的地铁车辆；本项目仅验证架构覆盖，不宣称完整标准符合性。";

            attribute :>> requirementType = "架构/约束";

            attribute :>> verificationStatus = "PARTIALLY_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_TRAC_004 : RailRequirement by fn_FN_F_5311_01 {

            attribute :>> requirementId = "REQ-TRAC-004";

            attribute :>> domain = "牵引";

            attribute :>> requirementName = "交流电传动架构需求";

            attribute :>> requirementText = "电力牵引应采用变频调压的交流电传动系统，并应符合GB/T 37863.1的规定。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "11.1";

            attribute :>> criteria = "采用变频调压交流电传动；牵引电传动系统应符合GB/T 37863.1。";

            attribute :>> applicableConditions = "适用于GB/T 7928-2025范围内的地铁车辆；本项目仅验证架构覆盖，不宣称完整标准符合性。";

            attribute :>> requirementType = "架构/约束";

            attribute :>> verificationStatus = "PARTIALLY_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_001 : RailRequirement by fn_FN_F_7211_01 {

            attribute :>> requirementId = "REQ-BRK-001";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "常用制动平均减速度需求";

            attribute :>> requirementText = "列车从最高运行速度实施常用制动至停车时，平均减速度不应低于1.0 m/s²。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "6.12 a)";

            attribute :>> criteria = "平均常用制动减速度 ≥ 1.0 m/s²。";

            attribute :>> applicableConditions = "超员；平直干燥轨道；车轮半磨耗；从最高运行速度制动至停车。";

            attribute :>> requirementType = "性能";

            attribute :>> verificationStatus = "PARTIALLY_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_001 : RailRequirement by fn_FN_F_7211_02 {

            attribute :>> requirementId = "REQ-BRK-001";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "常用制动平均减速度需求";

            attribute :>> requirementText = "列车从最高运行速度实施常用制动至停车时，平均减速度不应低于1.0 m/s²。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "6.12 a)";

            attribute :>> criteria = "平均常用制动减速度 ≥ 1.0 m/s²。";

            attribute :>> applicableConditions = "超员；平直干燥轨道；车轮半磨耗；从最高运行速度制动至停车。";

            attribute :>> requirementType = "性能";

            attribute :>> verificationStatus = "PARTIALLY_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_001 : RailRequirement by fn_FN_F_7211_03 {

            attribute :>> requirementId = "REQ-BRK-001";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "常用制动平均减速度需求";

            attribute :>> requirementText = "列车从最高运行速度实施常用制动至停车时，平均减速度不应低于1.0 m/s²。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "6.12 a)";

            attribute :>> criteria = "平均常用制动减速度 ≥ 1.0 m/s²。";

            attribute :>> applicableConditions = "超员；平直干燥轨道；车轮半磨耗；从最高运行速度制动至停车。";

            attribute :>> requirementType = "性能";

            attribute :>> verificationStatus = "PARTIALLY_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_001 : RailRequirement by fn_FN_F_7255_01 {

            attribute :>> requirementId = "REQ-BRK-001";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "常用制动平均减速度需求";

            attribute :>> requirementText = "列车从最高运行速度实施常用制动至停车时，平均减速度不应低于1.0 m/s²。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "6.12 a)";

            attribute :>> criteria = "平均常用制动减速度 ≥ 1.0 m/s²。";

            attribute :>> applicableConditions = "超员；平直干燥轨道；车轮半磨耗；从最高运行速度制动至停车。";

            attribute :>> requirementType = "性能";

            attribute :>> verificationStatus = "PARTIALLY_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_001 : RailRequirement by fn_FN_F_5311_01 {

            attribute :>> requirementId = "REQ-BRK-001";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "常用制动平均减速度需求";

            attribute :>> requirementText = "列车从最高运行速度实施常用制动至停车时，平均减速度不应低于1.0 m/s²。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "6.12 a)";

            attribute :>> criteria = "平均常用制动减速度 ≥ 1.0 m/s²。";

            attribute :>> applicableConditions = "超员；平直干燥轨道；车轮半磨耗；从最高运行速度制动至停车。";

            attribute :>> requirementType = "性能";

            attribute :>> verificationStatus = "PARTIALLY_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_002 : RailRequirement by fn_FN_F_7211_04 {

            attribute :>> requirementId = "REQ-BRK-002";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "紧急制动平均减速度需求";

            attribute :>> requirementText = "列车从最高运行速度实施紧急制动至停车时，平均减速度不应低于1.2 m/s²。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "6.12 b)";

            attribute :>> criteria = "平均紧急制动减速度 ≥ 1.2 m/s²。";

            attribute :>> applicableConditions = "超员；平直干燥轨道；车轮半磨耗；从最高运行速度制动至停车。";

            attribute :>> requirementType = "性能/安全";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_002 : RailRequirement by fn_FN_F_7226_01 {

            attribute :>> requirementId = "REQ-BRK-002";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "紧急制动平均减速度需求";

            attribute :>> requirementText = "列车从最高运行速度实施紧急制动至停车时，平均减速度不应低于1.2 m/s²。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "6.12 b)";

            attribute :>> criteria = "平均紧急制动减速度 ≥ 1.2 m/s²。";

            attribute :>> applicableConditions = "超员；平直干燥轨道；车轮半磨耗；从最高运行速度制动至停车。";

            attribute :>> requirementType = "性能/安全";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_002 : RailRequirement by fn_FN_F_7255_01 {

            attribute :>> requirementId = "REQ-BRK-002";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "紧急制动平均减速度需求";

            attribute :>> requirementText = "列车从最高运行速度实施紧急制动至停车时，平均减速度不应低于1.2 m/s²。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "6.12 b)";

            attribute :>> criteria = "平均紧急制动减速度 ≥ 1.2 m/s²。";

            attribute :>> applicableConditions = "超员；平直干燥轨道；车轮半磨耗；从最高运行速度制动至停车。";

            attribute :>> requirementType = "性能/安全";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_002 : RailRequirement by fn_FN_F_D121_01 {

            attribute :>> requirementId = "REQ-BRK-002";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "紧急制动平均减速度需求";

            attribute :>> requirementText = "列车从最高运行速度实施紧急制动至停车时，平均减速度不应低于1.2 m/s²。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "6.12 b)";

            attribute :>> criteria = "平均紧急制动减速度 ≥ 1.2 m/s²。";

            attribute :>> applicableConditions = "超员；平直干燥轨道；车轮半磨耗；从最高运行速度制动至停车。";

            attribute :>> requirementType = "性能/安全";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_003 : RailRequirement by fn_FN_F_7211_02 {

            attribute :>> requirementId = "REQ-BRK-003";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "纵向冲击率需求";

            attribute :>> requirementText = "除紧急制动外，列车在牵引或制动过程中纵向冲击率不应大于0.75 m/s³。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "6.13";

            attribute :>> criteria = "纵向冲击率 ≤ 0.75 m/s³。";

            attribute :>> applicableConditions = "牵引或非紧急制动过程。";

            attribute :>> requirementType = "舒适性/性能";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_003 : RailRequirement by fn_FN_F_7211_03 {

            attribute :>> requirementId = "REQ-BRK-003";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "纵向冲击率需求";

            attribute :>> requirementText = "除紧急制动外，列车在牵引或制动过程中纵向冲击率不应大于0.75 m/s³。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "6.13";

            attribute :>> criteria = "纵向冲击率 ≤ 0.75 m/s³。";

            attribute :>> applicableConditions = "牵引或非紧急制动过程。";

            attribute :>> requirementType = "舒适性/性能";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_003 : RailRequirement by fn_FN_F_7255_01 {

            attribute :>> requirementId = "REQ-BRK-003";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "纵向冲击率需求";

            attribute :>> requirementText = "除紧急制动外，列车在牵引或制动过程中纵向冲击率不应大于0.75 m/s³。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "6.13";

            attribute :>> criteria = "纵向冲击率 ≤ 0.75 m/s³。";

            attribute :>> applicableConditions = "牵引或非紧急制动过程。";

            attribute :>> requirementType = "舒适性/性能";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_004 : RailRequirement by fn_FN_F_7211_02 {

            attribute :>> requirementId = "REQ-BRK-004";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "电制动与空气制动双制动方式需求";

            attribute :>> requirementText = "列车应具备电制动和空气制动两种制动方式；牵引供电中断或电制动故障时，空气制动仍应使列车安全停车。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "10.1";

            attribute :>> criteria = "双制动方式；空气制动具备相对独立的安全停车能力。";

            attribute :>> applicableConditions = "牵引供电中断或电制动故障等意外工况。";

            attribute :>> requirementType = "功能/安全";

            attribute :>> verificationStatus = "PARTIALLY_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_004 : RailRequirement by fn_FN_F_7211_03 {

            attribute :>> requirementId = "REQ-BRK-004";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "电制动与空气制动双制动方式需求";

            attribute :>> requirementText = "列车应具备电制动和空气制动两种制动方式；牵引供电中断或电制动故障时，空气制动仍应使列车安全停车。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "10.1";

            attribute :>> criteria = "双制动方式；空气制动具备相对独立的安全停车能力。";

            attribute :>> applicableConditions = "牵引供电中断或电制动故障等意外工况。";

            attribute :>> requirementType = "功能/安全";

            attribute :>> verificationStatus = "PARTIALLY_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_004 : RailRequirement by fn_FN_F_5311_01 {

            attribute :>> requirementId = "REQ-BRK-004";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "电制动与空气制动双制动方式需求";

            attribute :>> requirementText = "列车应具备电制动和空气制动两种制动方式；牵引供电中断或电制动故障时，空气制动仍应使列车安全停车。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "10.1";

            attribute :>> criteria = "双制动方式；空气制动具备相对独立的安全停车能力。";

            attribute :>> applicableConditions = "牵引供电中断或电制动故障等意外工况。";

            attribute :>> requirementType = "功能/安全";

            attribute :>> verificationStatus = "PARTIALLY_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_004 : RailRequirement by fn_FN_F_7255_01 {

            attribute :>> requirementId = "REQ-BRK-004";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "电制动与空气制动双制动方式需求";

            attribute :>> requirementText = "列车应具备电制动和空气制动两种制动方式；牵引供电中断或电制动故障时，空气制动仍应使列车安全停车。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "10.1";

            attribute :>> criteria = "双制动方式；空气制动具备相对独立的安全停车能力。";

            attribute :>> applicableConditions = "牵引供电中断或电制动故障等意外工况。";

            attribute :>> requirementType = "功能/安全";

            attribute :>> verificationStatus = "PARTIALLY_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_005 : RailRequirement by fn_FN_F_7224_01 {

            attribute :>> requirementId = "REQ-BRK-005";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "载荷自适应制动力需求";

            attribute :>> requirementText = "制动系统应具有常用制动、紧急制动功能，并能根据载荷变化自动调整制动力大小。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "10.2";

            attribute :>> criteria = "制动力随车辆载荷变化自动调整。";

            attribute :>> applicableConditions = "车辆载荷变化。";

            attribute :>> requirementType = "功能";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_005 : RailRequirement by fn_FN_F_7211_01 {

            attribute :>> requirementId = "REQ-BRK-005";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "载荷自适应制动力需求";

            attribute :>> requirementText = "制动系统应具有常用制动、紧急制动功能，并能根据载荷变化自动调整制动力大小。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "10.2";

            attribute :>> criteria = "制动力随车辆载荷变化自动调整。";

            attribute :>> applicableConditions = "车辆载荷变化。";

            attribute :>> requirementType = "功能";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_006 : RailRequirement by fn_FN_F_7211_02 {

            attribute :>> requirementId = "REQ-BRK-006";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "常用制动电制动优先需求";

            attribute :>> requirementText = "常用制动应优先利用电制动，并具有冲动限制。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "10.3";

            attribute :>> criteria = "常用制动优先调用电制动；同时限制制动冲动。";

            attribute :>> applicableConditions = "常用制动。";

            attribute :>> requirementType = "功能/控制";

            attribute :>> verificationStatus = "PARTIALLY_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_006 : RailRequirement by fn_FN_F_5311_01 {

            attribute :>> requirementId = "REQ-BRK-006";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "常用制动电制动优先需求";

            attribute :>> requirementText = "常用制动应优先利用电制动，并具有冲动限制。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "10.3";

            attribute :>> criteria = "常用制动优先调用电制动；同时限制制动冲动。";

            attribute :>> applicableConditions = "常用制动。";

            attribute :>> requirementType = "功能/控制";

            attribute :>> verificationStatus = "PARTIALLY_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_006 : RailRequirement by fn_FN_F_7255_01 {

            attribute :>> requirementId = "REQ-BRK-006";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "常用制动电制动优先需求";

            attribute :>> requirementText = "常用制动应优先利用电制动，并具有冲动限制。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "10.3";

            attribute :>> criteria = "常用制动优先调用电制动；同时限制制动冲动。";

            attribute :>> applicableConditions = "常用制动。";

            attribute :>> requirementType = "功能/控制";

            attribute :>> verificationStatus = "PARTIALLY_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_007 : RailRequirement by fn_FN_F_7211_02 {

            attribute :>> requirementId = "REQ-BRK-007";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "再生制动优先需求";

            attribute :>> requirementText = "电制动时宜优先采用再生制动。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "10.3";

            attribute :>> criteria = "电制动时优先采用再生制动。";

            attribute :>> applicableConditions = "电制动可用、储能/电网具备可接纳条件时。";

            attribute :>> requirementType = "功能/能量";

            attribute :>> verificationStatus = "VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_007 : RailRequirement by fn_FN_F_5311_01 {

            attribute :>> requirementId = "REQ-BRK-007";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "再生制动优先需求";

            attribute :>> requirementText = "电制动时宜优先采用再生制动。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "10.3";

            attribute :>> criteria = "电制动时优先采用再生制动。";

            attribute :>> applicableConditions = "电制动可用、储能/电网具备可接纳条件时。";

            attribute :>> requirementType = "功能/能量";

            attribute :>> verificationStatus = "VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_007 : RailRequirement by fn_FN_F_X121_01 {

            attribute :>> requirementId = "REQ-BRK-007";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "再生制动优先需求";

            attribute :>> requirementText = "电制动时宜优先采用再生制动。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "10.3";

            attribute :>> criteria = "电制动时优先采用再生制动。";

            attribute :>> applicableConditions = "电制动可用、储能/电网具备可接纳条件时。";

            attribute :>> requirementType = "功能/能量";

            attribute :>> verificationStatus = "VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_007 : RailRequirement by fn_FN_F_X112_02 {

            attribute :>> requirementId = "REQ-BRK-007";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "再生制动优先需求";

            attribute :>> requirementText = "电制动时宜优先采用再生制动。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "10.3";

            attribute :>> criteria = "电制动时优先采用再生制动。";

            attribute :>> applicableConditions = "电制动可用、储能/电网具备可接纳条件时。";

            attribute :>> requirementType = "功能/能量";

            attribute :>> verificationStatus = "VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_008 : RailRequirement by fn_FN_F_7211_02 {

            attribute :>> requirementId = "REQ-BRK-008";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "电空制动平滑转换需求";

            attribute :>> requirementText = "电制动与空气制动应能实现平滑转换。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "10.3";

            attribute :>> criteria = "电制动与空气制动之间平滑过渡，不应出现不可接受的制动力突变。";

            attribute :>> applicableConditions = "混合制动切换、低速退出电制动等过程。";

            attribute :>> requirementType = "功能/控制";

            attribute :>> verificationStatus = "PARTIALLY_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_008 : RailRequirement by fn_FN_F_7211_03 {

            attribute :>> requirementId = "REQ-BRK-008";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "电空制动平滑转换需求";

            attribute :>> requirementText = "电制动与空气制动应能实现平滑转换。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "10.3";

            attribute :>> criteria = "电制动与空气制动之间平滑过渡，不应出现不可接受的制动力突变。";

            attribute :>> applicableConditions = "混合制动切换、低速退出电制动等过程。";

            attribute :>> requirementType = "功能/控制";

            attribute :>> verificationStatus = "PARTIALLY_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_008 : RailRequirement by fn_FN_F_7255_01 {

            attribute :>> requirementId = "REQ-BRK-008";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "电空制动平滑转换需求";

            attribute :>> requirementText = "电制动与空气制动应能实现平滑转换。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "10.3";

            attribute :>> criteria = "电制动与空气制动之间平滑过渡，不应出现不可接受的制动力突变。";

            attribute :>> applicableConditions = "混合制动切换、低速退出电制动等过程。";

            attribute :>> requirementType = "功能/控制";

            attribute :>> verificationStatus = "PARTIALLY_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_009 : RailRequirement by fn_FN_F_7211_02 {

            attribute :>> requirementId = "REQ-BRK-009";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "电制动力不足补偿需求";

            attribute :>> requirementText = "电制动力不足时，空气制动应按总制动力要求补充不足的制动力。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "10.3";

            attribute :>> criteria = "F_total需求由电制动与空气/机械制动共同满足；电制动不足量由空气/机械制动补足。";

            attribute :>> applicableConditions = "电制动能力受速度、功率、储能等限制时。";

            attribute :>> requirementType = "功能/控制";

            attribute :>> verificationStatus = "VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_009 : RailRequirement by fn_FN_F_7211_03 {

            attribute :>> requirementId = "REQ-BRK-009";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "电制动力不足补偿需求";

            attribute :>> requirementText = "电制动力不足时，空气制动应按总制动力要求补充不足的制动力。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "10.3";

            attribute :>> criteria = "F_total需求由电制动与空气/机械制动共同满足；电制动不足量由空气/机械制动补足。";

            attribute :>> applicableConditions = "电制动能力受速度、功率、储能等限制时。";

            attribute :>> requirementType = "功能/控制";

            attribute :>> verificationStatus = "VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_009 : RailRequirement by fn_FN_F_5311_01 {

            attribute :>> requirementId = "REQ-BRK-009";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "电制动力不足补偿需求";

            attribute :>> requirementText = "电制动力不足时，空气制动应按总制动力要求补充不足的制动力。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "10.3";

            attribute :>> criteria = "F_total需求由电制动与空气/机械制动共同满足；电制动不足量由空气/机械制动补足。";

            attribute :>> applicableConditions = "电制动能力受速度、功率、储能等限制时。";

            attribute :>> requirementType = "功能/控制";

            attribute :>> verificationStatus = "VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_009 : RailRequirement by fn_FN_F_7255_01 {

            attribute :>> requirementId = "REQ-BRK-009";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "电制动力不足补偿需求";

            attribute :>> requirementText = "电制动力不足时，空气制动应按总制动力要求补充不足的制动力。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "10.3";

            attribute :>> criteria = "F_total需求由电制动与空气/机械制动共同满足；电制动不足量由空气/机械制动补足。";

            attribute :>> applicableConditions = "电制动能力受速度、功率、储能等限制时。";

            attribute :>> requirementType = "功能/控制";

            attribute :>> verificationStatus = "VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_010 : RailRequirement by fn_FN_F_7211_04 {

            attribute :>> requirementId = "REQ-BRK-010";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "防滑功能需求";

            attribute :>> requirementText = "制动系统应具有防滑功能。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "10.5";

            attribute :>> criteria = "具备防滑控制能力。";

            attribute :>> applicableConditions = "低黏着或车轮滑移风险工况。";

            attribute :>> requirementType = "安全/功能";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_010 : RailRequirement by fn_FN_F_722A_01 {

            attribute :>> requirementId = "REQ-BRK-010";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "防滑功能需求";

            attribute :>> requirementText = "制动系统应具有防滑功能。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "10.5";

            attribute :>> criteria = "具备防滑控制能力。";

            attribute :>> applicableConditions = "低黏着或车轮滑移风险工况。";

            attribute :>> requirementType = "安全/功能";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_010 : RailRequirement by fn_FN_F_722B_01 {

            attribute :>> requirementId = "REQ-BRK-010";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "防滑功能需求";

            attribute :>> requirementText = "制动系统应具有防滑功能。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "10.5";

            attribute :>> criteria = "具备防滑控制能力。";

            attribute :>> applicableConditions = "低黏着或车轮滑移风险工况。";

            attribute :>> requirementType = "安全/功能";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_011 : RailRequirement by fn_FN_F_7211_04 {

            attribute :>> requirementId = "REQ-BRK-011";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "停放制动防溜逸需求";

            attribute :>> requirementText = "在线路最大坡度、最大载荷条件下施加停放制动后，列车不应溜逸，停放制动力应仅通过机械方式产生并传递。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "10.6";

            attribute :>> criteria = "最大坡度+最大载荷下不溜逸；停放制动力为机械方式。";

            attribute :>> applicableConditions = "线路最大坡度；车辆最大载荷。";

            attribute :>> requirementType = "安全/功能";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_011 : RailRequirement by fn_FN_F_7255_01 {

            attribute :>> requirementId = "REQ-BRK-011";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "停放制动防溜逸需求";

            attribute :>> requirementText = "在线路最大坡度、最大载荷条件下施加停放制动后，列车不应溜逸，停放制动力应仅通过机械方式产生并传递。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "10.6";

            attribute :>> criteria = "最大坡度+最大载荷下不溜逸；停放制动力为机械方式。";

            attribute :>> applicableConditions = "线路最大坡度；车辆最大载荷。";

            attribute :>> requirementType = "安全/功能";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_012 : RailRequirement by fn_FN_F_7142_01 {

            attribute :>> requirementId = "REQ-BRK-012";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "空气系统气密性需求";

            attribute :>> requirementText = "空气系统应满足规定的气密性要求。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "10.9";

            attribute :>> criteria = "关闭气路5 min后总风压力下降≤20 kPa；制动缸及制动储风缸3 min压力下降≤10 kPa。";

            attribute :>> applicableConditions = "按GB/T 14894规定的气密性试验方法。";

            attribute :>> requirementType = "性能/安全";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_012 : RailRequirement by fn_FN_F_7131_01 {

            attribute :>> requirementId = "REQ-BRK-012";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "空气系统气密性需求";

            attribute :>> requirementText = "空气系统应满足规定的气密性要求。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "10.9";

            attribute :>> criteria = "关闭气路5 min后总风压力下降≤20 kPa；制动缸及制动储风缸3 min压力下降≤10 kPa。";

            attribute :>> applicableConditions = "按GB/T 14894规定的气密性试验方法。";

            attribute :>> requirementType = "性能/安全";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_012 : RailRequirement by fn_FN_F_7100_01 {

            attribute :>> requirementId = "REQ-BRK-012";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "空气系统气密性需求";

            attribute :>> requirementText = "空气系统应满足规定的气密性要求。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "10.9";

            attribute :>> criteria = "关闭气路5 min后总风压力下降≤20 kPa；制动缸及制动储风缸3 min压力下降≤10 kPa。";

            attribute :>> applicableConditions = "按GB/T 14894规定的气密性试验方法。";

            attribute :>> requirementType = "性能/安全";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_013 : RailRequirement by fn_FN_F_722B_01 {

            attribute :>> requirementId = "REQ-BRK-013";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "制动缸压力控制精度需求";

            attribute :>> requirementText = "基础制动装置的制动缸压力实际值与设计值应满足允许误差要求。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "10.10";

            attribute :>> criteria = "制动缸压力实际值与设计值允许误差 ±20 kPa。";

            attribute :>> applicableConditions = "基础制动装置压力控制。";

            attribute :>> requirementType = "性能";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_013 : RailRequirement by fn_FN_F_722C_01 {

            attribute :>> requirementId = "REQ-BRK-013";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "制动缸压力控制精度需求";

            attribute :>> requirementText = "基础制动装置的制动缸压力实际值与设计值应满足允许误差要求。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "10.10";

            attribute :>> criteria = "制动缸压力实际值与设计值允许误差 ±20 kPa。";

            attribute :>> applicableConditions = "基础制动装置压力控制。";

            attribute :>> requirementType = "性能";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_013 : RailRequirement by fn_FN_F_7255_01 {

            attribute :>> requirementId = "REQ-BRK-013";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "制动缸压力控制精度需求";

            attribute :>> requirementText = "基础制动装置的制动缸压力实际值与设计值应满足允许误差要求。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "10.10";

            attribute :>> criteria = "制动缸压力实际值与设计值允许误差 ±20 kPa。";

            attribute :>> applicableConditions = "基础制动装置压力控制。";

            attribute :>> requirementType = "性能";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_014 : RailRequirement by fn_FN_F_8152_01 {

            attribute :>> requirementId = "REQ-BRK-014";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "制动辅助诊断与记录需求";

            attribute :>> requirementText = "制动系统应具有轮径校正、负载检测、故障诊断和记录功能。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "10.13";

            attribute :>> criteria = "具备轮径校正、负载检测、故障诊断、故障记录。";

            attribute :>> applicableConditions = "制动系统运行与维护。";

            attribute :>> requirementType = "功能/诊断";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_014 : RailRequirement by fn_FN_F_8152_02 {

            attribute :>> requirementId = "REQ-BRK-014";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "制动辅助诊断与记录需求";

            attribute :>> requirementText = "制动系统应具有轮径校正、负载检测、故障诊断和记录功能。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "10.13";

            attribute :>> criteria = "具备轮径校正、负载检测、故障诊断、故障记录。";

            attribute :>> applicableConditions = "制动系统运行与维护。";

            attribute :>> requirementType = "功能/诊断";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_014 : RailRequirement by fn_FN_F_8128_01 {

            attribute :>> requirementId = "REQ-BRK-014";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "制动辅助诊断与记录需求";

            attribute :>> requirementText = "制动系统应具有轮径校正、负载检测、故障诊断和记录功能。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "10.13";

            attribute :>> criteria = "具备轮径校正、负载检测、故障诊断、故障记录。";

            attribute :>> applicableConditions = "制动系统运行与维护。";

            attribute :>> requirementType = "功能/诊断";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_014 : RailRequirement by fn_FN_F_722B_01 {

            attribute :>> requirementId = "REQ-BRK-014";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "制动辅助诊断与记录需求";

            attribute :>> requirementText = "制动系统应具有轮径校正、负载检测、故障诊断和记录功能。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "10.13";

            attribute :>> criteria = "具备轮径校正、负载检测、故障诊断、故障记录。";

            attribute :>> applicableConditions = "制动系统运行与维护。";

            attribute :>> requirementType = "功能/诊断";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_014 : RailRequirement by fn_FN_F_722C_01 {

            attribute :>> requirementId = "REQ-BRK-014";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "制动辅助诊断与记录需求";

            attribute :>> requirementText = "制动系统应具有轮径校正、负载检测、故障诊断和记录功能。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "10.13";

            attribute :>> criteria = "具备轮径校正、负载检测、故障诊断、故障记录。";

            attribute :>> applicableConditions = "制动系统运行与维护。";

            attribute :>> requirementType = "功能/诊断";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_015 : RailRequirement by fn_FN_F_7211_04 {

            attribute :>> requirementId = "REQ-BRK-015";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "电制动完全失效降级需求";

            attribute :>> requirementText = "所有电制动停止工作时，空气制动系统及空气驱动部件应维持规定的安全运行和制动能力。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "10.14";

            attribute :>> criteria = "超员工况下可在基础制动热容量允许速度下运行一个往返；制动系统保持设计的常用制动减速度及紧急制动减速度。";

            attribute :>> applicableConditions = "所有电制动停止工作；超员工况。";

            attribute :>> requirementType = "安全/故障";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_015 : RailRequirement by fn_FN_F_7226_01 {

            attribute :>> requirementId = "REQ-BRK-015";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "电制动完全失效降级需求";

            attribute :>> requirementText = "所有电制动停止工作时，空气制动系统及空气驱动部件应维持规定的安全运行和制动能力。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "10.14";

            attribute :>> criteria = "超员工况下可在基础制动热容量允许速度下运行一个往返；制动系统保持设计的常用制动减速度及紧急制动减速度。";

            attribute :>> applicableConditions = "所有电制动停止工作；超员工况。";

            attribute :>> requirementType = "安全/故障";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_015 : RailRequirement by fn_FN_F_7255_01 {

            attribute :>> requirementId = "REQ-BRK-015";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "电制动完全失效降级需求";

            attribute :>> requirementText = "所有电制动停止工作时，空气制动系统及空气驱动部件应维持规定的安全运行和制动能力。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "10.14";

            attribute :>> criteria = "超员工况下可在基础制动热容量允许速度下运行一个往返；制动系统保持设计的常用制动减速度及紧急制动减速度。";

            attribute :>> applicableConditions = "所有电制动停止工作；超员工况。";

            attribute :>> requirementType = "安全/故障";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_BRK_015 : RailRequirement by fn_FN_F_8152_01 {

            attribute :>> requirementId = "REQ-BRK-015";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "电制动完全失效降级需求";

            attribute :>> requirementText = "所有电制动停止工作时，空气制动系统及空气驱动部件应维持规定的安全运行和制动能力。";

            attribute :>> standardNo = "GB/T 7928-2025";

            attribute :>> standardClause = "10.14";

            attribute :>> criteria = "超员工况下可在基础制动热容量允许速度下运行一个往返；制动系统保持设计的常用制动减速度及紧急制动减速度。";

            attribute :>> applicableConditions = "所有电制动停止工作；超员工况。";

            attribute :>> requirementType = "安全/故障";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_ENE_002 : RailRequirement by fn_FN_F_X113_01 {

            attribute :>> requirementId = "REQ-ENE-002";

            attribute :>> domain = "能量回收";

            attribute :>> requirementName = "储能故障检测、记录与输出需求";

            attribute :>> requirementText = "储能电源应具有故障检测功能，故障应能实时传送给车辆，并应具有故障记录储存和读取功能。";

            attribute :>> standardNo = "GB/T 42005.1-2022";

            attribute :>> standardClause = "5.2.2";

            attribute :>> criteria = "故障检测；实时上传车辆；故障记录可储存并由上位机读取。";

            attribute :>> applicableConditions = "X100储能子系统。";

            attribute :>> requirementType = "功能/诊断";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_ENE_002 : RailRequirement by fn_FN_F_X112_03 {

            attribute :>> requirementId = "REQ-ENE-002";

            attribute :>> domain = "能量回收";

            attribute :>> requirementName = "储能故障检测、记录与输出需求";

            attribute :>> requirementText = "储能电源应具有故障检测功能，故障应能实时传送给车辆，并应具有故障记录储存和读取功能。";

            attribute :>> standardNo = "GB/T 42005.1-2022";

            attribute :>> standardClause = "5.2.2";

            attribute :>> criteria = "故障检测；实时上传车辆；故障记录可储存并由上位机读取。";

            attribute :>> applicableConditions = "X100储能子系统。";

            attribute :>> requirementType = "功能/诊断";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_ENE_002 : RailRequirement by fn_FN_F_8122_03 {

            attribute :>> requirementId = "REQ-ENE-002";

            attribute :>> domain = "能量回收";

            attribute :>> requirementName = "储能故障检测、记录与输出需求";

            attribute :>> requirementText = "储能电源应具有故障检测功能，故障应能实时传送给车辆，并应具有故障记录储存和读取功能。";

            attribute :>> standardNo = "GB/T 42005.1-2022";

            attribute :>> standardClause = "5.2.2";

            attribute :>> criteria = "故障检测；实时上传车辆；故障记录可储存并由上位机读取。";

            attribute :>> applicableConditions = "X100储能子系统。";

            attribute :>> requirementType = "功能/诊断";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_ENE_003 : RailRequirement by fn_FN_F_X121_02 {

            attribute :>> requirementId = "REQ-ENE-003";

            attribute :>> domain = "能量回收";

            attribute :>> requirementName = "储能通信需求";

            attribute :>> requirementText = "储能电源应具备内部和外部通信能力，状态参数及故障信息应能够传递至电源管理系统和车辆。";

            attribute :>> standardNo = "GB/T 42005.1-2022";

            attribute :>> standardClause = "5.2.3";

            attribute :>> criteria = "模组电压、温度等信息可内部通信；储能状态参数及故障信息可通过外部通信网络发送给车辆。";

            attribute :>> applicableConditions = "X100储能子系统。";

            attribute :>> requirementType = "接口/功能";

            attribute :>> verificationStatus = "PARTIALLY_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_ENE_003 : RailRequirement by fn_FN_F_X112_03 {

            attribute :>> requirementId = "REQ-ENE-003";

            attribute :>> domain = "能量回收";

            attribute :>> requirementName = "储能通信需求";

            attribute :>> requirementText = "储能电源应具备内部和外部通信能力，状态参数及故障信息应能够传递至电源管理系统和车辆。";

            attribute :>> standardNo = "GB/T 42005.1-2022";

            attribute :>> standardClause = "5.2.3";

            attribute :>> criteria = "模组电压、温度等信息可内部通信；储能状态参数及故障信息可通过外部通信网络发送给车辆。";

            attribute :>> applicableConditions = "X100储能子系统。";

            attribute :>> requirementType = "接口/功能";

            attribute :>> verificationStatus = "PARTIALLY_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_ENE_003 : RailRequirement by fn_FN_F_8122_03 {

            attribute :>> requirementId = "REQ-ENE-003";

            attribute :>> domain = "能量回收";

            attribute :>> requirementName = "储能通信需求";

            attribute :>> requirementText = "储能电源应具备内部和外部通信能力，状态参数及故障信息应能够传递至电源管理系统和车辆。";

            attribute :>> standardNo = "GB/T 42005.1-2022";

            attribute :>> standardClause = "5.2.3";

            attribute :>> criteria = "模组电压、温度等信息可内部通信；储能状态参数及故障信息可通过外部通信网络发送给车辆。";

            attribute :>> applicableConditions = "X100储能子系统。";

            attribute :>> requirementType = "接口/功能";

            attribute :>> verificationStatus = "PARTIALLY_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_ENE_003 : RailRequirement by fn_FN_F_8128_03 {

            attribute :>> requirementId = "REQ-ENE-003";

            attribute :>> domain = "能量回收";

            attribute :>> requirementName = "储能通信需求";

            attribute :>> requirementText = "储能电源应具备内部和外部通信能力，状态参数及故障信息应能够传递至电源管理系统和车辆。";

            attribute :>> standardNo = "GB/T 42005.1-2022";

            attribute :>> standardClause = "5.2.3";

            attribute :>> criteria = "模组电压、温度等信息可内部通信；储能状态参数及故障信息可通过外部通信网络发送给车辆。";

            attribute :>> applicableConditions = "X100储能子系统。";

            attribute :>> requirementType = "接口/功能";

            attribute :>> verificationStatus = "PARTIALLY_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_ENE_004 : RailRequirement by fn_FN_F_X122_01 {

            attribute :>> requirementId = "REQ-ENE-004";

            attribute :>> domain = "能量回收";

            attribute :>> requirementName = "储能电压均衡需求";

            attribute :>> requirementText = "储能电源应具有单体及模组间电压均衡功能，并满足规定的电压一致性要求。";

            attribute :>> standardNo = "GB/T 42005.1-2022";

            attribute :>> standardClause = "5.2.4";

            attribute :>> criteria = "额定电压时：双电层电容器单体电压与平均电压之差绝对值≤0.15 V；混合型电容器≤0.1 V。";

            attribute :>> applicableConditions = "额定电压；按储能单元类型选择判据。";

            attribute :>> requirementType = "功能/性能";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_ENE_004 : RailRequirement by fn_FN_F_X112_01 {

            attribute :>> requirementId = "REQ-ENE-004";

            attribute :>> domain = "能量回收";

            attribute :>> requirementName = "储能电压均衡需求";

            attribute :>> requirementText = "储能电源应具有单体及模组间电压均衡功能，并满足规定的电压一致性要求。";

            attribute :>> standardNo = "GB/T 42005.1-2022";

            attribute :>> standardClause = "5.2.4";

            attribute :>> criteria = "额定电压时：双电层电容器单体电压与平均电压之差绝对值≤0.15 V；混合型电容器≤0.1 V。";

            attribute :>> applicableConditions = "额定电压；按储能单元类型选择判据。";

            attribute :>> requirementType = "功能/性能";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_ENE_005 : RailRequirement by fn_FN_F_X121_01 {

            attribute :>> requirementId = "REQ-ENE-005";

            attribute :>> domain = "能量回收";

            attribute :>> requirementName = "储能能量效率需求";

            attribute :>> requirementText = "电容式储能电源的充放电能量效率应达到规定要求。";

            attribute :>> standardNo = "GB/T 42005.1-2022";

            attribute :>> standardClause = "5.3.4";

            attribute :>> criteria = "双电层电容器能量效率≥93%；混合型电容器能量效率≥90%。";

            attribute :>> applicableConditions = "按标准规定的充放电试验条件与储能单元类型。";

            attribute :>> requirementType = "性能";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_ENE_005 : RailRequirement by fn_FN_F_X112_01 {

            attribute :>> requirementId = "REQ-ENE-005";

            attribute :>> domain = "能量回收";

            attribute :>> requirementName = "储能能量效率需求";

            attribute :>> requirementText = "电容式储能电源的充放电能量效率应达到规定要求。";

            attribute :>> standardNo = "GB/T 42005.1-2022";

            attribute :>> standardClause = "5.3.4";

            attribute :>> criteria = "双电层电容器能量效率≥93%；混合型电容器能量效率≥90%。";

            attribute :>> applicableConditions = "按标准规定的充放电试验条件与储能单元类型。";

            attribute :>> requirementType = "性能";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_ENE_006 : RailRequirement by fn_FN_F_X124_01 {

            attribute :>> requirementId = "REQ-ENE-006";

            attribute :>> domain = "能量回收";

            attribute :>> requirementName = "储能温度一致性需求";

            attribute :>> requirementText = "储能电源工作过程中最高工作温度及单体温差应满足规定要求。";

            attribute :>> standardNo = "GB/T 42005.1-2022";

            attribute :>> standardClause = "5.3.8";

            attribute :>> criteria = "最高工作温度≤55 ℃；同一时刻最高单体温度与最低单体温度差≤15 ℃。";

            attribute :>> applicableConditions = "储能电源工作过程。";

            attribute :>> requirementType = "性能/安全";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_ENE_007 : RailRequirement by fn_FN_F_X124_01 {

            attribute :>> requirementId = "REQ-ENE-007";

            attribute :>> domain = "能量回收";

            attribute :>> requirementName = "储能过温保护需求";

            attribute :>> requirementText = "储能电源应具有过温保护功能，过温时不应爆炸、起火。";

            attribute :>> standardNo = "GB/T 42005.1-2022";

            attribute :>> standardClause = "5.4.2";

            attribute :>> criteria = "具备过温保护；过温时不爆炸、不起火。";

            attribute :>> applicableConditions = "储能电源过温异常工况。";

            attribute :>> requirementType = "安全";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_ENE_007 : RailRequirement by fn_FN_F_X112_02 {

            attribute :>> requirementId = "REQ-ENE-007";

            attribute :>> domain = "能量回收";

            attribute :>> requirementName = "储能过温保护需求";

            attribute :>> requirementText = "储能电源应具有过温保护功能，过温时不应爆炸、起火。";

            attribute :>> standardNo = "GB/T 42005.1-2022";

            attribute :>> standardClause = "5.4.2";

            attribute :>> criteria = "具备过温保护；过温时不爆炸、不起火。";

            attribute :>> applicableConditions = "储能电源过温异常工况。";

            attribute :>> requirementType = "安全";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_ENE_008 : RailRequirement by fn_FN_F_X123_01 {

            attribute :>> requirementId = "REQ-ENE-008";

            attribute :>> domain = "能量回收";

            attribute :>> requirementName = "储能过流保护需求";

            attribute :>> requirementText = "储能电源正负极两端应具有过流保护功能，过流时不应爆炸、起火。";

            attribute :>> standardNo = "GB/T 42005.1-2022";

            attribute :>> standardClause = "5.4.3";

            attribute :>> criteria = "具备过流保护；过流时不爆炸、不起火。";

            attribute :>> applicableConditions = "储能电源过流异常工况。";

            attribute :>> requirementType = "安全";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_ENE_008 : RailRequirement by fn_FN_F_X112_02 {

            attribute :>> requirementId = "REQ-ENE-008";

            attribute :>> domain = "能量回收";

            attribute :>> requirementName = "储能过流保护需求";

            attribute :>> requirementText = "储能电源正负极两端应具有过流保护功能，过流时不应爆炸、起火。";

            attribute :>> standardNo = "GB/T 42005.1-2022";

            attribute :>> standardClause = "5.4.3";

            attribute :>> criteria = "具备过流保护；过流时不爆炸、不起火。";

            attribute :>> applicableConditions = "储能电源过流异常工况。";

            attribute :>> requirementType = "安全";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_ENE_009 : RailRequirement by fn_FN_F_X112_02 {

            attribute :>> requirementId = "REQ-ENE-009";

            attribute :>> domain = "能量回收";

            attribute :>> requirementName = "储能短路保护需求";

            attribute :>> requirementText = "储能电源应具有短路保护功能，短路时不应爆炸、起火。";

            attribute :>> standardNo = "GB/T 42005.1-2022";

            attribute :>> standardClause = "5.4.4";

            attribute :>> criteria = "具备短路保护；短路时不爆炸、不起火。";

            attribute :>> applicableConditions = "储能电源短路异常工况。";

            attribute :>> requirementType = "安全";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_REQ_ENE_009 : RailRequirement by fn_FN_F_X113_01 {

            attribute :>> requirementId = "REQ-ENE-009";

            attribute :>> domain = "能量回收";

            attribute :>> requirementName = "储能短路保护需求";

            attribute :>> requirementText = "储能电源应具有短路保护功能，短路时不应爆炸、起火。";

            attribute :>> standardNo = "GB/T 42005.1-2022";

            attribute :>> standardClause = "5.4.4";

            attribute :>> criteria = "具备短路保护；短路时不爆炸、不起火。";

            attribute :>> applicableConditions = "储能电源短路异常工况。";

            attribute :>> requirementType = "安全";

            attribute :>> verificationStatus = "NOT_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_PRJ_BRK_001 : RailRequirement by fn_FN_F_7211_01 {

            attribute :>> requirementId = "PRJ-BRK-001";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "项目服务制动目标需求";

            attribute :>> requirementText = "本项目服务制动目标减速度设为1.2 m/s²，用于高于GB/T 7928-2025常用制动基线的设计验证与需求变更示例。";

            attribute :>> standardNo = "";

            attribute :>> standardClause = "";

            attribute :>> criteria = "项目目标 a_service = 1.2 m/s²；标准基线为常用制动平均减速度≥1.0 m/s²。";

            attribute :>> applicableConditions = "当前80 t等效动力单元；项目基准工况。";

            attribute :>> requirementType = "项目性能";

            attribute :>> verificationStatus = "VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_PRJ_BRK_001 : RailRequirement by fn_FN_F_7211_02 {

            attribute :>> requirementId = "PRJ-BRK-001";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "项目服务制动目标需求";

            attribute :>> requirementText = "本项目服务制动目标减速度设为1.2 m/s²，用于高于GB/T 7928-2025常用制动基线的设计验证与需求变更示例。";

            attribute :>> standardNo = "";

            attribute :>> standardClause = "";

            attribute :>> criteria = "项目目标 a_service = 1.2 m/s²；标准基线为常用制动平均减速度≥1.0 m/s²。";

            attribute :>> applicableConditions = "当前80 t等效动力单元；项目基准工况。";

            attribute :>> requirementType = "项目性能";

            attribute :>> verificationStatus = "VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_PRJ_BRK_001 : RailRequirement by fn_FN_F_7211_03 {

            attribute :>> requirementId = "PRJ-BRK-001";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "项目服务制动目标需求";

            attribute :>> requirementText = "本项目服务制动目标减速度设为1.2 m/s²，用于高于GB/T 7928-2025常用制动基线的设计验证与需求变更示例。";

            attribute :>> standardNo = "";

            attribute :>> standardClause = "";

            attribute :>> criteria = "项目目标 a_service = 1.2 m/s²；标准基线为常用制动平均减速度≥1.0 m/s²。";

            attribute :>> applicableConditions = "当前80 t等效动力单元；项目基准工况。";

            attribute :>> requirementType = "项目性能";

            attribute :>> verificationStatus = "VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_PRJ_BRK_001 : RailRequirement by fn_FN_F_7255_01 {

            attribute :>> requirementId = "PRJ-BRK-001";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "项目服务制动目标需求";

            attribute :>> requirementText = "本项目服务制动目标减速度设为1.2 m/s²，用于高于GB/T 7928-2025常用制动基线的设计验证与需求变更示例。";

            attribute :>> standardNo = "";

            attribute :>> standardClause = "";

            attribute :>> criteria = "项目目标 a_service = 1.2 m/s²；标准基线为常用制动平均减速度≥1.0 m/s²。";

            attribute :>> applicableConditions = "当前80 t等效动力单元；项目基准工况。";

            attribute :>> requirementType = "项目性能";

            attribute :>> verificationStatus = "VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_PRJ_BRK_001 : RailRequirement by fn_FN_F_5311_01 {

            attribute :>> requirementId = "PRJ-BRK-001";

            attribute :>> domain = "制动";

            attribute :>> requirementName = "项目服务制动目标需求";

            attribute :>> requirementText = "本项目服务制动目标减速度设为1.2 m/s²，用于高于GB/T 7928-2025常用制动基线的设计验证与需求变更示例。";

            attribute :>> standardNo = "";

            attribute :>> standardClause = "";

            attribute :>> criteria = "项目目标 a_service = 1.2 m/s²；标准基线为常用制动平均减速度≥1.0 m/s²。";

            attribute :>> applicableConditions = "当前80 t等效动力单元；项目基准工况。";

            attribute :>> requirementType = "项目性能";

            attribute :>> verificationStatus = "VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_PRJ_ENE_002 : RailRequirement by fn_FN_F_X112_02 {

            attribute :>> requirementId = "PRJ-ENE-002";

            attribute :>> domain = "能量回收";

            attribute :>> requirementName = "储能最大充电功率约束";

            attribute :>> requirementText = "车载储能系统吸收再生功率时，充电功率不得超过项目设定的最大允许充电功率。";

            attribute :>> standardNo = "";

            attribute :>> standardClause = "";

            attribute :>> criteria = "P_charge,max = 600 kW。";

            attribute :>> applicableConditions = "当前X100等效模型。";

            attribute :>> requirementType = "项目约束";

            attribute :>> verificationStatus = "VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_PRJ_ENE_002 : RailRequirement by fn_FN_F_X112_01 {

            attribute :>> requirementId = "PRJ-ENE-002";

            attribute :>> domain = "能量回收";

            attribute :>> requirementName = "储能最大充电功率约束";

            attribute :>> requirementText = "车载储能系统吸收再生功率时，充电功率不得超过项目设定的最大允许充电功率。";

            attribute :>> standardNo = "";

            attribute :>> standardClause = "";

            attribute :>> criteria = "P_charge,max = 600 kW。";

            attribute :>> applicableConditions = "当前X100等效模型。";

            attribute :>> requirementType = "项目约束";

            attribute :>> verificationStatus = "VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_PRJ_ENE_002 : RailRequirement by fn_FN_F_X121_01 {

            attribute :>> requirementId = "PRJ-ENE-002";

            attribute :>> domain = "能量回收";

            attribute :>> requirementName = "储能最大充电功率约束";

            attribute :>> requirementText = "车载储能系统吸收再生功率时，充电功率不得超过项目设定的最大允许充电功率。";

            attribute :>> standardNo = "";

            attribute :>> standardClause = "";

            attribute :>> criteria = "P_charge,max = 600 kW。";

            attribute :>> applicableConditions = "当前X100等效模型。";

            attribute :>> requirementType = "项目约束";

            attribute :>> verificationStatus = "VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_PRJ_ENE_003 : RailRequirement by fn_FN_F_X123_01 {

            attribute :>> requirementId = "PRJ-ENE-003";

            attribute :>> domain = "能量回收";

            attribute :>> requirementName = "储能电流约束";

            attribute :>> requirementText = "车载储能系统充放电电流不得超过项目设定的电流限制。";

            attribute :>> standardNo = "";

            attribute :>> standardClause = "";

            attribute :>> criteria = "I_max = 900 A。";

            attribute :>> applicableConditions = "当前X100等效模型。";

            attribute :>> requirementType = "项目约束";

            attribute :>> verificationStatus = "PARTIALLY_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_PRJ_ENE_003 : RailRequirement by fn_FN_F_X112_02 {

            attribute :>> requirementId = "PRJ-ENE-003";

            attribute :>> domain = "能量回收";

            attribute :>> requirementName = "储能电流约束";

            attribute :>> requirementText = "车载储能系统充放电电流不得超过项目设定的电流限制。";

            attribute :>> standardNo = "";

            attribute :>> standardClause = "";

            attribute :>> criteria = "I_max = 900 A。";

            attribute :>> applicableConditions = "当前X100等效模型。";

            attribute :>> requirementType = "项目约束";

            attribute :>> verificationStatus = "PARTIALLY_VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_PRJ_PWR_001 : RailRequirement by fn_FN_F_4111_01 {

            attribute :>> requirementId = "PRJ-PWR-001";

            attribute :>> domain = "供电";

            attribute :>> requirementName = "项目牵引供电制式需求";

            attribute :>> requirementText = "本项目牵引供电采用AC 25 kV、50 Hz作为联合仿真名义工况。";

            attribute :>> standardNo = "GB/T 1402-2025";

            attribute :>> standardClause = "标准背景";

            attribute :>> criteria = "名义供电：AC 25 kV / 50 Hz。";

            attribute :>> applicableConditions = "项目交流电气化轨道车辆单动力单元抽象模型。";

            attribute :>> requirementType = "项目约束";

            attribute :>> verificationStatus = "VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_PRJ_PWR_001 : RailRequirement by fn_FN_F_4511_01 {

            attribute :>> requirementId = "PRJ-PWR-001";

            attribute :>> domain = "供电";

            attribute :>> requirementName = "项目牵引供电制式需求";

            attribute :>> requirementText = "本项目牵引供电采用AC 25 kV、50 Hz作为联合仿真名义工况。";

            attribute :>> standardNo = "GB/T 1402-2025";

            attribute :>> standardClause = "标准背景";

            attribute :>> criteria = "名义供电：AC 25 kV / 50 Hz。";

            attribute :>> applicableConditions = "项目交流电气化轨道车辆单动力单元抽象模型。";

            attribute :>> requirementType = "项目约束";

            attribute :>> verificationStatus = "VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_PRJ_PWR_001 : RailRequirement by fn_FN_F_5131_01 {

            attribute :>> requirementId = "PRJ-PWR-001";

            attribute :>> domain = "供电";

            attribute :>> requirementName = "项目牵引供电制式需求";

            attribute :>> requirementText = "本项目牵引供电采用AC 25 kV、50 Hz作为联合仿真名义工况。";

            attribute :>> standardNo = "GB/T 1402-2025";

            attribute :>> standardClause = "标准背景";

            attribute :>> criteria = "名义供电：AC 25 kV / 50 Hz。";

            attribute :>> applicableConditions = "项目交流电气化轨道车辆单动力单元抽象模型。";

            attribute :>> requirementType = "项目约束";

            attribute :>> verificationStatus = "VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

        satisfy requirement req_PRJ_PWR_001 : RailRequirement by fn_FN_F_5132_01 {

            attribute :>> requirementId = "PRJ-PWR-001";

            attribute :>> domain = "供电";

            attribute :>> requirementName = "项目牵引供电制式需求";

            attribute :>> requirementText = "本项目牵引供电采用AC 25 kV、50 Hz作为联合仿真名义工况。";

            attribute :>> standardNo = "GB/T 1402-2025";

            attribute :>> standardClause = "标准背景";

            attribute :>> criteria = "名义供电：AC 25 kV / 50 Hz。";

            attribute :>> applicableConditions = "项目交流电气化轨道车辆单动力单元抽象模型。";

            attribute :>> requirementType = "项目约束";

            attribute :>> verificationStatus = "VERIFIED";

            attribute :>> sourceFile = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";

        }

    }
}
