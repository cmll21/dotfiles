# Neovim Configuration

This is a personal Neovim configuration built with Lua and managed by [lazy.nvim](https://github.com/folke/lazy.nvim).

## Installation

### Prerequisites

- Neovim >= 0.11.0
- Git
- A C compiler (for Tree-sitter)
- [ripgrep](https://github.com/BurntSushi/ripgrep) (for Telescope live_grep)
- A [Nerd Font](https://www.nerdfonts.com/) (for icons)

### Steps

1. Backup existing configuration:

   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. Clone this configuration:

   ```bash
   git clone https://github.com/cmll21/nvim.git ~/.config/nvim
   ```

3. Start Neovim:

   ```bash
   nvim
   ```

4. Install plugins: Lazy.nvim will automatically install all plugins on first launch.

## Plugin List

#### Core Plugins

| Plugin                                                       | Description       |
| ------------------------------------------------------------ | ----------------- |
| [lazy.nvim](https://github.com/folke/lazy.nvim)              | Plugin manager    |
| [alpha-nvim](https://github.com/goolord/alpha-nvim)          | Start screen      |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Status line       |
| [which-key.nvim](https://github.com/folke/which-key.nvim)    | Key binding hints |

#### Editor Enhancement

| Plugin                                                                          | Description         |
| ------------------------------------------------------------------------------- | ------------------- |
| [snacks.nvim](https://github.com/folke/snacks.nvim)                             | Enhanced UI tools   |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)              | Fuzzy finder        |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)           | Syntax highlighting |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Indent guides       |
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)                   | Terminal management |

#### Language Support

| Plugin                                                     | Description       |
| ---------------------------------------------------------- | ----------------- |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP configuration |
| [mason.nvim](https://github.com/mason-org/mason.nvim)      | LSP installer     |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)            | Auto-completion   |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip)             | Snippet engine    |

#### Git Integration

| Plugin                                                      | Description     |
| ----------------------------------------------------------- | --------------- |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git decorations |
| [neogit](https://github.com/TimUntersberger/neogit)         | Git interface   |
| [diffview.nvim](https://github.com/sindrets/diffview.nvim)  | Git diff viewer |

#### AI

| Plugin                                                                | Description        |
| --------------------------------------------------------------------- | ------------------ |
| [copilot.lua](https://github.com/zbirenbaum/copilot.lua)              | GitHub Copilot     |
| [CopilotChat.nvim](https://github.com/CopilotC-Nvim/CopilotChat.nvim) | Copilot chat       |
| [auto-session](https://github.com/rmagatti/auto-session)              | Session management |
| [avante.nvim](https://github.com/yetone/avante.nvim)                  | AI Editing         |

#### Themes

| Theme                                                          | Description       |
| -------------------------------------------------------------- | ----------------- |
| [Catppuccin](https://github.com/catppuccin/nvim)               | Default theme     |
| [GitHub Theme](https://github.com/projekt0n/github-nvim-theme) | GitHub-inspired   |
| [VS Code Theme](https://github.com/Mofiqul/vscode.nvim)        | VS Code-inspired  |
| [OneDark](https://github.com/navarasu/onedark.nvim)            | Dark theme        |
| [Tokyo Night](https://github.com/folke/tokyonight.nvim)        | Tokyo-inspired    |
| [Kanagawa](https://github.com/rebelot/kanagawa.nvim)           | Japanese-inspired |

## Key Bindings

**Leader Key**: `Space`

#### General

| Key               | Action          |
| ----------------- | --------------- |
| `<leader>e`       | File Explorer   |
| `<leader><space>` | Smart find      |
| `<leader>fr`      | Recent files    |
| `<leader>/`       | Live grep       |
| `<leader>ff`      | Find files      |
| `<leader>,`       | Buffers         |
| `<leader>:`       | Cmd history     |
| `<leader>n`       | Notifications   |
| `<C-/>`           | Toggle terminal |
| `SPC SPC`         | Smart find      |
| `SPC ff`          | Find files      |
| `SPC fr`          | Recent files    |
| `SPC ,`           | Buffers         |
| `SPC /`           | Grep            |
| `SPC n`           | Notifications   |
| `SPC e`           | Explorer        |
| `e`               | New file        |

#### LSP

| Key          | Action               |
| ------------ | -------------------- |
| `gd`         | Go to definition     |
| `gr`         | Go to references     |
| `gi`         | Go to implementation |
| `K`          | Hover documentation  |
| `<leader>ca` | Code actions         |
| `<leader>rn` | Rename               |
| `<leader>f`  | Format               |
| `<M-l>`      | Accept suggestion    |
| `<M-w>`      | Accept word          |
| `<M-j>`      | Accept line          |
| `<M-n>`      | Next suggestion      |
| `<M-p>`      | Previous suggestion  |
| `<C-]>`      | Dismiss suggestion   |

#### Git

| Key         | Action      |
| ----------- | ----------- |
| `<leader>g` | Open Neogit |

## Configuration Structure

```
~/.config/nvim/
├── init.lua                 # Entry point
├── lazy-lock.json          # Plugin versions lock file
├── lua/
│   ├── config/
│   │   ├── keymaps.lua     # Key mappings
│   │   ├── lazy.lua        # Plugin manager setup
│   │   └── options.lua     # Neovim options
│   └── plugins/
│       ├── ...
│       ├── cmp.lua         # Completion
│       ├── colorscheme.lua # Color schemes
│       ├── copilot.lua     # AI assistance
│       ├── lspconfig.lua   # LSP configuration
│       ├── snacks.lua      # QoL tools
│       ├── treesitter.lua  # Syntax highlighting
│       └── ...             # Other plugins
```
