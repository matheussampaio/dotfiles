#!/bin/bash

set -e

if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "---------------------------------------------------------"
  echo "$(tput setaf 2) Installing NeoVim.$(tput sgr 0)"
  echo "---------------------------------------------------------"

  rm -rf nvim-osx64
  wget https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz
  tar xzvf nvim-macos.tar.gz
  ln -fs $PWD/nvim-osx64/bin/nvim /usr/local/bin/nvim
  rm nvim-macos.tar.gz
fi
