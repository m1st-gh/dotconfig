local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

-- Font configuration
config.font = wezterm.font("FiraCode Nerd Font Mono", { weight = "Medium" })
config.font_size = 12
-- Custom color palette from your theme
-- Define your custom palette

local palette = {
	dark1 = "#191919",
	dark2 = "#6e6e6e",
	background = "#222222",
	text = "#f7f1ff",
	accent1 = "#fc618d",
	accent2 = "#7bd88f",
	accent3 = "#fce566",
	accent4 = "#fd9353",
	accent5 = "#948ae3",
	accent6 = "#5ad4e6",
}

-- Helper function to darken a hex color by a given factor (default 0.7)

config.colors = {
	-- Default text and background colors
	foreground = palette.text,
	background = palette.background,

	-- Cursor colors
	cursor_bg = palette.text,
	cursor_fg = palette.background,
	cursor_border = palette.text,

	-- Selection colors
	selection_fg = palette.background,
	selection_bg = palette.accent1,

	ansi = {
		palette.dark1,
		palette.accent1,
		palette.accent2,
		palette.accent3,
		palette.accent4,
		palette.accent5,
		palette.accent6,
		palette.text,
	},

	brights = {
		palette.dark2, -- Bright Black
		palette.accent1, -- Bright Red (original accent1)
		palette.accent2, -- Bright Green (original accent2)
		palette.accent3, -- Bright Yellow (original accent3)
		palette.accent4, -- Bright Blue (original accent4)
		palette.accent5, -- Bright Magenta (original accent5)
		palette.accent6, -- Bright Cyan (original accent6)
		palette.text, -- Bright White
	},

	-- Arbitrary indexed colors (if needed)
	indexed = { [136] = palette.accent4 },

	-- Compose cursor color (when input composition is active)
	compose_cursor = palette.accent1,

	-- Colors for copy mode and quick select
	copy_mode_active_highlight_bg = { Color = palette.dark2 },
	copy_mode_active_highlight_fg = { AnsiColor = "Black" },
	copy_mode_inactive_highlight_bg = { Color = palette.accent2 },
	copy_mode_inactive_highlight_fg = { AnsiColor = "White" },

	quick_select_label_bg = { Color = palette.accent3 },
	quick_select_label_fg = { Color = palette.text },
	quick_select_match_bg = { Color = palette.accent4 },
	quick_select_match_fg = { Color = palette.text },
}

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- Tab bar configuration
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

return config
