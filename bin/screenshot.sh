#!/bin/bash
SCREENSHOT_DIR=/home/petee/scrot
if [[ ! -d "${SCREENSHOT_DIR}" ]]; then
    mkdir -p ${SCREENHSHOT_DIR}
fi
scrot -s -e "mv \$f ${SCREENSHOT_DIR}/; echo ${SCREENSHOT_DIR}/\$f | xsel -b"
