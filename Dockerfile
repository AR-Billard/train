FROM debian:bookworm-slim

COPY --from=docker.io/astral/uv:latest /uv /uvx /bin/

RUN apt-get update && apt-get install -y \
    && apt-get install -y sudo curl git unzip wget lsb-release software-properties-common gnupg gdb libgl1 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

RUN uv tool install ultralytics
RUN uv tool install copyparty

COPY --chmod=755 entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
