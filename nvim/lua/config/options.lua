-- lua/options.lua
-- Basic Neovim options

local o = vim.opt

-- Tabs / indentation
o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4
o.smartindent = true
-- Line numbers
o.number = true
o.relativenumber = true

-- Mouse
o.mouse = "a"

-- System clipboard
-- o.clipboard = "unnamedplus"

-- Hide tildes (~) on empty lines at the end of buffer
o.fillchars = { eob = " " }

-- Some additional sensible defaults
o.termguicolors = true
o.wrap = false
o.signcolumn = "yes"
o.cursorline = true
o.incsearch = true
o.ignorecase = true
o.smartcase = true
o.completeopt = { "menuone", "noselect" }
o.backup = false
o.writebackup = false
o.swapfile = false
o.undofile = true
o.virtualedit = "block"
o.ruler = false -- Disable the default ruler
o.winborder = "rounded"
