SHELL = /bin/bash
DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
UNAME_S := $(shell uname -s)


SYSTEM_PACKAGES   := git stow tmux ripgrep wget jq zsh
NODE_PACKAGES     := n tldr neovim


all: install-system-packages install-node setup-node install-neovim setup-neovim install-fzf link


link:
	stow --verbose --target=$$HOME --dir=$(DIR) --restow zsh nvim git tmux npm


install-system-packages:
ifeq ($(UNAME_S), Darwin)
	if ! type "brew" >/dev/null 2>&1; then \
		curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash; \
	fi; \
	brew install $(SYSTEM_PACKAGES)
else
	sudo apt-get update && \
	sudo apt-get install -y $(SYSTEM_PACKAGES)
endif


install-fzf:
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && \
	~/.fzf/install --xdg --no-bash --no-fish --key-bindings --no-update-rc --completion


install-node:
ifeq ($(UNAME_S), Darwin)
	brew install node
else
	curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - && \
	sudo apt-get install -y nodejs
endif


setup-node:
	mkdir -p $$HOME/.npm $$HOME/.n && \
	npm install --prefix $$HOME/.npm -g n && \
	N_PREFIX=$$HOME/.n $$HOME/.npm/bin/n lts && \
	$$HOME/.n/bin/npm install --prefix $$HOME/.npm -g $(NODE_PACKAGES)


install-neovim:
ifeq ($(UNAME_S), Darwin)
	brew install neovim --HEAD
else
	sudo add-apt-repository ppa:neovim-ppa/unstable -y && \
	sudo apt-get update && \
	sudo apt-get install -y neovim
endif


setup-neovim:
	nvim --headless +"PlugInstall --sync" +qa
