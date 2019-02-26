#!/usr/bin/env bash

set -e

USERNAME=$(whoami)

PACKAGES=(
    # Essentials
    "tpope/vim-commentary" # comment stuff out
    "tpope/vim-sensible" # universal set of defaults that everyone can agree on
    "tpope/vim-surround" # provides mappings to easily delete, change and add surroundings (parantheses, brackets, quotes, etc)
    "tpope/vim-fugitive" # git wrapper
    "tpope/vim-apathy" # set `path` option for miscellaneous file types
    "tpope/vim-vinegar" # directory browser
    "kien/ctrlp.vim" # fuzzy file, buffer mru ttag, etc finder
    "vim-airline/vim-airline" # lean and mean status/tabline
    "vim-airline/vim-airline-themes"
    "w0rp/ale" # asynchronous lint engine
    "kshenoy/vim-signature" # place, toggle and display marks
    "unblevable/quick-scope" # highlights which characters to target for `f`, `F` and family.
    "mileszs/ack.vim" # search files with Ack
    "terryma/vim-smooth-scroll" # smooth scroll when moving pages
    "suy/vim-context-commentstring" # sets the value of 'commentstring' depending on the region of the file
    "jiangmiao/auto-pairs" # insert or delete brackets, parents, and quotes in pairs
    "christoomey/vim-tmux-navigator" # make it easier to swap between vim and tmux

    # Others
    "vimwiki/vimwiki" # personal wiki from vim
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
ln -fs $(pwd)/vim/mine $HOME/.vim/pack/$USERNAME/start/mine

echo "creating plugins link"
ln -fs $(pwd)/vim/plugin $HOME/.vim/plugin

for PACKAGE in ${PACKAGES[@]}; do
   DIRNAME="$(basename $PACKAGE)"
   PACKAGE_DIR="$HOME/.vim/pack/$USERNAME/start/$DIRNAME"
   REPOSITORY_URL="https://github.com/$PACKAGE.git"

   echo "cloning $PACKAGE..."

   git clone --depth 1 $REPOSITORY_URL $PACKAGE_DIR
done

vim -c "helptags ALL" -c q

echo "vim setup done <3"
