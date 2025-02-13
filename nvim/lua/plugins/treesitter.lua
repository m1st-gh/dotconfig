-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
          "markdown",
          "markdown_inline",
          "python",
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighing = false,
        },    incremental_selection = {
      enable = true,  -- Enable incremental selection (for selecting code blocks)
      keymaps = {
        init_selection = "<CR>",  -- Key for starting selection
        node_incremental = "<TAB>",  -- Key for expanding selection
        node_decremental = "<S-TAB>",  -- Key for shrinking selection
        scope_incremental = "<C-Space>",  -- Key for expanding scope selection
      },
    },
  },
}

