#!/bin/bash

# Kill all running instances
killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 0.2; done

# Detect connected monitors
MONITORS=$(xrandr --query | grep " connected" | cut -d" " -f1)

# Loop through all connected monitors
for m in $MONITORS; do
    case "$m" in
        eDP-1)
            MONITOR=$m polybar --reload mainbar &
            ;;
        HDMI*|DP*)
            MONITOR=$m polybar --reload secondbar &
            ;;
        *)
            echo "No bar configured for monitor: $m"
            ;;
    esac
done
