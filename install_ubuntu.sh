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
sudo apt-get install -y file python3 tmux ripgrep fzf htop tldr hub zsh

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Install node.$(tput sgr 0)"
echo "---------------------------------------------------------"
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install -y nodejs

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Installing NeoVim.$(tput sgr 0)"
echo "---------------------------------------------------------"
sudo apt-get install -y python-dev python-pip python3-dev python3-pip software-properties-common
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt-get install -y neovim
