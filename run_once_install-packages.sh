#!/bin/bash
set -e

COMMON_DEPS="eza zoxide fish fzf ripgrep bat neovim git fd jq curl wget tldr tree htop oh-my-posh lazygit gh"

install_deps() {
  local package_manager=$1
  local packages=$2

  echo "🔧 Installing core dependencies via $package_manager..."

  case "$package_manager" in
    "brew")
      if ! command -v brew &>/dev/null; then
        echo "🍺 Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      fi

      for pkg in $packages; do
        if ! brew list "$pkg" &>/dev/null; then
          echo "→ Installing $pkg"
          brew install "$pkg"
        else
          echo "✓ $pkg already installed"
        fi
      done
      ;;
    "apt")
      echo "📦 Updating package lists..."
      sudo apt update -y

      for pkg in $packages; do
        if ! dpkg -s "$pkg" &>/dev/null; then
          echo "→ Installing $pkg"
          sudo apt install -y "$pkg"
        else
          echo "✓ $pkg already installed"
        fi
      done
      ;;
    *)
      echo "❌ Unsupported package manager: $package_manager"
      exit 1
      ;;
  esac
}

os=$(uname -s)

if [[ "$os" == "Darwin" ]]; then
  echo "🍏 Setting up macOS dependencies..."
  install_deps "brew" "$COMMON_DEPS"
elif [[ "$os" == "Linux" ]]; then
  echo "🐧 Setting up Linux dependencies..."
  install_deps "apt" "$COMMON_DEPS"
elif grep -qi microsoft /proc/version 2>/dev/null; then
  echo "🪟 Detected WSL environment..."
  install_deps "apt" "$COMMON_DEPS"
else
  echo "⚠️ Unsupported OS detected: $os"
fi

echo "✅ Setup complete! Make sure your shell is set to fish and configured properly."
