#!/bin/bash
WORKING_DIR="/home/aug/bin/"
LOG_DIR="/home/aug/.local/share/wezterm"
LOG_FILE="$0"

ALIGN=$1

logger -p user.debug "ALIGN: ${ALIGN}"

cd ${WORKING_DIR}

if [ "$1" == "" ]; then
	lua -l init set_background_vertical_align.lua "Middle"
	lua -l init set_background_horizontal_align.lua "Center"
	exit
fi

case ${ALIGN} in
  "Top"|"top"|"t")
		lua -l init set_background_vertical_align.lua Top;; 
  "Bottom"|"bottom"|"b")
		lua -l init set_background_vertical_align.lua Bottom;;
  "Middle"|"middle"|"m")
		lua -l init set_background_vertical_align.lua Middle;;
  "Left"|"left"|"l")
		lua -l init set_background_horizontal_align.lua Left;;
  "Right"|"right"|"r")
		lua -l init set_background_horizontal_align.lua Right;;
  "Center"|"center"|"c")
		lua -l init set_background_horizontal_align.lua Center;;
  *)
		lua -l init set_background_vertical_align.lua "Middle"
		lua -l init set_background_horizontal_align.lua "Center"
esac

