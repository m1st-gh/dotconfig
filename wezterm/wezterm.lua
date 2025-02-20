local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()

-- Leader key configuration
config.leader = { key = "a", mods = "CTRL" }

-- Key bindings with WSL clone behavior
config.keys = {
    { key = "c", mods = "LEADER", action = act.SpawnTab({ domain = "CurrentPaneDomain" }) },
    { key = "-", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "_", mods = "LEADER|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "Tab", mods = "LEADER", action = act.ActivateTabRelative(1) },
    { key = "Tab", mods = "LEADER|SHIFT", action = act.ActivateTabRelative(-1) },
}

-- Font configuration
config.font = wezterm.font("FiraCode Nerd Font Mono")
config.font_size = 12

-- Cursor configuration
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 500
config.animation_fps=1
config.force_reverse_video_cursor = true
config.colors = {
    cursor_bg = "#ffffff",
}

-- WSL-specific configuration
config.default_domain = "WSL:openSUSE-Tumbleweed"  -- Replace with your WSL distro name if different
config.launch_menu = {}  -- Clear any existing launch menu items

-- Window configuration
config.term = "xterm-256color"
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
