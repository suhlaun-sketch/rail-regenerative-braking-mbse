# SysON 导入顺序（Requirement Traceability V2）

1. 冻结工程模型：`work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml`
2. V2 overlay 单文件：`work/sysmlv2/requirements_traceability_v2/06_RequirementTraceability_AllInOne_v2.sysml`

All-In-One 已包含 46 个需求 usage、Parent→Derived requirement connection、289 条 `satisfy` trace，以及来自冻结 allocation 和 Product interaction reference 的可审计数据；并导入冻结模型中的 `FunctionDefinitions`、`ProductDefinitions`、`FunctionAllocations` 与 `PhysicalNetworks` 包。先导入冻结模型确保引用到原模型的真实 action、product、allocation 和 flow。

如果 SysON 当前只允许逐文件/包导入而不能一次导入多 package，请用下列依赖顺序：

1. `01_RequirementDefinitions_v2.sysml`
2. `02_RequirementHierarchy_v2.sysml`
3. `03_RequirementFunctionTrace_v2.sysml`
4. `04_FunctionProductAllocationTrace_v2.sysml`
5. `05_ProductInteractionReference_v2.sysml`

拆分文件均依赖先导入的冻结工程模型；关系只引用已有 Requirement usage 和冻结 `fu_*` allocation/action usage，不覆盖冻结模型定义。
