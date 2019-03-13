#!/usr/bin/env bash

set -e

USERNAME=$(whoami)

PACKAGES=(
    # Essentials
    "tpope/vim-sensible" # universal set of defaults that everyone can agree on.
    "tpope/vim-commentary" # comment stuff out.
    "suy/vim-context-commentstring" # sets the value of 'commentstring' depending on the region of the file.
    "tpope/vim-surround" # provides mappings to easily delete, change and add surroundings (parantheses, brackets, quotes, etc).
    "tpope/vim-fugitive" # git wrapper.
    # "tpope/vim-apathy" # set `path` option for miscellaneous file types.
    "tpope/vim-vinegar" # improvements to netrw
    "kien/ctrlp.vim" # fuzzy file, buffer mru ttag, etc finder.
    "vim-airline/vim-airline" # lean and mean status/tabline.
    "vim-airline/vim-airline-themes"
    # "w0rp/ale" # asynchronous lint engine.
    "kshenoy/vim-signature" # place, toggle and display marks.
    "unblevable/quick-scope" # highlights which characters to target for `f`, `F` and family.
    "mileszs/ack.vim" # search files with Ack.
    # "jiangmiao/auto-pairs" # insert or delete brackets, parents, and quotes in pairs.
    "christoomey/vim-tmux-navigator" # make it easier to swap between vim and tmux.
    "milkypostman/vim-togglelist" # toggle quicklist and loclist
    "simnalamburt/vim-mundo" # undo tree

    # Others
    "mhinz/vim-signify" # sign column to indicate added, modified and removed lines.
    # "sheerun/vim-polyglot" # collection of language packs.

    # Autocompletion
    # "neoclide/coc.nvim" # intellisense engine with LSP support. NOTE: Requires nodejs, yarn and vim-node-rpc

    # HTML
    "mattn/emmet-vim"

    # Javascript
    "pangloss/vim-javascript"
    "mxw/vim-jsx"

    # Markdown
    "shime/vim-livedown" # preview markdown.

    # Themes
    "sickill/vim-monokai" 

    # Others
    "lervag/wiki.vim"
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

vim -esc "helptags ALL | q"

echo "vim setup done <3"
