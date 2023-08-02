# Without this, Ctrl+S would freeze the terminal
# https://unix.stackexchange.com/a/12108
stty -ixon

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [ -d "/home/linuxbrew/.linuxbrew/share/zsh/site-functions" ]; then
    fpath=(/home/linuxbrew/.linuxbrew/share/zsh/site-functions $fpath)
fi

# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort access
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit && compinit -C
autoload -Uz bashcompinit && bashcompinit

# better and friendly vi(vim) mode plugin for ZSH
source $HOME/.zsh/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# help remembering those shell aliases and Git aliases you once defined
source $HOME/.zsh/alias-tips/alias-tips.plugin.zsh

# provides many aliases and a few useful functions
source $HOME/.zsh/ohmyzsh/lib/git.zsh
source $HOME/.zsh/ohmyzsh/plugins/git/git.plugin.zsh

# improves history command
source $HOME/.zsh/ohmyzsh/lib/history.zsh

# improves cd commands
source $HOME/.zsh/ohmyzsh/lib/directories.zsh

# system clipboard integration
source $HOME/.zsh/ohmyzsh/lib/clipboard.zsh

# provides many aliases and a few useful functions
source $HOME/.zsh/ohmyzsh/plugins/aliases/aliases.plugin.zsh

# (warp directory) lets you jump to custom directories in zsh
source $HOME/.zsh/ohmyzsh/plugins/wd/wd.plugin.zsh

# Powerlevel10k is a theme for Zsh.
source $HOME/.zsh/powerlevel10k/powerlevel10k.zsh-theme

# Suggests commands as you type based on history and completions.
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

# Provides completion support for awscli and a few utilities to manage AWS
# profiles and display them in the prompt.
source $HOME/.zsh/zsh-aws/zsh-aws.plugin.zsh

# Replace zsh's default completion selection menu with fzf!
source $HOME/.zsh/fzf-tab/fzf-tab.plugin.zsh

# cache the output of a binary initialization command, intended to help lower
# shell startup time.
source $HOME/.zsh/evalcache/evalcache.plugin.zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# turn off all beeps
unsetopt BEEP

# If a command is issued that canât be executed as a normal command, and the
# command is the name of a directory, perform the cd command to that directory.
# useful to call `..` and `...` to go up folders.
setopt AUTO_CD

# https://unix.stackexchange.com/questions/599641/why-do-i-have-duplicates-in-my-zsh-history
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

export HISTSIZE=1000000000
export SAVEHIST=1000000000

# export WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>'
export WORDCHARS='~!#$%^&*(){}[]<>?.+;-'

export FZF_DEFAULT_OPTS="--tiebreak end,length,index --color=$(cat $XDG_CONFIG_HOME/theme || echo 'light')"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude .bemol'
export FZF_CTRL_R_OPTS="--reverse --info hidden"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export EDITOR='nvim'
export MANPAGER='nvim +Man!'

function zvm_config() {
  ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
}

# https://github.com/jeffreytse/zsh-vi-mode/issues/19
# saves to clipboard on yank
function zvm_vi_yank() {
    zvm_yank
    printf %s "${CUTBUFFER}" | clipcopy
    zvm_exit_visual_mode
}

function my_zvm_init() {
    [ -f $XDG_CONFIG_HOME/fzf/fzf.zsh ] && source $XDG_CONFIG_HOME/fzf/fzf.zsh

    bindkey '^P' history-beginning-search-backward
    bindkey '^N' history-beginning-search-forward
    bindkey '^ ' autosuggest-accept
}

zvm_after_init_commands+=(my_zvm_init)

_nvim() {
    nvim --listen $XDG_DATA_HOME/nvim/nvim-$(date +%s).pipe "$@"
}

alias nvim=_nvim

if [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
    _evalcache /home/linuxbrew/.linuxbrew/bin/brew shellenv
fi

_evalcache zoxide init zsh

# if command -v rbenv > /dev/null 2>&1; then
#     eval "$(rbenv init - zsh)";
# fi
#
# if command -v pyenv > /dev/null 2>&1; then
#     eval "$(pyenv init -)";
# fi
#
# if command -v pyenv-virtualenv-init > /dev/null 2>&1; then
#     eval "$(pyenv virtualenv-init -)";
# fi
#
# if command -v plenv > /dev/null 2>&1; then
#     eval "$(plenv init -)"
# fi

# set default theme
if [ ! -f $XDG_CONFIG_HOME/theme ]; then
    echo 'dark' > $XDG_CONFIG_HOME/theme
fi

# Set theme
set-theme() {
    echo $1 > $XDG_CONFIG_HOME/theme

    if tmux has-session &> /dev/null; then
        tmux source-file $XDG_CONFIG_HOME/tmux/tmux-set-theme.conf
    fi

    for pipe in $(find $XDG_DATA_HOME/nvim -type s -name 'nvim-*.pipe'); do
        (\nvim --clean --server $pipe --remote-send "<ESC>:set background=$1<CR>" >/dev/null 2>&1 || true)
    done

    if [[ -n "${SSH_CONNECTION:-1}" ]] && [[ "$(uname -s)" = Darwin ]]; then
        python3 $XDG_CONFIG_HOME/iterm2/set-theme.py &
    fi
}

# Toggle between dark and light theme
toggle-theme () {
    if [ -f $XDG_CONFIG_HOME/theme ] && [ "$(cat $XDG_CONFIG_HOME/theme)" = 'light' ]; then
        set-theme dark
    else
        set-theme light
    fi
}

gbf() {
    TEMP_BRANCH_NAME=gbf-$(date +%s)
    CURRENT_BRANCH="$(git_current_branch)"

    git checkout --quiet -b $TEMP_BRANCH_NAME && \
        git branch -f $CURRENT_BRANCH origin/$CURRENT_BRANCH && \
        git checkout --quiet $CURRENT_BRANCH && \
        git branch --quiet -D $TEMP_BRANCH_NAME
}

ssh-copy-terminfo() {
    infocmp | ssh $1 "cat > /tmp/terminfo && tic -x /tmp/terminfo; rm /tmp/terminfo"
}

table-colors() {
    for i in {0..255}; do
        printf "\x1b[38;5;${i}mcolour${i}\x1b[0m\n"
    done
}

theme() {
    if [ ! -f "$XDG_CONFIG_HOME/theme" ]; then
        echo 'light' > "$XDG_CONFIG_HOME/theme"
    fi

    cat "$XDG_CONFIG_HOME/theme"
}

sync() {
    (set -x; rsync --archive --relative $1 $2)

    while inotifywait --quiet --event modify,create,delete,move --recursive $1; do
        (set -x; rsync --archive --relative $1 $2)
    done
}

timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

alias lg='lazygit'
alias bat='bat --theme=gruvbox-$(theme)'
alias ls='exa'
alias l='ls -lah'
alias t='tmux'
alias tn='t new-session -As'
alias graa='git rebase -i --autostash --autosquash origin/$(git_current_branch)'
alias gcr='git commit --fixup HEAD && graa'
alias gg='git global'
alias ggs='gg status -s'

if [ -f "$HOME/.p10k.zsh" ]; then
    source "$HOME/.p10k.zsh"
fi

if [ -f "$HOME/.zshrc.local" ]; then
    source "$HOME/.zshrc.local"
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

