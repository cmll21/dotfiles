# Enable Vi mode
fish_vi_key_bindings
functions -e fish_mode_prompt

# Setup PATH
set -x PATH /opt/homebrew/bin /usr/local/bin /usr/bin /bin /usr/sbin /sbin $HOME/.local/bin

# Set default editor
set -x EDITOR nvim

# C headers and libs
set -x CPATH /opt/homebrew/include $CPATH
set -x LIBRARY_PATH /opt/homebrew/lib $LIBRARY_PATH

# NVM — Use Fish-native plugin instead of Bash scripts
# Install with: fisher install jorgebucaran/nvm.fish
set -x NVM_DIR $HOME/.nvm

# Opam init (silently)
if test -r "$HOME/.opam/opam-init/init.fish"
    source "$HOME/.opam/opam-init/init.fish" > /dev/null 2>&1
end

# Oh My Posh (only outside Apple Terminal)
if test "$TERM_PROGRAM" != "Apple_Terminal"
    oh-my-posh init fish --config "$HOME/.config/oh-my-posh/zen.omp.toml" | source
end

# Zoxide directory jumper
zoxide init fish | source

# Set compilers
set -Ux CC /opt/homebrew/bin/gcc-15
set -Ux CXX /opt/homebrew/bin/g++-15

# Aliases
alias cd='z'
alias ls='eza --icons --group-directories-first --color=always'
alias ll='eza -lh --icons --group-directories-first --git'
alias la='eza -lha --icons --group-directories-first --git'
alias lt='eza --tree --level=2 --icons'
alias grep='rg'
alias cat='bat'
