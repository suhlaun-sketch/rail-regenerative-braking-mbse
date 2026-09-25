package RequirementFunctionTrace {
    private import RequirementTraceDefinitions::*;
    private import FunctionDefinitions::*;

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
