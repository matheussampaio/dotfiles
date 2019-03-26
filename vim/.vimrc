"============================================================
" matheussampaio's settings
"============================================================

set nocompatible
filetype off

"============================================================
" Vim Plug
"============================================================

" Install Vim Plug if folder is not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Essentials
Plug 'tpope/vim-sensible' " universal set of defaults that everyone can agree on.
Plug 'tpope/vim-commentary' " comment stuff out.
Plug 'suy/vim-context-commentstring' " sets the value of 'commentstring' depending on the region of the file.
Plug 'tpope/vim-surround' " provides mappings to easily delete, change and add surroundings (parantheses, brackets, quotes, etc).
Plug 'tpope/vim-fugitive' " git wrapper.
" Plug 'tpope/vim-apathy' " set `path` option for miscellaneous file types.
Plug 'tpope/vim-vinegar' " improvements to netrw
Plug 'vim-airline/vim-airline' " lean and mean status/tabline.
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale' " asynchronous lint engine.
Plug 'kshenoy/vim-signature' " place, toggle and display marks.
Plug 'unblevable/quick-scope' " highlights which characters to target for `f`, `F` and family.
Plug 'mileszs/ack.vim', { 'on': [] } " search files with Ack.
Plug 'jiangmiao/auto-pairs', { 'on': [] } " insert or delete brackets, parents, and quotes in pairs.
Plug 'christoomey/vim-tmux-navigator' " make it easier to swap between vim and tmux.
Plug 'milkypostman/vim-togglelist' " toggle quicklist and loclist
Plug 'simnalamburt/vim-mundo' " undo tree
Plug 'tpope/vim-obsession' " keep vim sessions up to date

" Others
Plug 'mhinz/vim-signify', { 'on': [] } " sign column to indicate added, modified and removed lines.
Plug 'airblade/vim-gitgutter' " shows a git diff in the gutter (sign column)
" Plug 'sheerun/vim-polyglot' " collection of language packs.

" Autocompletion
" Plug 'neoclide/coc.nvim' " intellisense engine with LSP support. NOTE: Requires nodejs, yarn and vim-node-rpc

" Find files, buffers, tags
" Plug 'kien/ctrlp.vim' " fuzzy file, buffer mru ttag, etc finder.
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " fuzzy string search
Plug 'junegunn/fzf.vim' " keybindings and commands for FZF

" HTML
Plug 'mattn/emmet-vim', { 'for': 'html' }

" Javascript, JSX
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" JSON
Plug 'elzr/vim-json'

" GraphQL
Plug 'jparise/vim-graphql'

" Markdown
Plug 'shime/vim-livedown', { 'for': 'markdown' } " preview markdown.

" Themes
Plug 'patstockwell/vim-monokai-tasty'

" Others
Plug 'lervag/wiki.vim'
Plug 'lervag/wiki-ft.vim'

call plug#end()

"============================================================
" Vim Plug
"============================================================

syntax on " Enable syntax highlighting.
filetype plugin on " Defines autocommands that will get executed when a file matching a given pattern is opened.

set expandtab " tab to spaces
set shiftwidth=2 " number of spaces when shift indenting
set smartindent " smart autoindenting when starting a new line
set softtabstop=2 " number of spaces in tab when editing
set tabstop=2 " number of visual spaces per tab

set wrap " changes how text is displayed
set linebreak " wrap long lines at a character in 'breakat'

set showcmd
set scrolloff=2

" backup, undo, swap files {{{
set backup
set swapfile
set undofile
set undolevels=1000
set undoreload=10000

" Create folder and set backup, undo and swp folder
silent !mkdir ~/.vim/.backup > /dev/null 2>&1
silent !mkdir ~/.vim/.undo > /dev/null 2>&1
silent !mkdir ~/.vim/.swp > /dev/null 2>&1

set backupdir=~/.vim/.backup/
set undodir=~/.vim/.undo/
set directory=~/.vim/.swp/
" }}}

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
set foldmethod=indent
set foldlevelstart=10
set relativenumber " Show relative line numbers
set hidden
set encoding=utf-8
set termguicolors
set laststatus=1


" Show invisible characters
set list
set listchars=tab:▸\ ,trail:~,extends:>,precedes:<

" Remove escape delay
set timeoutlen=1000 ttimeoutlen=0

" Open split at the right side
set splitright
set splitbelow

" =======
" Plugins
" =======

" Plugin: vim-airline
" https://github.com/vim-airline/vim-airline

let g:airline_powerline_fonts=1
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#ale#enabled=1
let g:airline_skip_empty_sections=1

" Plugin: wiki.vim
" https://github.com/lervag/wiki.vim
let g:wiki_root = '~/Dropbox/wiki'

" " Plugin: ale
" let g:ale_lint_on_text_changed='ever' " only run lints when saving the files
" let g:ale_completion_enabled=1
" let g:ale_set_signs=0

" Plugin: ctrlp
" let g:ctrlp_working_path_mode='ra'
" let g:ctrlp_show_hidden=1
" let g:ctrlp_cache_dir='~/.vim/.cache/ctrlp'
" let g:ctrlp_use_caching=1
" let g:ctrlp_custom_ignore = {
"   \ 'dir':  '\v[\/](\.git|\.idea|node_modules|coverage|Build|Pods)$',
"   \ }

" Plugin: vim-signify
let g:signify_vcs_list = [ 'git' ]

" Plugin: emmet
let g:user_emmet_install_global=0

" Hide cursorline after losing window focus
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

"Netrw
let g:netrw_altfile=1 " Don't add netwr buffers when jumping with <C-6>
let g:netrw_localrmdir="rm -r" " delete non-empty folders

autocmd BufWritePre * :call RemoveTrailingSpaces()
autocmd FileType vim,javascript,typescript let b:strip_whitespace=1 " only remove empty spaces for those filetypes

"============================================================
" Theme
"============================================================

" Only apply theme if vim-monokai plugin exists
if isdirectory( expand("$HOME/.vim/plugged/vim-monokai-tasty") )
  " forces true colour on
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"

  let g:vim_monokai_tasty_italic = 1

  if isdirectory( expand("$HOME/.vim/plugged/vim-airline") )
    let g:airline_theme='monokai_tasty'
      " let g:airline_theme='base16_monokai'
  endif

  colorscheme vim-monokai-tasty

  " " Change Relative Numbers column colors to match monokai's background
  " highlight clear LineNr
  " highlight LineNr ctermfg=245

  " highlight clear SignColumn

  " " Change bottom half of the background color to match monokai's background
  " " More info: https://stackoverflow.com/questions/18094481/changing-background-colors
  " highlight clear NonText
  " highlight NonText ctermfg=235

  " hi TabLineFill ctermfg=231 ctermbg=235 cterm=NONE guifg=NONE guibg=NONE gui=NONE
  " hi TabLine ctermfg=242 ctermbg=235 cterm=NONE guifg=NONE guibg=NONE gui=NONE
endif


"============================================================
" Mappings
"============================================================

" space open/closes folds
" nnoremap <space> za

" Ctrl+S to save the buffer
" inoremap <C-s> <ESC>:w<CR>
" nnoremap <C-s> :w<CR>

" navigate between splits
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" By pressing ctrl+r in visual mode, you will be prompted to enter text to replace with.
" Press enter and then confirm each change you agree with y or decline with n.
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" \ + l to searc for lines
noremap <leader>f :Lines<CR>
" \ + f to search for files
noremap <leader>f :Files<CR>
" \ + b to search for buffers
noremap <leader>b :Buffers<CR>

" Auto reload .vimrc
augroup myvimrc
    au!
    au BufWritePost .vimrc so $MYVIMRC
augroup END
