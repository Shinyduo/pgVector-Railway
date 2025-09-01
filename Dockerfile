FROM postgres:16

# Install pgvector package matching PG major
RUN apt-get update && \
    apt-get install -y --no-install-recommends postgresql-16-pgvector && \
    rm -rf /var/lib/apt/lists/*

# Optional: per-start wrapper or just rely on init.sql
# COPY always.sh /usr/local/bin/always.sh
# RUN chmod +x /usr/local/bin/always.sh
# ENTRYPOINT ["/usr/local/bin/always.sh"]
# CMD ["postgres"]
