return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  { "mrjones2014/smart-splits.nvim", lazy = false },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "python",
      },
    },
  },
  {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
    lazy = false, -- Keeping lazy=false as in your original snippet
    config = function()
      -- Call the plugin's setup function with your options
      -- The structure below matches the wiki's documentation
      require("no-neck-pain").setup {
        width = 160,
      }
    end,
  },
}
