# Dotfiles

This directory stores the chezmoi source for local dotfiles. See [https://chezmoi.io](url) for more details.

## Bootstrap

1. Run `sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply cmll21`.

## Making changes

- Edit the files in this directory and run `chezmoi diff` to inspect pending
  updates.
- Run `chezmoi apply` after confirming the changes look correct.
- Use `chezmoi add <path>` to bring unmanaged files under chezmoi control.

## Packages

`run_once_install-packages.sh` ensures the following tools are installed across
supported platforms:

- eza
- zoxide
- fish
- fzf
- ripgrep
- bat
- neovim
- git
- fd
- jq
- curl
- wget
- tldr
- tree
- htop
- oh-my-posh
- lazygit
- gh
