# Path to oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Name of the theme to load.
export ZSH_THEME="robbyrussell"

# Language settings
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export N_PREFIX=$HOME/.n

# Set default editor to nvim
if command -v nvim > /dev/null 2>&1; then
  export EDITOR='nvim'
fi

# if command -v most > /dev/null 2>&1; then
#   export PAGER="most"
# fi

# Enabled true color support for terminals
export NVIM_TUI_ENABLE_TRUE_COLOR=1

# Set XDG values
export XDG_CONFIG_HOME="$HOME/.config"

# Disable brew analytics
export HOMEBREW_NO_ANALYTICS=1

# Setting rg as the default source for fzf
if command -v rg > /dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='rg --files'
fi

# Apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Add Android SDK to PATH
export PATH="$PATH:$HOME/Library/Android/sdk/tools/"

# Add Go libraries to PATH
export PATH="$PATH:$HOME/go/bin/"
export PATH="$PATH:/usr/local/go/bin"

# Add NPM libraries to PATH
export PATH="$PATH:$HOME/.npm/bin"

# Add N_PREFIX to PATH
export PATH="$N_PREFIX/bin:$PATH"

# Add PHP libraries to PATH
export PATH="$PATH:/usr/local/opt/php@7.3/bin"
export PATH="$PATH:/usr/local/opt/php@7.3/sbin"
