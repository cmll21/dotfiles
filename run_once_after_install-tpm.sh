#!/bin/bash
# Bootstrap Tmux Plugin Manager and install plugins from ~/.tmux.conf.
# Runs after install-packages so tmux and git are available.
export PATH="/opt/homebrew/bin:/usr/local/bin:/home/linuxbrew/.linuxbrew/bin:$PATH"

if ! command -v tmux >/dev/null 2>&1 || ! command -v git >/dev/null 2>&1; then
    echo "tmux or git not found; skipping TPM setup. Install them, then run ~/.tmux/plugins/tpm/bin/install_plugins"
    exit 0
fi

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing Tmux Plugin Manager..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo "Installing tmux plugins..."
~/.tmux/plugins/tpm/bin/install_plugins
