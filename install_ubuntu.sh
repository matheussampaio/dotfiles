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
sudo apt-get install -y git python3 python3-pip tmux zsh ripgrep htop hub tree wget jq fonts-powerline

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Install node.$(tput sgr 0)"
echo "---------------------------------------------------------"
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Installing laztgit.$(tput sgr 0)"
echo "---------------------------------------------------------"
sudo add-apt-repository ppa:lazygit-team/release
sudo apt-get update
sudo apt-get install -y lazygit
