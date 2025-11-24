FROM debian:13.2-slim

RUN apt-get update && apt-get install -y \
    rtl-433

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENV RTL_FREQ=
ENV ADDITIONAL_PARAMETERS=

WORKDIR /src

COPY run.sh .
RUN chmod +x run.sh

ENTRYPOINT ["sh", "run.sh"]