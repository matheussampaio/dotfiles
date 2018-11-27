"============================================================
" Plugins
"============================================================
" List of plugins that I use:
" + ctrlp
" + vim-airline
" + nerdtree
" + pathogen

set runtimepath^=~/.vim/bundle/ctrlp.vim
set runtimepath^=~/.vim/bundle/vim-airline/plugin/airline.vim

"============================================================
" matheussampaio settings
"============================================================

set nocompatible
syntax on " Enable syntax highlighting.
color monokai " Select Monokai theme
set smartindent
set clipboard=unnamed " use OS clipboard
set shiftwidth=2 " number of spaces when shift indenting
set tabstop=2 " number of visual spaces per tab
set softtabstop=2 " number of spaces in tab when editing
set expandtab " tab to spaces
set number " show line numbers
set cursorline  " highlight current line
set showmatch " highlight matching [{()}]
set incsearch " search as characters are entered
set hlsearch " highlight matches
set ignorecase " Ignore case when searching.
set smartcase " Override the 'ignorecase' option if the search pattern contains upper case characters.
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/* " lol
set visualbell " Error bells are displayed visually.
set wildmenu " Show autocomplete menus.
set backspace=indent,eol,start " Normal backspace
filetype plugin on " Defines autocommands that will get executed when a file matching a given pattern is opened.

" Create folder and set backup, undo and swp folder
silent !mkdir ~/.vim/.backup > /dev/null 2>&1
silent !mkdir ~/.vim/.undo > /dev/null 2>&1
silent !mkdir ~/.vim/.swp > /dev/null 2>&1

set backupdir=~/.vim/.backup//
set undodir=~/.vim/.undo//
set directory=~/.vim/.swp//

" Show invisible characters
set list
set listchars=tab:>-,trail:~,extends:>,precedes:<

" Remove escape delay
set timeoutlen=1000 ttimeoutlen=0

" Open split at the right side
set splitright
set splitbelow

"============================================================
" Plugins
"============================================================

" Plugin: NERDTree
" https://github.com/scrooloose/nerdtree
map <C-n> :NERDTreeToggle<CR>

" Close VIM if the only window left open is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Plugin: vim-airline
" https://github.com/vim-airline/vim-airline
set laststatus=2
let g:airline_theme = 'deus'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1

" Plugin: vimwiki
" https://github.com/vimwiki/vimwiki
let g:vimwiki_list = [{ 'path': '~/Dropbox/wiki' }]

"============================================================
" Mappings
"============================================================

" space open/closes folds
nnoremap <space> za

"============================================================
" Start pathogen
"============================================================
execute pathogen#infect()
call pathogen#helptags()

set noruler
set noshowmode
set hidden
