require('telescope').setup({
    defaults = {
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
            override_generic_sorter = true,
            override_file_sorter = true,
        }
    }
})

require('telescope').load_extension('fzf')

-- Search for a term in the current directory
vim.keymap.set('', '<Leader>st', ':Telescope live_grep<CR>', { silent = true, desc = "Search text" })

-- Browse list of files in current directory
vim.keymap.set('', '<Leader>sf', ':Telescope find_files<CR>', { silent = true, desc = "Search files" })

-- Search help tags
vim.keymap.set('', '<Leader>sh', ':Telescope help_tags<CR>', { silent = true, desc = "Search help tags" })

-- Search for word under cursor
vim.keymap.set('', '<Leader>sw', ':Telescope grep_string<CR>', { silent = true, desc = "Search current word" })

-- Resume telescope
vim.keymap.set('', '<Leader>sr', ':Telescope resume<CR>', { silent = true, desc = "Resume search" })
