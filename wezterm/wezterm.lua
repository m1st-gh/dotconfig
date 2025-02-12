local wezterm = require 'wezterm'

return {
  -- Set font to FiraCode Nerd Font Mono
  font = wezterm.font("FiraCode Nerd Font Mono", {weight = "Medium"}),
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
  enable_tab_bar = false,

}
