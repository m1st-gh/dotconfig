local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

config.font = wezterm.font("FiraCode Nerd Font Mono", { weight = "Medium" })
config.font_size = 12

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

config.colors = {

	foreground = palette.text,
	background = palette.background,
	cursor_bg = palette.text,
	cursor_border = palette.text,
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
		palette.dark2,
		palette.accent1,
		palette.accent2,
		palette.accent3,
		palette.accent4,
		palette.accent5,
		palette.accent6,
		palette.text,
	},

	compose_cursor = palette.accent1,

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

config.default_domain = "WSL:openSUSE-Tumbleweed"
config.default_prog = { "wsl.exe" }
-- Tab bar configuration
config.hide_tab_bar_if_only_one_tab = true

return config
