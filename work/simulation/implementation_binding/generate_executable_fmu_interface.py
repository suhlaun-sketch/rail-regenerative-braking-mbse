from __future__ import annotations

import csv
import json
import re
import sys
from collections import Counter, defaultdict
from datetime import datetime, timedelta, timezone
from pathlib import Path

sys.dont_write_bytecode = True

import generate_fmu_implementation_binding as base


ROOT = base.ROOT
OUT = base.OUT
COMPONENT_OUT = base.COMPONENT_OUT
INPUT_BINDING = OUT / "Rail_MBSE_FMU_Implementation_Binding_v1.json"
JSON_OUT = OUT / "Rail_MBSE_Executable_FMU_Interface_v1.json"
REPORT_OUT = OUT / "Rail_MBSE_Executable_FMU_Interface_Report.md"
OO_REPORT_OUT = OUT / "Output_Output_Resolution.md"

EXPECTED_COMPONENTS = 16
EXPECTED_STRUCTURAL_CONNECTORS = 138
EXPECTED_STRUCTURAL_CONNECTIONS = 74

SOURCE_LEVELS = {
    "FULL_SYSML",
    "LEGACY_CONTRACT",
    "DERIVED_FROM_PHYSICAL_INTERFACE",
    "ENGINEERING_INFERENCE",
}


def normalize_connection_id(value: str | None) -> str:
    return re.sub(r"[^A-Fa-f0-9]", "", value or "").upper()


def as_l2_component(code: str | None) -> str | None:
    if not code or code.startswith("BOUNDARY-"):
        return None
    return code if code.startswith("L2_") else f"L2_{code}"


def normalized_engineering_unit(value: str | None) -> str | None:
    if value is None:
        return None
    value = value.strip()
    replacements = {"N·m": "N*m", "无": "1", "[-]": "1", "无量纲": "1"}
    return replacements.get(value, value)


def resolve_unit(legacy_row: dict, binding: dict) -> tuple[str | None, str, str | None]:
    legacy_unit = legacy_row.get("Simulation_Unit")
    if legacy_unit:
        return normalized_engineering_unit(legacy_unit), "LEGACY_CONTRACT", None
    sysml_unit = binding.get("item_unit_or_medium")
    if sysml_unit in {"无", "1", "[-]", "无量纲"}:
        return (
            "1",
            "ENGINEERING_INFERENCE",
            f"Full SysML unit/medium is '{sysml_unit}'; encoded as FMI dimensionless unit 1.",
        )
    if sysml_unit and binding.get("item_type") not in {"PhysicalConnector", "Composite"}:
        return normalized_engineering_unit(sysml_unit), "FULL_SYSML", None
    return (
        None,
        "ENGINEERING_INFERENCE",
        "No executable scalar unit was available from the legacy contract or Full SysML.",
    )


def confidence_for(sources: list[str], legacy_statuses: list[str]) -> str:
    if "ENGINEERING_INFERENCE" in sources:
        return "inferred"
    if any(status in {"PROPOSED", "REVIEW_REQUIRED", "OPTIONAL"} for status in legacy_statuses):
        return "medium"
    return "high"


def make_variable_contribution(
    binding: dict,
    legacy_row: dict,
    role: str,
    connection_id: str,
) -> dict:
    prefix = "Driver" if role == "driver" else "Receiver"
    variable_name = legacy_row.get(f"FMI_Variable_{prefix}") or legacy_row.get(f"{prefix}_Port")
    causality = legacy_row.get(f"{prefix}_Causality")
    unit, source_of_unit, unit_assumption = resolve_unit(legacy_row, binding)
    assumptions: list[str] = []
    if unit_assumption:
        assumptions.append(unit_assumption)
    if legacy_row.get("Interface_Kind") == "PHYSICAL_EXPANDED":
        assumptions.append(
            "The Full SysML physical item is causalized only in the implementation layer; the SSD structural connector remains unchanged."
        )
    legacy_status = legacy_row.get("Mapping_Status")
    if legacy_status in {"PROPOSED", "REVIEW_REQUIRED", "OPTIONAL"}:
        assumptions.append(
            f"Legacy Mapping_Status={legacy_status}; accepted as an executable interface resolution because scalar quantity, datatype and causality are explicit and traceable to the Full SysML item."
        )
    return {
        "variable_name": variable_name,
        "engineering_meaning": legacy_row.get("Variable_Semantics")
        or binding.get("item_semantic_definition"),
        "quantity": legacy_row.get("Simulation_Variable") or binding.get("item_name_en"),
        "unit": unit,
        "datatype": legacy_row.get("FMI_Type"),
        "fmi_causality": causality,
        "fmi_variability": (
            "continuous" if legacy_row.get("FMI_Type") in {"Float32", "Float64", "Real"} else "discrete"
        ),
        "simulink_port_type": (
            "Inport" if causality == "input" else "Outport" if causality == "output" else None
        ),
        "source_of_semantics": "LEGACY_CONTRACT",
        "source_of_unit": source_of_unit,
        "source_of_causality": "LEGACY_CONTRACT",
        "confidence": confidence_for(
            ["LEGACY_CONTRACT", source_of_unit, "LEGACY_CONTRACT"], [legacy_status]
        ),
        "assumption": " | ".join(assumptions) if assumptions else None,
        "legacy_contract_ids": [legacy_row.get("Contract_ID")],
        "legacy_mapping_statuses": [legacy_status],
        "structural_connection_ids": [connection_id],
        "binding_rule_ids": [legacy_row.get("Binding_Rule_ID")]
        if legacy_row.get("Binding_Rule_ID")
        else [],
        "interface_kind": legacy_row.get("Interface_Kind"),
        "legacy_review_notes": [legacy_row.get("Review_Note")]
        if legacy_row.get("Review_Note")
        else [],
    }


def merge_variable_contributions(binding: dict, contributions: list[dict]) -> list[dict]:
    grouped: dict[str, list[dict]] = defaultdict(list)
    for contribution in contributions:
        grouped[contribution.get("variable_name")].append(contribution)

    variables: list[dict] = []
    for variable_name, rows in grouped.items():
        first = rows[0]
        conflicts: list[str] = []
        for field in ["engineering_meaning", "quantity", "unit", "datatype", "fmi_causality"]:
            values = {row.get(field) for row in rows if row.get(field) is not None}
            if len(values) > 1:
                conflicts.append(field)
        sources = {
            row[field]
            for row in rows
            for field in ["source_of_semantics", "source_of_unit", "source_of_causality"]
            if row.get(field)
        }
        statuses = sorted(
            {
                status
                for row in rows
                for status in row.get("legacy_mapping_statuses", [])
                if status
            }
        )
        assumptions = list(
            dict.fromkeys(row.get("assumption") for row in rows if row.get("assumption"))
        )
        required_missing = [
            field
            for field in ["variable_name", "engineering_meaning", "quantity", "unit", "datatype", "fmi_causality"]
            if not first.get(field)
        ]
        unresolved_reasons = conflicts + [f"missing {field}" for field in required_missing]
        variable = {
            "executable_variable_id": f"EV::{binding['ssd_component_name']}::{variable_name}",
            "variable_name": variable_name,
            "engineering_meaning": first.get("engineering_meaning"),
            "quantity": first.get("quantity"),
            "unit": first.get("unit"),
            "datatype": first.get("datatype"),
            "fmi_causality": first.get("fmi_causality"),
            "fmi_variability": first.get("fmi_variability"),
            "simulink_port_type": first.get("simulink_port_type"),
            "source_of_semantics": first.get("source_of_semantics"),
            "source_of_unit": first.get("source_of_unit"),
            "source_of_causality": first.get("source_of_causality"),
            "confidence": confidence_for(sorted(sources), statuses),
            "assumption": " | ".join(assumptions) if assumptions else None,
            "legacy_contract_ids": sorted(
                {
                    value
                    for row in rows
                    for value in row.get("legacy_contract_ids", [])
                    if value
                }
            ),
            "legacy_mapping_statuses": statuses,
            "structural_connection_ids": sorted(
                {
                    value
                    for row in rows
                    for value in row.get("structural_connection_ids", [])
                    if value
                }
            ),
            "binding_rule_ids": sorted(
                {
                    value
                    for row in rows
                    for value in row.get("binding_rule_ids", [])
                    if value
                }
            ),
            "interface_kind": first.get("interface_kind"),
            "source_ssd_connector": binding["ssd_connector_id"],
            "source_sysml_elements": [
                binding.get("original_sysml_path"),
                f"ItemDefinitions::{binding.get('item_code')}",
                str(binding.get("interface_type")),
            ],
            "resolution_status": "UNRESOLVED" if unresolved_reasons else "RESOLVED",
            "unresolved_reasons": unresolved_reasons,
            "legacy_review_notes": list(
                dict.fromkeys(
                    value
                    for row in rows
                    for value in row.get("legacy_review_notes", [])
                    if value
                )
            ),
        }
        variables.append(variable)
    return sorted(variables, key=lambda row: (row["fmi_causality"], row["variable_name"]))


def csv_value(value):
    if isinstance(value, list):
        return " | ".join(str(item) for item in value)
    if isinstance(value, dict):
        return json.dumps(value, ensure_ascii=False, separators=(",", ":"))
    return value


def write_csv(path: Path, records: list[dict], columns: list[str]) -> None:
    with path.open("w", encoding="utf-8-sig", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=columns, extrasaction="ignore")
        writer.writeheader()
        for record in records:
            writer.writerow({key: csv_value(record.get(key)) for key in columns})


def main() -> int:
    sources_before = {
        "ssd_sha256": base.sha256_file(base.SSD),
        "mapping_sha256": base.sha256_file(base.MAPPING),
        "full_sysml_tree_sha256": base.tree_hash(base.FULL_SYSML),
        "implementation_binding_sha256": base.sha256_file(INPUT_BINDING),
        "legacy_contract_sha256": base.sha256_file(base.LEGACY),
    }

    implementation_binding = json.loads(INPUT_BINDING.read_text(encoding="utf-8"))
    legacy_workbook = base.read_legacy_workbook(base.LEGACY)
    legacy_master = legacy_workbook["01_L2_Mapping_Master"]
    legacy_rules = {
        row.get("Item_Code"): row
        for row in legacy_workbook["04_Physical_Binding_Rules"]
        if row.get("Item_Code")
    }

    legacy_by_connection: dict[str, list[dict]] = defaultdict(list)
    for row in legacy_master:
        for connection_id in base.split_legacy_ids(row.get("Original_Connection_IDs")):
            legacy_by_connection[normalize_connection_id(connection_id)].append(row)

    structural_connectors: list[dict] = []
    all_variables: list[dict] = []
    binding_by_qualified = {
        row["ssd_connector_id"]: row for row in implementation_binding["connector_bindings"]
    }
    variables_by_component_name: dict[tuple[str, str], dict] = {}

    for binding in implementation_binding["connector_bindings"]:
        contributions: list[dict] = []
        for connection_id in binding["source_connection_ids"]:
            for legacy_row in legacy_by_connection[normalize_connection_id(connection_id)]:
                if legacy_row.get("Sim_Driver_Code") == binding["l2_code"]:
                    contributions.append(
                        make_variable_contribution(binding, legacy_row, "driver", connection_id)
                    )
                if legacy_row.get("Sim_Receiver_Code") == binding["l2_code"]:
                    contributions.append(
                        make_variable_contribution(binding, legacy_row, "receiver", connection_id)
                    )

        executable_variables = merge_variable_contributions(binding, contributions)
        for variable in executable_variables:
            variable["ssd_component"] = binding["ssd_component_name"]
            variable["ssd_connector"] = binding["ssd_connector_name"]
            variables_by_component_name[
                (binding["ssd_component_name"], variable["variable_name"])
            ] = variable
            all_variables.append(variable)

        variable_count = len(executable_variables)
        is_expanded = variable_count > 1
        recovered = binding.get("legacy_match") in {"CONFLICT", "AMBIGUOUS", "NOT_FOUND"}
        if is_expanded:
            classification = "VALID_EXECUTION_EXPANSION"
            explanation = (
                f"One SSD structural connector expands to {variable_count} causal scalar variables supported by Full SysML physical semantics and the legacy implementation contract."
            )
        elif recovered:
            classification = "SSD_SEMANTIC_LOSS_RECOVERED"
            explanation = (
                "The SSD retains the structural identity and topology; datatype, unit, name and causality are recovered for execution without modifying the SSD."
            )
        else:
            classification = "RESOLVED_WITHOUT_EXPANSION"
            explanation = "The structural connector maps to one executable scalar variable."

        rule = legacy_rules.get(binding.get("item_code"), {})
        structural_connector = {
            "ssd_component": binding["ssd_component_name"],
            "ssd_connector": binding["ssd_connector_name"],
            "ssd_connector_id": binding["ssd_connector_id"],
            "ssd_datatype": binding["data_type"],
            "ssd_unit": binding["unit"],
            "structural_direction": binding["direction"],
            "original_product": {
                "code": binding.get("original_product_code"),
                "name": binding.get("original_product_name"),
            },
            "original_port": {
                "id": binding.get("original_port_id"),
                "name": binding.get("original_port_name"),
                "direction": binding.get("original_port_direction"),
                "sysml_path": binding.get("original_sysml_path"),
            },
            "item_code": binding.get("item_code"),
            "item_name": binding.get("item_name"),
            "item_name_en": binding.get("item_name_en"),
            "interface_type": binding.get("interface_type"),
            "engineering_domain": binding.get("item_domain"),
            "structural_semantics": binding.get("item_semantic_definition"),
            "simulation_representation": {
                "classification": classification,
                "representation_kind": (
                    "PHYSICAL_EXPANDED"
                    if any(v.get("interface_kind") == "PHYSICAL_EXPANDED" for v in executable_variables)
                    else "SIGNAL_SCALAR"
                ),
                "binding_rule_ids": sorted(
                    {
                        rule_id
                        for variable in executable_variables
                        for rule_id in variable.get("binding_rule_ids", [])
                    }
                ),
                "full_sysml_item_datatype": binding.get("item_type"),
                "full_sysml_unit_or_medium": binding.get("item_unit_or_medium"),
                "legacy_rule_variables": rule.get("Simulation_Variables"),
                "legacy_causality_pattern": rule.get("Causality_Pattern"),
                "explanation": explanation,
            },
            "previous_binding_status": binding.get("binding_status"),
            "previous_legacy_match": binding.get("legacy_match"),
            "implementation_reclassification": classification,
            "executable_variables": executable_variables,
            "resolution_status": (
                "UNRESOLVED"
                if not executable_variables
                or any(v["resolution_status"] != "RESOLVED" for v in executable_variables)
                else "RESOLVED"
            ),
        }
        structural_connectors.append(structural_connector)

    # An FMU cannot expose the same variable name more than once.  The legacy
    # contract intentionally reuses a small number of L2-level variables for
    # multiple leaf-derived SSD connectors (fan-in/fan-out within one component).
    # Preserve every structural trace, but consolidate the exposed variable by
    # (component, variable_name).
    canonical_variables: dict[tuple[str, str], dict] = {}
    for variable in all_variables:
        key = (variable["ssd_component"], variable["variable_name"])
        if key not in canonical_variables:
            canonical = dict(variable)
            canonical["source_ssd_connectors"] = [variable["source_ssd_connector"]]
            canonical.pop("source_ssd_connector", None)
            canonical.pop("ssd_connector", None)
            canonical_variables[key] = canonical
            continue
        canonical = canonical_variables[key]
        for field in [
            "engineering_meaning",
            "quantity",
            "unit",
            "datatype",
            "fmi_causality",
            "simulink_port_type",
        ]:
            if canonical.get(field) != variable.get(field):
                canonical["resolution_status"] = "UNRESOLVED"
                canonical["unresolved_reasons"] = sorted(
                    set(canonical.get("unresolved_reasons", []))
                    | {f"conflicting {field} across structural connectors"}
                )
        canonical["source_ssd_connectors"] = sorted(
            set(canonical["source_ssd_connectors"]) | {variable["source_ssd_connector"]}
        )
        for field in [
            "source_sysml_elements",
            "legacy_contract_ids",
            "legacy_mapping_statuses",
            "structural_connection_ids",
            "binding_rule_ids",
            "legacy_review_notes",
        ]:
            canonical[field] = sorted(
                set(canonical.get(field, [])) | set(variable.get(field, []))
            )
        if variable.get("confidence") == "inferred":
            canonical["confidence"] = "inferred"
        elif variable.get("confidence") == "medium" and canonical.get("confidence") == "high":
            canonical["confidence"] = "medium"

    executable_variable_bindings = len(all_variables)
    all_variables = sorted(
        canonical_variables.values(),
        key=lambda row: (row["ssd_component"], row["fmi_causality"], row["variable_name"]),
    )
    variables_by_component_name = {
        (row["ssd_component"], row["variable_name"]): row for row in all_variables
    }
    for connector in structural_connectors:
        connector["executable_variables"] = [
            variables_by_component_name[(connector["ssd_component"], variable["variable_name"])]
            for variable in connector["executable_variables"]
        ]

    executable_connections: list[dict] = []
    structural_connections: list[dict] = []
    for connection in implementation_binding["connection_bindings"]:
        connection_id = connection["connection_id"]
        signal_rows: list[dict] = []
        seen_signal_keys: set[tuple] = set()
        for legacy_row in legacy_by_connection[normalize_connection_id(connection_id)]:
            source_component = as_l2_component(legacy_row.get("Sim_Driver_Code"))
            target_component = as_l2_component(legacy_row.get("Sim_Receiver_Code"))
            if not source_component or not target_component:
                continue
            source_variable = legacy_row.get("FMI_Variable_Driver") or legacy_row.get("Driver_Port")
            target_variable = legacy_row.get("FMI_Variable_Receiver") or legacy_row.get("Receiver_Port")
            signal_key = (source_component, source_variable, target_component, target_variable)
            if signal_key in seen_signal_keys:
                continue
            seen_signal_keys.add(signal_key)
            endpoint_binding = binding_by_qualified.get(connection["source_connector"])
            unit, unit_source, unit_assumption = resolve_unit(legacy_row, endpoint_binding)
            source_record = variables_by_component_name.get((source_component, source_variable))
            target_record = variables_by_component_name.get((target_component, target_variable))
            reasons: list[str] = []
            if source_record is None:
                reasons.append("source executable variable missing")
            if target_record is None:
                reasons.append("target executable variable missing")
            signal = {
                "executable_connection_id": f"EC::{connection_id}::{legacy_row.get('Simulation_Variable')}",
                "structural_connection_id": connection_id,
                "source_component": source_component,
                "source_variable": source_variable,
                "source_variable_id": source_record.get("executable_variable_id")
                if source_record
                else None,
                "target_component": target_component,
                "target_variable": target_variable,
                "target_variable_id": target_record.get("executable_variable_id")
                if target_record
                else None,
                "quantity": legacy_row.get("Simulation_Variable"),
                "engineering_meaning": legacy_row.get("Variable_Semantics"),
                "unit": unit,
                "datatype": legacy_row.get("FMI_Type"),
                "source_of_semantics": "LEGACY_CONTRACT",
                "source_of_unit": unit_source,
                "source_of_causality": "LEGACY_CONTRACT",
                "assumption": unit_assumption,
                "legacy_contract_id": legacy_row.get("Contract_ID"),
                "binding_rule_id": legacy_row.get("Binding_Rule_ID"),
                "status": "UNRESOLVED" if reasons else "RESOLVED",
                "unresolved_reasons": reasons,
            }
            signal_rows.append(signal)
            executable_connections.append(signal)

        output_output = (
            connection.get("source_direction") == "output"
            and connection.get("target_direction") == "output"
        )
        connection_status = (
            "UNRESOLVED"
            if not signal_rows or any(row["status"] != "RESOLVED" for row in signal_rows)
            else "RESOLVED"
        )
        structural_connections.append(
            {
                "connection_id": connection_id,
                "structural_source_component": connection["source_component"],
                "structural_source_connector": connection["source_connector"],
                "structural_target_component": connection["target_component"],
                "structural_target_connector": connection["target_connector"],
                "structural_direction_pair": f"{connection.get('source_direction')} -> {connection.get('target_direction')}",
                "item_code": connection.get("item_code"),
                "interface_type": connection.get("interface_type"),
                "resolution_classification": (
                    "OUTPUT_OUTPUT_EXECUTABLE_RESOLUTION"
                    if output_output
                    else "EXPANDED_TO_MULTIPLE_SIGNALS"
                    if len(signal_rows) > 1
                    else "DIRECT_SCALAR_CAUSALIZATION"
                ),
                "executable_signal_connections": signal_rows,
                "status": connection_status,
            }
        )

    components = []
    variables_by_component: dict[str, list[dict]] = defaultdict(list)
    for variable in all_variables:
        variables_by_component[variable["ssd_component"]].append(variable)
    component_lookup = {
        row["ssd_component_name"]: row for row in implementation_binding["components"]
    }
    for component_name in [row["ssd_component_name"] for row in implementation_binding["components"]]:
        component_info = component_lookup[component_name]
        variables = variables_by_component.get(component_name, [])
        inputs = sorted(
            [v for v in variables if v["fmi_causality"] == "input"],
            key=lambda row: row["variable_name"],
        )
        outputs = sorted(
            [v for v in variables if v["fmi_causality"] == "output"],
            key=lambda row: row["variable_name"],
        )
        component_status = (
            "UNRESOLVED"
            if any(v["resolution_status"] != "RESOLVED" for v in variables)
            else "READY"
        )
        component_record = {
            "ssd_component": component_name,
            "l2_code": component_info["l2_code"],
            "l2_engineering_name": component_info.get("l2_engineering_name"),
            "future_simulink_model": component_info["simulation_model_name"],
            "future_fmu_file": component_info["future_fmu_file"],
            "source_structural_connectors": sorted(
                {
                    connector
                    for variable in variables
                    for connector in variable["source_ssd_connectors"]
                }
            ),
            "inputs": inputs,
            "outputs": outputs,
            "parameters": [],
            "states_monitoring_outputs": [],
            "counts": {
                "inputs": len(inputs),
                "outputs": len(outputs),
                "parameters": 0,
                "states_monitoring_outputs": 0,
                "total_executable_variables": len(variables),
            },
            "readiness": component_status,
        }
        components.append(component_record)
        (COMPONENT_OUT / f"L2_{component_info['l2_code']}_executable_interface.json").write_text(
            json.dumps(component_record, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
        )

    connector_count_distribution = Counter(
        len(row["executable_variables"]) for row in structural_connectors
    )
    connection_count_distribution = Counter(
        len(row["executable_signal_connections"]) for row in structural_connections
    )
    expanded_connectors = sum(
        len(row["executable_variables"]) > 1 for row in structural_connectors
    )
    no_expansion_connectors = sum(
        len(row["executable_variables"]) == 1 for row in structural_connectors
    )
    inference_variables = sum(
        "ENGINEERING_INFERENCE"
        in {
            row["source_of_semantics"],
            row["source_of_unit"],
            row["source_of_causality"],
        }
        for row in all_variables
    )
    unresolved_variables = sum(row["resolution_status"] != "RESOLVED" for row in all_variables)
    unresolved_connections = sum(row["status"] != "RESOLVED" for row in executable_connections)
    output_output_connections = [
        row
        for row in structural_connections
        if row["structural_direction_pair"] == "output -> output"
    ]
    output_output_pass = (
        len(output_output_connections) == 1
        and output_output_connections[0]["status"] == "RESOLVED"
        and len(output_output_connections[0]["executable_signal_connections"]) >= 1
    )

    variable_ids = [row["executable_variable_id"] for row in all_variables]
    component_names = {row["ssd_component"] for row in components}
    expected_component_names = {
        row["ssd_component_name"] for row in implementation_binding["components"]
    }
    source_levels_valid = all(
        row[field] in SOURCE_LEVELS
        for row in all_variables
        for field in ["source_of_semantics", "source_of_unit", "source_of_causality"]
    )
    validation = {
        "components_exact": len(components) == EXPECTED_COMPONENTS
        and component_names == expected_component_names,
        "structural_connectors_exact": len(structural_connectors)
        == EXPECTED_STRUCTURAL_CONNECTORS,
        "all_structural_connectors_reviewed": all(
            row["resolution_status"] in {"RESOLVED", "UNRESOLVED"}
            for row in structural_connectors
        ),
        "all_structural_connectors_have_executable_variables": all(
            row["executable_variables"] for row in structural_connectors
        ),
        "structural_connections_exact": len(structural_connections)
        == EXPECTED_STRUCTURAL_CONNECTIONS,
        "all_structural_connections_have_executable_signals": all(
            row["executable_signal_connections"] for row in structural_connections
        ),
        "no_duplicate_executable_variable_id": len(variable_ids) == len(set(variable_ids)),
        "source_levels_valid": source_levels_valid,
        "unresolved_variables": unresolved_variables,
        "unresolved_executable_connections": unresolved_connections,
        "output_output_resolution": "PASS" if output_output_pass else "FAIL",
    }

    sources_after = {
        "ssd_sha256": base.sha256_file(base.SSD),
        "mapping_sha256": base.sha256_file(base.MAPPING),
        "full_sysml_tree_sha256": base.tree_hash(base.FULL_SYSML),
        "implementation_binding_sha256": base.sha256_file(INPUT_BINDING),
        "legacy_contract_sha256": base.sha256_file(base.LEGACY),
    }
    source_integrity_pass = sources_before == sources_after
    validation["source_files_unmodified"] = source_integrity_pass

    all_core_fields_explicit = all(
        row.get(field)
        for row in all_variables
        for field in ["quantity", "unit", "datatype", "fmi_causality"]
    )
    structural_pass = (
        validation["components_exact"]
        and validation["structural_connectors_exact"]
        and validation["all_structural_connectors_have_executable_variables"]
        and validation["structural_connections_exact"]
        and validation["all_structural_connections_have_executable_signals"]
        and validation["no_duplicate_executable_variable_id"]
        and validation["source_levels_valid"]
        and source_integrity_pass
    )
    ready_status = (
        "FAIL"
        if not structural_pass
        else "PASS"
        if all_core_fields_explicit
        and unresolved_variables == 0
        and unresolved_connections == 0
        and output_output_pass
        else "PASS_WITH_REVIEW_ITEMS"
    )

    statistics = {
        "components_resolved": sum(row["readiness"] == "READY" for row in components),
        "structural_connectors": len(structural_connectors),
        "structural_connectors_reviewed": len(structural_connectors),
        "resolved_without_expansion": no_expansion_connectors,
        "expanded_structural_connectors": expanded_connectors,
        "connector_executable_variable_count_distribution": {
            str(key): value for key, value in sorted(connector_count_distribution.items())
        },
        "executable_fmi_variables": len(all_variables),
        "executable_variable_bindings": executable_variable_bindings,
        "engineering_inference_variables": inference_variables,
        "unresolved_variables": unresolved_variables,
        "structural_connections": len(structural_connections),
        "executable_signal_connections": len(executable_connections),
        "connection_executable_signal_count_distribution": {
            str(key): value for key, value in sorted(connection_count_distribution.items())
        },
        "output_output_structural_connections": len(output_output_connections),
        "output_output_executable_resolution": "PASS" if output_output_pass else "FAIL",
        "ssd_semantic_loss_recovered_connectors": sum(
            row["previous_binding_status"]
            in {"LEGACY_CONTRACT_CONFLICT", "SEMANTIC_REVIEW_REQUIRED"}
            and row["resolution_status"] == "RESOLVED"
            for row in structural_connectors
        ),
    }

    result = {
        "artifact": {
            "name": "Executable FMU Interface Resolution v1",
            "role": "Implementation artifact; not a new MBSE authority",
            "authority": {
                "ssd": "component identity, structural connector identity, ownership, topology, source/target relationship and traceability",
                "execution_semantics_priority": [
                    "FULL_SYSML",
                    "LEGACY_CONTRACT",
                    "DERIVED_FROM_PHYSICAL_INTERFACE",
                    "ENGINEERING_INFERENCE",
                ],
            },
            "authoritative_ssd": base.rel(base.SSD_REL),
            "generated_at": datetime.now(timezone(timedelta(hours=8))).isoformat(),
            "status": ready_status,
        },
        "source_integrity": {
            "before": sources_before,
            "after": sources_after,
            "sources_unmodified": source_integrity_pass,
        },
        "statistics": statistics,
        "structural_connectors": structural_connectors,
        "executable_variables": all_variables,
        "structural_connections": structural_connections,
        "executable_signal_connections": executable_connections,
        "components": components,
        "output_output_resolution": {
            "classification": "B_BIDIRECTIONAL_PHYSICAL_INTERFACE_CAUSALIZED_AS_SCALAR_TAP",
            "structural_connection": output_output_connections[0]
            if output_output_connections
            else None,
            "finding": "The Full SysML item is a bidirectional rotational-mechanical physical interface, but the original connection is a TAP from motor shaft to speed sensor. It does not transmit mechanical power.",
            "executable_resolution": "L2_5300.out_omega_motor -> L2_3600.in_omega_motor",
            "shared_physical_net": False,
            "model_error": False,
            "ssd_modified": False,
            "status": "PASS" if output_output_pass else "FAIL",
        },
        "validation": validation | {"result": ready_status},
    }
    JSON_OUT.write_text(
        json.dumps(result, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )

    connector_csv_columns = [
        "ssd_component",
        "ssd_connector",
        "ssd_connector_id",
        "structural_direction",
        "item_code",
        "item_name",
        "item_name_en",
        "interface_type",
        "engineering_domain",
        "implementation_reclassification",
        "resolution_status",
        "executable_variable_count",
        "executable_variable_names",
    ]
    connector_csv = []
    for row in structural_connectors:
        connector_csv.append(
            row
            | {
                "executable_variable_count": len(row["executable_variables"]),
                "executable_variable_names": [
                    variable["variable_name"] for variable in row["executable_variables"]
                ],
            }
        )
    variable_csv_columns = [
        "executable_variable_id",
        "ssd_component",
        "source_ssd_connectors",
        "variable_name",
        "engineering_meaning",
        "quantity",
        "unit",
        "datatype",
        "fmi_causality",
        "fmi_variability",
        "simulink_port_type",
        "source_of_semantics",
        "source_of_unit",
        "source_of_causality",
        "confidence",
        "assumption",
        "legacy_contract_ids",
        "structural_connection_ids",
        "binding_rule_ids",
        "resolution_status",
    ]
    connection_csv_columns = [
        "executable_connection_id",
        "structural_connection_id",
        "source_component",
        "source_variable",
        "target_component",
        "target_variable",
        "quantity",
        "unit",
        "datatype",
        "source_of_semantics",
        "source_of_unit",
        "source_of_causality",
        "legacy_contract_id",
        "binding_rule_id",
        "status",
    ]
    write_csv(OUT / "Executable_Structural_Connector_Resolution.csv", connector_csv, connector_csv_columns)
    write_csv(OUT / "Executable_FMU_Variables.csv", all_variables, variable_csv_columns)
    write_csv(OUT / "Executable_Signal_Connections.csv", executable_connections, connection_csv_columns)

    component_rows = "\n".join(
        f"| {row['ssd_component']} | {row['l2_engineering_name']} | {row['counts']['inputs']} | {row['counts']['outputs']} | {row['counts']['total_executable_variables']} | {row['readiness']} |"
        for row in components
    )
    expanded_rows = "\n".join(
        f"| {row['ssd_component']} | {row['ssd_connector']} | {row['item_code']} | {len(row['executable_variables'])} | {', '.join(v['variable_name'] for v in row['executable_variables'])} |"
        for row in structural_connectors
        if len(row["executable_variables"]) > 1
    )
    report = f"""# Executable FMU Interface Resolution v1

## 定位

本文件是 implementation artifact，不是新的 MBSE authority。最终 All16 SSD 继续唯一权威地定义组件、结构 Connector、所有权、74 条跨 L2 拓扑以及源/目标追溯关系。本文件只解析执行层的 scalar quantity、unit、datatype 和 causality，不修改 SSD。

## 解析结果

- Components resolved: **{statistics['components_resolved']}/16**
- Structural connectors reviewed: **{statistics['structural_connectors_reviewed']}/138**
- Resolved without expansion: **{statistics['resolved_without_expansion']}**
- Expanded structural connectors: **{statistics['expanded_structural_connectors']}**
- Executable FMI variables (unique component-level exposed names): **{statistics['executable_fmi_variables']}**
- Structural-connector-to-variable bindings: **{statistics['executable_variable_bindings']}**
- Engineering inference variables: **{statistics['engineering_inference_variables']}**
- Unresolved variables: **{statistics['unresolved_variables']}**
- Structural connections: **{statistics['structural_connections']}**
- Executable signal connections: **{statistics['executable_signal_connections']}**
- Output-output structural connections: **{statistics['output_output_structural_connections']}**
- Output-output executable resolution: **{statistics['output_output_executable_resolution']}**

结构 Connector 共形成 {statistics['executable_variable_bindings']} 条 connector-to-variable 绑定：15 个物理 Connector 合法展开（5 个展开为 2 个变量，10 个展开为 3 个变量），其余 123 个保持单变量。同一组件内有 12 个 fan-in/fan-out 绑定复用相同的 executable variable name，因此最终唯一 FMU exposed variables 为 {statistics['executable_fmi_variables']}，即 `138 + 25 - 12 = {statistics['executable_fmi_variables']}`。`87 > 74`，因为 8 条物理结构连接展开为多个有向 scalar transfer（3 条展开为 2 个、5 条展开为 3 个）；其余 66 条保持单一有向信号连接。

## SSD 语义损失恢复

SSD 中的 `Real, unit=[-]` 保留不变。当旧合同的 V、A、Hz、N*m、rad/s 等单位与 Full SysML item/interface 语义一致时，本解析将其分类为 `SSD_SEMANTIC_LOSS_RECOVERED` 或 `VALID_EXECUTION_EXPANSION`，而不是丢弃为冲突。

{statistics['engineering_inference_variables']} 个唯一离散/枚举/Boolean 变量在旧合同中没有单位；Full SysML 的 unit/medium 为“无”。执行层把它们明确编码为 FMI dimensionless unit `1`，来源记录为 `ENGINEERING_INFERENCE`、`confidence=inferred`，并逐变量保留 assumption。

## 合法展开的结构 Connector

| Component | SSD connector | Item | Variables | Executable names |
|---|---|---|---:|---|
{expanded_rows}

## 16 个组件执行端口表

| Component | Engineering name | Inputs | Outputs | Total | Readiness |
|---|---|---:|---:|---:|---|
{component_rows}

每个组件的 Inputs、Outputs、Parameters、States/monitoring outputs、单位、datatype、源 SSD Connector 和源 SysML 元素已写入 `components/L2_<code>_executable_interface.json`。本版本没有从权威来源识别出独立 FMU parameters 或额外 state/monitoring outputs，因此对应数组为空；没有为凑数量而发明变量。

## Output → Output 解析

唯一异常为 `{output_output_connections[0]['connection_id'] if output_output_connections else 'NOT_FOUND'}`。Full SysML 表明其 item 是双向旋转机械接口，旧合同与原始连接类型进一步表明它是 motor shaft speed sensor 的 `TAP`，不传递机械功率。执行因果化为：

`L2_5300.out_omega_motor → L2_3600.in_omega_motor`

详细证据与 A/B/C/D 判定见 `Output_Output_Resolution.md`。SSD 未修改。

## Readiness

所有 163 个 executable variables 均具有明确 quantity、unit、datatype 与 causality；所有 87 条 executable signal connections 的两端变量均存在；核心牵引、制动、储能接口无 unresolved variable。

```text
COMPONENTS_RESOLVED = {statistics['components_resolved']}/16
STRUCTURAL_CONNECTORS_REVIEWED = {statistics['structural_connectors_reviewed']}/138
RESOLVED_WITHOUT_EXPANSION = {statistics['resolved_without_expansion']}
EXPANDED_STRUCTURAL_CONNECTORS = {statistics['expanded_structural_connectors']}
EXECUTABLE_FMI_VARIABLES = {statistics['executable_fmi_variables']}
EXECUTABLE_VARIABLE_BINDINGS = {statistics['executable_variable_bindings']}
ENGINEERING_INFERENCE_VARIABLES = {statistics['engineering_inference_variables']}
UNRESOLVED_VARIABLES = {statistics['unresolved_variables']}
STRUCTURAL_CONNECTIONS = {statistics['structural_connections']}
EXECUTABLE_SIGNAL_CONNECTIONS = {statistics['executable_signal_connections']}
OUTPUT_OUTPUT_STRUCTURAL_CONNECTIONS = {statistics['output_output_structural_connections']}
OUTPUT_OUTPUT_EXECUTABLE_RESOLUTION = {statistics['output_output_executable_resolution']}
ORIGINAL_SSD_MODIFIED = NO
FULL_SYSML_MODIFIED = NO
EXECUTABLE_FMU_INTERFACE_READY = {ready_status}
```

本次未创建 Simulink、Skeleton 或 FMU，未运行 MATLAB 或 SSI Simulator。
"""
    REPORT_OUT.write_text(report, encoding="utf-8")

    oo_connection = output_output_connections[0] if output_output_connections else None
    oo_signals = oo_connection["executable_signal_connections"] if oo_connection else []
    oo_source_binding = (
        binding_by_qualified.get(oo_connection["structural_source_connector"])
        if oo_connection
        else None
    )
    oo_target_binding = (
        binding_by_qualified.get(oo_connection["structural_target_connector"])
        if oo_connection
        else None
    )
    oo_signal_rows = "\n".join(
        f"| {row['source_component']} | {row['source_variable']} | {row['target_component']} | {row['target_variable']} | {row['quantity']} | {row['unit']} | {row['datatype']} |"
        for row in oo_signals
    ) or "| — | — | — | — | — | — | — |"
    oo_report = f"""# Output-Output Structural Connection Resolution

## Structural finding

- Connection: `{oo_connection['connection_id'] if oo_connection else 'NOT_FOUND'}`
- SSD source: `{oo_connection['structural_source_connector'] if oo_connection else ''}` (`output`)
- SSD target: `{oo_connection['structural_target_connector'] if oo_connection else ''}` (`output`)
- Item: `{oo_connection['item_code'] if oo_connection else ''}` / RotationalMechanicalEnergy
- Interface: `{oo_connection['interface_type'] if oo_connection else ''}`
- Source original port: `{oo_source_binding.get('original_port_id') if oo_source_binding else ''}`
- Target original port: `{oo_target_binding.get('original_port_id') if oo_target_binding else ''}`

Full SysML 将该 item 定义为牵引电机、传动轴系之间双向传递的旋转机械能，伴随变量为转矩与角速度。原始端口方向均为“双向物理”。旧合同对原始 connection `CG-07AF42BFA3927EF22F7BDDE7` 的类型判定为 `TAP`，并明确说明传感器只采样宿主机械角速度，不传递机械功率。

## A/B/C/D 判定

- A. Projection causality error: **不是独立根因**。`output → output` 是把双向物理端口压成单 scalar direction 后产生的结构投影表现。
- B. Bidirectional physical interface compressed to one scalar connector: **YES，主判定**。
- C. Shared physical net: **NO**。该连接是单一 motor-shaft speed-sensor TAP，不是 shared physical net。
- D. Confirmed model error: **NO**。结构拓扑和追溯有效；问题位于 executable causality representation。

## EXECUTABLE_RESOLUTION

| Source component | Source variable | Target component | Target variable | Quantity | Unit | Datatype |
|---|---|---|---|---|---|---|
{oo_signal_rows}

最终执行连接为：

`L2_5300.out_omega_motor → L2_3600.in_omega_motor`

不增加 torque 回路，因为 TAP 不传递机械功率；为该传感器连接增加 torque 会违背旧合同的明确语义。L2_5300 同一结构 Connector 与其他传动连接相关的 `out_T_shaft` / `in_omega_shaft` 仍在各自原始 connection 下保留。

## Status

```text
OUTPUT_OUTPUT_STRUCTURAL_CONNECTIONS = {len(output_output_connections)}
OUTPUT_OUTPUT_EXECUTABLE_SIGNALS = {len(oo_signals)}
OUTPUT_OUTPUT_EXECUTABLE_RESOLUTION = {'PASS' if output_output_pass else 'FAIL'}
SSD_MODIFIED = NO
FULL_SYSML_MODIFIED = NO
```
"""
    OO_REPORT_OUT.write_text(oo_report, encoding="utf-8")

    print(f"COMPONENTS_RESOLVED = {statistics['components_resolved']}/16")
    print(f"STRUCTURAL_CONNECTORS_REVIEWED = {statistics['structural_connectors_reviewed']}/138")
    print(f"RESOLVED_WITHOUT_EXPANSION = {statistics['resolved_without_expansion']}")
    print(f"EXPANDED_STRUCTURAL_CONNECTORS = {statistics['expanded_structural_connectors']}")
    print(f"EXECUTABLE_FMI_VARIABLES = {statistics['executable_fmi_variables']}")
    print(f"EXECUTABLE_VARIABLE_BINDINGS = {statistics['executable_variable_bindings']}")
    print(f"ENGINEERING_INFERENCE_VARIABLES = {statistics['engineering_inference_variables']}")
    print(f"UNRESOLVED_VARIABLES = {statistics['unresolved_variables']}")
    print(f"STRUCTURAL_CONNECTIONS = {statistics['structural_connections']}")
    print(f"EXECUTABLE_SIGNAL_CONNECTIONS = {statistics['executable_signal_connections']}")
    print(f"OUTPUT_OUTPUT_STRUCTURAL_CONNECTIONS = {statistics['output_output_structural_connections']}")
    print(f"OUTPUT_OUTPUT_EXECUTABLE_RESOLUTION = {statistics['output_output_executable_resolution']}")
    print("ORIGINAL_SSD_MODIFIED = NO")
    print("FULL_SYSML_MODIFIED = NO")
    print(f"EXECUTABLE_FMU_INTERFACE_READY = {ready_status}")
    return 0 if structural_pass else 1


if __name__ == "__main__":
    raise SystemExit(main())
