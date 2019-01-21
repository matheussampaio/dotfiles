# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

ZSH_THEME="robbyrussell"

bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git tmux wd)

# utils
alias cpwd="pwd | tr -d '\n' | pbcopy"

if type hub > /dev/null; then
  alias git=hub
fi

# editing and reloading bash profile
alias ebash='vim ~/.zshrc'
alias rbash='source ~/.zshrc'

if type tmux > /dev/null; then
  alias tmux='tmux -2'  # for 256color
  alias tmux='tmux -u'  # to get rid of unicode rendering problem
fi

gmm() {
    git branch -f $1 $(current_branch) && git push origin $1
}

# http://superuser.com/questions/399296/256-color-support-for-vim-background-in-tmux/399326#399326
# File: ~/.bashrc (Ubuntu), ~/.bash_profile (Mac)
# for VIM and TMUC
if [ "$TERM" = "xterm" ]; then
  export TERM=xterm-256color
fi


stty -ixon

git config --global alias.df "diff -- ':!package-lock.json' ':!yarn.lock'"
alias df="git diff -- ':!package-lock.json' ':!yarn.lock'"

source $ZSH/oh-my-zsh.sh

if [[ -a ~/.babun-docker/setup.sh ]]; then
  source ~/.babun-docker/setup.sh
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
