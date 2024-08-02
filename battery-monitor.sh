#!/bin/bash

# Set environment variables
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"

# Full paths for the commands
ACPI_CMD="/usr/bin/acpi"
NOTIFY_SEND_CMD="/usr/bin/notify-send"
ZENITY_CMD="/usr/bin/zenity"
MPV_CMD="/usr/bin/mpv"

# Get battery information using acpi
BATTERY_INFO=$($ACPI_CMD -b | grep 'Battery 1')
BATTERY_LEVEL=$(echo "$BATTERY_INFO" | grep -oP '[0-9]+(?=%)')
BATTERY_STATUS=$(echo "$BATTERY_INFO" | grep -oP '(Charging|Discharging|Full)')

# Store notification texts in variables
HIGH_BATTERY_NOTIFY_TITLE="Charging Limit Reached"
HIGH_BATTERY_NOTIFY_MESSAGE="Battery level is at %$BATTERY_LEVEL. Consider stopping the charging."
LOW_BATTERY_NOTIFY_TITLE="Low Battery Warning"
LOW_BATTERY_NOTIFY_MESSAGE="Battery level is at %$BATTERY_LEVEL. Please charge the battery soon."

# Check battery status and level for high battery warning
if [[ "$BATTERY_STATUS" == "Charging" || "$BATTERY_STATUS" == "Full" ]] && [ "$BATTERY_LEVEL" -ge 80 ]; then
    if ! $NOTIFY_SEND_CMD "$HIGH_BATTERY_NOTIFY_TITLE" "$HIGH_BATTERY_NOTIFY_MESSAGE"; then
        $ZENITY_CMD --notification --text="$HIGH_BATTERY_NOTIFY_MESSAGE"
    fi
    $MPV_CMD /home/aziz/Müzik/Yüksek_Pil_Uyarısı.wav
    echo "Notification sent for battery level $BATTERY_LEVEL"
else
    echo "Battery status is not Charging or Full, or level is below 80%"
fi

# Check battery status and level for low battery warning
if [[ "$BATTERY_STATUS" == "Discharging" ]] && [ "$BATTERY_LEVEL" -le 54 ]; then
    if ! $NOTIFY_SEND_CMD "$LOW_BATTERY_NOTIFY_TITLE" "$LOW_BATTERY_NOTIFY_MESSAGE"; then
        $ZENITY_CMD --notification --text="$LOW_BATTERY_NOTIFY_MESSAGE"
    fi
    $MPV_CMD /home/aziz/Müzik/Düşük_Pil_Uyarısı.wav
    echo "Low battery warning played for battery level $BATTERY_LEVEL"
else
    echo "Battery status is not Discharging, or level is above 54%"
fi

