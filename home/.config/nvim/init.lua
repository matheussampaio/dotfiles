-- Enable number columns.
vim.o.number = true
vim.o.relativenumber = true

-- only save cursor and folds in view sessions
vim.opt.viewoptions = { "cursor", "folds" }

-- Show tabline is more than one tab exists
vim.o.showtabline = 1

-- Insert spaces when TAB is pressed.
vim.o.expandtab = true

-- Change number of spaces that a <Tab> counts for during editing ops.
vim.o.softtabstop = 4

vim.o.shiftwidth = 4

-- Disable line/column number in status line.
-- Shows up in preview window when airline is disabled if not.
vim.o.ruler = false

-- enable conceal
vim.o.conceallevel = 1

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

-- Disable swap files.
vim.o.swapfile = false

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

-- Don't display mode in command line (airline already shows it).
vim.o.showmode = false

-- Enable true colors support.
vim.o.termguicolors = true

-- Remove ~ from the left side of the window
vim.o.fillchars = "eob: "

-- Disable bells.
vim.o.visualbell = true

-- Display characters
vim.o.list = true

-- Display tab characters
vim.opt.listchars = "tab:▶ ,trail:·"

-- Set default to unfold
vim.o.foldlevel = 1

-- Display signs in the number column
vim.o.signcolumn = "auto"

-- pop up menu height
vim.o.pumheight = 10

-- Highlight cursor line
vim.o.cursorline = true

vim.o.completeopt = "menu,menuone,noinsert,preview"

-- only show command line if needed
vim.o.cmdheight = 1

-- wraps line at last word
vim.o.linebreak = true

if vim.fn.filereadable(vim.fn.expand("$XDG_CONFIG_HOME/theme")) > 0 then
    vim.cmd('let &background = readfile(glob("$XDG_CONFIG_HOME/theme"))[0]')
else
    vim.o.background = "dark"
end

-- disable ruby and perl providers, see :checkhealth
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- set python paths
vim.g.python2_host_prog = vim.fn.expand("$HOME/.pyenv/versions/neovim2/bin/python")
vim.g.python3_host_prog = vim.fn.expand("$HOME/.pyenv/versions/neovim3/bin/python")

-- Change leader to SPACE.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normally space move the cursor to the right in normal mode. Since LEADER is
-- SPACE, disabling that behavior works better for me.
vim.keymap.set({ "n", "v" }, "<Space>", "<NOP>", { silent = true })

-- Quick ways to get to MYVIMRC
vim.keymap.set("n", "<Leader>uv", ":edit $MYVIMRC<CR>", { silent = true, desc = "Edit $MYVIMRC" })
vim.keymap.set("n", "<Leader>ut", ":tabnew $MYVIMRC<CR>", { silent = true, desc = "Edit $MYVIMRC in a new tab" })

-- Erase search highlight
vim.keymap.set("n", "<Leader>uh", ":nohlsearch<CR>", { silent = true, desc = "Remove search highlight" })

-- Ctrl + S to save the buffer
vim.keymap.set("n", "<C-s>", ":w<CR>", { silent = true, desc = "Save current file" })

-- Move visual lines
vim.keymap.set("n", "k", 'v:count == 0 ? "gk" : "k"', { expr = true })
vim.keymap.set("n", "j", 'v:count == 0 ? "gj" : "j"', { expr = true })

-- Paste from clipboard
vim.keymap.set("n", "<Leader>v", 'o<ESC>"+p', { desc = "Paste from clipboard" })
vim.keymap.set("x", "<Leader>v", '"+p', { desc = "Paste from clipboard" })

-- Save to clipboard
vim.keymap.set("v", "<Leader>c", '"+y', { desc = "Copy to clipboard" })

-- By pressing ctrl+r in visual mode, you will be prompted to enter text to replace with.
-- Press enter and then confirm each change you agree with y or decline with n.
vim.keymap.set("v", "<C-r>", '"hy:%s/<C-r>h//gc<left><left><left>', { desc = "Replace current selection" })

-- Map <Esc> to exit terminal-mode.
vim.keymap.set("t", "<Esc>", "<C-\\><C-N>", { desc = "Leave terminal insert mode" })

-- Highlights the yanked text.
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight yanked text",
    group = vim.api.nvim_create_augroup("HilightTextYank", { clear = true }),
    pattern = { "*" },
    callback = function() vim.highlight.on_yank({ higroup = "IncSearch", timeout = 500 }) end
})

vim.api.nvim_create_autocmd({ "WinEnter", "FocusGained" }, {
    desc = "Show the cursorline whenever the window gain focus",
    group = vim.api.nvim_create_augroup("ShowCursorLineWhenLoseFocus", { clear = true }),
    pattern = { "*" },
    callback = function() vim.o.cursorline = true end
})

vim.api.nvim_create_autocmd({ "WinLeave", "FocusLost" }, {
    desc = "Hide the cursorline whenever the window loses focus",
    group = vim.api.nvim_create_augroup("HideCursorLineWhenLoseFocus", { clear = true }),
    pattern = { "*" },
    callback = function() vim.o.cursorline = false end
})


-- Add custom highlights in method that is executed every time a colorscheme is sourced.
-- See https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f for details
local override_highlights = function()
    -- Change highlight
    vim.api.nvim_set_hl(0, "Search", { bg = "NONE", fg = "peru", bold = true })

    -- gray
    vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { bg = "NONE", fg = "#808080", strikethrough = true })
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
    local CommentHighlight = vim.api.nvim_get_hl_by_name('Comment', true)
    local CursorLineHighlight = vim.api.nvim_get_hl_by_name('CursorLine', true)
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

    hi! default LspReferenceText gui=bold,underline cterm=bold,underline
    hi! default LspReferenceRead gui=bold,underline cterm=bold,underline
    hi! default LspReferenceWrite gui=bold,underline cterm=bold,underline
    ]])
end

-- set custom browserx viewer to open links inside ssh connection in the host
if vim.fn.getenv("SSH_CONNECTION") ~= vim.NIL then
    vim.g.netrw_browsex_viewer = "ssh-open-firefox"
end

-- Call override_highlights after colorschem is set.
vim.api.nvim_create_autocmd('ColorScheme', {
    desc = 'Reload custom highlight overrides',
    group = vim.api.nvim_create_augroup('ColorSchemeOverrides', { clear = true }),
    pattern = { '*' },
    callback = override_highlights
})

-- Auto save files
vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost' }, {
    desc = 'Auto save files',
    callback = function ()
        if vim.bo.modified and not vim.bo.readonly and vim.fn.expand('%') ~= '' and vim.bo.buftype == '' then
            vim.api.nvim_command('silent update')
        end
    end
})

local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

local packer_bootstrap = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    packer_bootstrap = vim.fn.system('git clone --depth 1 https://github.com/wbthomason/packer.nvim ' .. install_path)

    vim.cmd('packadd packer.nvim')
end

return require('packer').startup(function(use)
    use 'nvim-lua/plenary.nvim'

    use {
        'wbthomason/packer.nvim',
        config = function()
            vim.keymap.set('n', '<Leader>us', ':PackerSync<CR>', { desc = 'Run packer sync' })
            vim.keymap.set('n', '<Leader>ui', ':PackerInstall<CR>', { desc = 'Run packer install' })
            vim.keymap.set('n', '<Leader>uc', ':PackerCompile<CR>', { desc = 'Run packer compile' })
        end
    }

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
            local Tab = require('lualine.components.tabs.tab')
            local dap = require("dap")

            -- override Tab:label to add the tab's CWD in the tab name
            function Tab:label()
                local winnr = vim.fn.tabpagewinnr(self.tabnr)
                local tab_cwd = vim.fn.fnamemodify(vim.fn.getcwd(winnr, self.tabnr), ':p:h:t')

                return tab_cwd
            end

            require('lualine').setup({
                extensions = { 'fugitive', 'quickfix' },
                options = {
                    theme = 'gruvbox',
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'ObessionStatus' },
                    lualine_c = { {
                        'filename',
                        newfile_status = true,
                        path = 1
                    } },
                    lualine_x = {},
                    lualine_y = { dap.status },
                    lualine_z = { 'filetype' }
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { {
                        'filename',
                        newfile_status = true,
                        path = 1
                    } },
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {
                    lualine_a = { {
                        'tabs',
                        max_length = vim.o.columns,
                        mode = 1
                    } },
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {}
                },
            })

            -- lualine sets showtabline to 2 (alwasy show) if 'tabs'
            -- is enabled, so we override back to 1.
            vim.cmd("set showtabline=1")
        end
    }

    --  handy brackets mappings.
    use 'tpope/vim-unimpaired'

    -- Provides mappings to easily delete, change and add surroundings (parentheses, brackets, quotes, etc).
    use {
        'kylechui/nvim-surround',
        config = function ()
            require("nvim-surround").setup({})
        end
    }

    -- Asynchronous build and test dispatcher 
    use 'tpope/vim-dispatch'

    -- Change word case, add abbreviations, and search/replace.
    use 'tpope/vim-abolish'

    -- Enable repeating supported plugin maps with '.'.
    use 'tpope/vim-repeat'

    -- Continuously updated session files
    use 'tpope/vim-obsession'

    -- Provides additional text objects
    use 'wellle/targets.vim'

    -- Easy notes
    use {
        'vimwiki/vimwiki',
        config = function ()
            vim.g.vimwiki_list = {{
                path = '~/vimwiki'
            }}
        end
    }

    -- Make Vim persist editing state without fuss.
    use 'zhimsel/vim-stay'

    -- Place, toggle and display marks.
    use 'kshenoy/vim-signature'

    -- Add support to .editorconfig files.
    use 'gpanders/editorconfig.nvim'

    -- Treesitter configurations and abstraction layer for Neovim.
    use {
        'nvim-treesitter/nvim-treesitter',
        requires = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            -- 'nvim-treesitter/nvim-treesitter-context'
        },
        run = ':TSUpdate',
        config = function() require('plugins/treesitter') end
    }

    -- Comment stuff out.
    use {
        'numToStr/Comment.nvim',
        config = function() require('Comment').setup() end
    }

    -- Path navigator designed to work with Vim's built-in mechanisms and complementary plugins.
    use {
        'justinmk/vim-dirvish',
        -- The file manipulation commands for vim-dirvish
        requires = { 'roginfarrer/vim-dirvish-dovish' }
    }

    -- move outside vim to another tmux pane easily
    use 'christoomey/vim-tmux-navigator'

    -- OSC 52 is a terminal sequence used to copy printed text into clipboard.
    -- (copy from SSH session)
    use {
        'ojroques/vim-oscyank',
        setup = function()
            vim.g.oscyank_term = 'default'
            vim.g.oscyank_silent = true
        end,
        config = function()
            vim.keymap.set({ 'v', 'x' }, '<Leader>c', ':OSCYankVisual<CR>', { silent = true, desc = 'OSC yank' })
            vim.keymap.set({ 'n' }, '<Leader>c', '<Plug>OSCYank', { silent = true, desc = 'OSC yank' })
        end
    }

    -- Focus reading/writing mode
    use {
        'junegunn/goyo.vim',
        requires = 'nvim-lualine/lualine.nvim',
        config = function ()
            vim.api.nvim_create_autocmd('User', {
                desc = 'Hide Lualine when entering Goyo',
                pattern = "GoyoEnter",
                callback = function ()
                    require('lualine').hide()
                end
            })

            vim.api.nvim_create_autocmd('User', {
                desc = 'Show Lualine when entering Goyo',
                pattern = 'GoyoLeave',
                callback = function ()
                    require('lualine').hide({ unhide = true })
                end
            })
        end
    }

    -- Highlight current block and dimns the others, useful with Goyo
    use { 'junegunn/limelight.vim' }

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
                vim.keymap.set('n', '<Leader>g', ':Git ', { desc = 'Git' })
                vim.keymap.set('n', '<Leader>gs', ':Git<CR>', { silent = true, desc = 'Git status' })
                vim.keymap.set('n', '<Leader>gp', ':Git push<CR>', { silent = true, desc = 'Git push' })
                vim.keymap.set({ 'n', 'v' }, '<Leader>go', ':GBrowse<CR>', { silent = true, desc = 'Git browse' })
                vim.keymap.set({ 'n', 'v' }, '<Leader>gc', ':GBrowse!<CR>', { silent = true, desc = 'Git browse' })
                vim.keymap.set('n', '<Leader>gb', ':Git blame<CR>', { silent = true, desc = 'Git blame' })
            end
        },
        {
            -- Git commit browser.
            'junegunn/gv.vim',
            after = 'vim-fugitive',
            config = function()
                vim.keymap.set('n', '<Leader>gl', ':GV<CR>', { silent = true, desc = 'Git log tree' })
                vim.keymap.set('n', '<Leader>ga', ':GV --all<CR>', { silent = true, desc = 'Git log tree --all' })
            end
        },
        {
            -- Enables :GBrowse from fugitive.vim to open GitHub URLs.
            "tpope/vim-rhubarb",
            after = "vim-fugitive"
        },
        {
            -- shows git author as virtual text on each line of code
            "f-person/git-blame.nvim",
            setup = function()
                vim.g.gitblame_date_format = "%r"
                vim.g.gitblame_message_template = "  <date> - <author>"
                vim.g.gitblame_ignored_filetypes = { "gitcommit", "fugitive", "help", "packer" }
                vim.g.gitblame_highlight_group = "GitBlame"
            end
        },
        {
            "sindrets/diffview.nvim",
            requires = "nvim-lua/plenary.nvim"
        }
    }

    -- Keybinding catalog
    use {
        'folke/which-key.nvim',
        after = 'nvim-lspconfig',
        config = function()
            local wk = require('which-key')

            wk.setup({
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

            wk.register({
                s = { name = 'Search' },
                d = { name = 'Debug' },
                u = { name = 'Utils' },
                g = { name = 'Git' },
                w = { name = 'Wiki' },
                h = { name = 'Jump' },
                l = {
                    name = 'LSP',
                    w = { name = 'Workspaces' }
                },
            }, { prefix = '<Leader>' })
        end
    }

    -- Wrap and unwrap function arguments, lists, and dictionaires.
    use {
        'FooSoft/vim-argwrap',
        config = function()
            vim.keymap.set('n', '<Leader>ua', ':ArgWrap<CR>', { silent = true, desc = 'Arg Wrap' })
        end
    }

    -- Support for expanding abbreviations.
    use {
        'mattn/emmet-vim',
        ft = { 'html', 'vue', 'jsx', 'riot' },
        setup = function()
            vim.g.user_emmet_leader_key = '<C-e>'
            vim.g.user_emmet_install_global = false
        end,
        config = function()
            vim.api.nvim_create_autocmd('FileType', {
                desc = 'Install emmet',
                group = vim.api.nvim_create_augroup('EmmetInstall', { clear = true }),
                pattern = { '*.html', '*.vue', '*.jsx', '*.riot' },
                callback = 'EmmetInstall'
            })
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

    -- general-purpose motion plugin
    use {
        'ggandor/leap.nvim',
        config = function()
            vim.keymap.set('n', 's', '<Plug>(leap-forward-to)', { desc = 'Leap forward-to' })
            vim.keymap.set('n', 'S', '<Plug>(leap-backward-to)', { desc = 'Leap backward-to' })
        end
    }

    -- Fuzzy finder over lists.
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            -- { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
            { 'natecraddock/telescope-zf-native.nvim' },
            { 'nvim-telescope/telescope-ui-select.nvim' },
            { 'nvim-telescope/telescope-dap.nvim' },
            { 'nvim-telescope/telescope-frecency.nvim',
                requires = { 'kkharji/sqlite.lua' }
            }
        },
        config = function() require('plugins/telescope') end
    }

    -- java lsp
    use { 'mfussenegger/nvim-jdtls' }

    use {
        'neovim/nvim-lspconfig',
        config = function()
            require('plugins/lsp')
            require('plugins/diagnostics')
        end
    }

    -- copilot
    use {
        {
            "zbirenbaum/copilot.lua",
            cmd = 'Copilot',
            config = function()
                require("copilot").setup({
                    panel = {
                        enabled = false
                    },
                    suggestion = {
                        enabled = false
                    }
                })
            end,
        },
        {
            "zbirenbaum/copilot-cmp",
            after = { "copilot.lua" },
            config = function()
                require("copilot_cmp").setup()
            end
        }
    }


    use {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            require("plugins/null-ls")
        end
    }

    use {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({
                check_ts = true,
                disable_filetype = { "TelescopePrompt", "vim" }
            })
        end
    }

    use {
        "L3MON4D3/LuaSnip",
        requires = { "rafamadriz/friendly-snippets" },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end
    }

    -- Completion
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "saadparwaiz1/cmp_luasnip",
            "onsails/lspkind-nvim",
            "rcarriga/cmp-dap"
        },
        config = function() require("plugins/cmp") end
    }

    use {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup({
                char = "▏",
            })
        end
    }

    -- setup debugger
    use {
        {
            "mfussenegger/nvim-dap",
            config = function()
                require("plugins/dap")
            end
        },
        {
            "rcarriga/nvim-dap-ui",
            requires = "mfussenegger/nvim-dap",
            config = function()
                require("dapui").setup()
            end
        },
        {
            "theHamsta/nvim-dap-virtual-text",
            requires = "mfussenegger/nvim-dap",
            config = function()
                require("nvim-dap-virtual-text").setup()
            end
        }
    }

    -- open/close Quickfix and Localfix
    use {
        "milkypostman/vim-togglelist",
        setup = function()
            vim.g.toggle_list_no_mappings = true
        end,
        config = function()
            vim.keymap.set("n", "<Leader>tq", function() vim.cmd([[:call ToggleQuickfixList()]]) end,
                { desc = "Toggle Quickfix list" })
            vim.keymap.set("n", "<Leader>tl", function() vim.cmd([[:call ToggleLocationList()]]) end,
                { desc = "Toggle loc list" })
        end
    }

    -- require plugins that start with "extra" in plugins/ folder
    local extra_file_glob = vim.fn.stdpath("config") .. "/lua/plugins/extra*"
    local extra_files = vim.fn.glob(extra_file_glob, true, true)

    for _, file in ipairs(extra_files) do
        file = file:match(".+/lua/(plugins/.+)%..+")
        require(file).setup(use)
    end

    if packer_bootstrap then
        require("packer").sync()
    end
end)
