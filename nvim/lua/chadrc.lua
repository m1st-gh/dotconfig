-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "tokyonight",

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
  integrations = {
    "dap",
  },
}

M.nvdash = { load_on_startup = true }
M.ui = {
  tabufline = {
    enabled = true,
    lazyload = false,
  },
     cheatsheet = {
     theme = "grid", -- simple/grid
     excluded_groups = {}
   },
}

M.mason = { pkgs = {"debugpy"}}

return M
