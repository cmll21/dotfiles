return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  build = "make install_jsregexp",
  event = "InsertEnter",
  dependencies = {
    {
      "rafamadriz/friendly-snippets",
      event = "InsertEnter",
    },
  },
  config = function()
    local ls = require("luasnip")
    require("luasnip.loaders.from_vscode").lazy_load()
  end,
}
