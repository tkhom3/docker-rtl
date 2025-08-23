#!/bin/bash

# Seed config file for first run
if [ ! -f "$CONFIG_DIR/rtl_433.conf" ]; then
    echo "Config file not found in $CONFIG_DIR, copying from /home/$USER..."
    cp /home/$USER/rtl_433_example.conf /$CONFIG_DIR/rtl_433.conf
fi

/usr/bin/rtl_433 -c "$CONFIG_DIR/rtl_433.conf"