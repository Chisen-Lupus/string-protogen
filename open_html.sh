#!/bin/bash

# Paths to the two HTML files
HTML_FILE_1="$(pwd)/test.html"
HTML_FILE_2="$(pwd)/test_mirror.html"

# Browser command
BROWSER="chromium"

# Open first window
$BROWSER --new-window "file://$HTML_FILE_1" --window-size=800,600 &
sleep 2  # Adjust delay for Chromium window creation

# Get the identifier of the first window
first_window=$(swaymsg -t get_tree | jq -r '.. | select(.app_id? and .app_id == "chromium") | .id' | tail -n 1)
if [ -z "$first_window" ]; then
    echo "Error: Unable to find first Chromium window."
    exit 1
fi
echo "Debug: First Window ID is $first_window"

# Move the first window to workspace 1 and set fullscreen
swaymsg "[con_id=$first_window]" move workspace 1
swaymsg "[con_id=$first_window]" fullscreen

# Open second window
$BROWSER --new-window "file://$HTML_FILE_2" --window-size=800,600 &
sleep 2  # Adjust delay for Chromium window creation

# Get the identifier of the second window
second_window=$(swaymsg -t get_tree | jq -r '.. | select(.app_id? and .app_id == "chromium") | .id' | tail -n 1)
if [ -z "$second_window" ]; then
    echo "Error: Unable to find second Chromium window."
    exit 1
fi
echo "Debug: Second Window ID is $second_window"

# Move the second window to workspace 2 and set fullscreen
swaymsg "[con_id=$second_window]" move workspace 2
swaymsg "[con_id=$second_window]" fullscreen
