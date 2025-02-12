return {
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
  { "folke/tokyonight.nvim" },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
  }
}
