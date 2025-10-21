return {
	"hkupty/iron.nvim",
	config = function()
		local iron = require("iron.core")

		iron.setup({
			config = {
				repl_definition = {
					sh = { command = { "zsh" } },
					python = { command = { "ipython" } },
					ocaml = { command = { "ocaml" } },
				},
				repl_open_cmd = "vsplit",
			},
			keymaps = {
				send_motion = "<leader>sc",
				visual_send = "<leader>sc",
				send_file = "<leader>sf",
				send_line = "<leader>sl",
				send_until_cursor = "<leader>su",
				send_mark = "<leader>sm",
				mark_motion = "<leader>mc",
				mark_visual = "<leader>mc",
				remove_mark = "<leader>md",
				cr = "<leader>s<cr>",
				interrupt = "<leader>s<leader>",
				exit = "<leader>sq",
				clear = "<leader>cl",
			},
		})
	end,
}
