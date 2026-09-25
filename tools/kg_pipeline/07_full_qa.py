"""Run read-only QA against the actual Neo4j target database."""

from __future__ import annotations

import argparse
import json
from pathlib import Path

from common import load_config, neo4j_driver, read_json, verify_server, write_json, GRAPH_DATA_PATH


EXPECTED = {
    "Product": 147,
    "level_1": 8,
    "level_2": 16,
    "level_3": 34,
    "level_4": 89,
    "standard_299": 120,
    "project_extension": 25,
    "external_system": 2,
    "selected_leaf": 90,
    "Item": 144,
    "Profile": 1,
    "CONTAINS": 139,
    "EXPOSES": 517,
    "active_EXPOSES": 511,
    "inactive_EXPOSES": 6,
    "Port": 0,
}


def scalar(driver, database: str, query: str, **params):
    records, _, _ = driver.execute_query(query, database_=database, **params)
    return records[0][0]


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    config = load_config()
    project_id = config["project_id"]
    profile_id = config["profile"]["profile_id"]
    driver, settings = neo4j_driver(config)
    try:
        server = verify_server(driver, settings)
        database = settings["database"]
        actual = {
            "Product": scalar(driver, database, "MATCH (n:Product) RETURN count(n)"),
            "Item": scalar(driver, database, "MATCH (n:Item) RETURN count(n)"),
            "Profile": scalar(driver, database, "MATCH (n:Profile) RETURN count(n)"),
            "CONTAINS": scalar(driver, database, "MATCH ()-[r:CONTAINS]->() RETURN count(r)"),
            "EXPOSES": scalar(driver, database, "MATCH ()-[r:EXPOSES]->() RETURN count(r)"),
            "active_EXPOSES": scalar(driver, database, "MATCH ()-[r:EXPOSES {profile_id:$profile,profile_active:true}]->() RETURN count(r)", profile=profile_id),
            "inactive_EXPOSES": scalar(driver, database, "MATCH ()-[r:EXPOSES {profile_id:$profile,profile_active:false}]->() RETURN count(r)", profile=profile_id),
            "Port": scalar(driver, database, "MATCH (n:Port) RETURN count(n)"),
            "selected_leaf": scalar(driver, database, "MATCH (n:Product {selected:true,leaf:true}) RETURN count(n)"),
        }
        level_records, _, _ = driver.execute_query(
            "MATCH (n:Product) RETURN n.level AS level, count(n) AS count ORDER BY level",
            database_=database,
        )
        for record in level_records:
            actual[f"level_{record['level']}"] = record["count"]
        source_records, _, _ = driver.execute_query(
            "MATCH (n:Product) RETURN n.source_type AS source_type, count(n) AS count ORDER BY source_type",
            database_=database,
        )
        for record in source_records:
            actual[record["source_type"]] = record["count"]

        diagnostics = {
            "E100_state": scalar(driver, database, "MATCH (n:Product {code:'E100'}) RETURN collect({level:n.level,leaf:n.leaf})"),
            "EXPOSES_from_non_leaf": scalar(driver, database, "MATCH (p:Product)-[r:EXPOSES]->() WHERE p.leaf <> true RETURN count(r)"),
            "EXPOSES_wrong_endpoints": scalar(driver, database, "MATCH (a)-[r:EXPOSES]->(b) WHERE NOT a:Product OR NOT b:Item RETURN count(r)"),
            "CONTAINS_wrong_endpoints": scalar(driver, database, "MATCH (a)-[r:CONTAINS]->(b) WHERE NOT a:Product OR NOT b:Product RETURN count(r)"),
            "CONNECTS_TO": scalar(driver, database, "MATCH ()-[r:CONNECTS_TO]->() RETURN count(r)"),
            "duplicate_Product_code_groups": scalar(driver, database, "MATCH (n:Product) WITH n.code AS key,count(*) AS c WHERE c>1 RETURN count(*)"),
            "duplicate_Item_code_groups": scalar(driver, database, "MATCH (n:Item) WITH n.item_code AS key,count(*) AS c WHERE c>1 RETURN count(*)"),
            "duplicate_Profile_id_groups": scalar(driver, database, "MATCH (n:Profile) WITH n.profile_id AS key,count(*) AS c WHERE c>1 RETURN count(*)"),
            "duplicate_CONTAINS_id_groups": scalar(driver, database, "MATCH ()-[r:CONTAINS]->() WITH r.relation_id AS key,count(*) AS c WHERE c>1 RETURN count(*)"),
            "duplicate_EXPOSES_id_groups": scalar(driver, database, "MATCH ()-[r:EXPOSES]->() WITH r.port_id AS key,count(*) AS c WHERE c>1 RETURN count(*)"),
            "foreign_project_nodes": scalar(driver, database, "MATCH (n) WHERE (n:Product OR n:Item OR n:Profile) AND n.project_id <> $project RETURN count(n)", project=project_id),
            "foreign_project_relationships": scalar(driver, database, "MATCH ()-[r]->() WHERE (type(r)='CONTAINS' OR type(r)='EXPOSES') AND r.project_id <> $project RETURN count(r)", project=project_id),
        }

        key_queries = {
            "5000_hierarchy_nodes": scalar(driver, database, "MATCH (:Product {code:'5000'})-[:CONTAINS*0..]->(p:Product) RETURN count(DISTINCT p)"),
            "5311_EXPOSES": scalar(driver, database, "MATCH (:Product {code:'5311'})-[r:EXPOSES]->(:Item) RETURN count(r)"),
            "rotational_mechanical_energy_EXPOSES": scalar(driver, database, "MATCH (:Product)-[r:EXPOSES]->(:Item {item_name_cn:'旋转机械能'}) RETURN count(r)"),
            "active_physical_EXPOSES": scalar(driver, database, "MATCH (:Product)-[r:EXPOSES {profile_id:$profile,profile_active:true}]->(:Item) WHERE r.port_category='物理' RETURN count(r)", profile=profile_id),
            "inactive_profile_EXPOSES": scalar(driver, database, "MATCH (:Product)-[r:EXPOSES {profile_id:$profile,profile_active:false}]->(:Item) RETURN count(r)", profile=profile_id),
            "X000_hierarchy_nodes": scalar(driver, database, "MATCH (:Product {code:'X000'})-[:CONTAINS*0..]->(p:Product) RETURN count(DISTINCT p)"),
            "ITM_PHY_003_EXPOSES": scalar(driver, database, "MATCH (:Product)-[r:EXPOSES]->(:Item {item_code:'ITM-PHY-003'}) RETURN count(r)"),
            "Port_nodes": actual["Port"],
        }

        offline = read_json(GRAPH_DATA_PATH)["meta"]["counts"]
        offline_expected = {
            "Product": offline["products"],
            "Item": offline["items"],
            "CONTAINS": offline["contains"],
            "EXPOSES": offline["exposes"],
            "selected_leaf": offline["selected_leaves"],
            "active_EXPOSES": offline["active_exposes"],
            "inactive_EXPOSES": offline["inactive_exposes"],
        }
        checks = {f"count_{key}": actual.get(key) == value for key, value in EXPECTED.items()}
        checks.update({
            "offline_matches_database": all(actual[key] == value for key, value in offline_expected.items()),
            "E100_level_2_leaf_true": diagnostics["E100_state"] == [{"level": 2, "leaf": True}],
            "all_EXPOSES_products_are_leaf": diagnostics["EXPOSES_from_non_leaf"] == 0,
            "EXPOSES_endpoint_types": diagnostics["EXPOSES_wrong_endpoints"] == 0,
            "CONTAINS_endpoint_types": diagnostics["CONTAINS_wrong_endpoints"] == 0,
            "no_CONNECTS_TO": diagnostics["CONNECTS_TO"] == 0,
            "unique_identifiers": all(value == 0 for key, value in diagnostics.items() if key.startswith("duplicate_")),
            "project_scope": diagnostics["foreign_project_nodes"] == 0 and diagnostics["foreign_project_relationships"] == 0,
            "validation_inactive_query": key_queries["inactive_profile_EXPOSES"] == 6,
        })
        result = {
            "server": server,
            "uri": settings["uri"],
            "database": database,
            "actual": actual,
            "diagnostics": diagnostics,
            "key_validation_queries": key_queries,
            "checks": checks,
            "all_kg_qa": "PASS" if all(checks.values()) else "FAIL",
        }
        if args.output:
            write_json(args.output, result)
        print(json.dumps(result, ensure_ascii=False, indent=2))
        if result["all_kg_qa"] != "PASS":
            raise SystemExit(1)
    finally:
        driver.close()


if __name__ == "__main__":
    main()
