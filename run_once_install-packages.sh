#!/bin/bash

# ==============================================================================
# Dependency Lists
# Git is now in the common list. lazygit is only explicitly listed for macOS.
# ==============================================================================

# Core tools used on both OSs, now including git.
COMMON_DEPS="eza zoxide fish fzf ripgrep bat neovim git"

# macOS: Install common tools plus lazygit via Homebrew.
MACOS_DEPS="$COMMON_DEPS lazygit"

# Linux: Only install the common tools via apt.
LINUX_DEPS="$COMMON_DEPS"

# ==============================================================================
# Function to Install Dependencies
# This handles the package manager logic (brew or apt)
# ==============================================================================

install_deps() {
  local package_manager=$1
  local packages=$2

  echo "Installing core dependencies via $package_manager..."

  case "$package_manager" in
    "brew")
      # Check for Homebrew and install if missing
      if ! command -v brew &>/dev/null; then
        echo "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      fi
      # Install packages with Homebrew
      brew install $packages
      ;;
    "apt")
      # Update and install packages with apt
      sudo apt update
      sudo apt install -y $packages
      ;;
    *)
      echo "Error: Unsupported package manager '$package_manager'."
      exit 1
      ;;
  esac
}

# ==============================================================================
# Main Logic
# ==============================================================================

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "Setting up macOS dependencies with Homebrew..."
  # Uses MACOS_DEPS which includes 'git' and 'lazygit'
  install_deps "brew" "$MACOS_DEPS"

elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  echo "Setting up Linux dependencies (assuming Ubuntu/Debian for apt)..."
  # Uses LINUX_DEPS which includes 'git' but excludes 'lazygit'
  install_deps "apt" "$LINUX_DEPS"

else
  echo "Warning: Unsupported OS type: $OSTYPE. Skipping installation."
fi

echo "Setup complete! Please ensure your shell is set to fish and configured."
