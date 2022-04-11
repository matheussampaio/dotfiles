-- Enable number columns.
vim.o.number = true
vim.o.relativenumber = true

-- Don't show last command.
vim.o.showcmd = false

-- Leave buffer without saving.
vim.o.hidden = true

-- Insert spaces when TAB is pressed.
vim.o.expandtab = true

-- Change number of spaces that a <Tab> counts for during editing ops.
vim.o.softtabstop = 2

-- Indentation amount for < and > commands.
vim.o.shiftwidth = 2

-- Wrap long lines by default.
vim.o.wrap = true

-- Disable line/column number in status line.
-- Shows up in preview window when airline is disabled if not.
vim.o.ruler = false

-- Only one line for command line.
-- vim.o.cmdheight = 1

-- Don't give completion messages like 'match 1 of 2' or 'The only match'.
vim.o.shortmess = vim.o.shortmess .. "c"

-- Always keep some lines before/after the current line when scrolling.
vim.o.scrolloff = 4

-- Always keep some characters before/after the current column.
vim.o.sidescroll = 4

-- ignore case when searching.
vim.o.ignorecase = true

-- if the search string has an upper case letter in it, the search will be case sensitive.
vim.o.smartcase = true

-- Show the effects of a command incrementally, as you type
vim.o.inccommand = "nosplit"

-- Automatically re-read file if a change was detected outside of vim.
vim.o.autoread = true

-- Disable swap files.
vim.o.swapfile = false

-- Enable persistent undo.
vim.o.undofile = true
vim.o.undolevels = 3000
vim.o.undoreload = 10000

-- Create vertical splits to the ride of the current split.
vim.o.splitright = true

-- Create horizontal splits below the current split.
vim.o.splitbelow = true

-- Don't dispay mode in command line (airilne already shows it).
vim.o.showmode = false

-- Enable true colors support.
vim.o.termguicolors = true

-- Start in nopaste mode.
vim.o.paste = false

-- Save fold and cursor positions to viewfile.
vim.o.viewoptions = "cursor,folds,slash,unix"

-- Remove ~ from the left side of the window
vim.o.fillchars = "eob: "

-- Start diffmode with vertical splits.
-- vim.o.diffopt = "vertical"

-- Disable bells.
vim.o.visualbell = true

-- Display characters
vim.o.list = true

-- Display tab characters
vim.o.listchars = "nbsp:·,tab:▶-,trail:·"

-- set default regexp engine
vim.o.regexpengine = 1

-- Set default to unfold
vim.o.foldlevel = 1000

-- Display signs in the number column
vim.o.signcolumn = "yes"

-- pop up menu height
vim.o.pumheight = 10

vim.o.smartindent = true

-- Use dark background
vim.o.background = dark

-- Highlight cursor line
vim.o.cursorline = true

vim.o.completeopt = "menu,noinsert,preview"

-- Change leader to SPACE.
vim.g.mapleader = " "

-- Normally space move the cursor to the right in normal mode. Since LEADER is
-- SPACE, disabling that behavior works better for me.
vim.api.nvim_set_keymap('', '<Space>', '<NOP>', { noremap = true })

-- Quick ways to get to MYVIMRC
vim.api.nvim_set_keymap('n', '<Leader>ov', ':edit $MYVIMRC<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ot', ':tabnew $MYVIMRC<CR>', { noremap = true, silent = true })

-- Erase search highlight
vim.api.nvim_set_keymap('n', '<Leader>h', ':nohlsearch<CR>', { noremap = true, silent = true })

-- Ctrl + S to save the buffer
vim.api.nvim_set_keymap('n', '<C-s>', ':wa<CR>', { noremap = true })

-- Move visual lines
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true })

-- Paste from clipboard
vim.api.nvim_set_keymap('n', '<Leader>v', 'o<ESC>"+p', { noremap = true })
vim.api.nvim_set_keymap('x', '<Leader>v', '"+p', { noremap = true })

-- Save to clipboard
vim.api.nvim_set_keymap('v', '<Leader>c', '"+y', { noremap = true })

-- By pressing ctrl+r in visual mode, you will be prompted to enter text to replace with.
-- Press enter and then confirm each change you agree with y or decline with n.
vim.api.nvim_set_keymap('v', '<C-r>', '"hy:%s/<C-r>h//gc<left><left><left>', { noremap = true })

-- Highlights the yanked text.
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = { "*" },
  callback = vim.highlight.on_yank
})

-- Add custom highlights in method that is executed every time a
-- colorscheme is sourced
-- See https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f for
-- details
local override_highlights = function()
  -- Make background signcolumn background transparent
  vim.api.nvim_set_hl(0, 'SignColumn', { bg='NONE', fg='NONE' })

  -- Make background color transparent for git changes
  vim.api.nvim_set_hl(0, 'SignifySignAdd', { bg = 'NONE', fg = '#99c794' })
  vim.api.nvim_set_hl(0, 'SignifySignDelete', { bg = 'NONE', fg = '#ec5f67' })
  vim.api.nvim_set_hl(0, 'SignifySignChange', { bg = 'NONE', fg = '#c594c5' })

  -- Change highlight
  vim.api.nvim_set_hl(0, 'Search', { bg = 'NONE', fg = 'peru' })

  -- Add a little bit more contrast to LineNr
  vim.api.nvim_set_hl(0, 'LineNr', { fg = '#6a6a6a' })

  -- Errors bold read with transparent background
  vim.api.nvim_set_hl(0, 'Error', { bg = 'NONE', fg = '#ff005f', bold = true })

  -- vim.api.nvim_set_hl(0, 'NormalNC', { bg = '#1c1c1c' })

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
end

-- Call override_highlights after colorschem is set.
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = { "*" },
  callback = override_highlights
})

-- local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
-- 
-- if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
--   packer_bootstrap = vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
-- end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use {
    'wbthomason/packer.nvim',
    config = function()
      vim.api.nvim_set_keymap('n', '<Leader>oi', ':PackerSync<CR>', { noremap = true, silent = true })
    end
  }

  -- Monokai Tasty Colorschema.
  use {
    'tanvirtin/monokai.nvim',
    config = function()
      vim.cmd('colorscheme monokai')
    end
  }

  -- Lean and mean status/tabline.
  use {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup({
        options = {
          -- icons_enabled = false,
          theme = 'auto',
          component_separators = { left = nil, right = nil },
          section_separators = { left = nil, right = nil },
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'filetype'},
          lualine_y = {},
          lualine_z = {}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {}
        },
      })
    end
  }

  --  handy brackets mappings.
  use 'tpope/vim-unimpaired'

  -- Comment stuff out.
  use {
    'tpope/vim-commentary',
    requires = 'suy/vim-context-commentstring'
  }

  -- Provides mappings to easily delete, change and add surroundings (parantheses, brackets, quotes, etc).
  use 'tpope/vim-surround'

  -- Change word case, add abbreviations, and search/replace.
  use 'tpope/vim-abolish'

  -- Enable repeating supported plugin maps with '.'.
  use 'tpope/vim-repeat'

  -- Make Vim persist editing state without fuss.
  use 'zhimsel/vim-stay'

  -- Place, toggle and display marks.
  use 'kshenoy/vim-signature'

  -- Add support to .editorconfig files.
  use 'gpanders/editorconfig.nvim'

  -- Treesitter configurations and abstraction layer for Neovim.
  use {
    'nvim-treesitter/nvim-treesitter',
    event = 'UIEnter',
    run = ':TSUpdate',
    config = function() require('plugins/treesitter') end
  }

  use 'ryym/vim-riot'

  -- Path navigator designed to work with Vim's built-in mechanisms and complementary plugins.
  use {
    'justinmk/vim-dirvish',
    -- The file manipulation commands for vim-dirvish
    requires = 'roginfarrer/vim-dirvish-dovish'
  }

  -- Make it easier to swap between vim and tmux.
  use 'christoomey/vim-tmux-navigator'

  -- OSC 52 is a terminal sequence used to copy printed text into clipboard.
  -- (copy from SSH session)
  use { 
    'ojroques/vim-oscyank',
    cmd = 'OSCYank',
    keys = '<Leader>co',
    config = function()
      vim.api.nvim_set_keymap('v', '<Leader>co', ':OSCYank<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('x', '<Leader>co', ':OSCYank<CR>', { noremap = true, silent = true })
    end
  }

  -- Take notes with Wiki.
  use {
    "vimwiki/vimwiki",
    cmd = "VimwikiIndex",
    setup = function()
      vim.cmd("let g:vimwiki_list = [{ 'path': '~/wiki' }]")
    end
  }

  -- Git wrapper.
  use {
    'tpope/vim-fugitive',
    requires = {
      -- Git commit browser.
      'junegunn/gv.vim',
      -- Enables :GBrowse from fugitive.vim to open GitHub URLs.
      'tpope/vim-rhubarb',
      -- Show git changes in the sign column.
      {
        'mhinz/vim-signify',
        config = function()
          vim.cmd("let g:signify_sign_delete = '-'")
        end
      }
    },
    config = function()
      vim.api.nvim_set_keymap('n', '<Leader>g', ':Git<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Leader>gl', ':GV<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Leader>gla', ':GV --all<CR>', { noremap = true, silent = true })
    end
  }

  -- Wrap and unwrap function arguments, lists, and dictionaires.
  use {
    'FooSoft/vim-argwrap',
    cmd = 'ArgWrap',
    keys = '<Leader>aw',
    config = function()
      vim.api.nvim_set_keymap('n', '<Leader>aw', ':ArgWrap<CR>', { noremap = true, silent = true })
    end
  }

  -- Support for expanding abbreviations.
  use {
    'mattn/emmet-vim',
    ft = { 'html', 'vue', 'jsx', 'riot' },
    setup = function()
      vim.cmd("let g:user_emmet_leader_key = '<C-e>'")
    end
  }

  -- Vim motions on speed!
  use { 
    'phaazon/hop.nvim',
    cmd = { 'HopChar2', 'HopLine' },
    keys = { 's', '<Leader>l' },
    config = function()
      require('hop').setup()

      vim.api.nvim_set_keymap('n', 's', ':HopChar2<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Leader>l', ':HopLine<CR>', { noremap = true, silent = true })
    end
  }

  -- Fuzzy finder over lists.
  use {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    keys = { '<Leader>s', '<Leader>p' },
    requires = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    },
    config = function() require('plugins/telescope') end
  }

  -- Completion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      {
        'github/copilot.vim',
        config = function()
          vim.cmd("let g:copilot_no_tab_map = v:true")

          vim.api.nvim_set_keymap('i', '<C-j>', 'copilot#Accept("<CR>")', { script = true, expr = true, silent = true })
        end
      },
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
      { 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-copilot', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-vsnip', after = 'nvim-cmp' },
      'hrsh7th/vim-vsnip',
      'onsails/lspkind-nvim',
    },
    config = function() require('plugins/cmp') end
  }

  -- use 'tpope/vim-obsession'
  -- use 'milkypostman/vim-togglelist'

  --   if packer_bootstrap then
  --     require('packer').sync()
  --   end

  -- Read a local nvimrc if available
  -- if filereadable(expand("$HOME/.nvimrc"))
  --   source $HOME/.nvimrc
  -- endif
end)
