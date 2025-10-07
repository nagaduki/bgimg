#!/bin/bash
WORKING_DIR="/home/aug/bin/"
LOG_DIR="/home/aug/.local/share/wezterm"
LOG_FILE="$0"

FILE=$1
EXT=${FILE##*.}                             
logger -p user.debug "FILE: ${FILE}, EXT: ${EXT}"

FILE_NAME=$(/usr/bin/basename ${FILE%.*})
DIR_NAME=$(/usr/bin/dirname ${FILE%.*})
logger -p user.debug "FILE_NAME: ${FILE_NAME}, DIR_NAME: ${DIR_NAME}"

# 1:
# EXT CHECK
EXT_LOWER=$(echo "${EXT}" | tr '[:upper:]' '[:lower:]')

if [ "${EXT_LOWER}" != "png" ]; then
	echo "extension is ${EXT_LOWER}. image format is allowed PNG only."
	if [ ! -e ${DIR_NAME}/${FILE_NAME}.png ]; then 
		/usr/bin/convert ${FILE} -quality 100 ${DIR_NAME}/${FILE_NAME}.png
	# exit 1
	fi
fi

# 2:
# WINDOWS FILE SYSTEM CHECK:
## sed -i s@'../${dir}/'@@g test.sh
echo ${FILE} | sed 's@/mnt/c/@@g; t; q100;' > /dev/null 2>&1
##echo $?

if [ "$?" != "0" ]; then
	echo "image path is not in windows path. image path must be in windows path."
	exit 1
fi

cd ${WORKING_DIR}

# lua set_background_image.lua ${FILE}
lua -l init set_background_image.lua ${DIR_NAME}/${FILE_NAME}.png


