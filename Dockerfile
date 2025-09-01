# Postgres 16 base
FROM postgres:16

# Install build deps and compile pgvector from source (alternatively use pgvector/pgvector:pg16/pg17 image)
RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential git postgresql-server-dev-16 && \
    git clone https://github.com/pgvector/pgvector.git /tmp/pgvector && \
    make -C /tmp/pgvector && make -C /tmp/pgvector install && \
    rm -rf /tmp/pgvector && \
    apt-get purge -y build-essential git postgresql-server-dev-16 && \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy per-start wrapper and SQL
COPY always.sh /usr/local/bin/always.sh
COPY sql/always.sql /opt/sql/always.sql
RUN chmod +x /usr/local/bin/always.sh
