#!/bin/bash

if pgrep -x "hypridle" > /dev/null
then
    dunstify "Hypridle" "Killing it..."
    pkill -x "hypridle"
else
		dunstify "Hypridle" "Starting it..."
    hypridle & 
fi
