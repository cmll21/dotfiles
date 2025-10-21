local handlers = require("plugins.lsp.handlers")

return {
  ["lua_ls"] = function()
    require("lspconfig").lua_ls.setup({
      capabilities = handlers.capabilities,
      on_attach = handlers.on_attach,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            checkThirdParty = false,
            library = vim.api.nvim_get_runtime_file("", true),
          },
        },
      },
    })
  end,

  ["jsonls"] = function()
    require("lspconfig").jsonls.setup({
      capabilities = handlers.capabilities,
      on_attach = handlers.on_attach,
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    })
  end,
}
