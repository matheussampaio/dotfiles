SHELL = /bin/bash
DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
UNAME_S := $(shell uname -s)

SYSTEM_PACKAGES   := gcc g++ make git stow tmux ripgrep wget jq
NODE_PACKAGES     := n tldr neovim


ifeq ($(UNAME_S), Darwin)
	OS := macos
	PKG_INSTALLER := brew install
else
	OS := linux
	PKG_INSTALLER := sudo apt-get install -y
endif


all: $(OS)


macos: install-brew install-system-packages install-node-packages install-neovim install-fzf link


linux: install-system-packages install-node install-node-packages install-neovim install-fzf link


link:
	stow --verbose --target=$$HOME --dir=$(DIR) --restow zsh nvim git tmux


install-system-packages:
	$(PKG_INSTALLER) $(SYSTEM_PACKAGES)


install-fzf:
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && \
	~/.fzf/install --xdg --no-bash --no-fish --key-bindings --no-update-rc --completion


install-brew:
	if ! type "brew" >/dev/null 2>&1; then \
		curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash; \
	fi


install-node:
ifeq ($(OS), macos)
	$(PKG_INSTALLER) node
else
	curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - && \
	$(PKG_INSTALLER) nodejs
endif


install-neovim:
ifeq ($(OS), macos)
	$(PKG_INSTALLER) neovim --HEAD
else
	sudo add-apt-repository ppa:neovim-ppa/unstable -y && \
	sudo apt-get update && \
	$(PKG_INSTALLER) neovim
endif


install-node-packages:
	npm install -g $(NODE_PACKAGES) && \
	mkdir -p $$HOME/.n

