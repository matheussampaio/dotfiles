#!/usr/bin/env bash

BASE_DIR="$HOME/.vim"
PLUGIN_DIR="$BASE_DIR/bundle"
COLORS_DIR="$BASE_DIR/colors"
AUTOLOAD_DIR="$BASE_DIR/autoload"
PLUGINS=(
    "tpope/vim-pathogen"
    "tpope/vim-commentary"
    "tpope/vim-sensible"
    "tpope/vim-surround"
    "vim-airline/vim-airline"
    "vim-airline/vim-airline-themes"
    "scrooloose/nerdtree"
    "sickill/vim-monokai"
    "kien/ctrlp.vim"
    "vimwiki/vimwiki"
)

rm -rf $PLUGIN_DIR
mkdir -p $PLUGIN_DIR

rm -rf $COLORS_DIR
mkdir -p $COLORS_DIR

rm -rf $AUTOLOAD_DIR
mkdir -p $AUTOLOAD_DIR

for PLUGIN in ${PLUGINS[@]}; do
   DIRNAME="$(basename $PLUGIN)"
   git clone https://github.com/$PLUGIN.git $PLUGIN_DIR/$DIRNAME
done

ln -s $HOME/git/dotfiles/.vimrc $HOME/.vimrc
ln -s $PLUGIN_DIR/vim-monokai/colors/monokai.vim $COLORS_DIR/monokai.vim
ln -s $PLUGIN_DIR/vim-pathogen/autoload/pathogen.vim $AUTOLOAD_DIR/pathogen.vim

echo "vim setup done <3"
