#!/usr/bin/env bash

dir="$HOME/.config/rofi"
theme='config'

if pgrep -x rofi > /dev/null
then
	killall rofi
else
	rofi \
			-show drun \
			-theme ${dir}/${theme}.rasi
fi
