#!/bin/bash

set -e

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Update apt-get.$(tput sgr 0)"
echo "---------------------------------------------------------"
sudo apt-get update

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Install essentials.$(tput sgr 0)"
echo "---------------------------------------------------------"
sudo apt-get install -y build-essential gcc curl git

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Install tools.$(tput sgr 0)"
echo "---------------------------------------------------------"
sudo apt-get install -y file python3 tmux ripgrep htop hub zsh tree

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Install node.$(tput sgr 0)"
echo "---------------------------------------------------------"
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install -y nodejs

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Installing NeoVim.$(tput sgr 0)"
echo " ---------------------------------------------------------"
# sudo apt-get install -y python-neovim python3-neovim neovim
wget https://github.com/neovim/neovim/releases/download/v0.4.2/nvim.appimage
sudo mv nvim.appimage /usr/bin/nvim
