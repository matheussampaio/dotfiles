#!/bin/sh
echo "---------------------------------------------------------"
echo "$(tput setaf 2) Greetings. Preparing to power up and begin diagnostics.$(tput sgr 0)"
echo "---------------------------------------------------------"

INSTALLDIR=$PWD

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Checking for Homebrew installation.$(tput sgr 0)"
echo "---------------------------------------------------------"
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

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Installing system packages.$(tput sgr 0)"
echo "---------------------------------------------------------"

packages=(
  "git"
  "node"
  "tmux"
  "python3"
  "zsh"
  "ripgrep"
  "fzf"
  "cmake"
  "boost"
  "htop"
  "tldr"
  "hub"
  "z"
)

for i in "${packages[@]}"
do
  brew install $i
  brew upgrade $i
  echo "---------------------------------------------------------"
done

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Installing NeoVim.$(tput sgr 0)"
echo "---------------------------------------------------------"

rm -rf nvim-osx64
wget https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz
tar xzvf nvim-macos.tar.gz
ln -fs $PWD/nvim-osx64/bin/nvim /usr/local/bin/nvim
rm nvim-macos.tar.gz

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Installing Python NeoVim client.$(tput sgr 0)"
echo "---------------------------------------------------------"

pip3 install neovim

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Installing node neovim package$(tput sgr 0)"
echo "---------------------------------------------------------"

npm install -g neovim

localGit="/usr/local/bin/git"
if ! [[ -f "$localGit" ]]; then
  echo "---------------------------------------------------------"
  echo "$(tput setaf 1) Invalid git installation. Aborting. Please install git.$(tput sgr 0)"
  echo "---------------------------------------------------------"
  exit 1
fi

# Create backup folder if it doesn't exist
mkdir -p ~/.local/share/nvim/backup

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Installing oh-my-zsh.$(tput sgr 0)"
echo "---------------------------------------------------------"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

  ln -fs $PWD/.zshrc ~/.zshrc
else
  echo "---------------------------------------------------------"
  echo "$(tput setaf 2) oh-my-zsh already installed.$(tput sgr 0)"
  echo "---------------------------------------------------------"
fi

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Installing zsh-autosuggestions.$(tput sgr 0)"
echo "---------------------------------------------------------"
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Installing Neovim plugins and linking dotfiles.$(tput sgr 0)"
echo "---------------------------------------------------------"

mkdir -p $HOME/.config/nvim

ln -fs $PWD/nvim/coc-settings.json ~/.config/nvim/coc-settings.json
ln -fs $PWD/nvim/init.vim ~/.config/nvim/init.vim
ln -fs $PWD/nvim/plugins.vim ~/.config/nvim/plugins.vim

nvim +PlugInstall +qall
nvim +UpdateRemotePlugins +qall

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Installing tmux plugin manager.$(tput sgr 0)"
echo "---------------------------------------------------------"

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ~/.tmux/plugins/tpm/scripts/install_plugins.sh

  ln -fs $PWD/.tmux.conf ~/.tmux.conf
fi

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Switching shell to zsh. You may need to logout.$(tput sgr 0)"
echo "---------------------------------------------------------"

sudo sh -c "echo $(which zsh) >> /etc/shells"
chsh -s $(which zsh)

echo "---------------------------------------------------------"
echo "$(tput setaf 2) System update complete. Currently running at 100% power. Enjoy.$(tput sgr 0)"
echo "---------------------------------------------------------"

exit 0
