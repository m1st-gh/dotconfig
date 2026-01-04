-- ~/.wezterm.lua

-- Core Wezterm module
local wezterm = require("wezterm")
local act = wezterm.action

-- Configuration builder
local config = wezterm.config_builder()

-- Plugins
-- -----------------------------------------------------------------------------
-- Attempt to load the smart-splits plugin
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")

-- -----------------------------------------------------------------------------
-- Basic Configuration
-- -----------------------------------------------------------------------------
config.automatically_reload_config = true
config.adjust_window_size_when_changing_font_size = false
config.scrollback_lines = 50000
config.status_update_interval = 1000 -- milliseconds

-- Default domain (e.g., for WSL)
local wsl_domains = wezterm.default_wsl_domains()

if #wsl_domains > 0 then
	config.default_domain = wsl_domains[1].name
end
config.default_prog = { "pwsh.exe", "-NoLogo" }

-- -----------------------------------------------------------------------------
-- Appearance
-- -----------------------------------------------------------------------------
-- Font
config.font = wezterm.font({ family = "FiraCode Nerd Font Ret" })
config.font_size = 12

-- Window Decorations and Padding
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.window_content_alignment = {
	horizontal = "Center",
	vertical = "Center",
}
config.max_fps = 120

-- Tab Bar
config.enable_tab_bar = true

-- Inactive Pane
config.inactive_pane_hsb = { saturation = 1, brightness = 1 }

-- Cursor
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 500
config.animation_fps = 1
config.cursor_blink_ease_in = "Linear"
config.cursor_blink_ease_out = "Linear"
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"

-- -----------------------------------------------------------------------------
-- Colors (Copied from your original configuration)
-- -----------------------------------------------------------------------------
config.color_scheme = "OneDarker"
config.freetype_load_target = "Normal"

-- -----------------------------------------------------------------------------
-- Keybindings
-- -----------------------------------------------------------------------------
-- config.disable_default_key_bindings = true

config.keys = {
	{ key = "F11", mods = "ALT", action = act.ToggleFullScreen },

	{ key = "9", mods = "CTRL", action = act.EmitEvent("toggle-tabbar") },

	-- Copy/Paste
	{ key = "c", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard") },
	{ key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },
	{ key = "/", mods = "LEADER", action = act.ActivateCopyMode },
}

-- -----------------------------------------------------------------------------
-- Event Handlers
-- -----------------------------------------------------------------------------
wezterm.on("toggle-tabbar", function(window, _)
	local overrides = window:get_config_overrides() or {}

	local current_config_value = true
	if config.enable_tab_bar ~= nil then
		current_config_value = config.enable_tab_bar
	end

	local current_effective_state
	if overrides.enable_tab_bar == nil then
		current_effective_state = current_config_value
	else
		current_effective_state = overrides.enable_tab_bar
	end

	overrides.enable_tab_bar = not current_effective_state
	window:set_config_overrides(overrides)
	return true
end)
return config
