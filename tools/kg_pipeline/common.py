"""Shared paths, configuration, normalization, and Neo4j helpers."""

from __future__ import annotations

import hashlib
import json
import os
import re
import sys
import unicodedata
from pathlib import Path
from typing import Any, Iterable, Iterator, Sequence


PIPELINE_DIR = Path(__file__).resolve().parent
PROJECT_DIR = PIPELINE_DIR.parents[1]
CONFIG_PATH = PIPELINE_DIR / "config" / "graph_schema.yaml"
WORK_DIR = PIPELINE_DIR / "work"
GRAPH_DATA_PATH = WORK_DIR / "graph_data.json"
RUN_STATE_PATH = WORK_DIR / "run_state.json"
IDEMPOTENCY_BASELINE_PATH = WORK_DIR / "idempotency_baseline.json"
INPUT_WORKBOOK = PROJECT_DIR / "筛选牵引制动架构V2_InterfaceLayer_v1.xlsx"
ITEM_WORKBOOK = PROJECT_DIR / "完整Item字典.xlsx"
INTERFACE_AUDIT_REPORT = PROJECT_DIR / "reports" / "interface_layer_audit.md"
KG_REPORT = PROJECT_DIR / "reports" / "kg_import_report.md"
VALIDATION_QUERIES = PROJECT_DIR / "reports" / "kg_validation_queries.cypher"
LOCAL_ENV_PATH = PIPELINE_DIR / ".env"
ROOT_ENV_PATH = PROJECT_DIR / ".env"
ENV_EXAMPLE_PATH = PIPELINE_DIR / ".env.example"


class MissingEnvironmentError(RuntimeError):
    """Raised when no local secret-bearing .env exists."""


def configure_console() -> None:
    for stream in (sys.stdout, sys.stderr):
        reconfigure = getattr(stream, "reconfigure", None)
        if reconfigure:
            reconfigure(encoding="utf-8", errors="replace")


def load_config() -> dict[str, Any]:
    data = json.loads(CONFIG_PATH.read_text(encoding="utf-8"))
    database = data["database"]
    if database != database.strip():
        raise ValueError(f"数据库名称包含首尾空格: {database!r}")
    if database != "motor-brake-system":
        raise ValueError(f"数据库名称必须为 motor-brake-system，实际为: {database!r}")
    return data


def ensure_inputs() -> None:
    missing = [
        str(path)
        for path in (INPUT_WORKBOOK, ITEM_WORKBOOK, INTERFACE_AUDIT_REPORT)
        if not path.exists()
    ]
    if missing:
        raise FileNotFoundError("缺少必需输入:\n" + "\n".join(missing))


def load_local_environment() -> Path:
    from dotenv import load_dotenv

    env_path = LOCAL_ENV_PATH if LOCAL_ENV_PATH.exists() else ROOT_ENV_PATH
    if not env_path.exists():
        raise MissingEnvironmentError(
            "未找到本地.env，无法进行Neo4j认证。请复制并填写:\n"
            f"  Copy-Item '{ENV_EXAMPLE_PATH}' '{LOCAL_ENV_PATH}'\n"
            f"然后在 {LOCAL_ENV_PATH} 中设置真实 NEO4J_PASSWORD。"
        )
    load_dotenv(env_path, override=False)
    return env_path


def database_settings(config: dict[str, Any]) -> dict[str, str]:
    env_path = load_local_environment()
    uri = os.getenv("NEO4J_URI", config["uri"]).strip()
    database_raw = os.getenv("NEO4J_DATABASE", config["database"])
    user = os.getenv("NEO4J_USER", config["user"]).strip()
    password = os.getenv("NEO4J_PASSWORD", "")
    if database_raw != database_raw.strip():
        raise ValueError(f"NEO4J_DATABASE包含首尾空格: {database_raw!r}")
    database = database_raw.strip()
    if database != config["database"]:
        raise ValueError(f"NEO4J_DATABASE必须为 {config['database']!r}，实际为 {database!r}")
    if not password or password == "replace-with-local-password":
        raise MissingEnvironmentError(f"{env_path} 中缺少有效 NEO4J_PASSWORD。")
    return {"uri": uri, "database": database, "user": user, "password": password, "env_path": str(env_path)}


def neo4j_driver(config: dict[str, Any]):
    from neo4j import GraphDatabase

    settings = database_settings(config)
    driver = GraphDatabase.driver(
        settings["uri"],
        auth=(settings["user"], settings["password"]),
        connection_timeout=10,
        max_connection_lifetime=300,
    )
    return driver, settings


def verify_server(driver, settings: dict[str, str]) -> dict[str, Any]:
    driver.verify_connectivity()
    auth_ok = driver.verify_authentication()
    if auth_ok is False:
        raise PermissionError("Neo4j authentication failed")
    existence_method = "target_database_query"
    listed = None
    try:
        records, _, _ = driver.execute_query(
            "SHOW DATABASES YIELD name RETURN collect(name) AS names",
            database_="system",
        )
        names = list(records[0]["names"]) if records else []
        listed = settings["database"] in names
        existence_method = "SHOW DATABASES"
        if not listed:
            raise RuntimeError(
                f"目标数据库不存在: {settings['database']!r}。现有数据库未被修改。"
            )
    except RuntimeError:
        raise
    except Exception:
        # Some roles cannot SHOW DATABASES. A query against the named database still proves existence.
        listed = None
    try:
        records, _, _ = driver.execute_query("RETURN 1 AS ok", database_=settings["database"])
        if not records or records[0]["ok"] != 1:
            raise RuntimeError("目标数据库连通性检查未返回预期结果。")
    except Exception as exc:
        raise RuntimeError(
            f"无法访问目标数据库 {settings['database']!r}；不会创建、删除或重建数据库。"
        ) from exc
    return {
        "driver_connectivity": True,
        "authentication": True,
        "database_exists": True,
        "database_check_method": existence_method,
        "database_listed": listed,
    }


def normalize_text(value: Any) -> str:
    if value is None:
        return ""
    return unicodedata.normalize("NFKC", str(value)).strip()


def normalize_code(value: Any) -> str:
    text = normalize_text(value).upper()
    if text.endswith(".0") and text[:-2].isdigit():
        text = text[:-2]
    return text


def normalize_id_component(value: Any) -> str:
    text = normalize_text(value)
    text = re.sub(r"\s+", "_", text)
    text = re.sub(r"[:/\\|]+", "_", text)
    return text


def stable_port_id(product_code: str, port_name: str, item_code: str, direction: str) -> str:
    return "PORT::{}::{}::{}::{}".format(
        normalize_code(product_code),
        normalize_id_component(port_name),
        normalize_code(item_code),
        normalize_id_component(direction),
    )


def stable_port_type_id(item_code: str) -> str:
    code = normalize_code(item_code)
    if not code.startswith("ITM-"):
        raise ValueError(f"非法Item code: {item_code}")
    return "PT-" + code.removeprefix("ITM-")


def stable_interface_type_id(item_code: str) -> str:
    code = normalize_code(item_code)
    if not code.startswith("ITM-"):
        raise ValueError(f"非法Item code: {item_code}")
    return "IF-" + code.removeprefix("ITM-")


def product_level(code: str) -> int:
    code = normalize_code(code)
    if len(code) != 4:
        raise ValueError(f"产品code必须为4字符: {code!r}")
    if code[1:] == "000":
        return 1
    if code[2:] == "00":
        return 2
    if code[3] == "0":
        return 3
    return 4


def expected_parent_code(code: str) -> str:
    level = product_level(code)
    if level == 1:
        return ""
    if level == 2:
        return code[0] + "000"
    if level == 3:
        return code[:2] + "00"
    return code[:3] + "0"


def namespace_for_code(code: str) -> str:
    code = normalize_code(code)
    return code[0] if code[0].isalpha() else "CRH"


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for block in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def write_json(path: Path, data: Any) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2), encoding="utf-8")


def read_json(path: Path) -> Any:
    return json.loads(path.read_text(encoding="utf-8"))


def chunked(values: Sequence[Any], size: int = 500) -> Iterator[list[Any]]:
    for start in range(0, len(values), size):
        yield list(values[start : start + size])


def cypher_rows(driver, database: str, query: str, rows: Sequence[dict], **params: Any) -> int:
    total = 0
    for batch in chunked(rows):
        records, summary, _ = driver.execute_query(
            query,
            rows=batch,
            database_=database,
            **params,
        )
        total += len(batch)
    return total

