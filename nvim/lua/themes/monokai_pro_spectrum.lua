---@type Base46Table
local M = {}

-- UI Colors
M.base_30 = {
  white = "#f7f1ff",
  black = "#222222",
  darker_black = "#131313",
  black2 = "#191919",
  one_bg = "#363537",
  one_bg2 = "#525053",
  one_bg3 = "#69676c",
  grey = "#8b888f",
  grey_fg = "#bab6c0",
  grey_fg2 = "#9494cc",
  light_grey = "#ccccdd",
  red = "#fc618d",
  baby_pink = "#fd9353",
  pink = "#fc618d",
  line = "#363537",
  green = "#7bd88f",
  vibrant_green = "#5ad4e6",
  nord_blue = "#5ad4e6",
  blue = "#5ad4e6",
  seablue = "#5ad4e6",
  yellow = "#fce566",
  sun = "#fce566",
  purple = "#948ae3",
  dark_purple = "#7a70bf",
  teal = "#5ad4e6",
  orange = "#fd9353",
  cyan = "#5ad4e6",
  statusline_bg = "#191919",
  lightbg = "#525053",
  pmenu_bg = "#7bd88f",
  folder_bg = "#5ad4e6",
}

-- Syntax Colors
M.base_16 = {
  base00 = "#222222",
  base01 = "#131313",
  base02 = "#191919",
  base03 = "#363537",
  base04 = "#525053",
  base05 = "#f7f1ff",
  base06 = "#bab6c0",
  base07 = "#f7f1ff",
  base08 = "#fc618d",
  base09 = "#fd9353",
  base0A = "#fce566",
  base0B = "#7bd88f",
  base0C = "#5ad4e6",
  base0D = "#948ae3",
  base0E = "#fc618d",
  base0F = "#69676c",
}

-- Default Highlight Groups + Treesitter
M.polish_hl = {
  defaults = {
    Comment = { fg = M.base_30.grey, italic = true },
    Normal = { bg = M.base_30.black, fg = M.base_30.white },
    Visual = { bg = M.base_30.dimmed5 },
    CursorLine = { bg = M.base_30.black2 },
    LineNr = { fg = M.base_30.grey },
    CursorLineNr = { fg = M.base_30.white },
    VertSplit = { fg = M.base_30.black2 },
    Folded = { fg = M.base_30.grey_fg, bg = M.base_30.black2 },
    Pmenu = { bg = M.base_30.black2 },
    PmenuSel = { bg = M.base_30.one_bg },
    SignColumn = { bg = M.base_30.black },
    Todo = { fg = M.base_30.black, bg = M.base_30.yellow },
    Error = { fg = M.base_30.red },
    Warning = { fg = M.base_30.orange },
    Info = { fg = M.base_30.cyan },
    Hint = { fg = M.base_30.purple },
  },

  treesitter = {
    ["@annotation"] = { fg = M.base_30.cyan, italic = true },
    ["@attribute"] = { fg = M.base_30.green },
    ["@boolean"] = { fg = M.base_30.red },
    ["@constant"] = { fg = M.base_30.red },
    ["@constructor"] = { fg = M.base_30.green },
    ["@field"] = { fg = M.base_30.red },
    ["@function"] = { fg = M.base_30.green },
    ["@keyword"] = { fg = M.base_30.red, italic = true },
    ["@number"] = { fg = M.base_30.red },
    ["@operator"] = { fg = M.base_30.red },
    ["@string"] = { fg = M.base_30.yellow },
    ["@tag"] = { fg = M.base_30.red },
    ["@type"] = { fg = M.base_30.cyan },
    ["@variable"] = { fg = M.base_30.white },
    ["@variable.parameter"] = { fg = M.base_30.blue, italic = true },

    -- Language specific
    ["@function.builtin.lua"] = { fg = M.base_30.green },
    ["@keyword.lua"] = { fg = M.base_30.red, italic = true },
    ["@markup.heading.markdown"] = { fg = M.base_30.green, bold = true },
    ["@punctuation.special.yaml"] = { fg = M.base_30.white },
    ["@string.yaml"] = { fg = M.base_30.yellow },
    ["@type.cpp"] = { fg = M.base_30.blue, italic = true },
    ["@comment.documentation.lua"] = { fg = M.base_30.cyan },

    -- Add remaining language rules from your config here
    ["@diff.plus"] = { fg = M.base_30.green },
    ["@diff.minus"] = { fg = M.base_30.red },
    ["@diff.delta"] = { fg = M.base_30.yellow },
    ["@markup.link.url.markdown_inline"] = { fg = M.base_30.green, underline = true },
    ["@text.uri.markdown_inline"] = { fg = M.base_30.green, underline = true },
    ["@lsp.type.class.dockerfile"] = { fg = M.base_30.cyan },
  },
}

M.type = "dark"

-- Apply theme overrides
M = require("base46").override_theme(M, "monokai-pro-spectrum")

return M
