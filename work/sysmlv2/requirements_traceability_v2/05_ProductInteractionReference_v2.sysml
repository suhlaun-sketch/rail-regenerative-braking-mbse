// Product/flow/interface endpoints reference the frozen PhysicalNetworks package; no Function-to-Connector relation is asserted.
package ProductInteractionReferenceV2 {
    private import PhysicalNetworks::*;

    private import ScalarValues::*;

    item def ProductFlowTraceReference {
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

    item productFlow_001 : ProductFlowTraceReference {
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

    item productFlow_002 : ProductFlowTraceReference {
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

    item productFlow_003 : ProductFlowTraceReference {
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

    item productFlow_004 : ProductFlowTraceReference {
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

    item productFlow_005 : ProductFlowTraceReference {
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

    item productFlow_006 : ProductFlowTraceReference {
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

    item productFlow_007 : ProductFlowTraceReference {
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

    item productFlow_008 : ProductFlowTraceReference {
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

    item productFlow_009 : ProductFlowTraceReference {
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

    item productFlow_010 : ProductFlowTraceReference {
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

    item productFlow_011 : ProductFlowTraceReference {
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

    item productFlow_012 : ProductFlowTraceReference {
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

    item productFlow_013 : ProductFlowTraceReference {
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

    item productFlow_014 : ProductFlowTraceReference {
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

    item productFlow_015 : ProductFlowTraceReference {
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

    item productFlow_016 : ProductFlowTraceReference {
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

    item productFlow_017 : ProductFlowTraceReference {
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

    item productFlow_018 : ProductFlowTraceReference {
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

    item productFlow_019 : ProductFlowTraceReference {
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

    item productFlow_020 : ProductFlowTraceReference {
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

    item productFlow_021 : ProductFlowTraceReference {
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

    item productFlow_022 : ProductFlowTraceReference {
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

    item productFlow_023 : ProductFlowTraceReference {
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

    item productFlow_024 : ProductFlowTraceReference {
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

    item productFlow_025 : ProductFlowTraceReference {
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

    item productFlow_026 : ProductFlowTraceReference {
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

    item productFlow_027 : ProductFlowTraceReference {
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

    item productFlow_028 : ProductFlowTraceReference {
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

    item productFlow_029 : ProductFlowTraceReference {
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

    item productFlow_030 : ProductFlowTraceReference {
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

    item productFlow_031 : ProductFlowTraceReference {
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

    item productFlow_032 : ProductFlowTraceReference {
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

    item productFlow_033 : ProductFlowTraceReference {
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

    item productFlow_034 : ProductFlowTraceReference {
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

    item productFlow_035 : ProductFlowTraceReference {
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

    item productFlow_036 : ProductFlowTraceReference {
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

    item productFlow_037 : ProductFlowTraceReference {
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

    item productFlow_038 : ProductFlowTraceReference {
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

    item productFlow_039 : ProductFlowTraceReference {
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

    item productFlow_040 : ProductFlowTraceReference {
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

    item productFlow_041 : ProductFlowTraceReference {
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

    item productFlow_042 : ProductFlowTraceReference {
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

    item productFlow_043 : ProductFlowTraceReference {
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

    item productFlow_044 : ProductFlowTraceReference {
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

    item productFlow_045 : ProductFlowTraceReference {
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

    item productFlow_046 : ProductFlowTraceReference {
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

    item productFlow_047 : ProductFlowTraceReference {
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

    item productFlow_048 : ProductFlowTraceReference {
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

    item productFlow_049 : ProductFlowTraceReference {
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

    item productFlow_050 : ProductFlowTraceReference {
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

    item productFlow_051 : ProductFlowTraceReference {
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

    item productFlow_052 : ProductFlowTraceReference {
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

    item productFlow_053 : ProductFlowTraceReference {
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

    item productFlow_054 : ProductFlowTraceReference {
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

    item productFlow_055 : ProductFlowTraceReference {
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

    item productFlow_056 : ProductFlowTraceReference {
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

    item productFlow_057 : ProductFlowTraceReference {
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

    item productFlow_058 : ProductFlowTraceReference {
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

    item productFlow_059 : ProductFlowTraceReference {
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

    item productFlow_060 : ProductFlowTraceReference {
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

    item productFlow_061 : ProductFlowTraceReference {
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

    item productFlow_062 : ProductFlowTraceReference {
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

    item productFlow_063 : ProductFlowTraceReference {
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

    item productFlow_064 : ProductFlowTraceReference {
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

    item productFlow_065 : ProductFlowTraceReference {
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

    item productFlow_066 : ProductFlowTraceReference {
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

    item productFlow_067 : ProductFlowTraceReference {
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

    item productFlow_068 : ProductFlowTraceReference {
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

    item productFlow_069 : ProductFlowTraceReference {
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

    item productFlow_070 : ProductFlowTraceReference {
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

    item productFlow_071 : ProductFlowTraceReference {
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

    item productFlow_072 : ProductFlowTraceReference {
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

    item productFlow_073 : ProductFlowTraceReference {
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

    item productFlow_074 : ProductFlowTraceReference {
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

}
