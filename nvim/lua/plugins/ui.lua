return {
	{
		"tummetott/reticle.nvim",
		event = "VeryLazy", -- optionally lazy load the plugin
		opts = {
			-- add options here if you wish to override the default settings
		},
		-- Lua
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = {
			max_lines = 5,
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	{
		"kylechui/nvim-surround",
		opts = {},
	},
	{
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		opts = {
			-- add any custom options here
		},
	},
	{ "nvim-tree/nvim-web-devicons", opts = {} },

	{ "shortcuts/no-neck-pain.nvim", version = "*", opts = { width = 200 } },
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = {
				style_preset = 2,
				offsets = {
					{
						filetype = "neo-tree",
						text = "Neo-tree",
						highlight = "Directory",
						text_align = "left",
					},
					{
						filetype = "snacks_layout_box",
					},
				},
			},
		},
	},
}
