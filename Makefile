SHELL = /bin/bash
DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
UNAME_S := $(shell uname -s)


BREW_PACKAGES := git stow tmux ripgrep wget jq zsh fd lua-language-server man
NODE_PACKAGES := n tldr neovim typescript typescript-language-server trash-cli eslint prettier


all: install-brew-packages install-node install-neovim install-fzf install-zplug link setup-zsh


link:
	stow --verbose --target=$$HOME --dir=$(DIR) --restow home


install-brew-packages:
	if ! type "brew" >/dev/null 2>&1; then \
		curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash; \
	fi; \
	brew install $(BREW_PACKAGES)


install-zplug:
	if [ ! -d "$$HOME/.zplug" ]; then \
		curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh; \
	fi;


install-fzf:
	if [ ! -d $$HOME/.fzf ]; then git clone --depth 1 https://github.com/junegunn/fzf.git $$HOME/.fzf; fi; \
	$$HOME/.fzf/install --xdg --no-bash --no-fish --key-bindings --no-update-rc --completion


install-node:
	brew install node


setup-node:
	mkdir -p $$HOME/.npm $$HOME/.n && \
	npm install --prefix $$HOME/.npm -g n && \
	N_PREFIX=$$HOME/.n $$HOME/.npm/bin/n lts && \
	$$HOME/.n/bin/npm install --prefix $$HOME/.npm -g $(NODE_PACKAGES)


install-neovim:
	brew install --HEAD luajit
	brew install --HEAD neovim


install-terminfo:
	curl -LO https://invisible-island.net/datafiles/current/terminfo.src.gz && gunzip terminfo.src.gz && \
	/usr/bin/tic -xe tmux-256color terminfo.src


setup-zsh:
	chsh -s $$(which zsh)
