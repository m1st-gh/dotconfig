local wezterm = require("wezterm")
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
local config = wezterm.config_builder()
local act = wezterm.action

-- Your existing WezTerm configuration (add it here)
wezterm.on("toggle-tabbar", function(window, _)
	local overrides = window:get_config_overrides() or {}

	if not first_tab_toggle_done then
		-- First press in this session: always hide
		overrides.enable_tab_bar = false
		First_tab_toggle_done = true -- Mark first press as done for this session
	else
		-- Subsequent presses: toggle normally
		overrides.enable_tab_bar = not overrides.enable_tab_bar
	end

	window:set_config_overrides(overrides)
end)

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.adjust_window_size_when_changing_font_size = false
config.window_close_confirmation = "NeverPrompt"
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
config.font = wezterm.font({ family = "FiraCode Nerd Font Mono" })
config.font_size = 14
config.color_scheme = "tokyonight"
config.automatically_reload_config = true
config.status_update_interval = 1000
config.scrollback_lines = 50000

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
