from pathlib import Path
from pydantic import SecretStr
from pydantic_settings import BaseSettings, SettingsConfigDict

ENV_FILE = Path(__file__).resolve().parents[1] / ".env.local"

class Settings(BaseSettings):
    neo4j_uri: str = "neo4j://127.0.0.1:7687"
    neo4j_database: str = "motor-brake-system"
    neo4j_user: str = "neo4j"
    neo4j_password: SecretStr | None = None
    llm_provider: str = "qwen"
    qwen_api_key: SecretStr | None = None
    qwen_base_url: str = ""
    qwen_model: str = "qwen3.7-flash"
    qwen_timeout_seconds: int = 15
    qwen_enabled: bool = False
    model_config = SettingsConfigDict(env_file=ENV_FILE, env_file_encoding="utf-8", extra="ignore")

    @property
    def neo4j_db(self) -> str: return self.neo4j_database.strip()

settings = Settings()
