return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		spec = {
			{ "<leader>e", group = "explorer" },
			{ "<leader>f", group = "file" },
			{ "<leader>g", group = "git" },
			{ "<leader>l", icon = "", group = "lsp" },
			{ "<leader>s", group = "search" },
			{ "<leader>u", group = "ui" },
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
