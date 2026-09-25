package FunctionInteractionTrace {
    private import ScalarValues::*;

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
}
