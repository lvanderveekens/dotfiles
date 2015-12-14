#!/bin/bash

if [ -n "$(amixer get Master | grep off)" ]; then
    echo "vol off"    
else 
    echo "vol "$(amixer get Master | grep "Front Left:" | awk '{ gsub("\\[|\\]",""); print $5 }')
fi
