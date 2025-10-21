return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = { "mason-org/mason.nvim" },
	cmd = { "MasonToolsInstall", "MasonToolsUpdate" },
	event = "VeryLazy",
	config = function()
		require("mason-tool-installer").setup({
			ensure_installed = {
				-- Formatters
				"prettierd",
				"stylua",
				"black",
				"clang-format",
				-- Linters
				"eslint_d",
				"flake8",
			},
			auto_update = false,
			run_on_start = true,
		})
	end,
}
