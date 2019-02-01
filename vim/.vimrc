"============================================================
" matheussampaio's settings
"============================================================

set nocompatible
syntax on " Enable syntax highlighting.
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
set conceallevel=0 "disable auto-hide features
filetype plugin on " Defines autocommands that will get executed when a file matching a given pattern is opened.
set foldmethod=indent
set foldlevelstart=99
set relativenumber " Show relative line numbers
set noruler
set noshowmode
set hidden
set undofile
set undolevels=1000
set undoreload=10000
set encoding=utf-8

" Create folder and set backup, undo and swp folder
silent !mkdir ~/.vim/.backup > /dev/null 2>&1
silent !mkdir ~/.vim/.undo > /dev/null 2>&1
silent !mkdir ~/.vim/.swp > /dev/null 2>&1

set backupdir=~/.vim/.backup/
set undodir=~/.vim/.undo/
set directory=~/.vim/.swp/

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

" Plugin: vim-airline
" https://github.com/vim-airline/vim-airline
set laststatus=2

let g:airline_powerline_fonts = 1

let g:airline_theme='lucius'

let g:airline#extensions#branch#enabled=1
let g:airline#extensions#ale#enabled=1

" Plugin: vimwiki
" https://github.com/vimwiki/vimwiki
let g:vimwiki_list=[{ 'path': '~/Dropbox/wiki' }]

" Plugin: indentLine
" https://github.com/Yggdroot/indentLine
let g:indentLine_color_term=238

" Plugin: ale
let g:ale_lint_on_text_changed='ever' " only run lints when saving the files

" Plugin: ctrlp
let g:ctrlp_working_path_mode = '0'
let g:ctrlp_show_hidden=1
" let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" Plugin: emmet
let g:user_emmet_install_global=0

" Plugin: Smooth Scroll
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 25, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 25, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 25, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 25, 4)<CR>

" Plugin: quick-scope

" Change QuickScope colors to be easier to see with monokai's theme
" highlight QuickScopePrimary ctermfg=214
" highlight QuickScopeSecondary ctermfg=218

" Hide cursorline after losing window focus
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

"Netrw
" Don't add netwr buffers when jumping with <C-6>
let g:netrw_altfile = 1

autocmd BufWritePre * :call RemoveTrailingSpaces()
autocmd FileType vim,javascript let b:strip_whitespace = 1

"============================================================
" Theme
"============================================================

" forces true colour on
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"

" set termguicolors

colorscheme monotone

" Plugin: vim-monokai
" colorscheme monokai

" Change comment code color
" hi Comment ctermfg=242 ctermbg=NONE cterm=NONE guifg=#75715e guibg=NONE gui=NONE

" Change Relative Numbers column colors to match monokai's background
" highlight LineNr ctermbg=235

" Change bottom half of the background color to match monokai's background
" More info: https://stackoverflow.com/questions/18094481/changing-background-colors
" highlight NonText ctermbg=235


"============================================================
" Mappings
"============================================================

" space open/closes folds
nnoremap <space> za

inoremap <C-s> <ESC>:w<CR>
nnoremap <C-s> :w<CR>

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <leader>f :Ack<Space>


