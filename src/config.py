"""Application configuration helpers."""

from __future__ import annotations

import os
from dataclasses import dataclass

from dotenv import load_dotenv


load_dotenv()


@dataclass(frozen=True)
class DatabaseConfig:
	host: str
	port: int
	database: str
	user: str
	password: str
	sslmode: str | None = None
	url: str | None = None


def get_database_config() -> DatabaseConfig:
	"""Read database settings from environment variables."""

	return DatabaseConfig(
		host=os.getenv("DB_HOST", "localhost"),
		port=int(os.getenv("DB_PORT", "5432")),
		database=os.getenv("DB_NAME", os.getenv("DB_DATABASE", "")),
		user=os.getenv("DB_USER", ""),
		password=os.getenv("DB_PASSWORD", ""),
		sslmode=os.getenv("DB_SSLMODE"),
		url=os.getenv("DATABASE_URL"),
	)


def get_database_connection_kwargs() -> dict[str, object]:
	"""Build psycopg2 connection kwargs from the environment."""

	config = get_database_config()

	if config.url:
		return {"dsn": config.url}

	kwargs: dict[str, object] = {
		"host": config.host,
		"port": config.port,
		"dbname": config.database,
		"user": config.user,
		"password": config.password,
	}

	if config.sslmode:
		kwargs["sslmode"] = config.sslmode

	return kwargs
