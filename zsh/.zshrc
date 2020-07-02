# Without this, Ctrl+S would freeze the terminal
# https://unix.stackexchange.com/a/12108
stty -ixon

# Disable marking untracked files under VCS as dirty. This makes repository
# status check for large repositories much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Plugins can be found in ~/.oh-my-zsh/plugins/*
plugins=(git wd z)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# turn off all beeps
unsetopt BEEP

# Bindins
# bindkey '^P' up-line-or-search
# bindkey '^N' down-line-or-search

bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

# disable zsh's autocd
unsetopt autocd

alias adbs=adb_screenshot
alias vims='nvim_session'
alias vim='nvim'
alias python='python3'

# Take and pull a screenshot from connected Android device
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

  # Add image to clipboard
  osascript -e "set the clipboard to (read (POSIX file \"$SCREENSHOT_FILEPATH\") as JPEG picture)"
}

# Force current branch to point to origin/$current_branch
gbf() {
  TEMP_BRANCH_NAME=gbf-$(date +%F)
  CURRENT_BRANCH="$(git_current_branch)"

  git checkout --quiet -b $TEMP_BRANCH_NAME && \
  git branch -f $CURRENT_BRANCH origin/$CURRENT_BRANCH && \
  git checkout --quiet $CURRENT_BRANCH && \
  git branch --quiet -D $TEMP_BRANCH_NAME
}

# Open vim and create/load a session
nvim_session() {
  SESSIONS_FOLDER=~/.local/share/nvim/sessions
  SESSION_FILE=${SESSIONS_FOLDER}/$1.vim

  echo "$SESSION_FILE"

  if [[ $# == 1 ]]; then
    if [[  -f $SESSION_FILE ]]; then
      nvim -S $SESSION_FILE
    else
      nvim -c ":Obsession $SESSION_FILE"
    fi
  else
    SESSION_FILE=${SESSIONS_FOLDER}/$(ls ${SESSIONS_FOLDER} | fzf)

    nvim -S $SESSION_FILE
  fi
}

# Load hub
if type hub > /dev/null; then
  alias git=hub
fi

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/matheussampaio/Downloads/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/matheussampaio/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/matheussampaio/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/matheussampaio/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
