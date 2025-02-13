local wezterm = require 'wezterm'
local act = wezterm.action

local mod = {
  SUPER = 'ALT',
  SUPER_REV = 'ALT|CTRL'
}

-- Define the custom event
wezterm.on('tabs.toggle-tab-bar', function(window, _pane)
  local effective_config = window:effective_config()
  window:set_config_overrides({
    enable_tab_bar = not effective_config.enable_tab_bar,
  })
end)

return {
  -- Set font to FiraCode Nerd Font Mono
  font = wezterm.font("FiraCode Nerd Font Mono", { weight = "Medium" }),
  font_size = 12.0, -- Adjust as needed

  color_scheme = "Gruvbox Dark",

  colors = {
    cursor_fg = "white",
    cursor_bg = "white",
  },

  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
  default_prog = { 'pwsh.exe' },

  keys = {
    {
      key = '9',
      mods = mod.SUPER,
      action = act.EmitEvent('tabs.toggle-tab-bar'),
    },
  }
}

