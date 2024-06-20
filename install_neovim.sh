#!/usr/bin/env bash

NVIM_VERSION="v0.10.0"

# https://gist.github.com/kawaz/393c7f62fe6e857cc3d9#file-install_neovim_to_amazonlinux-sh
sudo yum groups install -y Development\ tools
sudo yum install -y cmake3
sudo yum install -y python34-{devel,pip}
sudo pip-3.4 install neovim --upgrade
(
cd "$(mktemp -d)"
git clone https://github.com/neovim/neovim.git
cd neovim
git checkout "$NVIM_VERSION"
make CMAKE_BUILD_TYPE=Release
sudo make install
)
