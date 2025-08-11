#!/usr/bin/env bash

dir="$HOME/.config/rofi"
theme='config'

## Run
rofi \
    rofi -modi clipboard:~/.config/rofi/cliphist-rofi -show clipboard -theme ${dir}/${theme}.rasi    
