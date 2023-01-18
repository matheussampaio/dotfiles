SHELL = /bin/bash
DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
UNAME_S := $(shell uname -s)


BREW_PACKAGES        := stow tmux ripgrep wget jq fd lua-language-server rust-analyzer exa bat tree jdtls htop miller glow pyenv pyenv-virtualenv lazygit
CARGO_PACKAGES       := zoxide
NODE_PACKAGES        := n tldr neovim typescript typescript-language-server trash-cli eslint prettier js-beautify
ZSH_PLUGINS_PACKAGES := romkatv/powerlevel10k ohmyzsh/ohmyzsh zsh-users/zsh-autosuggestions jeffreytse/zsh-vi-mode djui/alias-tips apachler/zsh-aws Aloxaf/fzf-tab mroth/evalcache


all:: install-brew-packages install-cargo-packages install-node-packages install-neovim install-fzf download-zsh-plugins link install-terminfo


link::
	stow --verbose --no-folding --target=$$HOME --dir=$(DIR) --restow home


unlink::
	stow --verbose --no-folding --target=$$HOME --dir=$(DIR) --delete home


install-brew-packages:
	if [ -d "/home/linuxbrew/.linuxbrew/bin" ]; then \
		export PATH="/home/linuxbrew/.linuxbrew/bin:$$PATH"; \
	fi; \
	if ! type "brew" >/dev/null 2>&1; then \
		curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash; \
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


install-neovim: setup-neovim-python2 setup-neovim-python3
	brew install --HEAD luajit
	brew install neovim


install-terminfo:
	curl -LO https://invisible-island.net/datafiles/current/terminfo.src.gz && gunzip terminfo.src.gz && \
	/usr/bin/tic -xe tmux-256color terminfo.src


setup-java:: download-checkstyle download-lombok download-google-java-format setup-java-debug setup-vscode-java-test setup-vscode-java-decompiler


download-checkstyle:
	mkdir -p ~/.java && wget https://github.com/checkstyle/checkstyle/releases/download/checkstyle-8.41/checkstyle-8.41-all.jar -O ~/.java/checkstyle.jar


download-lombok:
	mkdir -p ~/.java && wget https://projectlombok.org/downloads/lombok.jar -O ~/.java/lombok.jar


download-google-java-format:
	mkdir -p ~/.java && wget https://github.com/google/google-java-format/releases/download/v1.15.0/google-java-format-1.15.0-all-deps.jar -O ~/.java/google-java-format.jar


setup-java-debug:
	mkdir -p ~/.java && \
	cd ~/.java && \
	rm -rf ~/.java/java-debug && \
	git clone --depth 1 git@github.com:microsoft/java-debug.git
	cd ~/.java/java-debug && \
	./mvnw clean install


setup-vscode-java-test:
	mkdir -p ~/.java && \
	cd ~/.java && \
	rm -rf ~/.java/vscode-java-test && \
	git clone --depth 1 git@github.com:microsoft/vscode-java-test.git
	cd ~/.java/vscode-java-test && \
	npm install && \
	npm run build-plugin


setup-vscode-java-decompiler:
	mkdir -p ~/.java && \
	cd ~/.java && \
	rm -rf ~/.java/vscode-java-decompiler && \
	git clone --depth 1 git@github.com:dgileadi/vscode-java-decompiler.git


setup-neovim-python2:
	pyenv install 2.7.18 && \
	pyenv virtualenv 2.7.18 neovim2 && \
	pyenv activate neovim2 && \
	pip install neovim


setup-neovim-python3:
	pyenv install 3.7.13 && \
	pyenv virtualenv 3.4.4 neovim3 && \
	pyenv activate neovim3 && \
	pip install neovim


download-zsh-plugins:
	rm -rf ~/.zsh && \
	mkdir -p ~/.zsh && \
	cd ~/.zsh && \
	for repo in $(ZSH_PLUGINS_PACKAGES); do \
		git clone --depth=1 https://github.com/$$repo.git; \
	done
