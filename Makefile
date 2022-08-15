SHELL = /bin/bash
DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
UNAME_S := $(shell uname -s)


BREW_PACKAGES  := stow tmux ripgrep wget jq fd lua-language-server rust-analyzer exa
NODE_PACKAGES  := n tldr neovim typescript typescript-language-server trash-cli eslint prettier js-beautify
CARGO_PACKAGES := zoxide


all: install-brew-packages install-cargo-packages install-node-packages install-neovim install-fzf install-zplug link install-terminfo


link:
	stow --verbose --no-folding --target=$$HOME --dir=$(DIR) --restow home


install-brew-packages:
	if ! type "brew" >/dev/null 2>&1; then \
		curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash; \
	fi; \
	brew install $(BREW_PACKAGES)


install-zplug:
	if [ ! -d "$$HOME/.zplug" ]; then \
		curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh; \
	fi;


install-cargo-packages:
	if ! type "cargo" > /dev/null 2>&1; then \
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh; \
		source "$$HOME/.cargo/env"; \
	fi; \
	cargo install $(CARGO_PACKAGES)


install-fzf:
	if [ ! -d $$HOME/.fzf ]; then git clone --depth 1 https://github.com/junegunn/fzf.git $$HOME/.fzf; fi; \
	$$HOME/.fzf/install --xdg --no-bash --no-fish --key-bindings --no-update-rc --completion


install-node-packages:
	if ! type "node" > /dev/null 2>&1; then \
		brew install node; \
	fi; \
	if ! type "n" > /dev/null 2>&1; then \
		mkdir -p $$HOME/.npm $$HOME/.n && \
		npm install --prefix $$HOME/.npm -g n && \
		N_PREFIX=$$HOME/.n $$HOME/.npm/bin/n lts; \
	fi; \
	$$HOME/.n/bin/npm install --prefix $$HOME/.npm -g $(NODE_PACKAGES)


install-neovim:
	brew install --HEAD luajit
	brew install neovim


install-terminfo:
	curl -LO https://invisible-island.net/datafiles/current/terminfo.src.gz && gunzip terminfo.src.gz && \
	/usr/bin/tic -xe tmux-256color terminfo.src
