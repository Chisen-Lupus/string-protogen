#!/bin/bash

# Paths to the two HTML files
HTML_FILE_1="$(pwd)/test.html"
HTML_FILE_2="$(pwd)/test_mirror.html"

# Ensure the DISPLAY variable is set correctly
export DISPLAY=:0

# Browser command
BROWSER="chromium"

# Open first window with initial size and get its ID
$BROWSER --new-window "file://$HTML_FILE_1" --window-size=800,600 &
sleep 2  # Adjust delay for Chromium window creation
first_id=$(xdotool search --class "chromium" | tail -n 1)
if [ -z "$first_id" ]; then
    echo "Error: Unable to find first Chromium window."
    exit 1
fi
echo "Debug: First Window ID is $first_id"

# Move the first window to position (0, 0)
xdotool windowactivate "$first_id"
xdotool windowmove "$first_id" 0 0
# Send F11 to the first window to make it fullscreen
xdotool key --window "$first_id" F11

# Open second window with initial size and get its ID
$BROWSER --new-window "file://$HTML_FILE_2" --window-size=800,600 &
sleep 2
second_id=$(xdotool search --class "chromium" | tail -n 1)
if [ -z "$second_id" ]; then
    echo "Error: Unable to find second Chromium window."
    exit 1
fi
echo "Debug: Second Window ID is $second_id"

# Move the second window to position (1920, 0)
xdotool windowactivate "$second_id"
xdotool windowmove "$second_id" 1920 0
# Send F11 to the second window to make it fullscreen
xdotool key --window "$second_id" F11
