require "nvchad.options"

-- add yours here!

local o = vim.o
local cmd = vim.cmd

-- o.cursorlineopt ='both' -- to enable cursorline!
o.foldlevelstart = 99
o.relativenumber = true
cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"
