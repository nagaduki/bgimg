#!/bin/bash
# UTF-8 BOM 追加
LC_ALL=C sed -e $'1s/^/\xef\xbb\xbf/' -- "$@"
