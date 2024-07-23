#!/bin/bash

# Set environment variables
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

# Get battery information using acpi
BATTERY_INFO=$(acpi -b | grep 'Battery 1')
BATTERY_LEVEL=$(echo "$BATTERY_INFO" | grep -oP '[0-9]+(?=%)')
BATTERY_STATUS=$(echo "$BATTERY_INFO" | grep -oP '(Charging|Discharging|Full)')

# Store notification texts in variables
NOTIFY_TITLE="Charging Limit Reached"
NOTIFY_MESSAGE="Battery level is at %$BATTERY_LEVEL. Consider stopping the charging."

# Check battery status and level
if [[ "$BATTERY_STATUS" == "Charging" || "$BATTERY_STATUS" == "Full" ]] && [ "$BATTERY_LEVEL" -ge 84 ]; then
    if ! notify-send "$NOTIFY_TITLE" "$NOTIFY_MESSAGE"; then
        zenity --notification --text="$NOTIFY_MESSAGE"
    fi
    echo "Notification sent for battery level $BATTERY_LEVEL"
else
    echo "Battery status is not Charging or Full, or level is below 84%"
fi
