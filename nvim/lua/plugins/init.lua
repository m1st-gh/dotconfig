return {
  {
    "loctvl842/monokai-pro.nvim",
    lazy = false,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    cmd = { "CopilotChat" },
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken", -- Only on macOS or Linux
    opts = {},
  },
  {
    "github/copilot.vim",
    cmd = { "Copilot" },
    lazy = true,
  },
  {
    "ellisonleao/dotenv.nvim",
    lazy = true, -- Set to lazy load
  },
  {
    "Vigemus/iron.nvim",
    cmd = { "IronRepl" }, -- Only load when IronRepl is called
    opts = function(_, conf)
      local iron = require "iron.core"
      local view = require "iron.view"
      local common = require "iron.fts.common"

      iron.setup {
        config = {
          scratch_repl = true,
          repl_definition = {
            sh = { command = { "bash" } },
            python = {
              command = { "python3" },
              format = common.bracketed_paste_python,
              block_deviders = { "# %%", "#%%" },
            },
          },
          repl_open_cmd = view.split.vertical.botright(50),
        },
        highlight = { italic = true },
        ignore_blank_lines = true,
      }
      return conf
    end,
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- Trigger on buffer write
    opts = function(_, _)
      return require "configs.conform"
    end,
  },
  {
    "hat0uma/csvview.nvim",
    cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
    opts = {
      parser = { comments = { "#", "//" } },
    },
  },
  {
    "willothy/wezterm.nvim",
    config = true,
    lazy = true, -- Lazy load wezterm plugin
  },
  {
    "neovim/nvim-lspconfig",
    event = "LspAttach", -- Load when LSP is attached
    opts = function(_, conf)
      require "configs.lspconfig"
      return conf
    end,
  },
  {
    "quarto-dev/quarto-nvim",
    ft = { "quarto" }, -- Load when .qmd files are opened
    dependencies = {
      "jmbuhr/otter.nvim", -- Only load otter.nvim for quarto
    },
    opts = {},
  },
  {
    "GCBallesteros/jupytext.nvim",
    cmd = { "Jupytext" },
    opts = {
      style = "hydrogen",
      output_extension = "auto",
      force_ft = nil,
      custom_language_formatting = {},
    },
  },
  {
    "jbyuki/nabla.nvim",
    cmd = { "Nabla" }, -- Load only when invoking 'Nabla' command
  },
  {
    "GCBallesteros/NotebookNavigator.nvim",
    event = "VeryLazy", -- Load only on very lazy event
    keys = {
      {
        "]h",
        function()
          require("notebook-navigator").move_cell "d"
        end,
      },
      {
        "[h",
        function()
          require("notebook-navigator").move_cell "u"
        end,
      },
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
    opts = function(_, conf)
      conf.activate_hydra_keys = "<localleader>h"
      return conf
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "vim", "lua", "vimdoc", "html", "css", "python", "go" },
      highlight = {
        enable = true,
      },
    },
    event = "BufRead", -- Load treesitter only when a file is opened
  },
}
