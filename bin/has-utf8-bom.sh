#!/bin/bash
# UTF-8 BOM 確認
[[ $(LC_ALL=C head -c 3 -- "$@") == $'\xef\xbb\xbf' ]] && echo 'has utf8 bom.'

