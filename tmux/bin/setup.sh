#!/usr/bin/env bash

git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

ln -s $HOME/git/dotfiles/tmux/.tmux.conf $HOME/.tmux.conf

echo "tmux setup done <3"

