local wezterm = require("wezterm")
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
local config = wezterm.config_builder()
local act = wezterm.action

wezterm.on("toggle-tabbar", function(window, _)
	local overrides = window:get_config_overrides() or {}
	local current_override_state = overrides.enable_tab_bar

	local new_state
	if current_override_state == nil then
		new_state = false
	else
		new_state = not current_override_state
	end

	overrides.enable_tab_bar = new_state
	window:set_config_overrides(overrides)
	return true
end)

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.window_content_alignment = {
	horizontal = "Center",
	vertical = "Center",
}

config.adjust_window_size_when_changing_font_size = false
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.inactive_pane_hsb = {
	saturation = 1,
	brightness = 1,
}

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 3000 }
config.disable_default_key_bindings = true
config.keys = {
	-- Leader bindings
	{ key = "a", mods = "LEADER|CTRL", action = act.SendKey({ key = "a", mods = "CTRL" }) },
	{ key = "r", mods = "LEADER", action = act.ReloadConfiguration },
	{ key = "\\", mods = "LEADER", action = act.SplitPane({ direction = "Down", size = { Percent = 50 } }) },
	{
		key = "|",
		mods = "LEADER|SHIFT",
		action = act.SplitPane({ direction = "Right", size = { Percent = 50 } }),
	},
	{ key = "H", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Left", 1 }) },
	{ key = "J", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Down", 1 }) },
	{ key = "K", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Up", 1 }) },
	{ key = "L", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Right", 1 }) },
	{ key = "X", mods = "LEADER|SHIFT", action = act.CloseCurrentPane({ confirm = true }) },
	{ key = "Q", mods = "LEADER|SHIFT", action = act.CloseCurrentTab({ confirm = true }) },
	{ key = "q", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
	{ key = "x", mods = "LEADER", action = act.CloseCurrentTab({ confirm = true }) },
	{ key = "c", mods = "LEADER", action = act.SpawnTab("DefaultDomain") },
	{ key = "o", mods = "LEADER", action = act.ActivatePaneDirection("Next") },
	{ key = "f", mods = "LEADER", action = act.ToggleFullScreen },
	{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
	{ key = "p", mods = "LEADER", action = act.ActivateCommandPalette },

	-- Global bindings
	{ key = "\\", mods = "CTRL", action = act.ActivatePaneDirection("Prev") },
	{ key = "=", mods = "CTRL", action = act.IncreaseFontSize },
	{ key = "-", mods = "CTRL", action = act.DecreaseFontSize },
	{ key = "0", mods = "CTRL", action = act.ResetFontSize },
	{ key = "9", mods = "CTRL", action = act.EmitEvent("toggle-tabbar") },
	-- Alt+number to switch tabs
	{ key = "1", mods = "ALT", action = act.ActivateTab(0) },
	{ key = "2", mods = "ALT", action = act.ActivateTab(1) },
	{ key = "3", mods = "ALT", action = act.ActivateTab(2) },
	{ key = "4", mods = "ALT", action = act.ActivateTab(3) },
	{ key = "5", mods = "ALT", action = act.ActivateTab(4) },
	{ key = "6", mods = "ALT", action = act.ActivateTab(5) },
	{ key = "7", mods = "ALT", action = act.ActivateTab(6) },
	{ key = "8", mods = "ALT", action = act.ActivateTab(7) },
	{ key = "9", mods = "ALT", action = act.ActivateTab(8) },
	{ key = "0", mods = "ALT", action = act.ActivateTab(9) },
	{ key = "[", mods = "LEADER", action = act.ActivateCopyMode },
	{ key = "c", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard") },
	{ key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },
}
config.font = wezterm.font({ family = "JetBrainsMono NF" })
config.font_size = 14
config.automatically_reload_config = true
config.status_update_interval = 1000
config.scrollback_lines = 50000

config.colors = {
	-- The default text color
	foreground = "#abb2bf",
	-- The default background color
	background = "#1e222a",

	-- Overrides the cell background color when the current cell is occupied by the
	-- cursor and the cursor style is set to Block
	cursor_bg = "#abb2bf",
	-- Overrides the text color when the current cell is occupied by the cursor
	cursor_fg = "#1e222a",
	-- Specifies the border color of the cursor when the cursor style is set to Block,
	-- or the color of the vertical or horizontal bar when the cursor style is set to
	-- Bar or Underline.
	cursor_border = "#98c379",

	-- the foreground color of selected text
	selection_fg = "#abb2bf",
	-- the background color of selected text
	selection_bg = "#353b45",

	-- The color of the scrollbar "thumb"; the portion that represents the current viewport
	scrollbar_thumb = "#282c34",

	-- The color of the split lines between panes
	split = "#31353d",

	brights = {
		"#565c64", -- black
		"#e06c75", -- red
		"#98c379", -- green
		"#e5c07b", -- yellow
		"#61afef", -- blue
		"#c678dd", -- purple
		"#56b6c2", -- teal
		"#abb2bf", -- white
	},
	ansi = {
		"#545862", -- bright black
		"#DE8C92", -- bright red
		"#7eca9c", -- bright green
		"#EBCB8B", -- bright yellow
		"#81A1C1", -- bright blue
		"#de98fd", -- bright magenta
		"#a3b8ef", -- bright cyan
		"#c8ccd4", -- bright white
	},

	-- Arbitrary colors of the palette in the range from 16 to 255
	indexed = {
		[136] = "#d19a66", -- orange
		[137] = "#be5046", -- dark red
		[138] = "#ff75a0", -- pink
	},

	-- Since: 20220319-142410-0fcdea07
	-- When the IME, a dead key or a leader key are being processed and are effectively
	-- holding input pending the result of input composition, change the cursor
	-- to this color to give a visual cue about the compose state.
	compose_cursor = "#fca2aa",

	-- Colors for copy_mode and quick_select
	-- available since: 20220807-113146-c2fee766
	-- In copy_mode, the color of the active text is:
	-- 1. copy_mode_active_highlight_* if additional text was selected using the mouse
	-- 2. selection_* otherwise
	copy_mode_active_highlight_bg = { Color = "#373b43" },
	-- use `AnsiColor` to specify one of the ansi color palette values
	-- (index 0-15) using one of the names "Black", "Maroon", "Green",
	--  "Olive", "Navy", "Purple", "Teal", "Silver", "Grey", "Red", "Lime",
	-- "Yellow", "Blue", "Fuchsia", "Aqua" or "White".
	copy_mode_active_highlight_fg = { AnsiColor = "Black" },
	copy_mode_inactive_highlight_bg = { Color = "#98c379" },
	copy_mode_inactive_highlight_fg = { AnsiColor = "White" },

	quick_select_label_bg = { Color = "#61afef" },
	quick_select_label_fg = { Color = "#1e222a" },
	quick_select_match_bg = { Color = "#e06c75" },
	quick_select_match_fg = { Color = "#1e222a" },

	input_selector_label_bg = { Color = "#61afef" },
	input_selector_label_fg = { Color = "#1e222a" },
}

local wsl_domains = wezterm.default_wsl_domains()
if #wsl_domains > 0 then
	config.default_domain = wsl_domains[1].name
end

-- Smart Splits Configuration
smart_splits.apply_to_config(config, {
	direction_keys = { "h", "j", "k", "l" },
	modifiers = {
		move = "CTRL",
		resize = "META",
	},
	log_level = "info",
})

return config
