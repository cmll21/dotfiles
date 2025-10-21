return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"mason-org/mason.nvim",
			build = ":MasonUpdate",
			config = true, -- use default Mason config
		},
		"mason-org/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		local mason_lspconfig = require("mason-lspconfig")
		local handlers = require("plugins.lsp.handlers")
		local custom_servers = require("plugins.lsp.servers")

		mason_lspconfig.setup({
			ensure_installed = {
				"lua_ls", -- Lua
				"ts_ls", -- TypeScript/JavaScript
				"pyright", -- Python
				"ocamllsp", -- OCaml
				"html", -- HTML
				"cssls", -- CSS
				"jsonls", -- JSON
				"yamlls", -- YAML
				"bashls", -- Bash
				"clangd", -- C/C++
			},
			automatic_installation = true,
			handlers = vim.tbl_extend("force", {
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = handlers.capabilities,
						on_attach = handlers.on_attach,
					})
				end,
			}, custom_servers),
		})
	end,
}
