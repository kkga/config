local wezterm = require("wezterm")
local act = wezterm.action

-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
local function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return 'Dark'
end

local function scheme_for_appearance(appearance)
	if appearance:find 'Dark' then
		return 'saturn'
	else
		return 'saturn'
	end
end

return {
	font_size = 13,
	-- line_height = 1.2,
	-- freetype_load_flags = 'FORCE_AUTOHINT',
	-- freetype_load_target = "Light",
	-- freetype_render_target = 'HorizontalLcd',
	font = wezterm.font({
		-- family = "CommitMono",
		family = "Berkeley Mono",
	}),
	-- harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
	color_scheme = scheme_for_appearance(get_appearance()),
	hide_tab_bar_if_only_one_tab = true,
	use_fancy_tab_bar = false,
	window_decorations = "RESIZE",
	window_padding = { top = 0, bottom = 0, left = 0, right = 0 },
	enable_kitty_keyboard = true,
	enable_csi_u_key_encoding = true,
	warn_about_missing_glyphs = true,
	-- enable_scroll_bar = true,
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
