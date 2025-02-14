-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {
  { "folke/tokyonight.nvim" },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "olimorris/onedarkpro.nvim", priority = 1000 },
  { "loctvl842/monokai-pro.nvim", priority = 1000 },

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
    config = function() require("dotenv").setup { enable_on_load = false, verbose = false } end,
  },
  {
    "Vigemus/iron.nvim",
    config = function()
      local iron = require "iron.core"
      local view = require "iron.view"
      local common = require "iron.fts.common"

      iron.setup {
        config = {
          scratch_repl = true,
          repl_definition = {
            sh = { command = { "zsh" } },
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
    end,
  },
  {
    "GCBallesteros/jupytext.nvim",
    config = function() require("jupytext").setup { style = "hydrogen", output_extension = "auto" } end,
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
    config = function()
      local nn = require "notebook-navigator"
      nn.setup { activate_hydra_keys = "<localleader>h" }
    end,
  },
  {
    "andweeb/presence.nvim",
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },
  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        " █████  ███████ ████████ ██████   ██████",
        "██   ██ ██         ██    ██   ██ ██    ██",
        "███████ ███████    ██    ██████  ██    ██",
        "██   ██      ██    ██    ██   ██ ██    ██",
        "██   ██ ███████    ██    ██   ██  ██████",
        " ",
        "    ███    ██ ██    ██ ██ ███    ███",
        "    ████   ██ ██    ██ ██ ████  ████",
        "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
        "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
        "    ██   ████   ████   ██ ██      ██",
      }
      return opts
    end,
  },
}
