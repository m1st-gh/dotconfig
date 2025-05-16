local M = {}

-- Debugger restart function
function M.dap_restart()
  local dap = require "dap"
  if dap.restart then
    dap.restart()
  else
    dap.terminate()
    vim.defer_fn(function()
      dap.continue()
    end, 100)
  end
end

-- Toggle local spell check (en_us)
function M.toggle_local_spell_us()
  if vim.opt_local.spell:get() then
    vim.opt_local.spell = false
    vim.notify("Local spell check OFF", vim.log.levels.INFO)
  else
    vim.opt_local.spelllang = "en_us"
    vim.opt_local.spell = true
    vim.notify("Local spell check ON (en_us)", vim.log.levels.INFO)
  end
end

-- LSP virtual text state
local lsp_virtual_text_enabled = true
function M.toggle_lsp_virtual_text()
  lsp_virtual_text_enabled = not lsp_virtual_text_enabled
  vim.diagnostic.config { virtual_text = lsp_virtual_text_enabled }
  vim.notify("LSP virtual text " .. (lsp_virtual_text_enabled and "enabled" or "disabled"), vim.log.levels.INFO)
end

-- Statusline state
local original_statusline, original_laststatus, statusline_visible = nil, nil, true
function M.toggle_statusline()
  if statusline_visible then
    if not original_statusline then
      original_statusline = vim.o.statusline
    end
    if not original_laststatus then
      original_laststatus = vim.o.laststatus
    end
    vim.o.statusline = ""
    vim.o.laststatus = 0
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

-- LSP diagnostics state
local diagnostics_enabled = true
function M.toggle_lsp_diagnostics()
  diagnostics_enabled = not diagnostics_enabled
  vim.diagnostic.config {
    virtual_text = diagnostics_enabled,
    signs = diagnostics_enabled,
    underline = diagnostics_enabled,
    update_in_insert = diagnostics_enabled,
  }
  vim.notify("LSP diagnostics " .. (diagnostics_enabled and "enabled" or "disabled"), vim.log.levels.INFO)
end

-- Center cursor state
local original_scrolloff = vim.o.scrolloff
local original_sidescrolloff = vim.o.sidescrolloff
local center_cursor_enabled = false
function M.toggle_center_cursor()
  if center_cursor_enabled then
    -- restore
    vim.o.scrolloff = original_scrolloff
    vim.o.sidescrolloff = original_sidescrolloff
    vim.notify("Center cursor OFF", vim.log.levels.INFO)
    center_cursor_enabled = false
  else
    -- save current (in case they changed it elsewhere)
    original_scrolloff = vim.o.scrolloff
    original_sidescrolloff = vim.o.sidescrolloff
    vim.o.scrolloff = 999
    vim.o.sidescrolloff = 999
    vim.notify("Center cursor ON", vim.log.levels.INFO)
    center_cursor_enabled = true
  end
end

-- Tabufline state
local default_tabline = vim.o.tabline
local default_showtabline = vim.o.showtabline
function M.toggle_tabufline()
  local static = M.toggle_tabufline_state or { enabled = true }
  M.toggle_tabufline_state = static

  if static.enabled then
    vim.o.showtabline = 0
    vim.notify("Tabufline hidden", vim.log.levels.INFO)
  else
    vim.o.showtabline = default_showtabline
    vim.o.tabline = default_tabline
    vim.notify("Tabufline shown", vim.log.levels.INFO)
  end
  static.enabled = not static.enabled
  vim.cmd "redrawtabline"
end

-- Find files in directory
function M.find_files_in_dir()
  vim.ui.input({ prompt = "Directory to search: ", completion = "dir" }, function(input)
    if input and #input > 0 then
      require("telescope.builtin").find_files { cwd = input }
    end
  end)
end

return M
