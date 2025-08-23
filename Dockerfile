FROM debian:13.0-slim

RUN apt-get update && apt-get install -y \
    rtl-433 \
    usbutils

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENV CONFIG_DIR="/config"
ENV USER="rtl_433"
ENV UID="99"
ENV GID="100"

RUN useradd -m $USER && \
    usermod -o -u $UID $USER && \
    groupmod -o -g $GID $USER

RUN mkdir -p $CONFIG_DIR

WORKDIR /home/$USER

COPY --chown=$USER:$USER rtl_433_example.conf .
COPY --chown=$USER:$USER run.sh .
RUN chmod 554 run.sh && \
    chmod 664 rtl_433_example.conf

# USER $USER # to-do: run as non-root user https://www.instructables.com/rtl-sdr-on-Ubuntu/

ENTRYPOINT [ "sh", "run.sh" ]
