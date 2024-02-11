#!/bin/bash

CONFIG_FILES="$HOME/.config/waybar/config $HOME/.config/waybar/style.css"

trap "killall waybar" EXIT

while true; do
    waybar > /dev/null 2>&1 &
    inotifywait -e create,modify $CONFIG_FILES
    killall waybar
done
