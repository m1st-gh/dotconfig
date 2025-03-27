-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes

-- Disable cursorline globally
vim.o.cursorline = false -- Disable cursorline completely

-- Set cursor animation and blink delay (250ms)
vim.o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20" -- Normal mode block cursor, Insert mode vertical bar
vim.o.guicursor = vim.o.guicursor .. ",a:blinkon500" -- Set blink delay to 250ms
