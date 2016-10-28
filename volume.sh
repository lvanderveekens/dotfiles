#!/bin/sh
# A simple shell script that reads the volume level

if [ -n "$(amixer get Master | grep off)" ]; then
    VOL=OFF
else 
    VOL=$(amixer get Master | grep "Front Left:" | awk '{ gsub("\\[|\\]",""); print $5 }')
fi

echo "<fc=red>vol</fc> $VOL"
