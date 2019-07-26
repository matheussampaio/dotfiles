scriptencoding utf-8

" " ============================================================================ "
" " ===                              VIM Plug                                === "
" " ============================================================================ "

" check whether vim-plug is installed and install it if necessary
let plugpath = expand('<sfile>:p:h'). '/autoload/plug.vim'
if !filereadable(plugpath)
    if executable('curl')
        let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        call system('curl -fLo ' . shellescape(plugpath) . ' --create-dirs ' . plugurl)
        if v:shell_error
            echom "Error downloading vim-plug. Please install it manually.\n"
            exit
        endif
    else
        echom "vim-plug not installed. Please install it manually or install curl.\n"
        exit
    endif
endif

call plug#begin('~/.local/share/nvim/plugged')

" " ============================================================================ "
" " ===                               Plugins                                === "
" " ============================================================================ "

" " === Essentials === "
" comment stuff out.
Plug 'tpope/vim-commentary'

" sets the value of 'commentstring' depending on the region of the file.
Plug 'suy/vim-context-commentstring', { 'for': 'javascript.jsx' }

" provides mappings to easily delete, change and add surroundings (parantheses, brackets, quotes, etc).
Plug 'tpope/vim-surround'

" fugitive github extension.
Plug 'tpope/vim-rhubarb'

" handy brackets mappings.
Plug 'tpope/vim-unimpaired'

" enable repeating supported plugin maps with '.'.
Plug 'tpope/vim-repeat'

" improvements to netrw.
Plug 'tpope/vim-vinegar'

" lean and mean status/tabline.
Plug 'vim-airline/vim-airline'

" place, toggle and display marks.
Plug 'kshenoy/vim-signature'

" make it easier to swap between vim and tmux.
Plug 'christoomey/vim-tmux-navigator'

" toggle quicklist and loclist.
Plug 'milkypostman/vim-togglelist'

" Trailing whitespace highlighting & automatic fixing.
Plug 'ntpeters/vim-better-whitespace'

" Intellisense engine with LSP support.
Plug 'neoclide/coc.nvim', { 'tag': '*', 'do': './install.sh' }

" Monokai Tasty Colorschema.
Plug 'patstockwell/vim-monokai-tasty'

" Take notes with Wiki.
Plug 'vimwiki/vimwiki'

" auto-close brakets after pressing ENTER.
Plug 'rstacruz/vim-closer'

" Many syntax highlights
Plug 'sheerun/vim-polyglot'

" Display colors inline
Plug 'RRethy/vim-hexokinase', { 'on': 'HexokinaseToggle' }

" A simple alignment operator
Plug 'tommcdo/vim-lion'

" Speed up Vim by updating folds only when called-for.
Plug 'Konfekt/FastFold'

" Make Vim persist editing state without fuss
Plug 'zhimsel/vim-stay'

" " === Git Plugins === "
" Git wrapper.
Plug 'tpope/vim-fugitive'

" Show git changes in the sign column.
Plug 'mhinz/vim-signify'

" Efficient way of using Vim as Git mergetool
Plug 'samoshkin/vim-mergetool'

" " === Markdown Plugins === "
" Preview markdown with :LivePreview.
Plug 'shime/vim-livedown', { 'for': 'markdown' }

" Syntax highlighting, matching rules and mappings for the original Markdown and extensions.
Plug 'plasticboy/vim-markdown', { 'for': ['markdown', 'md'] }

" ReactJS JSX syntax highlighting
Plug 'mxw/vim-jsx', { 'for': 'javascript' }

" Show information about dependencies versions inside `package.json`.
Plug 'meain/vim-package-info', { 'for': 'javascript', 'do': 'npm install' }

" Wrap and unwrap function arguments, lists, and dictionaires
Plug 'FooSoft/vim-argwrap'

" Disctraction-free writing in vim
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }

" Jekyll utils
Plug 'parkr/vim-jekyll'

" Support for expanding abbreviations
Plug 'mattn/emmet-vim', { 'for': ['javascript', 'jsx', 'html'] }

call plug#end()

" " ============================================================================ "
" " ===                           EDITING OPTIONS                            === "
" " ============================================================================ "

" Show line number in the sign column.
set number

" Show relative line numbers.
set relativenumber

" Don't show last command.
set noshowcmd

" Hides buffers instead of closing them.
set hidden

" Insert spaces when TAB is pressed.
set expandtab

" Change number of spaces that a <Tab> counts for during editing ops.
set softtabstop=2

" Indentation amount for < and > commands.
set shiftwidth=2

" Wrap long lines by default.
set wrap

" Disable line/column number in status line.
" Shows up in preview window when airline is disabled if not.
set noruler

" Only one line for command line.
set cmdheight=1

" Don't give completion messages like 'match 1 of 2' or 'The only match'.
set shortmess+=c

" Always keep some lines before/after the current line when scrolling.
set scrolloff=2

" Always keep some characters before/after the current column.
set sidescroll=5

" ignore case when searching.
set ignorecase

" if the search string has an upper case letter in it, the search will be case sensitive.
set smartcase

" Show the effects of a command incrementally, as you type
set inccommand=nosplit

" Automatically re-read file if a change was detected outside of vim.
set autoread

" Disable swap files.
set noswapfile

" Enable persistent undo.
set undofile
set undolevels=3000
set undoreload=10000

" Create vertical splits to the ride of the current split.
set splitright

" Create horizontal splits below the current split.
set splitbelow

" Don't dispay mode in command line (airilne already shows it).
set noshowmode

" Enable true colors support.
set termguicolors

" Start in nopaste mode.
set nopaste

" Save fold and cursor positions to viewfile.
set viewoptions=folds,cursor,slash,unix

" Load local .nvimrc (:h exrc).
set exrc

" Avoid trojan horses when loading local .nvimrc (:h trojan-horse).
set secure

" Start diffmode with vertical splits.
set diffopt+=vertical

" Disable bells.
set visualbell

" Change leader to SPACE.
let mapleader=" "

" Display tab characters
set list
set listchars=nbsp:·,tab:▶-

" the screen will not be redrawn while executing macros, registers and other commands that have not been typed.
set lazyredraw

" set default regexp engine
set regexpengine=1

" Syntax highlighting items specify folds.
set foldmethod=syntax

" Set default to unfold
set foldlevel=1000

" " ============================================================================ "
" " ===                           PLUGIN SETUP                               === "
" " ============================================================================ "

" " === Vim airline ==== "
" Wrap in try/catch to avoid errors on initial install before plugin is available
try

" Do not show current git branch
let g:airline#extensions#branch#enabled=0

" Do not draw separators for empty sections (only for the active window) >
let g:airline_skip_empty_sections=1

" remove (fileencoding, fileformat) section
let g:airline_section_y=''

" remove (percentage, line number, column number) section
let g:airline_section_z=''

let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'
let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'

" Configure error/warning section to use coc.nvim
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

" Disable vim-airline in preview mode
let g:airline_exclude_preview = 1

" Enable powerline fonts
let g:airline_powerline_fonts = 0

" Enable caching of syntax highlighting groups
let g:airline_highlighting_cache = 1

" Don't show git changes to current file in airline
let g:airline#extensions#hunks#enabled=0

catch
  echo 'Airline not installed. It should work after running :PlugInstall'
endtry

" " === vimwiki ==== "
let g:vimwiki_list = [{ 'path': '~/Dropbox/wiki' }]

" " === Signify === "
let g:signify_sign_delete = '-'

" " === Netrw === "
let g:netrw_altfile=1 " Don't add netwr buffers when jumping with <C-6>
let g:netrw_localrmdir="rm -r" " delete non-empty folders

" " === vim jsx === "
" Only enable jsx for files with `.jsx` extension
let g:jsx_ext_required = 1

" " === vim-hexokinase === "
" Display colors as virtual text
let g:Hexokinase_highlighters = ['virtual']

" " === coc.nvim === "
" Install basic lists, including `files`, `mru`, `grep`, etc.
call coc#add_extension('coc-lists', 'coc-snippets')

" " === emmet.vim === "
" Change emmet key
let g:user_emmet_leader_key='<C-E>'

" " === fastfold === "
let g:markdown_folding=1
let g:javaScript_fold=1

" " ============================================================================ "
" " ===                                UI                                    === "
" " ============================================================================ "

" Use dark background
set background=dark

" Add custom highlights in method that is executed every time a
" colorscheme is sourced
" See https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f for
" details
function! MyHighlights() abort
  " Make background signcolumn background transparent
  hi! SignColumn ctermfg=NONE guibg=NONE

  " Make background color transparent for git changes
  hi! SignifySignAdd guibg=NONE
  hi! SignifySignDelete guibg=NONE
  hi! SignifySignChange guibg=NONE

  " Highlight git change signs
  hi! SignifySignAdd guifg=#99c794
  hi! SignifySignDelete guifg=#ec5f67
  hi! SignifySignChange guifg=#c594c5
endfunction

augroup MyHighlights
  autocmd!
  autocmd ColorScheme * call MyHighlights()
augroup END

" Hide cursorline after losing window focus
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" Only apply theme if vim-monokai plugin exists
if isdirectory( expand("$HOME/.local/share/nvim/plugged/vim-monokai-tasty") )
  " forces true colour on
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"

  let g:vim_monokai_tasty_italic = 1

  if isdirectory( expand("$HOME/.local/share/nvim/plugged/vim-airline") )
    let g:airline_theme='monokai_tasty'
  endif

  colorscheme vim-monokai-tasty

  " Add a little bit more contrast to LineNr
  hi! LineNr guifg=#6a6a6a

  " Errors bold read with transparent background
  hi! Error cterm=bold ctermfg=231 ctermbg=NONE gui=bold guifg=#ff005f guibg=NONE

  " Hide End Of Buffer tilde
  hi! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg
endif

" " ============================================================================ "
" " ===                            Key Mappings                              === "
" " ============================================================================ "

" " === coc.nvim === "
" Got to current word definition
nmap <silent> <leader>cd <Plug>(coc-definition)
" Search for current work references
nmap <silent> <leader>ce <Plug>(coc-references)
" Open current word implementation
nmap <silent> <leader>ci <Plug>(coc-implementation)
" Rename current word
nmap <silent> <leader>cr <Plug>(coc-rename)
" Fix current line
nmap <silent> <leader>cf <Plug>(coc-fix-current)
" Browse list of files in current directory
nmap <silent> <C-p> :CocList files<CR>
" Browse most recent files
nmap <silent> <leader>cb :CocList mru<CR>
" Search for a symbol in the current directory
nmap <silent> <leader>cs :CocList symbols<CR>
" Search for a term in the current directory
nmap <silent> <leader>f :CocList -I grep -ignorecase<CR>
" Browse CoC commands
nmap <silent> <leader>cp :CocList commands<CR>
" Trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" " === vim-better-whitespace === "
" Automatically remove trailing whitespace
nmap <leader>as :StripWhitespace<CR>

" " === vim hexokinase === "
" Toggle show colors beside colors hex, rgb, rgba, etc.
nmap <leader>ac :HexokinaseToggle<CR>

" " === Vim Plug === "
" Run Plug Status
nnoremap <leader>ps :PlugStatus<CR>
" Run Plug Install
nnoremap <leader>pi :PlugInstall<CR>
" Run Plug Update
nnoremap <leader>pu :PlugUpdate<CR>

" " === Vim ArgWrap === "
" Toggle argwrap
nnoremap <silent> <leader>aw :ArgWrap<CR>

" " === Vim Fugitive === "
" Open GStatus in a new tab
nnoremap <leader>gs :G<CR>
" Git push
nnoremap <leader>gp :Gpush<CR>
" Git checkout branch
nnoremap <leader>gcb :Git checkout -b<space>
" Git pull
nnoremap <leader>gl :Gpull<CR>

" " === vim-mergetool === "
let g:mergetool_layout = 'bmr'
let g:mergetool_prefer_revision = 'local'

nmap <leader>mt <plug>(MergetoolToggle)

" " === Others === "
" Open dotfiles
nnoremap <leader>od :Ex ~/git/dotfiles<CR>
" Open .vimrc
nnoremap <leader>ov :tabnew ~/git/dotfiles/nvim/init.vim<CR>
" Open .tmux.conf
nnoremap <leader>ot :tabnew ~/.tmux.conf<CR>
" Open .zshrc
nnoremap <leader>oz :tabnew ~/.zshrc<CR>
" Open vim notes
nnoremap <leader>on :tabnew ~/Dropbox/wiki/Notes.wiki<CR>
" Open vim notes
nnoremap <leader>oc :tabnew ~/git/dotfiles/nvim/coc-settings.json<CR>

" Ctrl+S to save the buffer
nnoremap <C-s> :w<CR>

" Update buffers
nnoremap <leader>u :checktime<CR>

" Debug hightlight group
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
  \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
  \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" help transitions
nnoremap <leader>p :echo "Use \f"<CR>

" move visual lines
nnoremap j gj
nnoremap k gk

" Paste from "+ (system) register
nnoremap <leader>v o<ESC>"+p

" Copy selection to "+ (system) register
vnoremap <leader>c "+y

" Clear highlighted search terms while preserving history
noremap <Leader>h :nohlsearch<CR>

" By pressing ctrl+r in visual mode, you will be prompted to enter text to replace with.
" Press enter and then confirm each change you agree with y or decline with n.
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" Normally space move the cursor to the right in normal mode. Since LEADER is
" SPACE, disabling that behavior works better for me.
nnoremap <space> <NOP>

" Git diff keybindings
nnoremap <silent> <leader>gdh :diffget //2<CR>
nnoremap <silent> <leader>gdl :diffget //3<CR>
