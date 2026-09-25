# 牵引—制动—再生能量回收 Interface Layer Pipeline

本目录保存可重复执行的接口语义层代码。处理范围固定为：

`Clean Raw Port → Architecture Profile → PortType → InterfaceType → Compatibility Rules`

本版本不生成 Connection、Connection候选、GraphRAG连接排序、SysML Connector 或 SSD Connection；不修改 Simulink，不生成 SysML/XMI/SSD。

## 本地Python环境

Pipeline只使用项目内虚拟环境：

`tools\interface_pipeline\.venv`

已确认可用于创建虚拟环境的基础解释器：

`D:\Computer\Anaconda\envs\mineru\python.exe`

首次安装或重建环境时，在项目根目录执行：

```powershell
& 'D:\Computer\Anaconda\envs\mineru\python.exe' -m venv '.\tools\interface_pipeline\.venv'
& '.\tools\interface_pipeline\.venv\Scripts\python.exe' -m pip install -r '.\tools\interface_pipeline\requirements.txt'
```

依赖只包含 `openpyxl==3.1.5`，版本记录在 `requirements.txt`。Pipeline不修改全局Python或Anaconda环境，也不依赖全局隐式包。

## 输入与输出

必需输入：

- `筛选牵引制动架构V2_RawPort完成版.xlsx`
- `完整Item字典.xlsx`

辅助证据（存在时读取，不覆盖）：

- `筛选牵引制动架构V2.xlsx`
- `筛选牵引制动架构V2_一二三级产品统计.xlsx`

输出：

- `筛选牵引制动架构V2_InterfaceLayer_v1.xlsx`
- `reports\interface_layer_audit.md`

主输入工作簿不会被覆盖。入口脚本在运行前后比较主输入SHA-256；若发生变化立即报错。

## 重新执行整个Pipeline

在项目根目录执行：

```powershell
& '.\tools\interface_pipeline\.venv\Scripts\python.exe' '.\tools\interface_pipeline\run_interface_pipeline.py'
```

也可以用已确认的基础解释器启动入口；入口会自动切换到项目内 `.venv`：

```powershell
& 'D:\Computer\Anaconda\envs\mineru\python.exe' '.\tools\interface_pipeline\run_interface_pipeline.py'
```

执行失败会返回非零状态，不会静默跳过规则或QA。

## 文件职责

- `01_audit_raw_ports.py`：实际读取输入、Sheet、Item字典、入选叶节点、Raw Port和原始QA，生成输入审计清单。
- `02_clean_raw_ports.py`：按显式语义规则删除、修改或新增Raw Port。本版本只删除4235/4236上不属于传统互感器本体的3个DC物理Port。
- `03_build_profile.py`：执行默认Active加override的 `CRH_AC25KV_SC` Profile，关闭DC受流支路并激活超级电容分支。
- `04_build_porttypes.py`：以Canonical Item、Port Category和必要物理域生成稳定PortType，并为每个Clean Raw Port生成唯一映射。
- `05_build_interfacetypes.py`：从PortType生成InterfaceType和确定性的Compatibility Rules，不生成连接。
- `06_validate_interface_layer.py`：执行QA-01至QA-14、生成并回读最终Excel、扫描公式错误、生成审计报告。
- `run_interface_pipeline.py`：依次执行全部阶段和回归测试，打印最终14项汇总。
- `rules.py`：集中保存清洗、物理域、Compatibility和人工式重点节点复核规则，避免magic strings散落。
- `config\architecture_profiles.json`：保存Profile默认策略、节点条件和Port变体override。
- `tests\test_interface_pipeline.py`：对Sheet、行数、类型ID、Profile互斥和QA结果进行回归测试。

阶段间的确定性JSON中间结果保存在 `work\`，用于审计和后续Connection阶段复用。

## Canonical类型与稳定ID

PortType不使用局部端口名称和方向作为类型身份。Input和Output实例只要携带同一Canonical Item且类别一致，就共享同一PortType。

- `port_type_id = PT-` + `item_code` 去掉 `ITM-` 前缀。
- `interface_type_id = IF-` + `item_code` 去掉 `ITM-` 前缀。
- 例：`ITM-PHY-005 → PT-PHY-005 → IF-PHY-005`。
- 不使用UUID、随机数或运行顺序编号。

物理Item保持独立Canonical语义。例如 `ITM-PHY-003 中间直流电能` 与 `ITM-PHY-016 储能侧直流电能` 均属于直流电气域，但不会合并。

## Profile计算

`CRH_AC25KV_SC` 使用：

- `default_node_active = true`
- `default_port_active = true`
- 节点/Port条件只记录有方案意义的分类和override

节点先计算Active，Port再计算Active；任一层为False时Port为Inactive。当前实例停用4121直流受流器整节点，并停用4212、5121、5122上的DC供电候选Port。AC主链与超级电容储能分支保持Active。

## Compatibility边界

信号硬约束：输出到输入、Item一致、PortType一致、datatype兼容、unit兼容、Profile Active。

物理硬约束：双向物理到双向物理、Item一致、Physical Domain一致、medium一致、Profile Active。

通用保护：禁止Port连接自身、禁止同一四级产品内部无意义自连接、禁止跨未激活供电制式、禁止信号和物理类别混连。

这些规则只作为后续Connection生成器的确定性输入；本轮不枚举或排序任何连接候选。
