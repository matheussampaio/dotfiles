# Name of the theme to load.
export ZSH_THEME="robbyrussell"

# Language settings
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Enabled true color support for terminals
export NVIM_TUI_ENABLE_TRUE_COLOR=1

# Disable brew analytics
export HOMEBREW_NO_ANALYTICS=1

# Name of the theme to load.
export ZSH_THEME="robbyrussell"

export AUTO_TITLE_SCREENS="NO"

# Path to oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set XDG values
export XDG_CONFIG_HOME="$HOME/.config"

#  n (node manager packages) should install node versions here
export N_PREFIX=$HOME/.n

# Add Go libraries to PATH
if [ -d "$HOME/go/bin" ]; then
    export PATH="$PATH:$HOME/go/bin/"
fi

if [ -d "/usr/local/go/bin" ]; then
    export PATH="$PATH:/usr/local/go/bin"
fi

# Add NPM libraries to PATH
if [ -d "$HOME/.npm/bin" ]; then
    export PATH="$HOME/.npm/bin:$PATH"
fi

# Add N_PREFIX to PATH
export PATH="$N_PREFIX/bin:$PATH"

if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.rbenv/bin" ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
fi

if [ -d "$HOME/.npm-global/bin" ]; then
  export PATH="$HOME/.npm-global/bin:$PATH"
fi

if [ -d "$HOME/nvim/bin" ]; then
  export PATH="$HOME/nvim/bin/:$PATH"
fi

if [ -f "$HOME/.zshenv.local" ]; then
  source "$HOME/.zshenv.local"
fi
