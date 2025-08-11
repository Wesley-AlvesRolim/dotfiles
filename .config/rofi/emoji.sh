#!/usr/bin/env bash

dir="$HOME/.config/rofi"
theme='config'

## Run
rofimoji \
   --selector rofi \
	 --selector-args "-theme ${dir}/${theme}.rasi -theme-str 'mainbox { children: [\"inputbar\", \"listview\"];}'" \
	 --action copy \
	 --clipboarder wl-copy
