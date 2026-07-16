#!/usr/bin/env bash

# List visible networks
networks=$(nmcli -t -f SSID dev wifi list | grep -v '^$' | sort -u)

# Show menu
chosen=$(echo "$networks" | wofi -dmenu -i -p "Wi-Fi")

if [[ -n "$chosen" ]]; then
    # Check for a saved connection for this SSID
    saved_conn=$(nmcli -t -f NAME connection show | grep "^$chosen$")

    if [[ -n "$saved_conn" ]]; then
        # Activate the saved connection → will trigger GUI prompt for password if needed
        nmcli connection up "$saved_conn"
    else
        # Only try a direct connection for simple networks
        nmcli dev wifi connect "$chosen"
    fi
fi

