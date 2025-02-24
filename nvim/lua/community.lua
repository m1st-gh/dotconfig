-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" }, -- import/override with your plugins folder
  { import = "astrocommunity.pack.typescript" }, -- import/override with your plugins folder
  { import = "astrocommunity.pack.python" }, -- import/override with your plugins folder
  { import = "astrocommunity.editing-support.copilotchat-nvim" },
  { import = "astrocommunity.colorscheme.monokai-pro-nvim" },
  { import = "astrocommunity.completion.copilot-cmp" },
  {
    "loctvl842/monokai-pro.nvim",
    config = function()
      require("monokai-pro").setup {
        filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
        devicons = true,
        styles = {
          comment = { italic = true },
          keyword = { italic = true }, -- any other keyword
          type = { italic = true }, -- (preferred) int, long, char, etc
          storageclass = { italic = true }, -- static, register, volatile, etc
          structure = { italic = true }, -- struct, union, enum, etc
          parameter = { italic = true }, -- parameter pass in function
          annotation = { italic = true },
          tag_attribute = { italic = true }, -- attribute of tag in reactjs
        },
      }
    end,
  },
}
