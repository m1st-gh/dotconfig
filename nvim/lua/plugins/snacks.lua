return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			bigfile = { enabled = true },
			dashboard = {
				enabled = true,
				preset = {
					header = [[
                                            ▄▄                   
▀███▄   ▀███▀                ▀████▀   ▀███▀ ██                   
  ███▄    █                    ▀██     ▄█                        
  █ ███   █   ▄▄█▀██  ▄██▀██▄   ██▄   ▄█  ▀███ ▀████████▄█████▄  
  █  ▀██▄ █  ▄█▀   ████▀   ▀██   ██▄  █▀    ██   ██    ██    ██  
  █   ▀██▄█  ██▀▀▀▀▀▀██     ██   ▀██ █▀     ██   ██    ██    ██  
  █     ███  ██▄    ▄██▄   ▄██    ▄██▄      ██   ██    ██    ██  
▄███▄    ██   ▀█████▀ ▀█████▀      ██     ▄████▄████  ████  ████▄
                    ]],
				},
			},
			explorer = { enabled = true },
			indent = { enabled = true },
			input = { enabled = true },
			picker = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = true },
			-- scroll = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
			zen = { enabed = true },
			styles = {
				zen = {
					enter = true,
					fixbuf = true,
					minimal = false,
					width = 120,
					height = 0,
					backdrop = { transparent = false, blend = 99.99 },
					keys = { q = false },
					zindex = 40,
					wo = {
						winhighlight = "NormalFloat:Normal",
					},
					w = {
						snacks_main = true,
					},
				},
			},
		},
	},
}
