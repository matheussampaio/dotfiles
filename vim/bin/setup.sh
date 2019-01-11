#!/usr/bin/env bash

set -e

USERNAME=$(whoami)
PERSONAL_CUSTOMIZATIONS="mine"

PACKAGES=(
    # Essentials
    "tpope/vim-commentary" # comment stuff out
    "tpope/vim-sensible" # universal set of defaults that everyone can agree on
    "tpope/vim-surround" # provides mappings to easily delete, change and add surroundings (parantheses, brackets, quotes, etc)
    "tpope/vim-fugitive" # git wrapper
    "tpope/vim-apathy" # set `path` option for miscellaneous file types
    "tpope/vim-vinegar" # directory browser
    "tpope/vim-obsession" # keep vim-sessions updated
    "kien/ctrlp.vim" # fuzzy file, buffer mru ttag, etc finder
    "vim-airline/vim-airline" # lean and mean status/tabline
    "vim-airline/vim-airline-themes"
    "w0rp/ale" # asynchronous lint engine
    "kshenoy/vim-signature" # place, toggle and display marks
    "unblevable/quick-scope" # highlights which characters to target for `f`, `F` and family.

    # Others
    "vimwiki/vimwiki" # personal wiki from vim
    "christoomey/vim-tmux-navigator" # navigate seamlessly between vim and tmux splits
    "sheerun/vim-polyglot" # collection of language packs

    # HTML Plugins
    "mattn/emmet-vim"

    # Colorschema
    "sickill/vim-monokai" # monokai color scheme
)

echo "creating .vimrc link"
ln -fs $(pwd)/vim/.vimrc $HOME/.vimrc

echo "cleaning ~/.vim/pack..."

rm -rf $HOME/.vim/pack
mkdir -p $HOME/.vim/pack/$USERNAME/start

echo "creating mine link"
ln -fs $(pwd)/vim/$PERSONAL_CUSTOMIZATIONS $HOME/.vim/pack/$USERNAME/start/$PERSONAL_CUSTOMIZATIONS

for PACKAGE in ${PACKAGES[@]}; do
   DIRNAME="$(basename $PACKAGE)"
   PACKAGE_DIR="$HOME/.vim/pack/$USERNAME/start/$DIRNAME"
   REPOSITORY_URL="https://github.com/$PACKAGE.git"

   echo "cloning $PACKAGE..."

   git clone $REPOSITORY_URL $PACKAGE_DIR --quiet
done

vim -c "helptags ALL" -c q

echo "vim setup done <3"
