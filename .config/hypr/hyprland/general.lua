hl.monitor({
	output = "HDMI-A-1",
	mode = "1920x1080@180",
	position = "auto",
	scale = "1",
})

hl.device({
	name = "elan1205:00-04f3:30e9-touchpad",
	sensitivity = 0,
})

hl.config({
	input = {
		kb_layout = "br",
		kb_variant = "abnt2",
		kb_options = "grp:win_space_toggle",
		numlock_by_default = true,
		repeat_delay = 250,
		repeat_rate = 35,

		touchpad = {
			natural_scroll = false,
			disable_while_typing = false,
			clickfinger_behavior = true,
			scroll_factor = 1.5,
		},

		special_fallthrough = true,
		follow_mouse = 1,
		force_no_accel = false,
	},

	binds = {
		scroll_event_delay = 0,
	},

	-- gestures = {
	-- 	-- workspace_swipe = true,
	-- 	workspace_swipe_distance = 700,
	-- 	-- workspace_swipe_fingers = 3,
	-- 	workspace_swipe_cancel_ratio = 0.2,
	-- 	workspace_swipe_min_speed_to_force = 5,
	-- 	workspace_swipe_direction_lock = true,
	-- 	workspace_swipe_direction_lock_threshold = 10,
	-- 	workspace_swipe_create_new = true,
	-- },

	general = {
		gaps_in = 12,
		gaps_out = 20,
		gaps_workspaces = 50,
		border_size = 2,
		col = {
			active_border = "rgba(3B294AFF)",
			inactive_border = "rgba(31313600)",
		},
		resize_on_border = true,
		no_focus_fallback = true,
		layout = "dwindle",
		allow_tearing = true,
	},

	dwindle = {
		preserve_split = true,
		smart_split = true,
		smart_resizing = false,
	},

	misc = {
		vrr = 0,
		focus_on_activate = false,
		animate_manual_resizes = false,
		animate_mouse_windowdragging = false,
		enable_swallow = false,
		swallow_regex = "(foot|ghostty|Ghostty)",
		disable_hyprland_logo = true,
		force_default_wallpaper = 0,
		on_focus_under_fullscreen = 2,
		allow_session_lock_restore = true,
		initial_workspace_tracking = false,
	},
})

hl.config({
	decoration = {
		rounding = 20,
		shadow = {
			enabled = false,
		},
		blur = {
			enabled = true,
			xray = true,
			size = 7,
			vibrancy_darkness = 3.0,
			passes = 4,
			vibrancy = 0.1796,
		},
	},
})

hl.config({
	decoration = {
		rounding = 6,
		blur = {
			enabled = true,
			xray = true,
			special = false,
			new_optimizations = true,
			size = 4,
			passes = 4,
			brightness = 2,
			noise = 0,
			contrast = 2,
			popups = true,
			popups_ignorealpha = 0.6,
		},
		dim_inactive = false,
		dim_strength = 0.1,
		dim_special = 0,
	},
})

hl.config({
	animations = {
		enabled = true,
	},
})

hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("md3_standard", { type = "bezier", points = { { 0.2, 0 }, { 0, 1 } } })
hl.curve("md3_decel", { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } })
hl.curve("md3_accel", { type = "bezier", points = { { 0.3, 0 }, { 0.8, 0.15 } } })
hl.curve("overshot", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.1 } } })
hl.curve("crazyshot", { type = "bezier", points = { { 0.1, 1.5 }, { 0.76, 0.92 } } })
hl.curve("hyprnostretch", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.0 } } })
hl.curve("menu_decel", { type = "bezier", points = { { 0.1, 1 }, { 0, 1 } } })
hl.curve("menu_accel", { type = "bezier", points = { { 0.38, 0.04 }, { 1, 0.07 } } })
hl.curve("easeInOutCirc", { type = "bezier", points = { { 0.85, 0 }, { 0.15, 1 } } })
hl.curve("easeOutCirc", { type = "bezier", points = { { 0, 0.55 }, { 0.45, 1 } } })
hl.curve("easeOutExpo", { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } })
hl.curve("softAcDecel", { type = "bezier", points = { { 0.26, 0.26 }, { 0.15, 1 } } })
hl.curve("md2", { type = "bezier", points = { { 0.4, 0 }, { 0.2, 1 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 3, bezier = "md3_decel", style = "popin 60%" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 3, bezier = "md3_decel", style = "popin 60%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "md3_accel", style = "popin 60%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "md3_decel" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 3, bezier = "menu_decel", style = "slide" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.6, bezier = "menu_accel" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 2, bezier = "menu_decel" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 4.5, bezier = "menu_accel" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 7, bezier = "menu_decel", style = "slide" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 2.5, bezier = "softAcDecel", style = "slide" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 7, bezier = "menu_decel", style = "slidefade 15%" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3, bezier = "md3_decel", style = "slidefadevert 15%" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3, bezier = "md3_decel", style = "slidevert" })
