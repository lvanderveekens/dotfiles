#!/bin/bash

if [ -n $(amixer get Master | grep off) ]; then
    echo "off"    
else 
    echo $(amixer get Master | grep Mono: | awk '{ gsub("\\[|\\]",""); print $4 }')
fi
