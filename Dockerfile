FROM postgres:16

RUN apt-get update && \
    apt-get install -y build-essential git postgresql-server-dev-16 && \
    git clone https://github.com/pgvector/pgvector.git && \
    cd pgvector && \
    make && \
    make install && \
    cd .. && \
    rm -rf pgvector && \
    apt-get remove --purge -y build-essential git postgresql-server-dev-16 && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
