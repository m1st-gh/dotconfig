require "nvchad.mappings"

-- add yours here
local chadrc = require "chadrc"
local map = vim.keymap.set
local nomap = vim.keymap.del
local original_statusline = nil
local original_laststatus = nil
local statusline_visible = true
local lsp_virtual_text_enabled = true

function _G.ToggleLocalSpellUS()
  -- Check the current local value of the 'spell' option
  if vim.opt_local.spell:get() then
    -- If spell is currently ON for this buffer, turn it OFF
    vim.opt_local.spell = false
    vim.notify("Local spell check OFF", vim.log.levels.INFO)
  else
    -- If spell is currently OFF, set language and turn it ON
    vim.opt_local.spelllang = "en_us" -- Set language to US English
    vim.opt_local.spell = true -- Enable spell checking locally
    vim.notify("Local spell check ON (en_us)", vim.log.levels.INFO)
  end
end

function ToggleLspVirtualText()
  lsp_virtual_text_enabled = not lsp_virtual_text_enabled
  vim.diagnostic.config { virtual_text = lsp_virtual_text_enabled }
  if lsp_virtual_text_enabled then
    vim.notify("LSP virtual text enabled", vim.log.levels.INFO)
  else
    vim.notify("LSP virtual text disabled", vim.log.levels.INFO)
  end
end

function ToggleStatusline()
  if statusline_visible then
    if not original_statusline then
      original_statusline = vim.o.statusline
    end
    if not original_laststatus then
      original_laststatus = vim.o.laststatus
    end
    vim.o.statusline = ""
    vim.o.laststatus = 0 -- Hide the statusline completely
    statusline_visible = false
  else
    if original_statusline then
      vim.o.statusline = original_statusline
    end
    if original_laststatus then
      vim.o.laststatus = original_laststatus
    end
    statusline_visible = true
  end
end

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<Leader>dl", "<cmd>lua require'dap'.step_into()<CR>", { desc = "Debugger step into" })
map("n", "<Leader>dj", "<cmd>lua require'dap'.step_over()<CR>", { desc = "Debugger step over" })
map("n", "<Leader>dk", "<cmd>lua require'dap'.step_out()<CR>", { desc = "Debugger step out" })
map("n", "<Leader>dc", "<cmd>lua require'dap'.continue()<CR>", { desc = "Debugger continue" })
map("n", "<Leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { desc = "Debugger toggle breakpoint" })
map(
  "n",
  "<Leader>dd",
  "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
  { desc = "Debugger set conditional breakpoint" }
)
map("n", "<Leader>uz", _G.ToggleLocalSpellUS, { desc = "Toggle local spell check (en_us)" })
map("n", "<leader>un", "<cmd>NoNeckPain<CR>", { desc = "Toggle Center" })
map("n", "<Leader>de", "<cmd>lua require'dap'.terminate()<CR>", { desc = "Debugger reset" })
map("n", "<Leader>dr", "<cmd>lua require'dap'.run_last()<CR>", { desc = "Debugger run last" })
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map("n", "<leader>us", ToggleStatusline, { desc = "Toggle statusline" })
map("n", "<leader>uv", ToggleLspVirtualText, { desc = "Toggle LSP virtual text" })
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  map("t", "<esc>", [[<C-\><C-n>]], opts)
  map("t", "jk", [[<C-\><C-n>]], opts)
  map("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  map("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  map("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  map("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
  map("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

-- smart-splits nvim mappings
local smart_splits = require "smart-splits"
local ufo = require "ufo"

map("n", "<A-h>", smart_splits.resize_left)
map("n", "<A-j>", smart_splits.resize_down)
map("n", "<A-k>", smart_splits.resize_up)
map("n", "<A-l>", smart_splits.resize_right)

map("n", "<C-h>", smart_splits.move_cursor_left)
map("n", "<C-j>", smart_splits.move_cursor_down)
map("n", "<C-k>", smart_splits.move_cursor_up)
map("n", "<C-l>", smart_splits.move_cursor_right)
map("n", "<C-\\>", smart_splits.move_cursor_previous)

map("n", "<leader><leader>h", smart_splits.swap_buf_left)
map("n", "<leader><leader>j", smart_splits.swap_buf_down)
map("n", "<leader><leader>k", smart_splits.swap_buf_up)
map("n", "<leader><leader>l", smart_splits.swap_buf_right)

map("n", "zR", ufo.openAllFolds, { desc = "Open all folds" })
map("n", "zM", ufo.closeAllFolds, { desc = "Close all folds" })
map("n", "zr", ufo.openFoldsExceptKinds, { desc = "Fold more" })
map("n", "zm", ufo.closeFoldsWith, { desc = "Fold less" })
