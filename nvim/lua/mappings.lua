require "nvchad.mappings"

local map = vim.keymap.set
local nomap = vim.keymap.del
local helpers = require "mapping_helpers"

-- Make global functions accessible
_G.ToggleLocalSpellUS = helpers.toggle_local_spell_us
_G.ToggleCenterCursor = helpers.toggle_center_cursor
_G.ToggleTabufline = helpers.toggle_tabufline

-----------------------------------------------------------
-- Unmap specific keys
-----------------------------------------------------------
nomap("n", "<leader>v")
nomap("n", "<leader>h")
nomap("n", "<M-i>")
nomap("n", "<M-v>")

-----------------------------------------------------------
-- General mappings
-----------------------------------------------------------
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>", { desc = "Insert escape" })

-----------------------------------------------------------
-- UI Toggles (u prefix)
-----------------------------------------------------------
map("n", "<Leader>uz", helpers.toggle_local_spell_us, { desc = "Toggle local spell check en_us" })
map("n", "<leader>un", "<cmd>NoNeckPain<CR>", { desc = "Toggle center" })
map("n", "<leader>us", helpers.toggle_statusline, { desc = "Toggle statusline" })
map("n", "<leader>uv", helpers.toggle_lsp_virtual_text, { desc = "Toggle LSP virtual text" })
map("n", "<leader>ud", helpers.toggle_lsp_diagnostics, { desc = "Toggle LSP diagnostics" })
map("n", "<leader>uc", helpers.toggle_center_cursor, { desc = "Toggle center cursor" })
map("n", "<leader>ub", helpers.toggle_tabufline, { desc = "Toggle tabufline" })
map("n", "<leader>uZ", function()
  vim.cmd "NoNeckPain"
  helpers.toggle_statusline()
  helpers.toggle_tabufline()
end, { desc = "Toggle zen mode" })

-----------------------------------------------------------
-- Telescope
-----------------------------------------------------------
map("n", "<leader>fd", helpers.find_files_in_dir, { desc = "Telescope find files in a directory" })

-----------------------------------------------------------
-- Debugger mappings (DAP + Telescope)
-----------------------------------------------------------
-- Leader-based mappings
map("n", "<leader>ds", function()
  local dap = require "dap"
  if dap.session() then
    dap.continue()
  else
    require("telescope").extensions.dap.configurations()
  end
end, { desc = "Debugger start/continue" })

map("n", "<leader>df", function()
  require("telescope").extensions.dap.list_breakpoints()
end, { desc = "Debugger breakpoints" })

map("n", "<leader>dc", function()
  require("dap").clear_breakpoints()
  print "All breakpoints cleared"
end, { desc = "Debugger clear all breakpoints" })

map("n", "<Leader>dl", function()
  require("dap").step_into()
end, { desc = "Debugger step into" })

map("n", "<Leader>db", function()
  require("dap").toggle_breakpoint()
end, { desc = "Debugger toggle breakpoint" })

map("n", "<Leader>dd", function()
  require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")
end, { desc = "Debugger set conditional breakpoint" })

map("n", "<Leader>de", function()
  require("dap").terminate()
end, { desc = "Debugger stop" })

map("n", "<Leader>dr", function()
  require("dap").run_last()
end, { desc = "Debugger run last" })

-- F-key Debugger mappings
-- F-key Debugger mappings
map("n", "<F5>", function()
  local dap = require "dap"
  if dap.session() then
    dap.restart()
  else
    -- Load all configurations
    require("dap.ext.vscode").load_launchjs(nil, {})

    -- Sort configurations to put .vscode ones first
    for ft, configs in pairs(dap.configurations) do
      table.sort(configs, function(a, b)
        local a_is_vscode = a.__vscode or false
        local b_is_vscode = b.__vscode or false

        if a_is_vscode and not b_is_vscode then
          return true
        elseif not a_is_vscode and b_is_vscode then
          return false
        else
          return (a.name or "") < (b.name or "")
        end
      end)
    end

    require("telescope").extensions.dap.configurations()
  end
end, { desc = "Debugger start/restart" })

map("n", "<F6>", function()
  local dap = require "dap"
  if dap.session() then
    dap.continue()
  else
    print "No active debug session"
  end
end, { desc = "Debugger pause/continue" })

map("n", "<S-F5>", function()
  require("dap").terminate()
end, { desc = "Debugger stop" })

map("n", "<F7>", function()
  require("dap").toggle_breakpoint()
end, { desc = "Debugger toggle breakpoint" })

map("n", "<F8>", function()
  require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")
end, { desc = "Debugger set conditional breakpoint" })

map("n", "<C-F7>", function()
  require("dap").clear_breakpoints()
  print "All breakpoints cleared"
end, { desc = "Debugger clear all breakpoints" })

map("n", "<F9>", function()
  require("dap").step_over()
end, { desc = "Debugger step over" })

map("n", "<F10>", function()
  require("dap").step_into()
end, { desc = "Debugger step into" })

map("n", "<F11>", function()
  require("dap").step_out()
end, { desc = "Debugger step out" })

-----------------------------------------------------------
-- Smart-splits mappings
-----------------------------------------------------------
-- Resize
map("n", "<A-h>", function()
  require("smart-splits").resize_left()
end, { desc = "Smart-splits resize left" })
map("n", "<A-j>", function()
  require("smart-splits").resize_down()
end, { desc = "Smart-splits resize down" })
map("n", "<A-k>", function()
  require("smart-splits").resize_up()
end, { desc = "Smart-splits resize up" })
map("n", "<A-l>", function()
  require("smart-splits").resize_right()
end, { desc = "Smart-splits resize right" })

-- Movement
map("n", "<C-h>", function()
  require("smart-splits").move_cursor_left()
end, { desc = "Smart-splits move cursor left" })
map("n", "<C-j>", function()
  require("smart-splits").move_cursor_down()
end, { desc = "Smart-splits move cursor down" })
map("n", "<C-k>", function()
  require("smart-splits").move_cursor_up()
end, { desc = "Smart-splits move cursor up" })
map("n", "<C-l>", function()
  require("smart-splits").move_cursor_right()
end, { desc = "Smart-splits move cursor right" })
map("n", "<C-\\>", function()
  require("smart-splits").move_cursor_previous()
end, { desc = "Smart-splits move cursor previous" })

-- Swap buffers
map("n", "<leader><leader>h", function()
  require("smart-splits").swap_buf_left()
end, { desc = "Smart-splits swap buffer left" })
map("n", "<leader><leader>j", function()
  require("smart-splits").swap_buf_down()
end, { desc = "Smart-splits swap buffer down" })
map("n", "<leader><leader>k", function()
  require("smart-splits").swap_buf_up()
end, { desc = "Smart-splits swap buffer up" })
map("n", "<leader><leader>l", function()
  require("smart-splits").swap_buf_right()
end, { desc = "Smart-splits swap buffer right" })

-----------------------------------------------------------
-- UFO fold mappings
-----------------------------------------------------------
map("n", "zR", function()
  require("ufo").openAllFolds()
end, { desc = "Folds open all" })
map("n", "zM", function()
  require("ufo").closeAllFolds()
end, { desc = "Folds close all" })
map("n", "zr", function()
  require("ufo").openFoldsExceptKinds()
end, { desc = "Folds open except kinds" })
map("n", "zm", function()
  require("ufo").closeFoldsWith()
end, { desc = "Folds close with" })
