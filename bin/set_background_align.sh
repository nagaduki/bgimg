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
  "Top")
		lua -l init set_background_vertical_align.lua ${ALIGN};; 
  "Bottom")
		lua -l init set_background_vertical_align.lua ${ALIGN};;
  "Middle")
		lua -l init set_background_vertical_align.lua ${ALIGN};;
  "Left")
		lua -l init set_background_horizontal_align.lua ${ALIGN};;
  "Right")
		lua -l init set_background_horizontal_align.lua ${ALIGN};;
  "Center")
		lua -l init set_background_horizontal_align.lua ${ALIGN};;
  *)
		lua -l init set_background_vertical_align.lua "Middle"
		lua -l init set_background_horizontal_align.lua "Center"
esac

