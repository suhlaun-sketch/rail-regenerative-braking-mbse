"""Central deterministic rules for cleaning, profiles, types, and compatibility."""

from __future__ import annotations


# The key is (node code, local port name, canonical item name).
DELETE_PORT_RULES = {
    (
        "4235",
        "直流牵引供电电能端口",
        "直流牵引供电电能",
    ): "传统高压电压互感器属于交流测量链；该DC物理端口是为通用性人为扩展，设备本体语义不支持。",
    (
        "4236",
        "第一测量端直流牵引供电电能端口",
        "直流牵引供电电能",
    ): "传统高压电流互感器基于交流互感原理；删除不属于设备本体的第一DC物理端口。",
    (
        "4236",
        "第二测量端直流牵引供电电能端口",
        "直流牵引供电电能",
    ): "传统高压电流互感器基于交流互感原理；删除不属于设备本体的第二DC物理端口。",
}

# Reserved for deterministic future amendments. Values are partial field replacements.
MODIFY_PORT_RULES: dict[tuple[str, str, str], dict[str, str]] = {}
ADD_PORT_RULES: list[dict[str, str]] = []


PHYSICAL_DOMAIN_BY_MEDIUM = {
    "高压交流电气": "Electrical.HighVoltageAC",
    "直流电气": "Electrical.DC",
    "交流电气": "Electrical.AC",
    "三相交流电气": "Electrical.ThreePhaseAC",
    "旋转机械": "Mechanical.Rotational",
    "纵向机械": "Mechanical.Longitudinal",
    "摩擦机械": "Mechanical.Friction",
    "压缩空气": "Fluid.Pneumatic",
    "电气回流": "Electrical.ReturnCurrent",
    "散粒介质": "Material.Granular",
    "热": "Thermal.HeatFlow",
    "低压直流电气": "Electrical.LowVoltageDC",
}


COMPATIBILITY_RULES = [
    {
        "rule_id": "CR-SIG-001",
        "applies_to": "信号",
        "constraint_name": "源方向",
        "source_requirement": "输出",
        "target_requirement": "输入",
        "predicate": "source.direction == '输出' and target.direction == '输入'",
        "severity": "HARD",
        "description": "信号只允许由输出端流向输入端。",
    },
    {
        "rule_id": "CR-SIG-002",
        "applies_to": "信号",
        "constraint_name": "Canonical Item一致",
        "source_requirement": "item_code",
        "target_requirement": "相同item_code",
        "predicate": "source.item_code == target.item_code",
        "severity": "HARD",
        "description": "信号两端必须携带同一Canonical Item。",
    },
    {
        "rule_id": "CR-SIG-003",
        "applies_to": "信号",
        "constraint_name": "PortType兼容",
        "source_requirement": "port_type_id",
        "target_requirement": "相同port_type_id",
        "predicate": "source.port_type_id == target.port_type_id",
        "severity": "HARD",
        "description": "当前v1采用同一Canonical PortType作为信号兼容条件。",
    },
    {
        "rule_id": "CR-SIG-004",
        "applies_to": "信号",
        "constraint_name": "数据类型兼容",
        "source_requirement": "datatype",
        "target_requirement": "相同datatype",
        "predicate": "source.datatype == target.datatype",
        "severity": "HARD",
        "description": "信号数据类型必须一致。",
    },
    {
        "rule_id": "CR-SIG-005",
        "applies_to": "信号",
        "constraint_name": "单位兼容",
        "source_requirement": "unit_medium",
        "target_requirement": "相同或属于Canonical允许集合",
        "predicate": "unit_compatible(source, target, canonical_item)",
        "severity": "HARD",
        "description": "单位必须相同，或均属于Item字典声明的可选单位。",
    },
    {
        "rule_id": "CR-SIG-006",
        "applies_to": "信号",
        "constraint_name": "Profile Active",
        "source_requirement": "profile_active == TRUE",
        "target_requirement": "profile_active == TRUE",
        "predicate": "source.profile_active and target.profile_active",
        "severity": "HARD",
        "description": "信号接口两端均须在当前Profile中激活。",
    },
    {
        "rule_id": "CR-PHY-001",
        "applies_to": "物理",
        "constraint_name": "Acausal方向",
        "source_requirement": "双向物理",
        "target_requirement": "双向物理",
        "predicate": "source.direction == target.direction == '双向物理'",
        "severity": "HARD",
        "description": "物理域保持acausal，两端均为双向物理。",
    },
    {
        "rule_id": "CR-PHY-002",
        "applies_to": "物理",
        "constraint_name": "Canonical Item一致",
        "source_requirement": "item_code",
        "target_requirement": "相同item_code",
        "predicate": "source.item_code == target.item_code",
        "severity": "HARD",
        "description": "物理接口两端必须交换同一Canonical Item。",
    },
    {
        "rule_id": "CR-PHY-003",
        "applies_to": "物理",
        "constraint_name": "Physical Domain一致",
        "source_requirement": "physical_domain",
        "target_requirement": "相同physical_domain",
        "predicate": "source.physical_domain == target.physical_domain",
        "severity": "HARD",
        "description": "物理域必须一致。",
    },
    {
        "rule_id": "CR-PHY-004",
        "applies_to": "物理",
        "constraint_name": "介质兼容",
        "source_requirement": "unit_medium",
        "target_requirement": "相同medium",
        "predicate": "source.unit_medium == target.unit_medium",
        "severity": "HARD",
        "description": "物理介质必须与Canonical Item声明一致。",
    },
    {
        "rule_id": "CR-PHY-005",
        "applies_to": "物理",
        "constraint_name": "Profile Active",
        "source_requirement": "profile_active == TRUE",
        "target_requirement": "profile_active == TRUE",
        "predicate": "source.profile_active and target.profile_active",
        "severity": "HARD",
        "description": "物理接口两端均须在当前Profile中激活。",
    },
    {
        "rule_id": "CR-GEN-001",
        "applies_to": "全部",
        "constraint_name": "禁止Port自连接",
        "source_requirement": "port_instance_key",
        "target_requirement": "不同port_instance_key",
        "predicate": "source.port_instance_key != target.port_instance_key",
        "severity": "HARD",
        "description": "禁止同一个Port连接自己。",
    },
    {
        "rule_id": "CR-GEN-002",
        "applies_to": "全部",
        "constraint_name": "禁止产品内部无意义自连接",
        "source_requirement": "code",
        "target_requirement": "不同code",
        "predicate": "source.code != target.code",
        "severity": "HARD",
        "description": "v1候选生成阶段禁止同一四级产品内部自连接。",
    },
    {
        "rule_id": "CR-GEN-003",
        "applies_to": "全部",
        "constraint_name": "禁止跨未激活制式",
        "source_requirement": "active supply variant",
        "target_requirement": "相同激活制式",
        "predicate": "not crosses_inactive_supply_variant(source, target, profile)",
        "severity": "HARD",
        "description": "禁止AC与未激活DC供电方案之间形成跨制式接口。",
    },
    {
        "rule_id": "CR-GEN-004",
        "applies_to": "全部",
        "constraint_name": "类别一致",
        "source_requirement": "port_category",
        "target_requirement": "相同port_category",
        "predicate": "source.port_category == target.port_category",
        "severity": "HARD",
        "description": "信号Port与物理Port不得直接形成接口。",
    },
]


SEMANTIC_WARNINGS = [
    "4238高压控制输入输出单元的19个Port包含成对采集/转发语义；按I/O单元职责保留，实际部署边界需在下一轮连接阶段用拓扑证据约束。",
    "8128输入输出单元的21个Port包含成对采集/转发语义；按I/O单元职责保留，不能仅因Item相同且方向相反而删除。",
    "X112双向DC/DC控制模块的30个Port包含命令接收与下发；按控制分配职责保留，后续须避免把内部实现回路误作外部连接。",
    "7211 EBCU与8122 VCU端口数较多，但均对应请求、测量、状态、故障、能力或跨组件统计；未发现可确定删除的内部算法中间量。",
    "4241处理单元与8166能量计均发布部分能量统计量；是否在具体车辆部署中合并职责取决于设备配置，本轮保留两者并标记为架构配置问题。",
]


MANUAL_REVIEW_DECISIONS = {
    "4111": ("PASS", "AC适用；两个高压交流物理口表示受流接触面与导流端，保留。"),
    "411C": ("PASS", "制式无关控制接口；控制指令、状态和故障均跨受电弓控制单元边界。"),
    "4121": ("PASS", "DC适用候选节点；通用库保留，CRH_AC25KV_SC整节点停用。"),
    "4211": ("PASS", "AC适用；断路器两侧物理口及控制/状态接口合理。"),
    "4212": ("PASS", "AC/DC Variant；产品类别可有不同制式型号，两套物理候选保留，Profile只启用AC。"),
    "4235": ("PASS", "AC适用；传统电压互感器不承载DC物理链，删除1个DC物理口。"),
    "4236": ("PASS", "AC适用；传统电流互感器不承载DC物理链，删除2个DC物理口。"),
    "4238": ("WARNING", "I/O采集与转发职责支持成对Input/Output；19个Port均保留，部署边界待后续拓扑约束。"),
    "4239": ("PASS", "控制单元接收测量/状态并下发高压设备命令，未见内部算法中间量暴露。"),
    "4241": ("WARNING", "能量处理结果可跨边界发布；与8166的实际职责分工依赖车辆配置。"),
    "4411": ("PASS", "贯通回流与热耗散均为真实物理边界。"),
    "4412": ("PASS", "回流电流两端和热流端口符合接地电阻本体语义。"),
    "4413": ("PASS", "旋转端/固定端回流电流为贯通型物理接口。"),
    "4511": ("PASS", "AC适用；只保留高压交流与变压器次级交流，未加入DC牵引供电口。"),
    "4513": ("PASS", "AC适用；两端均为牵引变压器次级交流电能。"),
    "4517": ("PASS", "AC主变压器检测保护；温度和故障状态跨边界，低压供电为物理口。"),
    "4518": ("PASS", "AC主变压器控制；指令、温度、断路器状态和故障均为外部接口。"),
    "5111": ("PASS", "网侧控制所需电网、直流母线、状态与能力信号均跨控制模块边界。"),
    "5112": ("PASS", "电机侧控制的请求、测量、状态、能力及故障接口均有跨边界职责。"),
    "5113": ("PASS", "检测保护组件发布母线/相电流测量、故障与限制，未发现内部算法中间量。"),
    "5121": ("PASS", "AC/DC Variant；通用库保留两种输入候选，Profile关闭DC口并启用AC链。"),
    "5122": ("PASS", "AC/DC Variant；通用库保留两种输入候选，Profile关闭DC口并启用AC链。"),
    "5131": ("PASS", "AC适用网侧变流模块；次级交流与中间直流物理口形成双向能量变换边界。"),
    "5132": ("PASS", "制式无关于上游供电；中间直流与三相交流均为双向acausal物理口。"),
    "5133": ("PASS", "斩波器控制指令、母线测量、状态与耗散能力均跨控制模块边界。"),
    "5142": ("PASS", "中间直流输入、热耗散及温度/功率/能量统计符合电阻器边界。"),
    "5145": ("PASS", "检测保护组件输出测量、保护状态和电压上限，未暴露可确定的内部变量。"),
    "5311": ("PASS", "三相交流与旋转机械保持acausal；转速、电流、电压、转矩另作跨边界测量信号。"),
    "7211": ("WARNING", "38个Port覆盖外部请求、测量、状态、能力与制动执行命令；数量高但未发现可确定删除项。"),
    "8122": ("WARNING", "35个Port承担车辆级协调与储能分配；均可跨VCU边界，实际总线聚合待部署架构确定。"),
    "8125": ("PASS", "列车级牵引控制接收请求/反馈并输出转矩、状态与能力，职责闭合。"),
    "8128": ("WARNING", "I/O单元的成对采集/转发是产品职责，21个Port保留。"),
    "8166": ("WARNING", "19个Port用于测量输入和能量统计输出；与4241的设备分工依赖具体配置。"),
    "X111": ("PASS", "双向DC/DC两侧物理能量保持不同Canonical Item，控制/测量/状态接口合理。"),
    "X112": ("WARNING", "30个Port覆盖请求接收、命令下发、测量、状态、故障和能力；保留但后续需约束内部/外部边界。"),
    "X113": ("PASS", "检测保护组件两侧物理感知与测量/保护/能力输出符合职责。"),
    "X121": ("PASS", "超级电容的储能侧直流、热流和SOC输出构成必要边界。"),
    "X122": ("PASS", "电压传感器物理感知口和测量输出合理。"),
    "X123": ("PASS", "电流传感器物理感知口和测量输出合理。"),
    "X124": ("PASS", "温度传感器使用热能/热流物理感知口和温度输出，语义正确。"),
    "X131": ("PASS", "接触器两侧储能直流物理口及指令/状态接口合理。"),
    "X132": ("PASS", "预充组件两侧储能直流物理口及指令/状态接口合理。"),
    "X133": ("PASS", "保护组件两侧储能直流物理口、故障与跳闸状态合理。"),
}


def port_rule_key(port: dict[str, str]) -> tuple[str, str, str]:
    return port["code"], port["端口名称"], port["交换内容"]


def canonical_unit_accepts(canonical: str, actual: str) -> bool:
    """Accept exact units or alternatives declared with Chinese '或' / slash."""

    canonical = canonical.strip()
    actual = actual.strip()
    if canonical == actual:
        return True
    normalized = canonical.replace(" 或 ", "或")
    alternatives = {part.strip() for part in normalized.split("或") if part.strip()}
    if actual in alternatives:
        return True
    if "/" in canonical:
        alternatives.update(part.strip() for part in canonical.split("/") if part.strip())
    return actual in alternatives


def stable_port_type_id(item_code: str) -> str:
    if not item_code.startswith("ITM-"):
        raise ValueError(f"非法Item code: {item_code}")
    return "PT-" + item_code.removeprefix("ITM-")


def stable_interface_type_id(item_code: str) -> str:
    if not item_code.startswith("ITM-"):
        raise ValueError(f"非法Item code: {item_code}")
    return "IF-" + item_code.removeprefix("ITM-")


def interface_domain(item: dict[str, str], port_category: str) -> str:
    if port_category == "物理":
        medium = item["单位/介质"]
        if medium not in PHYSICAL_DOMAIN_BY_MEDIUM:
            raise ValueError(f"未配置物理域: {item['item_code']} {medium}")
        return PHYSICAL_DOMAIN_BY_MEDIUM[medium]
    return "Signal." + item["领域"].replace("/", ".")
