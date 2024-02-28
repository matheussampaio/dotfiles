-- Enable number columns.
vim.o.number = true
vim.o.relativenumber = true

vim.o.foldlevel = 9999
vim.o.foldlevelstart = 9999
vim.o.foldenable = true
vim.o.foldmethod = 'indent'

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
vim.o.updatetime = 200

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

-- Display signs in the number column
vim.o.signcolumn = "yes"

-- pop up menu height
vim.o.pumheight = 10

-- disable mouse support
-- vim.o.mouse = 'nv'

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

-- vim.keymap.set("n", "<Leader>ui", function ()
--     vim.cmd([[function! SynGroup()
--     let l:s = synID(line('.'), col('.'), 1)
--         echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
--     endfun
--     ]])
-- end, { desc = "Show highlight under cursor"})

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
if vim.fn.getenv("SSH_CONNECTION") ~= vim.NIL then
    vim.g.netrw_browsex_viewer = "ssh-open-firefox"
end

-- Call override_highlights after color schema is set.
vim.api.nvim_create_autocmd('ColorScheme', {
    desc = 'Reload custom highlight overrides',
    group = vim.api.nvim_create_augroup('ColorSchemeOverrides', { clear = true }),
    pattern = { '*' },
    callback = override_highlights
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
    end
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
            }
        })
    end
end

vim.keymap.set('v', '<Leader>ue', epoch_to_virtual_text, { desc = 'Transform EPOCH to Datetime' })

-- Highlights the yanked text.
vim.api.nvim_create_autocmd("CursorHold", {
    desc = "Transform EPOCH to Datetime",
    group = vim.api.nvim_create_augroup("Epoch2Datetime", { clear = true }),
    pattern = { "*" },
    callback = epoch_to_virtual_text
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

local plugins = {
    "nvim-lua/plenary.nvim",

    "nvim-tree/nvim-web-devicons",

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
        end
    },

    --  handy brackets mappings.
    'tpope/vim-unimpaired',

    -- Asynchronous build and test dispatcher
    {
        'tpope/vim-dispatch',
        enabled = false
    },

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

    -- Comment stuff out.
    { 'numToStr/Comment.nvim', opts = {} },

    'lepture/vim-jinja',

    -- Neovim setup for init.lua and plugin development with full signature help, docs and completion for the nvim lua API.
    {
        "folke/neodev.nvim",
        ft = { 'lua' },
        opts = {}
    },

    -- simple directory tree viewer
    {
        'justinmk/vim-dirvish',
        -- The file manipulation commands for vim-dirvish
        dependencies = { 'roginfarrer/vim-dirvish-dovish' },
    },

    -- Standalone UI for nvim-lsp progress
    {
        'j-hui/fidget.nvim',
        tag = 'legacy',
        opts = {
            text = {
                spinner = 'dots'
            },
            fmt = {
                task = function(task_name, _, percentage)
                    if (task_name == nill or percentage == nill or string.find(string.lower(task_name), "validate documents") or string.find(string.lower(task_name), "diagnostic")) then
                        return false
                    end

                    return string.format("%s%% %s", percentage, task_name)
                end,
            },
            sources = {
                ["null-ls"] = {
                    ignore = true
                }
            }
        },
    },

    -- improve the default vim.ui interfaces
    {
        'stevearc/dressing.nvim',
        opts = {},
    },

    -- Improve Folding
    {
        'kevinhwang91/nvim-ufo',
        dependencies = 'kevinhwang91/promise-async',
        init = function()
            -- vim.keymap.set('n', '<CR>', 'zo', { remap = false, desc = 'Open fold' })
            -- vim.keymap.set('n', '<S-CR>', 'zc', { remap = false, desc = 'Close fold' })
        end,
        opts = {}
    },

    -- Treesitter configurations and abstraction layer for Neovim.
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
        config = function() require('plugins/treesitter') end
    },

    -- OSC 52 is a terminal sequence used to copy printed text into clipboard.
    -- (copy from SSH session)
    {
        'ojroques/vim-oscyank',
        init = function()
            vim.g.oscyank_term = 'default'
            vim.g.oscyank_silent = true
        end,
        config = function()
            vim.keymap.set({ 'v', 'x' }, '<Leader>c', ':OSCYankVisual<CR>', { silent = true, desc = 'OSC yank' })
            vim.keymap.set({ 'n' }, '<Leader>c', '<Plug>OSCYank', { silent = true, desc = 'OSC yank' })
        end
    },

    -- Lean and mean status/tabline.
    {
        'nvim-lualine/lualine.nvim',
        config = function()
            -- local Tab = require('lualine.components.tabs.tab')
            --
            -- -- override Tab:label to add the tab's CWD in the tab name
            -- function Tab:label()
            --     local winnr = vim.fn.tabpagewinnr(self.tabnr)
            --     local tab_cwd = vim.fn.fnamemodify(vim.fn.getcwd(winnr, self.tabnr), ':p:h:t')
            --
            --     return tab_cwd
            -- end

            require('lualine').setup({
                -- extensions = { 'fugitive', 'quickfix', 'lazy' },
                options = {
                    theme = 'gruvbox',
                },
                sections = {
                    lualine_a = { 'mode' },
                    -- lualine_b = { 'ObessionStatus' },
                    -- lualine_c = { {
                    --     'filename',
                    --     newfile_status = true,
                    --     path = 1
                    -- } },
                    lualine_x = { 'dap#status' },
                    lualine_y = { require('plugins/lualine-lsp-name') },
                    lualine_z = { 'filetype' }
                },
                inactive_sections = {
                    -- lualine_a = {},
                    -- lualine_b = {},
                    lualine_c = { {
                        'filename',
                        -- newfile_status = true,
                        -- path = 1
                    } },
                    -- lualine_x = {},
                    -- lualine_y = {},
                    -- lualine_z = {}
                },
                tabline = {
                    lualine_a = { {
                        'tabs',
                        -- max_length = vim.o.columns / 3,
                        -- mode = 1,
                        -- fmt = function(name, context)
                        --     local winnr = vim.fn.tabpagewinnr(context.tabnr)
                        --     local tab_cwd = vim.fn.fnamemodify(vim.fn.getcwd(winnr), ':p:h:t')
                        --     local uri = vim.uri_from_bufnr(vim.api.nvim_get_current_buf())
                        --
                        --     if vim.startswith(uri, 'jdt://') then
                        --         local package = uri:match('contents/[%a%d._-]+/([%a%d._-]+)') or ''
                        --         local class = uri:match('contents/[%a%d._-]+/[%a%d._-]+/([%a%d$]+).class') or ''
                        --         return string.format('%s::%s::%s', tab_cwd, package, class)
                        --     end
                        --
                        --     return string.format('%s::%s', tab_cwd, name)
                        -- end
                    } },
                    -- lualine_b = {},
                    -- lualine_c = {},
                    -- lualine_x = {},
                    -- lualine_y = {},
                    -- lualine_z = {}
                },
            })

            -- lualine sets showtabline to 2 (alwasy show) if 'tabs'
            -- is enabled, so we override back to 1.
            -- vim.cmd("set showtabline=1")
        end
    },

    -- Easy notes
    {
        'vimwiki/vimwiki',
        init = function()
            vim.g.vimwiki_list = {
                {
                    path = '~/notes',
                    name = 'Work Notes',
                    syntax = 'markdown',
                    ext = '.md',
                    custom_wiki2html = '~/.local/bin/m2h_pandoc.py',
                    base_url = '~/notes/',
                    custom_wiki2html_args = table.concat {
                        '--metadata title-prefix="Notes"',
                    },
                    auto_generate_links = 1,
                    auto_export = 1,
                    links_space_char = '_',
                    diary_frequency = 'monthly',
                    diary_header = 'Bullet Journal',
                    diary_rel_path = 'journal',
                    diary_caption_level = -1,
                    diary_index = 'index',
                }
            }

            -- open index.wiki when opening a folder
            vim.g.vimwiki_dir_link = 'index'

            -- Not always consider a .wiki or .md file to be a wiki.
            vim.g.vimwiki_global_ext = 0

            vim.g.vimwiki_markdown_link_ext = 1

            -- Add highlight groups to headers
            vim.g.vimwiki_hl_headers = 1
        end
    },

    -- Focus reading/writing mode
    {
        'junegunn/goyo.vim',
        dependencies = {
            'nvim-lualine/lualine.nvim',

            -- Highlight current block and dimns the others, useful with Goyo
            'junegunn/limelight.vim'
        },
        cmd = 'Goyo',
        config = function()
            vim.api.nvim_create_autocmd('User', {
                desc = 'Hide Lualine when entering Goyo',
                pattern = "GoyoEnter",
                callback = function()
                    require('lualine').hide()
                end
            })

            vim.api.nvim_create_autocmd('User', {
                desc = 'Show Lualine when entering Goyo',
                pattern = 'GoyoLeave',
                callback = function()
                    require('lualine').hide({ unhide = true })
                end
            })
        end
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
                end
            },

            -- Enables :GBrowse from fugitive.vim to open GitHub URLs.
            {
                "tpope/vim-rhubarb",
            },
        },
        config = function()
            vim.keymap.set('n', '<Leader>g', ':Git ', { desc = 'Git' })
            vim.keymap.set('n', '<Leader>gs', ':Git<CR>', { silent = true, desc = 'Git status' })
            vim.keymap.set('n', '<Leader>gp', ':Git push<CR>', { silent = true, desc = 'Git push' })
            vim.keymap.set({ 'n', 'v' }, '<Leader>go', ':GBrowse<CR>', { silent = true, desc = 'Git browse' })
            vim.keymap.set({ 'n', 'v' }, '<Leader>gc', ':GBrowse!<CR>', { silent = true, desc = 'Git browse' })
            vim.keymap.set('n', '<Leader>gb', ':Git blame<CR>', { silent = true, desc = 'Git blame' })
        end
    },

    -- shows git author as virtual text on each line of code
    {
        "f-person/git-blame.nvim",
        init = function()
            vim.g.gitblame_date_format = "%r"
            vim.g.gitblame_message_template = "  <date> - <author>"
            vim.g.gitblame_ignored_filetypes = { "gitcommit", "fugitive", "help", "packer" }
            vim.g.gitblame_highlight_group = "GitBlame"
        end
    },

    {
        "sindrets/diffview.nvim",
        dependencies = {
        }
    },

    -- Keybinding catalog
    {
        'folke/which-key.nvim',
        event = "VeryLazy",
        config = function()
            local wk = require('which-key')

            wk.setup({
                window = {
                    border = 'single',
                    margin = { 1, 1, 1, 1 },
                },
                layout = {
                    width = { min = 20, max = 40 }
                },
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
    },

    -- Support for expanding abbreviations.
    {
        'mattn/emmet-vim',
        ft = { 'html', 'vue', 'jsx', 'riot' },
        init = function()
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
    },

    {
        'antoinemadec/FixCursorHold.nvim',
        init = function()
            vim.g.cursorhold_updatetime = 100
        end
    },

    {
        'norcalli/nvim-colorizer.lua',
        main = 'colorizer',
        opts = {}
    },


    -- general-purpose motion plugin
    {
        'ggandor/leap.nvim',
        config = function()
            vim.keymap.set('n', 's', '<Plug>(leap-forward-to)', { desc = 'Leap forward-to' })
            vim.keymap.set('n', 'S', '<Plug>(leap-backward-to)', { desc = 'Leap backward-to' })
        end
    },

    -- splitting/joining blocks of code
    {
        'Wansmer/treesj',
        keys = { '<Leader>ua' },
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require('treesj').setup({
                use_default_keymaps = false,
                max_join_length = 9999,
            })

            vim.keymap.set(
                'n',
                '<Leader>ua',
                require('treesj').toggle,
                { desc = 'Toggle node under cursor (split if one-line and join if multiline)' }
            )
        end,
    },

    -- Fuzzy finder over lists.
    {
        'nvim-telescope/telescope.nvim',
        keys = {
            '<Leader>f',
            '<Leader>sr',
            '<Leader>sh',
            '<Leader>sw',
            '<Leader>p',
            '<Leader>o'
        },
        dependencies = {
            'natecraddock/telescope-zf-native.nvim',
            -- 'nvim-telescope/telescope-ui-select.nvim',
            'nvim-telescope/telescope-dap.nvim',
            'kkharji/sqlite.lua',
        },
        config = function() require('plugins/telescope') end
    },

    -- java lsp
    'mfussenegger/nvim-jdtls',

    {
        'neovim/nvim-lspconfig',
        config = function()
            require('plugins/lsp')

            vim.diagnostic.config({
                float = {
                    source = true
                },
            })

            vim.keymap.set('n', '<CR>', vim.diagnostic.open_float, { desc = "Diagnostic open float" })
            vim.keymap.set('n', '<Leader>ll', vim.diagnostic.setloclist, { desc = "Load diagnostics to loc list" })
            vim.keymap.set('n', '<Leader>lq', vim.diagnostic.setqflist,
                { desc = "Load all diagnostics to quickfix list" })
            vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev({ float = false }) end,
                { desc = "Go to previous diagnostic" })
            vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next({ float = false }) end,
                { desc = "Go to next diagnostic" })
        end
    },

    -- copilot
    -- {
    --     "zbirenbaum/copilot.lua",
    --     cmd = 'Copilot',
    --     dependencies = { "zbirenbaum/copilot-cmp" },
    --     opts = {
    --         panel = {
    --             enabled = false
    --         },
    --         suggestion = {
    --             enabled = false
    --         }
    --     }
    -- },

    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            local null_ls = require("null-ls")

            null_ls.setup({
                sources = {
                    -- null_ls.builtins.formatting.prettier,
                    -- null_ls.builtins.diagnostics.eslint,
                    -- null_ls.builtins.formatting.rustfmt
                }
            })
        end
    },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {
            check_ts = true,
            disable_filetype = { "TelescopePrompt", "vim" }
        }
    },

    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        lazy = true,
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end
    },

    -- Completion
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
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
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            indent = {
                char = "▏",
            }
        }
    },

    -- setup debugger
    {
        "mfussenegger/nvim-dap",
        lazy = true,
        dependencies = {
            {
                "rcarriga/nvim-dap-ui",
                main = "dapui",
                opts = {}
            },
            {
                "theHamsta/nvim-dap-virtual-text",
                opts = {}
            },
        },
        config = function()
            local dap = require("dap")
            local telescope = require("telescope")
            local dapWidgets = require("dap.ui.widgets")

            require('telescope').load_extension('dap')

            vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug: Continue" })
            vim.keymap.set("n", "<leader>dd", dap.step_over, { desc = "Debug: Step over" })
            vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug: Step into" })
            vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Debug: Step out" })
            vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle breakpoint" })
            vim.keymap.set("n", "<leader>dB", function()
                dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end, { desc = "Debug: Set breakpoint with condition" })
            vim.keymap.set("n", "<leader>dp", function()
                dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
            end, { desc = "Debug: Set breakpoint with log point message" })
            vim.keymap.set("n", "<leader>dr", function()
                dap.repl.toggle({ height = 12 })
            end, { desc = "Debug: Toggle Repl" })
            vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Debug: Run last" })
            vim.keymap.set("n", "<leader>dL", telescope.extensions.dap.list_breakpoints,
                { desc = "Debug: List breakpoints" })
            vim.keymap.set("n", "<leader>de", function()
                dap.set_exception_breakpoints("default")
            end, { desc = "Debug: Set exception breakpoint default" })
            vim.keymap.set("n", "<leader>dE", function()
                dap.set_exception_breakpoints({})
            end, { desc = "Debug: Set exception breakpoints" })
            vim.keymap.set("n", "<leader>dC", dap.run_to_cursor, { desc = "Debug: Run to cursor" })
            vim.keymap.set("n", "<leader>df", telescope.extensions.dap.frames, { desc = "Debug: Open frames" })
            vim.keymap.set("n", "<leader>ds", telescope.extensions.dap.variables, { desc = "Debug: Open variables" })
            vim.keymap.set({ "n", "v" }, "<leader>dK", dapWidgets.hover, { desc = "Debug: Hover" })
            vim.keymap.set("n", "<leader>du", function()
                local widgets = dapWidgets
                widgets.sidebar(widgets.scopes).open()
                widgets.sidebar(widgets.frames).open()
            end, { desc = "Debug: Open widgets" })
        end
    },

    -- open/close Quickfix and Localfix
    {
        "milkypostman/vim-togglelist",
        init = function()
            vim.g.toggle_list_no_mappings = true
        end,
        config = function()
            vim.keymap.set("n", "<Leader>tq", function() vim.cmd([[:call ToggleQuickfixList()]]) end,
                { desc = "Toggle Quickfix list" })
            vim.keymap.set("n", "<Leader>tl", function() vim.cmd([[:call ToggleLocationList()]]) end,
                { desc = "Toggle loc list" })
        end
    }
}

-- require plugins that start with "extra" in plugins/ folder
local extra_file_glob = vim.fn.stdpath("config") .. "/lua/plugins/extra*"
local extra_files = vim.fn.glob(extra_file_glob, true, true)

for _, file in ipairs(extra_files) do
    file = file:match(".+/lua/(plugins/.+)%..+")

    table.insert(plugins, require(file))
end

require("lazy").setup(plugins)
