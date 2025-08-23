FROM debian:13.0-slim

RUN apt-get update && apt-get install -y \
    rtl-433

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENV CONFIG_DIR="/config"

RUN mkdir -p $CONFIG_DIR

WORKDIR $CONFIG_DIR

COPY rtl_433.conf .

ENTRYPOINT [ "sh", "-c", "/usr/bin/rtl_433 -c ${CONFIG_DIR}/rtl_433.conf" ]
