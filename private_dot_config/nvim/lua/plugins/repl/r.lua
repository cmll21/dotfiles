return {
	"R-nvim/R.nvim",
	lazy = false,
	config = function()
		vim.g.R_app = "radian"
		vim.g.R_bracketed_paste = 1
		vim.g.R_assign = 0
		vim.g.R_hl_term = 0

		vim.g.R_auto_start = 1
		vim.g.R_close_term = 1

		vim.g.R_notmux_conf = {
			split_type = "vsplit",
			split_side = "right",
			split_size = 40,
		}

		-- vim.keymap.set("n", "<leader>sl", "<Plug>RSendLine", { silent = true })
		-- vim.keymap.set("v", "<leader>sc", "<Plug>RSendSelection", { silent = true })
	end,
}
