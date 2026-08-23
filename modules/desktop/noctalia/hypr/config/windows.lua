--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

hl.workspace_rule({ workspace = "1", monitor = "", persistent = true, default_name = "" })
hl.workspace_rule({ workspace = "2", monitor = "", persistent = true, default_name = "󰊯" })
hl.workspace_rule({ workspace = "3", monitor = "", persistent = true, default_name = "󰖣" })
hl.workspace_rule({ workspace = "4", monitor = "", persistent = true, default_name = "" })

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})
hl.window_rule({
	name = "kitty",
	match = {
		class = "kitty",
	},
	workspace = 1,
})
hl.window_rule({
	name = "google-chrome",
	match = {
		class = "google-chrome",
	},
	workspace = 2,
})
hl.window_rule({
	name = "beeper",
	match = {
		class = "beeper",
	},
	workspace = 3,
})
hl.window_rule({
	name = "steam",
	match = {
		class = "steam",
	},
	workspace = 4,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },

	move = "20 monitor_h-120",
	float = true,
})

hl.layer_rule({
	name = "noctalia",
	match = {
		namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$",
	},
	no_anim = true,
	ignore_alpha = 0.5,
	blur = true,
	blur_popups = true,
})
