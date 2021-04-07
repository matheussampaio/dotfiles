#!/bin/bash

set -e

brew="/usr/local/bin/brew"

if [ -f "$brew" ]
then
  echo "---------------------------------------------------------"
  echo "$(tput setaf 2) Homebrew is installed.$(tput sgr 0)"
  echo "---------------------------------------------------------"
else
  echo "---------------------------------------------------------"
  echo "$(tput setaf 3) Installing Homebrew. Homebrew requires osx command lines tools, please download xcode first$(tput sgr 0)"
  echo "---------------------------------------------------------"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# disable analytics
brew analytics off

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Updating Homebrew.$(tput sgr 0)"
echo "---------------------------------------------------------"
brew update

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Installing system packages.$(tput sgr 0)"
echo "---------------------------------------------------------"
brew reinstall gcc git python3 node tmux zsh ripgrep htop hub tree wget jq

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Installing lazygit.$(tput sgr 0)"
echo "---------------------------------------------------------"
brew reinstall jesseduffield/lazygit/lazygit

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Cleaning Homebrew.$(tput sgr 0)"
echo "---------------------------------------------------------"
brew cleanup

./install_nvim.sh
