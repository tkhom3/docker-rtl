#!/bin/sh
set -eu

if [ -z "${RTL_FREQ:-}" ]; then
    echo "RTL_FREQ is not set. Defaulting to 912M."
    RTL_FREQ="912M"
fi

if [ "${SEND_TO_MQTT}" = "true" ]; then
    echo "SEND_TO_MQTT is set to 'true'. Sending output to MQTT broker."

    if [ -z "${MQTT_HOST:-}" ]; then
        echo "MQTT_HOST is not set. Please set it before running the container."
        exit 1
    fi

    if [ -z "${MQTT_PORT:-}" ]; then
        echo "MQTT_PORT is not set. Defaulting to 1883."
        MQTT_PORT=1883
    fi

    if [ -z "${MQTT_USER:-}" ]; then
        echo "MQTT_USER is not set. Please set it before running the container."
        exit 1
    fi

    if [ -z "${MQTT_PASS:-}" ]; then
        echo "MQTT_PASS is not set. Please set it before running the container."
        exit 1
    fi

    HOSTNAME="$(hostname)"
    if [ -z "${HOSTNAME:-}" ]; then
        echo "Could not find hostname. Setting to 'rtl_433'."
        HOSTNAME="rtl_433"
    fi
    
    echo "Using hostname: ${HOSTNAME}"

    if [ -z "${MQTT_EVENTS:-}" ]; then
    echo "MQTT_EVENTS is not set. Defaulting to '[/model][/id]'."
    MQTT_EVENTS="[/model][/id]"
    fi

    /usr/bin/rtl_433 -f ${RTL_FREQ} -F "mqtt://${MQTT_HOST}:${MQTT_PORT},user=${MQTT_USER},pass=${MQTT_PASS},events=${HOSTNAME}${MQTT_EVENTS}}"

elif [ "${SEND_TO_MQTT}" = "false" ]; then
    echo "SEND_TO_MQTT is set to 'false'. Sending output to stdout."
    /usr/bin/rtl_433 -f "${RTL_FREQ}"

else
    echo "Invalid SEND_TO_MQTT value."
    exit 1
fi
