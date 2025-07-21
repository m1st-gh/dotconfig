return {
  -- Formatting on save
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    opts = require "configs.conform",
  },
  -- LSP config
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
    lazy = false,
  },

  -- No Neck Pain
  {
    "shortcuts/no-neck-pain.nvim",
    cmd = { "NoNeckPain" },
    config = function()
      require("no-neck-pain").setup {
        width = 160,
      }
    end,
  },

  -- Quarto support (loads only for Quarto files)
  {
    "quarto-dev/quarto-nvim",
    ft = "quarto",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },

  -- Smart splits (always loaded)
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
  },

  -- Treesitter
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
        "json",
        "javascript",
        "typescript",
      },
    },
  },

  -- UFO folding
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      require("ufo").setup()
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    init = function()
      -- This runs before the plugin loads
      vim.defer_fn(function()
        if pcall(require, "telescope") then
          require("telescope").load_extension "ui-select"
        end
      end, 50)
    end,
  },
}
