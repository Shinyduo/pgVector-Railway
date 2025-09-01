#!/bin/bash
set -euo pipefail

# Start the official entrypoint in the background so it handles initdb, users, db, etc.
# It will no-op if PGDATA already initialized.
# We pass "postgres" so it launches the server.
# We let it bind to defaults; we'll connect via localhost (unix socket) for psql.
# Use a subshell to allow readiness waiting.
(
  exec /usr/local/bin/docker-entrypoint.sh postgres
) &

# Wait for server readiness
echo "Waiting for Postgres to be ready..."
until pg_isready -h localhost -U "${POSTGRES_USER:-postgres}" -d "${POSTGRES_DB:-postgres}" >/dev/null 2>&1; do
  sleep 1
done
echo "Postgres is ready."

# Run idempotent SQL every start (safe to re-run)
# -v ON_ERROR_STOP=1 stops on error
# -1 wraps file in a single transaction
psql "host=localhost user=${POSTGRES_USER:-postgres} dbname=${POSTGRES_DB:-postgres}" -v ON_ERROR_STOP=1 -c "CREATE EXTENSION IF NOT EXISTS vector;"
psql "host=localhost user=${POSTGRES_USER:-postgres} dbname=${POSTGRES_DB:-postgres}" -v ON_ERROR_STOP=1 -1 -f /opt/sql/always.sql || true

# Bring postgres (child) to foreground
wait -n
