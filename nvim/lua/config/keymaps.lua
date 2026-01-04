-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- Zen mode state
local zen_mode = {
  active = false,
  orig_laststatus = vim.o.laststatus,
  orig_showtabline = vim.o.showtabline,
}

local toggle_zen = function()
  require("no-neck-pain").toggle()
  if zen_mode.active then
    -- Restore originals
    vim.opt.laststatus = zen_mode.orig_laststatus
    vim.opt.showtabline = zen_mode.orig_showtabline
    zen_mode.active = false
  else
    -- Store/update originals, then hide
    zen_mode.orig_laststatus = vim.o.laststatus
    zen_mode.orig_showtabline = vim.o.showtabline
    vim.opt.laststatus = 0
    vim.opt.showtabline = 0
    zen_mode.active = true
  end
end

map("n", "<leader>\\", "<C-W>v", { desc = "Split Window Right", remap = true })

map("n", "<A-h>", require("smart-splits").resize_left)
map("n", "<A-j>", require("smart-splits").resize_down)
map("n", "<A-k>", require("smart-splits").resize_up)
map("n", "<A-l>", require("smart-splits").resize_right)
map("n", "<C-h>", require("smart-splits").move_cursor_left)
map("n", "<C-j>", require("smart-splits").move_cursor_down)
map("n", "<C-k>", require("smart-splits").move_cursor_up)
map("n", "<C-l>", require("smart-splits").move_cursor_right)
map("n", "<C-\\>", require("smart-splits").move_cursor_previous)
map("n", "<leader>uv", function()
  vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
end, { desc = "Toggle diagnostic virtual text" })
map("n", "<leader>uC", function()
  require("no-neck-pain").toggle()
end, { desc = "Center screen" })

map("n", "<leader>uz", toggle_zen, { desc = "Toggle Zen mode" })

map("n", "<S-F9>", function()
  require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Breakpoint Condition" })
map("n", "<F9>", function()
  require("dap").toggle_breakpoint()
end, { desc = "Toggle Breakpoint" })
map("n", "<F5>", function()
  require("dap").continue()
end, { desc = "Run/Continue" })
map("n", "<F8>", function()
  require("dap").run_to_cursor()
end, { desc = "Run to Cursor" })
map("n", "<F11>", function()
  require("dap").step_into()
end, { desc = "Step Into" })
map("n", "<S-F5>", function()
  require("dap").run_last()
end, { desc = "Run Last" })
map("n", "<F12>", function()
  require("dap").step_out()
end, { desc = "Step Out" })
map("n", "<F10>", function()
  require("dap").step_over()
end, { desc = "Step Over" })
map("n", "<F6>", function()
  require("dap").pause()
end, { desc = "Pause" })
