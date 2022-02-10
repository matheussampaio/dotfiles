# Without this, Ctrl+S would freeze the terminal
# https://unix.stackexchange.com/a/12108
stty -ixon

# Disable marking untracked files under VCS as dirty. This makes repository
# status check for large repositories much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Plugins can be found in $HOME/.oh-my-zsh/plugins/*
plugins=(git wd z zsh-vi-mode)

# turn off all beeps
unsetopt BEEP

# disable zsh's autocd
unsetopt autocd

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

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Set XDG values
export XDG_CONFIG_HOME="$HOME/.config"

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

export N_PREFIX=$HOME/.n

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

# Setting rg as the default source for fzf
if command -v rg > /dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='rg --files'
fi

# Apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

function my_zvm_init() {
  [ -f $XDG_CONFIG_HOME/fzf/fzf.zsh ] && source $XDG_CONFIG_HOME/fzf/fzf.zsh

  bindkey '^P' history-beginning-search-backward
  bindkey '^N' history-beginning-search-forward
}

zvm_after_init_commands+=(my_zvm_init)

if command -v nvim > /dev/null 2>&1; then
  export EDITOR='nvim'

  alias vim='nvim'
fi

if command -v rbenv > /dev/null 2>&1; then
  eval "$(rbenv init - zsh)"
fi

if command -v pyenv > /dev/null 2>&1; then
  eval "$(pyenv init -)";
fi

if command -v pyenv-virtualenv-init > /dev/null 2>&1; then
  eval "$(pyenv virtualenv-init -)";
fi

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export PROMPT='%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ ) %{$fg[cyan]%}%c%{$reset_color%} %{$fg[yellow]%}[SSH]%{$reset_color%} $(git_prompt_info)'
fi

gbf() {
  TEMP_BRANCH_NAME=gbf-$(date +%F)
  CURRENT_BRANCH="$(git_current_branch)"

  git checkout --quiet -b $TEMP_BRANCH_NAME && \
    git branch -f $CURRENT_BRANCH origin/$CURRENT_BRANCH && \
    git checkout --quiet $CURRENT_BRANCH && \
    git branch --quiet -D $TEMP_BRANCH_NAME
}
