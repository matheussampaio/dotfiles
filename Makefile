SHELL = /bin/bash
DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
UNAME_S := $(shell uname -s)


SYSTEM_PACKAGES        := git stow tmux ripgrep wget jq zsh
MACOS_SYSTEM_PACKAGES  := fd lua-language-server
LINUX_SYSTEM_PACKAGES  := fd-find
NODE_PACKAGES          := n tldr neovim typescript typescript-language-server trash-cli eslint prettier


all: install-system-packages install-node setup-node install-neovim setup-neovim install-fzf install-zplug link


link:
	stow --verbose --target=$$HOME --dir=$(DIR) --restow zsh nvim git tmux npm


install-system-packages:
ifeq ($(UNAME_S), Darwin)
	if ! type "brew" >/dev/null 2>&1; then \
		curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash; \
	fi; \
	brew install $(SYSTEM_PACKAGES) $(MACOS_SYSTEM_PACKAGES)
else
	sudo apt-get update && \
	sudo apt-get install -y $(SYSTEM_PACKAGES) $(LINUX_SYSTEM_PACKAGES) && \
	mkdir -p $$HOME/.local/bin && ln -fs /usr/bin/fdfind $$HOME/.local/bin/fd
endif


install-zplug:
	if [ ! -d "$$HOME/.zplug" ]; then \
		curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh; \
	fi;


install-fzf:
	if [ ! -d $$HOME/.fzf ]; then git clone --depth 1 https://github.com/junegunn/fzf.git $$HOME/.fzf; fi; \
	$$HOME/.fzf/install --xdg --no-bash --no-fish --key-bindings --no-update-rc --completion


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
	brew install --HEAD luajit
	brew install --HEAD neovim
else
	sudo add-apt-repository ppa:neovim-ppa/unstable -y && \
	sudo apt-get update && \
	sudo apt-get install -y neovim
endif


setup-neovim:
	nvim --headless +"PlugInstall --sync" +"PlugClean\!" +qa


install-terminfo:
	curl -LO https://invisible-island.net/datafiles/current/terminfo.src.gz && gunzip terminfo.src.gz && \
	/usr/bin/tic -xe tmux-256color terminfo.src


download-theme:
	wget https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/Gruvbox%20Light.itermcolors && \
	wget https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/Gruvbox%20Dark.itermcolors


update:
	brew update && brew upgrade && \
	$$HOME/.tmux/plugins/tpm/bin/update_plugins all && \
	cd $$HOME/.fzf && git pull && \
	nvim --headless +"PlugUpgrade" +"PlugUpdate --sync" +"PlugClean\!" +qa

