-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
-- install plugins

vim.o.relativenumber = true
vim.o.number = true

lvim.colorscheme = "monokai-pro-spectrum"
lvim.format_on_save.enabled = true
lvim.plugins = {
	"github/copilot.vim",
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "github/copilot.vim" },
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken",
		opts = {},
	},
	"loctvl842/monokai-pro.nvim",
	"ChristianChiarulli/swenv.nvim",
	"stevearc/dressing.nvim",
	"mfussenegger/nvim-dap-python",
	"nvim-neotest/neotest",
	"nvim-neotest/neotest-python",
	"nvim-neotest/nvim-nio",
}

-- Add TypeScript and Lua formatters
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ name = "black" }, -- Python formatter
	{ name = "stylua" }, -- Lua formatter
	{ name = "prettierd" }, -- TypeScript formatter}
})
-- Fixed plugin configuration with proper nesting
-- Treesitter configuration
lvim.builtin.treesitter.ensure_installed = {
	"python",
	"lua", -- Add Lua syntax highlighting
	"typescript", -- Add TypeScript syntax highlighting
}

-- Python debug adapter setup
local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
pcall(function()
	require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
end)

-- Testing configuration
require("neotest").setup({
	adapters = {
		require("neotest-python")({
			dap = {
				justMyCode = false,
				console = "integratedTerminal",
			},
			args = { "--log-level", "DEBUG", "--quiet" },
			runner = "pytest",
		}),
	},
})

-- Key mappings
lvim.builtin.which_key.mappings["dm"] = { "<cmd>lua require('neotest').run.run()<cr>", "Test Method" }
lvim.builtin.which_key.mappings["dM"] =
	{ "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", "Test Method DAP" }
lvim.builtin.which_key.mappings["df"] =
	{ "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>", "Test Class" }
lvim.builtin.which_key.mappings["dF"] =
	{ "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", "Test Class DAP" }
lvim.builtin.which_key.mappings["dS"] = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Test Summary" }

lvim.builtin.which_key.mappings["lD"] = {
	"<cmd>lua vim.diagnostic.enable(not vim.diagnostic.is_enabled())<cr>",
	"Toggle Diagnostics",
}

-- Python environment switching
lvim.builtin.which_key.mappings["C"] = {
	name = "Python",
	c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
}
-- Show all keybindings with Leader + Backspace
lvim.keys.normal_mode["<leader><BS>"] = "<cmd>WhichKey<cr>"
-- Next buffer with Tab
lvim.keys.normal_mode["<Tab>"] = "<cmd>bnext<cr>"

-- Previous buffer with Shift-Tab
lvim.keys.normal_mode["<S-Tab>"] = "<cmd>bprevious<cr>"
