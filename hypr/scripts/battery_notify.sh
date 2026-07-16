#!/bin/bash

while true; do
  capacity=$(cat /sys/class/power_supply/BAT0/capacity)
  status=$(cat /sys/class/power_supply/BAT0/status)

  if [ "$status" = "Discharging" ]; then
    if [ "$capacity" -le 10 ]; then
      notify-send -u critical "🔋 Batterij bijna leeg ($capacity%)"
    elif [ "$capacity" -le 20 ]; then
      notify-send -u normal "Batterij laag ($capacity%)"
    fi
  fi

  sleep 60
done
