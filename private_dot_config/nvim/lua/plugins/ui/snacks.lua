return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			bigfile = { enabled = true },
			explorer = { enabled = true },
			indent = { enabled = true },
			input = { enabled = true },
			picker = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = true },
			scroll = { enabled = false },
			statuscolumn = { enabled = true },
			words = { enabled = true },
			terminal = { enabled = true },
			zen = { enabled = true },
			bufdelete = { enabled = true },
			scratch = { enabled = true },
			styles = {
				notification = { timeout = 3000 },
			},
			picker = {
				layouts = {
					default = {
						layout = {
							box = "horizontal",
							width = 0.9,
							min_width = 80,
							height = 0.9,
							{
								box = "vertical",
								border = "rounded",
								title = "{title} {live} {flags}",
								{ win = "input", height = 1, border = "bottom" },
								{ win = "list", border = "none" },
							},
							{ win = "preview", title = "{preview}", border = "rounded", width = 0.55 },
						},
					},
				},
			},
		},
		keys = {
			{
				"<leader><space>",
				function()
					require("snacks").picker.smart()
				end,
				desc = "Smart find files",
			},
			{
				"<leader>,",
				function()
					require("snacks").picker.buffers()
				end,
				desc = "Buffers",
			},
			{
				"<leader>/",
				function()
					require("snacks").picker.grep()
				end,
				desc = "Grep",
			},
			{
				"<leader>:",
				function()
					require("snacks").picker.command_history()
				end,
				desc = "Cmd history",
			},
			{
				"<leader>n",
				function()
					require("snacks").picker.notifications()
				end,
				desc = "Notifications",
			},
			{
				"<leader>e",
				function()
					require("snacks").explorer()
				end,
				desc = "Explorer",
			},
			{
				"<leader>ff",
				function()
					require("snacks").picker.files()
				end,
				desc = "Find files",
			},
			{
				"<leader>fg",
				function()
					require("snacks").picker.git_files()
				end,
				desc = "Find git files",
			},
			{
				"<leader>fr",
				function()
					require("snacks").picker.recent_files()
				end,
				desc = "Recent files",
			},
			{
				"<C-/>",
				function()
					require("snacks").terminal()
				end,
				desc = "Toggle terminal",
			},
		},
	},
}
