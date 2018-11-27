export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

plugins=(git tmux wd)

# utils
alias cpwd="pwd | tr -d '\n' | pbcopy"
alias git=hub

gmm() {
    git branch -f $1 $(current_branch) && git push origin $1
}

# http://superuser.com/questions/399296/256-color-support-for-vim-background-in-tmux/399326#399326
# File: ~/.bashrc (Ubuntu), ~/.bash_profile (Mac)
# for VIM and TMUC
if [ "$TERM" = "xterm" ]; then
  export TERM=xterm-256color
fi

alias tmux='tmux -2'  # for 256color
alias tmux='tmux -u'  # to get rid of unicode rendering problem

stty -ixon

# editing and reloading bash profile
alias ebash='vim ~/.zshrc'
alias rbash='source ~/.zshrc'
