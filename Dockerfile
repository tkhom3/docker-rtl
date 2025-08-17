FROM debian:13.0-slim

RUN apt-get update && apt-get install -y \
    rtl-433

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENV RTL_FREQ=
ENV SEND_TO_MQTT=
ENV MQTT_USER=
ENV MQTT_PASS=
ENV MQTT_HOST=
ENV MQTT_PORT=1883
ENV MQTT_TOPIC=
ENV MQTT_EVENTS=

WORKDIR /src

COPY run.sh .
RUN chmod +x run.sh

ENTRYPOINT ["sh", "run.sh"]
