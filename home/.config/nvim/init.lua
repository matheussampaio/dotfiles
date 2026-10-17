-- Enable number columns.
vim.o.number = true
vim.o.relativenumber = true

vim.o.foldlevel = 9999
vim.o.foldlevelstart = 9999
vim.o.foldenable = true
vim.o.foldmethod = 'indent'

-- only save cursor and folds in view sessions
vim.opt.viewoptions = { 'cursor', 'folds' }

-- -- Show tabline is more than one tab exists
-- vim.o.showtabline = 1

-- Insert spaces when TAB is pressed.
vim.o.expandtab = true

-- Enable true colors support.
vim.o.termguicolors = true

-- Change number of spaces that a <Tab> counts for during editing ops.
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

-- Disable line/column number in status line.
-- Shows up in preview window when airline is disabled if not.
vim.o.ruler = false

-- enable conceal
vim.o.conceallevel = 1

-- Don't give completion messages like 'match 1 of 2' or 'The only match'.
vim.o.shortmess = vim.o.shortmess .. 'c'

-- scroll by screen line.
vim.o.smoothscroll = true

-- Always keep some lines before/after the current line when scrolling.
vim.o.scrolloff = 4

-- Always keep some characters before/after the current column.
vim.o.sidescroll = 4

-- ignore case when searching.
vim.o.ignorecase = true

-- if the search string has an upper case letter in it, the search will be case sensitive.
vim.o.smartcase = true

-- Disable swap files.
vim.o.swapfile = false

-- Enable persistent undo.
vim.o.undofile = true
vim.o.undolevels = 3000
vim.o.undoreload = 10000

-- Faster cursorhold events
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
-- vim.opt.timeoutlen = 300

-- Create vertical splits to the ride of the current split.
vim.o.splitright = true

-- Create horizontal splits below the current split.
vim.o.splitbelow = true

-- Don't display mode in command line (airline already shows it).
vim.o.showmode = false

-- Remove ~ from the left side of the window
vim.o.fillchars = 'eob: '

-- Disable bells.
vim.o.visualbell = true

-- Display characters
vim.o.list = true

-- Display tab characters
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Display signs in the number column
vim.o.signcolumn = 'yes'

-- Highlight cursor line
vim.o.cursorline = true

vim.o.completeopt = 'menu,menuone,noinsert,preview'

-- wraps line at last word
vim.o.linebreak = true

-- Enable break indent
vim.o.breakindent = true

if vim.fn.filereadable(vim.fn.expand('$XDG_CONFIG_HOME/theme')) > 0 then
  vim.cmd('let &background = readfile(glob("$XDG_CONFIG_HOME/theme"))[0]')
else
  vim.o.background = 'dark'
end

-- disable ruby and perl providers, see :checkhealth
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
-- Change leader to SPACE.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Normally space move the cursor to the right in normal mode. Since LEADER is
-- SPACE, disabling that behavior works better for me.
vim.keymap.set({ 'n', 'v' }, '<Space>', '<NOP>', { silent = true })

vim.keymap.set('n', '<Leader>ui', function()
  vim.cmd([[function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
        echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
    endfun
    ]])
end, { desc = 'Show highlight under cursor' })

-- Quick ways to get to MYVIMRC
vim.keymap.set('n', '<Leader>uv', ':edit $MYVIMRC<CR>', { silent = true, desc = 'Edit $MYVIMRC' })
vim.keymap.set('n', '<Leader>ut', ':tabnew $MYVIMRC<CR>', { silent = true, desc = 'Edit $MYVIMRC in a new tab' })

-- Erase search highlight
vim.keymap.set('n', '<Leader>uh', ':nohlsearch<CR>', { silent = true, desc = 'Remove search highlight' })

-- Ctrl + S to save the buffer
vim.keymap.set('n', '<C-s>', ':w<CR>', { silent = true, desc = 'Save current file' })

-- Move visual lines
vim.keymap.set('n', 'k', 'v:count == 0 ? "gk" : "k"', { expr = true })
vim.keymap.set('n', 'j', 'v:count == 0 ? "gj" : "j"', { expr = true })

-- Paste from clipboard
vim.keymap.set('n', '<Leader>v', 'o<ESC>"+p', { desc = 'Paste from clipboard' })
vim.keymap.set('x', '<Leader>v', '"+p', { desc = 'Paste from clipboard' })

-- Save to clipboard
vim.keymap.set('v', '<Leader>c', '"+y', { desc = 'Copy to clipboard' })

-- By pressing ctrl+r in visual mode, you will be prompted to enter text to replace with.
-- Press enter and then confirm each change you agree with y or decline with n.
vim.keymap.set('v', '<C-r>', '"hy:%s/<C-r>h//gc<left><left><left>', { desc = 'Replace current selection' })

-- Map <Esc> to exit terminal-mode.
vim.keymap.set('t', '<Esc>', '<C-\\><C-N>', { desc = 'Leave terminal insert mode' })

-- Highlights the yanked text.
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight yanked text',
  group = vim.api.nvim_create_augroup('HilightTextYank', { clear = true }),
  pattern = { '*' },
  callback = function()
    vim.hl.on_yank({ higroup = 'IncSearch', timeout = 500 })
  end,
})

vim.api.nvim_create_autocmd({ 'WinEnter', 'FocusGained' }, {
  desc = 'Show the cursorline whenever the window gain focus',
  group = vim.api.nvim_create_augroup('ShowCursorLineWhenLoseFocus', { clear = true }),
  pattern = { '*' },
  callback = function()
    vim.o.cursorline = true
  end,
})

vim.api.nvim_create_autocmd({ 'WinLeave', 'FocusLost' }, {
  desc = 'Hide the cursorline whenever the window loses focus',
  group = vim.api.nvim_create_augroup('HideCursorLineWhenLoseFocus', { clear = true }),
  pattern = { '*' },
  callback = function()
    vim.o.cursorline = false
  end,
})

vim.keymap.set('n', '<Leader>ui', function()
  vim.cmd([[
    for i1 in synstack(line("."), col("."))
        let i2 = synIDtrans(i1)
        let n1 = synIDattr(i1, "name")
        let n2 = synIDattr(i2, "name")
        echo n1 "->" n2
    endfor
    ]])
end, { desc = 'Show highlight groups under cursor' })

-- Add custom highlights in method that is executed every time a colorscheme is sourced.
-- See https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f for details
local override_highlights = function()
  -- Change highlight
  vim.api.nvim_set_hl(0, 'Search', { bg = 'NONE', fg = 'peru', bold = true })

  -- gray
  vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg = 'NONE', fg = '#808080', strikethrough = true })
  -- blue
  vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg = 'NONE', fg = '#569CD6' })
  vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { bg = 'NONE', fg = '#569CD6' })
  -- light blue
  vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg = 'NONE', fg = '#9CDCFE' })
  vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { bg = 'NONE', fg = '#9CDCFE' })
  vim.api.nvim_set_hl(0, 'CmpItemKindText', { bg = 'NONE', fg = '#9CDCFE' })
  -- pink
  vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg = 'NONE', fg = '#C586C0' })
  vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { bg = 'NONE', fg = '#C586C0' })
  -- front
  vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg = 'NONE', fg = '#D4D4D4' })
  vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { bg = 'NONE', fg = '#D4D4D4' })
  vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { bg = 'NONE', fg = '#D4D4D4' })

  -- Merges Comment and CursorLine to create GitBlame
  local CommentHighlight = vim.api.nvim_get_hl(0, { name = 'Comment', link = false })
  local CursorLineHighlight = vim.api.nvim_get_hl(0, { name = 'CursorLine', link = false })
  vim.api.nvim_set_hl(0, 'GitBlame', vim.tbl_extend('force', {}, CommentHighlight, CursorLineHighlight))

  vim.cmd([[
    hi! SignColumn ctermfg=NONE guibg=NONE

    hi! SignifySignAdd guibg=NONE
    hi! SignifySignDelete guibg=NONE
    hi! SignifySignChange guibg=NONE

    hi! default link Operator GruvboxFg0

    hi! default link WhichKey GruvboxYellowBold
    hi! default link WhichKeyGroup GruvboxBlueBold
    hi! default link WhichKeyDesc GruvboxFg1
    hi! default link WhichKeySeperator GruvboxFg4
    hi! default link WhichKeyFloat GruvboxBg0
    hi! default link WhichKeyValue GruvboxFg4

    hi! default link DiagnosticError GruvboxRed
    hi! default link DiagnosticWarn GruvboxYellow
    hi! default link DiagnosticInfo GruvboxBlue
    hi! default link DiagnosticHint GruvboxAqua

    hi! default link JournalTodo GruvboxFg0
    hi! default link JournalDone GruvboxFg4
    hi! default link JournalEvent GruvboxYellow
    hi! default link JournalNote GruvboxBlue
    hi! default link JournalMoved GruvboxFg4
    hi! default link JournalCancelled htmlStrike

    hi! default LspReferenceText gui=bold,underline cterm=bold,underline
    hi! default LspReferenceRead gui=bold,underline cterm=bold,underline
    hi! default LspReferenceWrite gui=bold,underline cterm=bold,underline
    ]])
end

-- set custom browserx viewer to open links inside ssh connection in the host
if vim.fn.getenv('SSH_CONNECTION') ~= vim.NIL then
  vim.g.netrw_browsex_viewer = 'ssh-open-firefox'
end

-- Call override_highlights after color schema is set.
vim.api.nvim_create_autocmd('ColorScheme', {
  desc = 'Reload custom highlight overrides',
  group = vim.api.nvim_create_augroup('ColorSchemeOverrides', { clear = true }),
  pattern = { '*' },
  callback = override_highlights,
})

-- Auto save files
vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost' }, {
  desc = 'Auto save files',
  callback = function()
    if vim.bo.modified and not vim.bo.readonly and vim.fn.expand('%') ~= '' and vim.bo.buftype == '' then
      vim.api.nvim_command('silent update')

      if vim.bo.filetype == 'vimwiki' then
        vim.cmd(':Vimwiki2HTML')
        vim.cmd(':VimwikiRebuildTags')
      end
    end
  end,
})

local ns_epoch_datetime = vim.api.nvim_create_namespace('EpochToDatetime')

local function epoch_to_virtual_text()
  vim.api.nvim_buf_del_extmark(vim.api.nvim_get_current_buf(), ns_epoch_datetime, 1)

  local epoch = vim.api.nvim_get_current_line():match('%d%d%d%d%d%d%d%d%d%d')

  if epoch ~= nil then
    vim.api.nvim_buf_set_extmark(vim.api.nvim_get_current_buf(), ns_epoch_datetime, vim.fn.getcurpos()[2] - 1, 0, {
      id = 1,
      virt_text = {
        { os.date('%Y-%m-%d %H:%M:%S', tonumber(epoch)), 'GitBlame' },
      },
    })
  end
end

vim.keymap.set('v', '<Leader>ue', epoch_to_virtual_text, { desc = 'Transform EPOCH to Datetime' })

-- Highlights the yanked text.
vim.api.nvim_create_autocmd('CursorHold', {
  desc = 'Transform EPOCH to Datetime',
  group = vim.api.nvim_create_augroup('Epoch2Datetime', { clear = true }),
  pattern = { '*' },
  callback = epoch_to_virtual_text,
})

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local plugins = {
  'nvim-lua/plenary.nvim',

  'nvim-tree/nvim-web-devicons',

  -- Gruvbox Colorschema.
  {
    'morhetz/gruvbox',
    lazy = false,
    priority = 1000,
    init = function()
      vim.g.gruvbox_italic = 1
      vim.g.gruvbox_bold = 1
      vim.g.gruvbox_undercul = 1
      vim.g.gruvbox_underline = 1
      vim.g.gruvbox_invert_selection = 0
    end,
    config = function()
      vim.cmd('colorscheme gruvbox')
    end,
  },

  --  handy brackets mappings.
  'tpope/vim-unimpaired',

  -- Change word case, add abbreviations, and search/replace.
  'tpope/vim-abolish',

  -- Enable repeating supported plugin maps with '.'.
  'tpope/vim-repeat',

  -- Continuously updated session files
  'tpope/vim-obsession',

  -- Provides additional text objects
  'wellle/targets.vim',

  -- Make Vim persist editing state without fuss.
  'zhimsel/vim-stay',

  -- Place, toggle and display marks.
  'kshenoy/vim-signature',

  -- move outside vim to another tmux pane easily
  'christoomey/vim-tmux-navigator',

  -- Provides mappings to easily delete, change and add surroundings (parentheses, brackets, quotes, etc).
  { 'kylechui/nvim-surround', opts = {} },

  -- simple directory tree viewer
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('oil').setup({
        skip_confirm_for_simple_edits = true,
        view_options = {
          show_hidden = true,
        },
        keymaps = {
          ['<C-s>'] = false,
          -- ['<C-h>'] = false,
        },
      })

      vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    end,
  },


  -- Show git changes in the sign column.
  {
    'mhinz/vim-signify',
    init = function()
      vim.g.signify_sign_delete = '-'
    end,
  },

  {
    'tpope/vim-fugitive',
    dependencies = {
      -- Git commit browser.
      {
        'junegunn/gv.vim',
        config = function()
          vim.keymap.set('n', '<Leader>gl', ':GV<CR>', { silent = true, desc = 'Git log tree' })
          vim.keymap.set('n', '<Leader>ga', ':GV --all<CR>', { silent = true, desc = 'Git log tree --all' })
        end,
      },

      -- Enables :GBrowse from fugitive.vim to open GitHub URLs.
      {
        'tpope/vim-rhubarb',
      },
    },
    config = function()
      vim.keymap.set('n', '<Leader>g', ':Git ', { desc = 'Git' })
      vim.keymap.set('n', '<Leader>gs', ':Git<CR>', { silent = true, desc = 'Git status' })
      vim.keymap.set('n', '<Leader>gp', ':Git push<CR>', { silent = true, desc = 'Git push' })
      vim.keymap.set({ 'n', 'v' }, '<Leader>go', ':GBrowse<CR>', { silent = true, desc = 'Git browse' })
      vim.keymap.set({ 'n', 'v' }, '<Leader>gc', ':GBrowse!<CR>', { silent = true, desc = 'Git browse' })
      vim.keymap.set('n', '<Leader>gb', ':Git blame<CR>', { silent = true, desc = 'Git blame' })
    end,
  },

  -- shows git author as virtual text on each line of code
  {
    'f-person/git-blame.nvim',
    init = function()
      vim.g.gitblame_date_format = '%r'
      vim.g.gitblame_message_template = '  <date> - <author>'
      vim.g.gitblame_ignored_filetypes = { 'gitcommit', 'fugitive', 'help', 'packer' }
      vim.g.gitblame_highlight_group = 'GitBlame'
    end,
  },
}

-- require plugins that start with "extra" in plugins/ folder
local extra_file_glob = vim.fn.stdpath('config') .. '/lua/plugins/extra*'
local extra_files = vim.fn.glob(extra_file_glob, true, true)

for _, file in ipairs(extra_files) do
  file = file:match('.+/lua/(plugins/.+)%..+')

  table.insert(plugins, require(file))
end

require('lazy').setup(plugins, { rocks = { enabled = false } })
