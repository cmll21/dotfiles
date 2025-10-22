# Dotfiles

This repository contains my personal dotfile configuration, managed by [chezmoi](https://chezmoi.io).

<img width="1344" height="924" alt="Screenshot 2025-10-22 at 2 24 17 am" src="https://github.com/user-attachments/assets/bb437e18-fc50-4ba7-b37f-364e391c10c6" />

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

- [eza](https://github.com/eza-community/eza)
- [zoxide](https://github.com/ajeetdsouza/zoxide)
- [fish](https://github.com/fish-shell/fish-shell)
- [fzf](https://github.com/junegunn/fzf)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [bat](https://github.com/sharkdp/bat)
- [neovim](https://github.com/neovim/neovim)
- [git](https://github.com/git/git)
- [fd](https://github.com/sharkdp/fd)
- [jq](https://github.com/jqlang/jq)
- [curl](https://github.com/curl/curl)
- [wget](https://github.com/mirror/wget)
- [tldr](https://github.com/tldr-pages/tldr)
- [tree](https://github.com/Old-Man-Programmer/tree)
- [htop](https://github.com/htop-dev/htop)
- [oh-my-posh](https://github.com/JanDeDobbeleer/oh-my-posh)
- [lazygit](https://github.com/jesseduffield/lazygit)
- [gh](https://github.com/cli/cli)
