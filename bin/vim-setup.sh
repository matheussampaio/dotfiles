#!/usr/bin/env bash

DOTFILES_DIR="$HOME/git/dotfiles"

BASE_DIR="$HOME/.vim"
PLUGIN_DIR="$BASE_DIR/bundle"
COLORS_DIR="$BASE_DIR/colors"
AUTOLOAD_DIR="$BASE_DIR/autoload"
FTPLUGIN_DIR="$BASE_DIR/ftplugin"

PLUGINS=(
    # Essentials
    "tpope/vim-pathogen" # install plugins and runtime files
    "tpope/vim-commentary" # comment stuff out
    "tpope/vim-sensible" # universal set of defaults that everyone can agree on
    "tpope/vim-surround" # provides mappings to easily delete, change and add surroundings (parantheses, brackets, quotes, etc)
    "tpope/vim-fugitive" # git wrapper
    "kien/ctrlp.vim" # fuzzy file, buffer mru ttag, etc finder
    "vim-airline/vim-airline" # lean and mean status/tabline
    "vim-airline/vim-airline-themes"
    "scrooloose/nerdtree" # tree explorer plugin
    "sickill/vim-monokai" # monokai color scheme
    "w0rp/ale" # asynchronous lint engine
    "kshenoy/vim-signature" # place, toggle and display marks
    "unblevable/quick-scope" # highlights which characters to target for `f`, `F` and family.

    # Others
    "vimwiki/vimwiki" # personal wiki from vim
    "christoomey/vim-tmux-navigator" # navigate seamlessly between vim and tmux splits

    # Vue Plugins
    "posva/vim-vue" # syntax highlighting for vue components

    # Javascript Plugins
    "pangloss/vim-javascript"
)

rm -rf $PLUGIN_DIR
mkdir -p $PLUGIN_DIR

rm -rf $COLORS_DIR
mkdir -p $COLORS_DIR

rm -rf $AUTOLOAD_DIR
mkdir -p $AUTOLOAD_DIR

for PLUGIN in ${PLUGINS[@]}; do
   DIRNAME="$(basename $PLUGIN)"
   git clone https://github.com/$PLUGIN.git $PLUGIN_DIR/$DIRNAME
done

ln -s $DOTFILES_DIR/.vimrc $HOME/.vimrc
ln -s $DOTFILES_DIR/ftplugin $FTPLUGIN_DIR
ln -s $PLUGIN_DIR/vim-monokai/colors/monokai.vim $COLORS_DIR/monokai.vim
ln -s $PLUGIN_DIR/vim-pathogen/autoload/pathogen.vim $AUTOLOAD_DIR/pathogen.vim

echo "vim setup done <3"
