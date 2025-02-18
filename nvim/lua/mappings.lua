require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Key mappings from NotebookNavigator.nvim
map("n", "]h", function()
  require("notebook-navigator").move_cell "d"
end, { desc = "Move cell down" })
map("n", "[h", function()
  require("notebook-navigator").move_cell "u"
end, { desc = "Move cell up" })
map("n", "<localleader>X", "<cmd>lua require('notebook-navigator').run_cell()<cr>", { desc = "Run cell" })
map(
  "n",
  "<localleader>x",
  "<cmd>lua require('notebook-navigator').run_and_move()<cr>",
  { desc = "Run cell and move down" }
)
map("n", "<localleader>c", "<cmd>CsvViewToggle", { desc = "toggle CSV view" })

-- Keybind to toggle between LSP diagnostic levels (Error, Warn, Info, Hint)
map("n", "<leader>dt", function()
  if vim.diagnostic.is_enabled() then
    vim.diagnostic.enable(false)
  else
    vim.diagnostic.enable()
  end
end, { desc = "toggle LSP diagnostics" })

-- Toggle cmp for the buffer
local cmp_enabled = true
map("n", "<leader>ct", function()
  cmp_enabled = not cmp_enabled
  require("cmp").setup.buffer { enabled = cmp_enabled }
  print("CMP " .. (cmp_enabled and "enabled" or "disabled"))
end, { desc = "toggle CMP completion" })
