#!/usr/bin/env bash

# Current Theme
dir="$HOME/.config/rofi"
theme='config'

# Icons Options
shutdown_icon=''
reboot_icon=''
lock_icon='󰌾'
suspend_icon='󰒲'
logout_icon='󰍃'
yes_icon=''
no_icon=''

# Options with icon + text
shutdown="${shutdown_icon} Shutdown"
reboot="${reboot_icon} Reboot"
lock="${lock_icon} Lock"
suspend="${suspend_icon} Suspend"
logout="${logout_icon} Logout"
yes="${yes_icon} Yes"
no="${no_icon} No"

rofi_cmd() {
	rofi -dmenu \
		-p "$shutdown_icon " \
		-theme ${dir}/${theme}.rasi
}

confirm_cmd() {
	rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 350px; padding: 16px;}' \
     -theme-str 'mainbox {children: [ "message", "listview" ];}' \
     -theme-str 'listview {columns: 2; lines: 1; spacing: 15px;}' \
		 -theme-str 'element {spacing: 0px;}' \
     -theme-str 'element-text {padding: 0; horizontal-align: 0; vertical-align: 0.5;}' \
     -theme-str 'textbox {horizontal-align: 0.5;}' \
     -theme-str 'inputbar {enabled: false;}' \
     -theme-str 'inputbar {enabled: false;}' \
     -dmenu \
     -p 'Confirmation' \
     -mesg 'Are you Sure?' \
     -theme ${dir}/${theme}.rasi
}

confirm_exit() {
	echo -e "$yes\n$no" | confirm_cmd
}

run_rofi() {
	echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

run_cmd() {
	selected="$(confirm_exit)"
	if [[ "$selected" == "$yes" ]]; then
		if [[ $1 == '--shutdown' ]]; then
			systemctl poweroff
		elif [[ $1 == '--reboot' ]]; then
			systemctl reboot
		elif [[ $1 == '--suspend' ]]; then
			systemctl suspend
		elif [[ $1 == '--logout' ]]; then
      hyprctl dispatch exit
		fi
	else
		exit 0
	fi
}

chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
		run_cmd --shutdown
        ;;
    $reboot)
		run_cmd --reboot
        ;;
    $lock)
		hyprlock
        ;;
    $suspend)
		run_cmd --suspend
        ;;
    $logout)
		run_cmd --logout
        ;;
esac
