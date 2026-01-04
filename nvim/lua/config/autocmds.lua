-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
-- Create a new autocommand group for this feature
local convert_dos_to_unix_group = vim.api.nvim_create_augroup("convert_dos_to_unix", { clear = true })

-- Autocommand to convert DOS line endings to Unix on file open
vim.api.nvim_create_autocmd("BufReadPost", {
  group = convert_dos_to_unix_group,
  desc = "Convert DOS line endings to Unix if detected",
  callback = function()
    -- Check if the buffer's file format is DOS (CRLF line endings)
    if vim.bo.fileformat == "dos" then
      -- Remove trailing \r (carriage returns) to convert CRLF to LF
      -- This assumes the file is a text file; use caution for binary files
      vim.cmd([[silent! %s/\r$//e]])
      -- Set the file format to Unix for future saves
      vim.bo.fileformat = "unix"
    end
  end,
})
