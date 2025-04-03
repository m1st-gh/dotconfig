require "nvchad.options"

-- add yours here!

local o = vim.o
local cmd = vim.cmd
local notifyd = vim.notify
-- o.cursorlineopt ='both' -- to enable cursorline!
o.relativenumber = true
-- Add a timer function for clearing command line
vim.api.nvim_create_autocmd("CmdlineLeave", {
  group = vim.api.nvim_create_augroup("ClearCmdline", { clear = true }), -- Create a group for cleanup
  callback = function()
    -- Start a timer that clears the command line after 5000ms (5 seconds)
    vim.fn.timer_start(5000, function()
      -- Use 'echon' to clear the command line
      vim.cmd "echon ''" -- Clears the command line
    end)
  end,
})
cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"
