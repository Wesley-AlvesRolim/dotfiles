require("hyprland.lib")
local var = require("hyprland.variables")

local home_dir = os.getenv("HOME")

local function exec(cmd)
	hl.exec_cmd(cmd)
end

--  █   █ █ █▄ █ █▀▄ ▄▀▄ █   █
--  ▀▄▀▄▀ █ █ ▀█ █▄▀ ▀▄▀ ▀▄▀▄▀

-- Focusing
hl.bind("SUPER + h", function()
	hl.dispatch(hl.dsp.focus({ direction = "l" }))
end)
hl.bind("SUPER + l", function()
	hl.dispatch(hl.dsp.focus({ direction = "r" }))
end)
hl.bind("SUPER + k", function()
	hl.dispatch(hl.dsp.focus({ direction = "u" }))
end)
hl.bind("SUPER + j", function()
	hl.dispatch(hl.dsp.focus({ direction = "d" }))
end)
hl.bind("SUPER + mouse:272", function()
	hl.dispatch(hl.dsp.window.drag())
end, { mouse = true })
hl.bind("SUPER + mouse:273", function()
	hl.dispatch(hl.dsp.window.resize())
end, { mouse = true })
hl.bind("SUPER + Q", function()
	hl.dispatch(hl.dsp.window.close())
end)
hl.bind("SUPER + SHIFT + ALT + Q", function()
	hl.dispatch(hl.dsp.window.kill())
end)
hl.bind("SUPER + S", function()
	hl.dispatch(hl.dsp.window.float())
end)
hl.bind("SUPER + F", function()
	hl.dispatch(hl.dsp.window.fullscreen({ mode = "fullscreen" }))
end)
hl.bind("SUPER + ALT + F", function()
	hl.dispatch(hl.dsp.window.fullscreen({ mode = "maximized" }))
end)

-- Window arrangement
hl.bind("SUPER + SHIFT + h", function()
	hl.dispatch(hl.dsp.window.move({ direction = "l" }))
end)
hl.bind("SUPER + SHIFT + l", function()
	hl.dispatch(hl.dsp.window.move({ direction = "r" }))
end)
hl.bind("SUPER + SHIFT + k", function()
	hl.dispatch(hl.dsp.window.move({ direction = "u" }))
end)
hl.bind("SUPER + SHIFT + j", function()
	hl.dispatch(hl.dsp.window.move({ direction = "d" }))
end)
hl.bind("SUPER + Tab", function()
	hl.dispatch(hl.dsp.layout("swapsplit"))
end)

-- Window split ratio
hl.bind("SUPER + I", function()
	hl.dispatch(hl.dsp.layout("togglesplit"))
end)

-- Window resize
hl.bind("SUPER + ALT + right", function()
	hl.dispatch(hl.dsp.window.resize({ x = 10, y = 0 }))
end)
hl.bind("SUPER + ALT + left", function()
	hl.dispatch(hl.dsp.window.resize({ x = -10, y = 0 }))
end)
hl.bind("SUPER + ALT + up", function()
	hl.dispatch(hl.dsp.window.resize({ x = 0, y = -10 }))
end)
hl.bind("SUPER + ALT + down", function()
	hl.dispatch(hl.dsp.window.resize({ x = 0, y = 10 }))
end)

-- ▄▀▄ █▀▄ █▀▄ ▄▀▀
-- █▀█ █▀  █▀  ▄██

hl.bind("SUPER + T", function()
	exec(var.terminal)
end)
hl.bind("SUPER + Return", function()
	exec(var.terminal)
end)
hl.bind("CTRL + ALT + T", function()
	exec(var.terminal)
end)
hl.bind("SUPER + E", function()
	exec(var.fileManager)
end)
hl.bind("SUPER + W", function()
	exec(var.browser)
end)
hl.bind("SUPER + C", function()
	exec(var.textEditor)
end)
hl.bind("SUPER + SHIFT + C", function()
	exec("hyprpicker -a")
end)
hl.bind("SUPER + SHIFT + R", function()
	exec(home_dir .. "/.config/hypr/scripts/reload.sh")
end)
hl.bind("SUPER + A", function()
	exec(home_dir .. "/.config/hypr/scripts/noidle.sh")
end)

--  █▀▄ ▄▀▄ █▀ █
--  █▀▄ ▀▄▀ █▀ █

local rofi_dir = home_dir .. "/.config/rofi"
hl.bind("SUPER + SUPER_L", function()
	exec(rofi_dir .. "/launcher.sh")
end)
hl.bind("SUPER + SUPER_R", function()
	exec(rofi_dir .. "/launcher.sh")
end)
hl.bind("SUPER + X", function()
	exec(rofi_dir .. "/powermenu.sh")
end)
hl.bind("SUPER + V", function()
	exec(rofi_dir .. "/clipboard.sh")
end)
hl.bind("SUPER + SHIFT + E", function()
	exec(rofi_dir .. "/emoji.sh")
end)
hl.bind("SUPER + SHIFT + Space", function()
	exec(rofi_dir .. "/emoji.sh")
end)

-- Screenshot
local screenshots_dir = home_dir .. "/Pictures/Screenshots"
hl.bind("Print", function()
	exec("hyprshot -m region -o " .. screenshots_dir)
end)
hl.bind("SHIFT + Print", function()
	exec("hyprshot -m output -o " .. screenshots_dir)
end)
hl.bind("SUPER + P", function()
	exec("hyprshot -m region -o " .. screenshots_dir)
end)
hl.bind("SUPER + SHIFT + P", function()
	exec("hyprshot -m output -o " .. screenshots_dir)
end)

--  █   █ ▄▀▄ █▀▄ █▄▀ ▄▀▀ █▀▄ ▄▀▄ ▄▀▀ ██▀
--  ▀▄▀▄▀ ▀▄▀ █▀▄ █ █ ▄██ █▀  █▀█ ▀▄▄ █▄▄

-- Switch workspaces with mainMod + [1-9]
for i = 1, 9 do
	hl.bind("SUPER + " .. i, function()
		hl.dispatch(hl.dsp.focus({ workspace = i }))
	end)
end

-- Move active window to a workspace with mainMod + SHIFT + [1-9]
for i = 1, 9 do
	hl.bind("SUPER + SHIFT + " .. i, function()
		hl.dispatch(hl.dsp.window.move({ workspace = i }))
	end)
end

--  ▄▀▀ █▀▄ ██▀ ▄▀▀ █ ▄▀▄ █     █▄▀ ██▀ ▀▄▀ ▄▀▀
--  ▄██ █▀  █▄▄ ▀▄▄ █ █▀█ █▄▄   █ █ █▄▄  █  ▄██

local function exec_with_audio_notification(cmd, device)
	device = device or "@DEFAULT_AUDIO_SINK@"
	local notifycmd = [[state=$(wpctl get-volume ]]
		.. device
		.. [[); if printf '%s' "$state" | grep -q MUTED; then volume=0; else volume=$(printf '%s' "$state" | awk '{print int($2 * 100)}'); fi; dunstify -h int:value:"$volume" -i "$HOME/.config/dunst/assets/volume.svg" -t 500 -r 2593 "Volume: $volume%"]]
	exec(cmd .. " && " .. notifycmd)
end

local function exec_with_brightness_notification(cmd)
	local notifycmd =
		[[brightness=$(brightnessctl -m | cut -d, -f4 | tr -d '%') && dunstify -h int:value:"$brightness" -i "$HOME/.config/dunst/assets/brightness.svg" -t 500 -r 2593 "Brightness: $brightness%"]]
	exec(cmd .. " && " .. notifycmd)
end

hl.bind("XF86AudioRaiseVolume", function()
	exec_with_audio_notification("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1")
end, { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", function()
	exec_with_audio_notification("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")
end, { locked = true, repeating = true })
hl.bind("XF86AudioMute", function()
	exec_with_audio_notification("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
end, { locked = true })
hl.bind("XF86AudioMicMute", function()
	exec_with_audio_notification("wpctl set-mute @DEFAULT_SOURCE@ toggle", "@DEFAULT_SOURCE@")
end, { locked = true })
hl.bind("XF86MonBrightnessUp", function()
	exec_with_brightness_notification("brightnessctl s 5%+")
end, { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", function()
	exec_with_brightness_notification("brightnessctl s 5%-")
end, { locked = true, repeating = true })
hl.bind("XF86AudioNext", function()
	exec("playerctl next")
end, { locked = true })
hl.bind("XF86AudioPrev", function()
	exec("playerctl previous")
end, { locked = true })
hl.bind("XF86AudioPlay", function()
	exec("playerctl play-pause")
end, { locked = true })
hl.bind("XF86AudioPause", function()
	exec("playerctl play-pause")
end, { locked = true })
