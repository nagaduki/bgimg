#!/bin/bash

FILE=$1
EXE_FILE=ocr-gdrive.py
WORK_DIR=~/bin/
TOKEN=~/gdrive/token.json
CREDENTIAL=~/gdrive/cre.json
EXPANDED_TOKEN=$(echo ${TOKEN})
EXPANDED_CREDENTIAL=$(echo ${CREDENTIAL})
EXPANDED_WORK_DIR=$(echo ${WORK_DIR})
LOG=gdrive_api_error.log

# python3 -m venv ~/Projects/python/ocr-check-app

cd ${EXPANDED_WORK_DIR}
# LC_ALL=C sed -e $'1s/^\xef\xbb\xbf//' -- "$@"

# python3 q6.py -i ${FILE} -a ${EXPANDED_TOKEN} -c ${EXPANDED_CREDENTIAL} 2> "${LOG}" | sed -e 's/、/,/g' \
LC_ALL=C 
# -e 's/^_{3,}//g' \
# python3 ${EXE_FILE} -i ${FILE} -a ${EXPANDED_TOKEN} -c ${EXPANDED_CREDENTIAL} 2> "${LOG}" | sed -e '1s/^\xEF\xBB\xBF//' \
# python3 ${EXE_FILE} -i ${FILE} -a ${EXPANDED_TOKEN} -c ${EXPANDED_CREDENTIAL} 2> "${LOG}" | sed -e '1s/\xEF\xBB\xBF//' \
python3 ${EXE_FILE} -i ${FILE} -a ${EXPANDED_TOKEN} -c ${EXPANDED_CREDENTIAL} 2> "${LOG}" | /usr/bin/sed -re "s/_{3,}//g"  | 
	sed -e '1s/\xEF\xBB\xBF//' \
	-e 's/、/,/g' \
	-e 's/（/(/g' \
	-e 's/ (/(/g' \
	-e 's/）/)/g' \
	-e 's/) /)/g' \
	-e 's/, /,/g' \
	-e 's/ ,/,/g' \
	-e 's/ \./\./g' \
	-e 's/ ~/~/g' \
	-e 's/~ /~/g' \
	-e 's/~/～/g' \
	-e 's/：/:/g' \
	-e '/^$/d' 

# deactivate
