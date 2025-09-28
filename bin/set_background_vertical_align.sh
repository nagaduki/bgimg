#!/bin/bash
WORKING_DIR="/home/aug/bin/"
LOG_DIR="/home/aug/.local/share/wezterm"
LOG_FILE="$0"

ALIGN=$1

logger -p user.debug "ALIGN: ${ALIGN}"

if [ "$1" == "" ]; then
	ALIGN="Middle"
fi

cd ${WORKING_DIR}

lua -l init set_background_vertical_align.lua ${ALIGN}

