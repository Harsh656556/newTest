#!/bin/bash

# 1. Find the ID automatically by name
DEVICE_NAME="YSPRINGTECH USB OPTICAL MOUSE"
ID=$(xinput list --id-only "$DEVICE_NAME")

if [ -z "$ID" ]; then
    echo "Mouse not found. Check the USB connection."
    exit 1
fi

# 2. "Float" the device so it doesn't move the cursor or scroll pages
xinput float $ID

# 3. Listen for the buttons
xinput test $ID | while read line; do
    if [[ $line == "button press   4" ]]; then
        qdbus org.kde.kglobalaccel /component/kmix invokeShortcut 'increase_volume'
    elif [[ $line == "button press   5" ]]; then
        qdbus org.kde.kglobalaccel /component/kmix invokeShortcut 'decrease_volume'
    elif [[ $line == "button press   2" ]]; then
        qdbus org.kde.kglobalaccel /component/kmix invokeShortcut 'mute'
    # BRIGHTNESS CONTROLS
    elif [[ $line == "button press   3" ]]; then
        # Right Click -> Increase Brightness
        qdbus org.kde.kglobalaccel /component/org_kde_powerdevil invokeShortcut 'Increase Screen Brightness'
    elif [[ $line == "button press   1" ]]; then
        # Left Click -> Decrease Brightness
        qdbus org.kde.kglobalaccel /component/org_kde_powerdevil invokeShortcut 'Decrease Screen Brightness'
    fi
done
