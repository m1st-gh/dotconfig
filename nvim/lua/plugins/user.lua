package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"

return {
  --------------------------------------------------------------------------------
  ------------------------------- Themes Setup ---------------------------------
  --------------------------------------------------------------------------------
  { "folke/tokyonight.nvim" },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
  },
  {
    "loctvl842/monokai-pro.nvim",
    priority = 1000,
  },

  --------------------------------------------------------------------------------
  ------------------------------- LSP and REPL Providers -----------------------
  --------------------------------------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    config = function()
      local function find_python_venv()
        local venv = vim.fn.finddir('.venv', '.;')
        if venv == '' then
          return ''
        end
        local python_path = venv .. '/bin/python3'
        print("Using Python interpreter: " .. python_path)
        return python_path
      end

      vim.g.python3_host_prog = find_python_venv()
    end,
  },
  {
    'willothy/wezterm.nvim',
    config = true
  },
  {
    "Vigemus/iron.nvim",
    config = function()
      local iron = require("iron.core")
      local view = require("iron.view")
      local common = require("iron.fts.common")

      iron.setup {
        config = {
          scratch_repl = true,
          repl_definition = {
            sh = { command = {"zsh"} },
            python = {
              command = { "python3" },
              format = common.bracketed_paste_python,
              block_deviders = { "# %%", "#%%" },
            }
          },
          repl_filetype = function(bufnr, ft)
            return ft
          end,
          repl_open_cmd = view.split.vertical.botright(50),
        },
        highlight = {
          italic = true
        },
        ignore_blank_lines = true,
      }

      -- Key Mappings for REPL Functions
      vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>', { desc = 'Focus REPL' })
      vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>', { desc = 'Hide REPL' })
    end
  },

  --------------------------------------------------------------------------------
  ----------------------------- Notebook and Jupyter Integration ---------------
  --------------------------------------------------------------------------------
  {
    "GCBallesteros/jupytext.nvim",
    config = function()
      require("jupytext").setup({
        style = "hydrogen",
        output_extension = "auto",
        force_ft = nil,
      })
    end,
  },

  {
    "GCBallesteros/NotebookNavigator.nvim",
    keys = {
      { "]h", function() require("notebook-navigator").move_cell "d" end, { desc = "Move cell down" } },
      { "[h", function() require("notebook-navigator").move_cell "u" end, { desc = "Move cell up" } },
      { "<localleader>X", "<cmd>lua require('notebook-navigator').run_cell()<cr>", { desc = "Run current cell" } },
      { "<localleader>x", "<cmd>lua require('notebook-navigator').run_and_move()<cr>", { desc = "Run and move to next cell" } },
    },
    dependencies = {
      "echasnovski/mini.comment",
      "hkupty/iron.nvim", -- REPL provider
      "anuvyklack/hydra.nvim",
    },
    event = "VeryLazy",
    config = function()
      local nn = require "notebook-navigator"
      nn.setup({ activate_hydra_keys = "<leader>h" })
    end,
  },

  --------------------------------------------------------------------------------
  ------------------------------ Quarto Integration Setup ----------------------
  --------------------------------------------------------------------------------
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "quarto", "markdown" },
    config = function()
      local quarto = require("quarto")
      quarto.setup({
        lspFeatures = {
          languages = { "r", "python", "rust" },
          chunks = "all",
          diagnostics = {
            enabled = true,
            triggers = { "BufWritePost" },
          },
          completion = { enabled = true },
        },
        keymap = {
          hover = "H",
          definition = "gd",
          rename = "<leader>rn",
          references = "gr",
          format = "<leader>gf",
        },
        codeRunner = {
          enabled = true,
        },
      })
    end,
  },

  --------------------------------------------------------------------------------
  ------------------------------- Utility Plugins Setup -----------------------
  --------------------------------------------------------------------------------
  {
    "ellisonleao/dotenv.nvim",
    config = function()
      require('dotenv').setup({
        enable_on_load = true,
        verbose = false,
      })
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = {
      pickers = {
        colorscheme = {
          enable_preview = true,
        },
      },
    },
  },

  {
    "hat0uma/csvview.nvim",
    opts = {
      parser = { comments = { "#", "//" } },
      keymaps = {
        textobject_field_inner = { "if", mode = { "o", "x" } },
        textobject_field_outer = { "af", mode = { "o", "x" } },
        jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
        jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
        jump_next_row = { "<Enter>", mode = { "n", "v" } },
        jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
      },
    },
    cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
  },

  --------------------------------------------------------------------------------
  ----------------------------- Molten and Image Providers --------------------
  --------------------------------------------------------------------------------
  -- Add configuration here as needed
  -- {
  --   "benlubas/molten-nvim",
  --   version = "^1.0.0",
  --   build = ":UpdateRemotePlugins",
  --   init = function()
  --     vim.g.molten_auto_open_output = false
  --     vim.g.molten_output_show_more = true
  --     vim.g.molten_image_provider = "wezterm"
  --     vim.g.molten_output_virt_lines = true
  --     vim.g.molten_split_direction = "right"
  --     vim.g.molten_split_size = 40
  --     vim.g.molten_virt_text_output = true
  --     vim.g.molten_use_border_highlights = true
  --     vim.g.molten_virt_lines_off_by_1 = true
  --     vim.g.molten_auto_image_popup = false
  --   end,
  --   config = function()
  --     vim.keymap.set("n", "<localleader>rk", ":MoltenRestart<CR>", { silent = true, desc = "Restart Molten" })
  --     vim.keymap.set("n", "<localleader>ri", ":MoltenInit<CR>", { silent = true, desc = "Initialize Molten" })
  --   end,
  -- },
}
