# Dotfiles managed by chezmoi

This directory stores the chezmoi source for local dotfiles. Files obey
chezmoi's naming rules (for example `dot_` for home-directory files and
`private_` for secrets).

## Bootstrap

1. Install chezmoi following the instructions at https://www.chezmoi.io/.
2. Run `chezmoi init --apply $GITHUB_USERNAME` to clone this repo and deploy the
   dotfiles in one step.

## Making changes

- Edit the files in this directory and run `chezmoi diff` to inspect pending
  updates.
- Run `chezmoi apply` after confirming the changes look correct.
- Use `chezmoi add <path>` to bring unmanaged files under chezmoi control.
