#!/bin/bash
WORKING_DIR="/home/aug/bin/"
LOG_DIR="/home/aug/.local/share/wezterm"
LOG_FILE="$0"

logger -p user.debug "BRIGHTNESS 0.1"

cd ${WORKING_DIR}

echo set background brightness 0.1
lua -l init set_background_hsb_brightness_dark.lua 

