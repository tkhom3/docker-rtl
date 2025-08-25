#!/bin/sh
set -eu

if [ -z "${RTL_FREQ:-}" ]; then
    echo "RTL_FREQ is not set. Defaulting to 912M."
    RTL_FREQ="912M"
fi

if [ -n "${ADDITIONAL_PARAMETERS:-}" ]; then
    /usr/bin/rtl_433 -f ${RTL_FREQ} ${ADDITIONAL_PARAMETERS}
else
    /usr/bin/rtl_433 -f ${RTL_FREQ}
fi