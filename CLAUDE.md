# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal dotfiles managed by [chezmoi](https://chezmoi.io). The source directory (`~/.local/share/chezmoi`) maps to `~` via chezmoi's naming conventions — `dot_` becomes `.`, `private_` sets restrictive permissions, and `.tmpl` files are rendered as Go templates before being written.

## Common chezmoi commands

```bash
chezmoi diff                  # preview what would change in ~
chezmoi apply                 # apply source → home
chezmoi add ~/.config/foo     # bring a new file under management
chezmoi edit ~/.config/foo    # edit the source file for a target
chezmoi doctor                # diagnose environment issues
```

## File naming conventions

| Source name | Target name | Meaning |
|-------------|-------------|---------|
| `dot_foo` | `.foo` | dotfile |
| `private_dot_config/` | `~/.config/` | chmod 600 |
| `foo.tmpl` | `foo` (rendered) | Go template, evaluated at apply time |
| `run_once_*.sh` | (not copied) | runs once on first `chezmoi apply` |

## Templates and data

`.chezmoi.toml.tmpl` prompts for one variable at `chezmoi init` time:

- **`has_sudo`** (bool) — stored in `~/.config/chezmoi/chezmoi.toml` after first init; on Linux, controls whether the install script bootstraps Homebrew (Linuxbrew) or just prints a manual package list. macOS always installs via Homebrew regardless of this value.

Template variables available in `.tmpl` files:
- `.chezmoi.os` — `"darwin"` or `"linux"`
- `.has_sudo` — from the prompt above

Files that use templates: `config.fish.tmpl`, `run_once_after_install-packages.sh.tmpl`.

Shell fallback files:
- `dot_bashrc` -> `~/.bashrc`
- `dot_zshrc` -> `~/.zshrc`
- `dot_shell_common` -> `~/.shell_common`, sourced by both bash and zsh for shared PATH, aliases, zoxide, starship, and Rust setup

## Install script behaviour

`run_once_after_install-packages.sh.tmpl` runs after all files are applied (so `fish_plugins` exists first) and once per machine. Both platforms use the same Homebrew package list (`BREW_DEPS`), so there's no per-OS package name skew (e.g. `fd` vs `fd-find`, `bat` vs `batcat`):
- **macOS** — installs Homebrew if missing (to `/opt/homebrew` or `/usr/local`), then installs all packages via `brew`
- **Linux, `has_sudo = true`** — installs Homebrew if missing (to `/home/linuxbrew/.linuxbrew`; the initial bootstrap needs sudo), then installs all packages via `brew`
- **Linux, `has_sudo = false`** — skips installation, prints the package list
- **all platforms** — installs [fisher](https://github.com/jorgebucaran/fisher) if missing, then runs `fisher update` to install the plugins listed in `fish_plugins`

## OS-specific config

Template files branch on `{{ if eq .chezmoi.os "darwin" }}` to pick the right Homebrew prefix: `/opt/homebrew` (or `/usr/local`) on macOS, `/home/linuxbrew/.linuxbrew` on Linux. `dot_shell_common` checks for both prefixes at runtime (`[ -d ... ]`) instead of using a template conditional, since it's not rendered by chezmoi. Tmux does not set `default-shell`; it uses tmux's default behavior based on the shell environment when the server starts.
