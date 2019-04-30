# Without this, Ctrl+S would freeze the terminal
# https://unix.stackexchange.com/a/12108
stty -ixon

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

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git tmux wd z docker-compose)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Load hub
if type hub > /dev/null; then
  alias git=hub
fi

# Setting rg as the default source for fzf
export FZF_DEFAULT_COMMAND='rg --files'

# Apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Load FZF if exists
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Enabled zsh-autosuggestions
[ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Aliases
alias vim="nvim"

# Bindins
bindkey '^P' up-line-or-search
bindkey '^N' down-line-or-search

# disable zsh's autocd
unsetopt autocd

# Take and pull a screenshot from connect Android device
adb_screenshot() {
  SCREENSHOT_FILEPATH="/Users/$(whoami)/Desktop/screenshot_$(date +%d-%m-%Y:%H:%M:%S).png"

  # Record screenshot
  adb shell screencap -p /sdcard/screenshot.png

  # Pull screenshot from device
  adb pull /sdcard/screenshot.png

  # Clean screenshot from device
  adb shell rm /sdcard/screenshot.png

  # Move screenshot to Desktop and rename it to be unique
  mv screenshot.png $SCREENSHOT_FILEPATH

  # add image to clipboard
  osascript -e "set the clipboard to (read (POSIX file \"$SCREENSHOT_FILEPATH\") as JPEG picture)"
}

alias adbs=adb_screenshot
