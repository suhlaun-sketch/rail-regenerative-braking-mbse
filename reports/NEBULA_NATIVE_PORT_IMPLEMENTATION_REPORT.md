# Agent Display NEBULA 原生源码移植实施报告

## 结论

NEBULA 已按源代码机制移植为独立 React 场景，并在本机 Chrome、1600×900 视口完成视觉、交互、WebGL、性能和生命周期验收。验收路由为：

`http://127.0.0.1:5173/knowledge-graph/nebula-native`

该路由明确使用静态 fixture。正式 `/trace` 入口及原有 `KnowledgeNebulaGraph.tsx` 保持不变，避免把 fixture 当作真实工程知识图谱。SPIDER、PARK、后端、Neo4j、仿真数据、V2 Excel 和 SysML 均未修改。

## 源码移植范围

移植源为 `cyberdaddyleo/agent-display` 的 `index.html`：

- 上游 blob：`0cf90348d7ad7f179e6f851562ed92be2530b92c`
- 完整抽取 `tpl-nebula` 模板与样式
- 完整抽取 `mountNebula(host, SR)`，并保留其依赖、状态机和动画循环
- 保留 12 个星团、六类生成形态、78,264 个粒子、中央丝带星核、三圈轨道、公转/自旋/漂移、CRAWLER 八腿、动态触须、流星、四种视角、聚焦镜头和底部六面板
- `buildNebulae`、`buildCore`、`makeRibbonBall`、`ribbonGeo`、`ribbonMat`、`orbitStep`、`buildSpider`、`spiderMove`、`legsStep`、`threadTo`、`buildThreads`、`threadsStep`、`comet`、`cometsDraw`、`camWant`、`camStep`、`fitCamera`、`pickAt`、`setFocus` 均在移植后的渲染器中实际运行

## React 与渲染边界

`NebulaScene` 只负责挂载、snapshot 传入和卸载。逐帧粒子、蜘蛛、镜头、面板和任务状态全部留在原生渲染器中，没有每帧调用 React `setState`。

渲染器公开统一接口：

- `setSnapshot(snapshot)`
- `dispatch(event)`
- `resize()`
- `focus(id)`
- `getDiagnostics()`
- `dispose()`

场景模板和样式运行于 Shadow DOM，未与 Ant Design 或现有页面样式互相污染。

## three.js 0.186.1 兼容处理

- 使用项目已有 `three@0.186.1`，没有安装第二套 three.js
- 将 `EffectComposer`、`RenderPass`、`UnrealBloomPass` 改为当前版本 ES module 导入
- 保留 bloom 后处理、ShaderMaterial、BufferGeometry、BufferAttribute、加色混合和自定义 attributes/uniforms
- 明确设置 `renderer.outputColorSpace = THREE.SRGBColorSpace`
- 明确使用 `THREE.NoToneMapping`，保持原场景着色逻辑
- 保留原源码基于 FPS 的像素比和 composer 自适应降级；硬件验收期间 composer 始终启用

## 生命周期实现

统一登记并释放：

- `requestAnimationFrame`
- `ResizeObserver`
- canvas、document 事件监听
- interval、timeout
- CSS/Web Animations
- Geometry、Material、Texture、uniform Texture
- EffectComposer RenderTarget
- WebGLRenderer、render lists、WebGL context

React StrictMode 下完成 5 轮路由卸载和重挂载。每轮旧 controller 回查均为 `disposed=true`；最终 DOM 只有 1 个场景 host 和 1 个 WebGL canvas，没有重复动画循环或活动 canvas 累积。

## 浏览器验收

测试环境：Chrome、1600×900、deviceScaleFactor 1、WebGL2、Intel UHD Graphics、ANGLE Direct3D11。

| 项目 | 结果 |
|---|---:|
| WebGL2 | PASS |
| EffectComposer / UnrealBloom | PASS |
| 中央星核 | PASS |
| 三圈轨道 | PASS |
| 12 星团 / 六种形态 | PASS |
| CRAWLER 与八腿运动 | PASS |
| 动态触须 / 流星 | PASS |
| 拖动 / 滚轮 | PASS |
| 星团聚焦 / 返回 | PASS |
| 底部六面板 | PASS |
| 控制台错误 | 0 |
| 页面异常 | 0 |
| 请求失败 | 0 |

视觉基线和移植版均为 1600×900。原版基线处于 COPY 聚焦时刻，移植截图处于另一任务/聚焦时刻，因此动态内容和镜头位置不同；空间构成、粒子形态、轨道、星核、HUD 和面板结构保持一致。

## 性能记录

硬件 WebGL 路径连续 6 次采样：`27, 25, 26, 36, 30, 35 FPS`，平均 `29.8 FPS`。

| 指标 | 结果 |
|---|---:|
| Draw Calls | 143 |
| Rendered Triangles | 14,964 |
| Points | 78,264 |
| Geometries | 64 |
| Textures | 16 |
| Programs | 23 |
| Pixel ratio | 1.0 |
| Composer | enabled |

三角形和 draw call 是特定镜头、特定动画时刻的渲染统计，会随视锥裁剪、触须和流星数量变化。粒子数量与上游基线一致，没有通过减少粒子掩盖兼容问题。

补充测试中，强制 SwiftShader 软件渲染平均约 3.5 FPS，触发了原源码自带的低帧率降级并关闭 composer。改用本机 Intel UHD 硬件路径后 composer 保持启用；该结果证明降级来自原始自适应逻辑，而非移植时删除后处理。

## 构建结果

`npm run build`：PASS。

- TypeScript strict/noEmit：PASS
- Vite production build：PASS
- NEBULA 独立懒加载 chunk：约 90.34 kB，gzip 35.82 kB
- three.js 后处理共享 chunk：约 764.19 kB，gzip 196.75 kB

工程原有主包仍有 Vite 大 chunk 警告；NEBULA 已通过独立路由懒加载，没有把场景代码加入其他页面首屏。

## 文件清单

新增：

- `ui/frontend/src/components/scenes/NebulaScene.tsx`
- `ui/frontend/src/pages/NebulaNativePreviewPage.tsx`
- `ui/frontend/src/scenes/nebula/nebulaRenderer.ts`
- `ui/frontend/src/scenes/nebula/nebulaTemplate.ts`
- `ui/frontend/src/scenes/nebula/nebulaStyles.ts`
- `ui/frontend/src/scenes/nebula/nebulaTypes.ts`
- `ui/frontend/src/scenes/nebula/nebulaConstants.ts`
- `ui/frontend/src/scenes/shared/sceneTypes.ts`
- `ui/frontend/src/scenes/shared/shadowHost.ts`
- `ui/frontend/src/vendor/agent-display/LICENSE`
- `ui/frontend/src/vendor/agent-display/NOTICE.md`
- `ui/frontend/scripts/qa-nebula.mjs`

最小修改：

- `ui/frontend/src/App.tsx`：增加 fixture 验收路由，未改正式入口
- `ui/frontend/index.html`：增加内联 favicon，消除浏览器无关 404

保护备份：

- `work/backups/nebula_migration_20261104/App.tsx.before`
- `work/backups/nebula_migration_20261104/index.html.before`

## 产物

- `reports/assets/nebula_native_port_1600x900.png`
- `reports/assets/nebula_native_port_focused_1600x900.png`
- `reports/assets/nebula_original_vs_react.png`
- `reports/assets/nebula_native_qa.json`

## 许可证

上游 `LICENSE` 已逐字复制到 vendor 目录，SHA-256 与参考快照一致。`NOTICE.md` 记录上游仓库、源文件 blob、抽取范围和本地改动，原 HUD 中的作者署名仍然保留。

## 正式入口状态

原生渲染器的视觉、交互、生命周期和构建均已通过。本轮按要求只使用静态 fixture，尚未接入真实 Requirement → Function → Logical → Physical 数据适配器；因此未将 fixture 路由切换为正式 `/trace`，也未替换旧 `KnowledgeNebulaGraph.tsx`。下一阶段接入真实 API 后，可用现有 `setSnapshot` 和 `dispatch` 接口切换正式入口，无需重写渲染器。
