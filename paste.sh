#!/bin/bash
USER=luciano
PASS=luciano

paste() {
    echo $1 | xclip -i -selection clipboard;
    sh -c 'sleep 0.5; xdotool type "$(xclip -o -selection clipboard)"'
}

paste $USER
xdotool key Tab
paste $PASS
xdotool key Return

