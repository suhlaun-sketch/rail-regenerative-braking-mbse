package RequirementTraceUsages {
    private import RequirementTraceDefinitions::*;

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
}
