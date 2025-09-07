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
config.font = wezterm.font({ family = "Lilex Nerd Font" })
config.font_size = 14

-- Window Decorations and Padding
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.window_content_alignment = {
	horizontal = "Center",
	vertical = "Center",
}

-- Tab Bar
config.enable_tab_bar = true -- Default state, can be toggled by leader + 9

-- Inactive Pane
config.inactive_pane_hsb = { saturation = 1, brightness = 1 }

-- Cursor
config.default_cursor_style = "BlinkingBlock" -- Explicitly set, common default
config.cursor_blink_rate = 500 -- Blink every 0.5 seconds (500ms)
config.animation_fps = 1
config.cursor_blink_ease_in = "Linear"
config.cursor_blink_ease_out = "Linear"

-- -----------------------------------------------------------------------------
-- Colors (Copied from your original configuration)
-- -----------------------------------------------------------------------------
config.color_scheme = "Everforest Dark (Gogh)"

-- -----------------------------------------------------------------------------
-- Keybindings
-- -----------------------------------------------------------------------------
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 3000 }
config.disable_default_key_bindings = true

config.keys = {
	-- Leader Key Passthrough
	{
		key = "a",
		mods = "LEADER|CTRL",
		action = act.SendKey({ key = "a", mods = "CTRL" }),
	},

	-- Configuration Reload
	{ key = "r", mods = "LEADER", action = act.ReloadConfiguration },

	-- Pane Management
	{
		key = "s",
		mods = "LEADER",
		action = act.SplitPane({ direction = "Down", size = { Percent = 50 } }),
	},
	{
		key = "v",
		mods = "LEADER",
		action = act.SplitPane({ direction = "Right", size = { Percent = 50 } }),
	},
	{
		key = "s",
		mods = "LEADER|SHIFT",
		action = act.SplitPane({ direction = "Up", size = { Percent = 50 } }),
	},
	{
		key = "v",
		mods = "LEADER|SHIFT",
		action = act.SplitPane({ direction = "Left", size = { Percent = 50 } }),
	},
	{
		key = "q", -- leader + q to close current pane (as requested, was already this)
		mods = "LEADER",
		action = act.CloseCurrentPane({ confirm = true }),
	},
	{ key = "o", mods = "LEADER", action = act.ActivatePaneDirection("Next") },
	{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },

	-- Pane Resizing (using LEADER|SHIFT as in original)
	{
		key = "H",
		mods = "LEADER|SHIFT",
		action = act.AdjustPaneSize({ "Left", 1 }),
	},
	{
		key = "J",
		mods = "LEADER|SHIFT",
		action = act.AdjustPaneSize({ "Down", 1 }),
	},
	{
		key = "K",
		mods = "LEADER|SHIFT",
		action = act.AdjustPaneSize({ "Up", 1 }),
	},
	{
		key = "L",
		mods = "LEADER|SHIFT",
		action = act.AdjustPaneSize({ "Right", 1 }),
	},
	{
		key = "n",
		mods = "LEADER",
		action = wezterm.action_callback(function(win, pane)
			-- Step 1: Make the current pane (left) a dummy
			win:perform_action(act.SendString("clear; cat >/dev/null\n"), pane)

			-- Step 2: Create the right dummy pane
			local right = win:perform_action(
				act.SplitPane({
					direction = "Right",
					size = { Percent = 75 },
					command = { args = { "sh", "-c", "clear; cat >/dev/null" } },
				}),
				pane
			)

			-- Step 3: Create the center pane (real shell)
			local center = win:perform_action(
				act.SplitPane({
					direction = "Left",
					size = { Percent = 66 }, -- 66% of 75% ≈ 50%
					command = nil, -- Default interactive shell
				}),
				pane
			)

			-- Step 4: Focus the center pane
			win:perform_action(act.ActivatePane(center), pane)
		end),
	},
	-- Tab Management
	{ key = "c", mods = "LEADER", action = act.SpawnTab("DefaultDomain") },
	{
		key = "q",
		mods = "LEADER",
		action = act.CloseCurrentPane({ confirm = false }),
	},

	-- Window / Application Management
	{
		key = "Q", -- leader + Q to close current window (quit if last window)
		mods = "LEADER",
		action = act.CloseCurrentTab({ confirm = false }),
	},
	{ key = "f", mods = "LEADER", action = act.ToggleFullScreen },

	-- Utility
	{ key = "p", mods = "LEADER", action = act.ActivateCommandPalette },
	{ key = "[", mods = "LEADER", action = act.ActivateCopyMode },

	-- Global Bindings (Non-Leader)
	{ key = "\\", mods = "CTRL", action = act.ActivatePaneDirection("Prev") },
	{ key = "=", mods = "CTRL", action = act.IncreaseFontSize },
	{ key = "-", mods = "CTRL", action = act.DecreaseFontSize },
	{ key = "0", mods = "CTRL", action = act.ResetFontSize },
	{ key = "9", mods = "CTRL", action = act.EmitEvent("toggle-tabbar") },

	-- Tab Switching (ALT + number)
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

	-- Copy/Paste
	{ key = "c", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard") },
	{ key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },
}

-- -----------------------------------------------------------------------------
-- Event Handlers
-- -----------------------------------------------------------------------------
wezterm.on("toggle-tabbar", function(window, _)
	local overrides = window:get_config_overrides() or {}

	-- Determine the baseline state of enable_tab_bar from the main config
	local current_config_value = true -- Default if not explicitly set
	if config.enable_tab_bar ~= nil then
		current_config_value = config.enable_tab_bar
	end

	-- Determine the current effective state (override or config)
	local current_effective_state
	if overrides.enable_tab_bar == nil then
		current_effective_state = current_config_value
	else
		current_effective_state = overrides.enable_tab_bar
	end

	-- Toggle the state
	overrides.enable_tab_bar = not current_effective_state
	window:set_config_overrides(overrides)
	return true
end)

-- -----------------------------------------------------------------------------
-- Plugin Configuration
-- -----------------------------------------------------------------------------
if smart_splits then
	smart_splits.apply_to_config(config, {
		-- Smart Splits options from your original config:
		direction_keys = { "h", "j", "k", "l" },
		modifiers = {
			move = "LEADER",
			resize = "META",
		},
		log_level = "info",
	})
end

-- -----------------------------------------------------------------------------
-- Finalize and Return Configuration
-- -----------------------------------------------------------------------------
return config
