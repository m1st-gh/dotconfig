return {
    {
    "Vigemus/iron.nvim",
      opts = function(_, conf)
      local iron = require "iron.core"
      local view = require "iron.view"
      local common = require "iron.fts.common"

      iron.setup {
        config = {
          scratch_repl = true,  -- Enables scratch REPLs that are discarded upon exit
          repl_definition = {
            sh = { command = { "bash" } },  -- Defines a REPL for shell scripts using zsh
            python = {
              command = { "python3" },  -- Defines a REPL for Python 3
              format = common.bracketed_paste_python,  -- Enables bracketed paste mode for Python
              block_deviders = { "# %%", "#%%" },  -- Sets block delimiters for Python code cells
            },
          },
          repl_open_cmd = view.split.vertical.botright(50),  -- Opens the REPL in a vertical split at the bottom right, occupying 50% of the window
        },
        highlight = { italic = true },  -- Sets REPL text to be italicized
        ignore_blank_lines = true,  -- Ignores blank lines when sending code to the REPL
      }
      return conf
    end,
  },
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- uncomment for format on save
    opts = function(_, _)
      return require("configs.conform")
    end,
  },
  {
    "hat0uma/csvview.nvim",
    opts = {
      parser = { comments = { "#", "//" } },
    },
    cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
  },
  { "willothy/wezterm.nvim", config = true },
  {
    "ellisonleao/dotenv.nvim",
    opts = function(_, conf)
      conf.enable_on_load = false
      conf.verbose = false
      return conf
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, conf)
      require("configs.lspconfig")
      return conf
    end,
  },
  {
    "quarto-dev/quarto-nvim",
    ft = { "quarto" },
    dev = false,
    opts = {},
    dependencies = {
      -- For language features in code cells:
      "jmbuhr/otter.nvim",
    },
  },
  {
    "GCBallesteros/jupytext.nvim",
    
    opts = function(_, conf)
      conf.style = "hydrogen"
      conf.output_extension = "auto"
      return conf
    end,
    lazy=false
  },
  {
    "jbyuki/nabla.nvim",
  },
  {
    "GCBallesteros/NotebookNavigator.nvim",
    keys = {
      { "]h", function() require("notebook-navigator").move_cell "d" end },
      { "[h", function() require("notebook-navigator").move_cell "u" end },
      { "<localleader>X", "<cmd>lua require('notebook-navigator').run_cell()<cr>", desc = "Run cell" },
      {
        "<localleader>x",
        "<cmd>lua require('notebook-navigator').run_and_move()<cr>",
        desc = "Run cell and move down",
      },
    },
    dependencies = {
      "echasnovski/mini.comment",
      "hkupty/iron.nvim",
      "anuvyklack/hydra.nvim",
    },
    event = "VeryLazy",
    opts = function(_, conf)
      conf.activate_hydra_keys = "<localleader>h"
      return conf
    end,
  },

  --[[
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "vim", "lua", "vimdoc", "html", "css" } },
  },
  ]]
}
