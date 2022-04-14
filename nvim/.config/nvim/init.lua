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
vim.o.softtabstop = 4

-- Indentation amount for < and > commands.
vim.o.shiftwidth = 4

-- Wrap long lines by default.
vim.o.wrap = true

-- Disable line/column number in status line.
-- Shows up in preview window when airline is disabled if not.
vim.o.ruler = false

-- Only one line for command line.
-- vim.o.cmdheight = 1

-- Don't give completion messages like 'match 1 of 2' or 'The only match'.
vim.o.shortmess = vim.o.shortmess .. 'c'

-- Always keep some lines before/after the current line when scrolling.
vim.o.scrolloff = 4

-- Always keep some characters before/after the current column.
vim.o.sidescroll = 4

-- ignore case when searching.
vim.o.ignorecase = true

-- if the search string has an upper case letter in it, the search will be case sensitive.
vim.o.smartcase = true

-- Show the effects of a command incrementally, as you type
vim.o.inccommand = 'nosplit'

-- Automatically re-read file if a change was detected outside of vim.
vim.o.autoread = true

-- Disable swap files.
vim.o.swapfile = false

-- enable true colors
vim.g.termcolors = 1

-- Enable persistent undo.
vim.o.undofile = true
vim.o.undolevels = 3000
vim.o.undoreload = 10000

-- Faster cursorhold events
vim.g.updatetime = 200

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
vim.o.viewoptions = 'cursor,folds,slash,unix'

-- Remove ~ from the left side of the window
vim.o.fillchars = 'eob: '

-- Start diffmode with vertical splits.
-- vim.o.diffopt = 'vertical'

-- Disable bells.
vim.o.visualbell = true

-- Display characters
vim.o.list = true

-- Display tab characters
vim.o.listchars = 'nbsp:·,tab:▶-,trail:·'

-- set default regexp engine
vim.o.regexpengine = 1

-- Set default to unfold
vim.o.foldlevel = 1000

-- Display signs in the number column
vim.o.signcolumn = 'yes'

-- pop up menu height
vim.o.pumheight = 10

vim.o.smartindent = true

-- Highlight cursor line
vim.o.cursorline = true

vim.o.completeopt = 'menu,menuone,noinsert,preview'

if vim.fn.filereadable(vim.fn.expand("$XDG_CONFIG_HOME/theme")) > 0 then
    vim.cmd('let &background = readfile(glob("$XDG_CONFIG_HOME/theme"))[0]')
else
    vim.o.background = 'dark'
end

-- disable ruby and perl providers
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- set python3 path
vim.g.python3_host_prog = '/usr/local/bin/python3'

-- Change leader to SPACE.
vim.g.mapleader = ' '

-- Normally space move the cursor to the right in normal mode. Since LEADER is
-- SPACE, disabling that behavior works better for me.
vim.api.nvim_set_keymap('', '<Space>', '<NOP>', { noremap = true })

-- Quick ways to get to MYVIMRC
vim.api.nvim_set_keymap('n', '<Leader>ov', ':edit $MYVIMRC<CR>', { noremap = true, silent = true, desc = 'Edit $MYVIMRC' })
vim.api.nvim_set_keymap('n', '<Leader>ot', ':tabnew $MYVIMRC<CR>', { noremap = true, silent = true, desc = 'Edit $MYVIMRC in a new tab' })

-- Erase search highlight
vim.api.nvim_set_keymap('n', '<Leader>uh', ':nohlsearch<CR>', { noremap = true, silent = true, desc = 'Remove search highlight' })

-- Ctrl + S to save the buffer
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, desc = 'Save current file' })

-- Move visual lines
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true })

-- Paste from clipboard
vim.api.nvim_set_keymap('n', '<Leader>v', 'o<ESC>"+p', { noremap = true, desc = 'Paste from clipboard' })
vim.api.nvim_set_keymap('x', '<Leader>v', '"+p', { noremap = true, desc = 'Paste from clipboard' })

-- Save to clipboard
vim.api.nvim_set_keymap('v', '<Leader>c', '"+y', { noremap = true, desc = 'Copy to clipboard' })

-- By pressing ctrl+r in visual mode, you will be prompted to enter text to replace with.
-- Press enter and then confirm each change you agree with y or decline with n.
vim.api.nvim_set_keymap('v', '<C-r>', '"hy:%s/<C-r>h//gc<left><left><left>', { noremap = true, desc = 'Replace current selection' })

-- Highlights the yanked text.
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight yanked text',
    group = vim.api.nvim_create_augroup('HilightTextYank', { clear = true }),
    pattern = { '*' },
    callback = function() vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 500 }) end
})

-- Add custom highlights in method that is executed every time a colorscheme is sourced.
-- See https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f for details
local override_highlights = function()
    -- Change highlight
    vim.api.nvim_set_hl(0, 'Search', { bg = 'NONE', fg = 'peru', bold = true })

    -- Errors bold read with transparent background
    -- vim.api.nvim_set_hl(0, 'Error', { bg = 'NONE', fg = '#ff005f', bold = true })

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
  ]] )
end

-- Call override_highlights after colorschem is set.
vim.api.nvim_create_autocmd('ColorScheme', {
    desc = 'Reload custom highlight overrides',
    group = vim.api.nvim_create_augroup('ColorSchemeOverrides', { clear = true }),
    pattern = { '*' },
    callback = override_highlights
})

local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

local packer_bootstrap = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    packer_bootstrap = vim.fn.system('git clone --branch keys-desc --depth 1 https://github.com/matheussampaio/packer.nvim ' .. install_path)

    vim.cmd('packadd packer.nvim')
end

-- Highlights the yanked text.
-- vim.api.nvim_create_autocmd('BufWritePost', {
--   group = vim.api.nvim_create_augroup('PackerAutoCompile', { clear = true }),
--   pattern = { 'init.lua' },
--   callback = function()
--     vim.cmd('source <afile> | PackerCompile')
--   end
-- })

return require('packer').startup(function(use)
    use {
        'matheussampaio/packer.nvim',
        branch = 'keys-desc',
        config = function()
            vim.api.nvim_set_keymap('n', '<Leader>ps', ':PackerSync<CR>', { noremap = true, desc = 'Run packer sync' })
            vim.api.nvim_set_keymap('n', '<Leader>pi', ':PackerInstall<CR>', { noremap = true, desc = 'Run packer install' })
            vim.api.nvim_set_keymap('n', '<Leader>pc', ':PackerCompile<CR>', { noremap = true, desc = 'Run packer compile' })
        end
    }

    use 'nvim-lua/plenary.nvim'

    -- Gruvbox Colorschema.
    use {
        'morhetz/gruvbox',
        config = function()
            vim.g.gruvbox_italic = 1
            vim.g.gruvbox_bold = 1
            vim.g.gruvbox_undercul = 1
            vim.g.gruvbox_underline = 1
            vim.g.gruvbox_invert_selection = 0

            vim.cmd('colorscheme gruvbox')
        end
    }

    -- Lean and mean status/tabline.
    use {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('lualine').setup({
                options = {
                    theme = 'auto',
                    component_separators = { left = nil, right = nil },
                    section_separators = { left = nil, right = nil },
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diff', 'diagnostics' },
                    lualine_c = { 'filename' },
                    lualine_x = { 'filetype' },
                    lualine_y = {},
                    lualine_z = {}
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { 'filename' },
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
        'numToStr/Comment.nvim',
        config = function() require('Comment').setup() end
    }

    -- Provides mappings to easily delete, change and add surroundings (parantheses, brackets, quotes, etc).
    use 'tpope/vim-surround'

    -- Change word case, add abbreviations, and search/replace.
    use 'tpope/vim-abolish'

    -- Enable repeating supported plugin maps with '.'.
    -- use 'tpope/vim-repeat'

    -- Provides additional text objects
    use 'wellle/targets.vim'

    -- Make Vim persist editing state without fuss.
    use 'zhimsel/vim-stay'

    -- Place, toggle and display marks.
    use 'kshenoy/vim-signature'

    -- Add support to .editorconfig files.
    use 'gpanders/editorconfig.nvim'

    -- Treesitter configurations and abstraction layer for Neovim.
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        requires = 'JoosepAlviste/nvim-ts-context-commentstring',
        config = function() require('plugins/treesitter') end
    }

    use { 'ryym/vim-riot', ft = { 'riot' } }

    -- Path navigator designed to work with Vim's built-in mechanisms and complementary plugins.
    use {
        'justinmk/vim-dirvish',
        -- The file manipulation commands for vim-dirvish
        requires = { 'roginfarrer/vim-dirvish-dovish', after = 'vim-dirvish' }
    }


    use 'christoomey/vim-tmux-navigator'

    -- OSC 52 is a terminal sequence used to copy printed text into clipboard.
    -- (copy from SSH session)
    use {
        'ojroques/vim-oscyank',
        keys = {
            { 'v', '<Leader>co', 'OSC yank' },
            { 'x', '<Leader>co', 'OSC yank' }
        },
        config = function()
            vim.api.nvim_set_keymap('v', '<Leader>co', ':OSCYank<CR>', { noremap = true, silent = true, desc = 'OSC yank' })
            vim.api.nvim_set_keymap('x', '<Leader>co', ':OSCYank<CR>', { noremap = true, silent = true, desc = 'OSC yank' })
        end
    }

    -- Take notes with Wiki.
    use {
        'vimwiki/vimwiki',
        keys = {
            { 'n', '<Leader>ww', 'Open vimwiki' }
        },
        setup = function()
            vim.g.vimwiki_list = { { path = '~/wiki' } }
        end
    }

    -- Git
    use {
        -- Show git changes in the sign column.
        {
            'mhinz/vim-signify',
            config = function()
                vim.g.signify_sign_delete = '-'
            end
        },
        {
            'tpope/vim-fugitive',
            config = function()
                vim.api.nvim_set_keymap('n', '<Leader>gs', ':Git<CR>', { noremap = true, silent = true, desc = 'Git status' })
                vim.api.nvim_set_keymap('n', '<Leader>gp', ':Git push<CR>', { noremap = true, silent = true, desc = 'Git push' })
                vim.api.nvim_set_keymap('n', '<Leader>gb', ':GBrowse<CR>', { noremap = true, silent = true, desc = 'Git browse' })
            end
        },
        {
            -- Git commit browser.
            'junegunn/gv.vim',
            after = 'vim-fugitive',
            keys = {
                { 'n', '<Leader>gl', 'Git log tree' },
                { 'n', '<Leader>ga', 'Git log tree --all' }
            },
            config = function()
                vim.api.nvim_set_keymap('n', '<Leader>gl', ':GV<CR>', { noremap = true, silent = true, desc = 'Git log tree' })
                vim.api.nvim_set_keymap('n', '<Leader>ga', ':GV --all<CR>', { noremap = true, silent = true, desc = 'Git log tree --all' })
            end
        },
        {
            -- Enables :GBrowse from fugitive.vim to open GitHub URLs.
            'tpope/vim-rhubarb',
            after = 'vim-fugitive',
            cmd = 'GBrowse',
        }
    }

    -- Keybinding catalog
    use {
        -- 'folke/which-key.nvim',
        -- tracking PR https://github.com/folke/which-key.nvim/pull/253
        'xiyaowong/which-key.nvim',
        config = function()
            require('which-key').setup({
                window = {
                    border = 'single',
                    margin = { 1, 1, 1, 1 },
                    spelling = {
                        enabled = true
                    }
                },
                layout = {
                    width = { min = 20, max = 40 }
                }
            })
        end
    }

    -- Wrap and unwrap function arguments, lists, and dictionaires.
    use {
        'FooSoft/vim-argwrap',
        keys = {
            { 'n', '<Leader>ua', 'Arg Wrap' }
        },
        config = function()
            vim.api.nvim_set_keymap('n', '<Leader>ua', ':ArgWrap<CR>', { noremap = true, silent = true, desc = 'Arg Wrap' })
        end
    }

    -- Support for expanding abbreviations.
    use {
        'mattn/emmet-vim',
        ft = { 'html', 'vue', 'jsx', 'riot' },
        event = 'InsertEnter',
        setup = function()
            vim.g.user_emmet_leader_key = '<C-e>'
        end
    }

    use {
        'antoinemadec/FixCursorHold.nvim',
        config = function()
            vim.g.cursorhold_updatetime = 100
        end
    }

    use {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()
        end
    }

    -- Vim motions on speed!
    use {
        'phaazon/hop.nvim',
        keys = {
            { 'n', 's', 'Hop to char' },
            { 'n', '<Leader>hl', 'Hop to line' },
        },
        config = function()
            require('hop').setup()

            vim.api.nvim_set_keymap('n', 's', ':HopChar2<CR>', { noremap = true, silent = true, desc = 'Hop to char' })
            vim.api.nvim_set_keymap('n', '<Leader>hl', ':HopLine<CR>', { noremap = true, silent = true, desc = 'Hop to line' })
        end
    }

    -- Fuzzy finder over lists.
    use {
        'nvim-telescope/telescope.nvim',
        cmd = 'Telescope',
        keys = {
            { 'n', '<Leader>si', 'Search text' },
            { 'n', '<Leader>sf', 'Search files' },
            { 'n', '<Leader>sh', 'Search help tags' },
            { 'n', '<Leader>sw', 'Search current word' },
            { 'n', '<Leader>sr', 'Resume search' }
        },
        requires = {
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
        },
        config = function() require('plugins/telescope') end
    }

    use {
        'github/copilot.vim',
        -- zbirenbaum/copilot.lua does not support authentication yet. for new machines, we need to uso tpope's and run :Copilot enable
        disable = true
    }

    use {
        'zbirenbaum/copilot.lua',
        commit = '04a618dd678e7dc9c9d9680a4cce62d5aefa917a',
        event = 'InsertEnter',
        config = function()
            vim.schedule(function() require('copilot').setup() end)
        end
    }

    use {
        'neovim/nvim-lspconfig',
        config = function()
            require('plugins/lsp')
            require('plugins/diagnostics')
        end
    }

    use {
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
            require('plugins/null-ls')
        end
    }

    use {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        -- after = 'nvim-cmp',
        config = function()
            require('nvim-autopairs').setup({
                disable_filetype = { "TelescopePrompt" , "vim" }
            })

            -- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            -- local cmp = require('cmp')
            --
            -- cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
        end
    }

    -- Completion
    use {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        after = 'nvim-lspconfig',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            { 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
            { 'zbirenbaum/copilot-cmp', after = { 'copilot.lua', 'nvim-cmp' }, },
            { 'hrsh7th/cmp-vsnip', after = 'nvim-cmp' },
            'hrsh7th/vim-vsnip',
            'onsails/lspkind-nvim',
        },
        config = function() require('plugins/cmp') end
    }

    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('indent_blankline').setup({ char = '▏' })
        end
    }

    use {
        'abecodes/tabout.nvim',
        config = function ()
            require('tabout').setup()
        end
    }

    if packer_bootstrap then
        require('packer').sync()
    end

    -- Read a local nvimrc if available
    if vim.fn.filereadable(vim.fn.expand('$HOME/.nvimrc')) > 0 then
        vim.cmd('source $HOME/.nvimrc')
    end
end)
