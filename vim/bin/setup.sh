#!/usr/bin/env bash

USERNAME=$(whoami)
PERSONA_CUSTOMIZATIONS="mine"

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

    # Others
    "vimwiki/vimwiki" # personal wiki from vim
    "christoomey/vim-tmux-navigator" # navigate seamlessly between vim and tmux splits
    "sheerun/vim-polyglot" # collection of language packs

    # HTML Plugins
    "mattn/emmet-vim"

    # Colorschema
    "sickill/vim-monokai" # monokai color scheme
)

cp -R $PERSONA_CUSTOMIZATIONS $HOME/.vim/pack/$USERNAME/$PERSONA_CUSTOMIZATIONS

ln -fs $(pwd)/../.vimrc $HOME/.vimrc

exit

rm -rf $HOME/.vim/pack
mkdir -p $HOME/.vim/pack

for PACKAGE in ${PACKAGES[@]}; do
   DIRNAME="$(basename $PACKAGE)"
   git clone https://github.com/$PACKAGE.git $HOME/.vim/pack/$USERNAME/start/$DIRNAME
done


echo "vim setup done <3"
