# 实施接口绑定

冻结合同：`work/simulation/implementation_binding/Rail_MBSE_Executable_FMU_Interface_v1.json`。它连接结构 SSD Connector 与实际 FMI variable；v2.1 的 16 FMU/151 变量/87 执行连接以 `06_ssp/Executable_SSP_Validation_v2_1.json` 及各 FMU `modelDescription.xml` 校验。各变量的名称、causality、unit 以 FMU 内 XML 为准。结构连接不能直接当作执行因果连接。

工作台的绑定页从这些文件读取映射。若某变量无证据链，应标为未直接映射，不能以名称相似推断。相关来源见 `work/sysmlv2/ssi_integration/03_ssd/Rail_MBSE_L2_All16_v1_mapping.json` 和 `work/simulation/simulink_fmu_v2_1_final/06_ssp/Executable_SSP_Traceability_v2_1.json`。
