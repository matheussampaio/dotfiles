SHELL = /bin/bash

UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S), Darwin)
	OS := macos
else
	OS := linux
endif

all: $(OS)

macos: install-brew-packages install-node-packages install-nvim link

link:
	stow --verbose --target=$$HOME --restow zsh nvim git tmux

unlink:
	stow --verbose --target=$$HOME --delete zsh nvim git tmux

install-brew-packages: install-brew
	brew install gcc git stow tmux ripgrep wget jq fzf node; \
		$HOME/.fzf/install --xdg --no-bash --no-fish --no-key-bindings --no-update-rc --completion

install-brew:
	if ! type "brew" >/dev/null 2>&1; then \
		curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash; \
	fi

install-nvim: install-brew-packages link
	brew install neovim --HEAD;

install-node-packages: install-brew-packages
	npm install -g n tldr neovim; \
		mkdir -p $HOME/.n
