#!/bin/bash
WORKING_DIR="/home/aug/bin/"
LOG_DIR="/home/aug/.local/share/wezterm"
LOG_FILE="$0"

MAG_RATE=$1

logger -p user.debug "MAG RATE: ${MAG_RATE}"

if [ "$1" == "" ]; then
	#echo "input mag rate."
	#exit 1
	MAG_RATE=1.0
fi

cd ${WORKING_DIR}

lua -l init set_background_zoom.lua ${MAG_RATE}

