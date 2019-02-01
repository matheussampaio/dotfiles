export ZSH=$HOME/.oh-my-zsh
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM=xterm-256color-italic
export LANG=en_US.UTF-8
export ZSH_THEME="robbyrussell"

bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git tmux wd)

stty -ixon

# editing and reloading bash profile
alias ebash='vim ~/.zshrc'
alias rbash='source ~/.zshrc'
alias tmuxtemplate='~/git/dotfiles/tmux/bin/tmuxgo.sh'
alias ssh='TERM=xterm-256color ssh'

if type hub > /dev/null; then
  alias git=hub
fi

if [[ -a ~/.babun-docker/setup.sh ]]; then
  source ~/.babun-docker/setup.sh
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source $ZSH/oh-my-zsh.sh
