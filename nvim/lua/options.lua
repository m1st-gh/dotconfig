require "nvchad.options"

-- add yours here!

local o = vim.o
local cmd = vim.cmd
local g = vim.g

-- o.cursorlineopt ='both' -- to enable cursorline!
o.foldlevelstart = 99
o.relativenumber = true
o.guicursor = "n-v-c:block-blinkon250-blinkoff250,i:ver25-blinkon250-blinkoff250"
g.omni_sql_no_default_maps = 1
