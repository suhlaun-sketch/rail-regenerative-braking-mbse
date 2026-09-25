# Output-Output Structural Connection Resolution

## Structural finding

- Connection: `CG_07AF42BFA3927EF22F7BDDE7`
- SSD source: `L2_3600.p_3644_rp_af1c1b2c65382775` (`output`)
- SSD target: `L2_5300.p_5311_rp_97eb613c06ae1b2e` (`output`)
- Item: `ITM-PHY-005` / RotationalMechanicalEnergy
- Interface: `IF_IF_PHY_005`
- Source original port: `PORT::3644::旋转机械能端口::ITM-PHY-005::双向物理`
- Target original port: `PORT::5311::旋转机械能端口::ITM-PHY-005::双向物理`

Full SysML 将该 item 定义为牵引电机、传动轴系之间双向传递的旋转机械能，伴随变量为转矩与角速度。原始端口方向均为“双向物理”。旧合同对原始 connection `CG-07AF42BFA3927EF22F7BDDE7` 的类型判定为 `TAP`，并明确说明传感器只采样宿主机械角速度，不传递机械功率。

## A/B/C/D 判定

- A. Projection causality error: **不是独立根因**。`output → output` 是把双向物理端口压成单 scalar direction 后产生的结构投影表现。
- B. Bidirectional physical interface compressed to one scalar connector: **YES，主判定**。
- C. Shared physical net: **NO**。该连接是单一 motor-shaft speed-sensor TAP，不是 shared physical net。
- D. Confirmed model error: **NO**。结构拓扑和追溯有效；问题位于 executable causality representation。

## EXECUTABLE_RESOLUTION

| Source component | Source variable | Target component | Target variable | Quantity | Unit | Datatype |
|---|---|---|---|---|---|---|
| L2_5300 | out_omega_motor | L2_3600 | in_omega_motor | omega_motor | rad/s | Float64 |

最终执行连接为：

`L2_5300.out_omega_motor → L2_3600.in_omega_motor`

不增加 torque 回路，因为 TAP 不传递机械功率；为该传感器连接增加 torque 会违背旧合同的明确语义。L2_5300 同一结构 Connector 与其他传动连接相关的 `out_T_shaft` / `in_omega_shaft` 仍在各自原始 connection 下保留。

## Status

```text
OUTPUT_OUTPUT_STRUCTURAL_CONNECTIONS = 1
OUTPUT_OUTPUT_EXECUTABLE_SIGNALS = 1
OUTPUT_OUTPUT_EXECUTABLE_RESOLUTION = PASS
SSD_MODIFIED = NO
FULL_SYSML_MODIFIED = NO
```
