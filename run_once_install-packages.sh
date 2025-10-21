#!/bin/bash
set -e

# ==============================================================================
# Dependency Lists
# Git is now in the common list. lazygit is only explicitly listed for macOS.
# ==============================================================================

COMMON_DEPS="eza zoxide fish fzf ripgrep bat neovim git"
MACOS_DEPS="$COMMON_DEPS lazygit"
LINUX_DEPS="$COMMON_DEPS"

# ==============================================================================
# Function: install_deps
# Installs dependencies for the given package manager, skipping already-installed ones.
# ==============================================================================

install_deps() {
  local package_manager=$1
  local packages=$2

  echo "🔧 Installing core dependencies via $package_manager..."

  case "$package_manager" in
    "brew")
      # Ensure Homebrew exists
      if ! command -v brew &>/dev/null; then
        echo "🍺 Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      fi

      # Install each missing package
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
      echo "❌ Error: Unsupported package manager '$package_manager'."
      exit 1
      ;;
  esac
}

# ==============================================================================
# Main Logic
# Detect OS and choose the appropriate dependency set and installer
# ==============================================================================

os=$(uname -s)

if [[ "$os" == "Darwin" ]]; then
  echo "🍏 Setting up macOS dependencies with Homebrew..."
  install_deps "brew" "$MACOS_DEPS"

elif [[ "$os" == "Linux" ]]; then
  echo "🐧 Setting up Linux dependencies (assuming apt-based distro)..."
  install_deps "apt" "$LINUX_DEPS"

elif grep -qi microsoft /proc/version 2>/dev/null; then
  echo "🪟 Detected WSL environment. Installing Linux dependencies..."
  install_deps "apt" "$LINUX_DEPS"

else
  echo "⚠️ Warning: Unsupported OS detected ($os). Skipping installation."
fi

echo "✅ Setup complete! Make sure your shell is set to fish and configured properly."
