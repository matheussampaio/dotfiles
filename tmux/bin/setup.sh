#!/usr/bin/env bash

rm -rf ~/.tmux/plugins

git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

ln -fs $HOME/git/dotfiles/tmux/.tmux.conf $HOME/.tmux.conf

echo "tmux setup done <3"

