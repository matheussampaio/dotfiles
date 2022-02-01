# Without this, Ctrl+S would freeze the terminal
# https://unix.stackexchange.com/a/12108
stty -ixon

# Disable marking untracked files under VCS as dirty. This makes repository
# status check for large repositories much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git wd z zsh-vi-mode)

# turn off all beeps
unsetopt BEEP

# disable zsh's autocd
unsetopt autocd

# Path to oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

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

# Setting rg as the default source for fzf
if command -v rg > /dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='rg --files'
fi

# Apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export XDG_CONFIG_HOME="$HOME/.config"

export AUTO_TITLE_SCREENS="NO"

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

function my_zvm_init() {
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

  bindkey '^P' history-beginning-search-backward
  bindkey '^N' history-beginning-search-forward
}

zvm_after_init_commands+=(my_zvm_init)

if [ -d "$HOME/nvim/bin" ]; then
  export PATH=$HOME/nvim/bin/:$PATH
fi

# Set default editor to nvim
if command -v nvim > /dev/null 2>&1; then
  export EDITOR='nvim'
  alias vim='nvim'
fi

if [ -d "$HOME/.npm-global/bin" ]; then
  export PATH=$HOME/.npm-global/bin:$PATH
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

if command -v pyenv > /dev/null 2>&1; then
  eval "$(pyenv init -)";
fi

if command -v pyenv-virtualenv-init > /dev/null 2>&1; then
  eval "$(pyenv virtualenv-init -)";
fi

export JAVA_TOOLS_OPTIONS="-Dlog4j2.formatMsgNoLookups=true"
