# SysON 图形已知限制

历史 `FULL_SYSON_FINAL_QA.json` 对 57 个正式 IBD 的数量与可见元素给出 PASS；`FULL_IBD_COMPLETENESS.json` 记录 57/57、210 条 graphical edge。此统计不能证明每张图都具有正确的 Port 图形归属或真正的 Interconnection View Description。

在独立 2026.9.0 测试环境中，曾发生自动化请求 Interconnection View 语义类型，但最终 Sirius Representation 的 Description 为 General View。**SysML ViewUsage semantic type 与 Sirius Representation Description 是两个字段**；不能据此认定 SysON 2026.9.0 不支持 Interconnection View，也不能声称自动创建链路已修复。参见 `work/reports/IBD_V3_TWO_SMOKE_DIAGNOSTIC.md`、`tools/syson-local-2026.9-test/VERIFICATION.md`。此仓库没有修改 57 张正式图。

模型文本、连接证据、已归档 representation 可检查；对 Port/Connection 的图形解释，应逐张在正式 2026.7.0 UI 中确认。原 Project ID 是来源标识，导入新实例时可能变化。
