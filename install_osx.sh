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
brew reinstall gcc git python3 node tmux zsh ripgrep htop hub tree

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Installing lazygit.$(tput sgr 0)"
echo "---------------------------------------------------------"
brew install jesseduffield/lazygit/lazygit
ln -fs $PWD/git/lazygit.config.yml $HOME/Library/Application\ Support/jesseduffield/lazygit/config.yml

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Cleaning Homebrew.$(tput sgr 0)"
echo "---------------------------------------------------------"
brew cleanup

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Installing NeoVim.$(tput sgr 0)"
echo "---------------------------------------------------------"

if [[ "$OSTYPE" == "darwin"* ]]; then
  rm -rf nvim-osx64
  wget https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz
  tar xzvf nvim-macos.tar.gz
  ln -fs $PWD/nvim-osx64/bin/nvim /usr/local/bin/nvim
  rm nvim-macos.tar.gz
fi
