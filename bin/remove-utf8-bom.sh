#!/bin/bash
# UTF-8 BOM 削除
LC_ALL=C sed -e $'1s/^\xef\xbb\xbf//' -- "$@"
