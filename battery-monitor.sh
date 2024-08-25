#!/usr/bin/env bash

# Set environment variables
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"

# Full paths for the commands
NOTIFY_SEND_CMD="/usr/bin/notify-send"
ZENITY_CMD="/usr/bin/zenity"
MPV_CMD="/usr/bin/mpv"

# Get battery information using acpi
BATTERY_INFO=$(upower -i $(upower -e | grep 'BAT1'))
BATTERY_LEVEL=$(echo "$BATTERY_INFO" | grep percentage | awk '{print $2}' | sed 's/%//')
BATTERY_STATUS=$(upower -i $(upower -e | grep 'BAT1') | grep 'state:' | awk '{print $2}')

# Store notification texts in variables
HIGH_BATTERY_NOTIFY_TITLE="Charging Limit Reached"
HIGH_BATTERY_NOTIFY_MESSAGE="Battery level is at %$BATTERY_LEVEL. Consider stopping the charging."
LOW_BATTERY_NOTIFY_TITLE="Low Battery Warning"
LOW_BATTERY_NOTIFY_MESSAGE="Battery level is at %$BATTERY_LEVEL. Please charge the battery soon."

# Check battery status and level for high battery warning
if [[ "$BATTERY_STATUS" == "charging" || "$BATTERY_STATUS" == "full" ]] && [ "$BATTERY_LEVEL" -ge 80 ]; then
    if ! $NOTIFY_SEND_CMD "$HIGH_BATTERY_NOTIFY_TITLE" "$HIGH_BATTERY_NOTIFY_MESSAGE"; then
        $ZENITY_CMD --notification --text="$HIGH_BATTERY_NOTIFY_MESSAGE"
    fi
    $MPV_CMD /home/aziz/Müzik/battery-status-notifier_assets/Yüksek_Pil_Uyarısı.wav
    echo "Notification sent for battery level $BATTERY_LEVEL"
else
    echo "Battery status is not Charging or Full, or level is below 80%"
fi

# Check battery status and level for low battery warning
if [[ "$BATTERY_STATUS" == "discharging" ]] && [ "$BATTERY_LEVEL" -le 54 ]; then
    if ! $NOTIFY_SEND_CMD "$LOW_BATTERY_NOTIFY_TITLE" "$LOW_BATTERY_NOTIFY_MESSAGE"; then
        $ZENITY_CMD --notification --text="$LOW_BATTERY_NOTIFY_MESSAGE"
    fi
    $MPV_CMD /home/aziz/Müzik/battery-status-notifier_assets/Düşük_Pil_Uyarısı.wav
    echo "Low battery warning played for battery level $BATTERY_LEVEL"
else
    echo "Battery status is not Discharging, or level is above 54%"
fi

