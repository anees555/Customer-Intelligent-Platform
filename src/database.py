"""PostgreSQL connection helpers."""

from __future__ import annotations

from contextlib import contextmanager

import psycopg2
from psycopg2.extensions import connection as PsycopgConnection

from src.config import get_database_connection_kwargs


def get_connection() -> PsycopgConnection:
	"""Create a new PostgreSQL connection from environment settings."""

	connection_kwargs = get_database_connection_kwargs()

	if "dsn" in connection_kwargs:
		return psycopg2.connect(connection_kwargs["dsn"])

	return psycopg2.connect(**connection_kwargs)


@contextmanager
def get_connection_cursor():
	"""Yield a database cursor and close the connection automatically."""

	connection = get_connection()
	try:
		with connection:
			with connection.cursor() as cursor:
				yield cursor
	finally:
		connection.close()


def test_connection() -> bool:
	"""Return True when PostgreSQL accepts the configured connection."""

	connection = get_connection()
	try:
		with connection.cursor() as cursor:
			cursor.execute("SELECT 1")
			cursor.fetchone()
		return True
	finally:
		connection.close()

