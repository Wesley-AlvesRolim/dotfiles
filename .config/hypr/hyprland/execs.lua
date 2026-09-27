hl.on("hyprland.start", function()
	hl.exec_cmd("xdg-portal-hyprland")
	hl.exec_cmd("dbus-update-activation-environment --all")
	hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP QT_QPA_PLATFORMTHEME")

	-- Apps
	hl.exec_cmd("hypridle")
	hl.exec_cmd("hyprpm reload")
	hl.exec_cmd("dunst -conf .config/dunst/dunstrc")
	hl.exec_cmd("sh ~/.config/hypr/scripts/nogaps.sh")
	hl.exec_cmd("gammastep -c ~/.config/gammastep/gammastep.conf")
	hl.exec_cmd("foot --server")
	hl.exec_cmd("~/.local/bin/block_bad_habits.AppImage")
	hl.exec_cmd("~/.local/bin/wesley-tasks.AppImage --autostart")

	-- Bar, wallpaper
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("waybar")

	-- Input method
	hl.exec_cmd("fcitx5")

	-- Clipboard: history
	hl.exec_cmd("wl-paste --watch cliphist store &")
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)
