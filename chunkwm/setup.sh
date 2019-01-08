#!/usr/bin/env bash

set -ex

# clone tap
brew tap koekeishiya/formulae

brew install chunkwm

# install skhd (hotkey daemon) for setting up the keyboard shortcuts for chunkwm
brew install skhd

# Copy our configs
ln -sf ~/git/dotfiles/chunkwm/.chunkwmrc ~/.chunkwmrc
ln -sf ~/git/dotfiles/chunkwm/.skhdrc ~/.skhdrc

# chunkwmrc configuration file needs exec permission
chmod +x ~/.chunkwmrc

# Copy plugins from instalation path
cp -R /usr/local/opt/chunkwm/share/chunkwm/plugins ~/.chunkwm_plugins

# start the services
brew services start chunkwm
brew services start skhd

