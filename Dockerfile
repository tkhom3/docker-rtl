FROM debian:13.0-slim

RUN apt-get update && apt-get install -y \
    rtl-433

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENV CONFIG_DIR="/config"
ENV USER="rtl_433"
ENV UID="99"
ENV GID="100"

RUN useradd -m $USER && \
    usermod -o -u $UID $USER && \
    groupmod -o -g $GID $USER

RUN mkdir -p $CONFIG_DIR

WORKDIR $CONFIG_DIR

COPY --chown=$USER:$USER rtl_433.conf .
RUN chmod 664 rtl_433.conf

USER $USER

ENTRYPOINT [ "sh", "-c", "/usr/bin/rtl_433 -c ${CONFIG_DIR}/rtl_433.conf" ]
