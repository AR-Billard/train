FROM ultralytics/ultralytics:latest

COPY --from=docker.io/astral/uv:latest /uv /uvx /bin/

RUN apt-get update && apt-get install -y \
    unzip curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

RUN uv tool install copyparty

COPY --chmod=755 entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
