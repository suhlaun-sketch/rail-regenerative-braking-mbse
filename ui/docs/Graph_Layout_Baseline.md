# SysML / SSD 图形布局实施基线

- 默认层级：Level 1，16 个 L2 Product/Part。
- 默认端口：隐藏；默认边：按组件对聚合并保留真实连接元数据。
- 布局：Cytoscape.js + cytoscape-elk；ELK `layered`、`RIGHT`、`ORTHOGONAL`。
- 浏览：Overview → Zoom → Detail on Demand；支持一阶邻域、接口和 FMI 绑定下钻。
- 泳道：外部能源、高压供电、功率变换、牵引机械、车辆、控制、储能。
- 性能：默认节点数不超过 30；不使用 force-directed、cose 或 cose-bilkent。
- 稳定性：确定性 rank/lane 坐标与 `ui/backend/cache/layout` 视图缓存；缓存不构成模型数据。
- 权威关系：`work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml`。
