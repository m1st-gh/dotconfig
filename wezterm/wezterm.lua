local wezterm = require("wezterm")
local config = wezterm.config_builder()
config.color_scheme = "One Dark (Gogh)"
-- Font configuration
config.font = wezterm.font("FiraCode Nerd Font Mono")
config.font_size = 16
config.window_padding = {
	left = 4,
	right = 4,
	top = 4,
	bottom = 4,
}
config.colors = {
	cursor_fg = "black",
	cursor_bg = "white",
}

-- Tab bar configuration
config.hide_tab_bar_if_only_one_tab = true

-- Automatic WSL Domain Detection
local wsl_domains = wezterm.default_wsl_domains()
if #wsl_domains > 0 then
	config.default_domain = wsl_domains[1].name -- Use the first detected WSL domain
end

return config
