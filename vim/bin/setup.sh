#!/usr/bin/env bash

set -e

USERNAME=$(whoami)

echo "creating .vimrc link"
ln -fs $(pwd)/vim/.vimrc $HOME/.vimrc

echo "cleaning ~/.vim/pack..."
rm -rf $HOME/.vim/pack
mkdir -p $HOME/.vim/pack/$USERNAME/start

echo "creating mine link"
ln -fs $(pwd)/vim/mine $HOME/.vim/pack/$USERNAME/start/mine

echo "creating plugins link"
ln -fs $(pwd)/vim/plugin $HOME/.vim/plugin

echo "vim setup done <3"
