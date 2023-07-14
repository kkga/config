local wezterm = require("wezterm")
local act = wezterm.action

return {
	freetype_load_flags = "NO_HINTING",
	font_size = 13.745,
	font = wezterm.font({
		family = "MD IO 0.7",
		-- weight = "Medium",
		harfbuzz_features = { "dlig=1" },
	}),
	color_scheme = "saturn",
	hide_tab_bar_if_only_one_tab = true,
	use_fancy_tab_bar = false,
	window_decorations = "RESIZE",
	window_padding = { top = 0, bottom = 0, left = 0, right = 0 },
	enable_kitty_keyboard = true,
	enable_csi_u_key_encoding = true,
	keys = {
		-- tabs
		{ key = "j",      mods = "CMD",            action = act.ActivateTabRelative(1) },
		{ key = "k",      mods = "CMD",            action = act.ActivateTabRelative(-1) },
		{ key = "w",      mods = "LEADER|SHIFT",   action = act.CloseCurrentTab({ confirm = true }) },
		-- panes
		{ key = "Return", mods = "CMD",            action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "w",      mods = "CMD",            action = act.CloseCurrentPane({ confirm = true }) },
		{ key = "o",      mods = "CTRL|SHIFT",     action = act.PaneSelect({ mode = "SwapWithActive" }) },
		{ key = "h",      mods = "CTRL|SHIFT",     action = act.ActivatePaneDirection("Left") },
		{ key = "j",      mods = "CTRL|SHIFT",     action = act.ActivatePaneDirection("Down") },
		{ key = "k",      mods = "CTRL|SHIFT",     action = act.ActivatePaneDirection("Up") },
		{ key = "l",      mods = "CTRL|SHIFT",     action = act.ActivatePaneDirection("Right") },
		{ key = "f",      mods = "CTRL|SHIFT",     action = act.TogglePaneZoomState },
		{ key = "Return", mods = "CTRL|SHIFT",     action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "Return", mods = "CTRL|ALT|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		-- disable minimize
		{ key = "m",      mods = "CMD",            action = "DisableDefaultAssignment" },
	},
}
