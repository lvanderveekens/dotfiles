#!/bin/bash

if [ -n "$(amixer get Master | grep off)" ]; then
    echo "Vol: off"    
else 
    echo "Vol: "$(amixer get Master | grep "Front Left:" | awk '{ gsub("\\[|\\]",""); print $5 }')
fi
