package RequirementTraceabilityAllInOneV2 {
    private import ScalarValues::*;
    private import FunctionDefinitions::*;
    private import ProductDefinitions::*;
    private import FunctionAllocations::*;
    private import PhysicalNetworks::*;

    requirement def RailRequirementV2 {
        attribute requirementID : String;
        attribute parentRequirementIDs : String;
        attribute requirementLevel : String;
        attribute domain : String;
        attribute topicGroup : String;
        attribute name : String;
        attribute text : String;
        attribute requirementType : String;
        attribute sourceType : String;
        attribute standardNo : String;
        attribute standardClause : String;
        attribute criteria : String;
        attribute applicableConditions : String;
        attribute keywords : String;
        attribute synonyms : String;
        attribute userPhrases : String;
        attribute semanticTopics : String;
        attribute systemTerms : String;
        attribute actionTerms : String;
        attribute objectTerms : String;
        attribute expectedFunctionSemantics : String;
        attribute linkedFunctionIDs : String;
        attribute linkedFunctionNames : String;
        attribute linkedProductIDs : String;
        attribute linkedProductNames : String;
        attribute functionCoverageCount : String;
        attribute coverageStatus : String;
        attribute derivationReason : String;
        attribute relatedRequirementIDs : String;
        attribute verificationStatus : String;
        attribute modelCoverage : String;
        attribute notes : String;
        attribute evidenceSource : String;
    }

    requirement req_PRJ_BRK_001 : RailRequirementV2 {
        attribute :>> requirementID = "PRJ-BRK-001";
        attribute :>> parentRequirementIDs = "";
        attribute :>> requirementLevel = "L0_SYSTEM";
        attribute :>> domain = "制动";
        attribute :>> topicGroup = "BRAKING";
        attribute :>> name = "项目服务制动目标需求";
        attribute :>> text = "本项目服务制动目标减速度设为1.2 m/s²，用于高于GB/T 7928-2025常用制动基线的设计验证与需求变更示例。";
        attribute :>> requirementType = "项目性能";
        attribute :>> sourceType = "PROJECT_REQUIREMENT";
        attribute :>> standardNo = "";
        attribute :>> standardClause = "";
        attribute :>> criteria = "项目目标 a_service = 1.2 m/s²；标准基线为常用制动平均减速度≥1.0 m/s²。";
        attribute :>> applicableConditions = "当前80 t等效动力单元；项目基准工况。";
        attribute :>> keywords = "1.2m/s²；服务制动；项目目标；需求变更；制动；制动力；制动请求；再生制动；机械制动；摩擦制动；空气制动；制动协调";
        attribute :>> synonyms = "常用制动目标；提高减速度；刹车；摩擦制动；空气制动；气动制动；电制动";
        attribute :>> userPhrases = "我想看制动系统；把制动目标从1.0提高到1.2；服务制动要求提高；我想看项目服务制动目标需求具体要求；1.2m/s²相关的制动要求有哪些；服务制动出现异常时要查什么要求";
        attribute :>> semanticTopics = "BRAKING";
        attribute :>> systemTerms = "7211；电子制动控制单元(EBCU)；7200；制动；7255；增压缸；5311；牵引电机；5300；牵引电机及其冷却";
        attribute :>> actionTerms = "控制；协调；执行；转换；分配";
        attribute :>> objectTerms = "制动力；速度；机械能；电能；气动压力";
        attribute :>> expectedFunctionSemantics = "制动需求计算;制动力分配;车辆纵向动力学";
        attribute :>> linkedFunctionIDs = "FN_F_7211_01；FN_F_7211_02；FN_F_7211_03；FN_F_7255_01；FN_F_5311_01";
        attribute :>> linkedFunctionNames = "处理制动请求；协调再生制动与摩擦制动力；执行电空制动控制；将气动压力转换为制动机械力；实现三相交流电能与旋转机械能双向转换";
        attribute :>> linkedProductIDs = "7211；7255；5311";
        attribute :>> linkedProductNames = "电子制动控制单元(EBCU)；增压缸；牵引电机";
        attribute :>> functionCoverageCount = "5";
        attribute :>> coverageStatus = "FULL";
        attribute :>> derivationReason = "";
        attribute :>> relatedRequirementIDs = "DRV-BRK-001；DRV-BRK-002；DRV-CTL-003；REQ-BRK-001；REQ-BRK-002；REQ-BRK-003；REQ-BRK-004；REQ-BRK-005；REQ-BRK-006；REQ-BRK-007；REQ-BRK-008；REQ-BRK-009；REQ-BRK-010；REQ-BRK-011；REQ-BRK-012；REQ-BRK-013；REQ-BRK-014；REQ-BRK-015；REQ-ENE-002；REQ-ENE-003";
        attribute :>> verificationStatus = "VERIFIED";
        attribute :>> modelCoverage = "COVERED";
        attribute :>> notes = "该值是项目设计目标，不是GB/T 7928-2025对常用制动的最低要求。";
        attribute :>> evidenceSource = "https://www.gb-gbt.com/PDF/Chinese.aspx/GBT7928-2025";
    }

    requirement req_PRJ_ENE_001 : RailRequirementV2 {
        attribute :>> requirementID = "PRJ-ENE-001";
        attribute :>> parentRequirementIDs = "";
        attribute :>> requirementLevel = "L0_SYSTEM";
        attribute :>> domain = "能量回收";
        attribute :>> topicGroup = "ENERGY_STORAGE";
        attribute :>> name = "无电网再生接纳时车载储能吸收需求";
        attribute :>> text = "在当前仿真设定的电网不接纳再生功率工况下，可利用的再生制动能量应优先进入车载储能系统，并受储能可用能力约束。";
        attribute :>> requirementType = "项目功能";
        attribute :>> sourceType = "PROJECT_REQUIREMENT";
        attribute :>> standardNo = "";
        attribute :>> standardClause = "";
        attribute :>> criteria = "当前场景 grid_regen_acceptance = 0 W；能量优先路由至X100，在功率/SOC/电流限制内吸收。";
        attribute :>> applicableConditions = "当前项目的储能优先仿真场景。";
        attribute :>> keywords = "电网不接纳；再生能量；车载储能；X100；0W；储能；超级电容；SOC；充电；放电；储能功率；能量回收";
        attribute :>> synonyms = "无法回馈电网；储能优先；能量路由；车载储能；超级电容器；超容；电容储能；回馈制动；制动能量回收；再生能量回收";
        attribute :>> userPhrases = "我想看再生制动；制动的电去哪了；超级电容SOC上限；储能坏了怎么办；电网不要再生能量怎么办；再生能量怎么进超级电容；我想看无电网再生接纳时车载储能吸收需求具体要求";
        attribute :>> semanticTopics = "ENERGY_STORAGE";
        attribute :>> systemTerms = "X100；车载再生储能";
        attribute :>> actionTerms = "吸收；存储；释放；路由";
        attribute :>> objectTerms = "再生功率；超级电容；SOC";
        attribute :>> expectedFunctionSemantics = "再生能量路由;储能可用能力判断;吸收和存储再生制动能量";
        attribute :>> linkedFunctionIDs = "FN_F_X100_01";
        attribute :>> linkedFunctionNames = "吸收、存储并按需释放再生制动能量";
        attribute :>> linkedProductIDs = "X100";
        attribute :>> linkedProductNames = "车载再生储能";
        attribute :>> functionCoverageCount = "1";
        attribute :>> coverageStatus = "FULL";
        attribute :>> derivationReason = "";
        attribute :>> relatedRequirementIDs = "PRJ-ENE-002；PRJ-ENE-003；PRJ-ENE-004；REQ-BRK-004；REQ-BRK-006；REQ-BRK-007；REQ-BRK-008；REQ-BRK-009；REQ-BRK-015；REQ-ENE-001；REQ-ENE-002；REQ-ENE-003；REQ-ENE-004；REQ-ENE-005；REQ-ENE-006；REQ-ENE-007；REQ-ENE-008；REQ-ENE-009；REQ-TRAC-001；REQ-TRAC-003";
        attribute :>> verificationStatus = "VERIFIED";
        attribute :>> modelCoverage = "COVERED";
        attribute :>> notes = "这是项目场景与设计需求，不是国标直接条款。";
        attribute :>> evidenceSource = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
    }

    requirement req_PRJ_ENE_002 : RailRequirementV2 {
        attribute :>> requirementID = "PRJ-ENE-002";
        attribute :>> parentRequirementIDs = "";
        attribute :>> requirementLevel = "L1_DOMAIN";
        attribute :>> domain = "能量回收";
        attribute :>> topicGroup = "ENERGY_STORAGE";
        attribute :>> name = "储能最大充电功率约束";
        attribute :>> text = "车载储能系统吸收再生功率时，充电功率不得超过项目设定的最大允许充电功率。";
        attribute :>> requirementType = "项目约束";
        attribute :>> sourceType = "PROJECT_REQUIREMENT";
        attribute :>> standardNo = "";
        attribute :>> standardClause = "";
        attribute :>> criteria = "P_charge,max = 600 kW。";
        attribute :>> applicableConditions = "当前X100等效模型。";
        attribute :>> keywords = "600kW；充电功率；功率限制；超级电容；储能；再生能量；SOC；充电；放电；储能功率；能量回收；储能状态";
        attribute :>> synonyms = "储能功率上限；充电限功率；车载储能；超级电容器；超容；电容储能；回馈制动；制动能量回收；再生能量回收";
        attribute :>> userPhrases = "超级电容最多吸收多少功率；600千瓦限制；我想看储能最大充电功率约束具体要求；600kW相关的能量回收要求有哪些；充电功率出现异常时要查什么要求";
        attribute :>> semanticTopics = "ENERGY_STORAGE";
        attribute :>> systemTerms = "X112；双向DC/DC控制模块；X100；车载再生储能；X121；超级电容模块";
        attribute :>> actionTerms = "控制；协调；限制；吸收；释放；保护";
        attribute :>> objectTerms = "电能；再生功率；充电功率；放电功率；超级电容；SOC";
        attribute :>> expectedFunctionSemantics = "储能充电限幅;再生能力约束";
        attribute :>> linkedFunctionIDs = "FN_F_X112_02；FN_F_X112_01；FN_F_X121_01";
        attribute :>> linkedFunctionNames = "限制储能充放电功率并协调保护；控制双向DC/DC功率变换；储存并按需释放再生制动电能";
        attribute :>> linkedProductIDs = "X112；X121";
        attribute :>> linkedProductNames = "双向DC/DC控制模块；超级电容模块";
        attribute :>> functionCoverageCount = "3";
        attribute :>> coverageStatus = "FULL";
        attribute :>> derivationReason = "";
        attribute :>> relatedRequirementIDs = "PRJ-ENE-001；PRJ-ENE-003；PRJ-ENE-004；REQ-BRK-004；REQ-BRK-006；REQ-BRK-007；REQ-BRK-008；REQ-BRK-009；REQ-BRK-015；REQ-ENE-001；REQ-ENE-002；REQ-ENE-003；REQ-ENE-004；REQ-ENE-005；REQ-ENE-006；REQ-ENE-007；REQ-ENE-008；REQ-ENE-009；REQ-TRAC-001；REQ-TRAC-003";
        attribute :>> verificationStatus = "VERIFIED";
        attribute :>> modelCoverage = "COVERED";
        attribute :>> notes = "600 kW是当前项目模型参数，不是GB/T 42005.1-2022规定值。";
        attribute :>> evidenceSource = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
    }

    requirement req_PRJ_ENE_003 : RailRequirementV2 {
        attribute :>> requirementID = "PRJ-ENE-003";
        attribute :>> parentRequirementIDs = "";
        attribute :>> requirementLevel = "L1_DOMAIN";
        attribute :>> domain = "能量回收";
        attribute :>> topicGroup = "ENERGY_STORAGE";
        attribute :>> name = "储能电流约束";
        attribute :>> text = "车载储能系统充放电电流不得超过项目设定的电流限制。";
        attribute :>> requirementType = "项目约束";
        attribute :>> sourceType = "PROJECT_REQUIREMENT";
        attribute :>> standardNo = "";
        attribute :>> standardClause = "";
        attribute :>> criteria = "I_max = 900 A。";
        attribute :>> applicableConditions = "当前X100等效模型。";
        attribute :>> keywords = "900A；电流限制；限流；超级电容；储能；再生能量；SOC；充电；放电；储能功率；能量回收；储能状态";
        attribute :>> synonyms = "最大电流；储能限流；车载储能；超级电容器；超容；电容储能；回馈制动；制动能量回收";
        attribute :>> userPhrases = "超级电容最大电流是多少；电流超过900A怎么办；我想看储能电流约束具体要求；900A相关的能量回收要求有哪些；电流限制出现异常时要查什么要求";
        attribute :>> semanticTopics = "ENERGY_STORAGE";
        attribute :>> systemTerms = "X123；超级电容电流传感器；X100；车载再生储能；X112；双向DC/DC控制模块";
        attribute :>> actionTerms = "检测；协调；限制；保护";
        attribute :>> objectTerms = "放电功率；超级电容；SOC；电流";
        attribute :>> expectedFunctionSemantics = "电流限幅;储能可用能力判断";
        attribute :>> linkedFunctionIDs = "FN_F_X123_01；FN_F_X112_02";
        attribute :>> linkedFunctionNames = "检测超级电容电流传感器状态；限制储能充放电功率并协调保护";
        attribute :>> linkedProductIDs = "X123；X112";
        attribute :>> linkedProductNames = "超级电容电流传感器；双向DC/DC控制模块";
        attribute :>> functionCoverageCount = "2";
        attribute :>> coverageStatus = "FULL";
        attribute :>> derivationReason = "";
        attribute :>> relatedRequirementIDs = "PRJ-ENE-001；PRJ-ENE-002；PRJ-ENE-004；REQ-BRK-004；REQ-BRK-006；REQ-BRK-007；REQ-BRK-008；REQ-BRK-009；REQ-BRK-015；REQ-ENE-001；REQ-ENE-002；REQ-ENE-003；REQ-ENE-004；REQ-ENE-005；REQ-ENE-006；REQ-ENE-007；REQ-ENE-008；REQ-ENE-009；REQ-TRAC-001；REQ-TRAC-003";
        attribute :>> verificationStatus = "PARTIALLY_VERIFIED";
        attribute :>> modelCoverage = "COVERED";
        attribute :>> notes = "900 A是项目设计值；应与REQ-ENE-008的过流保护概念区分。";
        attribute :>> evidenceSource = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
    }

    requirement req_PRJ_ENE_004 : RailRequirementV2 {
        attribute :>> requirementID = "PRJ-ENE-004";
        attribute :>> parentRequirementIDs = "";
        attribute :>> requirementLevel = "L1_DOMAIN";
        attribute :>> domain = "能量回收";
        attribute :>> topicGroup = "ENERGY_STORAGE";
        attribute :>> name = "再生充电SOC上限需求";
        attribute :>> text = "当储能SOC达到项目设定的再生充电上限时，应限制或停止继续吸收再生能量。";
        attribute :>> requirementType = "项目约束";
        attribute :>> sourceType = "PROJECT_REQUIREMENT";
        attribute :>> standardNo = "";
        attribute :>> standardClause = "";
        attribute :>> criteria = "SOC_max_regen = 0.98。";
        attribute :>> applicableConditions = "当前X100等效模型。";
        attribute :>> keywords = "SOC；0.98；充电上限；再生制动；储能可用性；储能；再生能量；超级电容；充电；放电；储能功率；能量回收";
        attribute :>> synonyms = "SOC上限；满电；停止充电；车载储能；超级电容器；超容；电容储能；回馈制动；制动能量回收；再生能量回收";
        attribute :>> userPhrases = "我想看再生制动；制动的电去哪了；超级电容SOC上限；储能坏了怎么办；SOC到98%怎么办；超级电容满了还回收吗；我想看再生充电SOC上限需求具体要求";
        attribute :>> semanticTopics = "ENERGY_STORAGE";
        attribute :>> systemTerms = "X100；车载再生储能";
        attribute :>> actionTerms = "监测；限制；吸收；存储；释放";
        attribute :>> objectTerms = "再生功率；超级电容；SOC";
        attribute :>> expectedFunctionSemantics = "SOC监测;储能可用能力判断;再生功率限幅";
        attribute :>> linkedFunctionIDs = "FN_F_X100_01";
        attribute :>> linkedFunctionNames = "吸收、存储并按需释放再生制动能量";
        attribute :>> linkedProductIDs = "X100";
        attribute :>> linkedProductNames = "车载再生储能";
        attribute :>> functionCoverageCount = "1";
        attribute :>> coverageStatus = "FULL";
        attribute :>> derivationReason = "";
        attribute :>> relatedRequirementIDs = "PRJ-ENE-001；PRJ-ENE-002；PRJ-ENE-003；REQ-BRK-004；REQ-BRK-006；REQ-BRK-007；REQ-BRK-008；REQ-BRK-009；REQ-BRK-015；REQ-ENE-001；REQ-ENE-002；REQ-ENE-003；REQ-ENE-004；REQ-ENE-005；REQ-ENE-006；REQ-ENE-007；REQ-ENE-008；REQ-ENE-009；REQ-TRAC-001；REQ-TRAC-003";
        attribute :>> verificationStatus = "PARTIALLY_VERIFIED";
        attribute :>> modelCoverage = "COVERED";
        attribute :>> notes = "0.98是项目设计值，不是国标规定值。";
        attribute :>> evidenceSource = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx";
    }

    requirement req_PRJ_PWR_001 : RailRequirementV2 {
        attribute :>> requirementID = "PRJ-PWR-001";
        attribute :>> parentRequirementIDs = "";
        attribute :>> requirementLevel = "L0_SYSTEM";
        attribute :>> domain = "供电";
        attribute :>> topicGroup = "POWER_SUPPLY";
        attribute :>> name = "项目牵引供电制式需求";
        attribute :>> text = "本项目牵引供电采用AC 25 kV、50 Hz作为联合仿真名义工况。";
        attribute :>> requirementType = "项目约束";
        attribute :>> sourceType = "PROJECT_REQUIREMENT";
        attribute :>> standardNo = "GB/T 1402-2025";
        attribute :>> standardClause = "标准背景";
        attribute :>> criteria = "名义供电：AC 25 kV / 50 Hz。";
        attribute :>> applicableConditions = "项目交流电气化轨道车辆单动力单元抽象模型。";
        attribute :>> keywords = "25kV；50Hz；接触网；牵引供电；交流供电；供电；高压；受电弓；主变压器；高压分配；回流；接地";
        attribute :>> synonyms = "25千伏；工频交流；接触网电压；网侧供电；牵引供电；受流系统；高压电源";
        attribute :>> userPhrases = "供电电压是多少；为什么是25kV；接触网输入；我想看项目牵引供电制式需求具体要求；25kV相关的供电要求有哪些；50Hz出现异常时要查什么要求";
        attribute :>> semanticTopics = "POWER_SUPPLY";
        attribute :>> systemTerms = "4111；碳滑板；4100；高压受流；4511；主变压器主体；4500；主变压器及其冷却；5131；网侧变流模块；5100；牵引变流器主体及其控制；5132；电机侧变流模块；4110；受电弓总成；4200；网侧高压分配及控制；4210；高压开关；4211；真空断路器；4212；非真空隔离开关";
        attribute :>> actionTerms = "控制；传递；转换；隔离；分配";
        attribute :>> objectTerms = "电能；电压；受电弓；断路器；接地；回流";
        attribute :>> expectedFunctionSemantics = "供电输入;主变压器电压变换;直流母线供能";
        attribute :>> linkedFunctionIDs = "FN_F_4111_01；FN_F_4511_01；FN_F_5131_01；FN_F_5132_01；FN_F_4100_01；FN_F_4110_01；FN_F_4200_01；FN_F_4210_01；FN_F_4211_01；FN_F_4212_01";
        attribute :>> linkedFunctionNames = "传递碳滑板电能；实现高压交流电能与牵引变压器次级交流电能转换；实现主变次级交流电能与中间直流电能双向转换；实现中间直流电能与电机侧三相交流电能双向转换；传递能量/介质、控制运行；传递能量/介质、控制运行；传递能量/介质、控制运行；传递能量/介质；传递真空断路器电能；传递非真空隔离开关电能";
        attribute :>> linkedProductIDs = "4111；4511；5131；5132；4100；4110；4200；4210；4211；4212";
        attribute :>> linkedProductNames = "碳滑板；主变压器主体；网侧变流模块；电机侧变流模块；高压受流；受电弓总成；网侧高压分配及控制；高压开关；真空断路器；非真空隔离开关";
        attribute :>> functionCoverageCount = "10";
        attribute :>> coverageStatus = "FULL";
        attribute :>> derivationReason = "";
        attribute :>> relatedRequirementIDs = "DRV-PWR-001；DRV-PWR-002；DRV-PWR-003";
        attribute :>> verificationStatus = "VERIFIED";
        attribute :>> modelCoverage = "COVERED";
        attribute :>> notes = "GB/T 1402-2025为牵引供电系统电压标准背景；25 kV/50 Hz为本项目当前仿真设定。未将未核对的GB/T 1402-2025电压上下限写成直接标准判据。";
        attribute :>> evidenceSource = "https://std.samr.gov.cn/gb/search/gbDetailed?id=473EBB99D6A5455EE06397BE0A0ABB9A";
    }

    requirement req_REQ_BRK_001 : RailRequirementV2 {
        attribute :>> requirementID = "REQ-BRK-001";
        attribute :>> parentRequirementIDs = "";
        attribute :>> requirementLevel = "L1_DOMAIN";
        attribute :>> domain = "制动";
        attribute :>> topicGroup = "BRAKING";
        attribute :>> name = "常用制动平均减速度需求";
        attribute :>> text = "列车从最高运行速度实施常用制动至停车时，平均减速度不应低于1.0 m/s²。";
        attribute :>> requirementType = "性能";
        attribute :>> sourceType = "STANDARD_DIRECT";
        attribute :>> standardNo = "GB/T 7928-2025";
        attribute :>> standardClause = "6.12 a)";
        attribute :>> criteria = "平均常用制动减速度 ≥ 1.0 m/s²。";
        attribute :>> applicableConditions = "超员；平直干燥轨道；车轮半磨耗；从最高运行速度制动至停车。";
        attribute :>> keywords = "常用制动；平均减速度；制动力；停车；制动；制动请求；再生制动；机械制动；摩擦制动；空气制动；制动协调；减速度";
        attribute :>> synonyms = "服务制动；正常制动；减速度；刹车；摩擦制动；空气制动；气动制动；电制动";
        attribute :>> userPhrases = "我想看制动系统；只看服务制动；常用制动够不够；制动减速度是多少；我想看常用制动平均减速度需求具体要求；常用制动相关的制动要求有哪些；平均减速度出现异常时要查什么要求";
        attribute :>> semanticTopics = "BRAKING";
        attribute :>> systemTerms = "7211；电子制动控制单元(EBCU)；7200；制动；7255；增压缸；5311；牵引电机；5300；牵引电机及其冷却；3111；车轮；3100；轮轴组成；3130；制动盘；3131；外轮盘；3132；内轮盘；3133；轴盘；7252；非停放制动夹钳装置";
        attribute :>> actionTerms = "控制；协调；执行；传递；转换；耗散；分配";
        attribute :>> objectTerms = "制动力；速度；机械能；电能；气动压力；制动夹钳";
        attribute :>> expectedFunctionSemantics = "制动需求计算;总制动力生成;制动力分配;车辆纵向动力学";
        attribute :>> linkedFunctionIDs = "FN_F_7211_01；FN_F_7211_02；FN_F_7211_03；FN_F_7255_01；FN_F_5311_01；FN_F_3111_01；FN_F_3130_01；FN_F_3131_01；FN_F_3132_01；FN_F_3133_01；FN_F_7252_01；FN_F_7254_01";
        attribute :>> linkedFunctionNames = "处理制动请求；协调再生制动与摩擦制动力；执行电空制动控制；将气动压力转换为制动机械力；实现三相交流电能与旋转机械能双向转换；通过车轮耗散能量；耗散能量；通过外轮盘耗散机械制动能量；通过内轮盘耗散能量；通过轴盘耗散能量；传递制动夹钳作用力；通过闸片耗散机械制动能量";
        attribute :>> linkedProductIDs = "7211；7255；5311；3111；3130；3131；3132；3133；7252；7254";
        attribute :>> linkedProductNames = "电子制动控制单元(EBCU)；增压缸；牵引电机；车轮；制动盘；外轮盘；内轮盘；轴盘；非停放制动夹钳装置；闸片";
        attribute :>> functionCoverageCount = "12";
        attribute :>> coverageStatus = "FULL";
        attribute :>> derivationReason = "";
        attribute :>> relatedRequirementIDs = "DRV-BRK-001；DRV-BRK-002；DRV-CTL-003；PRJ-BRK-001；REQ-BRK-002；REQ-BRK-003；REQ-BRK-004；REQ-BRK-005；REQ-BRK-006；REQ-BRK-007；REQ-BRK-008；REQ-BRK-009；REQ-BRK-010；REQ-BRK-011；REQ-BRK-012；REQ-BRK-013；REQ-BRK-014；REQ-BRK-015；REQ-ENE-002；REQ-ENE-003";
        attribute :>> verificationStatus = "PARTIALLY_VERIFIED";
        attribute :>> modelCoverage = "COVERED";
        attribute :>> notes = "当前项目设计目标采用1.2 m/s²，但标准基线为≥1.0 m/s²；当前仿真工况不完全等同标准规定工况。";
        attribute :>> evidenceSource = "https://www.gb-gbt.com/PDF/Chinese.aspx/GBT7928-2025";
    }

    requirement req_REQ_BRK_002 : RailRequirementV2 {
        attribute :>> requirementID = "REQ-BRK-002";
        attribute :>> parentRequirementIDs = "";
        attribute :>> requirementLevel = "L1_DOMAIN";
        attribute :>> domain = "制动";
        attribute :>> topicGroup = "BRAKING";
        attribute :>> name = "紧急制动平均减速度需求";
        attribute :>> text = "列车从最高运行速度实施紧急制动至停车时，平均减速度不应低于1.2 m/s²。";
        attribute :>> requirementType = "性能/安全";
        attribute :>> sourceType = "STANDARD_DIRECT";
        attribute :>> standardNo = "GB/T 7928-2025";
        attribute :>> standardClause = "6.12 b)";
        attribute :>> criteria = "平均紧急制动减速度 ≥ 1.2 m/s²。";
        attribute :>> applicableConditions = "超员；平直干燥轨道；车轮半磨耗；从最高运行速度制动至停车。";
        attribute :>> keywords = "紧急制动；平均减速度；安全停车；制动；制动力；制动请求；再生制动；机械制动；摩擦制动；空气制动；制动协调；减速度";
        attribute :>> synonyms = "急停；EB；紧急停车；刹车；摩擦制动；空气制动；气动制动；电制动";
        attribute :>> userPhrases = "我想看制动系统；紧急制动够不够；急停能不能停住；我想看紧急制动平均减速度需求具体要求；紧急制动相关的制动要求有哪些；平均减速度出现异常时要查什么要求";
        attribute :>> semanticTopics = "BRAKING；机械制动";
        attribute :>> systemTerms = "7211；电子制动控制单元(EBCU)；7200；制动；7226；紧急制动阀；7255；增压缸；D121；紧急制动按钮；D100；操纵设施";
        attribute :>> actionTerms = "协调；执行；转换；隔离；提供";
        attribute :>> objectTerms = "制动力；速度；气动压力";
        attribute :>> expectedFunctionSemantics = "紧急制动需求生成;机械制动执行;车辆纵向动力学";
        attribute :>> linkedFunctionIDs = "FN_F_7211_04；FN_F_7226_01；FN_F_7255_01；FN_F_D121_01";
        attribute :>> linkedFunctionNames = "协调防滑与紧急制动安全请求；执行紧急制动气动隔离与施加；将气动压力转换为制动机械力；提供紧急制动按钮边界交互";
        attribute :>> linkedProductIDs = "7211；7226；7255；D121";
        attribute :>> linkedProductNames = "电子制动控制单元(EBCU)；紧急制动阀；增压缸；紧急制动按钮";
        attribute :>> functionCoverageCount = "4";
        attribute :>> coverageStatus = "PARTIAL";
        attribute :>> derivationReason = "";
        attribute :>> relatedRequirementIDs = "DRV-BRK-001；DRV-BRK-002；DRV-CTL-003；PRJ-BRK-001；REQ-BRK-001；REQ-BRK-003；REQ-BRK-004；REQ-BRK-005；REQ-BRK-006；REQ-BRK-007；REQ-BRK-008；REQ-BRK-009；REQ-BRK-010；REQ-BRK-011；REQ-BRK-012；REQ-BRK-013；REQ-BRK-014；REQ-BRK-015；REQ-ENE-002；REQ-ENE-003";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> modelCoverage = "PARTIAL";
        attribute :>> notes = "当前基准仿真为服务制动/保持工况，不能把1.2 m/s²服务制动目标当作紧急制动验证。";
        attribute :>> evidenceSource = "https://www.gb-gbt.com/PDF/Chinese.aspx/GBT7928-2025";
    }

    requirement req_REQ_BRK_003 : RailRequirementV2 {
        attribute :>> requirementID = "REQ-BRK-003";
        attribute :>> parentRequirementIDs = "";
        attribute :>> requirementLevel = "L1_DOMAIN";
        attribute :>> domain = "制动";
        attribute :>> topicGroup = "BRAKING";
        attribute :>> name = "纵向冲击率需求";
        attribute :>> text = "除紧急制动外，列车在牵引或制动过程中纵向冲击率不应大于0.75 m/s³。";
        attribute :>> requirementType = "舒适性/性能";
        attribute :>> sourceType = "STANDARD_DIRECT";
        attribute :>> standardNo = "GB/T 7928-2025";
        attribute :>> standardClause = "6.13";
        attribute :>> criteria = "纵向冲击率 ≤ 0.75 m/s³。";
        attribute :>> applicableConditions = "牵引或非紧急制动过程。";
        attribute :>> keywords = "冲击率；平顺性；舒适性；加加速度；jerk；制动；制动力；制动请求；再生制动；机械制动；摩擦制动；空气制动";
        attribute :>> synonyms = "冲动限制；纵向冲动；平顺制动；刹车；摩擦制动；空气制动；气动制动；电制动";
        attribute :>> userPhrases = "我想看制动系统；制动会不会顿挫；平顺性怎么样；冲击率多少；我想看纵向冲击率需求具体要求；冲击率相关的制动要求有哪些；平顺性出现异常时要查什么要求";
        attribute :>> semanticTopics = "BRAKING";
        attribute :>> systemTerms = "7211；电子制动控制单元(EBCU)；7200；制动；7255；增压缸";
        attribute :>> actionTerms = "控制；协调；执行；转换；限制";
        attribute :>> objectTerms = "制动力；速度；气动压力";
        attribute :>> expectedFunctionSemantics = "制动力斜率限制;制动协调;车辆加速度计算";
        attribute :>> linkedFunctionIDs = "FN_F_7211_02；FN_F_7211_03；FN_F_7255_01";
        attribute :>> linkedFunctionNames = "协调再生制动与摩擦制动力；执行电空制动控制；将气动压力转换为制动机械力";
        attribute :>> linkedProductIDs = "7211；7255";
        attribute :>> linkedProductNames = "电子制动控制单元(EBCU)；增压缸";
        attribute :>> functionCoverageCount = "3";
        attribute :>> coverageStatus = "PARTIAL";
        attribute :>> derivationReason = "";
        attribute :>> relatedRequirementIDs = "DRV-BRK-001；DRV-BRK-002；DRV-CTL-003；PRJ-BRK-001；REQ-BRK-001；REQ-BRK-002；REQ-BRK-004；REQ-BRK-005；REQ-BRK-006；REQ-BRK-007；REQ-BRK-008；REQ-BRK-009；REQ-BRK-010；REQ-BRK-011；REQ-BRK-012；REQ-BRK-013；REQ-BRK-014；REQ-BRK-015；REQ-ENE-002；REQ-ENE-003";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> modelCoverage = "PARTIAL";
        attribute :>> notes = "当前结果集中尚未形成标准条件下的jerk量化验收指标。";
        attribute :>> evidenceSource = "https://www.gb-gbt.com/PDF/Chinese.aspx/GBT7928-2025";
    }

    requirement req_REQ_BRK_004 : RailRequirementV2 {
        attribute :>> requirementID = "REQ-BRK-004";
        attribute :>> parentRequirementIDs = "";
        attribute :>> requirementLevel = "L1_DOMAIN";
        attribute :>> domain = "制动";
        attribute :>> topicGroup = "BRAKING；REGENERATIVE_BRAKING；SAFETY_PROTECTION";
        attribute :>> name = "电制动与空气制动双制动方式需求";
        attribute :>> text = "列车应具备电制动和空气制动两种制动方式；牵引供电中断或电制动故障时，空气制动仍应使列车安全停车。";
        attribute :>> requirementType = "功能/安全";
        attribute :>> sourceType = "STANDARD_DIRECT";
        attribute :>> standardNo = "GB/T 7928-2025";
        attribute :>> standardClause = "10.1";
        attribute :>> criteria = "双制动方式；空气制动具备相对独立的安全停车能力。";
        attribute :>> applicableConditions = "牵引供电中断或电制动故障等意外工况。";
        attribute :>> keywords = "电制动；空气制动；故障；安全停车；冗余；制动；制动力；制动请求；再生制动；机械制动；摩擦制动；制动协调";
        attribute :>> synonyms = "动力制动；摩擦制动；机械制动；降级制动；刹车；空气制动；气动制动；电制动";
        attribute :>> userPhrases = "我想看制动系统；电制动坏了怎么办；没有再生制动还能不能停车；我想看电制动与空气制动双制动方式需求具体要求；电制动相关的制动要求有哪些；空气制动出现异常时要查什么要求";
        attribute :>> semanticTopics = "BRAKING；REGENERATIVE_BRAKING；SAFETY_PROTECTION";
        attribute :>> systemTerms = "7211；电子制动控制单元(EBCU)；7200；制动；5311；牵引电机；5300；牵引电机及其冷却；7255；增压缸；3130；制动盘；3100；轮轴组成；3131；外轮盘；3132；内轮盘；3133；轴盘";
        attribute :>> actionTerms = "控制；协调；执行；转换；输出；耗散";
        attribute :>> objectTerms = "制动力；机械能；电能；气动压力";
        attribute :>> expectedFunctionSemantics = "电制动输出;机械/空气制动输出;故障降级切换";
        attribute :>> linkedFunctionIDs = "FN_F_7211_02；FN_F_7211_03；FN_F_5311_01；FN_F_7255_01；FN_F_3130_01；FN_F_3131_01；FN_F_3132_01；FN_F_3133_01";
        attribute :>> linkedFunctionNames = "协调再生制动与摩擦制动力；执行电空制动控制；实现三相交流电能与旋转机械能双向转换；将气动压力转换为制动机械力；耗散能量；通过外轮盘耗散机械制动能量；通过内轮盘耗散能量；通过轴盘耗散能量";
        attribute :>> linkedProductIDs = "7211；5311；7255；3130；3131；3132；3133";
        attribute :>> linkedProductNames = "电子制动控制单元(EBCU)；牵引电机；增压缸；制动盘；外轮盘；内轮盘；轴盘";
        attribute :>> functionCoverageCount = "8";
        attribute :>> coverageStatus = "PARTIAL";
        attribute :>> derivationReason = "";
        attribute :>> relatedRequirementIDs = "DRV-BRK-001；DRV-BRK-002；DRV-CTL-003；PRJ-BRK-001；PRJ-ENE-001；PRJ-ENE-002；PRJ-ENE-003；PRJ-ENE-004；REQ-BRK-001；REQ-BRK-002；REQ-BRK-003；REQ-BRK-005；REQ-BRK-006；REQ-BRK-007；REQ-BRK-008；REQ-BRK-009；REQ-BRK-010；REQ-BRK-011；REQ-BRK-012；REQ-BRK-013；REQ-BRK-014；REQ-BRK-015；REQ-ENE-001；REQ-ENE-002；REQ-ENE-003；REQ-ENE-004；REQ-ENE-005；REQ-ENE-006；REQ-ENE-007；REQ-ENE-008；REQ-ENE-009；REQ-TRAC-001；REQ-TRAC-003";
        attribute :>> verificationStatus = "PARTIALLY_VERIFIED";
        attribute :>> modelCoverage = "PARTIAL";
        attribute :>> notes = "当前模型存在电制动与机械制动通路，但未完整执行供电中断/电制动故障场景。";
        attribute :>> evidenceSource = "https://www.gb-gbt.com/PDF/Chinese.aspx/GBT7928-2025";
    }

    requirement req_REQ_BRK_005 : RailRequirementV2 {
        attribute :>> requirementID = "REQ-BRK-005";
        attribute :>> parentRequirementIDs = "";
        attribute :>> requirementLevel = "L1_DOMAIN";
        attribute :>> domain = "制动";
        attribute :>> topicGroup = "BRAKING";
        attribute :>> name = "载荷自适应制动力需求";
        attribute :>> text = "制动系统应具有常用制动、紧急制动功能，并能根据载荷变化自动调整制动力大小。";
        attribute :>> requirementType = "功能";
        attribute :>> sourceType = "STANDARD_DIRECT";
        attribute :>> standardNo = "GB/T 7928-2025";
        attribute :>> standardClause = "10.2";
        attribute :>> criteria = "制动力随车辆载荷变化自动调整。";
        attribute :>> applicableConditions = "车辆载荷变化。";
        attribute :>> keywords = "载荷；制动力；自适应；空重车；常用制动；紧急制动；制动；制动请求；再生制动；机械制动；摩擦制动；空气制动";
        attribute :>> synonyms = "负载补偿；载荷补偿；空重车调整；刹车；摩擦制动；空气制动；气动制动；电制动";
        attribute :>> userPhrases = "我想看制动系统；车辆更重时制动力怎么变；载客量变化怎么办；我想看载荷自适应制动力需求具体要求；载荷相关的制动要求有哪些；制动力出现异常时要查什么要求";
        attribute :>> semanticTopics = "BRAKING";
        attribute :>> systemTerms = "7224；空重车调整阀；7200；制动；7211；电子制动控制单元(EBCU)";
        attribute :>> actionTerms = "检测；分配";
        attribute :>> objectTerms = "制动力";
        attribute :>> expectedFunctionSemantics = "质量/载荷输入;制动需求计算;制动力分配";
        attribute :>> linkedFunctionIDs = "FN_F_7224_01；FN_F_7211_01";
        attribute :>> linkedFunctionNames = "检测空重车调整阀状态；处理制动请求";
        attribute :>> linkedProductIDs = "7224；7211";
        attribute :>> linkedProductNames = "空重车调整阀；电子制动控制单元(EBCU)";
        attribute :>> functionCoverageCount = "2";
        attribute :>> coverageStatus = "PARTIAL";
        attribute :>> derivationReason = "";
        attribute :>> relatedRequirementIDs = "DRV-BRK-001；DRV-BRK-002；DRV-CTL-003；PRJ-BRK-001；REQ-BRK-001；REQ-BRK-002；REQ-BRK-003；REQ-BRK-004；REQ-BRK-006；REQ-BRK-007；REQ-BRK-008；REQ-BRK-009；REQ-BRK-010；REQ-BRK-011；REQ-BRK-012；REQ-BRK-013；REQ-BRK-014；REQ-BRK-015；REQ-ENE-002；REQ-ENE-003";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> modelCoverage = "UNCOVERED";
        attribute :>> notes = "当前最终工况使用固定80 t等效质量，未建立AW0/AW1/AW2/AW3载荷切换。";
        attribute :>> evidenceSource = "https://www.gb-gbt.com/PDF/Chinese.aspx/GBT7928-2025";
    }

    requirement req_REQ_BRK_006 : RailRequirementV2 {
        attribute :>> requirementID = "REQ-BRK-006";
        attribute :>> parentRequirementIDs = "";
        attribute :>> requirementLevel = "L1_DOMAIN";
        attribute :>> domain = "制动";
        attribute :>> topicGroup = "BRAKING；REGENERATIVE_BRAKING";
        attribute :>> name = "常用制动电制动优先需求";
        attribute :>> text = "常用制动应优先利用电制动，并具有冲动限制。";
        attribute :>> requirementType = "功能/控制";
        attribute :>> sourceType = "STANDARD_DIRECT";
        attribute :>> standardNo = "GB/T 7928-2025";
        attribute :>> standardClause = "10.3";
        attribute :>> criteria = "常用制动优先调用电制动；同时限制制动冲动。";
        attribute :>> applicableConditions = "常用制动。";
        attribute :>> keywords = "电制动优先；常用制动；冲动限制；制动力分配；制动；制动力；制动请求；再生制动；机械制动；摩擦制动；空气制动；制动协调";
        attribute :>> synonyms = "动力制动优先；优先电制动；混合制动；刹车；摩擦制动；空气制动；气动制动；电制动";
        attribute :>> userPhrases = "机械制动什么时候介入；制动的电去哪了；我想看制动系统；制动时先用什么；为什么机械制动不先介入；我想看常用制动电制动优先需求具体要求；电制动优先相关的制动要求有哪些";
        attribute :>> semanticTopics = "BRAKING；REGENERATIVE_BRAKING；机械制动";
        attribute :>> systemTerms = "7211；电子制动控制单元(EBCU)；7200；制动；5311；牵引电机；5300；牵引电机及其冷却；7255；增压缸";
        attribute :>> actionTerms = "协调；转换；限制；分配";
        attribute :>> objectTerms = "制动力；机械能；电能；气动压力";
        attribute :>> expectedFunctionSemantics = "电制动能力评估;制动力分配;机械制动补偿";
        attribute :>> linkedFunctionIDs = "FN_F_7211_02；FN_F_5311_01；FN_F_7255_01";
        attribute :>> linkedFunctionNames = "协调再生制动与摩擦制动力；实现三相交流电能与旋转机械能双向转换；将气动压力转换为制动机械力";
        attribute :>> linkedProductIDs = "7211；5311；7255";
        attribute :>> linkedProductNames = "电子制动控制单元(EBCU)；牵引电机；增压缸";
        attribute :>> functionCoverageCount = "3";
        attribute :>> coverageStatus = "FULL";
        attribute :>> derivationReason = "";
        attribute :>> relatedRequirementIDs = "DRV-BRK-001；DRV-BRK-002；DRV-CTL-003；PRJ-BRK-001；PRJ-ENE-001；PRJ-ENE-002；PRJ-ENE-003；PRJ-ENE-004；REQ-BRK-001；REQ-BRK-002；REQ-BRK-003；REQ-BRK-004；REQ-BRK-005；REQ-BRK-007；REQ-BRK-008；REQ-BRK-009；REQ-BRK-010；REQ-BRK-011；REQ-BRK-012；REQ-BRK-013；REQ-BRK-014；REQ-BRK-015；REQ-ENE-001；REQ-ENE-002；REQ-ENE-003；REQ-ENE-004；REQ-ENE-005；REQ-ENE-006；REQ-ENE-007；REQ-ENE-008；REQ-ENE-009；REQ-TRAC-001；REQ-TRAC-003";
        attribute :>> verificationStatus = "PARTIALLY_VERIFIED";
        attribute :>> modelCoverage = "COVERED";
        attribute :>> notes = "当前混合制动逻辑可体现优先电制动，但标准条件下的冲动限制尚未独立验收。";
        attribute :>> evidenceSource = "https://www.gb-gbt.com/PDF/Chinese.aspx/GBT7928-2025";
    }

    requirement req_REQ_BRK_007 : RailRequirementV2 {
        attribute :>> requirementID = "REQ-BRK-007";
        attribute :>> parentRequirementIDs = "";
        attribute :>> requirementLevel = "L1_DOMAIN";
        attribute :>> domain = "制动";
        attribute :>> topicGroup = "BRAKING；REGENERATIVE_BRAKING";
        attribute :>> name = "再生制动优先需求";
        attribute :>> text = "电制动时宜优先采用再生制动。";
        attribute :>> requirementType = "功能/能量";
        attribute :>> sourceType = "STANDARD_DIRECT";
        attribute :>> standardNo = "GB/T 7928-2025";
        attribute :>> standardClause = "10.3";
        attribute :>> criteria = "电制动时优先采用再生制动。";
        attribute :>> applicableConditions = "电制动可用、储能/电网具备可接纳条件时。";
        attribute :>> keywords = "再生制动；电制动；优先；能量回收；制动；制动力；制动请求；机械制动；摩擦制动；空气制动；制动协调；减速度";
        attribute :>> synonyms = "回馈制动；再生优先；电机制动；刹车；摩擦制动；空气制动；气动制动；电制动；制动能量回收；再生能量回收";
        attribute :>> userPhrases = "机械制动什么时候介入；制动的电去哪了；我想看制动系统；只看再生制动；为什么优先回收能量；制动能量去哪；我想看再生制动优先需求具体要求";
        attribute :>> semanticTopics = "BRAKING；REGENERATIVE_BRAKING";
        attribute :>> systemTerms = "7211；电子制动控制单元(EBCU)；7200；制动；5311；牵引电机；5300；牵引电机及其冷却；X121；超级电容模块；X100；车载再生储能；X112；双向DC/DC控制模块";
        attribute :>> actionTerms = "协调；转换；限制；释放；输出；保护；路由";
        attribute :>> objectTerms = "制动力；速度；机械能；电能；放电功率";
        attribute :>> expectedFunctionSemantics = "再生制动能力评估;电机制动输出;能量路由";
        attribute :>> linkedFunctionIDs = "FN_F_7211_02；FN_F_5311_01；FN_F_X121_01；FN_F_X112_02";
        attribute :>> linkedFunctionNames = "协调再生制动与摩擦制动力；实现三相交流电能与旋转机械能双向转换；储存并按需释放再生制动电能；限制储能充放电功率并协调保护";
        attribute :>> linkedProductIDs = "7211；5311；X121；X112";
        attribute :>> linkedProductNames = "电子制动控制单元(EBCU)；牵引电机；超级电容模块；双向DC/DC控制模块";
        attribute :>> functionCoverageCount = "4";
        attribute :>> coverageStatus = "FULL";
        attribute :>> derivationReason = "";
        attribute :>> relatedRequirementIDs = "DRV-BRK-001；DRV-BRK-002；DRV-CTL-003；PRJ-BRK-001；PRJ-ENE-001；PRJ-ENE-002；PRJ-ENE-003；PRJ-ENE-004；REQ-BRK-001；REQ-BRK-002；REQ-BRK-003；REQ-BRK-004；REQ-BRK-005；REQ-BRK-006；REQ-BRK-008；REQ-BRK-009；REQ-BRK-010；REQ-BRK-011；REQ-BRK-012；REQ-BRK-013；REQ-BRK-014；REQ-BRK-015；REQ-ENE-001；REQ-ENE-002；REQ-ENE-003；REQ-ENE-004；REQ-ENE-005；REQ-ENE-006；REQ-ENE-007；REQ-ENE-008；REQ-ENE-009；REQ-TRAC-001；REQ-TRAC-003";
        attribute :>> verificationStatus = "VERIFIED";
        attribute :>> modelCoverage = "COVERED";
        attribute :>> notes = "当前基准模型已形成再生制动→车载储能路径；V&V证据仍应区分项目工况与标准型式试验。";
        attribute :>> evidenceSource = "https://www.gb-gbt.com/PDF/Chinese.aspx/GBT7928-2025";
    }

    requirement req_REQ_BRK_008 : RailRequirementV2 {
        attribute :>> requirementID = "REQ-BRK-008";
        attribute :>> parentRequirementIDs = "";
        attribute :>> requirementLevel = "L1_DOMAIN";
        attribute :>> domain = "制动";
        attribute :>> topicGroup = "BRAKING；REGENERATIVE_BRAKING";
        attribute :>> name = "电空制动平滑转换需求";
        attribute :>> text = "电制动与空气制动应能实现平滑转换。";
        attribute :>> requirementType = "功能/控制";
        attribute :>> sourceType = "STANDARD_DIRECT";
        attribute :>> standardNo = "GB/T 7928-2025";
        attribute :>> standardClause = "10.3";
        attribute :>> criteria = "电制动与空气制动之间平滑过渡，不应出现不可接受的制动力突变。";
        attribute :>> applicableConditions = "混合制动切换、低速退出电制动等过程。";
        attribute :>> keywords = "平滑转换；电空制动；混合制动；低速切换；制动；制动力；制动请求；再生制动；机械制动；摩擦制动；空气制动；制动协调";
        attribute :>> synonyms = "制动力衔接；电空配合；切换平顺；刹车；摩擦制动；空气制动；气动制动；电制动";
        attribute :>> userPhrases = "机械制动什么时候介入；制动的电去哪了；我想看制动系统；电制动切机械制动会不会跳变；低速怎么切换；我想看电空制动平滑转换需求具体要求；平滑转换相关的制动要求有哪些";
        attribute :>> semanticTopics = "BRAKING；REGENERATIVE_BRAKING；电空制动；机械制动";
        attribute :>> systemTerms = "7211；电子制动控制单元(EBCU)；7200；制动；7255；增压缸";
        attribute :>> actionTerms = "控制；协调；执行；转换";
        attribute :>> objectTerms = "制动力；气动压力";
        attribute :>> expectedFunctionSemantics = "制动协调;低速切换;机械制动接管";
        attribute :>> linkedFunctionIDs = "FN_F_7211_02；FN_F_7211_03；FN_F_7255_01";
        attribute :>> linkedFunctionNames = "协调再生制动与摩擦制动力；执行电空制动控制；将气动压力转换为制动机械力";
        attribute :>> linkedProductIDs = "7211；7255";
        attribute :>> linkedProductNames = "电子制动控制单元(EBCU)；增压缸";
        attribute :>> functionCoverageCount = "3";
        attribute :>> coverageStatus = "FULL";
        attribute :>> derivationReason = "";
        attribute :>> relatedRequirementIDs = "DRV-BRK-001；DRV-BRK-002；DRV-CTL-003；PRJ-BRK-001；PRJ-ENE-001；PRJ-ENE-002；PRJ-ENE-003；PRJ-ENE-004；REQ-BRK-001；REQ-BRK-002；REQ-BRK-003；REQ-BRK-004；REQ-BRK-005；REQ-BRK-006；REQ-BRK-007；REQ-BRK-009；REQ-BRK-010；REQ-BRK-011；REQ-BRK-012；REQ-BRK-013；REQ-BRK-014；REQ-BRK-015；REQ-ENE-001；REQ-ENE-002；REQ-ENE-003；REQ-ENE-004；REQ-ENE-005；REQ-ENE-006；REQ-ENE-007；REQ-ENE-008；REQ-ENE-009；REQ-TRAC-001；REQ-TRAC-003";
        attribute :>> verificationStatus = "PARTIALLY_VERIFIED";
        attribute :>> modelCoverage = "COVERED";
        attribute :>> notes = "当前模型存在低速过渡/保持逻辑，已观察到一个0.05 s通信步瞬态后收敛；尚未形成标准化平滑性指标。";
        attribute :>> evidenceSource = "https://www.gb-gbt.com/PDF/Chinese.aspx/GBT7928-2025";
    }

    requirement req_REQ_BRK_009 : RailRequirementV2 {
        attribute :>> requirementID = "REQ-BRK-009";
        attribute :>> parentRequirementIDs = "";
        attribute :>> requirementLevel = "L1_DOMAIN";
        attribute :>> domain = "制动";
        attribute :>> topicGroup = "BRAKING；REGENERATIVE_BRAKING";
        attribute :>> name = "电制动力不足补偿需求";
        attribute :>> text = "电制动力不足时，空气制动应按总制动力要求补充不足的制动力。";
        attribute :>> requirementType = "功能/控制";
        attribute :>> sourceType = "STANDARD_DIRECT";
        attribute :>> standardNo = "GB/T 7928-2025";
        attribute :>> standardClause = "10.3";
        attribute :>> criteria = "F_total需求由电制动与空气/机械制动共同满足；电制动不足量由空气/机械制动补足。";
        attribute :>> applicableConditions = "电制动能力受速度、功率、储能等限制时。";
        attribute :>> keywords = "制动力补偿；电制动力不足；空气制动；机械制动；总制动力；制动；制动力；制动请求；再生制动；摩擦制动；制动协调；减速度";
        attribute :>> synonyms = "混合制动补偿；摩擦制动补足；制动分配；刹车；摩擦制动；空气制动；气动制动；电制动";
        attribute :>> userPhrases = "机械制动什么时候介入；制动的电去哪了；我想看制动系统；再生不够怎么办；我想看电制动力不足补偿需求具体要求；制动力补偿相关的制动要求有哪些；电制动力不足出现异常时要查什么要求";
        attribute :>> semanticTopics = "BRAKING；REGENERATIVE_BRAKING；机械制动";
        attribute :>> systemTerms = "7211；电子制动控制单元(EBCU)；7200；制动；5311；牵引电机；5300；牵引电机及其冷却；7255；增压缸";
        attribute :>> actionTerms = "控制；协调；执行；转换；输出";
        attribute :>> objectTerms = "制动力；速度；机械能；电能；气动压力";
        attribute :>> expectedFunctionSemantics = "总制动力需求;电制动能力评估;剩余制动力计算;机械制动输出";
        attribute :>> linkedFunctionIDs = "FN_F_7211_02；FN_F_7211_03；FN_F_5311_01；FN_F_7255_01";
        attribute :>> linkedFunctionNames = "协调再生制动与摩擦制动力；执行电空制动控制；实现三相交流电能与旋转机械能双向转换；将气动压力转换为制动机械力";
        attribute :>> linkedProductIDs = "7211；5311；7255";
        attribute :>> linkedProductNames = "电子制动控制单元(EBCU)；牵引电机；增压缸";
        attribute :>> functionCoverageCount = "4";
        attribute :>> coverageStatus = "FULL";
        attribute :>> derivationReason = "";
        attribute :>> relatedRequirementIDs = "DRV-BRK-001；DRV-BRK-002；DRV-CTL-003；PRJ-BRK-001；PRJ-ENE-001；PRJ-ENE-002；PRJ-ENE-003；PRJ-ENE-004；REQ-BRK-001；REQ-BRK-002；REQ-BRK-003；REQ-BRK-004；REQ-BRK-005；REQ-BRK-006；REQ-BRK-007；REQ-BRK-008；REQ-BRK-010；REQ-BRK-011；REQ-BRK-012；REQ-BRK-013；REQ-BRK-014；REQ-BRK-015；REQ-ENE-001；REQ-ENE-002；REQ-ENE-003；REQ-ENE-004；REQ-ENE-005；REQ-ENE-006；REQ-ENE-007；REQ-ENE-008；REQ-ENE-009；REQ-TRAC-001；REQ-TRAC-003";
        attribute :>> verificationStatus = "VERIFIED";
        attribute :>> modelCoverage = "COVERED";
        attribute :>> notes = "当前仿真具备电制动与机械制动协调和总制动力跟踪结果。";
        attribute :>> evidenceSource = "https://www.gb-gbt.com/PDF/Chinese.aspx/GBT7928-2025";
    }

    requirement req_REQ_BRK_010 : RailRequirementV2 {
        attribute :>> requirementID = "REQ-BRK-010";
        attribute :>> parentRequirementIDs = "";
        attribute :>> requirementLevel = "L1_DOMAIN";
        attribute :>> domain = "制动";
        attribute :>> topicGroup = "BRAKING";
        attribute :>> name = "防滑功能需求";
        attribute :>> text = "制动系统应具有防滑功能。";
        attribute :>> requirementType = "安全/功能";
        attribute :>> sourceType = "STANDARD_DIRECT";
        attribute :>> standardNo = "GB/T 7928-2025";
        attribute :>> standardClause = "10.5";
        attribute :>> criteria = "具备防滑控制能力。";
        attribute :>> applicableConditions = "低黏着或车轮滑移风险工况。";
        attribute :>> keywords = "防滑；轮滑；黏着；WSP；滑移率；制动；制动力；制动请求；再生制动；机械制动；摩擦制动；空气制动";
        attribute :>> synonyms = "防滑控制；轮对滑行；低黏着；刹车；摩擦制动；空气制动；气动制动；电制动";
        attribute :>> userPhrases = "我想看制动系统；车轮打滑怎么办；制动防滑；我想看防滑功能需求具体要求；防滑相关的制动要求有哪些；轮滑出现异常时要查什么要求";
        attribute :>> semanticTopics = "BRAKING";
        attribute :>> systemTerms = "7211；电子制动控制单元(EBCU)；7200；制动；722A；防滑阀组成；722B；压力传感器";
        attribute :>> actionTerms = "检测；控制；协调；传递";
        attribute :>> objectTerms = "制动力；气动压力";
        attribute :>> expectedFunctionSemantics = "滑移检测;防滑控制;制动力限幅";
        attribute :>> linkedFunctionIDs = "FN_F_7211_04；FN_F_722A_01；FN_F_722B_01";
        attribute :>> linkedFunctionNames = "协调防滑与紧急制动安全请求；传递防滑阀组成气动压力；检测压力传感器状态";
        attribute :>> linkedProductIDs = "7211；722A；722B";
        attribute :>> linkedProductNames = "电子制动控制单元(EBCU)；防滑阀组成；压力传感器";
        attribute :>> functionCoverageCount = "3";
        attribute :>> coverageStatus = "PARTIAL";
        attribute :>> derivationReason = "";
        attribute :>> relatedRequirementIDs = "DRV-BRK-001；DRV-BRK-002；DRV-CTL-003；PRJ-BRK-001；REQ-BRK-001；REQ-BRK-002；REQ-BRK-003；REQ-BRK-004；REQ-BRK-005；REQ-BRK-006；REQ-BRK-007；REQ-BRK-008；REQ-BRK-009；REQ-BRK-011；REQ-BRK-012；REQ-BRK-013；REQ-BRK-014；REQ-BRK-015；REQ-ENE-002；REQ-ENE-003";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> modelCoverage = "UNCOVERED";
        attribute :>> notes = "当前最终模型没有显式轮轨黏着/滑移机制。";
        attribute :>> evidenceSource = "https://www.gb-gbt.com/PDF/Chinese.aspx/GBT7928-2025";
    }

    requirement req_REQ_BRK_011 : RailRequirementV2 {
        attribute :>> requirementID = "REQ-BRK-011";
        attribute :>> parentRequirementIDs = "";
        attribute :>> requirementLevel = "L1_DOMAIN";
        attribute :>> domain = "制动";
        attribute :>> topicGroup = "BRAKING";
        attribute :>> name = "停放制动防溜逸需求";
        attribute :>> text = "在线路最大坡度、最大载荷条件下施加停放制动后，列车不应溜逸，停放制动力应仅通过机械方式产生并传递。";
        attribute :>> requirementType = "安全/功能";
        attribute :>> sourceType = "STANDARD_DIRECT";
        attribute :>> standardNo = "GB/T 7928-2025";
        attribute :>> standardClause = "10.6";
        attribute :>> criteria = "最大坡度+最大载荷下不溜逸；停放制动力为机械方式。";
        attribute :>> applicableConditions = "线路最大坡度；车辆最大载荷。";
        attribute :>> keywords = "停放制动；坡度；最大载荷；防溜逸；机械制动；制动；制动力；制动请求；再生制动；摩擦制动；空气制动；制动协调";
        attribute :>> synonyms = "驻车制动；停车保持；坡道保持；刹车；摩擦制动；空气制动；气动制动；电制动";
        attribute :>> userPhrases = "我想看制动系统；坡道停车会不会溜车；停放制动能不能保持；我想看停放制动防溜逸需求具体要求；停放制动相关的制动要求有哪些；坡度出现异常时要查什么要求";
        attribute :>> semanticTopics = "BRAKING；机械制动";
        attribute :>> systemTerms = "7211；电子制动控制单元(EBCU)；7200；制动；7255；增压缸";
        attribute :>> actionTerms = "协调；传递；转换";
        attribute :>> objectTerms = "制动力；气动压力";
        attribute :>> expectedFunctionSemantics = "停车保持;机械制动力生成;坡度阻力计算";
        attribute :>> linkedFunctionIDs = "FN_F_7211_04；FN_F_7255_01";
        attribute :>> linkedFunctionNames = "协调防滑与紧急制动安全请求；将气动压力转换为制动机械力";
        attribute :>> linkedProductIDs = "7211；7255";
        attribute :>> linkedProductNames = "电子制动控制单元(EBCU)；增压缸";
        attribute :>> functionCoverageCount = "2";
        attribute :>> coverageStatus = "PARTIAL";
        attribute :>> derivationReason = "";
        attribute :>> relatedRequirementIDs = "DRV-BRK-001；DRV-BRK-002；DRV-CTL-003；PRJ-BRK-001；REQ-BRK-001；REQ-BRK-002；REQ-BRK-003；REQ-BRK-004；REQ-BRK-005；REQ-BRK-006；REQ-BRK-007；REQ-BRK-008；REQ-BRK-009；REQ-BRK-010；REQ-BRK-012；REQ-BRK-013；REQ-BRK-014；REQ-BRK-015；REQ-ENE-002；REQ-ENE-003";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> modelCoverage = "PARTIAL";
        attribute :>> notes = "当前有停车保持阶段，但没有坡度模型和最大载荷工况，不能判定该标准需求PASS。";
        attribute :>> evidenceSource = "https://www.gb-gbt.com/PDF/Chinese.aspx/GBT7928-2025";
    }

    requirement req_REQ_BRK_012 : RailRequirementV2 {
        attribute :>> requirementID = "REQ-BRK-012";
        attribute :>> parentRequirementIDs = "";
        attribute :>> requirementLevel = "L1_DOMAIN";
        attribute :>> domain = "制动";
        attribute :>> topicGroup = "BRAKING";
        attribute :>> name = "空气系统气密性需求";
        attribute :>> text = "空气系统应满足规定的气密性要求。";
        attribute :>> requirementType = "性能/安全";
        attribute :>> sourceType = "STANDARD_DIRECT";
        attribute :>> standardNo = "GB/T 7928-2025";
        attribute :>> standardClause = "10.9";
        attribute :>> criteria = "关闭气路5 min后总风压力下降≤20 kPa；制动缸及制动储风缸3 min压力下降≤10 kPa。";
        attribute :>> applicableConditions = "按GB/T 14894规定的气密性试验方法。";
        attribute :>> keywords = "气密性；总风；制动缸；储风缸；压力下降；制动；制动力；制动请求；再生制动；机械制动；摩擦制动；空气制动";
        attribute :>> synonyms = "漏气；风压保持；压力衰减；刹车；摩擦制动；空气制动；气动制动；电制动";
        attribute :>> userPhrases = "我想看制动系统；制动系统漏不漏气；风压能保持多久；我想看空气系统气密性需求具体要求；气密性相关的制动要求有哪些；总风出现异常时要查什么要求";
        attribute :>> semanticTopics = "BRAKING";
        attribute :>> systemTerms = "7142；总风管压力传感器；7100；供风；7131；总风管";
        attribute :>> actionTerms = "检测；监测；传递";
        attribute :>> objectTerms = "制动力；气动压力；总风管";
        attribute :>> expectedFunctionSemantics = "气压状态;泄漏模型;压力监测";
        attribute :>> linkedFunctionIDs = "FN_F_7142_01；FN_F_7131_01；FN_F_7100_01";
        attribute :>> linkedFunctionNames = "检测总风管压力传感器状态；传递总风管气动压力；传递能量/介质、检测运行参数";
        attribute :>> linkedProductIDs = "7142；7131；7100";
        attribute :>> linkedProductNames = "总风管压力传感器；总风管；供风";
        attribute :>> functionCoverageCount = "3";
        attribute :>> coverageStatus = "PARTIAL";
        attribute :>> derivationReason = "";
        attribute :>> relatedRequirementIDs = "DRV-BRK-001；DRV-BRK-002；DRV-CTL-003；PRJ-BRK-001；REQ-BRK-001；REQ-BRK-002；REQ-BRK-003；REQ-BRK-004；REQ-BRK-005；REQ-BRK-006；REQ-BRK-007；REQ-BRK-008；REQ-BRK-009；REQ-BRK-010；REQ-BRK-011；REQ-BRK-013；REQ-BRK-014；REQ-BRK-015；REQ-ENE-002；REQ-ENE-003";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> modelCoverage = "UNCOVERED";
        attribute :>> notes = "当前最终模型没有空气系统泄漏/气密性物理模型。";
        attribute :>> evidenceSource = "https://www.gb-gbt.com/PDF/Chinese.aspx/GBT7928-2025";
    }

    requirement req_REQ_BRK_013 : RailRequirementV2 {
        attribute :>> requirementID = "REQ-BRK-013";
        attribute :>> parentRequirementIDs = "";
        attribute :>> requirementLevel = "L1_DOMAIN";
        attribute :>> domain = "制动";
        attribute :>> topicGroup = "BRAKING";
        attribute :>> name = "制动缸压力控制精度需求";
        attribute :>> text = "基础制动装置的制动缸压力实际值与设计值应满足允许误差要求。";
        attribute :>> requirementType = "性能";
        attribute :>> sourceType = "STANDARD_DIRECT";
        attribute :>> standardNo = "GB/T 7928-2025";
        attribute :>> standardClause = "10.10";
        attribute :>> criteria = "制动缸压力实际值与设计值允许误差 ±20 kPa。";
        attribute :>> applicableConditions = "基础制动装置压力控制。";
        attribute :>> keywords = "制动缸；压力；控制精度；20kPa；反馈；制动；制动力；制动请求；再生制动；机械制动；摩擦制动；空气制动";
        attribute :>> synonyms = "制动压力；风压误差；压力跟踪；刹车；摩擦制动；空气制动；气动制动；电制动";
        attribute :>> userPhrases = "我想看制动系统；制动缸压力准不准；压力误差多少；我想看制动缸压力控制精度需求具体要求；制动缸相关的制动要求有哪些；压力出现异常时要查什么要求";
        attribute :>> semanticTopics = "BRAKING";
        attribute :>> systemTerms = "722B；压力传感器；7200；制动；722C；压力开关；7255；增压缸";
        attribute :>> actionTerms = "检测；控制；转换；反馈";
        attribute :>> objectTerms = "制动力；气动压力";
        attribute :>> expectedFunctionSemantics = "制动压力目标;气压动态;压力反馈";
        attribute :>> linkedFunctionIDs = "FN_F_722B_01；FN_F_722C_01；FN_F_7255_01";
        attribute :>> linkedFunctionNames = "检测压力传感器状态；检测压力开关状态；将气动压力转换为制动机械力";
        attribute :>> linkedProductIDs = "722B；722C；7255";
        attribute :>> linkedProductNames = "压力传感器；压力开关；增压缸";
        attribute :>> functionCoverageCount = "3";
        attribute :>> coverageStatus = "PARTIAL";
        attribute :>> derivationReason = "";
        attribute :>> relatedRequirementIDs = "DRV-BRK-001；DRV-BRK-002；DRV-CTL-003；PRJ-BRK-001；REQ-BRK-001；REQ-BRK-002；REQ-BRK-003；REQ-BRK-004；REQ-BRK-005；REQ-BRK-006；REQ-BRK-007；REQ-BRK-008；REQ-BRK-009；REQ-BRK-010；REQ-BRK-011；REQ-BRK-012；REQ-BRK-014；REQ-BRK-015；REQ-ENE-002；REQ-ENE-003";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> modelCoverage = "PARTIAL";
        attribute :>> notes = "模型包含压力相关动态参数，但尚未形成按±20 kPa判据的正式V&V指标。";
        attribute :>> evidenceSource = "https://www.gb-gbt.com/PDF/Chinese.aspx/GBT7928-2025";
    }

    requirement req_REQ_BRK_014 : RailRequirementV2 {
        attribute :>> requirementID = "REQ-BRK-014";
        attribute :>> parentRequirementIDs = "";
        attribute :>> requirementLevel = "L1_DOMAIN";
        attribute :>> domain = "制动";
        attribute :>> topicGroup = "BRAKING；SAFETY_PROTECTION";
        attribute :>> name = "制动辅助诊断与记录需求";
        attribute :>> text = "制动系统应具有轮径校正、负载检测、故障诊断和记录功能。";
        attribute :>> requirementType = "功能/诊断";
        attribute :>> sourceType = "STANDARD_DIRECT";
        attribute :>> standardNo = "GB/T 7928-2025";
        attribute :>> standardClause = "10.13";
        attribute :>> criteria = "具备轮径校正、负载检测、故障诊断、故障记录。";
        attribute :>> applicableConditions = "制动系统运行与维护。";
        attribute :>> keywords = "轮径校正；负载检测；故障诊断；故障记录；状态监测；制动；制动力；制动请求；再生制动；机械制动；摩擦制动；空气制动";
        attribute :>> synonyms = "制动诊断；状态记录；故障日志；刹车；摩擦制动；空气制动；气动制动；电制动";
        attribute :>> userPhrases = "我想看制动系统；制动故障怎么发现；能不能记录故障；轮径变化怎么办；我想看制动辅助诊断与记录需求具体要求；轮径校正相关的制动要求有哪些；负载检测出现异常时要查什么要求";
        attribute :>> semanticTopics = "BRAKING；SAFETY_PROTECTION";
        attribute :>> systemTerms = "8152；制动安全回路；8100；列车主干网及安全回路；8128；输入输出单元；722B；压力传感器；7200；制动；722C；压力开关";
        attribute :>> actionTerms = "检测；监测；执行；输出；报告；路由；采集";
        attribute :>> objectTerms = "制动力；运行状态；安全回路";
        attribute :>> expectedFunctionSemantics = "状态采集;故障判断;事件记录";
        attribute :>> linkedFunctionIDs = "FN_F_8152_01；FN_F_8152_02；FN_F_8128_01；FN_F_722B_01；FN_F_722C_01";
        attribute :>> linkedFunctionNames = "执行制动安全回路安全逻辑；报告制动安全回路运行状态；路由输入输出单元输入输出信号；检测压力传感器状态；检测压力开关状态";
        attribute :>> linkedProductIDs = "8152；8128；722B；722C";
        attribute :>> linkedProductNames = "制动安全回路；输入输出单元；压力传感器；压力开关";
        attribute :>> functionCoverageCount = "5";
        attribute :>> coverageStatus = "PARTIAL";
        attribute :>> derivationReason = "";
        attribute :>> relatedRequirementIDs = "DRV-BRK-001；DRV-BRK-002；DRV-CTL-003；PRJ-BRK-001；REQ-BRK-001；REQ-BRK-002；REQ-BRK-003；REQ-BRK-004；REQ-BRK-005；REQ-BRK-006；REQ-BRK-007；REQ-BRK-008；REQ-BRK-009；REQ-BRK-010；REQ-BRK-011；REQ-BRK-012；REQ-BRK-013；REQ-BRK-015；REQ-ENE-002；REQ-ENE-003";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> modelCoverage = "PARTIAL";
        attribute :>> notes = "当前任务模型可扩展状态接口，但未完成全套诊断/记录功能验证。";
        attribute :>> evidenceSource = "https://www.gb-gbt.com/PDF/Chinese.aspx/GBT7928-2025";
    }

    requirement req_REQ_BRK_015 : RailRequirementV2 {
        attribute :>> requirementID = "REQ-BRK-015";
        attribute :>> parentRequirementIDs = "";
        attribute :>> requirementLevel = "L1_DOMAIN";
        attribute :>> domain = "制动";
        attribute :>> topicGroup = "BRAKING；REGENERATIVE_BRAKING；SAFETY_PROTECTION";
        attribute :>> name = "电制动完全失效降级需求";
        attribute :>> text = "所有电制动停止工作时，空气制动系统及空气驱动部件应维持规定的安全运行和制动能力。";
        attribute :>> requirementType = "安全/故障";
        attribute :>> sourceType = "STANDARD_DIRECT";
        attribute :>> standardNo = "GB/T 7928-2025";
        attribute :>> standardClause = "10.14";
        attribute :>> criteria = "超员工况下可在基础制动热容量允许速度下运行一个往返；制动系统保持设计的常用制动减速度及紧急制动减速度。";
        attribute :>> applicableConditions = "所有电制动停止工作；超员工况。";
        attribute :>> keywords = "电制动失效；降级；空气制动；常用制动；紧急制动；故障；制动；制动力；制动请求；再生制动；机械制动；摩擦制动";
        attribute :>> synonyms = "电制动全失效；失效安全；故障降级；刹车；摩擦制动；空气制动；气动制动；电制动";
        attribute :>> userPhrases = "我想看制动系统；所有电制动都坏了怎么办；还能不能正常停车；我想看电制动完全失效降级需求具体要求；电制动失效相关的制动要求有哪些；降级出现异常时要查什么要求";
        attribute :>> semanticTopics = "BRAKING；REGENERATIVE_BRAKING；SAFETY_PROTECTION";
        attribute :>> systemTerms = "7211；电子制动控制单元(EBCU)；7200；制动；7226；紧急制动阀；7255；增压缸；8152；制动安全回路；8100；列车主干网及安全回路";
        attribute :>> actionTerms = "检测；协调；执行；转换；隔离";
        attribute :>> objectTerms = "制动力；气动压力；安全回路";
        attribute :>> expectedFunctionSemantics = "故障检测;电制动切除;空气制动接管;降级制动";
        attribute :>> linkedFunctionIDs = "FN_F_7211_04；FN_F_7226_01；FN_F_7255_01；FN_F_8152_01";
        attribute :>> linkedFunctionNames = "协调防滑与紧急制动安全请求；执行紧急制动气动隔离与施加；将气动压力转换为制动机械力；执行制动安全回路安全逻辑";
        attribute :>> linkedProductIDs = "7211；7226；7255；8152";
        attribute :>> linkedProductNames = "电子制动控制单元(EBCU)；紧急制动阀；增压缸；制动安全回路";
        attribute :>> functionCoverageCount = "4";
        attribute :>> coverageStatus = "PARTIAL";
        attribute :>> derivationReason = "";
        attribute :>> relatedRequirementIDs = "DRV-BRK-001；DRV-BRK-002；DRV-CTL-003；PRJ-BRK-001；PRJ-ENE-001；PRJ-ENE-002；PRJ-ENE-003；PRJ-ENE-004；REQ-BRK-001；REQ-BRK-002；REQ-BRK-003；REQ-BRK-004；REQ-BRK-005；REQ-BRK-006；REQ-BRK-007；REQ-BRK-008；REQ-BRK-009；REQ-BRK-010；REQ-BRK-011；REQ-BRK-012；REQ-BRK-013；REQ-BRK-014；REQ-ENE-001；REQ-ENE-002；REQ-ENE-003；REQ-ENE-004；REQ-ENE-005；REQ-ENE-006；REQ-ENE-007；REQ-ENE-008；REQ-ENE-009；REQ-TRAC-001；REQ-TRAC-003";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> modelCoverage = "PARTIAL";
        attribute :>> notes = "当前基准工况未执行全部电制动失效故障场景。";
        attribute :>> evidenceSource = "https://www.gb-gbt.com/PDF/Chinese.aspx/GBT7928-2025";
    }

    requirement req_REQ_ENE_001 : RailRequirementV2 {
        attribute :>> requirementID = "REQ-ENE-001";
        attribute :>> parentRequirementIDs = "";
        attribute :>> requirementLevel = "L1_DOMAIN";
        attribute :>> domain = "能量回收";
        attribute :>> topicGroup = "ENERGY_STORAGE";
        attribute :>> name = "电容式储能电源储存功能需求";
        attribute :>> text = "电容式储能电源应具有能量储存功能，并满足规定的储存能量和储存电压范围。";
        attribute :>> requirementType = "功能/性能";
        attribute :>> sourceType = "STANDARD_DIRECT";
        attribute :>> standardNo = "GB/T 42005.1-2022";
        attribute :>> standardClause = "5.2.1";
        attribute :>> criteria = "储存能量为标称能量的100%～120%；储存电压范围宜采用500～900 V。";
        attribute :>> applicableConditions = "适用于采用双电层电容器或混合型电容器的储能式电车动力储能电源；本项目作为X100子系统参考。";
        attribute :>> keywords = "超级电容；储能；储存能量；500V；900V；能量回收；再生能量；SOC；充电；放电；储能功率；储能状态";
        attribute :>> synonyms = "电容储能；车载储能；储能电源；超级电容器；超容；回馈制动；制动能量回收";
        attribute :>> userPhrases = "我想看再生制动；制动的电去哪了；超级电容SOC上限；超级电容能存多少；储能电压范围；只看储能系统；我想看电容式储能电源储存功能需求具体要求";
        attribute :>> semanticTopics = "ENERGY_STORAGE";
        attribute :>> systemTerms = "X100；车载再生储能；X110；双向储能变流及控制；X111；双向DC/DC变流模块";
        attribute :>> actionTerms = "控制；执行；转换；吸收；存储；释放；反馈；保护";
        attribute :>> objectTerms = "超级电容；SOC；电压";
        attribute :>> expectedFunctionSemantics = "吸收再生能量;储存能量;SOC/电压状态更新";
        attribute :>> linkedFunctionIDs = "FN_F_X100_01；FN_F_X110_01；FN_F_X111_01；FN_F_X111_02";
        attribute :>> linkedFunctionNames = "吸收、存储并按需释放再生制动能量；实现再生储能双向能量变换、控制与保护；实现中间直流母线与储能侧直流母线双向能量转换；执行双向DC/DC功率变换指令并反馈状态";
        attribute :>> linkedProductIDs = "X100；X110；X111";
        attribute :>> linkedProductNames = "车载再生储能；双向储能变流及控制；双向DC/DC变流模块";
        attribute :>> functionCoverageCount = "4";
        attribute :>> coverageStatus = "FULL";
        attribute :>> derivationReason = "";
        attribute :>> relatedRequirementIDs = "PRJ-ENE-001；PRJ-ENE-002；PRJ-ENE-003；PRJ-ENE-004；REQ-BRK-004；REQ-BRK-006；REQ-BRK-007；REQ-BRK-008；REQ-BRK-009；REQ-BRK-015；REQ-ENE-002；REQ-ENE-003；REQ-ENE-004；REQ-ENE-005；REQ-ENE-006；REQ-ENE-007；REQ-ENE-008；REQ-ENE-009；REQ-TRAC-001；REQ-TRAC-003";
        attribute :>> verificationStatus = "PARTIALLY_VERIFIED";
        attribute :>> modelCoverage = "COVERED";
        attribute :>> notes = "当前模型Vmin=500 V、Vmax=900 V与该条款的宜用范围一致；未进行标准规定的完整产品试验。";
        attribute :>> evidenceSource = "https://www.bzxz.net/bzxz/208403.html";
    }

    requirement req_REQ_ENE_002 : RailRequirementV2 {
        attribute :>> requirementID = "REQ-ENE-002";
        attribute :>> parentRequirementIDs = "";
        attribute :>> requirementLevel = "L1_DOMAIN";
        attribute :>> domain = "能量回收";
        attribute :>> topicGroup = "ENERGY_STORAGE；SAFETY_PROTECTION";
        attribute :>> name = "储能故障检测、记录与输出需求";
        attribute :>> text = "储能电源应具有故障检测功能，故障应能实时传送给车辆，并应具有故障记录储存和读取功能。";
        attribute :>> requirementType = "功能/诊断";
        attribute :>> sourceType = "STANDARD_DIRECT";
        attribute :>> standardNo = "GB/T 42005.1-2022";
        attribute :>> standardClause = "5.2.2";
        attribute :>> criteria = "故障检测；实时上传车辆；故障记录可储存并由上位机读取。";
        attribute :>> applicableConditions = "X100储能子系统。";
        attribute :>> keywords = "储能故障；故障检测；故障记录；状态输出；上位机；储能；再生能量；超级电容；SOC；充电；放电；储能功率";
        attribute :>> synonyms = "储能诊断；故障日志；故障上传；车载储能；超级电容器；超容；电容储能；回馈制动；制动能量回收";
        attribute :>> userPhrases = "储能坏了怎么办；储能坏了怎么发现；故障能不能记录；X100状态怎么上传；我想看储能故障检测、记录与输出需求具体要求；储能故障相关的能量回收要求有哪些；故障检测出现异常时要查什么要求";
        attribute :>> semanticTopics = "ENERGY_STORAGE；SAFETY_PROTECTION";
        attribute :>> systemTerms = "X113；双向DC/DC检测保护组件；X100；车载再生储能；X112；双向DC/DC控制模块；8122；车辆控制单元；8100；列车主干网及安全回路";
        attribute :>> actionTerms = "检测；控制；限制；输出；报告；保护";
        attribute :>> objectTerms = "超级电容；SOC；故障状态";
        attribute :>> expectedFunctionSemantics = "故障检测;故障状态输出;事件记录";
        attribute :>> linkedFunctionIDs = "FN_F_X113_01；FN_F_X112_03；FN_F_8122_03";
        attribute :>> linkedFunctionNames = "检测双向DC/DC检测保护组件状态；报告储能变换系统状态；限制并保护车辆控制单元运行";
        attribute :>> linkedProductIDs = "X113；X112；8122";
        attribute :>> linkedProductNames = "双向DC/DC检测保护组件；双向DC/DC控制模块；车辆控制单元";
        attribute :>> functionCoverageCount = "3";
        attribute :>> coverageStatus = "PARTIAL";
        attribute :>> derivationReason = "";
        attribute :>> relatedRequirementIDs = "DRV-BRK-002；DRV-CTL-003；PRJ-BRK-001；PRJ-ENE-001；PRJ-ENE-002；PRJ-ENE-003；PRJ-ENE-004；REQ-BRK-001；REQ-BRK-002；REQ-BRK-003；REQ-BRK-004；REQ-BRK-005；REQ-BRK-006；REQ-BRK-007；REQ-BRK-008；REQ-BRK-009；REQ-BRK-010；REQ-BRK-011；REQ-BRK-012；REQ-BRK-013；REQ-BRK-014；REQ-BRK-015；REQ-ENE-001；REQ-ENE-003；REQ-ENE-004；REQ-ENE-005；REQ-ENE-006；REQ-ENE-007；REQ-ENE-008；REQ-ENE-009；REQ-TRAC-001；REQ-TRAC-003";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> modelCoverage = "PARTIAL";
        attribute :>> notes = "当前模型有状态量和可用性语义，但未完成标准所述故障记录/上位机读取闭环。";
        attribute :>> evidenceSource = "https://www.bzxz.net/bzxz/208403.html";
    }

    requirement req_REQ_ENE_003 : RailRequirementV2 {
        attribute :>> requirementID = "REQ-ENE-003";
        attribute :>> parentRequirementIDs = "";
        attribute :>> requirementLevel = "L1_DOMAIN";
        attribute :>> domain = "能量回收";
        attribute :>> topicGroup = "ENERGY_STORAGE；SAFETY_PROTECTION";
        attribute :>> name = "储能通信需求";
        attribute :>> text = "储能电源应具备内部和外部通信能力，状态参数及故障信息应能够传递至电源管理系统和车辆。";
        attribute :>> requirementType = "接口/功能";
        attribute :>> sourceType = "STANDARD_DIRECT";
        attribute :>> standardNo = "GB/T 42005.1-2022";
        attribute :>> standardClause = "5.2.3";
        attribute :>> criteria = "模组电压、温度等信息可内部通信；储能状态参数及故障信息可通过外部通信网络发送给车辆。";
        attribute :>> applicableConditions = "X100储能子系统。";
        attribute :>> keywords = "通信；状态参数；故障信息；电压；温度；接口；储能；再生能量；超级电容；SOC；充电；放电";
        attribute :>> synonyms = "状态反馈；储能通信；信息上传；车载储能；超级电容器；超容；电容储能；回馈制动；制动能量回收";
        attribute :>> userPhrases = "我想看再生制动；制动的电去哪了；超级电容SOC上限；SOC怎么传给控制器；储能状态怎么输出；故障信息怎么传；我想看储能通信需求具体要求";
        attribute :>> semanticTopics = "ENERGY_STORAGE；SAFETY_PROTECTION";
        attribute :>> systemTerms = "X121；超级电容模块；X100；车载再生储能；X112；双向DC/DC控制模块；8122；车辆控制单元；8100；列车主干网及安全回路；8128；输入输出单元";
        attribute :>> actionTerms = "控制；传递；限制；输出；报告；反馈；保护；提供；采集";
        attribute :>> objectTerms = "超级电容；SOC；电压；运行状态";
        attribute :>> expectedFunctionSemantics = "状态量采集;SOC/电压/可用功率输出;通信接口";
        attribute :>> linkedFunctionIDs = "FN_F_X121_02；FN_F_X112_03；FN_F_8122_03；FN_F_8128_03";
        attribute :>> linkedFunctionNames = "提供超级电容荷电状态反馈；报告储能变换系统状态；限制并保护车辆控制单元运行；报告输入输出单元运行状态";
        attribute :>> linkedProductIDs = "X121；X112；8122；8128";
        attribute :>> linkedProductNames = "超级电容模块；双向DC/DC控制模块；车辆控制单元；输入输出单元";
        attribute :>> functionCoverageCount = "4";
        attribute :>> coverageStatus = "FULL";
        attribute :>> derivationReason = "";
        attribute :>> relatedRequirementIDs = "DRV-BRK-002；DRV-CTL-003；PRJ-BRK-001；PRJ-ENE-001；PRJ-ENE-002；PRJ-ENE-003；PRJ-ENE-004；REQ-BRK-001；REQ-BRK-002；REQ-BRK-003；REQ-BRK-004；REQ-BRK-005；REQ-BRK-006；REQ-BRK-007；REQ-BRK-008；REQ-BRK-009；REQ-BRK-010；REQ-BRK-011；REQ-BRK-012；REQ-BRK-013；REQ-BRK-014；REQ-BRK-015；REQ-ENE-001；REQ-ENE-002；REQ-ENE-004；REQ-ENE-005；REQ-ENE-006；REQ-ENE-007；REQ-ENE-008；REQ-ENE-009；REQ-TRAC-001；REQ-TRAC-003";
        attribute :>> verificationStatus = "PARTIALLY_VERIFIED";
        attribute :>> modelCoverage = "COVERED";
        attribute :>> notes = "当前模型已有SOC/功率/状态等信号接口，未建立真实列车通信网络协议层。";
        attribute :>> evidenceSource = "https://www.bzxz.net/bzxz/208403.html";
    }

    requirement req_REQ_ENE_004 : RailRequirementV2 {
        attribute :>> requirementID = "REQ-ENE-004";
        attribute :>> parentRequirementIDs = "";
        attribute :>> requirementLevel = "L1_DOMAIN";
        attribute :>> domain = "能量回收";
        attribute :>> topicGroup = "ENERGY_STORAGE";
        attribute :>> name = "储能电压均衡需求";
        attribute :>> text = "储能电源应具有单体及模组间电压均衡功能，并满足规定的电压一致性要求。";
        attribute :>> requirementType = "功能/性能";
        attribute :>> sourceType = "STANDARD_DIRECT";
        attribute :>> standardNo = "GB/T 42005.1-2022";
        attribute :>> standardClause = "5.2.4";
        attribute :>> criteria = "额定电压时：双电层电容器单体电压与平均电压之差绝对值≤0.15 V；混合型电容器≤0.1 V。";
        attribute :>> applicableConditions = "额定电压；按储能单元类型选择判据。";
        attribute :>> keywords = "电压均衡；单体电压；模组；0.15V；0.1V；储能；再生能量；超级电容；SOC；充电；放电；储能功率";
        attribute :>> synonyms = "均压；一致性；单体压差；车载储能；超级电容器；超容；电容储能；回馈制动；制动能量回收";
        attribute :>> userPhrases = "超级电容单体电压一致吗；怎么均压；我想看储能电压均衡需求具体要求；电压均衡相关的能量回收要求有哪些；单体电压出现异常时要查什么要求";
        attribute :>> semanticTopics = "ENERGY_STORAGE";
        attribute :>> systemTerms = "X122；超级电容电压传感器；X100；车载再生储能；X112；双向DC/DC控制模块";
        attribute :>> actionTerms = "检测；监测；控制";
        attribute :>> objectTerms = "超级电容；SOC；电压";
        attribute :>> expectedFunctionSemantics = "单体电压监测;均衡控制";
        attribute :>> linkedFunctionIDs = "FN_F_X122_01；FN_F_X112_01";
        attribute :>> linkedFunctionNames = "检测超级电容电压传感器状态；控制双向DC/DC功率变换";
        attribute :>> linkedProductIDs = "X122；X112";
        attribute :>> linkedProductNames = "超级电容电压传感器；双向DC/DC控制模块";
        attribute :>> functionCoverageCount = "2";
        attribute :>> coverageStatus = "PARTIAL";
        attribute :>> derivationReason = "";
        attribute :>> relatedRequirementIDs = "PRJ-ENE-001；PRJ-ENE-002；PRJ-ENE-003；PRJ-ENE-004；REQ-BRK-004；REQ-BRK-006；REQ-BRK-007；REQ-BRK-008；REQ-BRK-009；REQ-BRK-015；REQ-ENE-001；REQ-ENE-002；REQ-ENE-003；REQ-ENE-005；REQ-ENE-006；REQ-ENE-007；REQ-ENE-008；REQ-ENE-009；REQ-TRAC-001；REQ-TRAC-003";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> modelCoverage = "UNCOVERED";
        attribute :>> notes = "当前X100为系统级等效模型，未建模单体/模组电压均衡。";
        attribute :>> evidenceSource = "https://www.bzxz.net/bzxz/208403.html";
    }

    requirement req_REQ_ENE_005 : RailRequirementV2 {
        attribute :>> requirementID = "REQ-ENE-005";
        attribute :>> parentRequirementIDs = "";
        attribute :>> requirementLevel = "L1_DOMAIN";
        attribute :>> domain = "能量回收";
        attribute :>> topicGroup = "ENERGY_STORAGE";
        attribute :>> name = "储能能量效率需求";
        attribute :>> text = "电容式储能电源的充放电能量效率应达到规定要求。";
        attribute :>> requirementType = "性能";
        attribute :>> sourceType = "STANDARD_DIRECT";
        attribute :>> standardNo = "GB/T 42005.1-2022";
        attribute :>> standardClause = "5.3.4";
        attribute :>> criteria = "双电层电容器能量效率≥93%；混合型电容器能量效率≥90%。";
        attribute :>> applicableConditions = "按标准规定的充放电试验条件与储能单元类型。";
        attribute :>> keywords = "能量效率；充电能量；放电能量；93%；90%；损耗；储能；再生能量；超级电容；SOC；充电；放电";
        attribute :>> synonyms = "回收效率；储能效率；能量损失；车载储能；超级电容器；超容；电容储能；回馈制动；制动能量回收";
        attribute :>> userPhrases = "我想看再生制动；制动的电去哪了；超级电容SOC上限；回收能量损失多少；超级电容效率够不够；我想看储能能量效率需求具体要求；能量效率相关的能量回收要求有哪些";
        attribute :>> semanticTopics = "ENERGY_STORAGE";
        attribute :>> systemTerms = "X121；超级电容模块；X100；车载再生储能；X112；双向DC/DC控制模块；8166；能量计；8100；列车主干网及安全回路";
        attribute :>> actionTerms = "控制；协调；释放；报告；统计";
        attribute :>> objectTerms = "电能；放电功率；超级电容；SOC；运行状态";
        attribute :>> expectedFunctionSemantics = "充放电功率积分;能量损耗计算;效率计算";
        attribute :>> linkedFunctionIDs = "FN_F_X121_01；FN_F_X112_01；FN_F_8166_01；FN_F_8166_02；FN_F_8166_03；FN_F_8166_04";
        attribute :>> linkedFunctionNames = "储存并按需释放再生制动电能；控制双向DC/DC功率变换；控制能量计运行；协调能量计接口交互；报告能量计运行状态；统计能量计运行数据";
        attribute :>> linkedProductIDs = "X121；X112；8166";
        attribute :>> linkedProductNames = "超级电容模块；双向DC/DC控制模块；能量计";
        attribute :>> functionCoverageCount = "6";
        attribute :>> coverageStatus = "PARTIAL";
        attribute :>> derivationReason = "";
        attribute :>> relatedRequirementIDs = "PRJ-ENE-001；PRJ-ENE-002；PRJ-ENE-003；PRJ-ENE-004；REQ-BRK-004；REQ-BRK-006；REQ-BRK-007；REQ-BRK-008；REQ-BRK-009；REQ-BRK-015；REQ-ENE-001；REQ-ENE-002；REQ-ENE-003；REQ-ENE-004；REQ-ENE-006；REQ-ENE-007；REQ-ENE-008；REQ-ENE-009；REQ-TRAC-001；REQ-TRAC-003";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> modelCoverage = "PARTIAL";
        attribute :>> notes = "当前模型包含DC/DC效率参数，但尚未按标准定义的充放电能量效率试验进行独立V&V。";
        attribute :>> evidenceSource = "https://www.bzxz.net/bzxz/208403.html";
    }

    requirement req_REQ_ENE_006 : RailRequirementV2 {
        attribute :>> requirementID = "REQ-ENE-006";
        attribute :>> parentRequirementIDs = "";
        attribute :>> requirementLevel = "L1_DOMAIN";
        attribute :>> domain = "能量回收";
        attribute :>> topicGroup = "ENERGY_STORAGE";
        attribute :>> name = "储能温度一致性需求";
        attribute :>> text = "储能电源工作过程中最高工作温度及单体温差应满足规定要求。";
        attribute :>> requirementType = "性能/安全";
        attribute :>> sourceType = "STANDARD_DIRECT";
        attribute :>> standardNo = "GB/T 42005.1-2022";
        attribute :>> standardClause = "5.3.8";
        attribute :>> criteria = "最高工作温度≤55 ℃；同一时刻最高单体温度与最低单体温度差≤15 ℃。";
        attribute :>> applicableConditions = "储能电源工作过程。";
        attribute :>> keywords = "温度；55℃；温差；15℃；热管理；储能；再生能量；超级电容；SOC；充电；放电；储能功率";
        attribute :>> synonyms = "温度一致性；热管理；过热；车载储能；超级电容器；超容；电容储能；回馈制动；制动能量回收";
        attribute :>> userPhrases = "超级电容会不会过热；温差多大；我想看储能温度一致性需求具体要求；温度相关的能量回收要求有哪些；55℃出现异常时要查什么要求";
        attribute :>> semanticTopics = "ENERGY_STORAGE";
        attribute :>> systemTerms = "X124；超级电容温度传感器；X100；车载再生储能";
        attribute :>> actionTerms = "检测；监测";
        attribute :>> objectTerms = "超级电容；SOC";
        attribute :>> expectedFunctionSemantics = "温度监测;热管理";
        attribute :>> linkedFunctionIDs = "FN_F_X124_01";
        attribute :>> linkedFunctionNames = "检测超级电容温度传感器状态";
        attribute :>> linkedProductIDs = "X124";
        attribute :>> linkedProductNames = "超级电容温度传感器";
        attribute :>> functionCoverageCount = "1";
        attribute :>> coverageStatus = "PARTIAL";
        attribute :>> derivationReason = "";
        attribute :>> relatedRequirementIDs = "PRJ-ENE-001；PRJ-ENE-002；PRJ-ENE-003；PRJ-ENE-004；REQ-BRK-004；REQ-BRK-006；REQ-BRK-007；REQ-BRK-008；REQ-BRK-009；REQ-BRK-015；REQ-ENE-001；REQ-ENE-002；REQ-ENE-003；REQ-ENE-004；REQ-ENE-005；REQ-ENE-007；REQ-ENE-008；REQ-ENE-009；REQ-TRAC-001；REQ-TRAC-003";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> modelCoverage = "UNCOVERED";
        attribute :>> notes = "当前最终模型未建立热模型。";
        attribute :>> evidenceSource = "https://www.bzxz.net/bzxz/208403.html";
    }

    requirement req_REQ_ENE_007 : RailRequirementV2 {
        attribute :>> requirementID = "REQ-ENE-007";
        attribute :>> parentRequirementIDs = "";
        attribute :>> requirementLevel = "L1_DOMAIN";
        attribute :>> domain = "能量回收";
        attribute :>> topicGroup = "ENERGY_STORAGE";
        attribute :>> name = "储能过温保护需求";
        attribute :>> text = "储能电源应具有过温保护功能，过温时不应爆炸、起火。";
        attribute :>> requirementType = "安全";
        attribute :>> sourceType = "STANDARD_DIRECT";
        attribute :>> standardNo = "GB/T 42005.1-2022";
        attribute :>> standardClause = "5.4.2";
        attribute :>> criteria = "具备过温保护；过温时不爆炸、不起火。";
        attribute :>> applicableConditions = "储能电源过温异常工况。";
        attribute :>> keywords = "过温；热保护；安全；起火；爆炸；储能；再生能量；超级电容；SOC；充电；放电；储能功率";
        attribute :>> synonyms = "温度保护；热故障；车载储能；超级电容器；超容；电容储能；回馈制动；制动能量回收";
        attribute :>> userPhrases = "储能坏了怎么办；储能过热怎么办；有没有温度保护；我想看储能过温保护需求具体要求；过温相关的能量回收要求有哪些；热保护出现异常时要查什么要求";
        attribute :>> semanticTopics = "ENERGY_STORAGE";
        attribute :>> systemTerms = "X124；超级电容温度传感器；X100；车载再生储能；X112；双向DC/DC控制模块";
        attribute :>> actionTerms = "检测；监测；协调；限制；保护";
        attribute :>> objectTerms = "放电功率；超级电容；SOC";
        attribute :>> expectedFunctionSemantics = "温度监测;保护动作";
        attribute :>> linkedFunctionIDs = "FN_F_X124_01；FN_F_X112_02";
        attribute :>> linkedFunctionNames = "检测超级电容温度传感器状态；限制储能充放电功率并协调保护";
        attribute :>> linkedProductIDs = "X124；X112";
        attribute :>> linkedProductNames = "超级电容温度传感器；双向DC/DC控制模块";
        attribute :>> functionCoverageCount = "2";
        attribute :>> coverageStatus = "PARTIAL";
        attribute :>> derivationReason = "";
        attribute :>> relatedRequirementIDs = "PRJ-ENE-001；PRJ-ENE-002；PRJ-ENE-003；PRJ-ENE-004；REQ-BRK-004；REQ-BRK-006；REQ-BRK-007；REQ-BRK-008；REQ-BRK-009；REQ-BRK-015；REQ-ENE-001；REQ-ENE-002；REQ-ENE-003；REQ-ENE-004；REQ-ENE-005；REQ-ENE-006；REQ-ENE-008；REQ-ENE-009；REQ-TRAC-001；REQ-TRAC-003";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> modelCoverage = "UNCOVERED";
        attribute :>> notes = "当前最终模型未建立热失效和过温保护物理过程。";
        attribute :>> evidenceSource = "https://www.bzxz.net/bzxz/208403.html";
    }

    requirement req_REQ_ENE_008 : RailRequirementV2 {
        attribute :>> requirementID = "REQ-ENE-008";
        attribute :>> parentRequirementIDs = "";
        attribute :>> requirementLevel = "L1_DOMAIN";
        attribute :>> domain = "能量回收";
        attribute :>> topicGroup = "ENERGY_STORAGE";
        attribute :>> name = "储能过流保护需求";
        attribute :>> text = "储能电源正负极两端应具有过流保护功能，过流时不应爆炸、起火。";
        attribute :>> requirementType = "安全";
        attribute :>> sourceType = "STANDARD_DIRECT";
        attribute :>> standardNo = "GB/T 42005.1-2022";
        attribute :>> standardClause = "5.4.3";
        attribute :>> criteria = "具备过流保护；过流时不爆炸、不起火。";
        attribute :>> applicableConditions = "储能电源过流异常工况。";
        attribute :>> keywords = "过流；电流限制；保护；安全；900A；储能；再生能量；超级电容；SOC；充电；放电；储能功率";
        attribute :>> synonyms = "电流保护；过载；限流；车载储能；超级电容器；超容；电容储能；回馈制动；制动能量回收";
        attribute :>> userPhrases = "储能坏了怎么办；电流超过限制怎么办；超级电容过流保护；我想看储能过流保护需求具体要求；过流相关的能量回收要求有哪些；电流限制出现异常时要查什么要求";
        attribute :>> semanticTopics = "ENERGY_STORAGE";
        attribute :>> systemTerms = "X123；超级电容电流传感器；X100；车载再生储能；X112；双向DC/DC控制模块";
        attribute :>> actionTerms = "检测；协调；限制；保护";
        attribute :>> objectTerms = "放电功率；超级电容；SOC；电流";
        attribute :>> expectedFunctionSemantics = "电流测量;限流;保护动作";
        attribute :>> linkedFunctionIDs = "FN_F_X123_01；FN_F_X112_02";
        attribute :>> linkedFunctionNames = "检测超级电容电流传感器状态；限制储能充放电功率并协调保护";
        attribute :>> linkedProductIDs = "X123；X112";
        attribute :>> linkedProductNames = "超级电容电流传感器；双向DC/DC控制模块";
        attribute :>> functionCoverageCount = "2";
        attribute :>> coverageStatus = "PARTIAL";
        attribute :>> derivationReason = "";
        attribute :>> relatedRequirementIDs = "PRJ-ENE-001；PRJ-ENE-002；PRJ-ENE-003；PRJ-ENE-004；REQ-BRK-004；REQ-BRK-006；REQ-BRK-007；REQ-BRK-008；REQ-BRK-009；REQ-BRK-015；REQ-ENE-001；REQ-ENE-002；REQ-ENE-003；REQ-ENE-004；REQ-ENE-005；REQ-ENE-006；REQ-ENE-007；REQ-ENE-009；REQ-TRAC-001；REQ-TRAC-003";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> modelCoverage = "PARTIAL";
        attribute :>> notes = "当前项目Imax=900 A是项目设计限值，不是国标规定阈值；尚未执行过流故障V&V。";
        attribute :>> evidenceSource = "https://www.bzxz.net/bzxz/208403.html";
    }

    requirement req_REQ_ENE_009 : RailRequirementV2 {
        attribute :>> requirementID = "REQ-ENE-009";
        attribute :>> parentRequirementIDs = "";
        attribute :>> requirementLevel = "L1_DOMAIN";
        attribute :>> domain = "能量回收";
        attribute :>> topicGroup = "ENERGY_STORAGE";
        attribute :>> name = "储能短路保护需求";
        attribute :>> text = "储能电源应具有短路保护功能，短路时不应爆炸、起火。";
        attribute :>> requirementType = "安全";
        attribute :>> sourceType = "STANDARD_DIRECT";
        attribute :>> standardNo = "GB/T 42005.1-2022";
        attribute :>> standardClause = "5.4.4";
        attribute :>> criteria = "具备短路保护；短路时不爆炸、不起火。";
        attribute :>> applicableConditions = "储能电源短路异常工况。";
        attribute :>> keywords = "短路；保护；安全；故障；储能；再生能量；超级电容；SOC；充电；放电；储能功率；能量回收";
        attribute :>> synonyms = "短路故障；短路切除；车载储能；超级电容器；超容；电容储能；回馈制动；制动能量回收";
        attribute :>> userPhrases = "储能坏了怎么办；超级电容短路怎么办；有没有短路保护；我想看储能短路保护需求具体要求；短路相关的能量回收要求有哪些；保护出现异常时要查什么要求";
        attribute :>> semanticTopics = "ENERGY_STORAGE";
        attribute :>> systemTerms = "X112；双向DC/DC控制模块；X100；车载再生储能；X113；双向DC/DC检测保护组件";
        attribute :>> actionTerms = "检测；协调；限制；保护；隔离";
        attribute :>> objectTerms = "放电功率；超级电容；SOC";
        attribute :>> expectedFunctionSemantics = "短路检测;故障隔离;保护动作";
        attribute :>> linkedFunctionIDs = "FN_F_X112_02；FN_F_X113_01";
        attribute :>> linkedFunctionNames = "限制储能充放电功率并协调保护；检测双向DC/DC检测保护组件状态";
        attribute :>> linkedProductIDs = "X112；X113";
        attribute :>> linkedProductNames = "双向DC/DC控制模块；双向DC/DC检测保护组件";
        attribute :>> functionCoverageCount = "2";
        attribute :>> coverageStatus = "PARTIAL";
        attribute :>> derivationReason = "";
        attribute :>> relatedRequirementIDs = "PRJ-ENE-001；PRJ-ENE-002；PRJ-ENE-003；PRJ-ENE-004；REQ-BRK-004；REQ-BRK-006；REQ-BRK-007；REQ-BRK-008；REQ-BRK-009；REQ-BRK-015；REQ-ENE-001；REQ-ENE-002；REQ-ENE-003；REQ-ENE-004；REQ-ENE-005；REQ-ENE-006；REQ-ENE-007；REQ-ENE-008；REQ-TRAC-001；REQ-TRAC-003";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> modelCoverage = "UNCOVERED";
        attribute :>> notes = "当前最终模型未执行短路故障场景。";
        attribute :>> evidenceSource = "https://www.bzxz.net/bzxz/208403.html";
    }

    requirement req_REQ_TRAC_001 : RailRequirementV2 {
        attribute :>> requirementID = "REQ-TRAC-001";
        attribute :>> parentRequirementIDs = "";
        attribute :>> requirementLevel = "L1_DOMAIN";
        attribute :>> domain = "牵引";
        attribute :>> topicGroup = "TRACTION；REGENERATIVE_BRAKING";
        attribute :>> name = "牵引力-速度特性需求";
        attribute :>> text = "列车的牵引力-速度特性和制动力-速度特性应符合设计要求。";
        attribute :>> requirementType = "性能";
        attribute :>> sourceType = "STANDARD_DIRECT";
        attribute :>> standardNo = "GB/T 7928-2025";
        attribute :>> standardClause = "6.9";
        attribute :>> criteria = "符合经批准的牵引力-速度、制动力-速度设计特性。";
        attribute :>> applicableConditions = "车辆设计工况；具体特性曲线由项目设计给定。";
        attribute :>> keywords = "牵引力；速度特性；制动力；转矩；功率；牵引；牵引控制；牵引变流器；牵引电机；电能转换；速度";
        attribute :>> synonyms = "牵引特性；制动特性；力速曲线；转矩速度特性；牵引驱动；电机牵引；牵引传动";
        attribute :>> userPhrases = "牵引力怎么随速度变化；只看牵引特性；制动力速度曲线；我想看牵引力-速度特性需求具体要求；牵引力相关的牵引要求有哪些；速度特性出现异常时要查什么要求";
        attribute :>> semanticTopics = "TRACTION；REGENERATIVE_BRAKING";
        attribute :>> systemTerms = "5132；电机侧变流模块；5100；牵引变流器主体及其控制；5311；牵引电机；5300；牵引电机及其冷却；5112；电机侧变流器控制模块；3100；轮轴组成；3112；车轴；3120；齿轮箱及附件；3121；齿轮箱主体；3500；牵引传动耦合组件及其附件；3510；传动耦合机构；3511；联轴节(电机侧)";
        attribute :>> actionTerms = "检测；控制；传递；转换；反馈；提供";
        attribute :>> objectTerms = "牵引力；制动力；转矩；速度；机械能；电能；齿轮箱";
        attribute :>> expectedFunctionSemantics = "计算牵引/制动力需求;生成电机转矩;车辆纵向动力学";
        attribute :>> linkedFunctionIDs = "FN_F_5132_01；FN_F_5311_01；FN_F_5311_02；FN_F_5112_01；FN_F_3100_01；FN_F_3112_01；FN_F_3120_01；FN_F_3121_01；FN_F_3500_01；FN_F_3510_01；FN_F_3511_01；FN_F_3512_01；FN_F_3514_01；FN_F_3600_01；FN_F_3640_01；FN_F_3641_01；FN_F_3643_01；FN_F_3644_01；FN_F_5300_01；FN_F_5310_01";
        attribute :>> linkedFunctionNames = "实现中间直流电能与电机侧三相交流电能双向转换；实现三相交流电能与旋转机械能双向转换；提供牵引电机转速、转矩及电气状态反馈；控制电机侧变流器控制模块运行；转换能量/物理量、传递能量/介质；传递车轴机械能；转换能量/物理量；转换齿轮箱主体机械参数；传递能量/介质；传递能量/介质；传递联轴节(电机侧)机械能；传递联轴节(齿轮箱侧)机械能；传递万向轴机械能；检测运行参数；检测运行参数；检测轴端速度传感器状态；检测齿轮箱速度传感器状态；检测牵引电机速度传感器状态；转换能量/物理量、检测运行参数；转换能量/物理量、检测运行参数";
        attribute :>> linkedProductIDs = "5132；5311；5112；3100；3112；3120；3121；3500；3510；3511；3512；3514；3600；3640；3641；3643；3644；5300；5310";
        attribute :>> linkedProductNames = "电机侧变流模块；牵引电机；电机侧变流器控制模块；轮轴组成；车轴；齿轮箱及附件；齿轮箱主体；牵引传动耦合组件及其附件；传动耦合机构；联轴节(电机侧)；联轴节(齿轮箱侧)；万向轴；转向架相关检测；速度检测组件；轴端速度传感器；齿轮箱速度传感器；牵引电机速度传感器；牵引电机及其冷却；牵引电机组成";
        attribute :>> functionCoverageCount = "20";
        attribute :>> coverageStatus = "PARTIAL";
        attribute :>> derivationReason = "";
        attribute :>> relatedRequirementIDs = "DRV-TRAC-001；DRV-TRAC-002；DRV-TRAC-003；DRV-TRAC-004；PRJ-ENE-001；PRJ-ENE-002；PRJ-ENE-003；PRJ-ENE-004；REQ-BRK-004；REQ-BRK-006；REQ-BRK-007；REQ-BRK-008；REQ-BRK-009；REQ-BRK-015；REQ-ENE-001；REQ-ENE-002；REQ-ENE-003；REQ-ENE-004；REQ-ENE-005；REQ-ENE-006；REQ-ENE-007；REQ-ENE-008；REQ-ENE-009；REQ-TRAC-002；REQ-TRAC-003；REQ-TRAC-004";
        attribute :>> verificationStatus = "PARTIALLY_VERIFIED";
        attribute :>> modelCoverage = "PARTIAL";
        attribute :>> notes = "当前模型可形成牵引/制动响应，但尚未按完整标准试验工况对整条力-速度特性进行验证。";
        attribute :>> evidenceSource = "https://www.gb-gbt.com/PDF/Chinese.aspx/GBT7928-2025";
    }

    requirement req_REQ_TRAC_002 : RailRequirementV2 {
        attribute :>> requirementID = "REQ-TRAC-002";
        attribute :>> parentRequirementIDs = "";
        attribute :>> requirementLevel = "L1_DOMAIN";
        attribute :>> domain = "牵引";
        attribute :>> topicGroup = "TRACTION";
        attribute :>> name = "起动与加速性能需求";
        attribute :>> text = "列车在规定载荷、轨道、车轮和供电条件下应满足对应速度等级的平均加速度要求。";
        attribute :>> requirementType = "性能";
        attribute :>> sourceType = "STANDARD_DIRECT";
        attribute :>> standardNo = "GB/T 7928-2025";
        attribute :>> standardClause = "6.11";
        attribute :>> criteria = "80 km/h等级：0→40 km/h≥1.0 m/s²（动拖比1:1时≥0.83），0→80 km/h≥0.6 m/s²（动拖比1:1时≥0.5）；100 km/h等级：0→45 km/h≥1.0，0→100 km/h≥0.6；120 km/h等级：0→50 km/h≥1.0，0→120 km/h≥0.5。";
        attribute :>> applicableConditions = "定员；平直干燥轨道；车轮半磨耗；额定供电电压。";
        attribute :>> keywords = "加速度；起动；牵引；速度；定员；额定电压；牵引力；牵引控制；牵引变流器；牵引电机；电能转换；转矩";
        attribute :>> synonyms = "加速性能；起步性能；0到100；0到45；牵引驱动；电机牵引；牵引传动";
        attribute :>> userPhrases = "列车加速够不够；只看加速模型；起步牵引怎么样；我想看起动与加速性能需求具体要求；加速度相关的牵引要求有哪些；起动出现异常时要查什么要求";
        attribute :>> semanticTopics = "TRACTION";
        attribute :>> systemTerms = "5132；电机侧变流模块；5100；牵引变流器主体及其控制；5311；牵引电机；5300；牵引电机及其冷却；5112；电机侧变流器控制模块";
        attribute :>> actionTerms = "控制；转换；反馈；提供";
        attribute :>> objectTerms = "牵引力；转矩；速度；机械能；电能；电压";
        attribute :>> expectedFunctionSemantics = "速度目标生成;牵引力需求计算;电机转矩控制;车辆纵向动力学";
        attribute :>> linkedFunctionIDs = "FN_F_5132_01；FN_F_5311_01；FN_F_5311_02；FN_F_5112_01";
        attribute :>> linkedFunctionNames = "实现中间直流电能与电机侧三相交流电能双向转换；实现三相交流电能与旋转机械能双向转换；提供牵引电机转速、转矩及电气状态反馈；控制电机侧变流器控制模块运行";
        attribute :>> linkedProductIDs = "5132；5311；5112";
        attribute :>> linkedProductNames = "电机侧变流模块；牵引电机；电机侧变流器控制模块";
        attribute :>> functionCoverageCount = "4";
        attribute :>> coverageStatus = "PARTIAL";
        attribute :>> derivationReason = "";
        attribute :>> relatedRequirementIDs = "DRV-TRAC-001；DRV-TRAC-002；DRV-TRAC-003；DRV-TRAC-004；REQ-TRAC-001；REQ-TRAC-003；REQ-TRAC-004";
        attribute :>> verificationStatus = "PARTIALLY_VERIFIED";
        attribute :>> modelCoverage = "PARTIAL";
        attribute :>> notes = "当前基准仿真不是按GB/T 7928-2025规定的定员/半磨耗/速度等级试验工况执行，不能直接判定标准PASS。";
        attribute :>> evidenceSource = "https://www.gb-gbt.com/PDF/Chinese.aspx/GBT7928-2025";
    }

    requirement req_REQ_TRAC_003 : RailRequirementV2 {
        attribute :>> requirementID = "REQ-TRAC-003";
        attribute :>> parentRequirementIDs = "";
        attribute :>> requirementLevel = "L1_DOMAIN";
        attribute :>> domain = "牵引";
        attribute :>> topicGroup = "TRACTION；REGENERATIVE_BRAKING";
        attribute :>> name = "黏着利用与防空转/防滑行需求";
        attribute :>> text = "牵引系统应充分利用轮轨黏着条件，按车辆载荷自动调整牵引力或电制动力，并具有防空转、防滑行和防冲动控制。";
        attribute :>> requirementType = "功能/安全";
        attribute :>> sourceType = "STANDARD_DIRECT";
        attribute :>> standardNo = "GB/T 7928-2025";
        attribute :>> standardClause = "11.7";
        attribute :>> criteria = "具备载荷自适应牵引/电制动力调节，以及防空转、防滑行、防冲动控制。";
        attribute :>> applicableConditions = "轮轨黏着条件；车辆载荷变化。";
        attribute :>> keywords = "黏着；防空转；防滑行；防冲动；载荷；牵引力；电制动力；牵引；牵引控制；牵引变流器；牵引电机；电能转换";
        attribute :>> synonyms = "轮滑；空转；黏着控制；防滑控制；牵引驱动；电机牵引；牵引传动";
        attribute :>> userPhrases = "车轮打滑怎么办；黏着不足怎么办；牵引防空转；我想看黏着利用与防空转/防滑行需求具体要求；黏着相关的牵引要求有哪些；防空转出现异常时要查什么要求";
        attribute :>> semanticTopics = "TRACTION；REGENERATIVE_BRAKING";
        attribute :>> systemTerms = "7211；电子制动控制单元(EBCU)；7200；制动；722A；防滑阀组成；5311；牵引电机；5300；牵引电机及其冷却；3641；轴端速度传感器；3600；转向架相关检测；3643；齿轮箱速度传感器；3644；牵引电机速度传感器";
        attribute :>> actionTerms = "检测；控制；协调；传递；转换；限制；反馈；提供";
        attribute :>> objectTerms = "牵引力；制动力；转矩；速度；电能；气动压力；齿轮箱";
        attribute :>> expectedFunctionSemantics = "黏着限制;滑移率估计;牵引/制动力限幅;防滑控制";
        attribute :>> linkedFunctionIDs = "FN_F_7211_04；FN_F_722A_01；FN_F_5311_02；FN_F_3641_01；FN_F_3643_01；FN_F_3644_01";
        attribute :>> linkedFunctionNames = "协调防滑与紧急制动安全请求；传递防滑阀组成气动压力；提供牵引电机转速、转矩及电气状态反馈；检测轴端速度传感器状态；检测齿轮箱速度传感器状态；检测牵引电机速度传感器状态";
        attribute :>> linkedProductIDs = "7211；722A；5311；3641；3643；3644";
        attribute :>> linkedProductNames = "电子制动控制单元(EBCU)；防滑阀组成；牵引电机；轴端速度传感器；齿轮箱速度传感器；牵引电机速度传感器";
        attribute :>> functionCoverageCount = "6";
        attribute :>> coverageStatus = "PARTIAL";
        attribute :>> derivationReason = "";
        attribute :>> relatedRequirementIDs = "DRV-TRAC-001；DRV-TRAC-002；DRV-TRAC-003；DRV-TRAC-004；PRJ-ENE-001；PRJ-ENE-002；PRJ-ENE-003；PRJ-ENE-004；REQ-BRK-004；REQ-BRK-006；REQ-BRK-007；REQ-BRK-008；REQ-BRK-009；REQ-BRK-015；REQ-ENE-001；REQ-ENE-002；REQ-ENE-003；REQ-ENE-004；REQ-ENE-005；REQ-ENE-006；REQ-ENE-007；REQ-ENE-008；REQ-ENE-009；REQ-TRAC-001；REQ-TRAC-002；REQ-TRAC-004";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> modelCoverage = "UNCOVERED";
        attribute :>> notes = "当前最终模型未显式建立黏着系数、滑移率和WSP/防空转物理机制。";
        attribute :>> evidenceSource = "https://www.gb-gbt.com/PDF/Chinese.aspx/GBT7928-2025";
    }

    requirement req_REQ_TRAC_004 : RailRequirementV2 {
        attribute :>> requirementID = "REQ-TRAC-004";
        attribute :>> parentRequirementIDs = "";
        attribute :>> requirementLevel = "L1_DOMAIN";
        attribute :>> domain = "牵引";
        attribute :>> topicGroup = "TRACTION";
        attribute :>> name = "交流电传动架构需求";
        attribute :>> text = "电力牵引应采用变频调压的交流电传动系统，并应符合GB/T 37863.1的规定。";
        attribute :>> requirementType = "架构/约束";
        attribute :>> sourceType = "STANDARD_DIRECT";
        attribute :>> standardNo = "GB/T 7928-2025";
        attribute :>> standardClause = "11.1";
        attribute :>> criteria = "采用变频调压交流电传动；牵引电传动系统应符合GB/T 37863.1。";
        attribute :>> applicableConditions = "适用于GB/T 7928-2025范围内的地铁车辆；本项目仅验证架构覆盖，不宣称完整标准符合性。";
        attribute :>> keywords = "交流传动；变频调压；牵引电传动；变流器；电机；牵引；牵引力；牵引控制；牵引变流器；牵引电机；电能转换；速度";
        attribute :>> synonyms = "VVVF；交流牵引；变频牵引；牵引驱动；电机牵引；牵引传动";
        attribute :>> userPhrases = "牵引系统是什么架构；是不是交流传动；变流器怎么驱动电机；我想看交流电传动架构需求具体要求；交流传动相关的牵引要求有哪些；变频调压出现异常时要查什么要求";
        attribute :>> semanticTopics = "TRACTION";
        attribute :>> systemTerms = "4511；主变压器主体；4500；主变压器及其冷却；5131；网侧变流模块；5100；牵引变流器主体及其控制；5132；电机侧变流模块；5311；牵引电机；5300；牵引电机及其冷却；3100；轮轴组成；3112；车轴；3120；齿轮箱及附件；3121；齿轮箱主体；3500；牵引传动耦合组件及其附件";
        attribute :>> actionTerms = "检测；控制；传递；转换";
        attribute :>> objectTerms = "牵引力；转矩；速度；机械能；电能；齿轮箱";
        attribute :>> expectedFunctionSemantics = "直流母线能量变换;逆变;电机转矩生成";
        attribute :>> linkedFunctionIDs = "FN_F_4511_01；FN_F_5131_01；FN_F_5132_01；FN_F_5311_01；FN_F_3100_01；FN_F_3112_01；FN_F_3120_01；FN_F_3121_01；FN_F_3500_01；FN_F_3510_01；FN_F_3511_01；FN_F_3512_01；FN_F_3514_01；FN_F_4500_01；FN_F_4510_01；FN_F_4513_01；FN_F_5300_01；FN_F_5310_01";
        attribute :>> linkedFunctionNames = "实现高压交流电能与牵引变压器次级交流电能转换；实现主变次级交流电能与中间直流电能双向转换；实现中间直流电能与电机侧三相交流电能双向转换；实现三相交流电能与旋转机械能双向转换；转换能量/物理量、传递能量/介质；传递车轴机械能；转换能量/物理量；转换齿轮箱主体机械参数；传递能量/介质；传递能量/介质；传递联轴节(电机侧)机械能；传递联轴节(齿轮箱侧)机械能；传递万向轴机械能；转换能量/物理量、控制运行；转换能量/物理量、控制运行；传递电抗器电能；转换能量/物理量、检测运行参数；转换能量/物理量、检测运行参数";
        attribute :>> linkedProductIDs = "4511；5131；5132；5311；3100；3112；3120；3121；3500；3510；3511；3512；3514；4500；4510；4513；5300；5310";
        attribute :>> linkedProductNames = "主变压器主体；网侧变流模块；电机侧变流模块；牵引电机；轮轴组成；车轴；齿轮箱及附件；齿轮箱主体；牵引传动耦合组件及其附件；传动耦合机构；联轴节(电机侧)；联轴节(齿轮箱侧)；万向轴；主变压器及其冷却；主变压器主体及其控制；电抗器；牵引电机及其冷却；牵引电机组成";
        attribute :>> functionCoverageCount = "18";
        attribute :>> coverageStatus = "FULL";
        attribute :>> derivationReason = "";
        attribute :>> relatedRequirementIDs = "DRV-TRAC-001；DRV-TRAC-002；DRV-TRAC-003；DRV-TRAC-004；REQ-TRAC-001；REQ-TRAC-002；REQ-TRAC-003";
        attribute :>> verificationStatus = "PARTIALLY_VERIFIED";
        attribute :>> modelCoverage = "COVERED";
        attribute :>> notes = "模型结构具备交流牵引链路；未执行GB/T 37863.1全部型式/性能试验。";
        attribute :>> evidenceSource = "https://openstd.samr.gov.cn/bzgk/std/newGbInfo?hcno=71C4E9BF5C2DE8403ECB79A012928457";
    }

    requirement req_DRV_BRK_001 : RailRequirementV2 {
        attribute :>> requirementID = "DRV-BRK-001";
        attribute :>> parentRequirementIDs = "REQ-BRK-001；REQ-BRK-012";
        attribute :>> requirementLevel = "L2_DERIVED";
        attribute :>> domain = "制动";
        attribute :>> topicGroup = "PNEUMATIC_BRAKE";
        attribute :>> name = "制动供风与总风管压力可用性";
        attribute :>> text = "制动供风系统应向制动风缸提供压缩空气并传递总风管压力，检测供风系统运行参数和总风管压力传感器状态，以支持气动制动可用性判断。";
        attribute :>> requirementType = "工程功能要求";
        attribute :>> sourceType = "ENGINEERING_DERIVED";
        attribute :>> standardNo = "";
        attribute :>> standardClause = "";
        attribute :>> criteria = "模型判据：所列既有Function及其SysML allocation存在；本判据不表示标准符合性或试验验证通过。";
        attribute :>> applicableConditions = "适用于本项目现有SysML产品边界及已建模运行/控制接口。";
        attribute :>> keywords = "制动供风；压缩空气；制动风缸；总风管；总风压力；气动制动；压力传感器；供风可用性；制动；制动力；制动请求；再生制动";
        attribute :>> synonyms = "供风系统；风源系统；空气制动供气；制动气源；刹车；摩擦制动；空气制动；气动制动；电制动";
        attribute :>> userPhrases = "制动用压缩空气从哪里来；总风管压力由谁监测；供风系统和制动风缸怎么连接";
        attribute :>> semanticTopics = "PNEUMATIC_BRAKE；制动供风；空气制动；压力监测";
        attribute :>> systemTerms = "7100；供风；7120；风缸；7124；制动风缸；7130；列车级压缩空气分配组件；7131；总风管；7140；供风压力开关及传感器；7142；总风管压力传感器";
        attribute :>> actionTerms = "提供；传递；检测；监测";
        attribute :>> objectTerms = "压缩空气；制动风缸；总风管压力；压力传感器状态；制动力；气动压力；总风管";
        attribute :>> expectedFunctionSemantics = "制动供风系统应向制动风缸提供压缩空气并传递总风管压力，检测供风系统运行参数和总风管压力传感器状态，以支持气动制动可用性判断。";
        attribute :>> linkedFunctionIDs = "FN_F_7100_01；FN_F_7120_01；FN_F_7124_01；FN_F_7130_01；FN_F_7131_01；FN_F_7140_01；FN_F_7142_01";
        attribute :>> linkedFunctionNames = "传递能量/介质、检测运行参数；传递能量/介质；提供制动风缸外部能量；传递能量/介质；传递总风管气动压力；检测运行参数；检测总风管压力传感器状态";
        attribute :>> linkedProductIDs = "7100；7120；7124；7130；7131；7140；7142";
        attribute :>> linkedProductNames = "供风；风缸；制动风缸；列车级压缩空气分配组件；总风管；供风压力开关及传感器；总风管压力传感器";
        attribute :>> functionCoverageCount = "7";
        attribute :>> coverageStatus = "FULL";
        attribute :>> derivationReason = "现有制动需求未完整覆盖供风、风缸供气及总风管压力检测链；7100真实Function及其供风部件allocation形成同一气动制动可用性目标。";
        attribute :>> relatedRequirementIDs = "DRV-BRK-002；PRJ-BRK-001；REQ-BRK-001；REQ-BRK-002；REQ-BRK-003；REQ-BRK-004；REQ-BRK-005；REQ-BRK-006；REQ-BRK-007；REQ-BRK-008；REQ-BRK-009；REQ-BRK-010；REQ-BRK-011；REQ-BRK-012；REQ-BRK-013；REQ-BRK-014；REQ-BRK-015";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> modelCoverage = "COVERED";
        attribute :>> notes = "工程派生需求；不声明为标准直接要求，不增加或修改SysML对象。";
        attribute :>> evidenceSource = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml";
    }

    requirement req_DRV_BRK_002 : RailRequirementV2 {
        attribute :>> requirementID = "DRV-BRK-002";
        attribute :>> parentRequirementIDs = "REQ-BRK-001；REQ-BRK-004；REQ-BRK-013";
        attribute :>> requirementLevel = "L2_DERIVED";
        attribute :>> domain = "制动";
        attribute :>> topicGroup = "BRAKING";
        attribute :>> name = "气动压力分配与机械制动执行";
        attribute :>> text = "制动执行系统应按既有制动控制传递、调节或隔离气动压力，并将气动压力转换为制动机械力、传递夹钳作用力及耗散机械制动能量，同时提供已建模制动指示状态。";
        attribute :>> requirementType = "工程功能要求";
        attribute :>> sourceType = "ENGINEERING_DERIVED";
        attribute :>> standardNo = "";
        attribute :>> standardClause = "";
        attribute :>> criteria = "模型判据：所列既有Function及其SysML allocation存在；本判据不表示标准符合性或试验验证通过。";
        attribute :>> applicableConditions = "适用于本项目现有SysML产品边界及已建模运行/控制接口。";
        attribute :>> keywords = "制动执行；气动压力；电空转换阀；中继阀；电磁阀；缓解阀；制动夹钳；闸片；摩擦制动；制动指示器；制动截断塞门；制动";
        attribute :>> synonyms = "机械制动；摩擦制动；气动制动；基础制动；制动执行机构；刹车；空气制动；电制动";
        attribute :>> userPhrases = "机械制动什么时候介入；制动压力如何传到制动夹钳；电空转换后机械制动怎么执行";
        attribute :>> semanticTopics = "BRAKING；机械制动；空气制动；制动执行；制动力传递";
        attribute :>> systemTerms = "7200；制动；7210；制动控制组件；7213；制动控制接触器及其他；7220；直接制动控制；7222；电空转换阀；7223；中继阀；7225；控制电磁阀；7227；缓解阀；7228；车厢直接制动截断塞门；7229；调压阀；7250；制动夹钳及其配套组件；7252；非停放制动夹钳装置";
        attribute :>> actionTerms = "传递；调节；隔离；转换；执行；耗散；指示；控制；提供；分配";
        attribute :>> objectTerms = "气动压力；制动机械力；制动夹钳；闸片；制动状态";
        attribute :>> expectedFunctionSemantics = "制动执行系统应按既有制动控制传递、调节或隔离气动压力，并将气动压力转换为制动机械力、传递夹钳作用力及耗散机械制动能量，同时提供已建模制动指示状态。";
        attribute :>> linkedFunctionIDs = "FN_F_7200_01；FN_F_7210_01；FN_F_7213_01；FN_F_7220_01；FN_F_7222_01；FN_F_7223_01；FN_F_7225_01；FN_F_7227_01；FN_F_7228_01；FN_F_7229_01；FN_F_7250_01；FN_F_7252_01；FN_F_7254_01；FN_F_7280_01；FN_F_7281_01；FN_F_7284_01；FN_F_7285_01";
        attribute :>> linkedFunctionNames = "转换能量/物理量、控制运行；转换能量/物理量、控制运行；执行制动控制接触器及其他动作；转换能量/物理量、执行安全控制；传递电空转换阀气动压力；传递中继阀气动压力；执行控制电磁阀动作；执行缓解阀动作；传递车厢直接制动截断塞门气动压力；传递调压阀气动压力；转换能量/物理量、传递能量/介质；传递制动夹钳作用力；通过闸片耗散机械制动能量；转换能量/物理量、传递能量/介质；执行制动指示器动作；传递转向架制动截断塞门气动压力；传递单轴制动截断塞门气动压力";
        attribute :>> linkedProductIDs = "7200；7210；7213；7220；7222；7223；7225；7227；7228；7229；7250；7252；7254；7280；7281；7284；7285";
        attribute :>> linkedProductNames = "制动；制动控制组件；制动控制接触器及其他；直接制动控制；电空转换阀；中继阀；控制电磁阀；缓解阀；车厢直接制动截断塞门；调压阀；制动夹钳及其配套组件；非停放制动夹钳装置；闸片；其它制动元件及附件；制动指示器；转向架制动截断塞门；单轴制动截断塞门";
        attribute :>> functionCoverageCount = "17";
        attribute :>> coverageStatus = "FULL";
        attribute :>> derivationReason = "既有制动需求表达制动性能和协调目标，但没有说明阀件、气压分配、制动夹钳、闸片及状态指示构成的执行链；所列功能真实属于7200制动产品树。";
        attribute :>> relatedRequirementIDs = "DRV-BRK-001；DRV-CTL-003；PRJ-BRK-001；REQ-BRK-001；REQ-BRK-002；REQ-BRK-003；REQ-BRK-004；REQ-BRK-005；REQ-BRK-006；REQ-BRK-007；REQ-BRK-008；REQ-BRK-009；REQ-BRK-010；REQ-BRK-011；REQ-BRK-012；REQ-BRK-013；REQ-BRK-014；REQ-BRK-015；REQ-ENE-002；REQ-ENE-003";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> modelCoverage = "COVERED";
        attribute :>> notes = "工程派生需求；不声明为标准直接要求，不增加或修改SysML对象。";
        attribute :>> evidenceSource = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml";
    }

    requirement req_DRV_CTL_001 : RailRequirementV2 {
        attribute :>> requirementID = "DRV-CTL-001";
        attribute :>> parentRequirementIDs = "REQ-TRAC-002；REQ-BRK-001；REQ-BRK-002";
        attribute :>> requirementLevel = "L2_DERIVED";
        attribute :>> domain = "控制";
        attribute :>> topicGroup = "BRAKE_CONTROL";
        attribute :>> name = "司机操纵与ATP控制边界输入";
        attribute :>> text = "列车操纵及ATP边界应通过既有方向、牵引、制动操作元件和ATP接口向列车控制系统提供相应输入，并报告ATP接口运行状态。";
        attribute :>> requirementType = "工程功能要求";
        attribute :>> sourceType = "ENGINEERING_DERIVED";
        attribute :>> standardNo = "";
        attribute :>> standardClause = "";
        attribute :>> criteria = "模型判据：所列既有Function及其SysML allocation存在；本判据不表示标准符合性或试验验证通过。";
        attribute :>> applicableConditions = "适用于本项目现有SysML产品边界及已建模运行/控制接口。";
        attribute :>> keywords = "司机操纵；方向手柄；牵引手柄；制动手柄；ATP车载；ATP接口；列车控制输入；操作元件；列车控制；控制单元；控制接口；输入输出";
        attribute :>> synonyms = "司机控制界面；操纵台输入；ATP边界接口；车载控制；控制状态反馈；控制网络";
        attribute :>> userPhrases = "方向牵引和制动手柄的输入怎么进入控制系统；ATP接口和司机操纵有哪些需求；列车控制输入来自哪些边界设备";
        attribute :>> semanticTopics = "BRAKE_CONTROL；司机操纵；列车控制输入；ATP接口";
        attribute :>> systemTerms = "D100；操纵设施；D110；基本操纵组件；D112；方向操作元件；D113；牵引操作元件；D114；制动操作元件；D120；紧急响应元件；D130；开关按钮功能组件；E100；ATP车载；8127；ATP接口单元；8100；列车主干网及安全回路";
        attribute :>> actionTerms = "提供；输入；控制；路由；报告；输出";
        attribute :>> objectTerms = "方向输入；牵引请求；制动请求；ATP接口状态；运行状态；控制接口";
        attribute :>> expectedFunctionSemantics = "列车操纵及ATP边界应通过既有方向、牵引、制动操作元件和ATP接口向列车控制系统提供相应输入，并报告ATP接口运行状态。";
        attribute :>> linkedFunctionIDs = "FN_F_D100_01；FN_F_D110_01；FN_F_D112_01；FN_F_D113_01；FN_F_D114_01；FN_F_D120_01；FN_F_D130_01；FN_F_E100_01；FN_F_8127_01；FN_F_8127_02";
        attribute :>> linkedFunctionNames = "控制运行；控制运行；提供方向操作元件边界交互；提供牵引操作元件边界交互；提供制动操作元件边界交互；控制运行；控制运行；提供ATP车载边界交互；路由ATP接口单元输入输出信号；报告ATP接口单元运行状态";
        attribute :>> linkedProductIDs = "D100；D110；D112；D113；D114；D120；D130；E100；8127";
        attribute :>> linkedProductNames = "操纵设施；基本操纵组件；方向操作元件；牵引操作元件；制动操作元件；紧急响应元件；开关按钮功能组件；ATP车载；ATP接口单元";
        attribute :>> functionCoverageCount = "10";
        attribute :>> coverageStatus = "FULL";
        attribute :>> derivationReason = "现有牵引、制动性能需求未定义其边界操纵输入；D100操作元件、E100 ATP边界及8100 ATP接口单元提供了可验证的真实接口功能。";
        attribute :>> relatedRequirementIDs = "";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> modelCoverage = "COVERED";
        attribute :>> notes = "工程派生需求；不声明为标准直接要求，不增加或修改SysML对象。";
        attribute :>> evidenceSource = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml";
    }

    requirement req_DRV_CTL_002 : RailRequirementV2 {
        attribute :>> requirementID = "DRV-CTL-002";
        attribute :>> parentRequirementIDs = "REQ-TRAC-002；REQ-BRK-014；REQ-ENE-003";
        attribute :>> requirementLevel = "L2_DERIVED";
        attribute :>> domain = "控制";
        attribute :>> topicGroup = "COMMUNICATION";
        attribute :>> name = "车载控制单元协调与状态报告";
        attribute :>> text = "车载列车控制系统应在既有主控制、车辆控制、列车级牵引控制和输入输出单元之间协调控制接口交互，并提供相关控制单元的运行状态及运行数据。";
        attribute :>> requirementType = "工程功能要求";
        attribute :>> sourceType = "ENGINEERING_DERIVED";
        attribute :>> standardNo = "";
        attribute :>> standardClause = "";
        attribute :>> criteria = "模型判据：所列既有Function及其SysML allocation存在；本判据不表示标准符合性或试验验证通过。";
        attribute :>> applicableConditions = "适用于本项目现有SysML产品边界及已建模运行/控制接口。";
        attribute :>> keywords = "列车控制系统；主控制单元；车辆控制单元；牵引控制单元；输入输出单元；控制接口；状态报告；运行数据；车载通信；列车控制；控制单元；输入输出";
        attribute :>> synonyms = "车载控制网络；列车控制单元协调；控制状态反馈；车载控制；控制网络";
        attribute :>> userPhrases = "车辆控制和牵引控制单元如何协同；控制单元的状态信息从哪里获取；输入输出单元会报告哪些运行状态";
        attribute :>> semanticTopics = "COMMUNICATION；列车控制；车载通信；状态报告；控制单元协调";
        attribute :>> systemTerms = "8100；列车主干网及安全回路；8120；控制单元及输入输出模块；8121；主控制单元；8122；车辆控制单元；8125；列车级牵引控制单元；8128；输入输出单元；8160；其它附件";
        attribute :>> actionTerms = "协调；控制；路由；报告；统计；限制；输出；反馈；保护；提供";
        attribute :>> objectTerms = "主控制单元；车辆控制单元；牵引控制单元；输入输出单元；运行状态；控制接口";
        attribute :>> expectedFunctionSemantics = "车载列车控制系统应在既有主控制、车辆控制、列车级牵引控制和输入输出单元之间协调控制接口交互，并提供相关控制单元的运行状态及运行数据。";
        attribute :>> linkedFunctionIDs = "FN_F_8100_01；FN_F_8120_01；FN_F_8121_01；FN_F_8121_02；FN_F_8121_03；FN_F_8122_01；FN_F_8122_02；FN_F_8122_04；FN_F_8122_05；FN_F_8125_01；FN_F_8125_02；FN_F_8125_03；FN_F_8125_04；FN_F_8128_01；FN_F_8128_02；FN_F_8128_03；FN_F_8160_01";
        attribute :>> linkedFunctionNames = "控制运行、实施保护与限制；控制运行、实施保护与限制；控制主控制单元运行；协调主控制单元接口交互；报告主控制单元运行状态；控制车辆控制单元运行；协调车辆控制单元接口交互；报告车辆控制单元运行状态；统计车辆控制单元运行数据；控制列车级牵引控制单元运行；协调列车级牵引控制单元接口交互；限制并保护列车级牵引控制单元运行；报告列车级牵引控制单元运行状态；路由输入输出单元输入输出信号；协调输入输出单元接口交互；报告输入输出单元运行状态；控制运行、反馈运行状态";
        attribute :>> linkedProductIDs = "8100；8120；8121；8122；8125；8128；8160";
        attribute :>> linkedProductNames = "列车主干网及安全回路；控制单元及输入输出模块；主控制单元；车辆控制单元；列车级牵引控制单元；输入输出单元；其它附件";
        attribute :>> functionCoverageCount = "17";
        attribute :>> coverageStatus = "FULL";
        attribute :>> derivationReason = "当前需求只覆盖个别制动安全或储能通信现象，未表达车载主控、车辆控制、牵引控制及I/O控制接口协调与状态报告这一组系统级能力；各Function均属于8100真实Product树。";
        attribute :>> relatedRequirementIDs = "";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> modelCoverage = "COVERED";
        attribute :>> notes = "工程派生需求；不声明为标准直接要求，不增加或修改SysML对象。";
        attribute :>> evidenceSource = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml";
    }

    requirement req_DRV_CTL_003 : RailRequirementV2 {
        attribute :>> requirementID = "DRV-CTL-003";
        attribute :>> parentRequirementIDs = "REQ-BRK-014；REQ-BRK-015；REQ-TRAC-003";
        attribute :>> requirementLevel = "L2_DERIVED";
        attribute :>> domain = "安全";
        attribute :>> topicGroup = "SAFETY_PROTECTION";
        attribute :>> name = "牵引与高压安全回路逻辑及状态";
        attribute :>> text = "牵引、高压和制动安全回路应执行模型中定义的安全逻辑，并向车辆控制系统提供相应安全回路运行状态。";
        attribute :>> requirementType = "工程功能要求";
        attribute :>> sourceType = "ENGINEERING_DERIVED";
        attribute :>> standardNo = "";
        attribute :>> standardClause = "";
        attribute :>> criteria = "模型判据：所列既有Function及其SysML allocation存在；本判据不表示标准符合性或试验验证通过。";
        attribute :>> applicableConditions = "适用于本项目现有SysML产品边界及已建模运行/控制接口。";
        attribute :>> keywords = "安全回路；高压安全回路；牵引安全回路；制动安全回路；安全逻辑；回路状态；运行状态反馈；列车控制；控制单元；控制接口；输入输出；运行状态";
        attribute :>> synonyms = "安全联锁回路；安全状态反馈；牵引保护回路；车载控制；控制状态反馈；控制网络";
        attribute :>> userPhrases = "牵引和高压安全回路怎么执行保护；制动安全回路状态会不会上报；哪些安全回路具有状态反馈";
        attribute :>> semanticTopics = "SAFETY_PROTECTION；安全回路；牵引保护；高压保护；制动保护";
        attribute :>> systemTerms = "8150；整车级安全回路及其附件；8100；列车主干网及安全回路；8151；高压安全回路；8152；制动安全回路；8154；牵引安全回路";
        attribute :>> actionTerms = "执行；保护；限制；反馈；报告；控制；输出；提供";
        attribute :>> objectTerms = "高压安全回路；牵引安全回路；制动安全回路；安全状态；运行状态；安全回路；控制接口";
        attribute :>> expectedFunctionSemantics = "牵引、高压和制动安全回路应执行模型中定义的安全逻辑，并向车辆控制系统提供相应安全回路运行状态。";
        attribute :>> linkedFunctionIDs = "FN_F_8150_01；FN_F_8151_01；FN_F_8151_02；FN_F_8152_01；FN_F_8152_02；FN_F_8154_01；FN_F_8154_02";
        attribute :>> linkedFunctionNames = "执行安全控制、反馈运行状态；执行高压安全回路安全逻辑；报告高压安全回路运行状态；执行制动安全回路安全逻辑；报告制动安全回路运行状态；执行牵引安全回路安全逻辑；报告牵引安全回路运行状态";
        attribute :>> linkedProductIDs = "8150；8151；8152；8154";
        attribute :>> linkedProductNames = "整车级安全回路及其附件；高压安全回路；制动安全回路；牵引安全回路";
        attribute :>> functionCoverageCount = "7";
        attribute :>> coverageStatus = "FULL";
        attribute :>> derivationReason = "已有故障诊断需求涉及部分制动安全回路，但高压与牵引安全逻辑及状态反馈仍没有统一需求来源；8150、8151、8152、8154真实Functions支持该分组。";
        attribute :>> relatedRequirementIDs = "DRV-BRK-002；PRJ-BRK-001；REQ-BRK-001；REQ-BRK-002；REQ-BRK-003；REQ-BRK-004；REQ-BRK-005；REQ-BRK-006；REQ-BRK-007；REQ-BRK-008；REQ-BRK-009；REQ-BRK-010；REQ-BRK-011；REQ-BRK-012；REQ-BRK-013；REQ-BRK-014；REQ-BRK-015；REQ-ENE-002；REQ-ENE-003";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> modelCoverage = "COVERED";
        attribute :>> notes = "工程派生需求；不声明为标准直接要求，不增加或修改SysML对象。";
        attribute :>> evidenceSource = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml";
    }

    requirement req_DRV_PWR_001 : RailRequirementV2 {
        attribute :>> requirementID = "DRV-PWR-001";
        attribute :>> parentRequirementIDs = "PRJ-PWR-001";
        attribute :>> requirementLevel = "L2_DERIVED";
        attribute :>> domain = "供电";
        attribute :>> topicGroup = "POWER_SUPPLY";
        attribute :>> name = "高压受流与分配控制";
        attribute :>> text = "高压受流及分配系统应控制受电弓、高压断路器和隔离开关等既有设备的运行，采集高压电压、电流及开关单元状态，并通过已建模控制接口提供相应输入输出和状态信息。";
        attribute :>> requirementType = "工程功能要求";
        attribute :>> sourceType = "ENGINEERING_DERIVED";
        attribute :>> standardNo = "";
        attribute :>> standardClause = "";
        attribute :>> criteria = "模型判据：所列既有Function及其SysML allocation存在；本判据不表示标准符合性或试验验证通过。";
        attribute :>> applicableConditions = "适用于本项目现有SysML产品边界及已建模运行/控制接口。";
        attribute :>> keywords = "高压受流；受电弓；碳滑板；高压断路器；隔离开关；高压分配；电压互感器；电流互感器；开关状态；高压控制单元；供电；高压";
        attribute :>> synonyms = "网侧高压供电；受流装置；高压开关设备；高压测量；网侧供电；牵引供电；受流系统；高压电源";
        attribute :>> userPhrases = "受电弓和高压开关如何纳入控制；高压电压电流由哪些单元采集；高压分配状态怎么传给控制系统";
        attribute :>> semanticTopics = "POWER_SUPPLY；高压供电；受流；高压分配；开关控制";
        attribute :>> systemTerms = "4100；高压受流；4110；受电弓总成；411C；受电弓电子控制单元；4200；网侧高压分配及控制；4210；高压开关；4211；真空断路器；4212；非真空隔离开关；4230；高压保护及检测部件；4235；高压电压互感器；4236；高压电流互感器；4238；高压控制输入输出单元；4239；高压控制单元";
        attribute :>> actionTerms = "受流；控制；采集；路由；协调；报告；检测；传递；输出；反馈；隔离；统计；提供；分配";
        attribute :>> objectTerms = "受电弓；断路器；隔离开关；高压电压；高压电流；开关状态；电能；电流；电压；运行状态；控制接口";
        attribute :>> expectedFunctionSemantics = "高压受流及分配系统应控制受电弓、高压断路器和隔离开关等既有设备的运行，采集高压电压、电流及开关单元状态，并通过已建模控制接口提供相应输入输出和状态信息。";
        attribute :>> linkedFunctionIDs = "FN_F_4100_01；FN_F_4110_01；FN_F_411C_01；FN_F_411C_02；FN_F_4200_01；FN_F_4210_01；FN_F_4211_01；FN_F_4212_01；FN_F_4230_01；FN_F_4235_01；FN_F_4236_01；FN_F_4238_01；FN_F_4238_02；FN_F_4238_03；FN_F_4239_01；FN_F_4239_02；FN_F_4239_03；FN_F_4240_01；FN_F_4241_01；FN_F_4241_02；FN_F_4241_03";
        attribute :>> linkedFunctionNames = "传递能量/介质、控制运行；传递能量/介质、控制运行；控制受电弓电子控制单元运行；报告受电弓电子控制单元运行状态；传递能量/介质、控制运行；传递能量/介质；传递真空断路器电能；传递非真空隔离开关电能；控制运行、检测运行参数；检测高压电压互感器状态；检测并贯通高压电流互感器物理量；路由高压控制输入输出单元输入输出信号；协调高压控制输入输出单元接口交互；报告高压控制输入输出单元运行状态；控制高压控制单元运行；协调高压控制单元接口交互；报告高压控制单元运行状态；控制运行、反馈运行状态；控制处理单元运行；报告处理单元运行状态；统计处理单元运行数据";
        attribute :>> linkedProductIDs = "4100；4110；411C；4200；4210；4211；4212；4230；4235；4236；4238；4239；4240；4241";
        attribute :>> linkedProductNames = "高压受流；受电弓总成；受电弓电子控制单元；网侧高压分配及控制；高压开关；真空断路器；非真空隔离开关；高压保护及检测部件；高压电压互感器；高压电流互感器；高压控制输入输出单元；高压控制单元；能量测量；处理单元";
        attribute :>> functionCoverageCount = "21";
        attribute :>> coverageStatus = "FULL";
        attribute :>> derivationReason = "项目供电制式需求规定仿真名义供电条件，但未提出受电弓电子单元、高压开关、测量和I/O状态控制行为；这些功能由现有4100/4200产品及真实allocation支撑。";
        attribute :>> relatedRequirementIDs = "DRV-PWR-002；DRV-PWR-003；PRJ-PWR-001";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> modelCoverage = "COVERED";
        attribute :>> notes = "工程派生需求；不声明为标准直接要求，不增加或修改SysML对象。";
        attribute :>> evidenceSource = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml";
    }

    requirement req_DRV_PWR_002 : RailRequirementV2 {
        attribute :>> requirementID = "DRV-PWR-002";
        attribute :>> parentRequirementIDs = "PRJ-PWR-001";
        attribute :>> requirementLevel = "L2_DERIVED";
        attribute :>> domain = "供电";
        attribute :>> topicGroup = "POWER_SUPPLY";
        attribute :>> name = "牵引回流与接地通路";
        attribute :>> text = "牵引回流及接地系统应通过已建模接地变压器、主回路接地电阻和回流碳刷等部件提供牵引回流与接地能量传递通路。";
        attribute :>> requirementType = "工程功能要求";
        attribute :>> sourceType = "ENGINEERING_DERIVED";
        attribute :>> standardNo = "";
        attribute :>> standardClause = "";
        attribute :>> criteria = "模型判据：所列既有Function及其SysML allocation存在；本判据不表示标准符合性或试验验证通过。";
        attribute :>> applicableConditions = "适用于本项目现有SysML产品边界及已建模运行/控制接口。";
        attribute :>> keywords = "牵引回流；回流通路；接地；接地变压器；接地电阻；回流碳刷；主回路；供电；高压；接触网；受电弓；主变压器";
        attribute :>> synonyms = "回流系统；主回路接地；轨道回流；网侧供电；牵引供电；受流系统；高压电源";
        attribute :>> userPhrases = "牵引电流如何回流；主回路接地由哪些部件实现；回流碳刷相关要求是什么";
        attribute :>> semanticTopics = "POWER_SUPPLY；牵引供电；回流；接地";
        attribute :>> systemTerms = "4400；回流及接地；4410；主回路回流设备；4411；接地变压器；4412；主回路接地电阻；4413；回流碳刷";
        attribute :>> actionTerms = "传递；回流；接地；提供";
        attribute :>> objectTerms = "回流电能；接地变压器；接地电阻；回流碳刷；电能；受电弓；接地；回流";
        attribute :>> expectedFunctionSemantics = "牵引回流及接地系统应通过已建模接地变压器、主回路接地电阻和回流碳刷等部件提供牵引回流与接地能量传递通路。";
        attribute :>> linkedFunctionIDs = "FN_F_4400_01；FN_F_4410_01；FN_F_4411_01；FN_F_4412_01；FN_F_4413_01";
        attribute :>> linkedFunctionNames = "传递能量/介质；传递能量/介质；传递接地变压器物理能量；传递主回路接地电阻物理能量；传递回流碳刷电能";
        attribute :>> linkedProductIDs = "4400；4410；4411；4412；4413";
        attribute :>> linkedProductNames = "回流及接地；主回路回流设备；接地变压器；主回路接地电阻；回流碳刷";
        attribute :>> functionCoverageCount = "5";
        attribute :>> coverageStatus = "FULL";
        attribute :>> derivationReason = "25 kV供电项目需求没有展开回流和接地组成的工程行为；4400及其真实分配部件构成同一回流/接地目标链。";
        attribute :>> relatedRequirementIDs = "DRV-PWR-001；DRV-PWR-003；PRJ-PWR-001";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> modelCoverage = "COVERED";
        attribute :>> notes = "工程派生需求；不声明为标准直接要求，不增加或修改SysML对象。";
        attribute :>> evidenceSource = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml";
    }

    requirement req_DRV_PWR_003 : RailRequirementV2 {
        attribute :>> requirementID = "DRV-PWR-003";
        attribute :>> parentRequirementIDs = "PRJ-PWR-001；REQ-TRAC-004";
        attribute :>> requirementLevel = "L2_DERIVED";
        attribute :>> domain = "供电";
        attribute :>> topicGroup = "POWER_SUPPLY";
        attribute :>> name = "主变压器控制与状态监测";
        attribute :>> text = "牵引变压器及其控制装置应传递变压器支路电能，监测既有检测保护元件状态，并提供控制装置运行状态。";
        attribute :>> requirementType = "工程功能要求";
        attribute :>> sourceType = "ENGINEERING_DERIVED";
        attribute :>> standardNo = "";
        attribute :>> standardClause = "";
        attribute :>> criteria = "模型判据：所列既有Function及其SysML allocation存在；本判据不表示标准符合性或试验验证通过。";
        attribute :>> applicableConditions = "适用于本项目现有SysML产品边界及已建模运行/控制接口。";
        attribute :>> keywords = "主变压器；变压器控制；检测保护元件；变压器状态；电抗器；变压器支路；状态报告；供电；高压；接触网；受电弓；高压分配";
        attribute :>> synonyms = "牵引变压器；变压器监测；变压器控制装置；网侧供电；牵引供电；受流系统；高压电源";
        attribute :>> userPhrases = "主变压器保护元件状态怎么监测；变压器控制装置会报告哪些状态；主变压器支路电能如何传递";
        attribute :>> semanticTopics = "POWER_SUPPLY；牵引供电；主变压器；状态监测；电气保护";
        attribute :>> systemTerms = "4500；主变压器及其冷却；4510；主变压器主体及其控制；4513；电抗器；4517；主变压器检测及保护元件；4518；主变压器控制装置";
        attribute :>> actionTerms = "传递；监测；控制；报告；检测；转换；保护；提供；分配";
        attribute :>> objectTerms = "变压器；电抗器；保护元件状态；控制装置状态；电能；受电弓；运行状态";
        attribute :>> expectedFunctionSemantics = "牵引变压器及其控制装置应传递变压器支路电能，监测既有检测保护元件状态，并提供控制装置运行状态。";
        attribute :>> linkedFunctionIDs = "FN_F_4500_01；FN_F_4510_01；FN_F_4513_01；FN_F_4517_01；FN_F_4518_01；FN_F_4518_02";
        attribute :>> linkedFunctionNames = "转换能量/物理量、控制运行；转换能量/物理量、控制运行；传递电抗器电能；检测主变压器检测及保护元件状态；控制主变压器控制装置运行；报告主变压器控制装置运行状态";
        attribute :>> linkedProductIDs = "4500；4510；4513；4517；4518";
        attribute :>> linkedProductNames = "主变压器及其冷却；主变压器主体及其控制；电抗器；主变压器检测及保护元件；主变压器控制装置";
        attribute :>> functionCoverageCount = "6";
        attribute :>> coverageStatus = "FULL";
        attribute :>> derivationReason = "已有供电制式和电能转换需求没有覆盖主变压器支路传递、检测保护元件及控制装置状态报告；对应功能集中分配到4500产品边界。";
        attribute :>> relatedRequirementIDs = "DRV-PWR-001；DRV-PWR-002；PRJ-PWR-001";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> modelCoverage = "COVERED";
        attribute :>> notes = "工程派生需求；不声明为标准直接要求，不增加或修改SysML对象。";
        attribute :>> evidenceSource = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml";
    }

    requirement req_DRV_TRAC_001 : RailRequirementV2 {
        attribute :>> requirementID = "DRV-TRAC-001";
        attribute :>> parentRequirementIDs = "REQ-TRAC-001；REQ-TRAC-004";
        attribute :>> requirementLevel = "L2_DERIVED";
        attribute :>> domain = "牵引";
        attribute :>> topicGroup = "TRACTION";
        attribute :>> name = "牵引传动机械能传递";
        attribute :>> text = "牵引传动系统应将牵引电机输出的机械能经联轴器、齿轮箱和轮轴传递至轮对，并保持传动链各级机械能传递关系可追溯。";
        attribute :>> requirementType = "工程功能要求";
        attribute :>> sourceType = "ENGINEERING_DERIVED";
        attribute :>> standardNo = "";
        attribute :>> standardClause = "";
        attribute :>> criteria = "模型判据：所列既有Function及其SysML allocation存在；本判据不表示标准符合性或试验验证通过。";
        attribute :>> applicableConditions = "适用于本项目现有SysML产品边界及已建模运行/控制接口。";
        attribute :>> keywords = "牵引传动；机械能传递；联轴器；齿轮箱；轮轴；轮对；电机侧传动；传动链；牵引；牵引力；牵引控制；牵引变流器";
        attribute :>> synonyms = "牵引传动链；电机至轮对传动；机械传动；牵引驱动；电机牵引；牵引传动";
        attribute :>> userPhrases = "电机的机械能怎样传到轮对；联轴器和齿轮箱属于哪些牵引要求；我想看牵引传动链的要求";
        attribute :>> semanticTopics = "TRACTION；牵引；机械能传递；传动链";
        attribute :>> systemTerms = "3100；轮轴组成；3110；车轮车轴；3112；车轴；3120；齿轮箱及附件；3121；齿轮箱主体；3500；牵引传动耦合组件及其附件；3510；传动耦合机构；3511；联轴节(电机侧)；3512；联轴节(齿轮箱侧)；3514；万向轴";
        attribute :>> actionTerms = "传递；转换；控制；输出；耗散";
        attribute :>> objectTerms = "机械能；联轴器；齿轮箱；轮轴；轮对；牵引力";
        attribute :>> expectedFunctionSemantics = "牵引传动系统应将牵引电机输出的机械能经联轴器、齿轮箱和轮轴传递至轮对，并保持传动链各级机械能传递关系可追溯。";
        attribute :>> linkedFunctionIDs = "FN_F_3100_01；FN_F_3110_01；FN_F_3112_01；FN_F_3120_01；FN_F_3121_01；FN_F_3500_01；FN_F_3510_01；FN_F_3511_01；FN_F_3512_01；FN_F_3514_01";
        attribute :>> linkedFunctionNames = "转换能量/物理量、传递能量/介质；传递能量/介质、耗散能量；传递车轴机械能；转换能量/物理量；转换齿轮箱主体机械参数；传递能量/介质；传递能量/介质；传递联轴节(电机侧)机械能；传递联轴节(齿轮箱侧)机械能；传递万向轴机械能";
        attribute :>> linkedProductIDs = "3100；3110；3112；3120；3121；3500；3510；3511；3512；3514";
        attribute :>> linkedProductNames = "轮轴组成；车轮车轴；车轴；齿轮箱及附件；齿轮箱主体；牵引传动耦合组件及其附件；传动耦合机构；联轴节(电机侧)；联轴节(齿轮箱侧)；万向轴";
        attribute :>> functionCoverageCount = "10";
        attribute :>> coverageStatus = "FULL";
        attribute :>> derivationReason = "现有牵引特性与能量转换需求没有明确表达电机至轮对的机械传动链；Function 3100/3500 及其真实分配到的轮轴、齿轮箱和联轴器提供了成组实现证据。";
        attribute :>> relatedRequirementIDs = "DRV-TRAC-002；DRV-TRAC-003；DRV-TRAC-004；REQ-TRAC-001；REQ-TRAC-002；REQ-TRAC-003；REQ-TRAC-004";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> modelCoverage = "COVERED";
        attribute :>> notes = "工程派生需求；不声明为标准直接要求，不增加或修改SysML对象。";
        attribute :>> evidenceSource = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml";
    }

    requirement req_DRV_TRAC_002 : RailRequirementV2 {
        attribute :>> requirementID = "DRV-TRAC-002";
        attribute :>> parentRequirementIDs = "REQ-TRAC-003；REQ-BRK-010";
        attribute :>> requirementLevel = "L2_DERIVED";
        attribute :>> domain = "牵引";
        attribute :>> topicGroup = "TRACTION";
        attribute :>> name = "黏着增强撒砂控制";
        attribute :>> text = "黏着增强装置应接收撒砂控制输入，驱动撒砂控制单元、阀板和喷嘴执行撒砂动作，并向相关控制边界提供装置运行状态。";
        attribute :>> requirementType = "工程功能要求";
        attribute :>> sourceType = "ENGINEERING_DERIVED";
        attribute :>> standardNo = "";
        attribute :>> standardClause = "";
        attribute :>> criteria = "模型判据：所列既有Function及其SysML allocation存在；本判据不表示标准符合性或试验验证通过。";
        attribute :>> applicableConditions = "适用于本项目现有SysML产品边界及已建模运行/控制接口。";
        attribute :>> keywords = "撒砂；黏着增强；轮轨黏着；防滑；砂阀；撒砂喷嘴；撒砂控制；黏着利用；牵引；牵引力；牵引控制；牵引变流器";
        attribute :>> synonyms = "撒砂装置；砂控；黏着增强装置；牵引驱动；电机牵引；牵引传动";
        attribute :>> userPhrases = "空转时撒砂装置怎么动作；撒砂按钮会触发哪些设备；我想看黏着增强和防滑相关要求";
        attribute :>> semanticTopics = "TRACTION；黏着控制；撒砂；防滑";
        attribute :>> systemTerms = "3800；辅助增粘及轮缘润滑；3810；撒砂装置；3811；撒砂控制单元；3813；撒砂阀板组件；3814；撒砂喷嘴组件；D13B；撒砂按钮；D100；操纵设施";
        attribute :>> actionTerms = "控制；执行；报告；传递；转换；提供";
        attribute :>> objectTerms = "撒砂控制输入；撒砂阀板；喷嘴；运行状态；黏着；牵引力；撒砂";
        attribute :>> expectedFunctionSemantics = "黏着增强装置应接收撒砂控制输入，驱动撒砂控制单元、阀板和喷嘴执行撒砂动作，并向相关控制边界提供装置运行状态。";
        attribute :>> linkedFunctionIDs = "FN_F_3800_01；FN_F_3810_01；FN_F_3811_01；FN_F_3811_02；FN_F_3813_01；FN_F_3814_01；FN_F_D13B_01";
        attribute :>> linkedFunctionNames = "转换能量/物理量、控制运行；转换能量/物理量、控制运行；控制撒砂控制单元运行；报告撒砂控制单元运行状态；执行撒砂阀板组件动作；执行撒砂喷嘴组件动作；提供撒砂按钮边界交互";
        attribute :>> linkedProductIDs = "3800；3810；3811；3813；3814；D13B";
        attribute :>> linkedProductNames = "辅助增粘及轮缘润滑；撒砂装置；撒砂控制单元；撒砂阀板组件；撒砂喷嘴组件；撒砂按钮";
        attribute :>> functionCoverageCount = "7";
        attribute :>> coverageStatus = "FULL";
        attribute :>> derivationReason = "现有防滑需求涉及黏着，但未覆盖撒砂控制单元、执行阀板/喷嘴及司机撒砂按钮这组真实 Functions；该派生项以这些已分配功能为边界，不声称模型存在自动滑移率触发逻辑。";
        attribute :>> relatedRequirementIDs = "DRV-TRAC-001；DRV-TRAC-003；DRV-TRAC-004；REQ-TRAC-001；REQ-TRAC-002；REQ-TRAC-003；REQ-TRAC-004";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> modelCoverage = "COVERED";
        attribute :>> notes = "工程派生需求；不声明为标准直接要求，不增加或修改SysML对象。";
        attribute :>> evidenceSource = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml";
    }

    requirement req_DRV_TRAC_003 : RailRequirementV2 {
        attribute :>> requirementID = "DRV-TRAC-003";
        attribute :>> parentRequirementIDs = "REQ-TRAC-001；REQ-TRAC-002；REQ-TRAC-004";
        attribute :>> requirementLevel = "L2_DERIVED";
        attribute :>> domain = "牵引";
        attribute :>> topicGroup = "TRACTION";
        attribute :>> name = "牵引变流器控制与保护状态";
        attribute :>> text = "牵引变流器应控制网侧和电机侧变流控制模块，协调其接口交互，监测检测保护组件状态，并提供模块运行状态和保护限制信息。";
        attribute :>> requirementType = "工程功能要求";
        attribute :>> sourceType = "ENGINEERING_DERIVED";
        attribute :>> standardNo = "";
        attribute :>> standardClause = "";
        attribute :>> criteria = "模型判据：所列既有Function及其SysML allocation存在；本判据不表示标准符合性或试验验证通过。";
        attribute :>> applicableConditions = "适用于本项目现有SysML产品边界及已建模运行/控制接口。";
        attribute :>> keywords = "牵引变流器控制；网侧变流器；电机侧变流器；变流模块；接口协调；变流保护；检测组件；运行状态；牵引；牵引力；牵引控制；牵引变流器";
        attribute :>> synonyms = "牵引变流控制；变流器状态监测；变流模块保护；牵引驱动；电机牵引；牵引传动";
        attribute :>> userPhrases = "网侧和电机侧变流器怎样协调；变流器的保护和状态由谁处理；牵引变流器检测组件需要监测什么";
        attribute :>> semanticTopics = "TRACTION；牵引变流器；变流控制；变流保护；状态监测";
        attribute :>> systemTerms = "5100；牵引变流器主体及其控制；5110；牵引变流器控制；5111；网侧变流器控制模块；5112；电机侧变流器控制模块；5113；变流器检测保护组件；5130；变流模块；5131；网侧变流模块；5132；电机侧变流模块";
        attribute :>> actionTerms = "控制；协调；监测；限制；保护；报告；检测；执行；转换；反馈；提供";
        attribute :>> objectTerms = "网侧变流模块；电机侧变流模块；检测保护组件；运行状态；牵引力";
        attribute :>> expectedFunctionSemantics = "牵引变流器应控制网侧和电机侧变流控制模块，协调其接口交互，监测检测保护组件状态，并提供模块运行状态和保护限制信息。";
        attribute :>> linkedFunctionIDs = "FN_F_5100_01；FN_F_5110_01；FN_F_5111_01；FN_F_5111_02；FN_F_5111_03；FN_F_5111_04；FN_F_5112_02；FN_F_5112_03；FN_F_5112_04；FN_F_5113_01；FN_F_5130_01；FN_F_5131_02；FN_F_5132_02";
        attribute :>> linkedFunctionNames = "转换能量/物理量、控制运行；控制运行、检测运行参数；控制网侧变流器控制模块运行；协调网侧变流器控制模块接口交互；限制并保护网侧变流器控制模块运行；报告网侧变流器控制模块运行状态；协调电机侧变流器控制模块接口交互；限制并保护电机侧变流器控制模块运行；报告电机侧变流器控制模块运行状态；检测变流器检测保护组件状态；转换能量/物理量、控制运行；执行网侧变流控制并反馈运行状态；响应电机侧变流控制并反馈运行状态";
        attribute :>> linkedProductIDs = "5100；5110；5111；5112；5113；5130；5131；5132";
        attribute :>> linkedProductNames = "牵引变流器主体及其控制；牵引变流器控制；网侧变流器控制模块；电机侧变流器控制模块；变流器检测保护组件；变流模块；网侧变流模块；电机侧变流模块";
        attribute :>> functionCoverageCount = "13";
        attribute :>> coverageStatus = "FULL";
        attribute :>> derivationReason = "原牵引性能和能量转换需求没有细化变流控制模块的接口协调、保护和状态报告；缺口由5100下的控制、保护、状态和测量Function组成一组补足。";
        attribute :>> relatedRequirementIDs = "DRV-TRAC-001；DRV-TRAC-002；DRV-TRAC-004；REQ-TRAC-001；REQ-TRAC-002；REQ-TRAC-003；REQ-TRAC-004";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> modelCoverage = "COVERED";
        attribute :>> notes = "工程派生需求；不声明为标准直接要求，不增加或修改SysML对象。";
        attribute :>> evidenceSource = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml";
    }

    requirement req_DRV_TRAC_004 : RailRequirementV2 {
        attribute :>> requirementID = "DRV-TRAC-004";
        attribute :>> parentRequirementIDs = "REQ-TRAC-004；PRJ-PWR-001";
        attribute :>> requirementLevel = "L2_DERIVED";
        attribute :>> domain = "牵引";
        attribute :>> topicGroup = "TRACTION";
        attribute :>> name = "中间直流环节预充与放电保护";
        attribute :>> text = "牵引变流器中间直流环节应通过既有输入、预充电和放电电阻支路执行电能传递与耗散，并控制和监测相应支路状态。";
        attribute :>> requirementType = "工程功能要求";
        attribute :>> sourceType = "ENGINEERING_DERIVED";
        attribute :>> standardNo = "";
        attribute :>> standardClause = "";
        attribute :>> criteria = "模型判据：所列既有Function及其SysML allocation存在；本判据不表示标准符合性或试验验证通过。";
        attribute :>> applicableConditions = "适用于本项目现有SysML产品边界及已建模运行/控制接口。";
        attribute :>> keywords = "中间直流环节；直流母线；预充电；放电电阻；直流环节放电；输入组件；支路保护；直流电压检测；牵引；牵引力；牵引控制；牵引变流器";
        attribute :>> synonyms = "DC-Link；直流链；母线预充；母线泄放；牵引驱动；电机牵引；牵引传动";
        attribute :>> userPhrases = "直流母线启动前怎么预充；中间直流环节如何放电；放电电阻支路有哪些保护和状态";
        attribute :>> semanticTopics = "TRACTION；牵引变流器；中间直流环节；预充电；放电保护";
        attribute :>> systemTerms = "5120；输入及预充电单元；5100；牵引变流器主体及其控制；5121；预充电组件；5122；输入组件；5133；放电电阻控制模块；5140；中间直流环节组件及其；5142；放电电阻器；5145；中间直流环节检测保护组件";
        attribute :>> actionTerms = "传递；预充；控制；保护；耗散；监测；统计；检测；执行；限制；报告";
        attribute :>> objectTerms = "中间直流环节；预充电组件；放电电阻；支路状态；牵引力；电能；电压；运行状态";
        attribute :>> expectedFunctionSemantics = "牵引变流器中间直流环节应通过既有输入、预充电和放电电阻支路执行电能传递与耗散，并控制和监测相应支路状态。";
        attribute :>> linkedFunctionIDs = "FN_F_5120_01；FN_F_5121_01；FN_F_5122_01；FN_F_5133_01；FN_F_5133_02；FN_F_5133_03；FN_F_5140_01；FN_F_5142_01；FN_F_5142_02；FN_F_5145_01";
        attribute :>> linkedFunctionNames = "传递能量/介质；传递预充电组件电能；传递输入组件电能；控制放电电阻控制模块运行；限制并保护放电电阻控制模块运行；报告放电电阻控制模块运行状态；耗散能量、检测运行参数；通过放电电阻器耗散能量；统计放电电阻器运行数据；检测中间直流环节检测保护组件状态";
        attribute :>> linkedProductIDs = "5120；5121；5122；5133；5140；5142；5145";
        attribute :>> linkedProductNames = "输入及预充电单元；预充电组件；输入组件；放电电阻控制模块；中间直流环节组件及其；放电电阻器；中间直流环节检测保护组件";
        attribute :>> functionCoverageCount = "10";
        attribute :>> coverageStatus = "FULL";
        attribute :>> derivationReason = "供电和能量转换需求未覆盖中间直流环节的输入/预充/放电电阻支路行为；这些Function均真实分配到牵引变流器5100下级产品。";
        attribute :>> relatedRequirementIDs = "DRV-TRAC-001；DRV-TRAC-002；DRV-TRAC-003；REQ-TRAC-001；REQ-TRAC-002；REQ-TRAC-003；REQ-TRAC-004";
        attribute :>> verificationStatus = "NOT_VERIFIED";
        attribute :>> modelCoverage = "COVERED";
        attribute :>> notes = "工程派生需求；不声明为标准直接要求，不增加或修改SysML对象。";
        attribute :>> evidenceSource = "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml";
    }

    connection def RequirementDerivationConnection {
        end parentRequirement : RailRequirementV2;
        end derivedRequirement : RailRequirementV2;
    }

    connection derivation_001 : RequirementDerivationConnection connect (req_REQ_BRK_001, req_DRV_BRK_001) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_002 : RequirementDerivationConnection connect (req_REQ_BRK_012, req_DRV_BRK_001) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_003 : RequirementDerivationConnection connect (req_REQ_BRK_001, req_DRV_BRK_002) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_004 : RequirementDerivationConnection connect (req_REQ_BRK_004, req_DRV_BRK_002) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_005 : RequirementDerivationConnection connect (req_REQ_BRK_013, req_DRV_BRK_002) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_006 : RequirementDerivationConnection connect (req_REQ_TRAC_002, req_DRV_CTL_001) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_007 : RequirementDerivationConnection connect (req_REQ_BRK_001, req_DRV_CTL_001) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_008 : RequirementDerivationConnection connect (req_REQ_BRK_002, req_DRV_CTL_001) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_009 : RequirementDerivationConnection connect (req_REQ_TRAC_002, req_DRV_CTL_002) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_010 : RequirementDerivationConnection connect (req_REQ_BRK_014, req_DRV_CTL_002) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_011 : RequirementDerivationConnection connect (req_REQ_ENE_003, req_DRV_CTL_002) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_012 : RequirementDerivationConnection connect (req_REQ_BRK_014, req_DRV_CTL_003) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_013 : RequirementDerivationConnection connect (req_REQ_BRK_015, req_DRV_CTL_003) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_014 : RequirementDerivationConnection connect (req_REQ_TRAC_003, req_DRV_CTL_003) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_015 : RequirementDerivationConnection connect (req_PRJ_PWR_001, req_DRV_PWR_001) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_016 : RequirementDerivationConnection connect (req_PRJ_PWR_001, req_DRV_PWR_002) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_017 : RequirementDerivationConnection connect (req_PRJ_PWR_001, req_DRV_PWR_003) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_018 : RequirementDerivationConnection connect (req_REQ_TRAC_004, req_DRV_PWR_003) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_019 : RequirementDerivationConnection connect (req_REQ_TRAC_001, req_DRV_TRAC_001) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_020 : RequirementDerivationConnection connect (req_REQ_TRAC_004, req_DRV_TRAC_001) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_021 : RequirementDerivationConnection connect (req_REQ_TRAC_003, req_DRV_TRAC_002) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_022 : RequirementDerivationConnection connect (req_REQ_BRK_010, req_DRV_TRAC_002) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_023 : RequirementDerivationConnection connect (req_REQ_TRAC_001, req_DRV_TRAC_003) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_024 : RequirementDerivationConnection connect (req_REQ_TRAC_002, req_DRV_TRAC_003) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_025 : RequirementDerivationConnection connect (req_REQ_TRAC_004, req_DRV_TRAC_003) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_026 : RequirementDerivationConnection connect (req_REQ_TRAC_004, req_DRV_TRAC_004) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_027 : RequirementDerivationConnection connect (req_PRJ_PWR_001, req_DRV_TRAC_004) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    satisfy req_REQ_ENE_001 by fu_F_X100_01;
    satisfy req_PRJ_ENE_001 by fu_F_X100_01;
    satisfy req_PRJ_ENE_004 by fu_F_X100_01;
    satisfy req_REQ_TRAC_001 by fu_F_5132_01;
    satisfy req_REQ_TRAC_001 by fu_F_5311_01;
    satisfy req_REQ_TRAC_001 by fu_F_5311_02;
    satisfy req_REQ_TRAC_001 by fu_F_5112_01;
    satisfy req_REQ_TRAC_002 by fu_F_5132_01;
    satisfy req_REQ_TRAC_002 by fu_F_5311_01;
    satisfy req_REQ_TRAC_002 by fu_F_5311_02;
    satisfy req_REQ_TRAC_002 by fu_F_5112_01;
    satisfy req_REQ_TRAC_003 by fu_F_7211_04;
    satisfy req_REQ_TRAC_003 by fu_F_722A_01;
    satisfy req_REQ_TRAC_003 by fu_F_5311_02;
    satisfy req_REQ_TRAC_004 by fu_F_4511_01;
    satisfy req_REQ_TRAC_004 by fu_F_5131_01;
    satisfy req_REQ_TRAC_004 by fu_F_5132_01;
    satisfy req_REQ_TRAC_004 by fu_F_5311_01;
    satisfy req_REQ_BRK_001 by fu_F_7211_01;
    satisfy req_REQ_BRK_001 by fu_F_7211_02;
    satisfy req_REQ_BRK_001 by fu_F_7211_03;
    satisfy req_REQ_BRK_001 by fu_F_7255_01;
    satisfy req_REQ_BRK_001 by fu_F_5311_01;
    satisfy req_REQ_BRK_002 by fu_F_7211_04;
    satisfy req_REQ_BRK_002 by fu_F_7226_01;
    satisfy req_REQ_BRK_002 by fu_F_7255_01;
    satisfy req_REQ_BRK_002 by fu_F_D121_01;
    satisfy req_REQ_BRK_003 by fu_F_7211_02;
    satisfy req_REQ_BRK_003 by fu_F_7211_03;
    satisfy req_REQ_BRK_003 by fu_F_7255_01;
    satisfy req_REQ_BRK_004 by fu_F_7211_02;
    satisfy req_REQ_BRK_004 by fu_F_7211_03;
    satisfy req_REQ_BRK_004 by fu_F_5311_01;
    satisfy req_REQ_BRK_004 by fu_F_7255_01;
    satisfy req_REQ_BRK_005 by fu_F_7224_01;
    satisfy req_REQ_BRK_005 by fu_F_7211_01;
    satisfy req_REQ_BRK_006 by fu_F_7211_02;
    satisfy req_REQ_BRK_006 by fu_F_5311_01;
    satisfy req_REQ_BRK_006 by fu_F_7255_01;
    satisfy req_REQ_BRK_007 by fu_F_7211_02;
    satisfy req_REQ_BRK_007 by fu_F_5311_01;
    satisfy req_REQ_BRK_007 by fu_F_X121_01;
    satisfy req_REQ_BRK_007 by fu_F_X112_02;
    satisfy req_REQ_BRK_008 by fu_F_7211_02;
    satisfy req_REQ_BRK_008 by fu_F_7211_03;
    satisfy req_REQ_BRK_008 by fu_F_7255_01;
    satisfy req_REQ_BRK_009 by fu_F_7211_02;
    satisfy req_REQ_BRK_009 by fu_F_7211_03;
    satisfy req_REQ_BRK_009 by fu_F_5311_01;
    satisfy req_REQ_BRK_009 by fu_F_7255_01;
    satisfy req_REQ_BRK_010 by fu_F_7211_04;
    satisfy req_REQ_BRK_010 by fu_F_722A_01;
    satisfy req_REQ_BRK_010 by fu_F_722B_01;
    satisfy req_REQ_BRK_011 by fu_F_7211_04;
    satisfy req_REQ_BRK_011 by fu_F_7255_01;
    satisfy req_REQ_BRK_012 by fu_F_7142_01;
    satisfy req_REQ_BRK_012 by fu_F_7131_01;
    satisfy req_REQ_BRK_012 by fu_F_7100_01;
    satisfy req_REQ_BRK_013 by fu_F_722B_01;
    satisfy req_REQ_BRK_013 by fu_F_722C_01;
    satisfy req_REQ_BRK_013 by fu_F_7255_01;
    satisfy req_REQ_BRK_014 by fu_F_8152_01;
    satisfy req_REQ_BRK_014 by fu_F_8152_02;
    satisfy req_REQ_BRK_014 by fu_F_8128_01;
    satisfy req_REQ_BRK_014 by fu_F_722B_01;
    satisfy req_REQ_BRK_014 by fu_F_722C_01;
    satisfy req_REQ_BRK_015 by fu_F_7211_04;
    satisfy req_REQ_BRK_015 by fu_F_7226_01;
    satisfy req_REQ_BRK_015 by fu_F_7255_01;
    satisfy req_REQ_BRK_015 by fu_F_8152_01;
    satisfy req_REQ_ENE_002 by fu_F_X113_01;
    satisfy req_REQ_ENE_002 by fu_F_X112_03;
    satisfy req_REQ_ENE_002 by fu_F_8122_03;
    satisfy req_REQ_ENE_003 by fu_F_X121_02;
    satisfy req_REQ_ENE_003 by fu_F_X112_03;
    satisfy req_REQ_ENE_003 by fu_F_8122_03;
    satisfy req_REQ_ENE_003 by fu_F_8128_03;
    satisfy req_REQ_ENE_004 by fu_F_X122_01;
    satisfy req_REQ_ENE_004 by fu_F_X112_01;
    satisfy req_REQ_ENE_005 by fu_F_X121_01;
    satisfy req_REQ_ENE_005 by fu_F_X112_01;
    satisfy req_REQ_ENE_006 by fu_F_X124_01;
    satisfy req_REQ_ENE_007 by fu_F_X124_01;
    satisfy req_REQ_ENE_007 by fu_F_X112_02;
    satisfy req_REQ_ENE_008 by fu_F_X123_01;
    satisfy req_REQ_ENE_008 by fu_F_X112_02;
    satisfy req_REQ_ENE_009 by fu_F_X112_02;
    satisfy req_REQ_ENE_009 by fu_F_X113_01;
    satisfy req_PRJ_BRK_001 by fu_F_7211_01;
    satisfy req_PRJ_BRK_001 by fu_F_7211_02;
    satisfy req_PRJ_BRK_001 by fu_F_7211_03;
    satisfy req_PRJ_BRK_001 by fu_F_7255_01;
    satisfy req_PRJ_BRK_001 by fu_F_5311_01;
    satisfy req_PRJ_ENE_002 by fu_F_X112_02;
    satisfy req_PRJ_ENE_002 by fu_F_X112_01;
    satisfy req_PRJ_ENE_002 by fu_F_X121_01;
    satisfy req_PRJ_ENE_003 by fu_F_X123_01;
    satisfy req_PRJ_ENE_003 by fu_F_X112_02;
    satisfy req_PRJ_PWR_001 by fu_F_4111_01;
    satisfy req_PRJ_PWR_001 by fu_F_4511_01;
    satisfy req_PRJ_PWR_001 by fu_F_5131_01;
    satisfy req_PRJ_PWR_001 by fu_F_5132_01;
    satisfy req_REQ_TRAC_001 by fu_F_3100_01;
    satisfy req_REQ_TRAC_001 by fu_F_3112_01;
    satisfy req_REQ_TRAC_001 by fu_F_3120_01;
    satisfy req_REQ_TRAC_001 by fu_F_3121_01;
    satisfy req_REQ_TRAC_001 by fu_F_3500_01;
    satisfy req_REQ_TRAC_001 by fu_F_3510_01;
    satisfy req_REQ_TRAC_001 by fu_F_3511_01;
    satisfy req_REQ_TRAC_001 by fu_F_3512_01;
    satisfy req_REQ_TRAC_001 by fu_F_3514_01;
    satisfy req_REQ_TRAC_001 by fu_F_3600_01;
    satisfy req_REQ_TRAC_001 by fu_F_3640_01;
    satisfy req_REQ_TRAC_001 by fu_F_3641_01;
    satisfy req_REQ_TRAC_001 by fu_F_3643_01;
    satisfy req_REQ_TRAC_001 by fu_F_3644_01;
    satisfy req_REQ_TRAC_001 by fu_F_5300_01;
    satisfy req_REQ_TRAC_001 by fu_F_5310_01;
    satisfy req_REQ_TRAC_003 by fu_F_3641_01;
    satisfy req_REQ_TRAC_003 by fu_F_3643_01;
    satisfy req_REQ_TRAC_003 by fu_F_3644_01;
    satisfy req_REQ_TRAC_004 by fu_F_3100_01;
    satisfy req_REQ_TRAC_004 by fu_F_3112_01;
    satisfy req_REQ_TRAC_004 by fu_F_3120_01;
    satisfy req_REQ_TRAC_004 by fu_F_3121_01;
    satisfy req_REQ_TRAC_004 by fu_F_3500_01;
    satisfy req_REQ_TRAC_004 by fu_F_3510_01;
    satisfy req_REQ_TRAC_004 by fu_F_3511_01;
    satisfy req_REQ_TRAC_004 by fu_F_3512_01;
    satisfy req_REQ_TRAC_004 by fu_F_3514_01;
    satisfy req_REQ_TRAC_004 by fu_F_4500_01;
    satisfy req_REQ_TRAC_004 by fu_F_4510_01;
    satisfy req_REQ_TRAC_004 by fu_F_4513_01;
    satisfy req_REQ_TRAC_004 by fu_F_5300_01;
    satisfy req_REQ_TRAC_004 by fu_F_5310_01;
    satisfy req_REQ_BRK_001 by fu_F_3111_01;
    satisfy req_REQ_BRK_001 by fu_F_3130_01;
    satisfy req_REQ_BRK_001 by fu_F_3131_01;
    satisfy req_REQ_BRK_001 by fu_F_3132_01;
    satisfy req_REQ_BRK_001 by fu_F_3133_01;
    satisfy req_REQ_BRK_001 by fu_F_7252_01;
    satisfy req_REQ_BRK_001 by fu_F_7254_01;
    satisfy req_REQ_BRK_004 by fu_F_3130_01;
    satisfy req_REQ_BRK_004 by fu_F_3131_01;
    satisfy req_REQ_BRK_004 by fu_F_3132_01;
    satisfy req_REQ_BRK_004 by fu_F_3133_01;
    satisfy req_REQ_ENE_001 by fu_F_X110_01;
    satisfy req_REQ_ENE_001 by fu_F_X111_01;
    satisfy req_REQ_ENE_001 by fu_F_X111_02;
    satisfy req_REQ_ENE_005 by fu_F_8166_01;
    satisfy req_REQ_ENE_005 by fu_F_8166_02;
    satisfy req_REQ_ENE_005 by fu_F_8166_03;
    satisfy req_REQ_ENE_005 by fu_F_8166_04;
    satisfy req_PRJ_PWR_001 by fu_F_4100_01;
    satisfy req_PRJ_PWR_001 by fu_F_4110_01;
    satisfy req_PRJ_PWR_001 by fu_F_4200_01;
    satisfy req_PRJ_PWR_001 by fu_F_4210_01;
    satisfy req_PRJ_PWR_001 by fu_F_4211_01;
    satisfy req_PRJ_PWR_001 by fu_F_4212_01;
    satisfy req_DRV_TRAC_001 by fu_F_3100_01;
    satisfy req_DRV_TRAC_001 by fu_F_3110_01;
    satisfy req_DRV_TRAC_001 by fu_F_3112_01;
    satisfy req_DRV_TRAC_001 by fu_F_3120_01;
    satisfy req_DRV_TRAC_001 by fu_F_3121_01;
    satisfy req_DRV_TRAC_001 by fu_F_3500_01;
    satisfy req_DRV_TRAC_001 by fu_F_3510_01;
    satisfy req_DRV_TRAC_001 by fu_F_3511_01;
    satisfy req_DRV_TRAC_001 by fu_F_3512_01;
    satisfy req_DRV_TRAC_001 by fu_F_3514_01;
    satisfy req_DRV_TRAC_002 by fu_F_3800_01;
    satisfy req_DRV_TRAC_002 by fu_F_3810_01;
    satisfy req_DRV_TRAC_002 by fu_F_3811_01;
    satisfy req_DRV_TRAC_002 by fu_F_3811_02;
    satisfy req_DRV_TRAC_002 by fu_F_3813_01;
    satisfy req_DRV_TRAC_002 by fu_F_3814_01;
    satisfy req_DRV_TRAC_002 by fu_F_D13B_01;
    satisfy req_DRV_PWR_001 by fu_F_4100_01;
    satisfy req_DRV_PWR_001 by fu_F_4110_01;
    satisfy req_DRV_PWR_001 by fu_F_411C_01;
    satisfy req_DRV_PWR_001 by fu_F_411C_02;
    satisfy req_DRV_PWR_001 by fu_F_4200_01;
    satisfy req_DRV_PWR_001 by fu_F_4210_01;
    satisfy req_DRV_PWR_001 by fu_F_4211_01;
    satisfy req_DRV_PWR_001 by fu_F_4212_01;
    satisfy req_DRV_PWR_001 by fu_F_4230_01;
    satisfy req_DRV_PWR_001 by fu_F_4235_01;
    satisfy req_DRV_PWR_001 by fu_F_4236_01;
    satisfy req_DRV_PWR_001 by fu_F_4238_01;
    satisfy req_DRV_PWR_001 by fu_F_4238_02;
    satisfy req_DRV_PWR_001 by fu_F_4238_03;
    satisfy req_DRV_PWR_001 by fu_F_4239_01;
    satisfy req_DRV_PWR_001 by fu_F_4239_02;
    satisfy req_DRV_PWR_001 by fu_F_4239_03;
    satisfy req_DRV_PWR_001 by fu_F_4240_01;
    satisfy req_DRV_PWR_001 by fu_F_4241_01;
    satisfy req_DRV_PWR_001 by fu_F_4241_02;
    satisfy req_DRV_PWR_001 by fu_F_4241_03;
    satisfy req_DRV_PWR_002 by fu_F_4400_01;
    satisfy req_DRV_PWR_002 by fu_F_4410_01;
    satisfy req_DRV_PWR_002 by fu_F_4411_01;
    satisfy req_DRV_PWR_002 by fu_F_4412_01;
    satisfy req_DRV_PWR_002 by fu_F_4413_01;
    satisfy req_DRV_PWR_003 by fu_F_4500_01;
    satisfy req_DRV_PWR_003 by fu_F_4510_01;
    satisfy req_DRV_PWR_003 by fu_F_4513_01;
    satisfy req_DRV_PWR_003 by fu_F_4517_01;
    satisfy req_DRV_PWR_003 by fu_F_4518_01;
    satisfy req_DRV_PWR_003 by fu_F_4518_02;
    satisfy req_DRV_TRAC_003 by fu_F_5100_01;
    satisfy req_DRV_TRAC_003 by fu_F_5110_01;
    satisfy req_DRV_TRAC_003 by fu_F_5111_01;
    satisfy req_DRV_TRAC_003 by fu_F_5111_02;
    satisfy req_DRV_TRAC_003 by fu_F_5111_03;
    satisfy req_DRV_TRAC_003 by fu_F_5111_04;
    satisfy req_DRV_TRAC_003 by fu_F_5112_02;
    satisfy req_DRV_TRAC_003 by fu_F_5112_03;
    satisfy req_DRV_TRAC_003 by fu_F_5112_04;
    satisfy req_DRV_TRAC_003 by fu_F_5113_01;
    satisfy req_DRV_TRAC_003 by fu_F_5130_01;
    satisfy req_DRV_TRAC_003 by fu_F_5131_02;
    satisfy req_DRV_TRAC_003 by fu_F_5132_02;
    satisfy req_DRV_TRAC_004 by fu_F_5120_01;
    satisfy req_DRV_TRAC_004 by fu_F_5121_01;
    satisfy req_DRV_TRAC_004 by fu_F_5122_01;
    satisfy req_DRV_TRAC_004 by fu_F_5133_01;
    satisfy req_DRV_TRAC_004 by fu_F_5133_02;
    satisfy req_DRV_TRAC_004 by fu_F_5133_03;
    satisfy req_DRV_TRAC_004 by fu_F_5140_01;
    satisfy req_DRV_TRAC_004 by fu_F_5142_01;
    satisfy req_DRV_TRAC_004 by fu_F_5142_02;
    satisfy req_DRV_TRAC_004 by fu_F_5145_01;
    satisfy req_DRV_BRK_001 by fu_F_7100_01;
    satisfy req_DRV_BRK_001 by fu_F_7120_01;
    satisfy req_DRV_BRK_001 by fu_F_7124_01;
    satisfy req_DRV_BRK_001 by fu_F_7130_01;
    satisfy req_DRV_BRK_001 by fu_F_7131_01;
    satisfy req_DRV_BRK_001 by fu_F_7140_01;
    satisfy req_DRV_BRK_001 by fu_F_7142_01;
    satisfy req_DRV_BRK_002 by fu_F_7200_01;
    satisfy req_DRV_BRK_002 by fu_F_7210_01;
    satisfy req_DRV_BRK_002 by fu_F_7213_01;
    satisfy req_DRV_BRK_002 by fu_F_7220_01;
    satisfy req_DRV_BRK_002 by fu_F_7222_01;
    satisfy req_DRV_BRK_002 by fu_F_7223_01;
    satisfy req_DRV_BRK_002 by fu_F_7225_01;
    satisfy req_DRV_BRK_002 by fu_F_7227_01;
    satisfy req_DRV_BRK_002 by fu_F_7228_01;
    satisfy req_DRV_BRK_002 by fu_F_7229_01;
    satisfy req_DRV_BRK_002 by fu_F_7250_01;
    satisfy req_DRV_BRK_002 by fu_F_7252_01;
    satisfy req_DRV_BRK_002 by fu_F_7254_01;
    satisfy req_DRV_BRK_002 by fu_F_7280_01;
    satisfy req_DRV_BRK_002 by fu_F_7281_01;
    satisfy req_DRV_BRK_002 by fu_F_7284_01;
    satisfy req_DRV_BRK_002 by fu_F_7285_01;
    satisfy req_DRV_CTL_001 by fu_F_D100_01;
    satisfy req_DRV_CTL_001 by fu_F_D110_01;
    satisfy req_DRV_CTL_001 by fu_F_D112_01;
    satisfy req_DRV_CTL_001 by fu_F_D113_01;
    satisfy req_DRV_CTL_001 by fu_F_D114_01;
    satisfy req_DRV_CTL_001 by fu_F_D120_01;
    satisfy req_DRV_CTL_001 by fu_F_D130_01;
    satisfy req_DRV_CTL_001 by fu_F_E100_01;
    satisfy req_DRV_CTL_001 by fu_F_8127_01;
    satisfy req_DRV_CTL_001 by fu_F_8127_02;
    satisfy req_DRV_CTL_002 by fu_F_8100_01;
    satisfy req_DRV_CTL_002 by fu_F_8120_01;
    satisfy req_DRV_CTL_002 by fu_F_8121_01;
    satisfy req_DRV_CTL_002 by fu_F_8121_02;
    satisfy req_DRV_CTL_002 by fu_F_8121_03;
    satisfy req_DRV_CTL_002 by fu_F_8122_01;
    satisfy req_DRV_CTL_002 by fu_F_8122_02;
    satisfy req_DRV_CTL_002 by fu_F_8122_04;
    satisfy req_DRV_CTL_002 by fu_F_8122_05;
    satisfy req_DRV_CTL_002 by fu_F_8125_01;
    satisfy req_DRV_CTL_002 by fu_F_8125_02;
    satisfy req_DRV_CTL_002 by fu_F_8125_03;
    satisfy req_DRV_CTL_002 by fu_F_8125_04;
    satisfy req_DRV_CTL_002 by fu_F_8128_01;
    satisfy req_DRV_CTL_002 by fu_F_8128_02;
    satisfy req_DRV_CTL_002 by fu_F_8128_03;
    satisfy req_DRV_CTL_002 by fu_F_8160_01;
    satisfy req_DRV_CTL_003 by fu_F_8150_01;
    satisfy req_DRV_CTL_003 by fu_F_8151_01;
    satisfy req_DRV_CTL_003 by fu_F_8151_02;
    satisfy req_DRV_CTL_003 by fu_F_8152_01;
    satisfy req_DRV_CTL_003 by fu_F_8152_02;
    satisfy req_DRV_CTL_003 by fu_F_8154_01;
    satisfy req_DRV_CTL_003 by fu_F_8154_02;

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

    item def FunctionImplementationSupportTrace {
        attribute functionId : String;
        attribute functionName : String;
        attribute requirementIds : String;
        attribute coverageType : String;
        attribute evidence : String;
    }

    item implementationSupport_001 : FunctionImplementationSupportTrace {
        attribute :>> functionId = "FN_F_3000_01";
        attribute :>> functionName = "转换能量/物理量、控制运行";
        attribute :>> requirementIds = "REQ-TRAC-001；REQ-TRAC-004";
        attribute :>> coverageType = "IMPLEMENTATION_SUPPORT";
        attribute :>> evidence = "Function覆盖审计中的实现支持来源；不是289条正式Requirement→Function映射之一。";
    }

    item implementationSupport_002 : FunctionImplementationSupportTrace {
        attribute :>> functionId = "FN_F_4000_01";
        attribute :>> functionName = "转换能量/物理量、控制运行";
        attribute :>> requirementIds = "PRJ-PWR-001";
        attribute :>> coverageType = "IMPLEMENTATION_SUPPORT";
        attribute :>> evidence = "Function覆盖审计中的实现支持来源；不是289条正式Requirement→Function映射之一。";
    }

    item implementationSupport_003 : FunctionImplementationSupportTrace {
        attribute :>> functionId = "FN_F_5000_01";
        attribute :>> functionName = "转换能量/物理量、控制运行";
        attribute :>> requirementIds = "REQ-TRAC-004";
        attribute :>> coverageType = "IMPLEMENTATION_SUPPORT";
        attribute :>> evidence = "Function覆盖审计中的实现支持来源；不是289条正式Requirement→Function映射之一。";
    }

    item implementationSupport_004 : FunctionImplementationSupportTrace {
        attribute :>> functionId = "FN_F_7000_01";
        attribute :>> functionName = "转换能量/物理量、控制运行";
        attribute :>> requirementIds = "REQ-BRK-001";
        attribute :>> coverageType = "IMPLEMENTATION_SUPPORT";
        attribute :>> evidence = "Function覆盖审计中的实现支持来源；不是289条正式Requirement→Function映射之一。";
    }

    item implementationSupport_005 : FunctionImplementationSupportTrace {
        attribute :>> functionId = "FN_F_8000_01";
        attribute :>> functionName = "控制运行、实施保护与限制";
        attribute :>> requirementIds = "DRV-CTL-002；DRV-CTL-003";
        attribute :>> coverageType = "IMPLEMENTATION_SUPPORT";
        attribute :>> evidence = "Function覆盖审计中的实现支持来源；不是289条正式Requirement→Function映射之一。";
    }

    item implementationSupport_006 : FunctionImplementationSupportTrace {
        attribute :>> functionId = "FN_F_D000_01";
        attribute :>> functionName = "控制运行";
        attribute :>> requirementIds = "DRV-CTL-001";
        attribute :>> coverageType = "IMPLEMENTATION_SUPPORT";
        attribute :>> evidence = "Function覆盖审计中的实现支持来源；不是289条正式Requirement→Function映射之一。";
    }

    item implementationSupport_007 : FunctionImplementationSupportTrace {
        attribute :>> functionId = "FN_F_E000_01";
        attribute :>> functionName = "控制运行";
        attribute :>> requirementIds = "DRV-CTL-001";
        attribute :>> coverageType = "IMPLEMENTATION_SUPPORT";
        attribute :>> evidence = "Function覆盖审计中的实现支持来源；不是289条正式Requirement→Function映射之一。";
    }

    item implementationSupport_008 : FunctionImplementationSupportTrace {
        attribute :>> functionId = "FN_F_X000_01";
        attribute :>> functionName = "实现车载再生能量回收与利用";
        attribute :>> requirementIds = "REQ-ENE-001；PRJ-ENE-001";
        attribute :>> coverageType = "IMPLEMENTATION_SUPPORT";
        attribute :>> evidence = "Function覆盖审计中的实现支持来源；不是289条正式Requirement→Function映射之一。";
    }

    item implementationSupport_009 : FunctionImplementationSupportTrace {
        attribute :>> functionId = "FN_F_X120_01";
        attribute :>> functionName = "储存与释放能量、检测运行参数";
        attribute :>> requirementIds = "REQ-ENE-001；REQ-ENE-003";
        attribute :>> coverageType = "IMPLEMENTATION_SUPPORT";
        attribute :>> evidence = "Function覆盖审计中的实现支持来源；不是289条正式Requirement→Function映射之一。";
    }

    item implementationSupport_010 : FunctionImplementationSupportTrace {
        attribute :>> functionId = "FN_F_X130_01";
        attribute :>> functionName = "传递能量/介质";
        attribute :>> requirementIds = "REQ-ENE-001；REQ-ENE-003";
        attribute :>> coverageType = "IMPLEMENTATION_SUPPORT";
        attribute :>> evidence = "Function覆盖审计中的实现支持来源；不是289条正式Requirement→Function映射之一。";
    }

    item implementationSupport_011 : FunctionImplementationSupportTrace {
        attribute :>> functionId = "FN_F_X131_01";
        attribute :>> functionName = "传递储能主接触器电能";
        attribute :>> requirementIds = "REQ-ENE-001；REQ-ENE-003";
        attribute :>> coverageType = "IMPLEMENTATION_SUPPORT";
        attribute :>> evidence = "Function覆盖审计中的实现支持来源；不是289条正式Requirement→Function映射之一。";
    }

    item implementationSupport_012 : FunctionImplementationSupportTrace {
        attribute :>> functionId = "FN_F_X132_01";
        attribute :>> functionName = "传递储能预充电组件电能";
        attribute :>> requirementIds = "REQ-ENE-001；REQ-ENE-003";
        attribute :>> coverageType = "IMPLEMENTATION_SUPPORT";
        attribute :>> evidence = "Function覆盖审计中的实现支持来源；不是289条正式Requirement→Function映射之一。";
    }

    item implementationSupport_013 : FunctionImplementationSupportTrace {
        attribute :>> functionId = "FN_F_X133_01";
        attribute :>> functionName = "传递储能支路保护组件电能";
        attribute :>> requirementIds = "REQ-ENE-001；REQ-ENE-003";
        attribute :>> coverageType = "IMPLEMENTATION_SUPPORT";
        attribute :>> evidence = "Function覆盖审计中的实现支持来源；不是289条正式Requirement→Function映射之一。";
    }

}
