# FULL SysON IBD Port 图形归属：两张 V3 smoke 诊断

本轮只测试 X130 与 3110；旧 57 张 AUTO_IBD_* 未改动。旧版 `FULL_SYSON_FINAL_QA.json` 的可见性 PASS 已标为 `SUPERSEDED_VISIBILITY_ONLY`，不能代表正式 IBD 图形验收。

| smoke | 图形描述 | 根/直接子产品 | 根边界 Port | 子 Part 端口 | 独立/孤立 Port | 当前层 Port→Port 边 | 归属 | 总验收 |
|---|---|---|---:|---:|---:|---:|---|---|
| [AUTO_V3_IBD_X130](http://localhost:8080/projects/e44ac856-b4b0-4fb8-a94a-0ce1a6d722b8/edit/94cea473-1328-4930-8e2a-9cc1c4d28686) | General View（ViewUsage 类型：InterconnectionView） | X130 / X131, X132, X133 | 5/5 | 7/7 | 0/0 | 1/6 | PASS | FAIL |
| [AUTO_V3_IBD_3110](http://localhost:8080/projects/e44ac856-b4b0-4fb8-a94a-0ce1a6d722b8/edit/976cfb74-4401-4412-b1f2-d5538b2182ce) | General View（ViewUsage 类型：InterconnectionView） | 3110 / 3111, 3112 | 3/3 | 4/4 | 0/0 | 1/4 | PASS | FAIL |

## 已修正的图形归属

- 正式模型的当前层 Port 语义归属是正确的：PortUsage 直接定义在各 `PartDefinition` 下，由对应 `PartUsage` 继承。未新建、复制或重命名 PortUsage。
- 新图把 `P_X130` / `P_N_3110` 作为可见根容器；仅在 `interconnection` compartment 中显示直接子 Part，隐藏重复的 `parts` 文字清单。根边界 Port 位于根外壁，子端口位于各自 Part 外壁。
- X130 当前图显示 3 个直接子 Part、12 个必要 Port；3110 显示 2 个直接子 Part、7 个必要 Port。两图均无顶层独立 Port、孤立 Port、孙级或外部子树泄漏。当前实际可见的边均为 Port→Port，技术 Connection 标签已在视图层隐藏。
- 两张图的 SysON `diagramEvent` 实时 query-back 与持久化图形树一致，且直达页面均返回 HTTP 200；逐节点图形父节点和逐边端点保存在 JSON 审计中。

## 未通过的项目与本机实证

1. **视图描述不符。** 本机运行的是 SysON `2026.7.0`。对两图请求的 Description ID 都是 `Interconnection View`，ViewUsage 的 FeatureTyping 也指向 `StandardViewDefinitions::InterconnectionView`；但持久化的 `representation_metadata.description_id` 与 `representation_content.descriptionId` 均指向 `General View`。本机 `syson-tree-explorer-view-2026.7.0.jar` 的 `CreateRepresentationInputProcessor.getRepresentationDescriptionId` 将 Interconnection 描述 ID 映射为 General 描述 ID。此行为来自服务器自身，不是登记表笔误。
2. **refined Connection 未完整呈现。** 根定义作图形容器时，边界 Port 与子 Part 的真实 `fc_*` 关系并未全部渲染。曾在独立试验中额外暴露根 Usage，`fc_*` 边随即出现，但 Usage 与定义成为同级节点；隐藏 Usage 后边端点也被隐藏。因此不能把该试验留作合格 IBD，也没有修改任何 Connection 语义。
3. **人类可读主标签未实现。** 当前 SysON 图的 Part 与 Port 主标签仍是 `P_*`、`p_*`、`bp_*`、`rp_*`。正式模型内已有真实 `chineseName`、`portName` 和 ItemDefinition 名称，可作为显示标签证据；本机 GraphQL 的 `editLabelAppearance` 只支持可见性/样式，不支持 View 层文本覆盖。直接改写原始元素名称会改变冻结模型语义，因此未执行。

### 缺失的当前层关系

- **X130**：fc_79eb6beb9b0a_03, fc_c5e43804f4ca_01, fc_c003c81fb790_03, fc_166b9301cd54_01, fc_734e10c63b7a_01。

- **3110**：fc_fa31dfa220fe_05, fc_c53d41b4a1f6_01, fc_af75a5003a9b_03。

### 真实名称与实际图上标签示例

**X130**

- Part 图上：`«part def» / P_X130`；模型正式名称：`X130 储能接入与保护`。
- Part 图上：`«part» / p_X131 : P_X131`；模型正式名称：`X131 储能主接触器`。
- Port 图上：`bp_X130_0107c4d21e8f : ~PT_PT_CMD_028`；模型已有业务名称：`储能预充电指令`。
- Port 图上：`bp_X130_3735b6064778 : PT_PT_STA_034`；模型已有业务名称：`储能保护跳闸状态`。

**3110**

- Part 图上：`«part def» / P_N_3110`；模型正式名称：`3110 车轮车轴`。
- Part 图上：`«part» / p_N_3111 : P_N_3111`；模型正式名称：`3111 车轮`。
- Port 图上：`bp_3110_0807a7e0da02 : PT_PT_PHY_006`；模型已有业务名称：`轮轨纵向机械作用`。
- Port 图上：`bp_3110_0b98efa624af : PT_PT_PHY_005`；模型已有业务名称：`旋转机械能`。

## 停止点

两张 smoke 的 **Port ownership PASS，但整体验收 FAIL**。本轮按限定范围停止，不批量创建 57 张 V3 图，也不改 Frozen v1、Requirement V2 或正式 Connection。后续只有在 SysON 视图描述、根 Usage/Definition 关系端点映射与 View 层文本标签能力得到可验证的解决后，才能重跑两张 smoke 并考虑批量处理。

机器可读逐 Port / 逐 Edge 证据：`IBD_PORT_OWNERSHIP_AUDIT_X130.json`、`IBD_PORT_OWNERSHIP_AUDIT_3110.json`。
