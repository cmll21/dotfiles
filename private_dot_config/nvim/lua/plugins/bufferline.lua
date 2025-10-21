return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons", "folke/snacks.nvim" },
	event = "VeryLazy", -- optional: defer loading
	config = function()
		require("bufferline").setup({
			options = {
				mode = "buffers",
				numbers = "none",
				diagnostics = "nvim_lsp",
				show_buffer_close_icons = true,
				show_close_icon = false,
				always_show_bufferline = false, -- only when >1 buffer
				-- separator_style = "slant",
				indicator = {
					style = "none",
				},
				style_preset = {
					require("bufferline").style_preset.minimal,
					require("bufferline").style_preset.no_italic,
				},
				hover = {
					enabled = true,
					delay = 200,
					reveal = { "close" },
				},
				offsets = {
					{
						filteype = "snacks_picker_list",
						padding = 1,
					},
				},
				numbers = function(opts)
					return string.format("%s", opts.ordinal)
				end,
			},
		})

		for i = 1, 9 do
			vim.keymap.set("n", "<leader>" .. i, "<Cmd>BufferLineGoToBuffer " .. i .. "<CR>", {
				desc = "Go to buffer " .. i,
				silent = true,
			})
		end

		-- <leader>0 → last buffer
		vim.keymap.set("n", "<leader>0", "<Cmd>BufferLineGoToBuffer -1<CR>", {
			desc = "Go to last buffer",
			silent = true,
		})
	end,
}
