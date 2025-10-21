return {
  "kevinhwang91/nvim-ufo",
  dependencies = "kevinhwang91/promise-async",
  event = "VeryLazy",
  config = function()
    -- vim.o.foldcolumn = "1"       -- show fold column
    vim.o.foldlevel = 99         -- start unfolded
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

    require("ufo").setup({
      provider_selector = function(filetype)
        return { "treesitter", "indent" } -- fallback to indent if treesitter fails
      end,
    })
  end,
}
