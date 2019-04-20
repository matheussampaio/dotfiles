scriptencoding utf-8

" ============================================================================ "
"                                   VIM Plug                                   "
" ============================================================================ "

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

" ============================================================================ "
"                                   Plugins                                    "
" ============================================================================ "

" Essentials
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
Plug 'neoclide/coc.nvim', { 'tag': '*', 'do': { -> coc#util#install()} }

" Denite - Fuzzy finding, buffer management
Plug 'Shougo/denite.nvim'

" CtrlP matcher to improve file listing
Plug 'nixprime/cpsm', { 'do': './install.sh' }

" Monokai Tasty Colorschema.
Plug 'patstockwell/vim-monokai-tasty'

" Take notes with Wiki.
Plug 'lervag/wiki.vim'
Plug 'lervag/wiki-ft.vim'

" auto-close brakets after pressing ENTER.
Plug 'rstacruz/vim-closer'

" Many syntax highlights
Plug 'sheerun/vim-polyglot'

" Display colors inline
Plug 'RRethy/vim-hexokinase'

" === Git Plugins === "
" Git wrapper.
Plug 'tpope/vim-fugitive'

" Show git changes in the sign column.
Plug 'mhinz/vim-signify'

" === Markdown Plugins === "
" Preview markdown with :LivePreview.
Plug 'shime/vim-livedown', { 'for': 'markdown' }

" === Javascript Plugins === "
" Typescript syntax highlighting
Plug 'HerringtonDarkholme/yats.vim'

" ReactJS JSX syntax highlighting
Plug 'mxw/vim-jsx'

" Improved syntax highlighting and indentation
Plug 'othree/yajs.vim'

" Show information about dependencies versions inside `package.json`.
Plug 'meain/vim-package-info', { 'do': 'npm install' }

call plug#end()

" ============================================================================ "
" ===                           EDITING OPTIONS                            === "
" ============================================================================ "

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
set viewoptions=folds,cursor

" Automatically save/load viewfiles.
augroup AutoSaveFolds
  autocmd!
  autocmd BufWinLeave,BufLeave,BufWritePost ?* nested silent! mkview!
  autocmd BufWinEnter ?* silent! loadview
augroup end

" Load local .nvimrc (:h exrc).
set exrc

" Avoid trojan horses when loading local .nvimrc (:h trojan-horse).
set secure

" ============================================================================ "
" ===                           PLUGIN SETUP                               === "
" ============================================================================ "

" Wrap in try/catch to avoid errors on initial install before plugin is available
" try
" === Denite setup ==="
" Use ripgrep for searching current directory for files
" By default, ripgrep will respect rules in .gitignore
"   --files: Print each file that would be searched (but don't search)
"   --glob:  Include or exclues files for searching that match the given glob
"            (aka ignore .git files)
"
call denite#custom#var('file/rec', 'command', ['rg', '--files', '--hidden', '-g', '!.git', '-g', '!*.{png,jpg,lock}'])
call denite#custom#source('file/rec', 'matchers', ['matcher/cpsm'])

" Use ripgrep in place of "grep"
call denite#custom#var('grep', 'command', ['rg', '-g', '!{yarn.lock,package-lock.json}'])

" Custom options for ripgrep
"   --vimgrep:  Show results with every match on it's own line
"   --hidden:   Search hidden directories and files
"   --heading:  Show the file name above clusters of matches from each file
"   --S:        Search case insensitively if the pattern is all lowercase
call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S'])

" Recommended defaults for ripgrep via Denite docs
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Remove date from buffer list
call denite#custom#var('buffer', 'date_format', '')

call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>', 'noremap')

call denite#custom#option('default', 'auto_resize', 1)
call denite#custom#option('default', 'statusline', 0)
call denite#custom#option('default', 'statusline', 0)

" catch
"   echo 'Denite not installed. It should work after running :PlugInstall'
" endtry

" === Coc.nvim === "
" use <tab> for trigger completion and navigate to next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

"Close preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" === NeoSnippet === "
" Map <C-k> as shortcut to activate snippet if available
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" === Vim airline ==== "
" Wrap in try/catch to avoid errors on initial install before plugin is available
try

" Enable extensions
let g:airline_extensions = ['branch', 'hunks', 'coc']

" Do not draw separators for empty sections (only for the active window) >
let g:airline_skip_empty_sections = 1

" Smartly uniquify buffers names with similar filename, suppressing common parts of paths.
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Custom setup that removes filetype/whitespace from default vim airline bar
let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'warning', 'error']]

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

" === Wiki Vim ==== "
let g:wiki_root = '~/Dropbox/wiki'

" === Signify === "
let g:signify_sign_delete = '-'

" === Emmet === "
" let g:user_emmet_install_global=0

" === Netrw === "
let g:netrw_altfile=1 " Don't add netwr buffers when jumping with <C-6>
let g:netrw_localrmdir="rm -r" " delete non-empty folders

" === coc.nvim === "
let g:coc_start_at_startup=0

" === vim jsx === "
" Only enable jsx for files with `.jsx` extension
let g:jsx_ext_required = 1

" === vim-hexokinase === "
" Display colors as virtual text
let g:Hexokinase_highlighters = ['virtual']

" ============================================================================ "
" ===                                UI                                    === "
" ============================================================================ "

" Use dark background
set background=dark

" Add custom highlights in method that is executed every time a
" colorscheme is sourced
" See https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f for
" details
function! MyHighlights() abort
  " Add a little bit more contrast to LineNr
  hi! LineNr guifg=#6a6a6a

  " Make background signcolumn background transparent
  hi! SignColumn ctermfg=NONE guibg=NONE

  " Hide End Of Buffer tilde
  hi! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg

  " Make background color transparent for git changes
  hi! SignifySignAdd guibg=NONE
  hi! SignifySignDelete guibg=NONE
  hi! SignifySignChange guibg=NONE

  " Highlight git change signs
  hi! SignifySignAdd guifg=#99c794
  hi! SignifySignDelete guifg=#ec5f67
  hi! SignifySignChange guifg=#c594c5
endfunction

augroup MyColors
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
endif

" ============================================================================ "
" ===                            Key Mappings                              === "
" ============================================================================ "

" === Denite shorcuts === "

" Browser currently open buffers
nmap <silent> <leader>b :Denite buffer<CR>

" Browse list of files in current directory
nmap <silent> <leader>f :Denite file/rec -winheight=5<CR>

" Search current directory for occurences of given term and close window if no results
nnoremap <silent> <leader>s :<C-u>Denite grep:. -no-empty -mode=normal<CR>

" Search current directory for occurences of word under cursor
nnoremap <silent> <leader>w :<C-u>DeniteCursorWord grep:. -mode=normal<CR>

" === search shortcuts === "
" Clear highlighted search terms while preserving history
noremap <Leader>h :nohlsearch<CR>

" By pressing ctrl+r in visual mode, you will be prompted to enter text to replace with.
" Press enter and then confirm each change you agree with y or decline with n.
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" === coc.nvim === "
nmap <silent> <leader>cd <Plug>(coc-definition)
nmap <silent> <leader>ce <Plug>(coc-references)
nmap <silent> <leader>ci <Plug>(coc-implementation)
nmap <silent> <leader>cr <Plug>(coc-rename)
nmap <silent> <leader>cf <Plug>(coc-fix-current)

" === vim-better-whitespace === "
" Automatically remove trailing whitespace
nmap <leader>uw :StripWhitespace<CR>

" === vim hexokinase === "
" Toggle show colors beside colors hex, rgb, rgba, etc.
nmap <leader>uc :HexokinaseToggle<CR>

" === Open common used files === "
" Open .vimrc
nnoremap <silent> <leader>gv :e $MYVIMRC<CR>
" Open .tmux.conf
nnoremap <silent> <leader>gt :e ~/.tmux.conf<CR>
" Open .zshrc
nnoremap <silent> <leader>gz :e ~/.zshrc<CR>
" Open vim notes
nnoremap <silent> <leader>gn :e ~/Dropbox/wiki/Notes.wiki<CR>

" === System Clipboard === "
" Paste from "+ (system) register
nnoremap <leader>v o<ESC>"+p

" Copy selection to "+ (system) register
vnoremap <leader>c "+y

" === Vim Plug === "
" Run Plug Status
nnoremap <leader>ps :PlugStatus<CR>
" Run Plug Install
nnoremap <leader>pi :PlugInstall<CR>
" Run Plug Update
nnoremap <leader>pu :PlugUpdate<CR>

" === others === "
" Ctrl+S to save the buffer
nnoremap <C-s> :w<CR>

" Debug hightlight group
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
