# Path to oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Name of the theme to load.
export ZSH_THEME="robbyrussell"

# Language settings
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Set default editor to nvim
export EDITOR='nvim'

# Enabled true color support for terminals
export NVIM_TUI_ENABLE_TRUE_COLOR=1

# Set XDG values
export XDG_CONFIG_HOME="$HOME/.config"

# Disable brew analytics
export HOMEBREW_NO_ANALYTICS=1

# Setting rg as the default source for fzf
export FZF_DEFAULT_COMMAND='rg --files'

# Apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Add Android SDK to PATH
export PATH="$PATH:$HOME/Library/Android/sdk/tools/"

# Add Go libraries to PATH
export PATH="$PATH:$HOME/go/bin/"

# Add NPM libraries to PATH
export PATH="$PATH:$HOME/.npm/bin"
