#!/bin/bash

if [ -n "$(amixer get Master | grep off)" ]; then
    echo "Vol off"    
else 
    echo "<fc=green>Vol "$(amixer get Master | grep "Front Left:" | awk '{ gsub("\\[|\\]",""); print $5 }')"</fc>"
fi
