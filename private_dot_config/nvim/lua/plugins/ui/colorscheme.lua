return { 
  {'projekt0n/github-nvim-theme', name = 'github-theme' },
  {'Mofiqul/vscode.nvim', name = 'vscode-theme' },
  {'navarasu/onedark.nvim', name = 'onedark-theme' },
  {'catppuccin/nvim', 
    name = 'catppuccin',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme('catppuccin')
    end,
  },
  {'folke/tokyonight.nvim', name = 'tokyonight' },
  { 'rebelot/kanagawa.nvim', name = 'kanagawa' },
}
