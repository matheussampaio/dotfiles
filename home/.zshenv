# Language settings
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Disable brew analytics
export HOMEBREW_NO_ANALYTICS=1

# Enable `ls` colors
export CLICOLOR=1

# Set XDG values
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

export N_PREFIX=$HOME/.n

if [ -f "/usr/local/bin/brew" ]; then
    eval $(/usr/local/bin/brew shellenv)
fi

if [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi

if [ -d "$HOME/go/bin" ]; then
    path+=$HOME/go/bin
fi

if [ -d "/usr/local/go/bin" ]; then
    path+=/usr/local/go/bin
fi

if [ -d "$HOME/.npm/bin" ]; then
    path+=$HOME/.npm/bin
fi

if [ -d "$HOME/.n/bin" ]; then
    path+=$HOME/.n/bin
fi

if [ -d "$HOME/.local/bin" ]; then
    path+=$HOME/.local/bin
fi

if [ -d "$HOME/.rbenv/bin" ]; then
    path+=$HOME/.rbenv/bin
fi

if [ -d "$HOME/.gem/ruby/2.6.0/bin/" ]; then
    path+=$HOME/.gem/ruby/2.6.0/bin
fi

if [ -d "$HOME/.npm-global/bin" ]; then
    path+=$HOME/.npm-global/bin
fi

if [ -d "$HOME/nvim/bin" ]; then
    path+=$HOME/nvim/bin/
fi

if [ -d "$HOME/.plenv/bin" ]; then
    path+=$HOME/.plenv/bin
fi

if [ -d "$HOME/.cargo/bin" ]; then
    path+=$HOME/.cargo/bin
fi

if [ -f "$HOME/.zshenv.local" ]; then
    source "$HOME/.zshenv.local"
fi

# Add JAVA_HOME_<VERSION> environment variables.
folders=($HOMEBREW_PREFIX/opt/openjdk@*/)

for folder in $folders; do
  if [[ $folder =~ '.*openjdk@([0-9]+)' ]]; then
    version="${match[1]}"
    export "JAVA_HOME_${version}"="${folder}libexec/"
  fi
done
