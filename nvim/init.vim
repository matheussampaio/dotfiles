scriptencoding utf-8

" ============================================================================ "
" ===                              VIM Plug                                === "
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
" ===                               Plugins                                === "
" ============================================================================ "

" comment stuff out.
Plug 'tpope/vim-commentary'

" Change 'commentstring' according to context.
Plug 'suy/vim-context-commentstring', { 'for': 'vue' }

" provides mappings to easily delete, change and add surroundings (parantheses, brackets, quotes, etc).
Plug 'tpope/vim-surround'

" handy brackets mappings.
Plug 'tpope/vim-unimpaired'

" enable repeating supported plugin maps with '.'.
Plug 'tpope/vim-repeat'

" improvements to netrw.
" Plug 'tpope/vim-vinegar'
Plug 'justinmk/vim-dirvish'
Plug 'roginfarrer/vim-dirvish-dovish'

" continuously updated sessions files
Plug 'tpope/vim-obsession'

" lean and mean status/tabline.
Plug 'vim-airline/vim-airline'

" place, toggle and display marks.
" Plug 'kshenoy/vim-signature'

" make it easier to swap between vim and tmux.
Plug 'christoomey/vim-tmux-navigator'

" toggle quicklist and loclist.
Plug 'milkypostman/vim-togglelist'

" Intellisense engine with LSP support.
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" Monokai Tasty Colorschema.
Plug 'patstockwell/vim-monokai-tasty'

" Take notes with Wiki.
Plug 'vimwiki/vimwiki'

" auto-close brakets after pressing ENTER.
" Plug 'rstacruz/vim-closer'

" " === vim-polyglot === "
" let g:polyglot_disabled = ['typescript']

" Many syntax highlights
" Plug 'sheerun/vim-polyglot'

" TypeScript syntax highlights
" Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }

" A simple alignment operator
" Plug 'tommcdo/vim-lion'

" Speed up Vim by updating folds only when called-for.
" Plug 'Konfekt/FastFold'

" Make Vim persist editing state without fuss
Plug 'zhimsel/vim-stay'

" Git wrapper.
Plug 'tpope/vim-fugitive'

" fugitive github extension.
" Plug 'tpope/vim-rhubarb'

" Change word case, add abbreviations, and search/replace
Plug 'tpope/vim-abolish'

" Show git changes in the sign column.
Plug 'mhinz/vim-signify'

" Preview markdown with :LivePreview.
" Plug 'shime/vim-livedown', { 'on': 'LivedownPreview' }

" Provides automatic closing of quotes, parenthesis, brackets, etc.
" Plug 'Raimondi/delimitMate'

" " Syntax highlighting, matching rules and mappings for the original Markdown and extensions.
" Plug 'plasticboy/vim-markdown', { 'for': ['markdown', 'md'] }

" vim-markdown requries tabular to format tables
Plug 'godlygeek/tabular'

" " Show information about dependencies versions inside `package.json`.
" Plug 'meain/vim-package-info', { 'do': 'npm install' }

" Wrap and unwrap function arguments, lists, and dictionaires
Plug 'FooSoft/vim-argwrap'

" " " Disctraction-free writing in vim
" Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }

" Support for expanding abbreviations
Plug 'mattn/emmet-vim', { 'for': [ 'html', 'vue', 'jsx'] }

Plug 'editorconfig/editorconfig-vim'

" Treesitter configurations and abstraction layer for Neovim.
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

" Displays available keybindings in popup
Plug 'liuchengxu/vim-which-key'

call plug#end()

" ============================================================================ "
" ===                           EDITING OPTIONS                            === "
" ============================================================================ "

syntax on

" Show line number in the sign column.
set number

" Show relative line numbers.
set relativenumber

" Don't show last command.
set noshowcmd

" Leave buffer without saving
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
set scrolloff=8

" Always keep some characters before/after the current column.
set sidescroll=8

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
set viewoptions=cursor,folds,slash,unix

" Remove ~ from the left side of the window
set fillchars=eob:\ " space here is important

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

" Display characters
set list

" Display tab characters
set listchars=nbsp:·,tab:▶-

" the screen will not be redrawn while executing macros, registers and other commands that have not been typed.
set lazyredraw

" set default regexp engine
set regexpengine=1

" syntax highlighting items specify folds.
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" Set default to unfold
set foldlevel=1000

set backupdir=$HOME/.tmp

" Write swap files to disk quicker
set updatetime=300

" Display signs in the number column
set signcolumn=number

set conceallevel=1

" set blinking cursor
set guicursor+=a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor

" pop up menu height
set pumheight=10

set smartindent

" ============================================================================ "
" ===                           PLUGIN SETUP                               === "
" ============================================================================ "

" Useful variable to detect the OS
" if !exists("g:os")
"   if has("win64") || has("win32") || has("win16")
"     let g:os = "Windows"
"   else
"     let g:os = substitute(system('uname'), '\n', '', '')
"   endif
" endif

" === Vim airline ==== "
" Wrap in try/catch to avoid errors on initial install before plugin is available
try
  " Do not show current git branch
  " let g:airline#extensions#branch#enabled=0

  " Enable bufferline integration
  " let g:airline#extensions#fugitiveline#enabled=1

  " Do not draw separators for empty sections (only for the active window) >
  " let g:airline_skip_empty_sections=1

  " remove (fileencoding, fileformat) section
  let g:airline_section_y=''

  " remove (percentage, line number, column number) section
  let g:airline_section_z=''

  " hide tabs close button
  let g:airline#extensions#tabline#show_close_button=1

  " Disable vim-airline in preview mode
  let g:airline_exclude_preview=1

  " Enable powerline fonts
  " let g:airline_powerline_fonts=1

  " Enable caching of syntax highlighting groups
  let g:airline_highlighting_cache=1

  " Don't show git changes to current file in airline
  let g:airline#extensions#hunks#enabled=0
catch
endtry

" === vimwiki ==== "
let g:vimwiki_list = [{ 'path': '~/Dropbox/wiki' }]

" === Signify === "
let g:signify_sign_delete = '-'

" === Netrw === "
let g:netrw_altfile=1 " Don't add netwr buffers when jumping with <C-6>
let g:netrw_localrmdir="rm -r" " delete non-empty folders
let g:netrw_home='~/.local/share/nvim'

" === emmet.vim === "
" Change emmet key
" let g:user_emmet_leader_key='<C-E>'

" === fastfold === "
" let g:markdown_folding=1
" let g:javaScript_fold=1

" === editorconfig.vim === "
let g:EditorConfig_exclude_patterns = ['fugitive://.\*', 'scp://.\*']

" == which key ===
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

let g:which_key_floating_relative_win = 1

let g:which_key_map = {}
let g:which_key_visual_map = {}

call which_key#register('<Space>', "g:which_key_map")

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
  " Make background signcolumn background transparent
  hi! SignColumn ctermfg=NONE guibg=NONE

  " Make background color transparent for git changes
  hi! SignifySignAdd guibg=NONE
  hi! SignifySignDelete guibg=NONE
  hi! SignifySignChange guibg=NONE

  " Highlight git change signs
  hi! SignifySignAdd guifg=#99c794
  hi! SignifySignDelete guifg=#ec5f67

  " Add a little bit more contrast to LineNr
  hi! LineNr guifg=#6a6a6a

  " Errors bold read with transparent background
  hi! Error cterm=bold ctermfg=231 ctermbg=NONE gui=bold guifg=#ff005f guibg=NONE

  " Change highlight
  hi! Search guifg=peru guibg=NONE
  hi! SignifySignChange guifg=#c594c5

  hi! NormalNC guibg=#202020

  autocmd FileType json syntax match Comment +\/\/.\+$+
endfunction

augroup MyHighlights
  autocmd!
  autocmd ColorScheme * call MyHighlights()
augroup END

" Hide cursorline after losing window focus
" augroup CursorLine
"   au!
"   au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
"   au WinLeave * setlocal nocursorline
" augroup END

autocmd BufLeave * set laststatus=2

" Only apply theme if vim-monokai plugin exists
if isdirectory( expand("$HOME/.local/share/nvim/plugged/vim-monokai-tasty") )
  " forces true colour on
  " let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  " let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"

  " ???
  " set t_ZH=[3m
  " set t_ZR=[23m

  let g:vim_monokai_tasty_italic = 1

  if isdirectory( expand("$HOME/.local/share/nvim/plugged/vim-airline") )
    let g:airline_theme='monokai_tasty'
  endif

  colorscheme vim-monokai-tasty
endif

" ============================================================================ "
" ===                            Key Mappings                              === "
" ============================================================================ "

" Show keybindings
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

let g:which_key_map.aw = 'toggle-arg-warp'
nnoremap <silent> <leader>aw :ArgWrap<CR>

let g:which_key_map.ov = 'edit-vimrc'
nnoremap <leader>ov :tabnew ~/git/dotfiles/nvim/init.vim<CR>

" Ctrl+S to save the buffer
nnoremap <C-s> :w<CR>

" move visual lines
nnoremap j gj
nnoremap k gk

let g:which_key_map.v = 'paste-from-clipboard'
nnoremap <leader>v o<ESC>"+p

let g:which_key_visual_map.c = 'copy-to-clipboard'
vnoremap <leader>c "+y

let g:which_key_map.h = 'clear-search-highlight'
noremap <leader>h :nohlsearch<CR>

" By pressing ctrl+r in visual mode, you will be prompted to enter text to replace with.
" Press enter and then confirm each change you agree with y or decline with n.
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" Normally space move the cursor to the right in normal mode. Since LEADER is
" SPACE, disabling that behavior works better for me.
" nnoremap <space> <NOP>

" ============================================================================ "
" ===                               coc.nvim                               === "
" ============================================================================ "

" Install basic lists, including `files`, `mru`, `grep`, etc.
try
  call coc#add_extension('coc-css', 'coc-emmet', 'coc-html', 'coc-json', 'coc-lists', 'coc-python', 'coc-snippets', 'coc-tsserver', 'coc-vetur')

  " Got to current word definition
  nmap <silent> gd <Plug>(coc-definition)

  " Search for current work references
  nmap <silent> <leader>gr <Plug>(coc-references)

  " Open current word implementation
  nmap <silent> <leader>gi <Plug>(coc-implementation)

  " Rename current word
  nmap ,r <Plug>(coc-rename)

  " Fix current line
  nmap ,f <Plug>(coc-fix-current)

  " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
  xmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected)

  " Remap for do codeAction of current line
  nmap <leader>ac  <Plug>(coc-codeaction)

  " Use K to show documentation in preview window
  nmap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  " Use tab for trigger completion with characters ahead and navigate.
  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
  " other plugin before putting this into your config.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <c-space> to trigger completion.
  inoremap <silent><expr> <c-space> coc#refresh()

  " Use <cr> to confirk completion
  inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<C-r>=coc#on_enter()\<CR>"

  " Close the preview window when completion is done.
  autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

  " Browse most recent files
  nnoremap <silent> <leader>m :CocList mru<CR>

  " Search for a symbol in the current directory
  nnoremap <silent> <leader>cs :CocList symbols<CR>
 
  " Resumse previous list
  nnoremap <silent> <leader>r :CocResume<CR>

  " Search for a command
  nnoremap <silent> <leader>cc :CocCommand<CR>

  " Search for a term in the current directory
  nnoremap <silent> <leader>s :CocList -I grep -ignorecase<CR>

  " Browse coc commands
  nnoremap <silent> <leader>cp :CocList commands<CR>

  " Browse list of files in current directory
  nnoremap <silent> <leader>p  :CocList files<CR>

  " Trigger completion
  inoremap <silent><expr> <c-space> coc#refresh()

  " Open vim notes
  " nnoremap <leader>oc :tabnew ~/git/dotfiles/nvim/coc-settings.json<CR>

  " Use `[g` and `]g` to navigate diagnostics
  nnoremap <silent> [g <Plug>(coc-diagnostic-prev)
  nnoremap <silent> ]g <Plug>(coc-diagnostic-next)

  " Configure error/warning section to use coc.nvim
  let g:airline_section_error='%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
  let g:airline_section_warning='%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
  let g:airline_powerline_fonts=1

  let airline#extensions#coc#stl_format_err='%E{[%e(#%fe)]}'
  let airline#extensions#coc#stl_format_warn='%W{[%w(#%fw)]}'

  " Add status line support, for integration with other plugin, checkout `:h coc-status`
  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
catch
endtry

lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = {
      "bash",
      "html",
      "java",
      "javascript",
      "json",
      "markdown",
      "python",
      "typescript",
      "vim",
      "vue"
  },

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  indent = {
    enable = true
  },
}
EOF
