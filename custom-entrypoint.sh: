#!/bin/bash
set -e
# Call the default entrypoint so Postgres starts
/docker-entrypoint.sh postgres &

# Wait for postgres to be ready
until pg_isready -h localhost -p 5432; do
  sleep 2
done

# Run your SQL every time
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f /init.sql

wait
