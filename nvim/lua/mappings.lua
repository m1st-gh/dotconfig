require "nvchad.mappings"

local map = vim.keymap.set

-- Toggle local spell check (en_us)
function _G.ToggleLocalSpellUS()
  if vim.opt_local.spell:get() then
    vim.opt_local.spell = false
    vim.notify("Local spell check OFF", vim.log.levels.INFO)
  else
    vim.opt_local.spelllang = "en_us"
    vim.opt_local.spell = true
    vim.notify("Local spell check ON (en_us)", vim.log.levels.INFO)
  end
end

-- Toggle LSP virtual text
local lsp_virtual_text_enabled = true
function ToggleLspVirtualText()
  lsp_virtual_text_enabled = not lsp_virtual_text_enabled
  vim.diagnostic.config { virtual_text = lsp_virtual_text_enabled }
  vim.notify(
    "LSP virtual text " .. (lsp_virtual_text_enabled and "enabled" or "disabled"),
    vim.log.levels.INFO
  )
end

-- Toggle statusline
local original_statusline, original_laststatus, statusline_visible = nil, nil, true
function ToggleStatusline()
  if statusline_visible then
    if not original_statusline then original_statusline = vim.o.statusline end
    if not original_laststatus then original_laststatus = vim.o.laststatus end
    vim.o.statusline = ""
    vim.o.laststatus = 0
    statusline_visible = false
  else
    if original_statusline then vim.o.statusline = original_statusline end
    if original_laststatus then vim.o.laststatus = original_laststatus end
    statusline_visible = true
  end
end

-- General mappings
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>", { desc = "Insert escape" })
map("n", "<Leader>uz", _G.ToggleLocalSpellUS, { desc = "Toggle local spell check en_us" })
map("n", "<leader>un", "<cmd>NoNeckPain<CR>", { desc = "Toggle center" })
map("n", "<leader>us", ToggleStatusline, { desc = "Toggle statusline" })
map("n", "<leader>uv", ToggleLspVirtualText, { desc = "Toggle LSP virtual text" })

-- Debugger mappings (DAP + Telescope)
map("n", "<leader>dc", function()
  require("telescope").extensions.dap.configurations()
end, { desc = "Debugger start/continue" })
map("n", "<leader>dB", function()
  require("telescope").extensions.dap.list_breakpoints()
end, { desc = "Debugger breakpoints" })
map("n", "<Leader>dl", function() require("dap").step_into() end, { desc = "Debugger step into" })
map("n", "<Leader>dj", function() require("dap").step_over() end, { desc = "Debugger step over" })
map("n", "<Leader>dk", function() require("dap").step_out() end, { desc = "Debugger step out" })
map("n", "<Leader>db", function() require("dap").toggle_breakpoint() end, { desc = "Debugger toggle breakpoint" })
map("n", "<Leader>dd", function()
  require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Debugger set conditional breakpoint" })
map("n", "<Leader>de", function() require("dap").terminate() end, { desc = "Debugger stop" })
map("n", "<Leader>dr", function() require("dap").run_last() end, { desc = "Debugger run last" })

-- F-key Debugger mappings
map("n", "<F5>", function()
  require("telescope").extensions.dap.configurations()
end, { desc = "Debugger start/continue" })
map("n", "<S-F5>", function() require("dap").terminate() end, { desc = "Debugger stop" })
map("n", "<F9>", function() require("dap").toggle_breakpoint() end, { desc = "Debugger toggle breakpoint" })
map("n", "<F10>", function() require("dap").step_over() end, { desc = "Debugger step over" })
map("n", "<F11>", function() require("dap").step_into() end, { desc = "Debugger step into" })

local function dap_restart()
  local dap = require("dap")
  if dap.restart then
    dap.restart()
  else
    dap.terminate()
    vim.defer_fn(function() dap.continue() end, 100)
  end
end
map("n", "<C-F5>", dap_restart, { desc = "Debugger restart" })
map("n", "<C-S-F5>", dap_restart, { desc = "Debugger restart" })

-- Smart-splits mappings
map("n", "<A-h>", function() require("smart-splits").resize_left() end, { desc = "Smart-splits resize left" })
map("n", "<A-j>", function() require("smart-splits").resize_down() end, { desc = "Smart-splits resize down" })
map("n", "<A-k>", function() require("smart-splits").resize_up() end, { desc = "Smart-splits resize up" })
map("n", "<A-l>", function() require("smart-splits").resize_right() end, { desc = "Smart-splits resize right" })

map("n", "<C-h>", function() require("smart-splits").move_cursor_left() end, { desc = "Smart-splits move cursor left" })
map("n", "<C-j>", function() require("smart-splits").move_cursor_down() end, { desc = "Smart-splits move cursor down" })
map("n", "<C-k>", function() require("smart-splits").move_cursor_up() end, { desc = "Smart-splits move cursor up" })
map("n", "<C-l>", function() require("smart-splits").move_cursor_right() end, { desc = "Smart-splits move cursor right" })
map("n", "<C-\\>", function() require("smart-splits").move_cursor_previous() end, { desc = "Smart-splits move cursor previous" })

map("n", "<leader><leader>h", function() require("smart-splits").swap_buf_left() end, { desc = "Smart-splits swap buffer left" })
map("n", "<leader><leader>j", function() require("smart-splits").swap_buf_down() end, { desc = "Smart-splits swap buffer down" })
map("n", "<leader><leader>k", function() require("smart-splits").swap_buf_up() end, { desc = "Smart-splits swap buffer up" })
map("n", "<leader><leader>l", function() require("smart-splits").swap_buf_right() end, { desc = "Smart-splits swap buffer right" })

-- UFO fold mappings
map("n", "zR", function() require("ufo").openAllFolds() end, { desc = "Folds open all" })
map("n", "zM", function() require("ufo").closeAllFolds() end, { desc = "Folds close all" })
map("n", "zr", function() require("ufo").openFoldsExceptKinds() end, { desc = "Folds open except kinds" })
map("n", "zm", function() require("ufo").closeFoldsWith() end, { desc = "Folds close with" })

-- Terminal keymaps (set per terminal buffer)
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  map("t", "<esc>", [[<C-\><C-n>]], vim.tbl_extend("force", opts, { desc = "Terminal normal mode" }))
  map("t", "jk", [[<C-\><C-n>]], vim.tbl_extend("force", opts, { desc = "Terminal normal mode jk" }))
  map("t", "<C-h>", [[<Cmd>wincmd h<CR>]], vim.tbl_extend("force", opts, { desc = "Terminal window left" }))
  map("t", "<C-j>", [[<Cmd>wincmd j<CR>]], vim.tbl_extend("force", opts, { desc = "Terminal window down" }))
  map("t", "<C-k>", [[<Cmd>wincmd k<CR>]], vim.tbl_extend("force", opts, { desc = "Terminal window up" }))
  map("t", "<C-l>", [[<Cmd>wincmd l<CR>]], vim.tbl_extend("force", opts, { desc = "Terminal window right" }))
  map("t", "<C-w>", [[<C-\><C-n><C-w>]], vim.tbl_extend("force", opts, { desc = "Terminal window command" }))
end
