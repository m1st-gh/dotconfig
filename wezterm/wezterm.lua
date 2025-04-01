local wezterm = require("wezterm")
local config = wezterm.config_builder()
config.color_scheme = 'One Dark (Gogh)'
-- Font configuration
config.font = wezterm.font("FiraCode Nerd Font Mono")
config.font_size = 16
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.colors = {
 cursor_fg = "black",
 cursor_bg = "white",
}

-- Tab bar configuration
config.hide_tab_bar_if_only_one_tab = true
config.default_domain = "WSL:RTSO-Distro"
-- config.window_content_alignment = {
--   horizontal = 'Center',
--   vertical = 'Center',
-- }
-- config.default_cursor_style = "BlinkingBlock"
-- config.cursor_blink_ease_in = "Constant"
-- config.cursor_blink_ease_out = "Constant"
-- config.cursor_blink_rate = 500
-- config.animation_fps = 240
-- config.use_resize_increments = true
-- config.enable_scroll_bar = true
return config
