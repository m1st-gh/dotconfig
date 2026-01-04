-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
vim.o.guicursor = "n-v-c:block-blinkon0,i-ci-ve:ver50-blinkwait200-blinkon400-blinkoff250"
