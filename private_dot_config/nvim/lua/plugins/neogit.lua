return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
		"nvim-telescope/telescope.nvim",
	},
	keys = {
		{ "<leader>g", "<cmd>Neogit<cr>", desc = "Neogit" },
	},
	config = function()
		require("neogit").setup({
			kind = "floating",
			commit_editor = { kind = "floating" },
			commit_view = { kind = "floating" },
			log_view = { kind = "floating" },
			rebase_editor = { kind = "floating" },
			merge_editor = { kind = "floating" },
			preview_buffer = { kind = "floating" },
		})
	end,
}
