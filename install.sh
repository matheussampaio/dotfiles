#! /bin/bash

set -ex

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Greetings. Preparing to power up and begin diagnostics.$(tput sgr 0)"
echo "---------------------------------------------------------"

INSTALLDIR=$PWD

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Creating symbolic links.$(tput sgr 0)"
echo "---------------------------------------------------------"

ln -fs $PWD/zsh/.zshrc $HOME/.zshrc
ln -fs $PWD/zsh/.zshenv $HOME/.zshenv

ln -fs $PWD/tmux/.tmux.conf $HOME/.tmux.conf

mkdir -p $XDG_CONFIG_HOME/git
ln -fs $PWD/git/.gitignore $XDG_CONFIG_HOME/git/ignore
ln -fs $PWD/git/.gitconfig $HOME/.gitconfig

mkdir -p $XDG_CONFIG_HOME/ranger
ln -fs $PWD/ranger/rc.conf $XDG_CONFIG_HOME/ranger/rc.conf
ln -fs $PWD/ranger/scope.sh $XDG_CONFIG_HOME/ranger/scope.sh

mkdir -p $HOME/.config/nvim

ln -fs $PWD/nvim/coc-settings.json $HOME/.config/nvim/coc-settings.json
ln -fs $PWD/nvim/init.vim $HOME/.config/nvim/init.vim
ln -fs $PWD/nvim/after $HOME/.config/nvim/after

if [[ "$OSTYPE" == "darwin"* ]]; then
  ./install_osx.sh
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  ./install_ubuntu.sh
fi

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Installing Python NeoVim client.$(tput sgr 0)"
echo "---------------------------------------------------------"
pip3 install neovim

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Setting npm folder to ~/.npm.$(tput sgr 0)"
echo "---------------------------------------------------------"
npm set prefix ~/.npm

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Installing node package$(tput sgr 0)"
echo "---------------------------------------------------------"
npm install -g tldr

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Installing node neovim package$(tput sgr 0)"
echo "---------------------------------------------------------"
npm install -g neovim

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Installing yarn package$(tput sgr 0)"
echo "---------------------------------------------------------"
npm install -g yarn

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Installing yarn package$(tput sgr 0)"
echo "---------------------------------------------------------"
vim +"PlugInstall --sync" +qa

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Installing tmux plugin manager.$(tput sgr 0)"
echo "---------------------------------------------------------"
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone --depth 1 https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
fi

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Installing fzf.$(tput sgr 0)"
echo "---------------------------------------------------------"
if [ ! -d "$HOME/.fzf" ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
fi

$HOME/.fzf/install --all --no-bash --no-fish --xdg

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Installing oh-my-zsh.$(tput sgr 0)"
echo "---------------------------------------------------------"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

exit 0
