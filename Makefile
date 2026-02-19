SHELL = /bin/bash
DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
UNAME_S := $(shell uname -s)


BREW_PACKAGES        := stow tmux ripgrep wget jq fd tree htop miller lazygit
CARGO_PACKAGES       := zoxide eza
NODE_PACKAGES        := n tldr neovim
ZSH_PLUGINS_PACKAGES := romkatv/powerlevel10k ohmyzsh/ohmyzsh zsh-users/zsh-autosuggestions jeffreytse/zsh-vi-mode Aloxaf/fzf-tab mroth/evalcache


all:: install-brew-packages install-cargo-packages install-node-packages install-neovim install-fzf download-zsh-plugins link install-terminfo


link::
	stow --verbose --no-folding --target=$$HOME --dir=$(DIR) --restow home


unlink::
	stow --verbose --no-folding --target=$$HOME --dir=$(DIR) --delete home


install-brew-packages:
	if [ -d "/home/linuxbrew/.linuxbrew/bin" ]; then \
		export PATH="/home/linuxbrew/.linuxbrew/bin:$$PATH"; \
	fi; \
	brew install $(BREW_PACKAGES)


install-cargo-packages:
	if ! type "cargo" > /dev/null 2>&1; then \
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --profile default -y; \
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
	curl -LO https://invisible-island.net/datafiles/current/terminfo.src.gz && \
	gunzip terminfo.src.gz && \
	/usr/bin/tic -xe tmux-256color terminfo.src && \
	rm terminfo.src


download-zsh-plugins:
	rm -rf ~/.zsh && \
	mkdir -p ~/.zsh && \
	cd ~/.zsh && \
	for repo in $(ZSH_PLUGINS_PACKAGES); do \
		git clone --depth=1 https://github.com/$$repo.git; \
	done


update-zsh-plugins:
	cd ~/.zsh && \
	ls | xargs -I{} git -C {} pull
