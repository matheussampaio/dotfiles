require('telescope').setup {
    defaults = {
        -- file_sorter = require "telescope.sorters".get_fzy_sorter,
        -- generic_sorter = require "telescope.sorters".get_fzy_sorter,
        preview = {
            hide_on_startup = true
        },
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--iglob",
            "!package-lock.json",
        },
        file_ignore_patterns = { "node_modules", ".git" },
        mappings = {
            i = {
                ["<Esc>"] = require('telescope.actions').close,
            }
        }
    },

    pickers = {
        find_files = {
            hidden = true,
            follow = true
        }
    },

    extensions = {
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        }
    }
}

require('telescope').load_extension('fzf')

-- Search for a term in the current directory
vim.api.nvim_set_keymap('', '<Leader>si', ':Telescope live_grep<CR>', { noremap = true, silent = true, desc = "Search in files" })

-- Browse list of files in current directory
vim.api.nvim_set_keymap('', '<Leader>sf', ':Telescope find_files<CR>', { noremap = true, silent = true, desc = "Search for files" })

-- Search help tags
vim.api.nvim_set_keymap('', '<Leader>sh', ':Telescope help_tags<CR>', { noremap = true, silent = true, desc = "Search help tags" })

-- Search for word under cursor
vim.api.nvim_set_keymap('', '<Leader>sw', ':Telescope grep_string<CR>', { noremap = true, silent = true, desc = "Search word under cursor" })

-- Resume telescope
vim.api.nvim_set_keymap('', '<Leader>sr', ':Telescope resume<CR>', { noremap = true, silent = true, desc = "Resume search" })

