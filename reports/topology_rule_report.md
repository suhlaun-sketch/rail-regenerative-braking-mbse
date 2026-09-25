# Topology Rule Report

- KG v1 frozen: PASS
- Active EXPOSES baseline: 511
- Role map Products: 147
- Ports with derived local semantics: 511
- Modes: BOUNDARY, NET, SERIES, SIGNAL, TAP
- GraphRAG hard-rule override: forbidden

## Variant groups

- VG-BRAKE-DISC-01: 3131, 3132, 3133 — UNRESOLVED_VARIANT — 外轮盘、内轮盘、轴盘均为solution-space合法方案，当前Profile无选型证据。
- VG-COUPLING-01: 3511, 3512, 3514 — UNRESOLVED_VARIANT — 两种联轴节与万向轴均合法，当前Profile无部署选型证据。

## Role map audit

| Product | Name | Level | Leaf | Derived role | Active ports |
|---|---|---:|---|---|---:|
| 3000 | 转向架及其辅助 | 1 | false | HIERARCHY_CONTAINER | 0 |
| 3100 | 轮轴组成 | 2 | false | HIERARCHY_CONTAINER | 0 |
| 3110 | 车轮车轴 | 3 | false | HIERARCHY_CONTAINER | 0 |
| 3111 | 车轮 | 4 | true | ENERGY_SINK | 2 |
| 3112 | 车轴 | 4 | true | SERIES_MECHANICAL | 2 |
| 3120 | 齿轮箱及附件 | 3 | false | HIERARCHY_CONTAINER | 0 |
| 3121 | 齿轮箱主体 | 4 | true | MECHANICAL_TRANSFORMER | 2 |
| 3130 | 制动盘 | 3 | false | HIERARCHY_CONTAINER | 0 |
| 3131 | 外轮盘 | 4 | true | ENERGY_SINK | 2 |
| 3132 | 内轮盘 | 4 | true | ENERGY_SINK | 2 |
| 3133 | 轴盘 | 4 | true | ENERGY_SINK | 2 |
| 3500 | 牵引传动耦合组件及其附件 | 2 | false | HIERARCHY_CONTAINER | 0 |
| 3510 | 传动耦合机构 | 3 | false | HIERARCHY_CONTAINER | 0 |
| 3511 | 联轴节(电机侧) | 4 | true | SERIES_MECHANICAL | 2 |
| 3512 | 联轴节(齿轮箱侧) | 4 | true | SERIES_MECHANICAL | 2 |
| 3514 | 万向轴 | 4 | true | SERIES_MECHANICAL | 2 |
| 3600 | 转向架相关检测 | 2 | false | HIERARCHY_CONTAINER | 0 |
| 3640 | 速度检测组件 | 3 | false | HIERARCHY_CONTAINER | 0 |
| 3641 | 轴端速度传感器 | 4 | true | SENSOR_TAP | 2 |
| 3643 | 齿轮箱速度传感器 | 4 | true | SENSOR_TAP | 2 |
| 3644 | 牵引电机速度传感器 | 4 | true | SENSOR_TAP | 2 |
| 3800 | 辅助增粘及轮缘润滑 | 2 | false | HIERARCHY_CONTAINER | 0 |
| 3810 | 撒砂装置 | 3 | false | HIERARCHY_CONTAINER | 0 |
| 3811 | 撒砂控制单元 | 4 | true | CONTROLLER | 4 |
| 3813 | 撒砂阀板组件 | 4 | true | ACTUATOR | 4 |
| 3814 | 撒砂喷嘴组件 | 4 | true | ACTUATOR | 1 |
| 4000 | 主供电 | 1 | false | HIERARCHY_CONTAINER | 0 |
| 4100 | 高压受流 | 2 | false | HIERARCHY_CONTAINER | 0 |
| 4110 | 受电弓总成 | 3 | false | HIERARCHY_CONTAINER | 0 |
| 4111 | 碳滑板 | 4 | true | SERIES_ELECTRICAL | 2 |
| 411C | 受电弓电子控制单元 | 4 | true | CONTROLLER | 4 |
| 4120 | 其它类型受流组成 | 3 | false | HIERARCHY_CONTAINER | 0 |
| 4121 | 受流器 | 4 | true | SERIES_ELECTRICAL | 0 |
| 4200 | 网侧高压分配及控制 | 2 | false | HIERARCHY_CONTAINER | 0 |
| 4210 | 高压开关 | 3 | false | HIERARCHY_CONTAINER | 0 |
| 4211 | 真空断路器 | 4 | true | SERIES_ELECTRICAL | 5 |
| 4212 | 非真空隔离开关 | 4 | true | SERIES_ELECTRICAL | 4 |
| 4230 | 高压保护及检测部件 | 3 | false | HIERARCHY_CONTAINER | 0 |
| 4235 | 高压电压互感器 | 4 | true | SENSOR_TAP | 2 |
| 4236 | 高压电流互感器 | 4 | true | SERIES_SENSOR | 3 |
| 4238 | 高压控制输入输出单元 | 4 | true | IO_ROUTER | 19 |
| 4239 | 高压控制单元 | 4 | true | CONTROLLER | 13 |
| 4240 | 能量测量 | 3 | false | HIERARCHY_CONTAINER | 0 |
| 4241 | 处理单元 | 4 | true | CONTROLLER | 8 |
| 4400 | 回流及接地 | 2 | false | HIERARCHY_CONTAINER | 0 |
| 4410 | 主回路回流设备 | 3 | false | HIERARCHY_CONTAINER | 0 |
| 4411 | 接地变压器 | 4 | true | SAFETY_LOGIC | 3 |
| 4412 | 主回路接地电阻 | 4 | true | SAFETY_LOGIC | 3 |
| 4413 | 回流碳刷 | 4 | true | SERIES_ELECTRICAL | 2 |
| 4500 | 主变压器及其冷却 | 2 | false | HIERARCHY_CONTAINER | 0 |
| 4510 | 主变压器主体及其控制 | 3 | false | HIERARCHY_CONTAINER | 0 |
| 4511 | 主变压器主体 | 4 | true | ENERGY_CONVERTER | 2 |
| 4513 | 电抗器 | 4 | true | SERIES_ELECTRICAL | 2 |
| 4517 | 主变压器检测及保护元件 | 4 | true | SENSOR_TAP | 3 |
| 4518 | 主变压器控制装置 | 4 | true | CONTROLLER | 5 |
| 5000 | 牵引 | 1 | false | HIERARCHY_CONTAINER | 0 |
| 5100 | 牵引变流器主体及其控制 | 2 | false | HIERARCHY_CONTAINER | 0 |
| 5110 | 牵引变流器控制 | 3 | false | HIERARCHY_CONTAINER | 0 |
| 5111 | 网侧变流器控制模块 | 4 | true | CONTROLLER | 11 |
| 5112 | 电机侧变流器控制模块 | 4 | true | CONTROLLER | 16 |
| 5113 | 变流器检测保护组件 | 4 | true | SENSOR_TAP | 8 |
| 5120 | 输入及预充电单元 | 3 | false | HIERARCHY_CONTAINER | 0 |
| 5121 | 预充电组件 | 4 | true | SERIES_ELECTRICAL | 4 |
| 5122 | 输入组件 | 4 | true | SERIES_ELECTRICAL | 4 |
| 5130 | 变流模块 | 3 | false | HIERARCHY_CONTAINER | 0 |
| 5131 | 网侧变流模块 | 4 | true | ENERGY_CONVERTER | 8 |
| 5132 | 电机侧变流模块 | 4 | true | ENERGY_CONVERTER | 8 |
| 5133 | 放电电阻控制模块 | 4 | true | CONTROLLER | 5 |
| 5140 | 中间直流环节组件及其 | 3 | false | HIERARCHY_CONTAINER | 0 |
| 5142 | 放电电阻器 | 4 | true | ENERGY_SINK | 5 |
| 5145 | 中间直流环节检测保护组件 | 4 | true | SENSOR_TAP | 6 |
| 5300 | 牵引电机及其冷却 | 2 | false | HIERARCHY_CONTAINER | 0 |
| 5310 | 牵引电机组成 | 3 | false | HIERARCHY_CONTAINER | 0 |
| 5311 | 牵引电机 | 4 | true | ENERGY_CONVERTER | 6 |
| 7000 | 供风制动 | 1 | false | HIERARCHY_CONTAINER | 0 |
| 7100 | 供风 | 2 | false | HIERARCHY_CONTAINER | 0 |
| 7120 | 风缸 | 3 | false | HIERARCHY_CONTAINER | 0 |
| 7124 | 制动风缸 | 4 | true | ENERGY_SOURCE | 2 |
| 7130 | 列车级压缩空气分配组件 | 3 | false | HIERARCHY_CONTAINER | 0 |
| 7131 | 总风管 | 4 | true | PNEUMATIC_ELEMENT | 2 |
| 7140 | 供风压力开关及传感器 | 3 | false | HIERARCHY_CONTAINER | 0 |
| 7142 | 总风管压力传感器 | 4 | true | SENSOR_TAP | 3 |
| 7200 | 制动 | 2 | false | HIERARCHY_CONTAINER | 0 |
| 7210 | 制动控制组件 | 3 | false | HIERARCHY_CONTAINER | 0 |
| 7211 | 电子制动控制单元(EBCU) | 4 | true | CONTROLLER | 38 |
| 7213 | 制动控制接触器及其他 | 4 | true | ACTUATOR | 3 |
| 7220 | 直接制动控制 | 3 | false | HIERARCHY_CONTAINER | 0 |
| 7222 | 电空转换阀 | 4 | true | PNEUMATIC_ELEMENT | 3 |
| 7223 | 中继阀 | 4 | true | PNEUMATIC_ELEMENT | 3 |
| 7224 | 空重车调整阀 | 4 | true | SENSOR_TAP | 3 |
| 7225 | 控制电磁阀 | 4 | true | ACTUATOR | 3 |
| 7226 | 紧急制动阀 | 4 | true | PNEUMATIC_ELEMENT | 5 |
| 7227 | 缓解阀 | 4 | true | ACTUATOR | 2 |
| 7228 | 车厢直接制动截断塞门 | 4 | true | PNEUMATIC_ELEMENT | 4 |
| 7229 | 调压阀 | 4 | true | PNEUMATIC_ELEMENT | 2 |
| 722A | 防滑阀组成 | 4 | true | PNEUMATIC_ELEMENT | 5 |
| 722B | 压力传感器 | 4 | true | SENSOR_TAP | 2 |
| 722C | 压力开关 | 4 | true | SENSOR_TAP | 2 |
| 7250 | 制动夹钳及其配套组件 | 3 | false | HIERARCHY_CONTAINER | 0 |
| 7252 | 非停放制动夹钳装置 | 4 | true | ACTUATOR | 5 |
| 7254 | 闸片 | 4 | true | ENERGY_SINK | 4 |
| 7255 | 增压缸 | 4 | true | ACTUATOR | 2 |
| 7280 | 其它制动元件及附件 | 3 | false | HIERARCHY_CONTAINER | 0 |
| 7281 | 制动指示器 | 4 | true | ACTUATOR | 4 |
| 7284 | 转向架制动截断塞门 | 4 | true | PNEUMATIC_ELEMENT | 4 |
| 7285 | 单轴制动截断塞门 | 4 | true | PNEUMATIC_ELEMENT | 4 |
| 8000 | 网络及辅助监控 | 1 | false | HIERARCHY_CONTAINER | 0 |
| 8100 | 列车主干网及安全回路 | 2 | false | HIERARCHY_CONTAINER | 0 |
| 8120 | 控制单元及输入输出模块 | 3 | false | HIERARCHY_CONTAINER | 0 |
| 8121 | 主控制单元 | 4 | true | CONTROLLER | 19 |
| 8122 | 车辆控制单元 | 4 | true | CONTROLLER | 35 |
| 8125 | 列车级牵引控制单元 | 4 | true | CONTROLLER | 21 |
| 8127 | ATP接口单元 | 4 | true | IO_ROUTER | 5 |
| 8128 | 输入输出单元 | 4 | true | IO_ROUTER | 21 |
| 8150 | 整车级安全回路及其附件 | 3 | false | HIERARCHY_CONTAINER | 0 |
| 8151 | 高压安全回路 | 4 | true | SAFETY_LOGIC | 3 |
| 8152 | 制动安全回路 | 4 | true | SAFETY_LOGIC | 4 |
| 8154 | 牵引安全回路 | 4 | true | SAFETY_LOGIC | 4 |
| 8160 | 其它附件 | 3 | false | HIERARCHY_CONTAINER | 0 |
| 8166 | 能量计 | 4 | true | CONTROLLER | 19 |
| D000 | 驾驶设施 | 1 | false | HIERARCHY_CONTAINER | 0 |
| D100 | 操纵设施 | 2 | false | HIERARCHY_CONTAINER | 0 |
| D110 | 基本操纵组件 | 3 | false | HIERARCHY_CONTAINER | 0 |
| D112 | 方向操作元件 | 4 | true | EXTERNAL_BOUNDARY | 1 |
| D113 | 牵引操作元件 | 4 | true | EXTERNAL_BOUNDARY | 1 |
| D114 | 制动操作元件 | 4 | true | EXTERNAL_BOUNDARY | 1 |
| D120 | 紧急响应元件 | 3 | false | HIERARCHY_CONTAINER | 0 |
| D121 | 紧急制动按钮 | 4 | true | EXTERNAL_BOUNDARY | 1 |
| D130 | 开关按钮功能组件 | 3 | false | HIERARCHY_CONTAINER | 0 |
| D13B | 撒砂按钮 | 4 | true | EXTERNAL_BOUNDARY | 1 |
| E000 | 电务车载 | 1 | false | HIERARCHY_CONTAINER | 0 |
| E100 | ATP车载 | 2 | true | EXTERNAL_BOUNDARY | 2 |
| X000 | 再生储能扩展 | 1 | false | HIERARCHY_CONTAINER | 0 |
| X100 | 车载再生储能 | 2 | false | HIERARCHY_CONTAINER | 0 |
| X110 | 双向储能变流及控制 | 3 | false | HIERARCHY_CONTAINER | 0 |
| X111 | 双向DC/DC变流模块 | 4 | true | ENERGY_CONVERTER | 8 |
| X112 | 双向DC/DC控制模块 | 4 | true | CONTROLLER | 30 |
| X113 | 双向DC/DC检测保护组件 | 4 | true | SENSOR_TAP | 14 |
| X120 | 超级电容储能组件 | 3 | false | HIERARCHY_CONTAINER | 0 |
| X121 | 超级电容模块 | 4 | true | ENERGY_STORAGE | 3 |
| X122 | 超级电容电压传感器 | 4 | true | SENSOR_TAP | 2 |
| X123 | 超级电容电流传感器 | 4 | true | SENSOR_TAP | 2 |
| X124 | 超级电容温度传感器 | 4 | true | SENSOR_TAP | 2 |
| X130 | 储能接入与保护 | 3 | false | HIERARCHY_CONTAINER | 0 |
| X131 | 储能主接触器 | 4 | true | SERIES_ELECTRICAL | 4 |
| X132 | 储能预充电组件 | 4 | true | SERIES_ELECTRICAL | 4 |
| X133 | 储能支路保护组件 | 4 | true | SERIES_ELECTRICAL | 5 |

## Hard gates

- profile_active=true
- different Product
- canonical Item equal
- InterfaceType equal
- Signal output to input
- Physical medium/unit equal
- Product Role adjacency
- top-level system interaction allow-list
- Port local-side semantics
- Variant/route constraints
