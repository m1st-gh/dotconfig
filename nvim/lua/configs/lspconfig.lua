-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

local servers = { "html", "cssls", "pyright" }
local nvlsp = require "nvchad.configs.lspconfig"

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

lspconfig.ts_ls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    javascript = {
      preferences = {
        importModuleSpecifier = "relative",
      },
    },
    typescript = {
      preferences = {
        importModuleSpecifier = "relative",
      },
    },
  },
  init_options = {
    hostInfo = "neovim",
    maxTsServerMemory = 4096,
  },
}
