# 轨道列车牵引—再生制动数字工程工作台

中文数字工程 UI，读取冻结的 Rail MBSE SysML v2、SSD、FMI/SSP、V&V 与联合仿真结果。UI 与布局缓存均为只读展示层，不写回权威模型。

## 启动

```powershell
.\ui\start_ui.ps1
```

访问 `http://127.0.0.1:5173`。停止服务：

```powershell
.\ui\stop_ui.ps1
```

前端使用 React、TypeScript、Vite、Ant Design、Cytoscape.js、cytoscape-elk、ELK.js 与 ECharts。后端使用 FastAPI、Uvicorn 和 Pydantic。

默认 SysML/SSD 图仅显示 16 个 L2 组件；Ports 折叠；组件间连接聚合；布局固定为 ELK Layered、RIGHT、ORTHOGONAL。用户通过邻域、接口与实施绑定按钮逐级展开。
