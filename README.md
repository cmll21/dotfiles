# Dotfiles

This directory stores the chezmoi source for local dotfiles. Files obey
chezmoi's naming rules (for example `dot_` for home-directory files and
`private_` for secrets).

## Bootstrap

1. Run `sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply cmll21`.

## Making changes

- Edit the files in this directory and run `chezmoi diff` to inspect pending
  updates.
- Run `chezmoi apply` after confirming the changes look correct.
- Use `chezmoi add <path>` to bring unmanaged files under chezmoi control.
